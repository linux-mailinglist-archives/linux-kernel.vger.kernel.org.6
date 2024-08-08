Return-Path: <linux-kernel+bounces-279363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CF594BC4D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9F71F2287E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851EB187854;
	Thu,  8 Aug 2024 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZKQoY0uV"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1284142E78
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116682; cv=none; b=W/fHspcxfbKHm4pmSV8zqDUM2DjYUL1XtgbV0pBBO+yHswCwH82lyuyFxNTIUzLbjmNq1RyO58bd3lRRMitN8xjCqkkGse1K8UE8r59Q6WI5FuYVGp5VGtb9YdvzDUhbsTGU85wY1fIlzzl7L9+7SMJHlhPzoWqeA7rzS9DkR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116682; c=relaxed/simple;
	bh=uX87Nowq5JdLojeqzpqQCBp+s9vQD6zy7Iks8ES0pRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJ9oNV0nDFcb0YgmVGUDUvaaLfbGqNA73JuAPiWl1jao1BgqfWdKx8sywk0hHJwendoqMg3Q6ZkchyPbEgsxWdB8+tYwjjBtzKNceQPcd7go7GXNRPUghsBwVjj2LkGXVfNgEfCHDhbjHtjZxF1F7nBXfQIj+ucDpwxtVmdwnLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZKQoY0uV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sEinvqYoFoRoXEeX8sTP2VH+gv49kgs+xYY5IaYih8I=; b=ZKQoY0uVwHnJQuRLCyvijn1OUs
	cTZCEpV8qQaR/UwSmVhsdNryfztHkooCGTkd32SDmGFfATxgMsNGXnRpPgh/dNa7oWr7+5o0JG+hd
	Hep7Q3lJgxs5zPjsy1l2Vpf43c6EgdmpyAKX7QhTbaNxu1cFooXIKUtfNrcJSqH7119SMhp760BE2
	LGoSiyrrPwpKXhxdOrF8NwN2l/uZms7uQEhrzIeoBx/eCNJ8NiR5yLy/RAhJnqr7GpNy2G4J08cWo
	iOSoqglw1wC2n0UJ9sezbmjnSaGlQqbC4/3J1/zjQUZjXUI4dPOQ++1qn8vunDBwfx0cGUIV+GslF
	WGDexgdA==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sc1ML-009LaD-VG; Thu, 08 Aug 2024 13:31:10 +0200
Message-ID: <8fc33b63-40db-478c-95bc-bdfaa93d2fd4@igalia.com>
Date: Thu, 8 Aug 2024 08:31:02 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/ci: uprev mesa
To: Vignesh Raman <vignesh.raman@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, helen.koike@collabora.com, airlied@gmail.com,
 daniel@ffwll.ch, robdclark@gmail.com, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com,
 linux-kernel@vger.kernel.org
References: <20240807082020.429434-1-vignesh.raman@collabora.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <20240807082020.429434-1-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vignesh,

On 8/7/24 05:20, Vignesh Raman wrote:
> Uprev mesa to adapt to the latest changes in mesa ci.
> Project 'anholt/deqp-runner' was moved to 'mesa/deqp-runner'.
> So update the link.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v1:
>    - Working pipeline link,
>      https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1242911
> 
> ---
>   drivers/gpu/drm/ci/container.yml  |  8 ++++++++
>   drivers/gpu/drm/ci/gitlab-ci.yml  | 22 ++++++++++++----------
>   drivers/gpu/drm/ci/image-tags.yml |  8 ++++----
>   drivers/gpu/drm/ci/lava-submit.sh |  1 +
>   drivers/gpu/drm/ci/test.yml       |  4 ++--
>   5 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ci/container.yml b/drivers/gpu/drm/ci/container.yml
> index d6edf3635b23..2a94f54ce4cf 100644
> --- a/drivers/gpu/drm/ci/container.yml
> +++ b/drivers/gpu/drm/ci/container.yml
> @@ -28,6 +28,14 @@ debian/x86_64_test-vk:
>     rules:
>       - when: never
>   
> +debian/arm64_test-vk:
> +  rules:
> +    - when: never
> +
> +debian/arm64_test-gl:
> +  rules:
> +    - when: never
> +
>   fedora/x86_64_build:
>     rules:
>       - when: never
> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
> index 6d2cefa7f15e..eca47d4f816f 100644
> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> @@ -1,13 +1,13 @@
>   variables:
>     DRM_CI_PROJECT_PATH: &drm-ci-project-path mesa/mesa
> -  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha e2b9c5a9e3e4f9b532067af8022eaef8d6fc6c00
> +  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha d9849ac46623797a9f56fb9d46dc52460ac477de
>   
>     UPSTREAM_REPO: https://gitlab.freedesktop.org/drm/kernel.git
>     TARGET_BRANCH: drm-next
>   
>     IGT_VERSION: f13702b8e4e847c56da3ef6f0969065d686049c5
>   
> -  DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/anholt/deqp-runner.git
> +  DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/mesa/deqp-runner.git
>     DEQP_RUNNER_GIT_TAG: v0.15.0

Kinda of unrelated to the patch itself, but shouldn't we update
DEQP_RUNNER_GIT_TAG? Mesa is already using deqp-runner v0.20.0 and we
are still on v0.15.0.

Best Regards,
- Maíra

>   
>     FDO_UPSTREAM_REPO: helen.fornazier/linux   # The repo where the git-archive daily runs
> @@ -85,22 +85,24 @@ include:
>     - project: *drm-ci-project-path
>       ref: *drm-ci-commit-sha
>       file:
> +      - '/.gitlab-ci/container/gitlab-ci.yml'
>         - '/.gitlab-ci/farm-rules.yml'
> +      - '/.gitlab-ci/lava/lava-gitlab-ci.yml'
>         - '/.gitlab-ci/test-source-dep.yml'
> -      - '/.gitlab-ci/container/gitlab-ci.yml'
>         - '/.gitlab-ci/test/gitlab-ci.yml'
> -      - '/.gitlab-ci/lava/lava-gitlab-ci.yml'
> -      - '/src/microsoft/ci/gitlab-ci-inc.yml'
> -      - '/src/gallium/drivers/zink/ci/gitlab-ci-inc.yml'
> +      - '/src/amd/ci/gitlab-ci-inc.yml'
> +      - '/src/freedreno/ci/gitlab-ci-inc.yml'
>         - '/src/gallium/drivers/crocus/ci/gitlab-ci-inc.yml'
> -      - '/src/gallium/drivers/softpipe/ci/gitlab-ci-inc.yml'
>         - '/src/gallium/drivers/llvmpipe/ci/gitlab-ci-inc.yml'
> -      - '/src/gallium/drivers/virgl/ci/gitlab-ci-inc.yml'
>         - '/src/gallium/drivers/nouveau/ci/gitlab-ci-inc.yml'
> +      - '/src/gallium/drivers/softpipe/ci/gitlab-ci-inc.yml'
> +      - '/src/gallium/drivers/virgl/ci/gitlab-ci-inc.yml'
> +      - '/src/gallium/drivers/zink/ci/gitlab-ci-inc.yml'
>         - '/src/gallium/frontends/lavapipe/ci/gitlab-ci-inc.yml'
> +      - '/src/gallium/frontends/rusticl/ci/gitlab-ci.yml'
>         - '/src/intel/ci/gitlab-ci-inc.yml'
> -      - '/src/freedreno/ci/gitlab-ci-inc.yml'
> -      - '/src/amd/ci/gitlab-ci-inc.yml'
> +      - '/src/microsoft/ci/gitlab-ci-inc.yml'
> +      - '/src/nouveau/ci/gitlab-ci-inc.yml'
>         - '/src/virtio/ci/gitlab-ci-inc.yml'
>     - drivers/gpu/drm/ci/image-tags.yml
>     - drivers/gpu/drm/ci/container.yml
> diff --git a/drivers/gpu/drm/ci/image-tags.yml b/drivers/gpu/drm/ci/image-tags.yml
> index 13eda37bdf05..2c340d063a96 100644
> --- a/drivers/gpu/drm/ci/image-tags.yml
> +++ b/drivers/gpu/drm/ci/image-tags.yml
> @@ -1,15 +1,15 @@
>   variables:
> -   CONTAINER_TAG: "2024-05-09-mesa-uprev"
> +   CONTAINER_TAG: "2024-08-07-mesa-uprev"
>      DEBIAN_X86_64_BUILD_BASE_IMAGE: "debian/x86_64_build-base"
>      DEBIAN_BASE_TAG: "${CONTAINER_TAG}"
>   
>      DEBIAN_X86_64_BUILD_IMAGE_PATH: "debian/x86_64_build"
> -   DEBIAN_BUILD_TAG: "2024-06-10-vkms"
> +   DEBIAN_BUILD_TAG: "${CONTAINER_TAG}"
>   
> -   KERNEL_ROOTFS_TAG: "2023-10-06-amd"
> +   KERNEL_ROOTFS_TAG: "${CONTAINER_TAG}"
>   
>      DEBIAN_X86_64_TEST_BASE_IMAGE: "debian/x86_64_test-base"
>      DEBIAN_X86_64_TEST_IMAGE_GL_PATH: "debian/x86_64_test-gl"
> -   DEBIAN_X86_64_TEST_GL_TAG: "${CONTAINER_TAG}"
> +   DEBIAN_TEST_GL_TAG: "${CONTAINER_TAG}"
>   
>      ALPINE_X86_64_LAVA_SSH_TAG: "${CONTAINER_TAG}"
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/ci/lava-submit.sh b/drivers/gpu/drm/ci/lava-submit.sh
> index 0707fa706a48..6add15083c78 100755
> --- a/drivers/gpu/drm/ci/lava-submit.sh
> +++ b/drivers/gpu/drm/ci/lava-submit.sh
> @@ -44,6 +44,7 @@ PYTHONPATH=artifacts/ artifacts/lava/lava_job_submitter.py \
>   	--first-stage-init artifacts/ci-common/init-stage1.sh \
>   	--ci-project-dir "${CI_PROJECT_DIR}" \
>   	--device-type "${DEVICE_TYPE}" \
> +	--farm "${FARM}" \
>   	--dtb-filename "${DTB}" \
>   	--jwt-file "${S3_JWT_FILE}" \
>   	--kernel-image-name "${KERNEL_IMAGE_NAME}" \
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index b22b2cf8f06f..b6f428cdaf94 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -69,7 +69,7 @@
>   .baremetal-igt-arm64:
>     extends:
>       - .baremetal-test-arm64
> -    - .use-debian/arm64_test
> +    - .use-debian/baremetal_arm64_test
>       - .test-rules
>     variables:
>       FDO_CI_CONCURRENT: 10
> @@ -79,7 +79,7 @@
>       BM_CMDLINE: "ip=dhcp console=ttyMSM0,115200n8 $BM_KERNEL_EXTRA_ARGS root=/dev/nfs rw nfsrootdebug nfsroot=,tcp,nfsvers=4.2 init=/init $BM_KERNELARGS"
>       FARM: google
>     needs:
> -    - debian/arm64_test
> +    - debian/baremetal_arm64_test
>       - job: testing:arm64
>         artifacts: false
>       - igt:arm64

