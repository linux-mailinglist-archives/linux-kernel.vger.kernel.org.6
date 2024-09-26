Return-Path: <linux-kernel+bounces-341042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01303987AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62035B249CB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7CA186E39;
	Thu, 26 Sep 2024 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m9fpQhKC"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F4183CD6
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727386168; cv=none; b=m5YRBayFTyM0YaIOIovy+pKuTtwuCpOySyRuaGOM+vaZ2PSd157xyyxTRNiUKF29l7uNmZYhRCo6O4RwtWNr3WfkQrGVlbl3GxKzb2wFmyaBUW3gO1R9zdH0lF9AYlDJAaCMSYMAQnWd7jWv6Zk8OfLKpdsgG7VQ7GplK+2fOqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727386168; c=relaxed/simple;
	bh=xqFq4RQYxYh3u9MLZ5kVqT1d0qeMIn5tA9drEqhxvR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUD5y5G7eKyFAyPR4cgK1c4lQSMx4IgYyDx7h5PCF0uEECg6RLNgJS9IO5hd012l9RP8pIsXO47kFWXC+Gidn050sDyyo2Zd86VjyXTt7RtGecR/72ipRDn5ZzFgZ3Vb+NPX62YkwBRYbHbbKHpmF1BLmCjTbFlm/91EazYaYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m9fpQhKC; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cb25aad5dfso11274586d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727386165; x=1727990965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j+swCKlfoXljh1Hu/0Qrpjoy4tGhDYS+cmjUv5wcQ0g=;
        b=m9fpQhKCCcNTUR5NB0NjA/VY0g58moH+YGHI9+2UWDDwCtdLKA9SuqD/gOx6g1smaj
         H0VybX9qBh+J3/0vZkL1mhbJijOW/hCT41pIh71qD9RxaYEphmlaVHp5wYS5d/cCZNPI
         wULq8XNbsfPihnsNSlgmqWm4qRJg6UqRGy0z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727386165; x=1727990965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+swCKlfoXljh1Hu/0Qrpjoy4tGhDYS+cmjUv5wcQ0g=;
        b=S4yRVmTIpED3wlVoqNeyld6iYxSeJb9Tlhi7+W2lanJcBifrsVEzS4A/6quny6VRNc
         aalWUl9288is2eK5GDMc8g2xe7/pJ6HI+xy2S/DQKxzY0dsjoPGFRH644IyvX+0OsqWP
         56pGTYiRGq+BD8Q9KIwrBXQLRFx1+tYWyb/Wm+Ba+EWjyMXNZY63d9mgdMYYsXffJlZV
         E4EfsIsW6OZ03Po4IJNFDskDn957AAeBtIhQIMRoHTFBzQJvCIOwSDtBXQgjEYwOFgBd
         +l+CsMrB23TV/cok5sstdXRJFpNs2BdAz/anaJjUQtNOt8mRzKuZPI+AfL+R1xZiTLiX
         AU5w==
X-Forwarded-Encrypted: i=1; AJvYcCV/uuI5XlTUZdR0JZvBP++592Zyuge8OistWmz6XKkYsgT3ctjwa6NY8RxqPHGTaJ7TxujXH7SSbYkHglY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYN/QYNjU4z/FJKI5Yt9VrToHnV4kq/yiOpBAJz6H9Q3kePfnn
	soWdtRzVJI7g41AeCM9VgPfajm6/K1BnIYTtcD6Zk8Q43wYPfttoBTo+vrlnrSdh/j3nN48zqYW
	tNUbISGwEmpFo3qsImg46x9mxAiOjJV1NqiB/
X-Google-Smtp-Source: AGHT+IFJ2huc7rd6dPx1SGjSzSK0AKd3XeVgNspJCXTwvGlRQYEnb8R+RueAxRyyqxI2e+Yg2jHjhagmicTQnQvJRvY=
X-Received: by 2002:a05:6214:14a8:b0:6cb:3e17:f4cc with SMTP id
 6a1803df08f44-6cb3e17f54bmr1186906d6.31.1727386165372; Thu, 26 Sep 2024
 14:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926080021.148031-1-patrick.rudolph@9elements.com> <20240926080021.148031-37-patrick.rudolph@9elements.com>
In-Reply-To: <20240926080021.148031-37-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:29:12 +0200
Message-ID: <CAFLszTgNiRAh3bo26avy+tPZvu9L1R=CuFKJP4LBCJ0gdXfb0Q@mail.gmail.com>
Subject: Re: [PATCH v5 36/36] azure-pipelines: Enable qemu_sbsa
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 10:12, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add QEMU's SBSA ref board and run tests on it.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  .azure-pipelines.yml | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Should add gitlab too?



>
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
> --
> 2.46.0
>

