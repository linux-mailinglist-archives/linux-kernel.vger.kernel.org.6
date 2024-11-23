Return-Path: <linux-kernel+bounces-419213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C78D9D6ADF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9FAAB21D30
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 18:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CF8152196;
	Sat, 23 Nov 2024 18:48:58 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3C71386B4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732387737; cv=none; b=NcS9ZGL1C7F+E4xe2b/xp2w4kuZN/SOy6HYB6n9gxcRMkR5t/hfqa9rR4MbLuEoDvrU2Wi8Qh/9um1b4qoOZAfyAmgvPLkq7snms4sYzeLIWQKyD3/rqMNV26kfNP2Wy4s5XVlwy5MdWs0kwqNnPzT+c+QDrTJg1F6AJw4GUpzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732387737; c=relaxed/simple;
	bh=kkrxetTwLj+RxmrkpHxUpriZI40imdQLb0u0z4vIZes=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OTRVJ6GISbOkKi6fbioGvRhQ41zUdrRTjS9Ho8MqIzR4Ia5I/Iy72GeZCEXSOoJDBPH2wIIvCsdAiQxEyzRjkRCAcLr8PCtxyNZCQycvGRPR7WQ7NDC3BkhyoJJ542gyOUJfyVTzlhMzbsVa6n146G4ieKlWJI7fDN15Gcz6Y2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-100-8U2p8x2lMmCpShVp2xwf8A-1; Sat, 23 Nov 2024 18:48:52 +0000
X-MC-Unique: 8U2p8x2lMmCpShVp2xwf8A-1
X-Mimecast-MFC-AGG-ID: 8U2p8x2lMmCpShVp2xwf8A
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 23 Nov
 2024 18:48:50 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 23 Nov 2024 18:48:50 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Andrew Cooper
	<andrew.cooper3@citrix.com>, "bp@alien8.de" <bp@alien8.de>, Josh Poimboeuf
	<jpoimboe@kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, 'Arnd Bergmann' <arnd@kernel.org>, "'Mikel
 Rychliski'" <mikel@mikelr.com>, 'Thomas Gleixner' <tglx@linutronix.de>,
	"'Ingo Molnar'" <mingo@redhat.com>, 'Borislav Petkov' <bp@alien8.de>, 'Dave
 Hansen' <dave.hansen@linux.intel.com>, "'H. Peter Anvin'" <hpa@zytor.com>
Subject: [PATCH] x86: Allow user accesses to the base of the guard page
Thread-Topic: [PATCH] x86: Allow user accesses to the base of the guard page
Thread-Index: Ads91tEaZvh8m6sNQhyDMO+nmsu5/w==
Date: Sat, 23 Nov 2024 18:48:50 +0000
Message-ID: <680c14b5af9d43d6bc70d2c1e9321e01@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: k97mn0mOQf_ok89aJJUPtePvYy2vRAGx_hyDl9RzTEk_1732387731
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

A user buffer can validly end with the last valid user address.
In that case access_ok(ptr, size) will check that 'ptr + size'
is a valid user address - and it needs to succeed.
access_ok() can't decrement the length because access_ok(ptr, 0)
also has to be valid.
Any actual access will fault.

Fixes: 86e6b1547b3d0 ("x86: fix user address masking non-canonical speculat=
ion issue")
Signed-off-by: David Laight <david.laight@aculab.com>
---
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


