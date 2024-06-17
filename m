Return-Path: <linux-kernel+bounces-217698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D21590B606
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52983B34FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A92127E0D;
	Mon, 17 Jun 2024 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fWs+a21Z"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1284D30
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633167; cv=none; b=Ie/lJCGR0fv64im487znc/7+atkBpQXIpm6mhuTVfBk9HjwUUBdCcAU1+DgGFswgc+NGQxGalBuQBSPt7Ed1jP5IQWwqAdL9tH+Tjq60UFJpHBSGSuefbeufTYF3XIuQq2ZXcPMzrN1hBDA36gKuU6mxZtVnYlDzdmTxfAeZWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633167; c=relaxed/simple;
	bh=nParRfS8ioc8EQJM008WlNV9nyA7tt2yc6moo5kCjBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAkJahgvsJ5io1P2SFwc49+6sPr6A8mzI8ezvqd9ZH/UgWXJTq+fCSAW+R+7JnT0b2HyZTJwnfT/By/eVXwKWQQS+QdKvlQuiqRtL/LLIs9jCD0Y6+wU88nDa4gzr/qwwpskwmuxnH9EY5K1Et1GI97V37mGzGXxp1yy18LX+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=fWs+a21Z; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebd6ae2f56so4966621fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718633164; x=1719237964; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YzJ1Pp0CHUqFx+aOTH8lTPZN70yxjH5npE4fOTTLa0Y=;
        b=fWs+a21ZpjrvWlj/VdzxXN+ETdx7smAkRnabFtW/9U0DGQLah7YZuS40HPwEkimIxD
         U/bRBimSwsKFqYLobA6k8N9lFS88Sb4ZQREYbxsoz4AbcL1Vop5xuTrH9dLwWxLILj9o
         Y1H+AKu4xammAura2JpT7og1mbFEuPhCQlReU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633164; x=1719237964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzJ1Pp0CHUqFx+aOTH8lTPZN70yxjH5npE4fOTTLa0Y=;
        b=N2GVTZd6sh6gChjlXMU7FZKwkboCHgi667FBxnnh3M9JRNDTTJYzWGmMTEMMMUy1Y2
         Wt7RnB4qCyeBPq3wBqLQhDK0vZzaWNA3Enh7FIh61rJo0OTEj+nOYN6r+ijUP20uGUEF
         XVwkufe8BaoCHwlcIi4Z2IRPCeYDGAXEAbz7ycTkW/q52EiDpjDx5TZcM+nD4Cm4lopW
         m3ZeTw0lDdYVfmXwo8iuldGjBixycOy0cmEFbYWET1gVicGKU8gabO6rUAThmD8zOqyY
         2Qk0T7EArGcDZhqyld+Ij0Yq/tGdKMpV0dZzZS/ICCjs10cMGsAmnlc3gaLkMHZhWX6l
         EWjA==
X-Forwarded-Encrypted: i=1; AJvYcCWJRMvAeB6zGGtwmAu+KFcw/Xg9tvn5FqGrXR5Mlw/SWWUCyR7MAcy3rlI3ibiju3Wvs9UDDdjYAgs0rspDM5qdtZi75oc6DoOO14ru
X-Gm-Message-State: AOJu0YzI1rwuKrgbU4neJX8fat9BoTdocsiwID5SIjn+2bMe7wPPyHTo
	U9kxzU9ydq73L9o9DzMkVX9b+BiZTkXcZ//nPQZ28WBEQlh5zz0VNe2kfvwYk0M=
X-Google-Smtp-Source: AGHT+IGyKzHTmtEagCrg8eAVhDs9fzrEjWcbNxqbPwGceoM2kBwNFFGCqFisA44fsHb/Vnig8fsx7A==
X-Received: by 2002:a2e:be11:0:b0:2eb:e738:53b2 with SMTP id 38308e7fff4ca-2ec0e463c53mr70009601fa.1.1718633164071;
        Mon, 17 Jun 2024 07:06:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-423b7a61501sm80940085e9.46.2024.06.17.07.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:06:03 -0700 (PDT)
Date: Mon, 17 Jun 2024 16:06:01 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com, daniel@ffwll.ch,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	mairacanal@riseup.net, hamohammed.sa@gmail.com, robdclark@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, daniels@collabora.com,
	helen.koike@collabora.com, guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] drm/ci: add tests on vkms
Message-ID: <ZnBCyQfWzk5FWurf@phenom.ffwll.local>
Mail-Followup-To: Vignesh Raman <vignesh.raman@collabora.com>,
	dri-devel@lists.freedesktop.org, airlied@gmail.com,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	mairacanal@riseup.net, hamohammed.sa@gmail.com, robdclark@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, daniels@collabora.com,
	helen.koike@collabora.com, guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com, linux-kernel@vger.kernel.org
References: <20240611091037.558969-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240611091037.558969-1-vignesh.raman@collabora.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Tue, Jun 11, 2024 at 02:40:37PM +0530, Vignesh Raman wrote:
> Add job that runs igt on top of vkms.
> 
> Acked-by: Maíra Canal <mcanal@igalia.com>
> Acked-by: Helen Koike <helen.koike@collabora.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> Acked-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> Tested-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>

Do we have some effort going on to fix the testcases (or vkms)? With pure
software testcases there really shouldn't ever be any flakes, and if we
can use vkms to improve our testcase quality, then I think the entire
gitlab CI project was already more than worth it ...

Cheers, Sima

> ---
> 
> v2:
> - do not mv modules to /lib/modules in the job definition, leave it to
>   crosvm-runner.sh
> 
> v3:
> - Enable CONFIG_DRM_VKMS in x86_64.config and update xfails
> 
> v4:
> - Build vkms as module and test with latest IGT. 
>   This patch depends on https://lore.kernel.org/dri-devel/20240130150340.687871-1-vignesh.raman@collabora.com/
> 
> v5:
> - Test with the updated IGT and update xfails
> 
> ---
>  MAINTAINERS                                   |  1 +
>  drivers/gpu/drm/ci/build.sh                   |  1 -
>  drivers/gpu/drm/ci/gitlab-ci.yml              |  1 +
>  drivers/gpu/drm/ci/igt_runner.sh              |  6 +-
>  drivers/gpu/drm/ci/image-tags.yml             |  2 +-
>  drivers/gpu/drm/ci/test.yml                   | 24 ++++++-
>  drivers/gpu/drm/ci/x86_64.config              |  1 +
>  drivers/gpu/drm/ci/xfails/vkms-none-fails.txt | 57 ++++++++++++++++
>  .../gpu/drm/ci/xfails/vkms-none-flakes.txt    | 15 +++++
>  drivers/gpu/drm/ci/xfails/vkms-none-skips.txt | 67 +++++++++++++++++++
>  10 files changed, 169 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-skips.txt
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8aee861d18f9..94065f5028cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7036,6 +7036,7 @@ L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>  F:	Documentation/gpu/vkms.rst
> +F:	drivers/gpu/drm/ci/xfails/vkms*
>  F:	drivers/gpu/drm/vkms/
>  
>  DRM DRIVER FOR VIRTUALBOX VIRTUAL GPU
> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> index a67871fdcd3f..e938074ac8e7 100644
> --- a/drivers/gpu/drm/ci/build.sh
> +++ b/drivers/gpu/drm/ci/build.sh
> @@ -157,7 +157,6 @@ fi
>  
>  mkdir -p artifacts/install/lib
>  mv install/* artifacts/install/.
> -rm -rf artifacts/install/modules
>  ln -s common artifacts/install/ci-common
>  cp .config artifacts/${CI_JOB_NAME}_config
>  
> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
> index 1b29c3b6406b..80fb0f57ae46 100644
> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> @@ -123,6 +123,7 @@ stages:
>    - msm
>    - rockchip
>    - virtio-gpu
> +  - software-driver
>  
>  # YAML anchors for rule conditions
>  # --------------------------------
> diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
> index d49ad434b580..79f41d7da772 100755
> --- a/drivers/gpu/drm/ci/igt_runner.sh
> +++ b/drivers/gpu/drm/ci/igt_runner.sh
> @@ -30,10 +30,10 @@ case "$DRIVER_NAME" in
>              export IGT_FORCE_DRIVER="panfrost"
>          fi
>          ;;
> -    amdgpu)
> +    amdgpu|vkms)
>          # Cannot use HWCI_KERNEL_MODULES as at that point we don't have the module in /lib
> -        mv /install/modules/lib/modules/* /lib/modules/.
> -        modprobe amdgpu
> +        mv /install/modules/lib/modules/* /lib/modules/. || true
> +        modprobe --first-time $DRIVER_NAME
>          ;;
>  esac
>  
> diff --git a/drivers/gpu/drm/ci/image-tags.yml b/drivers/gpu/drm/ci/image-tags.yml
> index 60323ebc7304..13eda37bdf05 100644
> --- a/drivers/gpu/drm/ci/image-tags.yml
> +++ b/drivers/gpu/drm/ci/image-tags.yml
> @@ -4,7 +4,7 @@ variables:
>     DEBIAN_BASE_TAG: "${CONTAINER_TAG}"
>  
>     DEBIAN_X86_64_BUILD_IMAGE_PATH: "debian/x86_64_build"
> -   DEBIAN_BUILD_TAG: "2023-10-08-config"
> +   DEBIAN_BUILD_TAG: "2024-06-10-vkms"
>  
>     KERNEL_ROOTFS_TAG: "2023-10-06-amd"
>  
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 322cce714657..ee908b66aad2 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -338,7 +338,7 @@ meson:g12b:
>      RUNNER_TAG: mesa-ci-x86-64-lava-meson-g12b-a311d-khadas-vim3
>  
>  virtio_gpu:none:
> -  stage: virtio-gpu
> +  stage: software-driver
>    variables:
>      CROSVM_GALLIUM_DRIVER: llvmpipe
>      DRIVER_NAME: virtio_gpu
> @@ -358,3 +358,25 @@ virtio_gpu:none:
>      - debian/x86_64_test-gl
>      - testing:x86_64
>      - igt:x86_64
> +
> +vkms:none:
> +  stage: software-driver
> +  variables:
> +    DRIVER_NAME: vkms
> +    GPU_VERSION: none
> +  extends:
> +    - .test-gl
> +    - .test-rules
> +  tags:
> +    - kvm
> +  script:
> +    - ln -sf $CI_PROJECT_DIR/install /install
> +    - mv install/bzImage /lava-files/bzImage
> +    - mkdir -p /lib/modules
> +    - mkdir -p $CI_PROJECT_DIR/results
> +    - ln -sf $CI_PROJECT_DIR/results /results
> +    - ./install/crosvm-runner.sh ./install/igt_runner.sh
> +  needs:
> +    - debian/x86_64_test-gl
> +    - testing:x86_64
> +    - igt:x86_64
> diff --git a/drivers/gpu/drm/ci/x86_64.config b/drivers/gpu/drm/ci/x86_64.config
> index 1cbd49a5b23a..8eaba388b141 100644
> --- a/drivers/gpu/drm/ci/x86_64.config
> +++ b/drivers/gpu/drm/ci/x86_64.config
> @@ -24,6 +24,7 @@ CONFIG_DRM=y
>  CONFIG_DRM_PANEL_SIMPLE=y
>  CONFIG_PWM_CROS_EC=y
>  CONFIG_BACKLIGHT_PWM=y
> +CONFIG_DRM_VKMS=m
>  
>  # Strip out some stuff we don't need for graphics testing, to reduce
>  # the build.
> diff --git a/drivers/gpu/drm/ci/xfails/vkms-none-fails.txt b/drivers/gpu/drm/ci/xfails/vkms-none-fails.txt
> new file mode 100644
> index 000000000000..691c383b21a0
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/vkms-none-fails.txt
> @@ -0,0 +1,57 @@
> +core_hotunplug@hotrebind,Fail
> +core_hotunplug@hotrebind-lateclose,Fail
> +core_hotunplug@hotreplug,Fail
> +core_hotunplug@hotreplug-lateclose,Fail
> +core_hotunplug@hotunbind-rebind,Fail
> +core_hotunplug@hotunplug-rescan,Fail
> +core_hotunplug@unbind-rebind,Fail
> +core_hotunplug@unplug-rescan,Fail
> +device_reset@cold-reset-bound,Fail
> +device_reset@reset-bound,Fail
> +device_reset@unbind-cold-reset-rebind,Fail
> +device_reset@unbind-reset-rebind,Fail
> +dumb_buffer@invalid-bpp,Fail
> +kms_content_protection@atomic,Crash
> +kms_content_protection@atomic-dpms,Crash
> +kms_content_protection@content-type-change,Crash
> +kms_content_protection@lic-type-0,Crash
> +kms_content_protection@lic-type-1,Crash
> +kms_content_protection@srm,Crash
> +kms_content_protection@type1,Crash
> +kms_content_protection@uevent,Crash
> +kms_cursor_crc@cursor-rapid-movement-128x128,Fail
> +kms_cursor_crc@cursor-rapid-movement-128x42,Fail
> +kms_cursor_crc@cursor-rapid-movement-256x256,Fail
> +kms_cursor_crc@cursor-rapid-movement-256x85,Fail
> +kms_cursor_crc@cursor-rapid-movement-32x10,Fail
> +kms_cursor_crc@cursor-rapid-movement-32x32,Fail
> +kms_cursor_crc@cursor-rapid-movement-512x170,Fail
> +kms_cursor_crc@cursor-rapid-movement-512x512,Fail
> +kms_cursor_crc@cursor-rapid-movement-64x21,Fail
> +kms_cursor_crc@cursor-rapid-movement-64x64,Fail
> +kms_cursor_legacy@basic-flip-before-cursor-atomic,Fail
> +kms_cursor_legacy@basic-flip-before-cursor-legacy,Fail
> +kms_cursor_legacy@cursor-vs-flip-atomic,Fail
> +kms_cursor_legacy@cursor-vs-flip-legacy,Fail
> +kms_cursor_legacy@cursor-vs-flip-toggle,Fail
> +kms_cursor_legacy@cursor-vs-flip-varying-size,Fail
> +kms_cursor_legacy@flip-vs-cursor-atomic,Fail
> +kms_cursor_legacy@flip-vs-cursor-crc-atomic,Fail
> +kms_cursor_legacy@flip-vs-cursor-crc-legacy,Fail
> +kms_cursor_legacy@flip-vs-cursor-legacy,Fail
> +kms_flip@flip-vs-modeset-vs-hang,Fail
> +kms_flip@flip-vs-panning-vs-hang,Fail
> +kms_flip@flip-vs-suspend,Timeout
> +kms_flip@flip-vs-suspend-interruptible,Timeout
> +kms_flip@plain-flip-fb-recreate,Fail
> +kms_lease@lease-uevent,Fail
> +kms_pipe_crc_basic@nonblocking-crc,Fail
> +kms_pipe_crc_basic@nonblocking-crc-frame-sequence,Fail
> +kms_writeback@writeback-check-output,Fail
> +kms_writeback@writeback-check-output-XRGB2101010,Fail
> +kms_writeback@writeback-fb-id,Fail
> +kms_writeback@writeback-fb-id-XRGB2101010,Fail
> +kms_writeback@writeback-invalid-parameters,Fail
> +kms_writeback@writeback-pixel-formats,Fail
> +perf@i915-ref-count,Fail
> +tools_test@tools_test,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt b/drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt
> new file mode 100644
> index 000000000000..56484a30aff5
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt
> @@ -0,0 +1,15 @@
> +# Board Name: vkms
> +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
> +# Failure Rate: 50
> +# IGT Version: 1.28-g0df7b9b97
> +# Linux Version: 6.9.0-rc7
> +kms_cursor_legacy@long-nonblocking-modeset-vs-cursor-atomic
> +kms_flip@basic-flip-vs-wf_vblank
> +kms_flip@flip-vs-expired-vblank-interruptible
> +kms_flip@flip-vs-wf_vblank-interruptible
> +kms_flip@plain-flip-fb-recreate-interruptible
> +kms_flip@plain-flip-ts-check
> +kms_flip@plain-flip-ts-check-interruptible
> +kms_flip@flip-vs-absolute-wf_vblank
> +kms_flip@flip-vs-absolute-wf_vblank-interruptible
> +kms_flip@flip-vs-blocking-wf-vblank
> diff --git a/drivers/gpu/drm/ci/xfails/vkms-none-skips.txt b/drivers/gpu/drm/ci/xfails/vkms-none-skips.txt
> new file mode 100644
> index 000000000000..5a9093ddb613
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/vkms-none-skips.txt
> @@ -0,0 +1,67 @@
> +# keeps printing vkms_vblank_simulate: vblank timer overrun and never ends
> +kms_invalid_mode@int-max-clock
> +
> +# Kernel panic
> +kms_cursor_crc@cursor-rapid-movement-32x10
> +# Oops: 0000 [#1] PREEMPT SMP NOPTI
> +# CPU: 0 PID: 2635 Comm: kworker/u8:13 Not tainted 6.9.0-rc7-g40935263a1fd #1
> +# Hardware name: ChromiumOS crosvm, BIOS 0
> +# Workqueue: vkms_composer vkms_composer_worker [vkms]
> +# RIP: 0010:compose_active_planes+0x1c7/0x4e0 [vkms]
> +# Code: c9 0f 84 6a 01 00 00 8b 42 30 2b 42 28 41 39 c5 0f 8c 6f 01 00 00 49 83 c7 01 49 39 df 74 3b 4b 8b 34 fc 48 8b 96 48 01 00 00 <8b> 42 78 89 c1 83 e1 0a a8 20 74 b1 45 89 f5 41 f7 d5 44 03 6a 34
> +# RSP: 0018:ffffbb4700c17d58 EFLAGS: 00010246
> +# RAX: 0000000000000400 RBX: 0000000000000002 RCX: 0000000000000002
> +# RDX: 0000000000000000 RSI: ffffa2ad0788c000 RDI: 00000000fff479a8
> +# RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
> +# R10: ffffa2ad0bb14000 R11: 0000000000000000 R12: ffffa2ad03e21700
> +# R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000000
> +# FS:  0000000000000000(0000) GS:ffffa2ad2bc00000(0000) knlGS:0000000000000000
> +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> +# CR2: 0000000000000078 CR3: 000000010bd30000 CR4: 0000000000350ef0
> +# Call Trace:
> +#  <TASK>
> +#  ? __die+0x1e/0x60
> +#  ? page_fault_oops+0x17b/0x490
> +#  ? exc_page_fault+0x6d/0x230
> +#  ? asm_exc_page_fault+0x26/0x30
> +#  ? compose_active_planes+0x1c7/0x4e0 [vkms]
> +#  ? compose_active_planes+0x2a3/0x4e0 [vkms]
> +#  ? srso_return_thunk+0x5/0x5f
> +#  vkms_composer_worker+0x205/0x240 [vkms]
> +#  process_one_work+0x1f4/0x6b0
> +#  ? lock_is_held_type+0x9e/0x110
> +#  worker_thread+0x17e/0x350
> +#  ? __pfx_worker_thread+0x10/0x10
> +#  kthread+0xce/0x100
> +#  ? __pfx_kthread+0x10/0x10
> +#  ret_from_fork+0x2f/0x50
> +#  ? __pfx_kthread+0x10/0x10
> +#  ret_from_fork_asm+0x1a/0x30
> +#  </TASK>
> +# Modules linked in: vkms
> +# CR2: 0000000000000078
> +# ---[ end trace 0000000000000000 ]---
> +# RIP: 0010:compose_active_planes+0x1c7/0x4e0 [vkms]
> +# Code: c9 0f 84 6a 01 00 00 8b 42 30 2b 42 28 41 39 c5 0f 8c 6f 01 00 00 49 83 c7 01 49 39 df 74 3b 4b 8b 34 fc 48 8b 96 48 01 00 00 <8b> 42 78 89 c1 83 e1 0a a8 20 74 b1 45 89 f5 41 f7 d5 44 03 6a 34
> +# RSP: 0018:ffffbb4700c17d58 EFLAGS: 00010246
> +# RAX: 0000000000000400 RBX: 0000000000000002 RCX: 0000000000000002
> +# RDX: 0000000000000000 RSI: ffffa2ad0788c000 RDI: 00000000fff479a8
> +# RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
> +# R10: ffffa2ad0bb14000 R11: 0000000000000000 R12: ffffa2ad03e21700
> +# R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000000
> +# FS:  0000000000000000(0000) GS:ffffa2ad2bc00000(0000) knlGS:0000000000000000
> +# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> +
> +# Skip driver specific tests
> +^amdgpu.*
> +msm_.*
> +nouveau_.*
> +panfrost_.*
> +^v3d.*
> +^vc4.*
> +^vmwgfx*
> +
> +# Skip intel specific tests
> +gem_.*
> +i915_.*
> +xe_.*
> -- 
> 2.40.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

