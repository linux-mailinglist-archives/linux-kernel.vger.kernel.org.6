Return-Path: <linux-kernel+bounces-534885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB018A46C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F0E188CD6A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005C621D59E;
	Wed, 26 Feb 2025 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt+BcnVl"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862502755E6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601400; cv=none; b=Cu3OYEftc/RE2btTjna7BIwmezeM3NwuO9QpXcC4+NXZChULLlEY0/7toAfczg4ISJuB/vB9gBTriLhdyuYZ/fDy663nJhwZwCd5QjvSwN+UaovLthEiyAXUpuxtCyrt76w6kRut7XmZ//4nzZC3LxxkWMmXVV8TAhpe5E+FOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601400; c=relaxed/simple;
	bh=wJPDaf8JlJ/T8/czQb7S/knJzc2yV5bD/T3Df3fyjPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Da1ib/p2oR3Z3qLfhlG+UqiFJcDyXNmdrDBIG8zshx0rUiIyNlhhKkM3OmCt8unzuVnhqRq0EmC6YLL4X3oHQsKuB/dv0gIQTF0iridePxP/u8Y0QXI1+Y1/mSZdweYc4ozk9b3ngK7hvCpJzR4ejWRayRzX98QNH6/77OosxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mt+BcnVl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb9709b5b5so23733966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740601397; x=1741206197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hv3d4DyrXa2wa/xE8OSCNIM8w3UTF+Jeuiot7/Rh1Kw=;
        b=Mt+BcnVlyxQQkLJSCym4VN4DOlqjmZEM6nPb7l0n3rrPfpilbENvN7YHK/Zx7GrKuV
         TfRM8E3reWBY58VddNcSw6TD69VTeRhvCThjur9TeOg7FlivL+OIuGJZAftoonxWVcKa
         HP3iJRtDiIYP28GsaZ/0/6GjtDOb6KfG3fsgSmjOsQzXYbwJxunqK6qp8dnlef7uQrKc
         5GEUY4FYf2VH39FJzyf+ZyLEW/FmTol0JqDCQIuo7QRGoSqenBffqwKcTNK+LnIOOFUf
         db+E4Is8LlBlgDvnHxXCpTmPk+0Vk06eRH+Y+vP62cf9pNYudFjXPs7RsiOcxokPbImy
         TqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740601397; x=1741206197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hv3d4DyrXa2wa/xE8OSCNIM8w3UTF+Jeuiot7/Rh1Kw=;
        b=aTlQY+D7G/7u76KGO8tzoMtBy/cekGBIC1/XqYV+rRDdei4PAog3/wl0a5gAlbqzFo
         3wS/KgmCJBS/7gNZjWJFQ08+MLnJhdlTnELBzn+CNjQhmjJe6w32TfDZGWXM784lN1g6
         7DwPLFW/V1uqD4DWlgFf+i/wAMQxuMc4f2Pcq4lk+OXIDyKsbFB8Hee0JMtFqBVuKsFZ
         M6/UHlD3rrC/o+oRKbhN6MMiF8hsBVdfmp4vWVKll4/4i/f57hnNFm5q91oI3VgPTXYm
         bwMi0nApYt4QDUJg1/jVA1Rb8hg9BwcSmr4W+o0H1cYQSeQiyXRRmKdNCM+mZe64agK3
         /XnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJrIP+YW0xZfvGr7j2LTU0PibnKDwedbC0eOOW5bxypJUjtCKul96S611yldMbOGVYo0H0lzU73ezNr78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfX13mJhVeqtBAiK+RAEITi+SrewqYu/QgfGKyhlXfuvU9jBYP
	I4kpErMh3xg5jdyJUPFdBUx2WtzVrDzDT/pMSuadIIjZCbq9g3g14LBScZ2eoNtv7xJw4J9Sgnz
	z6T7G7qCIY0Mq6AvSTicnfGhl5aI64fOeU9oBpw==
X-Gm-Gg: ASbGncupkDuuhYBR1ll3iYLvHUTOktqyhk9wuLciV7DGI/aECc3B+lPHdgaaYdke2AC
	FSQY2bbENWQydE9ee8b2866LbHQCIgTIIysZf38hHTgEEvXKovBGyqGoOqBs527RNzi9vh0h2y+
	AWIqJE0K6JiQ==
X-Google-Smtp-Source: AGHT+IGcsknzYjLwND3bc1sPcXNQvaTyzDm2Bjz/NgjyNqfZjWbfKQaEhvo+HzC0+4k8y8v3Za1vyra69VerEi8lBQY=
X-Received: by 2002:a17:907:97cd:b0:abc:28a5:cbe2 with SMTP id
 a640c23a62f3a-abed10fa38dmr1042739166b.55.1740601396636; Wed, 26 Feb 2025
 12:23:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217053719.442644-1-vignesh.raman@collabora.com> <20250217053719.442644-2-vignesh.raman@collabora.com>
In-Reply-To: <20250217053719.442644-2-vignesh.raman@collabora.com>
From: Helen Mae Koike Fornazier <helen.fornazier@gmail.com>
Date: Wed, 26 Feb 2025 17:23:02 -0300
X-Gm-Features: AQ5f1JpoHXHT8WUgEiQgQiVgMuwnc--RICCLBb6XnGOBifRcYHDlqacEmmL5AQ4
Message-ID: <CAPW4XYbzAT6P4R83ZJOWFf8v0kPvP1eM1gg0=La9Nu4psCtKKA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/ci: refactor software-driver stage jobs
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
> Move common job configuration for software-driver
> stage jobs to separate job.
>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Acked-by: Helen Koike <helen.fornazier@gmail.com>

> ---
>
> v2:
>   - New patch in the series.
>
> v3:
>   - No changes.
>
> ---
>  drivers/gpu/drm/ci/test.yml | 59 +++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 6a1e059858e5..0eab020a33b9 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -89,6 +89,26 @@
>    tags:
>      - $RUNNER_TAG
>
> +.software-driver:
> +  stage: software-driver
> +  timeout: "1h30m"
> +  rules:
> +    - !reference [.scheduled_pipeline-rules, rules]
> +    - when: on_success
> +  extends:
> +    - .test-gl
> +  tags:
> +    - kvm
> +  script:
> +    - ln -sf $CI_PROJECT_DIR/install /install
> +    - mv install/bzImage /lava-files/bzImage
> +    - mkdir -p /lib/modules
> +    - install/crosvm-runner.sh install/igt_runner.sh
> +  needs:
> +    - debian/x86_64_test-gl
> +    - testing:x86_64
> +    - igt:x86_64
> +
>  .msm-sc7180:
>    extends:
>      - .lava-igt:arm64
> @@ -440,47 +460,16 @@ panfrost:g12b:
>      - .panfrost-gpu
>
>  virtio_gpu:none:
> -  stage: software-driver
> -  timeout: "1h30m"
> -  rules:
> -    - !reference [.scheduled_pipeline-rules, rules]
> -    - when: on_success
> +  extends:
> +    - .software-driver
>    variables:
>      CROSVM_GALLIUM_DRIVER: llvmpipe
>      DRIVER_NAME: virtio_gpu
>      GPU_VERSION: none
> -  extends:
> -    - .test-gl
> -  tags:
> -    - kvm
> -  script:
> -    - ln -sf $CI_PROJECT_DIR/install /install
> -    - mv install/bzImage /lava-files/bzImage
> -    - install/crosvm-runner.sh install/igt_runner.sh
> -  needs:
> -    - debian/x86_64_test-gl
> -    - testing:x86_64
> -    - igt:x86_64
>
>  vkms:none:
> -  stage: software-driver
> -  timeout: "1h30m"
> -  rules:
> -    - !reference [.scheduled_pipeline-rules, rules]
> -    - when: on_success
> +  extends:
> +    - .software-driver
>    variables:
>      DRIVER_NAME: vkms
>      GPU_VERSION: none
> -  extends:
> -    - .test-gl
> -  tags:
> -    - kvm
> -  script:
> -    - ln -sf $CI_PROJECT_DIR/install /install
> -    - mv install/bzImage /lava-files/bzImage
> -    - mkdir -p /lib/modules
> -    - ./install/crosvm-runner.sh ./install/igt_runner.sh
> -  needs:
> -    - debian/x86_64_test-gl
> -    - testing:x86_64
> -    - igt:x86_64
> --
> 2.43.0
>


--=20
Helen Koike

