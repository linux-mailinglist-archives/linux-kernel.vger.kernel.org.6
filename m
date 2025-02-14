Return-Path: <linux-kernel+bounces-514665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF8CA359E8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92E816E761
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C2622DFBB;
	Fri, 14 Feb 2025 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fu/mbDDq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C522CBF7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524296; cv=none; b=lly7SmiSeVsMt/E/LTGYoTNaIVByXbEGl30G/lTda0XA7hyZvEVOra+JP6HUSdqj0GhVbjaEwlg+hGtrRes3eUsRDodekKId9rlpMJG2vwmbY5AuplzGh8qHecHPPIF3DYJe+HSwEEcGPcScE89f8eTHldgcD2Qe5LyKtsM+J6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524296; c=relaxed/simple;
	bh=c79k5PqQMDOZXqP/gBJzcXzNmnr0cVO7VHBW+K2KDLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ma633wf7sq1RQyBwSZ+WfhdDAQ6Y6eyY1l63+8H4Rh7+dNny70yoAI3NFGwSguAerQyTXTmEFSElJnFmzdnSUYnmLetHYxHA/g4MxrEH0d+5q3u55tT4gHkPLGHkNR6FAzx2uqZCnzrRpeRUo3XIcKgPyeMNxTpHW5KQMicBaXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fu/mbDDq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739524291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tc1JWOShCi1X8A1xhO1+gcj4TkWCQ20kztsYnt5EtUI=;
	b=fu/mbDDqS0fihpAAB7CLrKqdPpvvHeuCiky/Um5onS9OH5y1Yh9NC885M5fFVHHPvNescP
	xV08hnxkWDLTiDM8H/UBWTDLNquLQMgQ3S50G6hSI9DLh2Osul++cfoN+obXwjsPctkpGv
	0Zu8uV8MnPbVGMfCCvqsQLjBKzCNwn0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-w-mRapdoNbaIesFNAK7qSg-1; Fri, 14 Feb 2025 04:11:27 -0500
X-MC-Unique: w-mRapdoNbaIesFNAK7qSg-1
X-Mimecast-MFC-AGG-ID: w-mRapdoNbaIesFNAK7qSg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43935bcec74so10464725e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524286; x=1740129086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc1JWOShCi1X8A1xhO1+gcj4TkWCQ20kztsYnt5EtUI=;
        b=ULmxMCVdYocrilwrnEIG5QIVES/pubaBHVS8H71WOgF0Wv0ycjKs/TtIJYmmFOH13I
         VV6LjTN7ef333xlTnQlipIgQovL1/wMMw79mrON8cnVmyky1B/hOPJu6JxG7T9FQX3Sx
         pA7/D5ngCJ2jL47jaNm9NZPcfJmAvp/Tv1N1PK0c5cMR6B/Fivkdr8RG59k6m9XjHh0J
         btkV2s8VLZRF7GU57xSJ/rd4nFWJJbOJqCwSILgVI45MP1MK2XkOFkJBR9MNjM0sNlaF
         dR3UFBGW9qQdLrqHTAjUgqJrJGlh9ZgzxXD5WOQU566NynWbqI0aRIiltnJEBMmrkSD+
         b7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXySBOrXi/UJWMMH8SZhnSbZ8417KW2K5Thi/RzxNPpIlnaYB6MzF60pHyn4WlZahGNWHxp8s4RIKXLXuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMf6PhR+qG3cIpsmFS35wD/Q7nFY0hbYiiIAF9j0kIUV3BKrlN
	G7dF0RoqQGvsx/JPgh57YGMWMEWR1HvZ+bePdTLp8tVO3owwEeHuBc24puygUsVPsSxbO34pbYY
	YmUsDN3BID0E4qRHU05FPQRkg8Ad78iT8wVnMkwzl5FAEx8qEUrhljJ4rxThaHQ==
X-Gm-Gg: ASbGncskqNjzhQrji8yI+vedmvGyl2WU/+X4bdjOPT4X8ksb3iNnGLqDU9fkSvGDvV9
	xMJRMVIqAsjBITz0Ydw1BtRSEv7BBsOmsHJJj0uf4IIV1iWR/zk+BjAVux9DeqYbL0JRnsxWss/
	Egqf6wy77Aw6j1h9j4I7K1OBkglgO2GvN8I9T4foSBn9R1jlrCINzENxBjjB1y/aHvOYTVsVZCy
	zZutgVF4bJoRszm1kzyGYOumygxmZs5mlXD6NbI9aNFrAcGCISVLTtsJ8yWjj8ZEukbyr/0o0bv
	e2XvPlS8yDpGXf8+73y5q2iB+1A/MSb2i4DGj37wWqO2
X-Received: by 2002:a05:600c:1c82:b0:439:5803:414f with SMTP id 5b1f17b1804b1-43959925af0mr124879115e9.5.1739524286280;
        Fri, 14 Feb 2025 01:11:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm8E96RB+m5k1Gt+SNihIV0fG42Jn/aA5AqyqoTBxngX/vsPEjKtSg1L/z2dEVb0ZzNTtCJw==
X-Received: by 2002:a05:600c:1c82:b0:439:5803:414f with SMTP id 5b1f17b1804b1-43959925af0mr124876945e9.5.1739524284504;
        Fri, 14 Feb 2025 01:11:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f208sm69679755e9.6.2025.02.14.01.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 01:11:24 -0800 (PST)
Message-ID: <cd7a9908-d4ba-45ca-a5cb-de8ac7ef72d0@redhat.com>
Date: Fri, 14 Feb 2025 10:11:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Include ASPEED ast-drm 1.15.1 video driver in kernel tree
To: Nicolas Baranger <nicolas.baranger@3xo.fr>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, airlied@redhat.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
References: <d507f6268ea3158b5af82b6860ca7b71@3xo.fr>
 <194c4656963debcf074d87e89ab1a829@3xo.fr>
 <b296bfef-1a9c-4452-baeb-09f86758addd@suse.de>
 <984c317de1027f5886390a65f1f66126@3xo.fr>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <984c317de1027f5886390a65f1f66126@3xo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/02/2025 10:27, Nicolas Baranger wrote:
> Dear Thomas
> 
> Thanks for answer and help.
> 
> Yes, due to .date total removal in linux 6.14 (https://github.com/ 
> torvalds/linux/commit/cb2e1c2136f71618142557ceca3a8802e87a44cd <https:// 
> github.com/torvalds/linux/commit/ 
> cb2e1c2136f71618142557ceca3a8802e87a44cd>) the last DKMS sources are :
> https://xba.soartist.net/ast-drm_nba_20250211/nba-dkms/ 
> nba_last_src_20250212/src/ <https://xba.soartist.net/ast- 
> drm_nba_20250211/nba-dkms/nba_last_src_20250212/src/>
> 
> You can also find this sources in directory drivers/gpu/drm/ast_new of 
> the tarball https://xba.soartist.net/ast-drm_nba_20250211/nba-kernel/ 
> linux-6.14.0.1-ast1.15.1-rc2_nba0_20250212.tar.gz <https:// 
> xba.soartist.net/ast-drm_nba_20250211/nba-kernel/linux-6.14.0.1- 
> ast1.15.1-rc2_nba0_20250212.tar.gz>
> 
> I'm surprised by the fact the in-kernel driver 0.1.0 is more advanced 
> than Aspeed version 1.15.1 because on my system it has very poor 
> rendering and is very slow, twinkle is high and had poor colors.
> The screen flickering is high and it's like if I was using a very old 
> cathode ray tube monitor (In fact I'm using a SAMSUNG LCD monitor which 
> is perfectly functionnal and which display a nice and eyes confortable 
> picture when using ast 1.15.1 driver or the video output of the Nvidia 
> GPU ).
> 
> 
> My testing system is a test Xeon server with an AST2400 BMC with its AST 
> VGA card as the main video output (to be able to have a screen on the 
> BMC KVM) +a discrete NVIDIA GPU I'm using for GPGPU and 3D rendering 
> with Nvidia prime render offload.
> What I constat with embed kernel driver 0.1.0 is that the Xeon processor 
> is doing the video job for example when watching a video, and it's not 
> the case with version 1.15.1 even when displaying on the AST VGA card a 
> vulkan rotating cube (compute by nvidia GPU with nvidia prime but 
> display by the AST VGA card of the AST2400).
> Note that with in-kernel version 0.1.0 it's nearly impossible to make 
> round the vulkan cube at more than half a round by  second where it's 
> working (very) fine for a 32MB video memory card with version 1.15.1 as 
> you can see in the video present in the online directory
> 
> I'm not developer or kernel developer so be sure that I wouldn't have 
> done all this work if the in-kernel ast version 0.1.0 was usable out-of- 
> the-box
> 
> Sure you can give me a patch I will test on this server (building 
> mainline+ast_new yesterday tooks 19 minutes on this server)
> 
> PS:
> here is a 'git diff linux-6.14.0.1-ast-rc2/drivers/gpu/drm/ast 
> linux-6.14.0.1-ast-rc2/drivers/gpu/drm/ast_new'
> https://xba.soartist.net/ast-drm_nba_20250211/nba-dump/ast- 
> fullpatch.patch <https://xba.soartist.net/ast-drm_nba_20250211/nba-dump/ 
> ast-fullpatch.patch>
> Diff is about 250+ kb so the 2 drivers seems to have nothing to do with 
> each others...
> 
> Thanks again for help
> 
> Kind regards
> Nicolas
> 
> 
> Le 2025-02-13 08:57, Thomas Zimmermann a écrit :
> 
>> Hi Nicolas
>>
>> Am 12.02.25 um 19:58 schrieb Nicolas Baranger:
>>> Dear maintener
>>
>> That's mostly me and Jocelyn.
>>
>>>
>>> I did include ast-drm driver version 1.15.1 (in replacement of 
>>> version 0.1.0) on the new mainline kernel too (6.14.0-rc2) and I 
>>> issue a new dkms patch
>>>
>>> Last DKMS patch had been sucessfully tested on mainline.
>>> And last ast.ko version 1.15.1 included in linux tree had also been 
>>> sucessfully tested
>>>
>>> Online directory is updated with :
>>> - new DKMS patch
>>> - new DKMS srouces
>>> - new DKMS debian package
>>> - new tarball of mainline included ast_new ported in kernel tree
>>> - new kernel debian package (mainline with ast_new)
>>>
>>>
>>> NB: online directory is here: https://xba.soartist.net/ast- 
>>> drm_nba_20250211/ <https://xba.soartist.net/ast-drm_nba_20250211/>
>>>
>>> Please let me know what I should do to see this change in linux-next
>>
>> I'm having a little trouble with figuring out which of the many driver 
>> sources is the relevant one. Am I correct to assume it's the one at
>>
>> https://xba.soartist.net/ast-drm_nba_20250211/nba-dkms/ 
>> nba_last_src_20250212/src/ <https://xba.soartist.net/ast- 
>> drm_nba_20250211/nba-dkms/nba_last_src_20250212/src/>
>>
>>
>> About that driver: Although the official driver reports an ancient 
>> version number, it is an up-to-date driver. It is actually more up-to- 
>> date than Aspeed's package. Both drivers share source code and a few 
>> years ago there was an effort to bring the kernel's driver up to the 
>> same feature set. Since then, the kernel's driver has been updated, 
>> reworked and improved.
>>
>> About the performance: From what I can tell, the only significant 
>> difference in these drivers is memory management. Your ast_new driver 
>> uses an older algorithm that we replaced quite a few releases ago. The 
>> old version was unreliable on systems with little video memory, so we 
>> had to replace it.  I don't know why the new code should be slower though.

Regarding the performances of ast driver, I remember doing profiling 
some times ago, and when running glxgears (with llvmpipe), 65% of the 
CPU time was wasted in page fault 
(https://elixir.bootlin.com/linux/v6.13.2/source/drivers/gpu/drm/drm_gem_shmem_helper.c#L534)
But as this driver is mostly used for console/basic desktop usage, I 
didn't investigate more.

If I remember correctly, the switch to shmem, is because some devices 
have only 16MB of memory, and 1920x1200x32bits takes ~9MB, so it's not 
possible to have double buffering in this case. (And this is required by 
most desktop environment).

The switch to shmem was done with "f2fa5a99ca81c drm/ast: Convert ast to 
SHMEM", and introduced in v6.2. So maybe if you can try with a v6.1 
kernel, using the built-in ast driver and report if it has better 
performances.

Best regards,

-- 

Jocelyn

>>
>> If I give you a patch against a recent Linux kernel, are you capable 
>> of building the patched kernel and testing that change on your system?
>>
>> Best regards
>> Thomas
>>
>>
>>>
>>> Thanks for help
>>>
>>> Kind regards
>>> Nicolas Baranger
>>>
>>>
>>> Le 2025-02-11 19:15, Nicolas Baranger a écrit :
>>>
>>>> Dear maintener
>>>>
>>>> For my own usage, I did make work the ASPEED ast-drm 1.15.1 video 
>>>> driver on mainline kernel (6.13.0 + 6.13.1).
>>>>
>>>> ASPEED video driver is availiable here:
>>>> https://www.aspeedtech.com/file/support/Linux_DRM_1.15.1_4.tar.gz 
>>>> <https://www.aspeedtech.com/file/support/Linux_DRM_1.15.1_4.tar.gz>
>>>>
>>>> But it only work for LTS kernel
>>>> So I modify the DKMS package and I build a new Debian DKMS package 
>>>> with the adapted  source.
>>>> My patch can be find here :
>>>> https://xba.soartist.net/ast-drm_nba_20250211/nba-dkms/astdiff.patch 
>>>> <https://xba.soartist.net/ast-drm_nba_20250211/nba-dkms/astdiff.patch>
>>>> See the README:
>>>> https://xba.soartist.net/ast-drm_nba_20250211/nba-dkms/README 
>>>> <https://xba.soartist.net/ast-drm_nba_20250211/nba-dkms/README>
>>>>
>>>> Using this new 'ast 1.15.1' driver, performance are amazing compared 
>>>> to the 'ast' driver include in kernel tree, specially when using a 
>>>> discrete GPU and offloading VULKAN / 3D on it but using AST VGA card 
>>>> as the main video card and as the main and only video output (the 
>>>> discrete GPU is used only for offloading 3D or for cuda/opencl)
>>>>
>>>> So to make things easier, I include the new 'ast 1.15.1' driver in 
>>>> kernel tree as AST_NEW : linux-6.13.1-ast/drivers/gpu/drm/ast_new'
>>>> It's working fine as you can see on this video :
>>>> https://xba.soartist.net/ast-drm_nba_20250211/ 
>>>> vulcan_nvidia_prime_render_offload_on_ast_vga_card.webm <https:// 
>>>> xba.soartist.net/ast-drm_nba_20250211/ 
>>>> vulcan_nvidia_prime_render_offload_on_ast_vga_card.webm> I upload 
>>>> all the work I've done here :
>>>> https://xba.soartist.net/ast-drm_nba_20250211/ <https:// 
>>>> xba.soartist.net/ast-drm_nba_20250211/>
>>>>
>>>> See the global README :
>>>> https://xba.soartist.net/ast-drm_nba_20250211/README <https:// 
>>>> xba.soartist.net/ast-drm_nba_20250211/README>
>>>>
>>>> and the README in nba-kernel sub-directory :
>>>> https://xba.soartist.net/ast-drm_nba_20250211/nba-kernel/README 
>>>> <https://xba.soartist.net/ast-drm_nba_20250211/nba-kernel/README>
>>>>
>>>> I'm not a developer so please let me know if I made the things the 
>>>> right way and if this new 'ast 1.15.1' driver can be ported to 
>>>> linux-next or linux-? ?
>>>> If you need more explanations, do not hesitate to contact me, I 
>>>> would be happy to help
>>>>
>>>> Kind regards
>>>> Nicolas Baranger


