Return-Path: <linux-kernel+bounces-302624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F319960120
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867A91C22294
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6A175809;
	Tue, 27 Aug 2024 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KY8rndpz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4984219FF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724737283; cv=none; b=S5fSQrXajdUAHbt8Lq/PNHBiK8p3UZEq9lUjowePFcJ7Zntz6J54TzIZn5rwyJChOad/GspIzSfMwrutbLHlpVY0kJw6RGhzVh1PmhHui1ZrSptn4dYngWPInYRdSsJ+Tmsrwv8srJK1ZhizT5na7QUov8HkAriWj12LyDLlR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724737283; c=relaxed/simple;
	bh=KMJVH0KJYiZnGoChdbmTq+vPUUA2R+vE56gE+gRxyeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuo0rf2nXvJv3bv8cFjn0yi0uJLT4hdqZ7l4RVa7ga7nghGVAfC1QTz2zC/JWnjmUQ62WbXMWwDdPG/29Qwu3+swO1pKHAsPbaP3YVW3WspEur6N9ehYMTj7vI2OSEwKyHulaNF0uzNdml/Q2IODIQ6w6rCyQ+xf5eQTglc+IyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KY8rndpz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724737280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qn4U33JvNoYJqKolndcGDNCaDrh5eC3o9PZWlH7K3zU=;
	b=KY8rndpzvJVWMdjWay+20FxyJ7rofGwcuR18NcIGXSgmJh20UFRTwknlnBMSklUon1dqnJ
	vg5zBIr4PrE0WwUAm0mG/ljICOtczd9kmIx9gG2RsDAFbcGYWh6osSjnvOv9OFnsGaozjr
	dBlNSUHoC3Ij6nfML+xGSN8hBcCE2SQ=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-pnY8F3fdOJOu3c2eAk5VHg-1; Tue, 27 Aug 2024 01:41:16 -0400
X-MC-Unique: pnY8F3fdOJOu3c2eAk5VHg-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d4c0fc036so64355805ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 22:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724737276; x=1725342076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qn4U33JvNoYJqKolndcGDNCaDrh5eC3o9PZWlH7K3zU=;
        b=U83Tj3hbeeQDW41p1JU6trLjpFdc8oksRneGP4mBuKgbpf4hOkSbLxtTetOPIw4w8r
         BQYZuhdWxp2ENaoZePKmdemG8fNyVNYYcn7CsOM2YISH7tQDTH5blbW9H8+LaxnDGdb7
         d9fYWdunU/C64WZ1OTIlT7SU6qJlHWd3jrgJFcpPMAGbjG7QjuwbnzYaJwFRo5inCh97
         kxfsgwMkNwrLDs16vukbngiZ7xnFidpcE/Vjhsmn6wuvc2bLTLuctfv53YpJJGaxESW1
         tnTyMVy2MPhyNO6DyTUf5zNDJEPH6CzLQibSIyCQM61Rpt2oXCGs+bZio7Obbm8yiApN
         LvCg==
X-Forwarded-Encrypted: i=1; AJvYcCXz5Og4K6ZxYhmgCEzxegRgPUL0TrxIf0NsIc8tN+X7GXeeOsaqmInx/nvxqqEYaPsERDKWr9IEkcxPNpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YygId8ZzURTXK88TosSzMpb4601nYQorOsriko74WfJnRjpxshj
	6lvDac02UNwyzSDPGIZc40JRHdDE/v1MqQKY711mopC7y3PhugGQg+dmAyUgiYd4HY5LSeOBqyW
	iutN+3ys+8QMcE5oCH5kD3f3c23z8Qd5UOX9umM8wOv+GPi3J1dpuhclkj6T0m9KV9HiP/Pxw9x
	4nJe2Yum1NowMnROeIvL8Wn/muWhyNhVm/a42k
X-Received: by 2002:a05:6e02:170b:b0:39d:254c:ecd2 with SMTP id e9e14a558f8ab-39e3c9c2ab9mr137161975ab.19.1724737275705;
        Mon, 26 Aug 2024 22:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDp/ADhuerjiX7GDmxB19H6YBYr/C7zDHsCGeNpRcEjxIHbYd2iFKRU+5veBOpvt4gknCxEKkyaZTD6rzaCM8=
X-Received: by 2002:a05:6e02:170b:b0:39d:254c:ecd2 with SMTP id
 e9e14a558f8ab-39e3c9c2ab9mr137161895ab.19.1724737275293; Mon, 26 Aug 2024
 22:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826024457.22423-1-bhe@redhat.com> <35e40987-1541-cbbe-6b16-1ddadc2c4c35@amd.com>
 <Zs1j31JGB/5EJatz@MiWiFi-R3L-srv>
In-Reply-To: <Zs1j31JGB/5EJatz@MiWiFi-R3L-srv>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 27 Aug 2024 13:41:25 +0800
Message-ID: <CALu+AoTNtzVGFyG=GLAtT=VEWJG7FNbx6jD_Ye+4ORYXOiMekw@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/sme: fix the kdump kernel breakage on SME system
 when CONFIG_IMA_KEXEC=y
To: Baoquan He <bhe@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, noodles@fb.com, 
	x86@kernel.org, lijiang@redhat.com, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 13:28, Baoquan He <bhe@redhat.com> wrote:
>
> On 08/26/24 at 09:24am, Tom Lendacky wrote:
> > On 8/25/24 21:44, Baoquan He wrote:
> > > Recently, it's reported that kdump kernel is broken during bootup on
> > > SME system when CONFIG_IMA_KEXEC=y. When debugging, I noticed this
> > > can be traced back to commit ("b69a2afd5afc x86/kexec: Carry forward
> > > IMA measurement log on kexec"). Just nobody ever tested it on SME
> > > system when enabling CONFIG_IMA_KEXEC.
> > >
> > > --------------------------------------------------
> > >  ima: No TPM chip found, activating TPM-bypass!
> > >  Loading compiled-in module X.509 certificates
> > >  Loaded X.509 cert 'Build time autogenerated kernel key: 18ae0bc7e79b64700122bb1d6a904b070fef2656'
> > >  ima: Allocated hash algorithm: sha256
> > >  Oops: general protection fault, probably for non-canonical address 0xcfacfdfe6660003e: 0000 [#1] PREEMPT SMP NOPTI
> > >  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc2+ #14
> > >  Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.20.0 05/03/2023
> > >  RIP: 0010:ima_restore_measurement_list+0xdc/0x420
> > >  Code: ff 48 c7 85 10 ff ff ff 00 00 00 00 48 c7 85 18 ff ff ff 00 00 00 00 48 85 f6 0f 84 09 03 00 00 48 83 fa 17 0f 86 ff 02 00 00 <66> 83 3e 01 49 89 f4 0f 85 90 94 7d 00 48 83 7e 10 ff 0f 84 74 94
> > >  RSP: 0018:ffffc90000053c80 EFLAGS: 00010286
> > >  RAX: 0000000000000000 RBX: ffffc90000053d03 RCX: 0000000000000000
> > >  RDX: e48066052d5df359 RSI: cfacfdfe6660003e RDI: cfacfdfe66600056
> > >  RBP: ffffc90000053d80 R08: 0000000000000000 R09: ffffffff82de1a88
> > >  R10: ffffc90000053da0 R11: 0000000000000003 R12: 00000000000001a4
> > >  R13: ffffc90000053df0 R14: 0000000000000000 R15: 0000000000000000
> > >  FS:  0000000000000000(0000) GS:ffff888040200000(0000) knlGS:0000000000000000
> > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >  CR2: 00007f2c744050e8 CR3: 000080004110e000 CR4: 00000000003506b0
> > >  Call Trace:
> > >   <TASK>
> > >   ? show_trace_log_lvl+0x1b0/0x2f0
> > >   ? show_trace_log_lvl+0x1b0/0x2f0
> > >   ? ima_load_kexec_buffer+0x6e/0xf0
> > >   ? __die_body.cold+0x8/0x12
> > >   ? die_addr+0x3c/0x60
> > >   ? exc_general_protection+0x178/0x410
> > >   ? asm_exc_general_protection+0x26/0x30
> > >   ? ima_restore_measurement_list+0xdc/0x420
> > >   ? vprintk_emit+0x1f0/0x270
> > >   ? ima_load_kexec_buffer+0x6e/0xf0
> > >   ima_load_kexec_buffer+0x6e/0xf0
> > >   ima_init+0x52/0xb0
> > >   ? __pfx_init_ima+0x10/0x10
> > >   init_ima+0x26/0xc0
> > >   ? __pfx_init_ima+0x10/0x10
> > >   do_one_initcall+0x5b/0x300
> > >   do_initcalls+0xdf/0x100
> > >   ? __pfx_kernel_init+0x10/0x10
> > >   kernel_init_freeable+0x147/0x1a0
> > >   kernel_init+0x1a/0x140
> > >   ret_from_fork+0x34/0x50
> > >   ? __pfx_kernel_init+0x10/0x10
> > >   ret_from_fork_asm+0x1a/0x30
> > >   </TASK>
> > >  Modules linked in:
> > >  ---[ end trace 0000000000000000 ]---
> > >  RIP: 0010:ima_restore_measurement_list+0xdc/0x420
> > >  Code: ff 48 c7 85 10 ff ff ff 00 00 00 00 48 c7 85 18 ff ff ff 00 00 00 00 48 85 f6 0f 84 09 03 00 00 48 83 fa 17 0f 86 ff 02 00 00 <66> 83 3e 01 49 89 f4 0f 85 90 94 7d 00 48 83 7e 10 ff 0f 84 74 94
> > >  RSP: 0018:ffffc90000053c80 EFLAGS: 00010286
> > >  RAX: 0000000000000000 RBX: ffffc90000053d03 RCX: 0000000000000000
> > >  RDX: e48066052d5df359 RSI: cfacfdfe6660003e RDI: cfacfdfe66600056
> > >  RBP: ffffc90000053d80 R08: 0000000000000000 R09: ffffffff82de1a88
> > >  R10: ffffc90000053da0 R11: 0000000000000003 R12: 00000000000001a4
> > >  R13: ffffc90000053df0 R14: 0000000000000000 R15: 0000000000000000
> > >  FS:  0000000000000000(0000) GS:ffff888040200000(0000) knlGS:0000000000000000
> > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >  CR2: 00007f2c744050e8 CR3: 000080004110e000 CR4: 00000000003506b0
> > >  Kernel panic - not syncing: Fatal exception
> > >  Kernel Offset: disabled
> > >  Rebooting in 10 seconds..
> > >
> > > From debugging printing, the stored addr and size of ima_kexec buffer
> > > are not decrypted correctly like:
> > >  ------
> > >  ima: ima_load_kexec_buffer, buffer:0xcfacfdfe6660003e, size:0xe48066052d5df359
> > >  ------
> > >
> > > There are three pieces of setup_data info passed to kexec/kdump kernel:
> > > SETUP_EFI, SETUP_IMA and SETUP_RNG_SEED. However, among them, only
> > > ima_kexec buffer suffered from the incorrect decryption. After
> > > debugging, it's because of the code bug in early_memremap_is_setup_data()
> > > where checking the embedded content inside setup_data takes wrong range
> > > calculation.
> > >
> > > The length of efi data, rng_seed and ima_kexec are 0x70, 0x20, 0x10,
> > > and the length of setup_data is 0x10. When checking if data is inside
> > > the embedded conent of setup_data, the starting address of efi data and
> > > rng_seed happened to land in the wrong calculated range. While the
> > > ima_kexec's starting address unluckily doesn't pass the checking, then
> > > error occurred.
> > >
> > > Here fix the code bug to make kexec/kdump kernel boot up successfully.
> > >
> > > Fixes: 8f716c9b5feb ("x86/mm: Add support to access boot related data in the clear")
> >
> > The check that was modified was added by:
> >       b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
> >
> > The SETUP_INDIRECT patches seem to be the issue here.
> >
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >  arch/x86/mm/ioremap.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> > > index aa7d279321ea..7953c4a1d28d 100644
> > > --- a/arch/x86/mm/ioremap.c
> > > +++ b/arch/x86/mm/ioremap.c
> > > @@ -717,7 +717,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
> > >             paddr_next = data->next;
> > >             len = data->len;
> > >
> > > -           if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
> > > +           if ((phys_addr > paddr) && (phys_addr < (paddr + size + len))) {
> >
> > I don't think this is correct. You are adding the requested size to the
> > length of the setup data element. The length is the true length of the
> > setup data and should not be increased.
>
> I talked to Dave, he reminded me that people could mix the passed in
> parameter 'size' and the local variable 'size' defined inside the while
> loop, not sure which 'size' you are referring to.
>
Baoquan, you are right, but I think I mistakenly read the code in
memremap_is_setup_data instead of early_memremap_is_setup_data.  You
can check the memremap_is_setup_data, no "size = sizeof (*data)",  so
these two functions could both need fixes.

Otherwise it would be better to change the function internal variable
name, it could cause confusion even if the actual result is correct.

Thanks
Dave


