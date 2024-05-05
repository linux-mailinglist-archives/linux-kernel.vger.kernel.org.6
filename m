Return-Path: <linux-kernel+bounces-169190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F648BC49B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 00:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53041C20B6B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C10313FD95;
	Sun,  5 May 2024 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W2/4M5Gw"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2E571743
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714949127; cv=none; b=XRpLasJONWxOeI28twhKssMYQ4DjafhEAOuJl/vGX1/3ICPIIC0hWF/3C1jevr0BoG74/wPWiqspWDpJJZ1kr1CaC74Kg1WE/05I+zymxLKQbRViPkbdewo8ASxzENwHHN3SkNs3+K3JNLV0JPHjsm2oeST7uIO2v0QBdYaclkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714949127; c=relaxed/simple;
	bh=sAsSSNJDnKhIa5F2tT1SnCoPw77rBtQwHK6tqCOkQyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwesjmNAnCTuAmLw4Eln81aBwODMQFpbWlcvgMlS55g6llQvq9JUE97+xn3IDAYk+Fd5r8D0k0oj2+gvVPhf/V+u6gEhv/rtrSz5Pd1HRQ7n1QN7HRjdvCZyDQBhTeNq6r1+5mcaN21FZ/m+qq9dD2LGhWDpzPlnYxx7vx53nLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=W2/4M5Gw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1EF7B40E0249;
	Sun,  5 May 2024 22:45:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YXcF-TBVowou; Sun,  5 May 2024 22:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714949118; bh=NjS5kxLZOJz81OAxMXF66zLJMhQsI82kKAEn8JwPuUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W2/4M5GwlZIEVqb8ZeZgvXi8BXp8gZy7RBkdwiWFad50NS4j7l43LeET3IyXp12YE
	 x2lW5bXlIct2ZM9aYU3hP4lF1O6c2bt3XxeVixMgImWDUwAtMcv1hypWgTEKFDK3OY
	 MvQuNrk8uwugOEtlyOhSkEuh6aBdvP9Hn3y9LN7AFoBl8djHbCux+1j5/48a1UmvZW
	 xHssIuO2mJprnXviqqPX74Uvs1smkR/+6e5mPpkWZuAb7rr17iVt+uJ8kjzil53MCL
	 6LZoO1mV9qbjJ8ld6Us+GacZXqMIy1JKYWI2o7k9IxcHLB8OQfC6rg2JaspHKPz8Yr
	 ol1Ax/9vatYYaDgG++5dkhnf6WPukYKUiVTp3duj+5BX/Hw6HGfLavvfp1+ovGGFLd
	 DHg2LNl73DBwMp6xJstelWu32FjfpopCv98ko0KEpxn8HQyMn8aKg8WWUW97l48HSY
	 3Syo6mbOtilwcmlz6PSpJoQo5GD45jQGDY1LnnGeQX9AL0J7HCEXZ24QfHNN9z7pnO
	 ntjjq5Or3Jo21+IZIiy0PcbvKpyS3zdEwahE8FEF5/sIR9CMIJXTtbZM8R5RnArdfJ
	 G9M7U+Q0hwNlqPU4yJQYMNIq6b3TgdihxRFicgTyAJ1s7IDpse7hPtDtVT9awfhBSu
	 5PatFEUJRfbz/KPylqF+12ec=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 184B840E0192;
	Sun,  5 May 2024 22:45:15 +0000 (UTC)
Date: Mon, 6 May 2024 00:45:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tranton Baddy <t.baddy@yandex.ru>, amd-gfx@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error in amd driver?
Message-ID: <20240505224508.GAZjgL9PO9Y5QaAO2t@fat_crate.local>
References: <1237381714935562@dmcmxrwo3x2o7y3i.sas.yp-c.yandex.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1237381714935562@dmcmxrwo3x2o7y3i.sas.yp-c.yandex.net>

+ amd-gfx@lists.freedesktop.org

On Sun, May 05, 2024 at 09:59:22PM +0300, Tranton Baddy wrote:
> I have this in my dmesg since version 6.8.6, not sure when it appeared. Is amdgpu driver has bug?
> [   64.253144] ==================================================================
> [   64.253162] BUG: KFENCE: use-after-free read in amdgpu_bo_move+0x51f/0x7a0
> 
> [   64.253183] Use-after-free read at 0x00000000671c48dd (in kfence-#111):
> [   64.253192]  amdgpu_bo_move+0x51f/0x7a0
> [   64.253202]  ttm_bo_handle_move_mem+0xcf/0x180
> [   64.253211]  ttm_mem_evict_first+0x1c5/0x500
> [   64.253218]  ttm_resource_manager_evict_all+0xa3/0x1e0
> [   64.253228]  amdgpu_device_prepare+0x66/0x110
> [   64.253237]  amdgpu_pmops_runtime_suspend+0xbe/0x1c0
> [   64.253248]  pci_pm_runtime_suspend+0x74/0x200
> [   64.253259]  vga_switcheroo_runtime_suspend+0x21/0xb0
> [   64.253268]  __rpm_callback+0x5f/0x190
> [   64.253277]  rpm_callback+0x7f/0x90
> [   64.253283]  rpm_suspend+0x120/0x6a0
> [   64.253290]  pm_runtime_work+0x9c/0xa0
> [   64.253297]  process_one_work+0x164/0x330
> [   64.253310]  worker_thread+0x302/0x430
> [   64.253320]  kthread+0xe4/0x110
> [   64.253329]  ret_from_fork+0x4c/0x60
> [   64.253341]  ret_from_fork_asm+0x1b/0x30
> 
> [   64.253353] kfence-#111: 0x00000000d018cf03-0x0000000034e821d1, size=96, cache=kmalloc-96
> 
> [   64.253363] allocated by task 152 on cpu 3 at 64.248952s:
> [   64.253418]  kmalloc_trace+0x283/0x340
> [   64.253427]  amdgpu_vram_mgr_new+0x8f/0x3f0
> [   64.253435]  ttm_resource_alloc+0x39/0x90
> [   64.253444]  ttm_bo_mem_space+0xa4/0x260
> [   64.253450]  ttm_mem_evict_first+0x18a/0x500
> [   64.253456]  ttm_resource_manager_evict_all+0xa3/0x1e0
> [   64.253465]  amdgpu_device_prepare+0x66/0x110
> [   64.253472]  amdgpu_pmops_runtime_suspend+0xbe/0x1c0
> [   64.253481]  pci_pm_runtime_suspend+0x74/0x200
> [   64.253489]  vga_switcheroo_runtime_suspend+0x21/0xb0
> [   64.253496]  __rpm_callback+0x5f/0x190
> [   64.253503]  rpm_callback+0x7f/0x90
> [   64.253509]  rpm_suspend+0x120/0x6a0
> [   64.253516]  pm_runtime_work+0x9c/0xa0
> [   64.253523]  process_one_work+0x164/0x330
> [   64.253532]  worker_thread+0x302/0x430
> [   64.253542]  kthread+0xe4/0x110
> [   64.253550]  ret_from_fork+0x4c/0x60
> [   64.253559]  ret_from_fork_asm+0x1b/0x30
> 
> [   64.253570] freed by task 152 on cpu 3 at 64.253117s:
> [   64.253582]  ttm_resource_free+0x67/0x90
> [   64.253591]  ttm_bo_move_accel_cleanup+0x247/0x2e0
> [   64.253598]  amdgpu_bo_move+0x1bd/0x7a0
> [   64.253605]  ttm_bo_handle_move_mem+0xcf/0x180
> [   64.253612]  ttm_mem_evict_first+0x1c5/0x500
> [   64.253618]  ttm_resource_manager_evict_all+0xa3/0x1e0
> [   64.253626]  amdgpu_device_prepare+0x66/0x110
> [   64.253634]  amdgpu_pmops_runtime_suspend+0xbe/0x1c0
> [   64.253642]  pci_pm_runtime_suspend+0x74/0x200
> [   64.253650]  vga_switcheroo_runtime_suspend+0x21/0xb0
> [   64.253658]  __rpm_callback+0x5f/0x190
> [   64.253664]  rpm_callback+0x7f/0x90
> [   64.253671]  rpm_suspend+0x120/0x6a0
> [   64.253677]  pm_runtime_work+0x9c/0xa0
> [   64.253684]  process_one_work+0x164/0x330
> [   64.253693]  worker_thread+0x302/0x430
> [   64.253703]  kthread+0xe4/0x110
> [   64.253711]  ret_from_fork+0x4c/0x60
> [   64.253723]  ret_from_fork_asm+0x1b/0x30
> 
> [   64.253735] CPU: 3 PID: 152 Comm: kworker/3:2 Tainted: P           OE      6.8.9 #3 e7323d0d25f89e853881fc823e59523bdcc577c6
> [   64.253756] Hardware name: Hewlett-Packard HP Pavilion Notebook /80B9, BIOS F.54 05/27/2019
> [   64.253761] Workqueue: pm pm_runtime_work
> [   64.253771] ==================================================================
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

