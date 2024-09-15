Return-Path: <linux-kernel+bounces-330033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F350A9798B4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 22:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704881F21A4F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 20:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2012F1EA87;
	Sun, 15 Sep 2024 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFTuwjV4"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E61B85CD
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726432278; cv=none; b=CkYGHwGhVZpbYbjpO3xGGETvsucNZxmTWU4zg6Qo0UdbZXeL10SDeLLLQQEq553M9zdIL1hm2MRdbPuZzgOILNRANTn2lWsjpXWgHKJLgmCwLaZ/V10MDRg6OcLpmCpd+s3sk44D/9jNv/r+onyrfWMl8oWMOarKqu9/na1NnA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726432278; c=relaxed/simple;
	bh=+Fcf2jmTn8eiYUCV3wpa3tQIjMhhPTaWSmxDK/CFc9o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=n9b4g4iPsK9+kuLJzAdSo57KArdjNEQf8/gECP7LgunDdJq9W7hbbudIYw9Sst0KQ5DDp9khP0kSRjdM/9XgDhNJYWeFBiSqvyUX2yCArn5nWUUnIBB/Otp+sn5u6uwft2bEeT+S1oV3Y6sDhWdlg5tZuNkiBSnbDNCLMszhJtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFTuwjV4; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-49be3d534ffso1188859137.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 13:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726432276; x=1727037076; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hAYZQWw2HWWFjLpbJ1p/0HLGKECZhCFOlFWY0I17SDI=;
        b=RFTuwjV4X6KVnPp/++N8HmQH8cyytkbyafADbVj2NWqEVCui7yC1zZel9YS1sgqSUz
         Rgh3AyDh0fro6fxkMyoF5hNfglf9WdmnSVzuQ7qWHrbN/8oULBPXM41PkYdwJOmQ6pDk
         m6srh0WqTZC8PhGKToiX+NDAsm2pm6BK3aHWUYfZzdeKzDXKiQe/prvCk83R81xFQ1nK
         Fo1wGY24Owcy/RAVclwAlzzvKwwFKuvfC+H4U9LQ3HfzyVNwj6cMGaPlgPi+NYGY6obg
         iunfAI3rATADA9eS2gDGTsByQk9XVQgWzX1wjmUYQu/rBpvm+lZ9v/7rogSBACox0Kl7
         YEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726432276; x=1727037076;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hAYZQWw2HWWFjLpbJ1p/0HLGKECZhCFOlFWY0I17SDI=;
        b=L8Gyn90brxSWM865mM4LnwBClEA7D6YuUW7BCm7eAoF71eqztBF/r0j5WnZOZRH1rD
         yvemqNbtp1jweX4dyC6Iyoj6plnzHJnT5ryunvsdvgZXoJhCpzGRe3VSrZO6TD4JI5md
         RmWDrJ4ANWkaKc3yZZXP4BXzkn+HKlyEhqzgvy2VTb9Y4IP+vKq+pyVRYB4AZ1EQ3wI5
         BdqRElk1XRVLgJiQlKdLoPZTgt2BDG/xUXjLooiWF6o+Cs3CamoaInmymc2WT/ykrb0E
         q42UrKTRkoNQ7ln9Qk8ndP/Ifr3GZm9YLNpSPtVeWwEMdCanqnPawRx1fUtnUX+Fpj2X
         K9Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVnfhpD7gVUxGpnVl8wl2pMBYldEnG2ZWXDfIRweDNVh9V1pxtvVyjjP7oIQWPb3wZodpsjA7Nt0hJk0eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4luNF6vV/i7JFDEEhCK/OAYAmUqnlLT3t2aiE+4e8Bkmn4E8n
	jMzenwZwPsIMVQWm+hv7Ri4g97lj7WHBPfKK0+WFcaWWFy7GU51+eJrlit1g7EgsZPF/svogbtb
	LIeCb8rchH+uFy7GlyJZwbBio/XY=
X-Google-Smtp-Source: AGHT+IHkL+Fo29ENavizDkxBSHVbm5AxIaQ/IPFYlxQc47hbs0WOkM73B9jK2Vn7Gni7WkxT1w/aQziQGBzOWSnFhTE=
X-Received: by 2002:a05:6102:f0d:b0:49b:f255:1779 with SMTP id
 ada2fe7eead31-49d41479c01mr10368014137.12.1726432275602; Sun, 15 Sep 2024
 13:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sitsofe Wheeler <sitsofe@gmail.com>
Date: Sun, 15 Sep 2024 21:30:49 +0100
Message-ID: <CALjAwxidmwCT5ZwbZRhf9GwshYbzQZ4N8K3B8KGLi5DnRzj8wQ@mail.gmail.com>
Subject: Kernel hang when amdgpu driver is loaded on old radeon card
To: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

(Apologies if I have CC'd the wrong people/places - I just went by
what get_maintainer.pl -f drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
said)

I recently upgraded from Ubuntu 20.04 (5.15.0-119.129~20.04.1-generic
kernel) to Ubuntu 24.04 (6.8.0-44-generic kernel) and found that while
booting the kernel hangs for around 15 seconds just before the amdgpu
driver is loaded:

[    4.459519] radeon 0000:01:05.0: [drm] Cannot find any crtc or sizes
[    4.460118] probe of 0000:01:05.0 returned 0 after 902266 usecs
[    4.460184] initcall radeon_module_init+0x0/0xff0 [radeon] returned
0 after 902473 usecs
[    4.465797] calling  drm_buddy_module_init+0x0/0xff0 [drm_buddy] @ 122
[    4.465853] initcall drm_buddy_module_init+0x0/0xff0 [drm_buddy]
returned 0 after 29 usecs
[    4.469419] radeon 0000:01:05.0: [drm] Cannot find any crtc or sizes
[    4.473831] calling  drm_sched_fence_slab_init+0x0/0xff0 [gpu_sched] @ 122
[    4.473892] initcall drm_sched_fence_slab_init+0x0/0xff0
[gpu_sched] returned 0 after 31 usecs
[   18.724442] calling  amdgpu_init+0x0/0xff0 [amdgpu] @ 122
[   18.726303] [drm] amdgpu kernel modesetting enabled.
[   18.726576] amdgpu: Virtual CRAT table created for CPU
[   18.726609] amdgpu: Topology: Add CPU node
[   18.726787] initcall amdgpu_init+0x0/0xff0 [amdgpu] returned 0
after 528 usecs

I've checked and the problem still exists in 6.11.0-061100rc7-generic
(which is close to vanilla upstream).

The graphics card I have is:
01:05.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] RS880M [Mobility Radeon HD 4225/4250] (prog-if 00 [VGA
controller])
01:05.0 0300: 1002:9712 (prog-if 00 [VGA controller])
Subsystem: 103c:1609

At first I thought the problem was related to the change
https://github.com/torvalds/linux/commit/eb4fd29afd4aa1c98d882800ceeee7d1f5262803
("drm/amdgpu: bind to any 0x1002 PCI diplay [sic] class device") which
now means my card is claimed by two drivers (radeon and amdgpu). That
change complicated things because:
- The amdgpu module and its dependencies remain permanently present (which
  never used to happen)
- It took some time for me to realise that the amdgpu driver hadn't suddenly
  grown the ability to support this old card :-) There is a nice table on
  https://www.x.org/wiki/RadeonFeature/#decoderringforengineeringvsmarketingnames
  that shows it is part of the R600 family and
  https://www.x.org/wiki/RadeonFeature/#featurematrixforfreeradeondrivers shows
  that R600 is only supported by the radeon driver.

However, testing a 5.16.20-051620-generic kernel showed that while the
amdgpu module is loaded, there is no 15 second hang... So far my
testing has the following results:
- 5.16.20-051620-generic - amdgpu loaded, no hang
- 5.18.19-051819-generic - amdgpu loaded, no hang
- 6.0.0-060000-generic - amdgpu loaded, hang
- 6.2.0-060200-generic - amdgpu loaded, hang
- 6.8.0-44-generic - amdgpu loaded, hang
- 6.11.0-061100rc7-generic - amdgpu loaded, hang

To work around the problem I've taken to blacklisting amdgpu in
/etc/modprobe.d/ which makes the hang disappear.

Does anyone else see this issue? Is there something better than my
current workaround? What do other drivers that want to bind to such a
large set of devices do? Further, while I'm already using
initcall_debug, is there any other kernel boot parameter to make
what's happening more visible?

--
Sitsofe

