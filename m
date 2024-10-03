Return-Path: <linux-kernel+bounces-348870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5E198ECE6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8E12826BB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDA914A099;
	Thu,  3 Oct 2024 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="N1gtCM1h"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF1A92F
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727951169; cv=none; b=SnDVB/Go1PVU9ZnW6pFp9Xt97ku8kowNNWb9PueNIK8QTXxV31gf/UfMiukSSdaeXQgMGxGDrc2QMGQ4Czzf8Wl8iW8jkNON5oI28Rek9r1RPyDJnMqVqP5RWklJ3raC3KWgM80zSKY/WtOE/S/4wh8rxidwZmD4DtRF+7A5E+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727951169; c=relaxed/simple;
	bh=ytCTx/RCYfpjqtZIBLZ0tOgMGE3BIRN5CXuluZeEuHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+6VRoW442x87UMgScRjJRVLe38aVZgrsTmmIM73WEEllQOMD71G6PEcYv+uTE6YR9JM1F+ujgDnHcMALi1Q8bK/7XlqQbgDnVg4n92BUwXPOZ1b2fqtPxkP/o8MJlJq3HQYLsZQd6fCNAMtAMiEpgU9Lb54lsXIYww9A8A1gbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=N1gtCM1h; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e25e4023cafso579417276.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 03:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1727951166; x=1728555966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjyuhCfqNCFRAbzuCuRzaWP0WNjSayZ0FhFg02rgmIM=;
        b=N1gtCM1h7/Br+6aoigUnySNPARvX8gAQ18u5dnrmxISnE6Cl8+u6+CeDAvUS/A23hY
         ZGKTckKHEkq4385UjrkhsuhjSlWTB32cjPI+L3k3vdk3o3hhm7e0hZ71obnvGAP3IYZY
         BpwswmJqtyz6VnEDwxDCgt2AHB94xxKDORhkzKylhjv4rLlMzrNBUx9MpobWkqD5lPNf
         GhqtmBvfvbTWNZueIVKlS5neRLkmgve/GtmpSoK902zQ/rirDRvzTqk5PalByLi1sXu4
         BMbdHIJ3bhnaMbGdgnpM0NW6vkbreFojWexCT9kz++nNM8hbnGrgR5EPAg+9S9Gu0Rtg
         jgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727951166; x=1728555966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjyuhCfqNCFRAbzuCuRzaWP0WNjSayZ0FhFg02rgmIM=;
        b=RQuBy34VKrujb+HonpwM3wQxx/mFPIIi5NMxfKSEEHgVFwoi/TaW7HOLMSO1sh2fel
         riXJTM/ZQrUmyDI5tz7PxhktGEUjvB6J1W1pqejaMkmGj8hZc2CTm/p3caOZOhxph4n2
         UoEPymQ+t1ulMQAdVk9oTWoLvCog99QOTnez38M6oNE1onbdb3sMl4FTSeanutWQsujr
         dsVEgyqcPRTisrZpzk17vzSFTmRT+xfCajbFwOFCU8sxlPZ40Y5u/jGNXv2bBiLfszyb
         X1dMER5xpOrH1jm/ADHXLkIUnD7JZZ8Tdsgou4jeEVmYu66ILyZW5MHB8ATqkRBN6nHh
         /xDg==
X-Forwarded-Encrypted: i=1; AJvYcCUB+COtMSIpWaNPz5JiChLHy3DkGWUv1NfQTfOZxbw7R+4AsEQ13SkBfLuumYdzsFqZtGp0ewuWlq2XH3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZKTZtxUUqYlwniUW+RdiXy11it6C7bH5o3Qcn55I6a7XCcvIq
	LndhQKxd5Wi+O2n0mOO5hrYBHsEwCms/0HgPTOqL/sMl0BR3KzW1neSqlJV5WFYax2VKj6B7udp
	M0JG0rviSh9DqQqo/ZXE1Mx8zX+No/l/F8sFLpg==
X-Google-Smtp-Source: AGHT+IF91Uitc/DAZxzVTKwWvm+H/TQmZ+9+FE15zjSLiCFHyvLNGfUeQlUaYYS9JzDhqSID1kuQsEOYvsgV9VR/QlI=
X-Received: by 2002:a05:6902:200f:b0:e1d:2e05:1958 with SMTP id
 3f1490d57ef6-e263841538emr4320294276.46.1727951166045; Thu, 03 Oct 2024
 03:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241003092859eucas1p1b9706a1e0a4ae23b490ae0f1c3c1d32d@eucas1p1.samsung.com>
 <20241003092826.1942901-1-m.szyprowski@samsung.com>
In-Reply-To: <20241003092826.1942901-1-m.szyprowski@samsung.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 3 Oct 2024 11:25:49 +0100
Message-ID: <CAPY8ntDcbx_7HayDV7Jwa+rfCiDjecAGr5BNdiSKi7Y3i9yuog@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm: Two fixes for the 'Provide client setup helper
 and convert drivers' patchset
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marek

On Thu, 3 Oct 2024 at 10:29, Marek Szyprowski <m.szyprowski@samsung.com> wr=
ote:
>
> Dear All,
>
> Yesterday the "drm: Provide client setup helper and convert drivers"
> patchset [1] landed in linux-next. In my tests I found that it causes ker=
nel
> NULL pointer dereference on ARM/ARM64 based Raspberry Pi4B boards. It
> turned out that the conversion of the VC4 DRM driver is a bit incomplete,
> so I've decided to provide the needed fix. While developping it I've
> found that a small fix to generic drm/fbdev-helper helps to avoid NULL
> pointer dereference in the future in case of similar problems.

This duplicates the patches I sent yesterday -
https://lists.freedesktop.org/archives/dri-devel/2024-October/472428.html

I chose EINVAL instead of ENODEV for the return value if neither probe
function was defined - I don't know which is better/preferred.

  Dave

> Those patches fixes the following problem observed on Raspberry Pi4B
> boards:
>
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
020 when write
> [00000020] *pgd=3D00000000
> Internal error: Oops: 805 [#1] SMP ARM
> Modules linked in: aes_arm aes_generic cmac brcmfmac_wcc brcmfmac brcmuti=
l sha256_generic libsha256 sha256_arm cfg80211 hci_uart btbcm crc32_arm_ce =
raspberrypi_hwmon bluetooth ecdh_generic vc4 ecc libaes snd_soc_hdmi_codec =
snd_soc_core ac97_bus snd_pcm_dmaengine snd_pcm v3d bcm2711_thermal snd_tim=
er genet drm_shmem_helper snd gpu_sched soundcore drm_dma_helper
> CPU: 1 UID: 0 PID: 21 Comm: kworker/1:0 Not tainted 6.12.0-rc1-next-20241=
002 #15363
> Hardware name: BCM2711
> Workqueue: events output_poll_execute
> PC is at __drm_fb_helper_initial_config_and_unlock+0x30c/0x518
> LR is at __drm_fb_helper_initial_config_and_unlock+0x26c/0x518
> pc : [<c0aec770>]    lr : [<c0aec6d0>]    psr: 60000013
> ...
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5383d  Table: 04ef006a  DAC: 00000051
> ...
> Register r12 information: slab task_struct start c213c400 pointer offset =
0 size 2176
> Process kworker/1:0 (pid: 21, stack limit =3D 0x98a73703)
> Stack: (0xf0879e28 to 0xf087a000)
> ...
> Call trace:
>  __drm_fb_helper_initial_config_and_unlock from drm_client_dev_hotplug+0x=
ac/0x104
>  drm_client_dev_hotplug from output_poll_execute+0x298/0x2a0
>  output_poll_execute from process_one_work+0x178/0x3c0
>  process_one_work from worker_thread+0x270/0x42c
>  worker_thread from kthread+0xe0/0xfc
>  kthread from ret_from_fork+0x14/0x28
> Exception stack(0xf0879fb0 to 0xf0879ff8)
> 9fa0:                                     00000000 00000000 00000000 0000=
0000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> Code: e30a3724 e5942038 e34c3186 e8b30003 (e5820020)
> ---[ end trace 0000000000000000 ]---
>
> [1] https://patchwork.freedesktop.org/series/137389/
>
> Best regards
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
>
> Patch summary:
>
> Marek Szyprowski (2):
>   drm/fbdev-helper: fail if driver provides no fbdev/fb probe functions
>   drm/vc4: Provides DRM_FBDEV_DMA_DRIVER_OPS also for vc5_drm_driver
>
>  drivers/gpu/drm/drm_fb_helper.c | 3 +++
>  drivers/gpu/drm/vc4/vc4_drv.c   | 1 +
>  2 files changed, 4 insertions(+)
>
> --
> 2.34.1
>

