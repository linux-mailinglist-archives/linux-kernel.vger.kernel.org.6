Return-Path: <linux-kernel+bounces-347714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E080498DC44
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DFD1C241B7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D8E1D0E3A;
	Wed,  2 Oct 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="F5ZSO3No"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC651CF5FB
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879595; cv=none; b=IY8ltxDF87BBic9LOGTeOP2Z+ARNLnVfsk3QnEcOUc+6zhX48YYuVI3mvEh4VjyaFp046r5rd1zxCPj99AIgcFSBcP1Xo980JkGO7eJWllfpWstsTecSK5kzyiW4KRK4de7K4R5n+NRu4USDp3kXJb26b+e6btBacnYoXPrHGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879595; c=relaxed/simple;
	bh=f+90MQvPrEolQsniRVwqUBXVzeLBUfgK0+iQIljiG/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNmYHknfO2soO8y04C3WB0CmB2WsufjL5vbSAztXGdlmIG8rd6nqWtWu+QTBg0yGwVU8oUFj7PTtSvGeUh3GJlAJUN4T88ZM8nzBsc2LBirxqHnf3wJflVWdH+pjsGTHSBxLkxGOUaucvSLRCaURapoqfLkZ2/n4sXs5oQnvBNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=F5ZSO3No; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so61034015e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727879592; x=1728484392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erU1VnZmdYTX2Wju9He3Bnn4nYfV32NEqyeEw+ucfvY=;
        b=F5ZSO3NoF5MIlAJeREsOMGuHGdPoFqiSRwz6YGq7vt6744w8TeMF5RJfAN3qgGhFi0
         oZdwspkUQHak9bReIKhDcFRqxw+Dydg6/LrkHxyz0LUUPmwZEEkvmrOkEbns0nuAIV3v
         ftOVvSqAfQ60ykn2MdqhA6ZsfRYDrkTOsvWsLr4+b0YUPksENch3/ZDYFEa0drx51ObH
         5PHRZN/eLUT2OwGfbAV7PsfRi/5xuWb4jZJ/V4+yIH/MxBjhFxd0EJ7H2DuTKZw7/kPK
         TmDNNQg2DWStKc1rCUOLPMgvmlTwgDDwkC3VOISdPsx5MMsUKcLv4zED8chzpOFfLY0B
         uNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727879592; x=1728484392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erU1VnZmdYTX2Wju9He3Bnn4nYfV32NEqyeEw+ucfvY=;
        b=HduU3g7HLLnHNN/UkrdlurJiKsM2EtCPgMzFk/JBPNWcQH/8Ifwq7iiDuYWbFf+Nsg
         3R5eWtG4OIZgpyjKWHqdswfFFf4uXLRX0N1I2Zyo2I5qZigC9t6MvJCv3NLeHkmj4jpC
         MrSuK/GLUNLYL1llkDj5KLa5x/QqdXtUu2Rt0WgrDiO81LYIiBqpd4fGmne0zVVaLacS
         HNerfZ52TRwGK+UbCPjsjlgefZrT2ApE1g5iz6d/J6IBf5e3jxvOQkbBmcXC6i1hicdz
         F2c5e8mvkFtW9hZ9RsaW/crAqQWPtVc4/ZiwLd9G+VpRmzhU5sVnOm/i1X5jt0Y+9cJ+
         Shjg==
X-Forwarded-Encrypted: i=1; AJvYcCVZu6zeyvtSPfTIeo1XKcuOD9W0TR0DGa0X9Q7v6rsci7FiT1KG1L81JudEUeIiB/jjRRkFAKRH5CqcbMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2FIIkZOusulsYrmzZ+XUiRJWdVO8QIkHaOAndXGYdjw8K624n
	RdlFnkJWF4bLiQI3RkRHdqYw3lbBxA98H2jK4s6guURnajtUIJZw3EeAa0xb1G8=
X-Google-Smtp-Source: AGHT+IGDvMwjFCEIq74iXP38Q2qvOd1Ap6PuvMTjHWrmmX+7zhNUqX+2/u4tPlcpyyq4g1ZnXztWEA==
X-Received: by 2002:adf:ff87:0:b0:37c:cc4b:d1ea with SMTP id ffacd0b85a97d-37cfba182cemr2528511f8f.53.1727879591603;
        Wed, 02 Oct 2024 07:33:11 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:23c5:7b17:f5a4:f41e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d5b7sm14180124f8f.5.2024.10.02.07.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 07:33:11 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: aggregator: simplify aggr_parse() with scoped bitmap
Date: Wed,  2 Oct 2024 16:33:10 +0200
Message-ID: <172787958675.72970.2473245220175622074.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930163207.80276-1-brgl@bgdev.pl>
References: <20240930163207.80276-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 30 Sep 2024 18:32:07 +0200, Bartosz Golaszewski wrote:
> The bitmap allocated in aggr_parse() is always freed before the function
> returns so use __free(bitmap) to simplify it and drop the goto label.
> 
> 

Applied, thanks!

[1/1] gpio: aggregator: simplify aggr_parse() with scoped bitmap
      commit: 22dec5aa596ef805cccbcd3fbe5ebffbcb4fa559

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

