Return-Path: <linux-kernel+bounces-330057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A690979914
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 23:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2995928287B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1806F2F2;
	Sun, 15 Sep 2024 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="XcR10VZF"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6F65A4D5
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726433986; cv=none; b=GrDsx0+6XHDvSS3GnFrb7iHBOREbJwUcjg1V5CUXtmP8je0wO2KmqsGNbwzL+6pg91g2ZZMDp+CMPkhJuIGFGT3dWfMNvoPjKx5nqNgTdhlKLiL8HUt0Rab8sWA8QAGi/58Zl/OidDi+MI4RhvI24ZxbUp5troNObve8/LJJ4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726433986; c=relaxed/simple;
	bh=fd+FZuZJiHUm0PxnKAViKC5VKt6xV0cdYB0QnuTsf0s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=mprc6VIGXgjScZpXyGcEKXKaL0wgPV7DukNFhjZU2UyzolDkAtEC+FS9ScyBN9IUTdW3DX+F7DniBa8vCuVB+shTBZ1ucayWuRsbFOceMlxGv2L4z1eumG+ho2EyPO7JKy4PKDiPs6N8mOBjgElkXJ/GFixbuT2CnCiZq8FKMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=XcR10VZF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20699ab963cso2472895ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1726433983; x=1727038783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3jzBcU4H9vVYqtYmdjnG9gCLBDa0F/Pxz22ykP76Xw=;
        b=XcR10VZFxsOaBlZF4XwkiarjAJUX5Q4hkPR73ZKKHhpNTHQ2ODkQD67emUzuw/iWYC
         hlW3aHLEdFtrD0dYAa7bIsY6NjperpL105HV4mZ3jOCj+8nUJvN+9LCtA6AfCTTgWJRX
         dS7RxAUe734zOC/rmDS6ZI7aAW/F60XHY0R8Pthz9n/A51uzizwABZzjt//gIS3Co04H
         XlNdAVlHTie396pinZ5EAIqZQXmbAO3ZPjBABB9KQvzMcsdrHxFUkPo6iQHN4Fkyyqga
         rTU5bDO3SPWX0Q5iggUUyRrac3BT34rOlhDWDUNIMvbAQCxBQWfo/ES0ZLUecWHabRK0
         H1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726433983; x=1727038783;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3jzBcU4H9vVYqtYmdjnG9gCLBDa0F/Pxz22ykP76Xw=;
        b=RuJ+lzwGBLlPxKtaGGyViYaW9PprKEH4801Ci6g6DiBU732OBUnW1ooVwYAYVHl3Ym
         dFaJIMCLrvoC8sfyxAB4LyILJ/4RpMpB8mrOfgIq0ERe7Xq+CBT0eb8xFJExJ2pJrwug
         EmRqKS/JUDSFwV+IZhQMz7LjX1frR3FsC9kqRpC1y/sfiiqyTjytpJzDMx/G9H9eKeom
         OtQE9JFwThYKdGYmFIzCk0LrJipC+NK1f5xFPel+pzjGtYSbAK261VcNI5M7lXWIfEIt
         eoOfzouPyxAQhL09kutLRhZ6FOnCNigkamRwFB77DF+SmIzjQZqnSHjgEzi8ARO39/6R
         skrg==
X-Gm-Message-State: AOJu0YwooXbzDmRcTSI2e81NoVncOfDKqePAMptTQWEhtUH72ghUef5g
	QysIr2UNa0XI/kP03blvGe6Qvw8PADBP9iFVSEjnFoTlUNQsX3/y8UFqFRiQ2QH6tjPcxy403TH
	O
X-Google-Smtp-Source: AGHT+IFFjVxAV1NcvAin2FgiRX+kVfEBWPyny/cb18fftKcnaFnux0SuSDNFbKWxq3L8yAzeWR3QgQ==
X-Received: by 2002:a17:902:c406:b0:207:4734:2ca6 with SMTP id d9443c01a7336-2076e41caa6mr83685755ad.10.1726433982529;
        Sun, 15 Sep 2024 13:59:42 -0700 (PDT)
Received: from ?IPV6:2001:56a:f979:1f00:5e1c:4719:2f2b:297d? ([2001:56a:f979:1f00:5e1c:4719:2f2b:297d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946032b9sm25568885ad.116.2024.09.15.13.59.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 13:59:42 -0700 (PDT)
Message-ID: <b955ec60-081d-4194-8688-b49ff206ea1d@telus.net>
Date: Sun, 15 Sep 2024 14:59:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bob Gill <gillb5@telus.net>
Subject: 6.11.0 crash on X startup
To: linux-kernel@vger.kernel.org
References: <96030dde-6c02-4308-b41b-48aeeba670f3@telus.net>
Content-Language: en-US
In-Reply-To: <96030dde-6c02-4308-b41b-48aeeba670f3@telus.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

So 6.10.0 runs ok.  6.11.0-rc1 was the first kernel that started 
crashing.  Every rc after, including 6.11.0 all crash.

By that I mean it seems the startup is ok, but when it comes to the X 
server, when it tries to start, it crashes (and takes everything else 
along with it).

I ran recovery kernel, enabled networking, dropped into terminal.

service --status-all | grep lightdm gave:

[ - ]  lightdm

Portions of Xorg.0.log:

cat Xorg.0.log | grep EE

[    61.679] Current Operating System: Linux freedom 6.11.0 #1 SMP 
PREEMPT_DYNAMIC Sun Sep 15 13:10:55 MDT 2024 x86_64
     (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[    61.809] (EE) systemd-logind: failed to get session: PID 2028 does 
not belong to any known session
[    61.913] (EE) open /dev/dri/card0: No such file or directory
[    61.913] (EE) open /dev/dri/card0: No such file or directory
[    61.914] (EE) Unable to find a valid framebuffer device
[    61.914] (EE) open /dev/fb0: No such file or directory
[    61.914] (EE) Screen 0 deleted because of no matching config section.
[    61.914] (EE) Screen 0 deleted because of no matching config section.


 From the terminal, I can't run 'service lightdm start' and get back to 
any state.  pressing ctrl-alt-(f1-f9) does nothing. Pressing the 
caps-lock button on/off on the keyboard stops responding immediately.  
Even the power/reset buttons on the case do nothing.  I have to hit the 
power switch.  The kernel crashes hard.

My graphics hardware (taken from 6.10.0):

inxi -G

Graphics:
   Device-1: AMD driver: amdgpu v: kernel
   Device-2: Conexant Systems CX23887/8 PCIe Broadcast Audio and Video
     Decoder with 3D Comb
     driver: cx23885 v: 0.0.4
   Device-3: Razer USA Kiyo Pro type: USB driver: snd-usb-audio,uvcvideo
   Device-4: Realtek RTL2838 DVB-T type: USB driver: N/A
   Display: x11 server: X.Org v: 1.21.1.4 driver: X: loaded: amdgpu,ati
     unloaded: fbdev,modesetting,radeon,vesa gpu: amdgpu resolution:
     1: 1920x1080~60Hz 2: 1920x1080~60Hz
   OpenGL:
     renderer: AMD Radeon RX 6500 XT (navi24 LLVM 15.0.7 DRM 3.57 
6.10.0-rc7+)
     v: 4.6 Mesa 23.2.1-1ubuntu3.1~22.04.2


There is a weird line from /var/log/Xorg.0.log.old:

[   299.900] (++) using VT number 7

[   299.900] (II) systemd-logind: logind integration requires -keeptty 
and -keeptty was not provided, disabling logind integration
[   299.908] (--) PCI:*(4@0:0:0) 1002:743f:148c:2415 rev 193, Mem @ 
0xd0000000/268435456, 0xcfe00000/2097152, 0xfb700000/1048576, I/O @ 
0x0000a000/256, B
IOS @ 0x????????/131072
[   299.908] (--) PCI: (9@0:0:0) 14f1:8880:0070:7801 rev 15, Mem @ 
0xfbc00000/2097152
[   299.908] (II) LoadModule: "glx"

I don't know why the BIOS line looks like: BIOS @ 0x????????/131072

Is that normal or did it not find it?


Sure, its a corner case.  I might be the only one on the planet with 
this problem.  Or maybe not.

I have been using a standard .config for building kernels for a while 
now.  Please reply to me directly as I'm not on the list.

Bob






