Return-Path: <linux-kernel+bounces-415877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B32E9D3D76
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E822F1F229D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206161A4F1B;
	Wed, 20 Nov 2024 14:23:48 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492DD1A9B53
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112627; cv=none; b=IbLhbMzEfkgk0CdwQemc6igJ1ZYSec0aETsrpi17F1jA/NGwVWE5qUnTLHDex9BRd8+Y9ID/W4QKBU7Nq+KGLKJkmA3Eg2BwjkUD3/x2rJ9Sn6H+mEAy99WzUpobCKY+Fv3P+CDY5ETmjjYozaVfA5tCUijJc+T8XtQTDez3GoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112627; c=relaxed/simple;
	bh=eaMdZ2Il5CUUCS2mliE84+0BJ2tnGIKfe0GKbXGaNzA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZlReFGgoc8Rww94Tjmw5Jh/cuRMkYBYMICEkzXPaCDF9CG5WMVyqIshqtJ0U87R/pxyAsgT65TgbHhvApHHOwcF3HVX3IZuWczvUl9pFCoN7B7N2UoJ6IcHPyEqXdZgbYeYS37Z/87Ew8VrN5tQKL5F2XVfFGhOYuOJZ0yAX/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.2.4] (unknown [60.17.5.234])
	by APP-03 (Coremail) with SMTP id rQCowAAnyO3e8D1nwXouBA--.11733S2;
	Wed, 20 Nov 2024 22:23:27 +0800 (CST)
Message-ID: <c26cbfe04f9c50f5b721a9e954c1213b8c5b0508.camel@iscas.ac.cn>
Subject: Re: [PATCH] riscv: fix memory leakage in
 process_accumulated_relocations
From: laokz <zhangkai@iscas.ac.cn>
To: =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>, Walmsley
	 <paul.walmsley@sifive.com>, Dabbelt <palmer@dabbelt.com>, Ou
	 <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Date: Wed, 20 Nov 2024 22:23:26 +0800
In-Reply-To: <ffcdbcbe-a5f6-48f4-a0a3-0d35c6c80050@rivosinc.com>
References: <35cab46a.6d145.19334919ed0.Coremail.zhangkai@iscas.ac.cn>
	 <ffcdbcbe-a5f6-48f4-a0a3-0d35c6c80050@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:rQCowAAnyO3e8D1nwXouBA--.11733S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW3Ar4ruF4kCF1kKw45KFg_yoW5XFy8pr
	ykKFyDGrW8Cr4kJF4Utwn5Wry8C348A3WUWF15XFy7Jr13Ar40qF1jqr1Fgr4DJr48Jr1U
	Jr15tw1jvr1UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgtr4UUUUU
X-CM-SenderInfo: x2kd0wxndlqxpvfd2hldfou0/

On Tue, 2024-11-19 at 17:57 +0100, Cl=C3=A9ment L=C3=A9ger wrote:
>=20
>=20
> On 16/11/2024 11:42, zhangkai@iscas.ac.cn=C2=A0wrote:
> > When module relocation is done, process_accumulated_relocations()
> > frees all dynamic allocated memory. rel_head_iter-&gt;rel_entry is
> > missed to free that kmemleak might report:
> >=20
> > unreferenced object 0xffffffd880c5fc40 (size 16):
> > =C2=A0 comm "insmod", pid 1101, jiffies 4295045138
> > =C2=A0 hex dump (first 16 bytes):
> > =C2=A0=C2=A0=C2=A0 e0 c0 f5 87 d8 ff ff ff 60 c5 f5 87 d8 ff ff ff=C2=
=A0
> > ........`.......
> > =C2=A0 backtrace (crc d2ecb20c):
> > =C2=A0=C2=A0=C2=A0 [&lt;00000000b01655f6&gt;] kmalloc_trace_noprof+0x26=
8/0x2f6
> > =C2=A0=C2=A0=C2=A0 [&lt;000000006dc0067a&gt;]
> > add_relocation_to_accumulate.constprop.0+0xf2/0x1aa
> > =C2=A0=C2=A0=C2=A0 [&lt;00000000e1b29a36&gt;] apply_relocate_add+0x13c/=
0x36e
> > =C2=A0=C2=A0=C2=A0 [&lt;000000007543f1fb&gt;] load_module+0x5c6/0x83e
> > =C2=A0=C2=A0=C2=A0 [&lt;00000000abce12e8&gt;] init_module_from_file+0x7=
4/0xaa
> > =C2=A0=C2=A0=C2=A0 [&lt;0000000049413e3d&gt;] idempotent_init_module+0x=
116/0x22e
> > =C2=A0=C2=A0=C2=A0 [&lt;00000000f9b98b85&gt;] __riscv_sys_finit_module+=
0x62/0xae
> >=20
> > Signed-off-by: Kai Zhang <zhangkai@iscas.ac.cn>
> > ---
> > =C2=A0arch/riscv/kernel/module.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/riscv/kernel/module.c
> > b/arch/riscv/kernel/module.c
> > index 1cd461f3d87..f8c3c4b47dc 100644
> > --- a/arch/riscv/kernel/module.c
> > +++ b/arch/riscv/kernel/module.c
> > @@ -643,6 +643,7 @@ process_accumulated_relocations(struct module
> > *me,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > reloc_handlers[curr_type].accumulate_handler(
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 me, location, buffer);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(rel_h=
ead_iter-&gt;rel_entry);
>=20
> Hey Kai,
>=20
> Your patch output is messed up probably due to some encoding issue.

Sorry, I've already resent one.

> But looknig at it and the module code, it seems like rel_entry does
> not
> need to be a pointer. It can be a plain "struct list_head rel_entry"
> and

I didn't find the plain(none pointer) usage. Where please?

> then simply pass the list_head pointer rather than allocating/freeing
> it. That remove an allocation as well as some memory leak.
>=20
> BTW, for fixes, you should add a Fixes: tag with the original commit
> sha1 that introduced the bug.
Thank you. I'll try.

laokz

> Thanks,
>=20
> Cl=C3=A9ment
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree=
(rel_head_iter);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 kfree(bucket_iter);


