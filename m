Return-Path: <linux-kernel+bounces-330974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7997197A6A9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3102DB2C000
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39B815B104;
	Mon, 16 Sep 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="kEdm+lBE"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE03B15AD95
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507246; cv=none; b=Rp9N5yor1dKYNsGoEIUdOkjwOWAoW/ho9J3m9MYfVM2xk0Q/ZXnnjP8o+ONXqOSeIeFrhfRjHrg97yG9VjZ4LUWelqK/Q4viPnOG+8qcKEhhv4L1tTA46xvjBvoahanFmaYQMMSiCjwU7oHSiewYc3CKbLfdTWOppkLDmHTdW0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507246; c=relaxed/simple;
	bh=/IhytKGddt6AoW2rQaH4L0Nxn0LRvwxRl/dken/AN2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgOk9UslNTl2q0UbBj4iek4gvqSTVGgo0ixp4umine4nWBrrcZC1EME0grqQ9/nFMhPYr6poxgM8d6YiDgkPB3gAbJNsM+DFxqwf7R4UJkIJeVitJRCfLiRhLO6yNs4tXRXrgB/sMxFNmNc9FG4gcmixf0TNA/XIGBkdR7OXK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=kEdm+lBE; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=6dSpWmEpsTQAwMYhXv1BuvQy/Hva0AT9QNxsfeoDReI=; b=kEdm+lBE4HPEeZF3
	OUcL+/nMWDhyeDO6Eh6BhhtXDEWvT16DZHEUsYGgzVLTj9XE1DEe5Rz8oXMPLzCFfs5mPT3lgC/m+
	XJ1ddZUWkZGOEWGK4S8CbfED7m2kB97W4qBcWFWWeMGKKBbW6u1P83BUu0Lw9pnTznWxW3Hj1qF1p
	wPnaQjvpw0DVEr9+QMeUfIKQfYZt2SNr92sI6qcVu5k8mRlYp1A6s9ueP9Y/tWQChhd2KfJhSqrrg
	0Ujx6UuCkicEhcAw6/UmloZ4nVDZmUZPnaE2mv1XLlvbADBDgNqQSkceqFqW0szCgEbpgweQl55Tb
	TfrczPKh6/H/9zbImg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sqFOz-0060Lu-2H;
	Mon, 16 Sep 2024 17:20:41 +0000
Date: Mon, 16 Sep 2024 17:20:41 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Bob Gill <gillb5@telus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 6.11.0 crash on X startup
Message-ID: <Zuho6e9T08Dzrqyp@gallifrey>
References: <96030dde-6c02-4308-b41b-48aeeba670f3@telus.net>
 <b955ec60-081d-4194-8688-b49ff206ea1d@telus.net>
 <aae5a0a4-4d65-43a0-a793-b95096e9ed98@telus.net>
 <ZugStvRPjdmQmMUx@gallifrey>
 <750fb856-9361-4d25-a9b9-efb728a35a5f@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <750fb856-9361-4d25-a9b9-efb728a35a5f@telus.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:16:31 up 131 days,  4:30,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Bob Gill (gillb5@telus.net) wrote:
> OK.

Thanks!  I'm not seeing anything too obvious, however...

>  6.10.0.dmesg.txt:
> 
> [    0.000000] Linux version 6.10.0 (root@freedom) (gcc (Ubuntu
> 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #1 SMP
> PREEMPT_DYNAMIC Sun Jul 14 18:50:17 MDT 2024
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.10.0
> root=UUID=94072726-5fed-439f-a496-8e6aaa88617e ro quiet splash

.....


> 6.11.0.dmesg.txt
> 
> [    0.000000] Linux version 6.11.0 (root@freedom) (gcc (Ubuntu
> 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #1 SMP
> PREEMPT_DYNAMIC Sun Sep 15 13:10:55 MDT 2024
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.11.0
> root=UUID=94072726-5fed-439f-a496-8e6aaa88617e ro recovery nomodeset
> dis_ucode_ldr
> [    0.000000] KERNEL supported cpus:

Would it be possible to get a 6.11.0 dmesg without the 'nomodeset' ?
I realise that's trickier, but it's really where things start to get interesting.

On the 6.10 dmesg we have the normal fun:

> [   15.759932] [drm] amdgpu kernel modesetting enabled.
> [   15.760169] amdgpu: Virtual CRAT table created for CPU
> [   15.760203] amdgpu: Topology: Add CPU node
> [   15.760502] [drm] initializing kernel modesetting (BEIGE_GOBY
> 0x1002:0x743F 0x148C:0x2415 0xC1).
> [   15.760519] [drm] register mmio base: 0xFB700000
> [   15.760520] [drm] register mmio size: 1048576
> [   15.764353] [drm] add ip block number 0 <nv_common>
> [   15.764355] [drm] add ip block number 1 <gmc_v10_0>
> [   15.764357] [drm] add ip block number 2 <navi10_ih>
> [   15.764359] [drm] add ip block number 3 <psp>
> [   15.764360] [drm] add ip block number 4 <smu>
> [   15.764361] [drm] add ip block number 5 <dm>
> [   15.764363] [drm] add ip block number 6 <gfx_v10_0>
> [   15.764364] [drm] add ip block number 7 <sdma_v5_2>
> [   15.764366] [drm] add ip block number 8 <vcn_v3_0>
> [   15.764379] resource: resource sanity check: requesting [mem
> 0x00000000000c0000-0x00000000000dffff], which spans more than PCI Bus
> 0000:00 [mem 0x000d0000-0x000dffff window]
> [   15.764383] caller pci_map_rom+0x83/0x220 mapping multiple BARs
> [   15.764391] amdgpu 0000:04:00.0: No more image in the PCI ROM
> [   15.764412] amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS from ROM BAR
> [   15.764414] amdgpu: ATOM BIOS: 113-001-XT7
> [   15.777550] [drm] VCN(0) decode is enabled in VM mode
> [   15.781178] amdgpu 0000:04:00.0: vgaarb: deactivate vga console
> [   15.781185] amdgpu 0000:04:00.0: amdgpu: Trusted Memory Zone (TMZ)
> feature disabled as experimental (default)
> [   15.781194] amdgpu 0000:04:00.0: amdgpu: PCIE atomic ops is not supported
> [   15.781245] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit,
> fragment size is 9-bit
> [   15.781261] amdgpu 0000:04:00.0: amdgpu: VRAM: 4080M 0x0000008000000000 -
> 0x00000080FEFFFFFF (4080M used)
> [   15.781264] amdgpu 0000:04:00.0: amdgpu: GART: 512M 0x0000000000000000 -
> 0x000000001FFFFFFF
> [   15.781277] [drm] Detected VRAM RAM=4080M, BAR=256M
> [   15.781279] [drm] RAM width 64bits GDDR6
> [   15.783108] [drm] amdgpu: 4080M of VRAM memory ready
> [   15.783112] [drm] amdgpu: 5979M of GTT memory ready.
> [   15.783133] [drm] GART: num cpu pages 131072, num gpu pages 131072
> [   15.783255] [drm] PCIE GART of 512M enabled (table at
> 0x0000008000800000).
> [   18.564918] random: crng init done
> [   19.594908] amdgpu 0000:04:00.0: amdgpu: STB initialized to 2048 entries
> [   19.595220] [drm] Loading DMUB firmware via PSP: version=0x02020020
> [   19.595937] [drm] use_doorbell being set to: [true]
> [   19.595955] [drm] Found VCN firmware Version ENC: 1.31 DEC: 3 VEP: 0
> Revision: 2
> [   19.595965] amdgpu 0000:04:00.0: amdgpu: Will use PSP to load VCN
> firmware
> [   19.663643] amdgpu 0000:04:00.0: amdgpu: reserve 0xa00000 from
> 0x80fd000000 for PSP TMR
> [   19.765435] amdgpu 0000:04:00.0: amdgpu: RAS: optional ras ta ucode is
> not available
> [   19.781512] amdgpu 0000:04:00.0: amdgpu: SECUREDISPLAY: securedisplay ta
> ucode is not available
> [   19.781538] amdgpu 0000:04:00.0: amdgpu: smu driver if version =
> 0x0000000d, smu fw if version = 0x00000010, smu fw program = 0, version =
> 0x00492400 (73.36.0)
> [   19.781544] amdgpu 0000:04:00.0: amdgpu: SMU driver if version not
> matched
> [   19.781581] amdgpu 0000:04:00.0: amdgpu: use vbios provided pptable
> [   19.828182] amdgpu 0000:04:00.0: amdgpu: SMU is initialized successfully!
> [   19.828795] [drm] Display Core v3.2.281 initialized on DCN 3.0.3
> [   19.828798] [drm] DP-HDMI FRL PCON supported
> [   19.829988] [drm] DMUB hardware initialized: version=0x02020020
> [   19.914675] [drm] kiq ring mec 2 pipe 1 q 0
> [   19.956011] amdgpu: HMM registered 4080MB device memory
> [   19.963868] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
> [   19.963883] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
> [   19.964255] amdgpu: Virtual CRAT table created for GPU
> [   19.964896] amdgpu: Topology: Add dGPU node [0x743f:0x1002]
> [   19.964900] kfd kfd: amdgpu: added device 1002:743f
> [   19.964919] amdgpu 0000:04:00.0: amdgpu: SE 1, SH per SE 2, CU per SH 8,
> active_cu_number 16
> [   19.964924] amdgpu 0000:04:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0
> on hub 0
> [   19.964926] amdgpu 0000:04:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1
> on hub 0
> [   19.964927] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng
> 4 on hub 0
> [   19.964929] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng
> 5 on hub 0
> [   19.964931] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng
> 6 on hub 0
> [   19.964933] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng
> 7 on hub 0
> [   19.964935] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng
> 8 on hub 0
> [   19.964936] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng
> 9 on hub 0
> [   19.964938] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng
> 10 on hub 0
> [   19.964940] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng
> 11 on hub 0
> [   19.964941] amdgpu 0000:04:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng
> 12 on hub 0
> [   19.964943] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on
> hub 0
> [   19.964945] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0
> on hub 8
> [   19.966250] amdgpu 0000:04:00.0: amdgpu: Using BACO for runtime pm
> [   19.966781] [drm] Initialized amdgpu 3.57.0 20150101 for 0000:04:00.0 on
> minor 0
> [   19.975362] fbcon: amdgpudrmfb (fb0) is primary device
> [   19.975369] fbcon: Deferring console take-over
> [   19.975373] amdgpu 0000:04:00.0: [drm] fb0: amdgpudrmfb frame buffer
> device

So lets see what that looks like on a 6.11.0 without the nomodeset.

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

