Return-Path: <linux-kernel+bounces-226834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2933591448B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A40281449
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5854C637;
	Mon, 24 Jun 2024 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gVWFRtnU"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44B38DD6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217277; cv=none; b=cF1nSRo+DCCTW7OTJ2n1CAt+vY8xlLRO/8U3Ao5BBwHzyymww2rXb54RG1Y7SwNbUlRhp5/SX7qF1nTrXauqjYkUuM7rAu6E8IAmbB3R8xDA0e+spseBWjxpOkcoK5er2KCIDRIl+f8LGkE+GILa2GMIanW/LArlFEGZYPZMKHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217277; c=relaxed/simple;
	bh=u251a/XP+o9tdpIJnyIXU0QRyZMFEyMwDU/ICP5xX+E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZJET2vdyLOTAuwoz7OXnl+EQJn6F4RPT2QvdEF6RoXxmH3QlXG1hKueVSW2eTsboAKltc75eTsDWRW8e1hE3CXwq34Af5kFTdyPm6yCQaU/DvW7jyzk1vBinZsuWBo7qPG99Rqk9IEnbWzIhRzVTjuLp5j9tFrxbBY2Dd3qoaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gVWFRtnU; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec595d0acbso13886701fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719217274; x=1719822074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlDb4mi6NTpX7sDJc09JrhEmbwE1hAUanv6O8UAsVHQ=;
        b=gVWFRtnUCOWiEJiNtfTEUV4VGj7AIHgcxB30BN9LLH1Pt3GUrTwnte+Xa9NAXYzW2N
         MolteNWjvc4S6QaUjlrKEL4R56RyXEwn6BxqNNsKlOAJu/+Frch5UU6OxwXpEEMHMqCh
         EueKcJwFZXGCXQLXhFciIosyuBIqyHoXZo6g/Phl0tA604BUZ0Cys//02uKDODqAkKpk
         VXiLSsSz5ZNp+DUOc58iefwTMFesix8ovC/dpLgoGV13TaMrN9uIKeFWGRou8aVwwvFK
         qePWgPYFKsox4R2rFKhqgw6glNf9wWpipZ5Kh3PRE71U3ojmbibIvIDYKaITGOdyAhL+
         /nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719217274; x=1719822074;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlDb4mi6NTpX7sDJc09JrhEmbwE1hAUanv6O8UAsVHQ=;
        b=rhcYVhkRHf+D7IxH93OaakXTzNvbSCTQodNbH0EqpdFtg78r5LeARuxpL3UbRiERjj
         CzmfO2o6Vttx+yKu5ODmZikxxBb3pJUhluBgTlUhz9faZoVkUKenq1Tv5T2cNcVMd2Lx
         J6FZj1k1F8BRjLCSkWjhXteEhPozFoSDxta2gjLgvRXxJQX9egO7TtThhjolRTnCGZeA
         S4lHC+qEz5pIyMaTrS5TCwFV/gwMf4s2F1whwfhMhjWqgOZ9Szawl1UHtVOmWYkqwj+0
         ZDlBkN5H73n/bqvvFbXMaOKbuGWFpj/15z6lNHxzSnIQjMAe0jQNfDpjZUuF3sBnUU20
         hywg==
X-Forwarded-Encrypted: i=1; AJvYcCXYgXYA52jZWt48K8X9qTlginBgkFpYbmrUVlG6VUGbd//I0KEmWi56NXdun8GzVnadt6gdw6ONNOQT/+xG9mJBvVlaG1ff26tBDAX9
X-Gm-Message-State: AOJu0Yw8ZY5VtzUyQWigC/QTVJCaJOg5oFyg+zemZQYUeJg01qLufbLW
	OTr+jBQnLwV7+eMZFk/00/WrU4ozMnddEpIgcctNgVVnYPQV2tngVYfNgvqkBI8=
X-Google-Smtp-Source: AGHT+IFPKBuSxSa24ffNl0qmiOjXu2IewrcJ94Gg7qLXnxIIuPS9D7LNMxJIkCRpfUF0FuMsV3Vwkg==
X-Received: by 2002:a2e:320a:0:b0:2ec:3d74:88c8 with SMTP id 38308e7fff4ca-2ec5b30bce2mr31274271fa.18.1719217273323;
        Mon, 24 Jun 2024 01:21:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248179d8e0sm132450205e9.3.2024.06.24.01.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:21:12 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christian Hewitt <christianshewitt@gmail.com>
Cc: Sam Nazarko <email@samnazarko.co.uk>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240622135117.2608890-1-christianshewitt@gmail.com>
References: <20240622135117.2608890-1-christianshewitt@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: amlogic: add OSMC Vero 4K
Message-Id: <171921727248.3499124.11397122409029609758.b4-ty@linaro.org>
Date: Mon, 24 Jun 2024 10:21:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Sat, 22 Jun 2024 13:51:16 +0000, Christian Hewitt wrote:
> Add support for the OSMC Vero 4K Linux-based STB
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/arm64-dt)

[1/2] dt-bindings: arm: amlogic: add OSMC Vero 4K
      https://git.kernel.org/amlogic/c/7d7dd631d1af471a6c909e197be2ef3df526d00f
[2/2] arm64: dts: meson: add support for OSMC Vero 4K
      https://git.kernel.org/amlogic/c/5feff053b08ce5d2167b9f44bcea3b466b5a81a0

These changes has been applied on the intermediate git tree [1].

The v6.11/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


