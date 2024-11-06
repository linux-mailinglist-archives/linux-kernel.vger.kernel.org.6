Return-Path: <linux-kernel+bounces-398104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 502839BE56F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A831F24B85
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302FD1DDC0F;
	Wed,  6 Nov 2024 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PpfBHBR2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4EF18C00E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892078; cv=none; b=TrxXZVDpl91IqmIinUu1s96IlNFhc26uMCHfX65jagL3Oe2gKSyDUouy9puf2RZSYnfwQVI3ALs3+4M5eGtTFVhe5sVQpLZLaVDFaUFZiunXV5qiPVidlC9NwvLNjPicfYkeKz4xm2eoa7k7RHvxkjmu+ZvyV9+No4UHtHNbeRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892078; c=relaxed/simple;
	bh=YXPfgFDdF+d9ngapRnd6AO0SpV7hFZYBlKb7CgdQFBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAFVuRJ5cOs3UKTTZyF8kVgVVsjuLRqQwj2uv4cZnC6MAS4im4aws6VlnS+Z0Y5eHaK8IgM6RYayFfATAY8FEeT8LgadknHhgrW2jYltuG42qQt8EHa0Dlr69u5+s/ituqsZFj4EmWl14h0BkkaR4t8RrhGRY4z7aW5P1em7UM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PpfBHBR2 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 79D9040E0163;
	Wed,  6 Nov 2024 11:21:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Duk4RlUzI0Sl; Wed,  6 Nov 2024 11:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730892067; bh=Bu9fc6Dk9TVZNAnf18tH23Loe20vPvoX1unefxwQ4fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PpfBHBR2siHCoN5sZjsRzzPjtSbUqReZ4o2pwyG2uYaxsqQY5QBrvbtP251iTzDMe
	 TZPG7ra+qAxDsRNQwPEma/4G/LJSDQFUbGxDKYO08KTdYRLffrgyhLJGxc+tI/zunL
	 yHRz9GtDJh1vMiQ5/oYolZ8d0tkFvIJ6ID25cYc78Lx1bVicJ5hocNqaWwfmcukGxX
	 CReJsezzTOgiaCegnYGTFKKig0Rxdw3r+uZ9OJ7Br46YWezJ0xXrCwYKe0mc1GJaJ6
	 DxHM84wbtNRTJbvjSzkzdhVKCUs5YAD9asmmfYgA+bj5iO/rALIEGwApFOXph9FYWg
	 vRoSmA8bt7a1R1eSARwHfcAaOwNtVYONfrTJd4COspgUgkpXbgqk48jXGwl2BizxL/
	 CuaDBzoZMOC8n4S4ZIl/oHMOKawbXc7YFzOp+jXnrpBLOm/T1f0aSLbE6yQMgXKthN
	 vXE6yMZlXLrFGTKsi66WP6Qe4WjJWM4h0Nka5yRxN+BJkqBPY6pGg07bbTnF5rj+01
	 MRiNvRw3jse4crVn6psMcy5+6QxcOtquX4aYvoYpDHKE+YawfzqkYPvJG2ug2LRwFp
	 203P4to4M7z10udhdGdVlKhQvWjpdXyKXxAcVqhDC5r3YIteAYErotYbkx+JKMODDq
	 YJZ/Lp9pRF0uX+LCqm/GyegM=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 23B5240E0261;
	Wed,  6 Nov 2024 11:20:58 +0000 (UTC)
Date: Wed, 6 Nov 2024 12:20:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <20241106112052.GCZytRFKTESZI8_3qD@fat_crate.local>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
 <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
 <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
 <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>
 <20241101161849.GCZyT_aSMcGIXnGr1-@fat_crate.local>
 <ZyVxBbGYsEjifLgp@MiWiFi-R3L-srv>
 <20241102110618.GAZyYHquhmVJd4yM9O@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241102110618.GAZyYHquhmVJd4yM9O@fat_crate.local>
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 02, 2024 at 12:06:18PM +0100, Borislav Petkov wrote:
> Ok, I'll take your 2/2 next week and you can then send the cleanup onto=
p.

OMG what a mess this is. Please test the below before I apply it.

Then, when you do the cleanup, do the following:

- merge early_memremap_is_setup_data() with memremap_is_setup_data() into
  a common __memremap_is_setup_data() and then add a bool early which
  determines which memremap variant is called.

- unify the @size argument by dropping it and using a function local size=
.
  What we have there now is the definition of bitrot. :-\

- replace all sizeof(*data), sizeof(struct setup_data) with a macro defin=
ition
  above the functions to unify it properly.

What an ugly mess... :-\

---
From: Baoquan He <bhe@redhat.com>
Date: Wed, 11 Sep 2024 16:16:15 +0800
Subject: [PATCH] x86/mm: Fix a kdump kernel failure on SME system when
 CONFIG_IMA_KEXEC=3Dy
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The kdump kernel is broken on SME systems with CONFIG_IMA_KEXEC=3Dy enabl=
ed.
Debugging traced the issue back to

  b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec").

Testing was previously not conducted on SME systems with CONFIG_IMA_KEXEC
enabled, which led to the oversight, with the following incarnation:

...
  ima: No TPM chip found, activating TPM-bypass!
  Loading compiled-in module X.509 certificates
  Loaded X.509 cert 'Build time autogenerated kernel key: 18ae0bc7e79b647=
00122bb1d6a904b070fef2656'
  ima: Allocated hash algorithm: sha256
  Oops: general protection fault, probably for non-canonical address 0xcf=
acfdfe6660003e: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc2+ #14
  Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.20.0 05/03/2023
  RIP: 0010:ima_restore_measurement_list
  Call Trace:
   <TASK>
   ? show_trace_log_lvl
   ? show_trace_log_lvl
   ? ima_load_kexec_buffer
   ? __die_body.cold
   ? die_addr
   ? exc_general_protection
   ? asm_exc_general_protection
   ? ima_restore_measurement_list
   ? vprintk_emit
   ? ima_load_kexec_buffer
   ima_load_kexec_buffer
   ima_init
   ? __pfx_init_ima
   init_ima
   ? __pfx_init_ima
   do_one_initcall
   do_initcalls
   ? __pfx_kernel_init
   kernel_init_freeable
   kernel_init
   ret_from_fork
   ? __pfx_kernel_init
   ret_from_fork_asm
   </TASK>
  Modules linked in:
  ---[ end trace 0000000000000000 ]---
  ...
  Kernel panic - not syncing: Fatal exception
  Kernel Offset: disabled
  Rebooting in 10 seconds..

Adding debug printks showed that the stored addr and size of ima_kexec bu=
ffer
are not decrypted correctly like:

  ima: ima_load_kexec_buffer, buffer:0xcfacfdfe6660003e, size:0xe48066052=
d5df359

Three types of setup_data info

  =E2=80=94 SETUP_EFI,
  - SETUP_IMA, and
  - SETUP_RNG_SEED

are passed to the kexec/kdump kernel. Only the ima_kexec buffer
experienced incorrect decryption. Debugging identified a bug in
early_memremap_is_setup_data(), where an incorrect range calculation
occurred due to the len variable in struct setup_data ended up only
representing the length of the data field, excluding the struct's size,
and thus leading to miscalculation.

Address a similar issue in memremap_is_setup_data() while at it.

  [ bp: Heavily massage. ]

Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20240911081615.262202-3-bhe@redhat.com
---
 arch/x86/mm/ioremap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 70b02fc61d93..8d29163568a7 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -656,7 +656,8 @@ static bool memremap_is_setup_data(resource_size_t ph=
ys_addr,
 		paddr_next =3D data->next;
 		len =3D data->len;
=20
-		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
+		if ((phys_addr > paddr) &&
+		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
 			memunmap(data);
 			return true;
 		}
@@ -718,7 +719,8 @@ static bool __init early_memremap_is_setup_data(resou=
rce_size_t phys_addr,
 		paddr_next =3D data->next;
 		len =3D data->len;
=20
-		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
+		if ((phys_addr > paddr) &&
+		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
 			early_memunmap(data, sizeof(*data));
 			return true;
 		}
--=20
2.43.0


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

