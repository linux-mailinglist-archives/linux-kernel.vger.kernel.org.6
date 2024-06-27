Return-Path: <linux-kernel+bounces-232229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E74491A579
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15541F24704
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFA114F100;
	Thu, 27 Jun 2024 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Thtjle8C"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEF5149009
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488400; cv=none; b=Q6Pj+cs32u70uPLMORvphtfykHX2WLhvY+GG3oVWg8/ludumSPMwTe7JTvuXDAMUXHQkWHhVMU6hPVza+CjkzXs051E/fPbXyWlCr9Ez3/wwQatDxepZxKK6ZdWkUytQYYGA/0KuBFGAxz0b+GvceAM5TVQuLNQctPXJgfcV1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488400; c=relaxed/simple;
	bh=H2oINYv1RisztMZ/1SAqTZYHs/1i3Urmq4+NkMvMiMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M39AW3N6KyZExMPm3EobdT/WJwRcIEnZcVxcdyDSuAU9B7Yj5ON7tjlTsY6qKt5saWwY/cRLqomgxiEVqp3FG8fMtbPolbjbg3NdiU4F6M6rAwWikvGPiehNSf/COCBaAefZKyCqD2u/jqLHf1MEryz+9KTkOcHiybcYiHbaJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Thtjle8C; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec595d0acbso59881881fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719488396; x=1720093196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbI7/sd74idfi/XMipln9/gNNA6hsJvdqtzVYepkGFg=;
        b=Thtjle8CV8sAZ48bIIqpc7edKv32ptt4YMAdb8nLauRmRbVzyrF4rAd0bP9wXsv3QP
         r0l9sY6A4LmbmYizqFVH3nvsSW8Q+K1GRV4RUhpwqP0WtaS1o15S3TfAceDGKJtFaKVR
         i8vz41XhVaP+YR/484dkjsjVkHTg3jFijCNol1rQ8pRRLYquDEdYaiKPQyeOrxvzWk3Z
         LX9G56MHG4E9AMq39rugx17tjoZsBurACY5DdWVSwvPO98apD72uvm+05eFk2wrSaJfn
         SKn4LM/bm7P3alUpJF42+JTs3nEh++eX4yDgZna4IrdL4BN+6RsN+QA+Jjb3STxxoB74
         lNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719488396; x=1720093196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbI7/sd74idfi/XMipln9/gNNA6hsJvdqtzVYepkGFg=;
        b=S+JSEty5m5LQ7Ox7S+1LdUf7dwppOmSoECvh3zdpz520Cvc5KgiBo6Kt4ieMg3qhJR
         hZH6WZHijw87Sb0MdsT+GIvRGD0EOXLMHLWatKG6Vt+k0r6d6L82y5/2SdTTaIyHBcA7
         OYBwqbcsbJQ/ekNWW3//B5cBialEVifdHOK37s2UNOrBNfNdt6P8Kic5a5HJZNSxPqzg
         KFiWHlIg9MQe6NL0u3ArkOuWREjDhi7w/rkdDcIeph+VjJ/1ZN64DhjYt6KPnAYgqZBO
         064v5xJ8+HleYmN/X6zgvXfy/Jf4E2LGfgaGuFeW7BHF0oNGZjoqEuiP96nM9jxCqHK/
         qZZw==
X-Forwarded-Encrypted: i=1; AJvYcCVduZnWN5sR7Th9EXLBjXuVvav/kOM8llpVGtNNmWjIExQ2cOasy1fTc7Gwg9LrG0kH6CIUQXUy+9BEkHkLgWTeMqtQXDLCBNR7NxVL
X-Gm-Message-State: AOJu0Yz7rJBQ6n/oH0NEBYO17YCkkA2rT/mkBnZHuhMk8MAWgRPrRGHh
	8wiD9B4GZhxJedKUPh9sIV9667mZVjY6JrS9y/YCaLw5aSiz7yg6E20MzBHKZVY=
X-Google-Smtp-Source: AGHT+IHFDzARAto2HLAI3TxjHyub50L0O0Jnjrz9yXwhDePCwserMcflGKVLOY5zTOX5jsXXhqzpcQ==
X-Received: by 2002:a2e:a442:0:b0:2ec:5019:8fa4 with SMTP id 38308e7fff4ca-2ec7278a341mr44969421fa.49.1719488396147;
        Thu, 27 Jun 2024 04:39:56 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7fe5:47e9:28c5:7f25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8468613sm62081815e9.39.2024.06.27.04.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:39:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Vinod Koul <vkoul@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 net-next 0/2] net: stmmac: qcom-ethqos: enable 2.5G ethernet on sa8775p-ride
Date: Thu, 27 Jun 2024 13:39:45 +0200
Message-ID: <20240627113948.25358-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Here are the changes required to enable 2.5G ethernet on sa8775p-ride.
As advised by Andrew Lunn and Russell King, I am reusing the existing
stmmac infrastructure to enable the SGMII loopback and so I dropped the
patches adding new callbacks to the driver core. This no longer has any
build-time dependencies on the PHY changes so sending it out separately.

Changes since v1:
- split out the stmmac patches into their own series
- don't add new callbacks to the stmmac core, reuse existing
  infrastructure instead
- don't try to add a new PHY mode (OCSGMII) but reuse 2500BASEX instead
Link to v1: https://lore.kernel.org/linux-arm-kernel/20240619184550.34524-1-brgl@bgdev.pl/T/

Bartosz Golaszewski (2):
  net: stmmac: qcom-ethqos: add support for 2.5G BASEX mode
  net: stmmac: qcom-ethqos: add a DMA-reset quirk for sa8775p-ride

 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

-- 
2.43.0


