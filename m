Return-Path: <linux-kernel+bounces-227242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC985914DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2B11C22784
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FE013D50E;
	Mon, 24 Jun 2024 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPIbegnf"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4906E13D521
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234310; cv=none; b=uZweaBmavBRZ3b8pvQkmTfudm+/pW9DiYcr8KVQLLG0uYI5AdIcfwiffKyktFuj1eAxTBRFc8No7CpLq9X73MPoDnykxw8pTWAy8DqA9Yos0FAk/+Vmx3QkEAPfiY/3R/7LP9ZuqAEDn+AXexuKWg0PYSyNlgT+MwHCQWD7MMOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234310; c=relaxed/simple;
	bh=+drNbvux++uug0hPu6tz7VO4BFIyNDtMKC1mDMXPKq4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Iz19hTqUX/SNHDKA09/NTwo0ZBsuggQZbXTT10vWv1mvRN7KDXEQWuE4/HYLV819o35vooHjkcuRp0oUvHyx8LHybvB3MKWyccXZv4jH7fBRA9YAM6550C9oY0iwPRbz/rpbE+xfhmm6NJbLGtocjecXGUPAZp16MAmhQ6W98m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SPIbegnf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cdbc20faeso2942338e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719234307; x=1719839107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCSs6EoE3tz3KgGGlszJ+JFtOP9WWRkRZnOsk0NEKe0=;
        b=SPIbegnf7qJAJgLG49IOvMsTGCw2LHuKnnb06cOVtQDv6HwixAlrqAGutvjzsUzvEo
         ga7mH18+JUNuQ/15mlP96/NDRt2/x9tuvCzTbKzd4Eq7E5dL8IKJ4FllU2kNXX+UIhaM
         eGJenYuskcvD1SZqnQOWJzlSehyilpxwrPSiIYBN4nqLTNnLA+tMEY3Ex4UHKB77HJYw
         QRUWOiDrA+4KEfqlHDx+gb9qDN/xywS85CL8q9xrMo6ZkosB0dGbOb1Pwlh1ZEcYLPVK
         nsMrbUhKQwwLp3o/XmTZXJICeUmAtxs/Xes0t++aAS75FLilTvY2SFWpUN8Dkn4GIubr
         WqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234307; x=1719839107;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCSs6EoE3tz3KgGGlszJ+JFtOP9WWRkRZnOsk0NEKe0=;
        b=HLrKr+VM/Ve0R9N43TvezpuCemz7JTghZ4DeSh6RGrbKHrmkugVuRHAmn54xwdXcLY
         /JqrvGdn2190f0dHujnsIs7LiFIyHNFLW3Lm/Z4t9cieFxhLAZxkZxfhYJzQbocx4W7T
         YP67Un9AF3DOBNufIFOkhcYCz2kVVrEPZeun1B71bySxpkcLyoXdnyoAAWCLKm1E0ZLS
         1mKp9tFYlK7hk0e8fjKXZOZGmWT9qGqR6J1RoQF5z0I3yPJbPnOHaLD9o+YHoAEYGg5x
         OugWuQDYRvU0h8j4iGQSM0yxn3bdAeEJXyDxO9vccYr7FJEp89xAzon+fm6vn7XEM9uQ
         ZUHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD32uGiGuYJtXgTgtXFv9MzODK2l/+ysh2DGPu6skpyiwBFHnXHTGnWrOUiE/7nh8FTvSPH0ocoSjKFwjjz4F1Wjt+h8iQSJs5yxM3
X-Gm-Message-State: AOJu0YxfHPhnyErxmWJW17EYZviI8SE4GOZfhQ+76scAVd7LLTjrbp5N
	JzeIGik6q/aHdGnYDh/zuCmtImIpdoFq4GU9vO5vCEovsXBnxQYlY0b3jMji+2EABSdGfcMILSX
	U
X-Google-Smtp-Source: AGHT+IEZaZMrjJjqM0Ess2luZwycJQQVw6sc4PZ0oTPthYEnIA9g9rv/bnCXKiQWNCLkhV7ZgfxGTA==
X-Received: by 2002:a05:6512:39c8:b0:52c:e4cf:4f31 with SMTP id 2adb3069b0e04-52ce4cf502dmr2779953e87.49.1719234307304;
        Mon, 24 Jun 2024 06:05:07 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248192243esm137985425e9.44.2024.06.24.06.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:05:06 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240602-md-clk-imx-v1-1-5c6d240f6fab@quicinc.com>
References: <20240602-md-clk-imx-v1-1-5c6d240f6fab@quicinc.com>
Subject: Re: [PATCH] clk: imx: add missing MODULE_DESCRIPTION() macros
Message-Id: <171923430571.3352368.17603224359381270285.b4-ty@linaro.org>
Date: Mon, 24 Jun 2024 16:05:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sun, 02 Jun 2024 08:59:17 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/imx/mxc-clk.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/imx/clk-imxrt1050.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> 
> [...]

Applied, thanks!

[1/1] clk: imx: add missing MODULE_DESCRIPTION() macros
      commit: 1919d77a9591aa692c8de11540ffc0e7d18eabb4

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


