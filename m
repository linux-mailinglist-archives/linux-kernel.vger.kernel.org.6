Return-Path: <linux-kernel+bounces-534889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA72A46C49
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010E316CEDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E8727561B;
	Wed, 26 Feb 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ywe9rtDm"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE472755E7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601463; cv=none; b=DqW7fIIfQylAKGPgmlH6b7RXA3tXgE5d0eEvdlBdE10oZdD+8r+cNOw6nSEVEkBw8pD2vCsxgrDASK6K1YWyewCnRJ/4MU8wmUz0nKSQ1M+f8/zYZbDskULr4/FpO4t+xImf1yle1y9epmlKmcpZrQDUMs1hEvue1/zuVqZ1HV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601463; c=relaxed/simple;
	bh=OLmkv9g4Bv+E1XrXEkkHYRlPrzGEUaC/lk0OczD2sUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/1sal+JhPp2Ajeivqoxy3WGUFixHZZZedlMf84avCLqzdwLFj5/wHaiuitCV6MM3G0o9xp8kdppJ0XrkEWdp/2T/FtQ0hKYn+noI6Pdo6eq8bQI22NPldERH8EM1nlFevMzKfUTXKK4r5l4cNgqWm2iaJnPJEvCMHDJv8elQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ywe9rtDm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb81285d33so37009366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740601460; x=1741206260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2LPlZ9elyCBQd7HfWkhng7/ATOs+tQHMcn3jLxff7s=;
        b=Ywe9rtDmco82gqPcxqOdQ8MewyovYlWyUQGmj160DxSt+mK6O7IceQZHzxTphmHHKo
         mIrJavspclp4HHCS6lSNDc6OGdo8mG4g+0DfeYIKLYvNUuSEgiX43/gLCV9Bur1yvPMq
         0pYKdW88Vh/7Ql5L7lfCIOpg127aaY74xxmQL8vjcv5bonxhZTDAk/QOQDokFGeL7hvF
         FZBZY83lUZexgu3QjU0KYl0y6+DFdaJ5uL7u47L/9kBMUa4fV2JJPSgdvZ+VIaMeKIla
         fl05zmYHujoZ9kqAhJlHqkuW3tHveqz1feW/oyE4DHeRbVE4mS6k5UyZqwlPLtmYQBfM
         4bVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740601460; x=1741206260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2LPlZ9elyCBQd7HfWkhng7/ATOs+tQHMcn3jLxff7s=;
        b=jlMwMs7/o0u9P76Z8ORo4S4LowBAZZNirxur4Siym+T5WTsJKOaVJJXhrhR3hBVufM
         cnN6Smwbv3pCSmC185zJ5ja8k43UGb/gtjwA03jFVACSmfsmwTKdJuEOEdi8zSY/Vs4h
         Tj9oS7MktwYbqFcs+hgrIs7v3i5qtPitVuu1w+l35vUQWAJgySJsIE4Z+f94dfEsMhkx
         KZzQLobLNfozkJ6XfQKjuvzvWYsuvkP36B547/2tSZVSS7oESM+fRx5BhjkplgjlVcVQ
         S3RxZ3GFia4AOybshMWqt/BRdCjnd8VlCRTVozIX36J85khZSAeJUddUUYqrJLhLRErV
         7E1A==
X-Forwarded-Encrypted: i=1; AJvYcCXLEyxv0Y+Zt1jFax9OLvn/ByPK4evAHMidNvCTedFSPop9rLeUa2A6y0bha6ywUMc32wWDXIWgXZM04dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcEFMzLHznisvbCRWNDXj4fSbXKldNyaCXNyq1JhODsKqE71Bs
	hs6A2+V8/OiXteBMcqtby/vR5HdhCDMPD4tjf29ULIft0u212Xro+4HEmNo8Ek5emau3H2L2FT4
	75Q7i2cNR87QAgc3mIvcxNX7ePzE=
X-Gm-Gg: ASbGnctbq9KuWOv/iMzKhPZuWml0T5g7hZ5RWs+iXeXc90NRP/D8iOudFdiLPTmw382
	gKoR14G5aeZW9dwjnNk8rmGqtDAU+zpRK1Pmydhy3hCrdfYHQqs90uom4fLrKhkTvWdie3/mZqv
	Tjokl6fvTE5Q==
X-Google-Smtp-Source: AGHT+IHZ9zn71hNPT073Seajv5QnbK+at0Y15ixdVsmdFgRf5ISg78/Yg+aTci4yWLn61MO0cOt5KTcxEdtKgnYuIoU=
X-Received: by 2002:a17:907:a317:b0:abe:fd0c:68a8 with SMTP id
 a640c23a62f3a-abefd0c7853mr416229466b.52.1740601459612; Wed, 26 Feb 2025
 12:24:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217053719.442644-1-vignesh.raman@collabora.com> <20250217053719.442644-4-vignesh.raman@collabora.com>
In-Reply-To: <20250217053719.442644-4-vignesh.raman@collabora.com>
From: Helen Mae Koike Fornazier <helen.fornazier@gmail.com>
Date: Wed, 26 Feb 2025 17:24:08 -0300
X-Gm-Features: AQ5f1JoEGij5s02EkXcJQX2XuiqAewaehTaMPjCiNOd3tf5DXYODa9_T83CTx04
Message-ID: <CAPW4XYZ-yinJovLJDCPoriOLyV-q2V7JdFktkiAZK7Uwh8zmVg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/ci: enable lockdep detection
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, airlied@gmail.com, 
	simona.vetter@ffwll.ch, robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
	jani.nikula@linux.intel.com, dmitry.baryshkov@linaro.org, mripard@kernel.org, 
	boqun.feng@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em seg., 17 de fev. de 2025 =C3=A0s 02:37, Vignesh Raman
<vignesh.raman@collabora.com> escreveu:
>
> We have enabled PROVE_LOCKING (which enables LOCKDEP) in drm-ci.
> This will output warnings when kernel locking errors are encountered
> and will continue executing tests. To detect if lockdep has been
> triggered, check the debug_locks value in /proc/lockdep_stats after
> the tests have run. When debug_locks is 0, it indicates that lockdep
> has detected issues and turned itself off. Check this value, and if
> lockdep is detected, exit with an error and configure it as a warning
> in GitLab CI.
>
> GitLab CI ignores exit codes other than 1 by default. Pass the correct
> exit code with variable FF_USE_NEW_BASH_EVAL_STRATEGY set to true or
> exit on failure.
>
> Also update the documentation.
>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Acked-by: Helen Koike <helen.fornazier@gmail.com>

> ---
>
> v2:
>   - Lockdep failures are reported as pipeline warnings,
>     and the documentation is updated.
>
> v3:
>   - Add a common job for exit code handling and extend it in other jobs.
>
> ---
>  Documentation/gpu/automated_testing.rst |  4 ++++
>  drivers/gpu/drm/ci/igt_runner.sh        | 11 +++++++++++
>  drivers/gpu/drm/ci/test.yml             | 17 ++++++++++++++---
>  3 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gpu/automated_testing.rst b/Documentation/gpu/=
automated_testing.rst
> index 6d7c6086034d..62aa3ede02a5 100644
> --- a/Documentation/gpu/automated_testing.rst
> +++ b/Documentation/gpu/automated_testing.rst
> @@ -115,6 +115,10 @@ created (eg. https://gitlab.freedesktop.org/janedoe/=
linux/-/pipelines)
>  5. The various jobs will be run and when the pipeline is finished, all j=
obs
>  should be green unless a regression has been found.
>
> +6. Warnings in the pipeline indicate that lockdep
> +(see Documentation/locking/lockdep-design.rst) issues have been detected
> +during the tests.
> +
>
>  How to update test expectations
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_ru=
nner.sh
> index 68b042e43b7f..2a0599f12c58 100755
> --- a/drivers/gpu/drm/ci/igt_runner.sh
> +++ b/drivers/gpu/drm/ci/igt_runner.sh
> @@ -85,5 +85,16 @@ deqp-runner junit \
>     --limit 50 \
>     --template "See $ARTIFACTS_BASE_URL/results/{{testcase}}.xml"
>
> +# Check if /proc/lockdep_stats exists
> +if [ -f /proc/lockdep_stats ]; then
> +    # If debug_locks is 0, it indicates lockdep is detected and it turns=
 itself off.
> +    debug_locks=3D$(grep 'debug_locks:' /proc/lockdep_stats | awk '{prin=
t $2}')
> +    if [ "$debug_locks" -eq 0 ] && [ "$ret" -eq 0 ]; then
> +        echo "Warning: LOCKDEP issue detected. Please check dmesg logs f=
or more information."
> +        cat /proc/lockdep_stats
> +        ret=3D101
> +    fi
> +fi
> +
>  cd $oldpath
>  exit $ret
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 0eab020a33b9..dbc4ff50d8ff 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -1,6 +1,14 @@
> +.allow_failure_lockdep:
> +  variables:
> +    FF_USE_NEW_BASH_EVAL_STRATEGY: 'true'
> +  allow_failure:
> +    exit_codes:
> +      - 101
> +
>  .lava-test:
>    extends:
>      - .container+build-rules
> +    - .allow_failure_lockdep
>    timeout: "1h30m"
>    rules:
>      - !reference [.scheduled_pipeline-rules, rules]
> @@ -69,6 +77,7 @@
>    extends:
>      - .baremetal-test-arm64
>      - .use-debian/baremetal_arm64_test
> +    - .allow_failure_lockdep
>    timeout: "1h30m"
>    rules:
>      - !reference [.scheduled_pipeline-rules, rules]
> @@ -91,6 +100,8 @@
>
>  .software-driver:
>    stage: software-driver
> +  extends:
> +    - .allow_failure_lockdep
>    timeout: "1h30m"
>    rules:
>      - !reference [.scheduled_pipeline-rules, rules]
> @@ -153,7 +164,7 @@ msm:apq8016:
>      BM_KERNEL_EXTRA_ARGS: clk_ignore_unused
>      RUNNER_TAG: google-freedreno-db410c
>    script:
> -    - ./install/bare-metal/fastboot.sh
> +    - ./install/bare-metal/fastboot.sh || exit $?
>
>  msm:apq8096:
>    extends:
> @@ -167,7 +178,7 @@ msm:apq8096:
>      GPU_VERSION: apq8096
>      RUNNER_TAG: google-freedreno-db820c
>    script:
> -    - ./install/bare-metal/fastboot.sh
> +    - ./install/bare-metal/fastboot.sh || exit $?
>
>  msm:sdm845:
>    extends:
> @@ -181,7 +192,7 @@ msm:sdm845:
>      GPU_VERSION: sdm845
>      RUNNER_TAG: google-freedreno-cheza
>    script:
> -    - ./install/bare-metal/cros-servo.sh
> +    - ./install/bare-metal/cros-servo.sh || exit $?
>
>  msm:sm8350-hdk:
>    extends:
> --
> 2.43.0
>


--=20
Helen Koike

