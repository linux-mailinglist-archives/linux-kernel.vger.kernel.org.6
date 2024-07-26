Return-Path: <linux-kernel+bounces-262941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED56A93CEE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4695282743
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2242A176258;
	Fri, 26 Jul 2024 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="R33Nxm+/"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0F92B9B8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979378; cv=none; b=NNm1NPQCqevoem6nnszPu3SwBRoV6NM2wBEK5jP3zblrOkJd1OJrw9e66BWtltkVPyfHktVFMpYgTjqxCEioqCln9sD6PBvdvQpE+mRicX1Bjxgj1W5AJgPRKaHQ0L+gV17/MIhm7f0/3irlsnG4sEQmAhekEECKiKbnmzXSF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979378; c=relaxed/simple;
	bh=f/4r9O0pieUzy+BI7oN946jYQ3kRH1Ye9O+pmbrYIG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7eHah2fkxGNpMbQjtTiWGNN/hTSE5Frj4mvrk8EFbLIX4fjw4fMICQkKt8FmaS+QPsMFkmqdsdoV14nX/SHQe6JwlpljWZF3Xh2eEx10RkENX0K3fOS1SEPep4erHwdMqUYUzXFIdSWXjJsRTIQChqrsqbPyoLD4Uh8oIZ/3iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=R33Nxm+/; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b7acf213a3so1855466d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1721979375; x=1722584175; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1TPKPX97TTgh+bMeyaRqhyTEqJldy/1yPCfnocQWuqg=;
        b=R33Nxm+/rJsBE3Qpo5Kz+FOQb8te/Z/ktpCMkGUhbtApoiX/V8l8zAN8CHeT6OVe5H
         ImKM6HyPv46ovnkuoaGPz4YPMtcEPzgM4zFCAY+DP5yMKcwRZENL9qJadvRe9PLpFa71
         jFNyNsl1WJKnsZJ7H7S38xkTcwHIgJHFocOBUME8vlogEo64npBjUDu5VQaRLEMo9u2I
         IOYaA80gQslaIqWw82XwOGigiOBvnIybVJxg6W7vsVAurudis+Hx0/gYnfpkOnf8Mj/2
         tLsx0fKKUDwHx3FDgQPJt0fwJOIg+sqzg6r5RkR5yAaTdZFmy/5/a6emhQQvFUUUUGkU
         rRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721979375; x=1722584175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TPKPX97TTgh+bMeyaRqhyTEqJldy/1yPCfnocQWuqg=;
        b=Ufl0xQ4GtIIGtJJb3hUbjG4L4udhTSD0ZS9GukgXgWcwmUzeK7S1Yt+VzfZ5tnYCJv
         5WlD2grzW3fbNB3KWLj0IvfCfrbiDhv+doqQVhgHkr/s8q97p0sWLo6rjXJ56CKiSCJK
         LVUvciE28X9oes7y56eSaOgZmSe9irTgvZQfk8duk4OtuQYNSH/nAkMhxH+/kLxuro7i
         nQN5YFPCey0TSdtEn3IEMgf6648e4a1u+YYQ4EdFwpz36D3IZTA/Z6rpxowYKbulfqBM
         3IKFuU4RI2APx3H5K6TTgnIlxtRWXdu9/l8berV9Bj+/F03oihJG2EZmOBxMfYovbiPW
         Nu6g==
X-Forwarded-Encrypted: i=1; AJvYcCVCookuv1uzsPZmPC5P45eFn6JBlBSO3BkEWw95PTXjifILooADyj5u9YyeuqxjznH3++5cp+MEvFKy1op45gNki6bYIyQU9OVV5NS5
X-Gm-Message-State: AOJu0Yys9Bwc8ZnxkKsXlY9l9BjeZ7edwRqp1cMZSV1Y+theGEf96UhG
	bThrg0h3Fs959Qbe7IXR+1b6ZnsdVTVDrG4YZ+9gevsRTIH78eVSCj2IPOdkYosskvFcuzs4XwV
	+ZxGHDxlRhca/zNV73qVo26iED3W1WGMKVjdMUA==
X-Google-Smtp-Source: AGHT+IGGlYtpl5CnwGzsbFku57FVU+vQWQg6UYr2oNR/eVitvY8vea0qGTJakNZeMiN0ELTqnJHGNHAzrUdeSPuNRfE=
X-Received: by 2002:ad4:5b8f:0:b0:6b2:dd54:b634 with SMTP id
 6a1803df08f44-6bb40894335mr53497916d6.39.1721979375321; Fri, 26 Jul 2024
 00:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724101015.523535-1-vignesh.raman@collabora.com> <20240724101015.523535-6-vignesh.raman@collabora.com>
In-Reply-To: <20240724101015.523535-6-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 26 Jul 2024 08:36:04 +0100
Message-ID: <CAPj87rMJUSRJ9G1uv-w5a_4qqS0R1dDaUEofoJf=ehbMszdfOw@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] drm/ci: rockchip: add tests for rockchip display driver
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	deborah.brouwer@collabora.com, robdclark@gmail.com, 
	linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Wed, 24 Jul 2024 at 11:12, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> For rockchip rk3288 and rk3399, the display driver is rockchip
> and gpu driver is panfrost. Currently, in drm-ci for rockchip
> rk3288 and rk3399, only the gpu driver is tested. Refactor
> the existing rockchip jobs to test both display and gpu driver
> and update xfails.

Could you also please add RK3588 in a new series (no need to hold this
one up), with Rockchip KMS and Panthor GPU? You can use the
rk3588-rock5-b device type in LAVA.

> diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
> index cf3a747f7cec..826cca5efbff 100644
> --- a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
> +++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt

This is in the wrong patch?

> +++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
> @@ -0,0 +1,71 @@
> +# Suspend to RAM seems to be broken on this machine
> +.*suspend.*
> +
> +# Too unstable, machine ends up hanging after lots of Oopses
> +kms_cursor_legacy.*
> +
> +# Started hanging the machine on Linux 5.19-rc2:
> +#
> +# [IGT] kms_plane_lowres: executing
> +# [IGT] kms_plane_lowres: starting subtest pipe-F-tiling-y
> +# [IGT] kms_plane_lowres: exiting, ret=77

ret 77 is a pure skip here, as you'd expect from a pipe F test,
because Rockchip doesn't have six CRTCs.

> +# Console: switching to colour frame buffer device 170x48
> +# rockchip-drm display-subsystem: [drm] *ERROR* flip_done timed out
> +# rockchip-drm display-subsystem: [drm] *ERROR* [CRTC:35:crtc-0] commit wait timed out
> +# BUG: spinlock bad magic on CPU#3, kms_plane_lowre/482
> +# 8<--- cut here ---
> +# Unable to handle kernel paging request at virtual address 7812078e
> +# [7812078e] *pgd=00000000
> +# Internal error: Oops: 5 [#1] SMP ARM
> +# Modules linked in:
> +# CPU: 3 PID: 482 Comm: kms_plane_lowre Tainted: G        W         5.19.0-rc2-323596-g00535de92171 #1
> +# Hardware name: Rockchip (Device Tree)
> +# Process kms_plane_lowre (pid: 482, stack limit = 0x1193ac2b)
> +#  spin_dump from do_raw_spin_lock+0xa4/0xe8
> +#  do_raw_spin_lock from wait_for_completion_timeout+0x2c/0x120
> +#  wait_for_completion_timeout from drm_crtc_commit_wait+0x18/0x7c
> +#  drm_crtc_commit_wait from drm_atomic_helper_wait_for_dependencies+0x44/0x168
> +#  drm_atomic_helper_wait_for_dependencies from commit_tail+0x34/0x180
> +#  commit_tail from drm_atomic_helper_commit+0x164/0x18c
> +#  drm_atomic_helper_commit from drm_atomic_commit+0xac/0xe4
> +#  drm_atomic_commit from drm_client_modeset_commit_atomic+0x23c/0x284
> +#  drm_client_modeset_commit_atomic from drm_client_modeset_commit_locked+0x60/0x1c8
> +#  drm_client_modeset_commit_locked from drm_client_modeset_commit+0x24/0x40
> +#  drm_client_modeset_commit from drm_fbdev_client_restore+0x58/0x94
> +#  drm_fbdev_client_restore from drm_client_dev_restore+0x70/0xbc
> +#  drm_client_dev_restore from drm_release+0xf4/0x114
> +#  drm_release from __fput+0x74/0x240
> +#  __fput from task_work_run+0x84/0xb4
> +#  task_work_run from do_exit+0x34c/0xa20
> +#  do_exit from do_group_exit+0x34/0x98

So this is pointing to the error being that, when a client exits, the
kernel attempts to restore fbdev and then it's broken. Pinning
pipe-F-tiling-y as specifically responsible for this seems quite odd
to me, given that it doesn't do anything but only skips. Is that maybe
just because it's the last test running in the kms_plane_lowres group
before it exits? Or does it occur more wildly on other test groups?

> +tools_test@tools_test,Fail

I keep noticing this failing everywhere. What's up with that? Have you
reported these logs to the igt list?

Cheers,
Daniel

