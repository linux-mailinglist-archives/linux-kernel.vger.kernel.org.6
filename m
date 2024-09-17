Return-Path: <linux-kernel+bounces-332089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED6197B552
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 23:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA361C23135
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 21:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1C51917E6;
	Tue, 17 Sep 2024 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdlWoAP/"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB82AEEE
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726609423; cv=none; b=s3UNqJL6yfDfAH3AiuCVq2sY73eDbF8DcrcNQUpocKwUwE03bLLrozcCCGZuCfScB8Q9NagoqVLDwJwTks3d5QeY0d9qa/X7rWdMYJ29mojWbemmH8v+lDx+okouGf/cJJJWspvfRNkSNbeza+UPC9DWWxCaOi124eDXHfwoyY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726609423; c=relaxed/simple;
	bh=6FTgbI7ljH8iHxY7NhOBagAiHjfuKFcdGgS8ddqN4ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+fclzQ4io9AMGEcgREa6KvMB9kaig+88cnSYXHs807bZNQ5LczhdIdPoujBGOPTuhuZzoN7QXxa6ZClOwKdihwK4YF8J6Hk6NZ83ZODUL/lapA/uslKEbBg7k5Zb20uIli4TkVi6aOLi/E8hK9zq5Uabr+/LKqXqGRCbotFxzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdlWoAP/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-717880daae7so768948b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 14:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726609420; x=1727214220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJQxiek1sqcvJHX5DqbudjsXRtWsNh8pviYM7nr6zLw=;
        b=cdlWoAP/aDU9wVNfgNeIz61U6crC6C/mmUzfLGHHtA5FO2WRmmQAAHDBNJ5UngpmQR
         T6s0KkVRqZ7eq1DxI/Q0yEl8FPSMcVDQ3bDF0xl+97oh1eHj+FKM9phttCNT6218uxq5
         E+y9fBDIQYB+i05VObdSUKblcnZltzR6RBh4BvrCDbCVALe7X1nFELa+GKQl5LF2mMCx
         3a6sK/RCcpRzyjDtWKMb40zPeSr6e/Sy7SjJGRuI/QY+xEN5HpEJuKPyc5LgNgBhL6FF
         IZHccuxljZ/KBFwm3LBM/23YQ7CFmLcy5/xxQgX4yQDvzEumPMEJDpFzc3aqdYYyeiq/
         eo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726609420; x=1727214220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJQxiek1sqcvJHX5DqbudjsXRtWsNh8pviYM7nr6zLw=;
        b=FD1xN0AN6wgvxneJZ7J5iqTntP0R75N8ypYXClzsVr8jZ7X7jmatb4OO3944Etlc31
         ld2uoJa8Za4MQH1NMGd42aMXRH9VjIuCr57Wtjol25DzlJec67fxx1iAyoonuJkX9C2U
         j5nmeKdBGy2TTilfRKm0Ro3US3Twlb7nBER72axs9hrsWsiBHLpfo7d8t6W6L6RtSe6c
         D7KMfR8Uo1nKYDT9w1YEmFexiBNjdcIztFFBYmcspAVdX8IvB5A8J5bfEMp2/k4cU2VI
         ERH+FM9zOboxB0kFDtfusIiyTanjGz2yt/veY21BKkXgPja9G8+MSwwlUX71vOsQT5ae
         F9SA==
X-Forwarded-Encrypted: i=1; AJvYcCXs2RmRuiFdURm3ak+Ea+BTNYSqUByD86L5hJP6uUy64eL66swuZmZbFv330rhAg+dJcueWKD5UkwxTiDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgX0R4H9aJjKz7sLEwmUJy4F3bXaMYVtmK0gE8vJ/I198aecMp
	bZ7Iw3oq2qce/te8SeMyH7QeYLsLWdyiuhCPeIogDI9nGcdkUfcinS59/ZfDuMX9yMDf9lzCejF
	AYbH1MqnBrkGdbojOZmpOL99JUwc=
X-Google-Smtp-Source: AGHT+IEsXGCscBSTzIZVFtTph5eEx9lv5jv9JkQZOd19AaH9N95Zw/Y9F1oQohL0rT+gFkpUIK4JksVk3CM0ErG+xqk=
X-Received: by 2002:a05:6a20:3d8f:b0:1cf:4845:67f with SMTP id
 adf61e73a8af0-1cf76233425mr12955383637.9.1726609420351; Tue, 17 Sep 2024
 14:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALjAwxidmwCT5ZwbZRhf9GwshYbzQZ4N8K3B8KGLi5DnRzj8wQ@mail.gmail.com>
In-Reply-To: <CALjAwxidmwCT5ZwbZRhf9GwshYbzQZ4N8K3B8KGLi5DnRzj8wQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Sep 2024 17:43:27 -0400
Message-ID: <CADnq5_ODjqwMS8WNbjdMq++YU3XeVtEEn=KnyoWOzdddyyUw0g@mail.gmail.com>
Subject: Re: Kernel hang when amdgpu driver is loaded on old radeon card
To: Sitsofe Wheeler <sitsofe@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 5:28=E2=80=AFPM Sitsofe Wheeler <sitsofe@gmail.com>=
 wrote:
>
> Hello,
>
> (Apologies if I have CC'd the wrong people/places - I just went by
> what get_maintainer.pl -f drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> said)
>
> I recently upgraded from Ubuntu 20.04 (5.15.0-119.129~20.04.1-generic
> kernel) to Ubuntu 24.04 (6.8.0-44-generic kernel) and found that while
> booting the kernel hangs for around 15 seconds just before the amdgpu
> driver is loaded:
>
> [    4.459519] radeon 0000:01:05.0: [drm] Cannot find any crtc or sizes
> [    4.460118] probe of 0000:01:05.0 returned 0 after 902266 usecs
> [    4.460184] initcall radeon_module_init+0x0/0xff0 [radeon] returned
> 0 after 902473 usecs
> [    4.465797] calling  drm_buddy_module_init+0x0/0xff0 [drm_buddy] @ 122
> [    4.465853] initcall drm_buddy_module_init+0x0/0xff0 [drm_buddy]
> returned 0 after 29 usecs
> [    4.469419] radeon 0000:01:05.0: [drm] Cannot find any crtc or sizes
> [    4.473831] calling  drm_sched_fence_slab_init+0x0/0xff0 [gpu_sched] @=
 122
> [    4.473892] initcall drm_sched_fence_slab_init+0x0/0xff0
> [gpu_sched] returned 0 after 31 usecs
> [   18.724442] calling  amdgpu_init+0x0/0xff0 [amdgpu] @ 122
> [   18.726303] [drm] amdgpu kernel modesetting enabled.
> [   18.726576] amdgpu: Virtual CRAT table created for CPU
> [   18.726609] amdgpu: Topology: Add CPU node
> [   18.726787] initcall amdgpu_init+0x0/0xff0 [amdgpu] returned 0
> after 528 usecs
>
> I've checked and the problem still exists in 6.11.0-061100rc7-generic
> (which is close to vanilla upstream).
>
> The graphics card I have is:
> 01:05.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] RS880M [Mobility Radeon HD 4225/4250] (prog-if 00 [VGA
> controller])
> 01:05.0 0300: 1002:9712 (prog-if 00 [VGA controller])
> Subsystem: 103c:1609
>
> At first I thought the problem was related to the change
> https://github.com/torvalds/linux/commit/eb4fd29afd4aa1c98d882800ceeee7d1=
f5262803
> ("drm/amdgpu: bind to any 0x1002 PCI diplay [sic] class device") which
> now means my card is claimed by two drivers (radeon and amdgpu). That
> change complicated things because:
> - The amdgpu module and its dependencies remain permanently present (whic=
h
>   never used to happen)
> - It took some time for me to realise that the amdgpu driver hadn't sudde=
nly
>   grown the ability to support this old card :-) There is a nice table on
>   https://www.x.org/wiki/RadeonFeature/#decoderringforengineeringvsmarket=
ingnames
>   that shows it is part of the R600 family and
>   https://www.x.org/wiki/RadeonFeature/#featurematrixforfreeradeondrivers=
 shows
>   that R600 is only supported by the radeon driver.
>
> However, testing a 5.16.20-051620-generic kernel showed that while the
> amdgpu module is loaded, there is no 15 second hang... So far my
> testing has the following results:
> - 5.16.20-051620-generic - amdgpu loaded, no hang
> - 5.18.19-051819-generic - amdgpu loaded, no hang
> - 6.0.0-060000-generic - amdgpu loaded, hang
> - 6.2.0-060200-generic - amdgpu loaded, hang
> - 6.8.0-44-generic - amdgpu loaded, hang
> - 6.11.0-061100rc7-generic - amdgpu loaded, hang
>
> To work around the problem I've taken to blacklisting amdgpu in
> /etc/modprobe.d/ which makes the hang disappear.
>
> Does anyone else see this issue? Is there something better than my
> current workaround? What do other drivers that want to bind to such a
> large set of devices do? Further, while I'm already using
> initcall_debug, is there any other kernel boot parameter to make
> what's happening more visible?

Do you have secureboot enabled?  If so, perhaps this is relevant:
https://bugzilla.kernel.org/show_bug.cgi?id=3D219229

Alex

>
> --
> Sitsofe

