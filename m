Return-Path: <linux-kernel+bounces-203962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5948FE257
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE741F23A8C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA5F13F014;
	Thu,  6 Jun 2024 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T70rtnqK"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97A13C833
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665205; cv=none; b=GpoUudeVoaas/gC4pKSJA5E3wEgQZ19cmwYN6ITi7DPzwKYvHsY0Ph0DgKGcGqcbZq9fR7ppRA5Rk4SVApzvneHckLIwJ68l2c0YUdjiccsP6XkTva/fFhmP97hHpQcDdBpdVBQW4Ezcvi/KUCQl5rRG1PrHWW/av04fCdAHLm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665205; c=relaxed/simple;
	bh=Iru8iRC2ikGxa+eWGhTT0jj3sQOG4ulhkmijbZolgls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VV6kybWV1B7giI+KN/9+nabapJHaE6cRFl0yMg6HfvoG1kOudrcWUETYvXoEHHVUs76lKaEqMYGtkPi56wV+Fvt6CeyCdibERMVzv4VBpl9wtaRWRmuBukL+Hej7/kzdEI4nLsW2VzlMCwMS/6XOtl4yaM13JdsBjb+3Aw2wIvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T70rtnqK; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b9dda4906so1007429e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717665202; x=1718270002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8XpB9v83VyPuuQdMulEgHFlBA3mzFMN9vIEdPPQdzQ=;
        b=T70rtnqKWTkDoMjXVbKlCovBLYs1lWawQd7RGM2xxS5xrUQuV68peoNZU8rvQ6RFNm
         MfQNBg0h8EgibISHVL7BjIxsFPAOp3eOfa8xNZ0nX/SUgTMlGcerQ4MqhJNz5nFX4Azr
         vGJHRNRBrCLOb+zhKeFcHtrFcma88SclPev1sqJWogfykJkb8o+b7ufcFfsLW6Yl806+
         /eg/CXO4jZlIH/kmefYOWCBo7evoopd727pQLbdi82dAGqsNz4PnV/GJ91j6sKksEF6/
         +nsNaM36VMW2L3qAe13ZFdTZgzUCqQNIfT5fNfyy3pgl92hHppqnnT9HrvXDzvZwS76t
         /IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717665202; x=1718270002;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8XpB9v83VyPuuQdMulEgHFlBA3mzFMN9vIEdPPQdzQ=;
        b=NeaNkeeNgiM4DlC+IHTtni+iP2inamGMavbDnZXEupWYz0cfFRZhKuuvFXCHcrO1xa
         PfSDjvDgDij14RXj8XYjXDcf0tTpTSh6wlFmwWcah9onhrjPYLIQpzSkBGHCZwnv/otz
         m+ZmqY9MOwFCD9P+VcnTCqWc4tSCsao2Y2mlbQk3ILHHfH0qj3CyGxKvogT+9ePlEeiA
         4nLWJd/bnosBlYChH0nI7gNcCZOE+c/p7dYQjr8wJKqM2vCoizYc1L6rC67sXiHloAnr
         a2cErstWF5NeXpll5lp6t+aNVP52W2PzExPXHdxgkkURH08mNb9lKgWx2pYWPFZISG6g
         tq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGiLvQrgCgE2CrpnqdVXhuecA3iwhH6rNJbwjbzE8ySNolMH1yxvILtcOPJ9yJE9iMQ4FWw3bRs7d8f9DnxIi+Jp7eX9uSPp6kAEQY
X-Gm-Message-State: AOJu0Yy+mV+H8EBECq31Fwl+AjoVBCK87s2jq67/FOsesRMQt+12HbJq
	x380oRio8A+eEXhyLtvUqlzlyiJALwE+5VOWseqDxZJHFasOnrJTQWAYHiZdA44=
X-Google-Smtp-Source: AGHT+IFqolBgjPb1yWWf0ytpdS7ylHHarzNbdgoMc38k4aaIgXcMNql57H+efViwpESPzqw6RAKTdw==
X-Received: by 2002:a05:6512:3f03:b0:523:8a79:21b with SMTP id 2adb3069b0e04-52bab4ce48cmr4559162e87.11.1717665201463;
        Thu, 06 Jun 2024 02:13:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d66d01sm1027407f8f.50.2024.06.06.02.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:13:20 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Igor Prusov <ivprusov@salutedevices.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240528133215.2266419-1-arnd@kernel.org>
References: <20240528133215.2266419-1-arnd@kernel.org>
Subject: Re: [PATCH] arm64: dts: amlogic: ad402: move thermal-zones to top
 node
Message-Id: <171766520046.3911343.14113541266786791367.b4-ty@linaro.org>
Date: Thu, 06 Jun 2024 11:13:20 +0200
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

On Tue, 28 May 2024 15:31:59 +0200, Arnd Bergmann wrote:
> It appears that this accidentally got added into the spi node, causing
> a warning.
> 
> arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts:119.16-161.4: Warning (spi_bus_reg): /soc/spi@fd000400/thermal-zones: missing or empty reg property
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/arm64-dt)

[1/1] arm64: dts: amlogic: ad402: move thermal-zones to top node
      https://git.kernel.org/amlogic/c/6c9b5ba73ca77ef3863cda6560856fdfe7dc237a

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


