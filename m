Return-Path: <linux-kernel+bounces-318317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0708496EBAC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB755285803
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133B214AD24;
	Fri,  6 Sep 2024 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Gg/mr5XL"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B86145B11
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725606679; cv=none; b=fvB07SaMlvim0bUj0SiC6dIrYalazm+X+ftRL16oCxwiznnozJNUwejiMi/i9as5tFQqNgEpto/8XimcbVGSvV6rmA74El7HFdNpEEBImFcod3o0RY1L3QRfAcGO+lj6gGgbgZxsMrEC+P4BclGp3SeAasQ3kGcf5WvLJcV6+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725606679; c=relaxed/simple;
	bh=MAXYm/fj1yP8lVOTQpdtw+CtvCrS1ey6DECPR81Pfik=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c9ZxhGZcMZ9meWoLCdKZ/E0Omz27VySKwzWD5092Us6QX1LIA/mfRQxX1asvvy3fYDfboyqHPxlYF5PCqonQuSfXDsDxw+BMV5Mm6zgFWaiSeFPqd8XqCXheJwrNepCNTJeu7HNal6zHlyXS6OJ+idMBmhGtUOlntP+1Egdrg50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Gg/mr5XL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso12535415e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 00:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725606676; x=1726211476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBb1m70RMv6UJKegzoNSHZhoQzpn0mL5Ktd2C9pGgiA=;
        b=Gg/mr5XLF3GDW0gPVc31C11u6SPMeVJhr2sjpcyu3NtoYKSpr4dJmp3jNFyiYn4gW/
         WRrsH7BUK53WJn+qODNRiGsCVK/rqvKShVq8L13NIDFNnc6GwMJXV9r+/b1zdxx1XK0i
         T0hL2k6Ny+ovoNZj2jPchpGaCIjFEfvFj+RLjciVjiutEYU7kPpTkxix0wfSPqt8Prf/
         NMmVONswFxFsxEElbENi7MzHNMQwP0P1+nPaMnFV493HxA2u5QKLzFTTlmkBRcJBdI7R
         L9+87xqPk1BIpnuRXR2oyPCX3wVooDt/AzlksHT7QRwI/JZkttHUOr5lCfuzKnpIAuJH
         y0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725606676; x=1726211476;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBb1m70RMv6UJKegzoNSHZhoQzpn0mL5Ktd2C9pGgiA=;
        b=V9je3b4d5s8xrS4Gm8mtGtNvkBuZf8PpdFs77vkYtV66M3tseKEPdOT95V2FJsMl3g
         N7+x8IcyfCkRDemsU9qLKb+bRXqp3ndDkdy9cZW7PZi/oiYBG+x3+BilNyBQptFFa5nz
         ZXHQfCStCtaW9lqUBHKYlHp/LCeLjW38TxBrvXwtohQrxFbUzrPfbySs/+24XRgP0Uum
         6iph29fcfqwDj6JVgyg+nmQ2vaFxJWpyC0dnSkRJb09BXpKK3Zb6b8FVm+MUMDX58jRa
         qedwLQ+6I8ZnBXfGww5YLAlmz6YMtY+zwDE3wW+MXDJq3wOD379qkDuhbN1YUZKR+q0L
         AlPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl+9l4WMtxoh5s5LNxsrcP1P9Wfa4UX5iOxiqDE3mzoGrhd3a58q2P9hBceuufxkYVnjZKxBoTPZV4bWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLeA5HMAhBDyVNOFHQ9EgdEwDi4ZBpVQQFDUGxWctJbHYo8WfD
	X1lX8OUmY1zZG4JtyX50gsSfWM/V2kgYe4GOhpphxWKjB6CfPazEMo0TuGlpyms=
X-Google-Smtp-Source: AGHT+IEqdAHSLSbZ7AHGnt96PMoqalKMoCEpht5Cea7Y/2LmhbcK43F8Fn45vpBv/QCzJQC9a1kDYw==
X-Received: by 2002:a05:600c:154c:b0:426:5416:67de with SMTP id 5b1f17b1804b1-42c9f9d7059mr9170495e9.30.1725606675422;
        Fri, 06 Sep 2024 00:11:15 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:4e33:801c:cee0:ee57])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-374ca94e002sm12596485f8f.72.2024.09.06.00.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 00:11:15 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Chuan Liu <chuan.liu@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240906-fix_clk-v1-0-2977ef0d72e7@amlogic.com>
References: <20240906-fix_clk-v1-0-2977ef0d72e7@amlogic.com>
Subject: Re: (subset) [PATCH 0/4] clk: meson: Fix an issue with inaccurate
 hifi_pll frequency
Message-Id: <172560667467.2965402.16362697378487101558.b4-ty@baylibre.com>
Date: Fri, 06 Sep 2024 09:11:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Applied to clk-meson (clk-meson-next), thanks!

[3/4] clk: meson: s4: pll: hifi_pll support fractional multiplier
      https://github.com/BayLibre/clk-meson/commit/80344f4c1a1e

Best regards,
--
Jerome


