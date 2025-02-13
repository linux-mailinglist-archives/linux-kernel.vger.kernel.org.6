Return-Path: <linux-kernel+bounces-512928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8F1A33F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87051168822
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB74221577;
	Thu, 13 Feb 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ5fyII0"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C5221579
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450634; cv=none; b=pIfwTPQafXx8M/9hqg58UVQretOb647NgwEhWsL2MagJFNC/EStOthTKQrc9tZ0PJTJ973WwMSZMqa24qcRDfFdU4Ws6L4IWCpNuqWCBOvDmhcDBEzhXkEgqYj+GVdG6o39hVA34OmOQV11wLzmwZssEMylnmMmbiTRipnsMp+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450634; c=relaxed/simple;
	bh=Tif10vlrcrWJS8mnrSxzavy5vN6oFFZ+VvAgRncHeO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBgAouVOy6JkgZoq7AyPG4Nijna0xQm8vlghTpZbbg2d9R6XFdvZ0Yt0iUVduuOUYumgG2hwQEhV39hVMPJxlN8ChEqjFiK9mKpPXd+q+26wlH2xOuIrEQruai2Gi4vGCeWsY2/PByHGkTRo5odlHYO2UJ/LPuuxzxREPhi8c8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ5fyII0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so872667a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 04:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739450631; x=1740055431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XjKKYlWXb6xupzizzPwV1OMDDEKmqUSqaArwd7zvko=;
        b=YQ5fyII0KVmDBkSbiX1K5WFyB5xuel/9asm1+LYlef7XelCSzC/5XckkDkD7YYAMzK
         kVtMqV7ccuxL4dmuPa9MrrrfcscVEPfvcVxHHqMhQA6q8e22tERorlDQxD13NrLoJ8mZ
         n8aq2Pa5l9hMsHAanghX82ScS4icZPtPTz/kmdwcDLwhwy8d2y8/XIqE22GosRATTyjX
         flU0Zc0Eg8iAAO0ndj8haxXLDqti++yd5XGOSFDpEUHpxQzVD14OgVcinrMj7BNZA+R9
         x+o+ynG7g2N7u+gEkFzf3tjPVdtxys4kS9ZUtIXSl+kWv6NMWt6eXjdi0dv75V6yB8k6
         aWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739450631; x=1740055431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XjKKYlWXb6xupzizzPwV1OMDDEKmqUSqaArwd7zvko=;
        b=pyM6TUGB9sffv7l9wPZH9FfuFHFUFHxiFGwArG49lB11JZRhGZWGSR5wp4SFmj6lXt
         pTh0IWLMyhsWErFJMkA34p0mGEd4W79vEZiaYkXPsPQFKc4vTN31Ratw9+XIkzEEgnvu
         EFFxjjcJGa/LjkTYZYbyVVosPzqx3SGElfZ3rpfFvhKMzHqKfcSJhGzVWDctKuhDVUiG
         5lelMHEmpcdeeaxskIoV0AZsuVzXHCD6O9LXANnsGJ3O85htAGPIbo6RFyiNvLqqYUVb
         22q+/HcRS0R4r+/NmK1HFavwYsK9W4nQD+yCne5uU+ngID0YOcKL6NT4DYe+L1qegX5r
         DQtw==
X-Forwarded-Encrypted: i=1; AJvYcCXPZpmv/MSvlsqzXn7SlvytDeSxZOK+ikEkosjEODLQvm/m7FKjzqswcZGO9nx1FoDHT9kuOjJ4K+yT6ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYkfIUG7L4/0gIV1Cih5CrxVqPMu0pyT68RsrRvmZWhSvBVsg6
	FL/hf/UlMS8F65ksJVE3Oh56BZ8iabgTQbb5o7MBrZDrjsjFLUBZIxiE5/p68bRI03lqJRq8iFw
	+6Ir7NRIugm+mP7BKRsvJ/FIoLEk=
X-Gm-Gg: ASbGncsKiS2MDvXdOldTs6Kp0yUAaq+VHeteldRyEtJJEMvIH4FUDOtqx3JVrLr6k2I
	4hmbQu/GU2keMN/bmVB9zvBoIH7dzp1TJt9x/VqbDz+EqXWibsofR+sUx0BX/fdjyYYaqqZjLAo
	M=
X-Google-Smtp-Source: AGHT+IFOw0kNCJFvrzKPyY1j6HibE6TL5bfUxYtzxWEfNrqyHD/MWFpjH/Bqtwv4+uWz3RPHu41mqOu5jSp87zpWBX0=
X-Received: by 2002:a05:6402:3905:b0:5dc:c9ce:b022 with SMTP id
 4fb4d7f45d1cf-5dec9e793c6mr2867061a12.9.1739450630923; Thu, 13 Feb 2025
 04:43:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211152812.54018-1-vignesh.raman@collabora.com> <20250211152812.54018-4-vignesh.raman@collabora.com>
In-Reply-To: <20250211152812.54018-4-vignesh.raman@collabora.com>
From: Helen Mae Koike Fornazier <helen.fornazier@gmail.com>
Date: Thu, 13 Feb 2025 09:43:39 -0300
X-Gm-Features: AWEUYZluT3Wkd1PZxazm6bk_o2BFn8FJ-1pTiFEGh_ywmnPSgc6YNgpHF_7ceUE
Message-ID: <CAPW4XYZtj7HRhoeOfYguZBEnbqpbRscKrXTn5821aAxvcqNb0g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/ci: enable lockdep detection
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, airlied@gmail.com, 
	simona.vetter@ffwll.ch, robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
	jani.nikula@linux.intel.com, dmitry.baryshkov@linaro.org, mripard@kernel.org, 
	boqun.feng@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vignesh,

thanks for your patch.

Em ter., 11 de fev. de 2025 =C3=A0s 12:29, Vignesh Raman
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
> ---
>
> v2:
>   - Lockdep failures are reported as pipeline warnings,
>     and the documentation is updated.
>
> ---
>  Documentation/gpu/automated_testing.rst |  4 ++++
>  drivers/gpu/drm/ci/igt_runner.sh        | 11 +++++++++++
>  drivers/gpu/drm/ci/test.yml             | 19 ++++++++++++++++---
>  3 files changed, 31 insertions(+), 3 deletions(-)
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
> index 0eab020a33b9..3af735dbf6bd 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -1,6 +1,8 @@
>  .lava-test:
>    extends:
>      - .container+build-rules
> +  variables:
> +    FF_USE_NEW_BASH_EVAL_STRATEGY: 'true'
>    timeout: "1h30m"
>    rules:
>      - !reference [.scheduled_pipeline-rules, rules]
> @@ -13,6 +15,9 @@
>      - mv -n install/* artifacts/.
>      # Override it with our lava-submit.sh script
>      - ./artifacts/lava-submit.sh
> +  allow_failure:
> +    exit_codes:
> +      - 101

Maybe we could have this rule more generically instead of just in lava,
so we can re-use it in other jobs as well and we don't need to repeat it.


Regards,
Helen

>
>  .lava-igt:arm32:
>    extends:
> @@ -88,9 +93,14 @@
>      - igt:arm64
>    tags:
>      - $RUNNER_TAG
> +  allow_failure:
> +    exit_codes:
> +      - 101
>
>  .software-driver:
>    stage: software-driver
> +  variables:
> +    FF_USE_NEW_BASH_EVAL_STRATEGY: 'true'
>    timeout: "1h30m"
>    rules:
>      - !reference [.scheduled_pipeline-rules, rules]
> @@ -108,6 +118,9 @@
>      - debian/x86_64_test-gl
>      - testing:x86_64
>      - igt:x86_64
> +  allow_failure:
> +    exit_codes:
> +      - 101
>
>  .msm-sc7180:
>    extends:
> @@ -153,7 +166,7 @@ msm:apq8016:
>      BM_KERNEL_EXTRA_ARGS: clk_ignore_unused
>      RUNNER_TAG: google-freedreno-db410c
>    script:
> -    - ./install/bare-metal/fastboot.sh
> +    - ./install/bare-metal/fastboot.sh || exit $?
>
>  msm:apq8096:
>    extends:
> @@ -167,7 +180,7 @@ msm:apq8096:
>      GPU_VERSION: apq8096
>      RUNNER_TAG: google-freedreno-db820c
>    script:
> -    - ./install/bare-metal/fastboot.sh
> +    - ./install/bare-metal/fastboot.sh || exit $?
>
>  msm:sdm845:
>    extends:
> @@ -181,7 +194,7 @@ msm:sdm845:
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

