Return-Path: <linux-kernel+bounces-358585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69099998126
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2501F26CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8081C243D;
	Thu, 10 Oct 2024 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="deCwGo9c"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179281BFDEE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550507; cv=none; b=UbB3+VDyP63mhTkY8mG0mXr6QCcXQv1sVXg+caWNOWx/26Fifth2tJbxA2TlodySzzDlijqttw1STDPz2VV96iPbHfAYz5ronU04+c82y77+HYot5UZ4+qWbHjab08eoAUGDMG1Wbsq+IhGzXd7/UwltaLsZRpoOTRY6adeju7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550507; c=relaxed/simple;
	bh=5Cx+4eot+xnIUAD/9oPz8ttDeh/qqSFRet/nf/SXMfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=niXX6yei7jhIB4mSv4tbO359mIw/ohi/zkIHIKzLR1vXvwdI2uNbd9Yf4BW8IpjnkoLuQcCHf4phegO80Aywh1/kXzAgQtBnWTWMPdtQ3q7pOhhW2wW9ftWYhm9K162Mr8Hs1ZM//ahHcsxkpApSpNTPgShaIiNF1bptbaYd304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=deCwGo9c; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43115367693so1081915e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728550504; x=1729155304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgOR4E9IFq32loq7SFGtPsR1wH/Z5vkFIo/MpY40Tqg=;
        b=deCwGo9cOJCdCJMj0DzNHzkZKuGpVu1K+Xg8FvronNPQUnOoQqAlpE6QBZkJk/wt61
         oZSEj5GTEIM/ZL/ROM8Vu0XcOhruhXorRNy/w/FNdIeOtnbjrki24Qk1LAKhdOcQIApU
         M/Ch5UeznRGZTGtqgIOD1ZnuKIOYXNOQOyZA0nAi3/Z9TUcQ94idBThvT/2L6p0fC2OU
         Dag877vTk7WQUqxn6hmpKA5OnJDcSW/sFXKmkGy5On2d9B14FLoaRhLjwdfAL1ey2oAQ
         F9tuxUSp9iUUaD8nq8hUdBj2Dc+3AMuqNB70dMQwKj34Y/WQJvwR2SflOtY3pnZkXYN4
         t0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550504; x=1729155304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgOR4E9IFq32loq7SFGtPsR1wH/Z5vkFIo/MpY40Tqg=;
        b=tjGpGDs7hDXgl1GKQFw/WokarpMgEZPK0qBanXL/D31peT7dpGCDKq+/ytie2uuh6G
         ++G3oevbuWUIrEahpu5UHd9EzXK9lSVyyv8r9/q/TNAfJqWYKHi33TfQSEp2yRZBlclc
         /HpjKba0WD6Or+lAXVMl/s2PZe/iJm0hLiFc/73+1u/6c/cvc6tlfb1ZmR/abFrD1oKo
         UwftWK+qmdrowJjS9/IeKhkrpiveKIe4QDpTLiMkNBfcK3Kmc/gvrEdIlKTeQqv0j51S
         aVlJWpRK92XR32UXeEKsWQJFRMr/5Yr0NfvT8ETKcKYHCd1N+ikR5J9FnHaoSqfRYRwS
         DqFw==
X-Forwarded-Encrypted: i=1; AJvYcCW6OTVZAxOfJwtvGmdbV3nsM9/P6K/6olV6B5KSmNM9i6Zn0bmKz6uWFi/Iij13xxYNnSdKWqoX56vaWBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJhVC1CEtVF6X6kP7K9PFgpye51rGMn83WpRMNGGHwYL2CNWj
	G9k6iUlrgE0mJ8gaSYqO56TLFZBrWvfMVhr5suuXn8yo9mN4hl362HuLSfdEC24=
X-Google-Smtp-Source: AGHT+IH2OTiB+QZPXTSj2Xs1QihUyDxM68B45YoqASQPr1RF5iEjSHbzN1GfHT1WymhYm0AgaUhmVQ==
X-Received: by 2002:a05:600c:1d18:b0:42c:aeee:d8ed with SMTP id 5b1f17b1804b1-430d7488fc7mr21015825e9.7.1728550504481;
        Thu, 10 Oct 2024 01:55:04 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bcf5bsm902012f8f.32.2024.10.10.01.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:55:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sunyeal Hong <sunyeal.hong@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 2/3] clk: samsung: exynosautov920: add peric1, misc and hsi0/1 clock support
Date: Thu, 10 Oct 2024 10:54:56 +0200
Message-ID: <172855049020.142350.17701587570659888437.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009042110.2379903-3-sunyeal.hong@samsung.com>
References: <20241009042110.2379903-1-sunyeal.hong@samsung.com> <CGME20241009042117epcas2p3805b8b5f3a65ed1ee39d5244310b9581@epcas2p3.samsung.com> <20241009042110.2379903-3-sunyeal.hong@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 09 Oct 2024 13:21:09 +0900, Sunyeal Hong wrote:
> Register compatible and cmu_info data to support clocks.
> CMU_PERIC1, this provides clocks for USI09 ~ USI17, USI_I2C and USI_I3C.
> CMU_MISC, this provides clocks for MISC, GIC and OTP.
> CMU_HSI0, this provides clocks for PCIE.
> CMU_HSI1, this provides clocks for USB and MMC.
> 
> 
> [...]

Applied, thanks!

[2/3] clk: samsung: exynosautov920: add peric1, misc and hsi0/1 clock support
      https://git.kernel.org/krzk/linux/c/5e830d3c97d50d619ea8eec04403e87ff7538c76

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

