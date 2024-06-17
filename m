Return-Path: <linux-kernel+bounces-216961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D312090A932
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F7F7B270FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC6219149D;
	Mon, 17 Jun 2024 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kuUPzegr"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E95191487
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615474; cv=none; b=fZaTF7QluC7nr7rgepKHbceoYScCEfknSNOWxcNAfgDux8eJRw3iN0MeHYA2T/f0CGEy3aP9wn2iC2KTH6lsNCsfQRUglCOebgt8VV7K+csaesM9hfLe38m2s7IJYI2JZyKq8lbaV431hUGBbZGyfQSuKdWwQdkKFuZet5LcvJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615474; c=relaxed/simple;
	bh=xiqMCvALfitq6gqhML0HanhNYhLYokK24+duP6/gN70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxmFYT7ymNVf0T3yQQSY+i/zyXcZkW5Jdv5h83Ux1qZqAzIZzIPG9ic7NqbQ5t1DSoVqg5VotHutotI7dPNGOCKLK2KuBMQhSvnhPLqLY48WQ6YYBGXgGZ8b+3Lc5plYFWKvHXlprCQA1gouAuNMSI3popZa3/VzPuUZtbZ1bfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kuUPzegr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52c89d6b4adso3813410e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718615470; x=1719220270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpTLDyvCYaFxuBfvH84svdUv4llKayr1HsnUqo2woZU=;
        b=kuUPzegro9eWz5sjBE/wGy199FU9GunqSRp8NaHVUe247B2+Kz2mamnsEW5YCojwW+
         vsDJdT2RfODpwBKxAK8URXEM0xfGX9gwJbnFXqmo113u8YopPwx7Ilz51E8i/mEUhbFC
         6WjWqvE5C/Pe5RiKVSoOZ9IhMjF22tYvb8co5krc9Cg1/6/NVz/rxW0s8QUtEhTUJzLk
         d9AXd8CWxwA/y2Aoy9Ik+SlTHg8gpDQ6lRqN+vymsLzFKqLkMBlabppE1A8g4zj9Icre
         GQyb1EsMtabCERBPYNnbyfW5DT5K/eJNzho59YoYyRThCVnUG1xMeVaKOBFe0s4jVojV
         vd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615470; x=1719220270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpTLDyvCYaFxuBfvH84svdUv4llKayr1HsnUqo2woZU=;
        b=kPep/ltbriCJ5Yvzb4xpUfT7QbFrEyo4hPLokVRaHZnii8zNpM1r1u+he2U+C+Ma05
         Gn3Fu+KTTXc+mLCgtjmN/I3kbt5JNiegg/pxPB68cl9+VwWy9xfXKXtcOv8uh0cUmNk+
         nyvFsRBAcq1wrfyc0ELDwc8spAbt+jjiAvwTrwTTw/BMNXDjWzLanDv+FmUwE5p/58p5
         EBumJVgJ6qBi462uetNxgRsFg/UN5xKfKUFCv/jR1HD1GYl6IKHoZW8FrG0aTsxX4kn0
         rJvLWy/VGwMQSMuZw566DpaY5TFlDo78QtFCnl8Ymu7CdQKuPYxwwc+M1wx9rlLdcoxk
         OQYg==
X-Forwarded-Encrypted: i=1; AJvYcCXtLKKwwPad3bo2ePNKMc4EeQnvuGz+Ma4di7oXART99guSOiWXyUXmQ9E08yg6tPI66iiOZfxPWvaUrxbYK4sNnSfadJ61NzRr7iZn
X-Gm-Message-State: AOJu0Yxk0CEjyk1fbHXWGxJWmwBv+mw1A7SOwPnSW0JJqYqsp8+EZago
	4npwnimdqyyFA1asXo7gaV4MxXMoj/uYMj6nuCBQC4u7ND7DQGeNxAOFdFT+V+vBlYv0BIdX4jl
	yKBhBhWsjQXJfsV1ZTiiamQhmQ3eJeyeBygC8XA==
X-Google-Smtp-Source: AGHT+IGeRJHP0TcBprcLVK3h+RJ1DP+BlSOB3+uNeQEhD1M8wUzaJmIgdjVHXch7ltaGznllvYCX1BS6ebnN2g7+3yU=
X-Received: by 2002:a05:6512:ba1:b0:52c:be4f:1e67 with SMTP id
 2adb3069b0e04-52cbe4f1eeamr896865e87.24.1718615470514; Mon, 17 Jun 2024
 02:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605122729.24283-1-brgl@bgdev.pl>
In-Reply-To: <20240605122729.24283-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 17 Jun 2024 11:10:59 +0200
Message-ID: <CAMRc=MfJkMUtXf96-MKPme=MH4nt71UjH-0DYyMTc_t7tvT7Gw@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] arm64: dts: qcom: add WiFi modules for several platforms
To: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 2:27=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Hi!
>
> Here are the DTS changes for several Qualcomm boards from the
> power-sequencing series. To keep the cover-letter short, I won't repeat
> all the details, they can be found in the cover-letter for v8. Please
> consider picking them up into the Qualcomm tree. They have all been
> thorougly tested with the pwrseq series.
>
> Changelog:
>
> Since v8:
> - split the DTS patches out into their own series
> - Link to v8: https://lore.kernel.org/r/20240528-pwrseq-v8-0-d354d52b763c=
@linaro.org
>
> Since v7:
> - added DTS changes for sm8650-hdk
> - added circular dependency detection for pwrseq units
> - fixed a KASAN reported use-after-free error in remove path
> - improve Kconfig descriptions
> - fix typos in bindings and Kconfig
> - fixed issues reported by smatch
> - fix the unbind path in PCI pwrctl
> - lots of minor improvements to the pwrseq core
>
> Since v6:
> - kernel doc fixes
> - drop myself from the DT bindings maintainers list for ath12k
> - wait until the PCI bridge device is fully added before creating the
>   PCI pwrctl platform devices for its sub-nodes, otherwise we may see
>   sysfs and procfs attribute failures (due to duplication, we're
>   basically trying to probe the same device twice at the same time)
> - I kept the regulators for QCA6390's ath11k as required as they only
>   apply to this specific Qualcomm package
>
> Since v5:
> - unify the approach to modelling the WCN WLAN/BT chips by always exposin=
g
>   the PMU node on the device tree and making the WLAN and BT nodes become
>   consumers of its power outputs; this includes a major rework of the DT
>   sources, bindings and driver code; there's no more a separate PCI
>   pwrctl driver for WCN7850, instead its power-up sequence was moved
>   into the pwrseq driver common for all WCN chips
> - don't set load_uA from new regulator consumers
> - fix reported kerneldoc issues
> - drop voltage ranges for PMU outputs from DT
> - many minor tweaks and reworks
>
> v1: Original RFC:
>
> https://lore.kernel.org/lkml/20240104130123.37115-1-brgl@bgdev.pl/T/
>
> v2: First real patch series (should have been PATCH v2) adding what I
>     referred to back then as PCI power sequencing:
>
> https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c=
145@gregkh/T/
>
> v3: RFC for the DT representation of the PMU supplying the WLAN and BT
>     modules inside the QCA6391 package (was largely separate from the
>     series but probably should have been called PATCH or RFC v3):
>
> https://lore.kernel.org/all/CAMRc=3DMc+GNoi57eTQg71DXkQKjdaoAmCpB=3Dh2ndE=
pGnmdhVV-Q@mail.gmail.com/T/
>
> v4: Second attempt at the full series with changed scope (introduction of
>     the pwrseq subsystem, should have been RFC v4)
>
> https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/
>
> v5: Two different ways of handling QCA6390 and WCN7850:
>
> https://lore.kernel.org/lkml/20240216203215.40870-1-brgl@bgdev.pl/
>
> Bartosz Golaszewski (3):
>   arm64: dts: qcom: sm8550-qrd: add the Wifi node
>   arm64: dts: qcom: sm8650-qrd: add the Wifi node
>   arm64: dts: qcom: qrb5165-rb5: add the Wifi node
>
> Neil Armstrong (1):
>   arm64: dts: qcom: sm8650-hdk: add the Wifi node
>
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 103 ++++++++++++++++++++---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi     |   2 +-
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts  |  97 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8550.dtsi     |   2 +-
>  arch/arm64/boot/dts/qcom/sm8650-hdk.dts  |  89 ++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts  |  89 ++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8650.dtsi     |   2 +-
>  7 files changed, 370 insertions(+), 14 deletions(-)
>
> --
> 2.40.1
>

Gentle ping.

Bart

