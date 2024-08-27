Return-Path: <linux-kernel+bounces-302519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D758195FFAB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F53283282
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE13718039;
	Tue, 27 Aug 2024 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hi5w9Y18"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CE8BE5E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724728762; cv=none; b=hTwT1xaMFrCa19hGXEz9jeQU2Su2ib9RLfYDJ8YrxUHqk4p3YL41HNEzPtauP3BIgZA3Q3MUKO5NDGWffBKXljTWWk1VEbPQGGG9igNpJOqMhb97bWVEFAc0r2VYFwArzOu0IpZqVbDcyZGec6FR1UlDsb6hX/ADK/6VwwMif4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724728762; c=relaxed/simple;
	bh=XBKNS74axaP62w9urfjhrHMe7t6bMxuP30NeCGZuYxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcK7spaxKOZz0jabZ8HBWODXvgIvTTu+3UIQX/SxpPIDMQDUAgxYwwOvt59Aw1fTQ/BwjgGQR8WCiUc01FJwAfj6BrQYARAP+jNQOPchWQdqKBwEBRUez1g0PvJS9fa9N8kgp27jAM+8w4qILTsofK9OOMhIaaGpWAnrll83xBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hi5w9Y18; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724728759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mao8BPC02rLbQsWcMKds61xFi54GETX6UtFo69nGjYE=;
	b=Hi5w9Y18EBHb9qWvmgURgmuLE5CXUkVx+P/Jqi125NPjKXqLHyTjVMgd3lN3uqXh8TO/7V
	ogPBw4FabN/iLaVJaHwaA3aQ4ytrPHvNW2Ttu/lZ1JVsxld8i4/0KFeSUNvJErnxFF8AGx
	sU0n/nykqBOGx4h0tLXJVJ8zC/Mubbo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-EmKBVpomP0WWh_c5xHSxcw-1; Mon,
 26 Aug 2024 23:19:16 -0400
X-MC-Unique: EmKBVpomP0WWh_c5xHSxcw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 115591955F3D;
	Tue, 27 Aug 2024 03:19:15 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B50DE1956052;
	Tue, 27 Aug 2024 03:19:13 +0000 (UTC)
Date: Tue, 27 Aug 2024 11:19:09 +0800
From: Baoquan He <bhe@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, noodles@fb.com, x86@kernel.org,
	lijiang@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org
Subject: Re: [PATCH] x86/mm/sme: fix the kdump kernel breakage on SME system
 when CONFIG_IMA_KEXEC=y
Message-ID: <Zs1FrZVuZK14Je7z@MiWiFi-R3L-srv>
References: <20240826024457.22423-1-bhe@redhat.com>
 <35e40987-1541-cbbe-6b16-1ddadc2c4c35@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35e40987-1541-cbbe-6b16-1ddadc2c4c35@amd.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/26/24 at 09:24am, Tom Lendacky wrote:
> On 8/25/24 21:44, Baoquan He wrote:
> > Recently, it's reported that kdump kernel is broken during bootup on
> > SME system when CONFIG_IMA_KEXEC=y. When debugging, I noticed this
> > can be traced back to commit ("b69a2afd5afc x86/kexec: Carry forward
> > IMA measurement log on kexec"). Just nobody ever tested it on SME
> > system when enabling CONFIG_IMA_KEXEC.
> > 
> > --------------------------------------------------
> >  ima: No TPM chip found, activating TPM-bypass!
> >  Loading compiled-in module X.509 certificates
> >  Loaded X.509 cert 'Build time autogenerated kernel key: 18ae0bc7e79b64700122bb1d6a904b070fef2656'
> >  ima: Allocated hash algorithm: sha256
> >  Oops: general protection fault, probably for non-canonical address 0xcfacfdfe6660003e: 0000 [#1] PREEMPT SMP NOPTI
> >  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc2+ #14
> >  Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.20.0 05/03/2023
> >  RIP: 0010:ima_restore_measurement_list+0xdc/0x420
> >  Code: ff 48 c7 85 10 ff ff ff 00 00 00 00 48 c7 85 18 ff ff ff 00 00 00 00 48 85 f6 0f 84 09 03 00 00 48 83 fa 17 0f 86 ff 02 00 00 <66> 83 3e 01 49 89 f4 0f 85 90 94 7d 00 48 83 7e 10 ff 0f 84 74 94
> >  RSP: 0018:ffffc90000053c80 EFLAGS: 00010286
> >  RAX: 0000000000000000 RBX: ffffc90000053d03 RCX: 0000000000000000
> >  RDX: e48066052d5df359 RSI: cfacfdfe6660003e RDI: cfacfdfe66600056
> >  RBP: ffffc90000053d80 R08: 0000000000000000 R09: ffffffff82de1a88
> >  R10: ffffc90000053da0 R11: 0000000000000003 R12: 00000000000001a4
> >  R13: ffffc90000053df0 R14: 0000000000000000 R15: 0000000000000000
> >  FS:  0000000000000000(0000) GS:ffff888040200000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 00007f2c744050e8 CR3: 000080004110e000 CR4: 00000000003506b0
> >  Call Trace:
> >   <TASK>
> >   ? show_trace_log_lvl+0x1b0/0x2f0
> >   ? show_trace_log_lvl+0x1b0/0x2f0
> >   ? ima_load_kexec_buffer+0x6e/0xf0
> >   ? __die_body.cold+0x8/0x12
> >   ? die_addr+0x3c/0x60
> >   ? exc_general_protection+0x178/0x410
> >   ? asm_exc_general_protection+0x26/0x30
> >   ? ima_restore_measurement_list+0xdc/0x420
> >   ? vprintk_emit+0x1f0/0x270
> >   ? ima_load_kexec_buffer+0x6e/0xf0
> >   ima_load_kexec_buffer+0x6e/0xf0
> >   ima_init+0x52/0xb0
> >   ? __pfx_init_ima+0x10/0x10
> >   init_ima+0x26/0xc0
> >   ? __pfx_init_ima+0x10/0x10
> >   do_one_initcall+0x5b/0x300
> >   do_initcalls+0xdf/0x100
> >   ? __pfx_kernel_init+0x10/0x10
> >   kernel_init_freeable+0x147/0x1a0
> >   kernel_init+0x1a/0x140
> >   ret_from_fork+0x34/0x50
> >   ? __pfx_kernel_init+0x10/0x10
> >   ret_from_fork_asm+0x1a/0x30
> >   </TASK>
> >  Modules linked in:
> >  ---[ end trace 0000000000000000 ]---
> >  RIP: 0010:ima_restore_measurement_list+0xdc/0x420
> >  Code: ff 48 c7 85 10 ff ff ff 00 00 00 00 48 c7 85 18 ff ff ff 00 00 00 00 48 85 f6 0f 84 09 03 00 00 48 83 fa 17 0f 86 ff 02 00 00 <66> 83 3e 01 49 89 f4 0f 85 90 94 7d 00 48 83 7e 10 ff 0f 84 74 94
> >  RSP: 0018:ffffc90000053c80 EFLAGS: 00010286
> >  RAX: 0000000000000000 RBX: ffffc90000053d03 RCX: 0000000000000000
> >  RDX: e48066052d5df359 RSI: cfacfdfe6660003e RDI: cfacfdfe66600056
> >  RBP: ffffc90000053d80 R08: 0000000000000000 R09: ffffffff82de1a88
> >  R10: ffffc90000053da0 R11: 0000000000000003 R12: 00000000000001a4
> >  R13: ffffc90000053df0 R14: 0000000000000000 R15: 0000000000000000
> >  FS:  0000000000000000(0000) GS:ffff888040200000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 00007f2c744050e8 CR3: 000080004110e000 CR4: 00000000003506b0
> >  Kernel panic - not syncing: Fatal exception
> >  Kernel Offset: disabled
> >  Rebooting in 10 seconds..
> > 
> > From debugging printing, the stored addr and size of ima_kexec buffer
> > are not decrypted correctly like:
> >  ------
> >  ima: ima_load_kexec_buffer, buffer:0xcfacfdfe6660003e, size:0xe48066052d5df359
> >  ------
> > 
> > There are three pieces of setup_data info passed to kexec/kdump kernel:
> > SETUP_EFI, SETUP_IMA and SETUP_RNG_SEED. However, among them, only
> > ima_kexec buffer suffered from the incorrect decryption. After
> > debugging, it's because of the code bug in early_memremap_is_setup_data()
> > where checking the embedded content inside setup_data takes wrong range
> > calculation.
> > 
> > The length of efi data, rng_seed and ima_kexec are 0x70, 0x20, 0x10,
> > and the length of setup_data is 0x10. When checking if data is inside
> > the embedded conent of setup_data, the starting address of efi data and
> > rng_seed happened to land in the wrong calculated range. While the
> > ima_kexec's starting address unluckily doesn't pass the checking, then
> > error occurred.
> > 
> > Here fix the code bug to make kexec/kdump kernel boot up successfully.
> > 
> > Fixes: 8f716c9b5feb ("x86/mm: Add support to access boot related data in the clear")
> 
> The check that was modified was added by:
> 	b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
> 
> The SETUP_INDIRECT patches seem to be the issue here.

Hmm, I didn't check it carefully, thanks for addding this info. While
after checking commit b3c72fc9a78e, I feel the adding code was trying to
fix your original early_memremap_is_setup_data(). Even though
SETUP_INDIRECT type of setup_data has been added, the original
early_memremap_is_setup_data() only check the starting address and
the content of struct setup_data, that's obviously wrong.

arch/x86/include/uapi/asm/setup_data.h:
/* extensible setup data list node */
struct setup_data {
        __u64 next;
        __u32 type;
        __u32 len;
        __u8 data[];
};

As you can see, the zero-length will embed the carried data which is
actually expected and adjacent to its carrier, the struct setup_data.

> 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/x86/mm/ioremap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> > index aa7d279321ea..7953c4a1d28d 100644
> > --- a/arch/x86/mm/ioremap.c
> > +++ b/arch/x86/mm/ioremap.c
> > @@ -717,7 +717,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
> >  		paddr_next = data->next;
> >  		len = data->len;
> >  
> > -		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
> > +		if ((phys_addr > paddr) && (phys_addr < (paddr + size + len))) {
> 
> I don't think this is correct. You are adding the requested size to the
> length of the setup data element. The length is the true length of the
> setup data and should not be increased.

Please see the inline comment among code lines.

static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
                                                unsigned long size)
{
        struct setup_indirect *indirect;
        struct setup_data *data;
        u64 paddr, paddr_next;

        paddr = boot_params.hdr.setup_data; //paddr point at struct steup_data;
        while (paddr) {
                unsigned int len, size;

                if (phys_addr == paddr) // check the starting addr of setup_data
                        return true;

		data = early_memremap_decrypted(paddr, sizeof(*data));
                if (!data) {
                        pr_warn("failed to early memremap setup_data entry\n");
                        return false;
                }

                size = sizeof(*data); //size is the length of struct setup_data

                paddr_next = data->next;
                len = data->len; // len is the length of carried data,
                                 //e.g sizeof(ima_setup_data) if ima_kexec buffer
                                 // or sizeof(struct setup_indirect) if
                                 // it's SETUP_INDIRECT type. Note that SETUP_INDIRECT
				 //data is also setup_data info even
				 //though it's intermideate info.


		//Here I check if phys_addr is inside (paddr, paddr + sizeof(struct setup_data) + len)	
                //means it check if phys_addr is inside struct
                //setup_data or struct ima_setup_data if ima_kexec case.
                if ((phys_addr > paddr) && (phys_addr < (paddr + size + len))) {
                        early_memunmap(data, sizeof(*data));
                        return true;
                }

		if (data->type == SETUP_INDIRECT) {
			......
			if (indirect->type != SETUP_INDIRECT) {
                                paddr = indirect->addr;
                                len = indirect->len;
                        }
			// it's checking the indirect dat, and the paddr
			// is adjusted here. Wondering if indirect data
			//can be nested, e.g 
 			//setup_data->indirect->indirect->acutal data
		}
	...
	}
	...
}


> 
> It looks like there were some major changes to this function to support
> SETUP_INDIRECT. Is the IMA log setup data marked SETUP_INDIRECT?

No, ima_kexec buffer is marked as SETUP_IMA, it's not indirect data.

arch/x86/kernel/kexec-bzimage64.c:
bzImage64_load()
    ->setup_boot_parameters()
        ->setup_ima_state()

> 
> It might be helpful to instrument the code to see exactly what is
> happening during the execution of that function for the IMA log address.

I almost have printed all needed information because kexec/kdump passed
three types of setup_data, but only ima_kexec buffer is not got right.
The behaviour is very bizarre at the beginning.


