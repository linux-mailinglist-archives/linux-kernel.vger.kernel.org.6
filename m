Return-Path: <linux-kernel+bounces-330119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6969799F5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BAD91F224DD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 02:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76295DF53;
	Mon, 16 Sep 2024 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="A6E+QRlr"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28770125BA
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726454640; cv=none; b=ClFCrfceZHjrBJmJsiAQUPey1Zx4Vp/XHDvk1P1bS8tIMJhSLFIeQC3HC68Tc38H88Yq024++EG9kFKXhM6kl2m+t4T25MFshrVk+yR62MFsZmVPAHplG9uyKtwtQiW9nTswO4MpKsQ9ZieXWAHoru6u73ADbjxHFuqlV2iDOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726454640; c=relaxed/simple;
	bh=TCWJ3Zdlu7V/5yZjvLfFFtVSChys35D07gaz7Ngj2rM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=g1u4kAfLHoEifM02CUwsLoI/UUpJLobgo7PazEbRBQCW1zaQRLB6Dh9XwDftPRJujo4VYkutcHoCLkRVuDhnQYXfnudOFu20xg5WaTrwIuPkeaGabBoK403ilRcp925sknFsZfFX49cJw9kNaOAej7YMOWSnPEZeW6UgO+jI0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=A6E+QRlr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-717839f9eb6so785537b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 19:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1726454638; x=1727059438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXDKmxFEldl8Q8lSjEQynxXtx0pXxPIwRrkAEmXHoak=;
        b=A6E+QRlr8DqwH+NlKdz2ToQjCvxZe5f1sStA07zQUTIGLkC6DSGZ45aC6VFXAZOdfo
         EdoWBjgezPtnVS3DMquJFe4Lwf8HHg37+7uzz1pbf4KY1PD9//G/yO0lnFuewVTNifLj
         8cy0z5nv0Q7VVU6u1nZY50/AG5y755QY1H6xjaDbWsn2Vacen6d2weFZyYA3ii8u+ZQa
         oFtbCUgPto9g1IvmEC86wuu8k6JYNtKeQS0bw/ddy33MVFfq/iPHBM1kwbnnTnYawhI7
         hpiTiCjT/P1yf2eoci/enFjL0F70t4vYyxZMC8msNx+30ABlicOhDhlX+7s6WSU4xRK8
         RL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726454638; x=1727059438;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXDKmxFEldl8Q8lSjEQynxXtx0pXxPIwRrkAEmXHoak=;
        b=jOpfSMLj4DpMLOYtw/wqyba12a6RP8EmMJRx5TeDFHOmjtQEG2nSXGNNVkXWSYJk23
         Hvbtb775ZstJ40NQIAg9rL5HsdiNUTf11gEURalg/H5AWa7ZbVTdoBoxIb6A5lzfUXSE
         CMOyFz02e7vg9zpUTZivd3KhwWRi5aAGxaYbetfKGHd4XiLo/UBQRpDbHTliGrnBAKzX
         J1DH0INnsPdfcDO6BS1hq6lsX7E1VcvM4qSO6KERS+5NHTaRLT/18rhUIb0kwFfSAbiv
         29gsAGE90EZIZEUYN9/xjgweg6wg+92Lcddl9HWtXQMacJ+jhFU8RloIaOuCYvUX8Rmn
         oR5g==
X-Gm-Message-State: AOJu0Yz4pNvEPh8HMgWAigIfrrbrCBPngiEQRhlhhBFu2yWGfXgV0M22
	88hZAVC3vQyzN5sb906Dm7isg/mTlkfhOQO2aIPvk3TN7k4WdoL+YYbk5DEJ7KOIwjg19u+Y/3u
	M
X-Google-Smtp-Source: AGHT+IFdQGbIUGcMLCcx4RzlHV9peYUPNeIL8RZPGMZQlzXE0pkwu67IKt7E5sWM3atwexR2Qr8WYA==
X-Received: by 2002:a05:6a00:ccb:b0:718:e49f:246e with SMTP id d2e1a72fcca58-7192620091cmr8504112b3a.6.1726454637732;
        Sun, 15 Sep 2024 19:43:57 -0700 (PDT)
Received: from ?IPV6:2001:56a:f979:1f00:4a0f:bed4:afc2:976e? ([2001:56a:f979:1f00:4a0f:bed4:afc2:976e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab5115sm2853144b3a.55.2024.09.15.19.43.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 19:43:57 -0700 (PDT)
Message-ID: <aae5a0a4-4d65-43a0-a793-b95096e9ed98@telus.net>
Date: Sun, 15 Sep 2024 20:43:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.11.0 crash on X startup
From: Bob Gill <gillb5@telus.net>
To: linux-kernel@vger.kernel.org
References: <96030dde-6c02-4308-b41b-48aeeba670f3@telus.net>
 <b955ec60-081d-4194-8688-b49ff206ea1d@telus.net>
Content-Language: en-US
In-Reply-To: <b955ec60-081d-4194-8688-b49ff206ea1d@telus.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Addendum: I have a portion of /var/log/syslog of the 6.11-rc7 kernel, 
which contains a coredump, and

another line: Sep  8 20:13:06 freedom kernel: [  566.359456] ACPI: 
\_SB_.PCI0.SBRG.ASOC: Device cannot be configured due to a frequency 
mismatch

any takers?

On 2024-09-15 14:59, Bob Gill wrote:
> So 6.10.0 runs ok.  6.11.0-rc1 was the first kernel that started 
> crashing.  Every rc after, including 6.11.0 all crash.
>
> By that I mean it seems the startup is ok, but when it comes to the X 
> server, when it tries to start, it crashes (and takes everything else 
> along with it).
>
> I ran recovery kernel, enabled networking, dropped into terminal.
>
> service --status-all | grep lightdm gave:
>
> [ - ]  lightdm
>
> Portions of Xorg.0.log:
>
> cat Xorg.0.log | grep EE
>
> [    61.679] Current Operating System: Linux freedom 6.11.0 #1 SMP 
> PREEMPT_DYNAMIC Sun Sep 15 13:10:55 MDT 2024 x86_64
>     (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
> [    61.809] (EE) systemd-logind: failed to get session: PID 2028 does 
> not belong to any known session
> [    61.913] (EE) open /dev/dri/card0: No such file or directory
> [    61.913] (EE) open /dev/dri/card0: No such file or directory
> [    61.914] (EE) Unable to find a valid framebuffer device
> [    61.914] (EE) open /dev/fb0: No such file or directory
> [    61.914] (EE) Screen 0 deleted because of no matching config section.
> [    61.914] (EE) Screen 0 deleted because of no matching config section.
>
>
> From the terminal, I can't run 'service lightdm start' and get back to 
> any state.  pressing ctrl-alt-(f1-f9) does nothing. Pressing the 
> caps-lock button on/off on the keyboard stops responding immediately.  
> Even the power/reset buttons on the case do nothing.  I have to hit 
> the power switch.  The kernel crashes hard.
>
> My graphics hardware (taken from 6.10.0):
>
> inxi -G
>
> Graphics:
>   Device-1: AMD driver: amdgpu v: kernel
>   Device-2: Conexant Systems CX23887/8 PCIe Broadcast Audio and Video
>     Decoder with 3D Comb
>     driver: cx23885 v: 0.0.4
>   Device-3: Razer USA Kiyo Pro type: USB driver: snd-usb-audio,uvcvideo
>   Device-4: Realtek RTL2838 DVB-T type: USB driver: N/A
>   Display: x11 server: X.Org v: 1.21.1.4 driver: X: loaded: amdgpu,ati
>     unloaded: fbdev,modesetting,radeon,vesa gpu: amdgpu resolution:
>     1: 1920x1080~60Hz 2: 1920x1080~60Hz
>   OpenGL:
>     renderer: AMD Radeon RX 6500 XT (navi24 LLVM 15.0.7 DRM 3.57 
> 6.10.0-rc7+)
>     v: 4.6 Mesa 23.2.1-1ubuntu3.1~22.04.2
>
>
> There is a weird line from /var/log/Xorg.0.log.old:
>
> [   299.900] (++) using VT number 7
>
> [   299.900] (II) systemd-logind: logind integration requires -keeptty 
> and -keeptty was not provided, disabling logind integration
> [   299.908] (--) PCI:*(4@0:0:0) 1002:743f:148c:2415 rev 193, Mem @ 
> 0xd0000000/268435456, 0xcfe00000/2097152, 0xfb700000/1048576, I/O @ 
> 0x0000a000/256, B
> IOS @ 0x????????/131072
> [   299.908] (--) PCI: (9@0:0:0) 14f1:8880:0070:7801 rev 15, Mem @ 
> 0xfbc00000/2097152
> [   299.908] (II) LoadModule: "glx"
>
> I don't know why the BIOS line looks like: BIOS @ 0x????????/131072
>
> Is that normal or did it not find it?
>
>
> Sure, its a corner case.  I might be the only one on the planet with 
> this problem.  Or maybe not.
>
> I have been using a standard .config for building kernels for a while 
> now.  Please reply to me directly as I'm not on the list.
>
> Bob
>
>
>
>
>

