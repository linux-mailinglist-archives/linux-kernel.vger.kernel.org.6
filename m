Return-Path: <linux-kernel+bounces-306337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ABF963DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0A21F25E09
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5BA188014;
	Thu, 29 Aug 2024 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7v+ak4i"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86A215821A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917885; cv=none; b=F0M2Hx8NSpNJMYGpKthOn0Rmo8Ftuf1cqYyzQqdFnkwOdxrHABB+YbP0wPsG1lvxhkhp3RN7KMDDnaydG7eyvfwDyIAGBsciXbA3NDm2TINwFtRn3fITuWR3ME57bkpYKfPK1jVNifjVpwgHzAoW+pUH0N8bmSl1jB/4qGxFX3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917885; c=relaxed/simple;
	bh=b1iu5bBGMN/WRY5McVNmPa0sPk6pBt+y0aWDnZ8I4ZY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W4ju3n9YhgqCJ+u14nerk1hKq8a1bsx9sI7ahSGg/F4qgacBj2XxX69H8swfckd8sR3Id6nRxh7D06i4lWv6PwBC2DiFsibJVnP1Mi3V8cN/l4WWuA1ZqXFxka3prtZWS3kB7GKPOSNLvGfWpANh2uTQ7Ir9WxY0EYyKmdD6/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f7v+ak4i; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso299561a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724917882; x=1725522682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNl66AlqwT4cAqEjUDGMGS3KRyt0fVfw/DJnltkCvlg=;
        b=f7v+ak4ix8VzdB6MuDGKwZJa0pGjw3pg/ey//Sanx/Y/eOJeq7xTU6BQfTp4wCEZcw
         dkDl4oJVYHcGE4B5NU+KqB5yuwq1/+tPm+9sSc8yIjjIB00H4O8ihIY7EClaO8Ok3edT
         0a3Ki2uXJ6v73eBk7bAWp+YN8YPHoEnBPmkjDC4ce1hg466DuzDFHLITZ9YHSrhY57vp
         6YHXRgtSlWq0/VmOX1+QQCSFs5+wt86yeMIt171rfLUqdcvQ4bH4kvcH8GRUCvHLRPxC
         tKEPFUL0r3E/ukUJVu37aPDENXPH0nmvj6UwqAbkYUY8IBYKutPaygsotNi3ZphD5W93
         ZGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724917882; x=1725522682;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNl66AlqwT4cAqEjUDGMGS3KRyt0fVfw/DJnltkCvlg=;
        b=Xn3AAgHyJmmElKgIJ8VxKucgRDe+y3JxqTQddKoXYY1Bz2rdsgBOz3d5hTdcOfJVkC
         pnKf/x3KvSf16w3eQIgcAknzBHUgxF25dqZhs3HX36KHpFH5FvW36rlwSzFMa5uJbL+L
         SrL9XIKPHbWjz5GWWEhbBywBmZMxzsAVt/R1/k8wPd15KRvy/OiIeqCiT1D4HWn5C2yb
         94j6fSUKddISz4ryUSv7t21ehqVQVa3QtvElTCPgSdf4jLrHuY5KshFREoFWZ4mNYD1M
         ZGbEhUeqn9DG4iBjTUtax+frCZCoyQForcraN6Jjl6pDByll2uFOzFYUnC86JMmTTQwg
         P+yA==
X-Forwarded-Encrypted: i=1; AJvYcCXaEzGkYBmDYWz+Puj4LA6hf2xNCTEcgIE6ZQSz99hy4CQDO9i7+ADggSWHB2JvZ1IskWQm8Y1JPQkPlAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoIo8QRHGTx25CgiOcGGvsCiAvmcc6xFGB/0+qqG71QdbXkyOo
	BDr9m5xRMe1UcKfB1tKhe2XfyDYvi0C3uDMJgp9U0CupmBE2UlGC3ot1jmrH9xY=
X-Google-Smtp-Source: AGHT+IG8huFuC9IMIewGRzZFbVOx39XRXGgjaUUrnzV5sW03EE5Zh6Qoa3HKistxnMgRVRVgwscq8A==
X-Received: by 2002:a05:6402:268e:b0:5bf:dd0:93ad with SMTP id 4fb4d7f45d1cf-5c21ed8e66bmr1506357a12.27.1724917882000;
        Thu, 29 Aug 2024 00:51:22 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ce4fb9sm387010a12.87.2024.08.29.00.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 00:51:21 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, 
 sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
 shengjiu.wang@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <1720600860-18866-1-git-send-email-shengjiu.wang@nxp.com>
References: <1720600860-18866-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] clk: imx: imx8: Use clk_hw pointer for self
 registered clock in clk_parent_data
Message-Id: <172491788069.2543084.96108740575044278.b4-ty@linaro.org>
Date: Thu, 29 Aug 2024 10:51:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 10 Jul 2024 16:41:00 +0800, Shengjiu Wang wrote:
> "acm_aud_clk0_sel" and "acm_aud_clk1_sel" are registered by this ACM
> driver, but they are the parent clocks for other clocks, in order to
> use assigned-clock-parents in device tree, the ".fw_name" can't be used,
> need to assign the clk_hw pointer for the imx8qm_mclk_sels[],
> imx8qxp_mclk_sels[], imx8dxl_mclk_sels[].
> 
> 
> [...]

Applied, thanks!

[1/1] clk: imx: imx8: Use clk_hw pointer for self registered clock in clk_parent_data
      commit: 35121e9def072aaa2361572829e4f71f80dd6e8d

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


