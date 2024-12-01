Return-Path: <linux-kernel+bounces-426710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB299DF6E6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 19:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B4FCB21135
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416C51D5CE8;
	Sun,  1 Dec 2024 18:12:57 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7891CD1F
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733076776; cv=none; b=oWZaVWu86noLgN72R3n1Y4NPJArwglH9v1XA7hNMLv+1So/m5t5yz5bVEsMob5ubwlUGw49kxj9GDySnlnESPK0tCEMKBXHmGsxivOvTArwqBepPO+cc9a2btxqP00fqGo7oAvenP4GoJ53r6grhtUV68C7gmjUTA29ish7NkB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733076776; c=relaxed/simple;
	bh=mnoj6b/+Tkn0pEuRi2CLR/E5pFflKReO3V9XaWABA5c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V+o8d3YLodO3YCKtEuzVmghSSFXKoGJOOetjdgsPOfMIG0lYdnguG7nYxwd5D6pJVh/bsD2Aw/yI2IST3k7UXHEj1LdrTSK8CtGym4l5USKwvcwp6FJa3NmeXCsxvAOqqnaARhyNRTzdmTt+XLzC5QXg/RCLqwNqwfUh5GhkRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-14-D1SDPVzzOO2hg2ZoGC2v1g-1; Sun, 01 Dec 2024 18:12:52 +0000
X-MC-Unique: D1SDPVzzOO2hg2ZoGC2v1g-1
X-Mimecast-MFC-AGG-ID: D1SDPVzzOO2hg2ZoGC2v1g
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 1 Dec
 2024 18:12:25 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 1 Dec 2024 18:12:25 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linuxfoundation.org>, "'x86@kernel.org'"
	<x86@kernel.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, 'Thomas Gleixner' <tglx@linutronix.de>,
	"'Ingo Molnar'" <mingo@redhat.com>, 'Dave Hansen'
	<dave.hansen@linux.intel.com>
CC: 'Andrew Cooper' <andrew.cooper3@citrix.com>, 'Josh Poimboeuf'
	<jpoimboe@kernel.org>, "'bp@alien8.de'" <bp@alien8.de>
Subject: [PATCH next] x86: mask_user_address() return base of guard page for
 kernel addresses
Thread-Topic: [PATCH next] x86: mask_user_address() return base of guard page
 for kernel addresses
Thread-Index: AdtEHKHDLvCr/TWKQ76WywrKdPgaxg==
Date: Sun, 1 Dec 2024 18:12:25 +0000
Message-ID: <e654a20c9045487eaacbd256f584ce45@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: ELuz8t-L36gtp0uZebmLhAAX7hREi0WQRYkjc7F0Vk4_1733076771
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

mask_user_address() currently return ~0 for kernel addresses.
This is fine for avoiding speculative reads and get_user()
but is problematic for the code pattern:
=09=09if (can_do_masked_user_access())
=09=09=09from =3D masked_user_access_begin(from);
=09=09else if (!user_read_access_begin(from, sizeof(*from)))
=09=09=09return -EFAULT;
=09=09unsafe_get_user(to->p, &from->p, Efault);
=09=09unsafe_get_user(to->size, &from->size, Efault);
=09=09user_read_access_end();
because of the requirement that the base address be accessed first.

Changing mask_user_address() to return the base of the guard page
means that any address within 4k of the tested address will fault
and the order of the structure member access is no longer critical.

The change replaces the 'sbb, or' with a 'cmov' so is also shorter.

Signed-off-by: David Laight <david.laight@aculab.com>
---

I've built and run a kernel with it - so not broken!

Probably ought to be a follow up patch to rename it to bound_user_access()
before there are too many users.

 arch/x86/include/asm/uaccess_64.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uacce=
ss_64.h
index b0a887209400..4cdace8c93b3 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -57,19 +57,22 @@ static inline unsigned long __untagged_addr_remote(stru=
ct mm_struct *mm,
 =09((__force unsigned long)(x) <=3D runtime_const_ptr(USER_PTR_MAX))
=20
 /*
- * Masking the user address is an alternative to a conditional
- * user_access_begin that can avoid the fencing. This only works
- * for dense accesses starting at the address.
+ * Bound a user address to the base of the guard page.
+ * This can be used to avoid speculative accesses following access_ok(),
+ * or as an alternative to a conditional user_access_begin.
+ * Both without expensive fencing.
+ * Valid provided the accesses are 'reasonably sequnential'
+ * (no jumps of a page size).
  */
 static inline void __user *mask_user_address(const void __user *ptr)
 {
-=09unsigned long mask;
-=09asm("cmp %1,%0\n\t"
-=09    "sbb %0,%0"
-=09=09:"=3Dr" (mask)
-=09=09:"r" (ptr),
-=09=09 "0" (runtime_const_ptr(USER_PTR_MAX)));
-=09return (__force void __user *)(mask | (__force unsigned long)ptr);
+=09void __user *bounded =3D (__force void __user *)runtime_const_ptr(USER_=
PTR_MAX);
+
+=09asm("cmp %0,%1\n\t"
+=09    "cmovc %1,%0"
+=09=09:"+r" (bounded)
+=09=09:"r" (ptr));
+=09return bounded;
 }
 #define masked_user_access_begin(x) ({=09=09=09=09\
 =09__auto_type __masked_ptr =3D (x);=09=09=09=09\
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


