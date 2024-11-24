Return-Path: <linux-kernel+bounces-420136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278089D7568
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE95162F0F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 15:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD072500B3;
	Sun, 24 Nov 2024 15:39:15 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE90C2500A0
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732462754; cv=none; b=kacJU/m9DlDx/BCRi0XlGUE33FX3VgX+Wm+bb7ZsPk5rlAFYh6+CE+CrQG3MvWBAh3pa2vFTns1NSw7mWBnYU9XOD4TxKzn3o4ykln6t/Al+U+FD8xsElxBkdBHfmmVwKo+F6n741f3DJFw+FaebWDmNRS15kUokn9oRaknTVmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732462754; c=relaxed/simple;
	bh=LcAaAMKbZ4aEcHmen/ASdShf07/Bxw97knUWb7lv3GA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GrLTPIOIP4YGUrYSNAKJT4p3PcgYGua/mr5saYPz0Ge+6OV8xu91oLfjwHgJd8c6KyCXB7BQEmfA6a7HooqSLv/GziD6uB2AxydBrLNPVagnWT1+a/rn78S9oaYCGYfPawVC1mjtkOHXZS0Y5bJALwV1ijgQPwGsc0Ug1MAPh8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-214-kr0LpHBoOaOFWzUcO5J6Qw-1; Sun, 24 Nov 2024 15:39:03 +0000
X-MC-Unique: kr0LpHBoOaOFWzUcO5J6Qw-1
X-Mimecast-MFC-AGG-ID: kr0LpHBoOaOFWzUcO5J6Qw
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 24 Nov
 2024 15:39:00 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 24 Nov 2024 15:39:00 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Andrew Cooper'
	<andrew.cooper3@citrix.com>, "'bp@alien8.de'" <bp@alien8.de>, "'Josh
 Poimboeuf'" <jpoimboe@kernel.org>
CC: "'x86@kernel.org'" <x86@kernel.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, 'Arnd Bergmann' <arnd@kernel.org>, "'Mikel
 Rychliski'" <mikel@mikelr.com>, 'Thomas Gleixner' <tglx@linutronix.de>,
	"'Ingo Molnar'" <mingo@redhat.com>, 'Borislav Petkov' <bp@alien8.de>, 'Dave
 Hansen' <dave.hansen@linux.intel.com>, "'H. Peter Anvin'" <hpa@zytor.com>
Subject: [PATCH v2] x86: Allow user accesses to the base of the guard page
Thread-Topic: [PATCH v2] x86: Allow user accesses to the base of the guard
 page
Thread-Index: Ads+hc9sKIgnrLHqRG2ra9Mk31sA5w==
Date: Sun, 24 Nov 2024 15:39:00 +0000
Message-ID: <0edca3e5d2194cdf9812a8ccb42216e9@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bn4nS-GD5Yb3jJcbcu0HXqT_soEEKdllySYk828Ixw0_1732462742
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

__access_ok() calls valid_user_address() with the address after
the last byte of the user buffer.
It is valid for a buffer to end with the last valid user address
so valid_user_address() must allow accesses to the base of the
guard page.

Fixes: 86e6b1547b3d0 ("x86: fix user address masking non-canonical speculat=
ion issue")
Signed-off-by: David Laight <david.laight@aculab.com>
---

v2: Rewritten commit message.

 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 06a516f6795b..ca327cfa42ae 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2389,12 +2389,12 @@ void __init arch_cpu_finalize_init(void)
 =09alternative_instructions();
=20
 =09if (IS_ENABLED(CONFIG_X86_64)) {
-=09=09unsigned long USER_PTR_MAX =3D TASK_SIZE_MAX-1;
+=09=09unsigned long USER_PTR_MAX =3D TASK_SIZE_MAX;
=20
 =09=09/*
 =09=09 * Enable this when LAM is gated on LASS support
 =09=09if (cpu_feature_enabled(X86_FEATURE_LAM))
-=09=09=09USER_PTR_MAX =3D (1ul << 63) - PAGE_SIZE - 1;
+=09=09=09USER_PTR_MAX =3D (1ul << 63) - PAGE_SIZE;
 =09=09 */
 =09=09runtime_const_init(ptr, USER_PTR_MAX);
=20
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


