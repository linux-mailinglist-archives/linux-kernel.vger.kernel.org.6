Return-Path: <linux-kernel+bounces-348350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD15098E67D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4AE1F220CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E693D19D8B5;
	Wed,  2 Oct 2024 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NZgHdcNy"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE23319CC09
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909751; cv=none; b=koB1/WzxzV3E9o21yoMPNaPMF0tZDsH/i5xCGjpNuCVcSrQ0hZ+5eFRKaqpdD8Hyg+FZUn7pVfE425+qnDZD8g06kWfgjZH0GBHlq1biJqokQqjhTOZm270K+q3pDU6K9bfvrULvzLvr1XBF9hcRyPlYXDbCBAie2Pc/EluUSJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909751; c=relaxed/simple;
	bh=eFXk5jqXabA4x1AkT8Ur/RWt83dP3PB4Z0V4WUSDShQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFscYHipK0dGdNnWiRqz8SrUzWLlrlEcyqkMVN5X7ONxei97AVoPG+Mg4qQksuCxEasCKm0DIl3qTy7CMupN8Hl+uaOQUre3TN+M0tYGuvMSdfM4xZtwEVVm+AQa+mHDYZnwE6Z0zv1sZTlwlReydpmZUSCsswpQZ0Y1uLpQeD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NZgHdcNy; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cb35f2aec1so2554566d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727909748; x=1728514548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w0wRBiF9Rrq/nk1qOOkidGdoqSZa5Yv+cMyCurX9NgE=;
        b=NZgHdcNySzPwv2pXqCiEe2icA7TpyC7zpHpawCzThNTu6qg2MwM+PGCxFgF2vFWNnx
         /DqeHs7eKPfgeBSunbgUihXD7wkAG2ZuAcdQFXg27J8hN7X205OC6S97t4VZ6QvOSv9X
         e50oT7Ljb+stBzqmzRIsemB0DFqwGiuwB0vQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727909748; x=1728514548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0wRBiF9Rrq/nk1qOOkidGdoqSZa5Yv+cMyCurX9NgE=;
        b=BXmz66JEeURQ0bpJo77KqogLFCTeYswQE4Q8rAIYFG0Jf7aQOfsAQza7VvItV6q5TU
         vUf50obb8Pn/b2gJwEm6B6GqTD9VNcM4RX4ZJ+NDV2TWQB5OzIhIghzd6rJafLLzf+4J
         jXHUNp0Zf7tJKep9SHRva45QTWbHgiIG45tC3tC6aiM0oRCWm1GKNs+WXZP1N/euAJHQ
         z30hrmi790A+f16+B9Cegll3rdv1USRFVXw9Jzt/YIjqKEcmowqcFKPBQ+hR9/IUmVvb
         Qo0cd6iv32IVbdIklL8QRDdigqztEI6ljvbdn5jjCvemPqNvTX1tq72mhpnP5RsBoYCa
         jtqA==
X-Forwarded-Encrypted: i=1; AJvYcCXPo+IETKaWkMNmeJ+3XWHNJhgdcJ/SwrOFYqMhdEKWOoTh7tBaPl59yjiyyH4mSjezIyngaPffY9qMlmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCWLnRLGsKqLAxTCQp/q9WS3BUf2/eyGdMpKhf0BtXMpXJBcoR
	vsJH1b/RLfJoksq0b9hDmLc8Js+F52JlVuRZ8tZbfC3CNomgH6szkmsOieoKezG1+5wKgddmolp
	cCGMX4Jx8JbQ40wii9zuq439IWT++eNRmm1xj
X-Google-Smtp-Source: AGHT+IHL1HC5Bxh89FeivUSbspMXQhnq7+8AMWkPyBQ6rmdnNoLUr8vpMrliTrhS9SBZSxg6Mtwdp4u2L+3mxPdxQnU=
X-Received: by 2002:a05:6214:3c98:b0:6cb:3c08:30a0 with SMTP id
 6a1803df08f44-6cb81cc8093mr76540236d6.49.1727909748611; Wed, 02 Oct 2024
 15:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002094832.24933-1-patrick.rudolph@9elements.com> <20241002094832.24933-38-patrick.rudolph@9elements.com>
In-Reply-To: <20241002094832.24933-38-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Oct 2024 16:55:38 -0600
Message-ID: <CAFLszTgKa46eQsf=RpEsKoiOW7CsFj-8aK5xTCfQ7H1PGG35Xw@mail.gmail.com>
Subject: Re: [PATCH v6 37/37] CI: Enable qemu_sbsa
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 03:58, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add QEMU's SBSA ref board to azure pipelines and gitlab CI to run tests on it.
> TEST: Run on Azure pipelines and confirmed that tests succeed.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
> Changelog v6:
> - Add gitlab CI support
> ---
>  .azure-pipelines.yml |  8 ++++++++
>  .gitlab-ci.yml       | 11 +++++++++++
>  2 files changed, 19 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 93111eb612..2881851ecf 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -250,6 +250,11 @@ stages:
>                wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
>                export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
>            fi
> +          if [[ "\${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
> +              wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
> +              wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
> +              export BINMAN_INDIRS=/tmp
> +          fi
>            # the below corresponds to .gitlab-ci.yml "script"
>            cd \${WORK_DIR}
>            export UBOOT_TRAVIS_BUILD_DIR=/tmp/\${TEST_PY_BD}
> @@ -415,6 +420,9 @@ stages:
>          qemu_arm64:
>            TEST_PY_BD: "qemu_arm64"
>            TEST_PY_TEST_SPEC: "not sleep"
> +        qemu_arm_sbsa_ref:
> +          TEST_PY_BD: "qemu-arm-sbsa"
> +          TEST_PY_TEST_SPEC: "not sleep"
>          qemu_m68k:
>            TEST_PY_BD: "M5208EVBE"
>            TEST_PY_ID: "--id qemu"
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 7d621031b8..3f02a492d5 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -39,6 +39,11 @@ stages:
>          wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
>          export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
>        fi
> +    - if [[ "${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
> +        wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
> +        wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
> +        export BINMAN_INDIRS=/tmp
> +      fi
>
>    after_script:
>      - cp -v /tmp/${TEST_PY_BD}/*.{html,css,xml} .
> @@ -344,6 +349,12 @@ qemu_arm64 test.py:
>      TEST_PY_TEST_SPEC: "not sleep"
>    <<: *buildman_and_testpy_dfn
>
> +qemu_arm_sbsa test.py:
> +  variables:
> +    TEST_PY_BD: "qemu-arm-sbsa"
> +    TEST_PY_TEST_SPEC: "not sleep"
> +  <<: *buildman_and_testpy_dfn
> +
>  qemu_m68k test.py:
>    variables:
>      TEST_PY_BD: "M5208EVBE"
> --
> 2.46.2
>

