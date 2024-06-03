Return-Path: <linux-kernel+bounces-199207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108F38D83D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6FE281719
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF9312E1DE;
	Mon,  3 Jun 2024 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vMFfFVWW"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8A412D74E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421130; cv=none; b=f7Ape+nwLe5SGh7d737XcYC+eJ7/1BTTa1pTKKHOACrThGjjDS/X5++mPKVNVRF+3n4VQsh5vaan6n9DOp2uqQ9yU96MFOGUJ+AhtsfuZeN+wPIovar5SaaezE2VwjFf52jvJv7AvhUmI7M6rTJxrL9F2cfdUv0NmFtQdAUp2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421130; c=relaxed/simple;
	bh=iELaW6UpZ0X+bfwPhQtUan0LM3FgLiyhDq4yW47Xm2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unhA+8PICltfRJFKs+qh+0bgky31H2aBzfEfKwAldOYcrM6iYgHs3iwaeJfyImwAdNs1R95m+1QijfVvBaSW5ASkqbLvEX1gAt+IdS9aS7qWyGNgdv+5dc4LxTI2ygT1O6TVnvs8U4CvnRAA3Z5nMhsQ5XGt27Xiw7oHUQmjeoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vMFfFVWW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4213b94b7e7so6573745e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717421125; x=1718025925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRe54a93ahgd4EPoCHEhwLJzVTEQQXrct73Kw8IiENQ=;
        b=vMFfFVWWOHmaxxAXq8ToxeF/I2Sfc6xIFISP/WFonG+n+duXQysQpzU/v3zXWCbLj4
         hv6mmqvjhaBTnJOsL0w/1Kuq4EwVynA+65BC/qaUc9CF9dR0RQRWKhvEuLds65zTAHWO
         M20IcHxZh+i+dvljKM3soBveantpaB5KC2N1HFOtDAcPu2+CallavM0jlNbAuJyoCqs2
         KAZlt85Eh9CxImwQa0tKagiq4X8PUf1SkTwOb/XJjDMQlBTW6W20mr2VcNEVgoi0s8MV
         Uf3FcFGILmuVTmrpJZiaWB2losBbs4ygMr38EgLiGWxQQ/W4E1id+r8j9gCJTV6ZY4+s
         s1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717421125; x=1718025925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRe54a93ahgd4EPoCHEhwLJzVTEQQXrct73Kw8IiENQ=;
        b=Y38J2lZgKjMMf9DMxaKKL3O2Dpls0/VIP+KXxD90f6fl+oJ3dgGjAe+ztV6eTR6onU
         IpsGqpL9EI28s/pNoaeUbn29TMwieaSX4zWGQS2bXzXL+wNAdRZNMxEBIyIVH1TbJ5vn
         MvlTupo1HFn3lgYRqez4biDlWkkrU14bvj3qI8f/aVAcBebj0nVUdnf3EfEPFV98kLdz
         X27PAZpP8U0vbxRZO5xOuEfyo+StRLkRxtxQrcbqpwPqV0P73S4tkGYvk5EkDHWxk+/o
         Zw+TdmYeRB7En8rDjfc3nga9aCCNSeh2iHGZTL7reCYj+mItJvjtuGBvTaW4n8gcggNE
         fHYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbugyxB0jGOaMAE+6gre+STna0L4f7+9XnlCfO0jyF/x2Lw8VKSOTCmsMdbRPBmMj5StC5SsbmP8c5tWAlynKZnYZQzmb00zZrElY1
X-Gm-Message-State: AOJu0YxSMvVNX7cF7SkYP8ZEpHBquPAGQyz77dJd6hF9uJ1lH9735KZB
	GV6krNXd4HGUL+Ynv4YTvuQwLr1jLqgkJS61RUrG1liZNjFqQasZtjgyLPcEmpw=
X-Google-Smtp-Source: AGHT+IFLEN7Kw3Ie8Yzd2cCLNqlgMqANvOY0ptXyI3CXaA1r2wfTKpMAgXZ0QIY3SdFesSqXOePBOg==
X-Received: by 2002:a05:600c:1c03:b0:421:2b2b:c4c7 with SMTP id 5b1f17b1804b1-4212ddbc8c6mr73327305e9.19.1717421125591;
        Mon, 03 Jun 2024 06:25:25 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:638a:e591:7142:7b85])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4212b84de44sm117381195e9.11.2024.06.03.06.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:25:25 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Yu Tu <yu.tu@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: s4: fix fixed_pll_dco clock
Date: Mon,  3 Jun 2024 15:24:45 +0200
Message-ID: <171742077913.140081.14785575209725989169.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603-s4_fixedpll-v1-1-2b2a98630841@amlogic.com>
References: <20240603-s4_fixedpll-v1-1-2b2a98630841@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Applied to clk-meson (v6.11/drivers), thanks!

[1/1] clk: meson: s4: fix fixed_pll_dco clock
      https://github.com/BayLibre/clk-meson/commit/c1380adf2e86

Best regards,
--
Jerome

