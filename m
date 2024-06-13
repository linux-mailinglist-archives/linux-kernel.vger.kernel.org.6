Return-Path: <linux-kernel+bounces-213380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89B590746B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D96E1F23CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A88145321;
	Thu, 13 Jun 2024 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qT0p5zPW"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D771F22092
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286921; cv=none; b=Q3Q614ZTtknTe3tirlTnMI43M0dhiRqyPUZSpNOQ4uml31XCXHiMYUu04DTfdTic37afES65H3pIuVQYPcHxGr3xubW7dJKC0EWOC07quBEiGm2VaW+aSiZQ9csypT0Gcjwj7LkbgMGYz4fBPx8sBd2c/xJlE+6Pkg0tGVDuw6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286921; c=relaxed/simple;
	bh=vVwvkMaZAYjZyqicTOx1nxvLkCMqD5e221Va8hSK8uU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JxPznDdtHxTcZr5KjbC91iVmPFJjdBQRwav7tmaePWZ3tvEAOZ3DeCOeV8xjcLJaiYPC+uQe8MA2EdusfobCP+LUdOnG/u4+4d9KaLHcXgaHK1QLH3Ff50AQbSepAnpkRgiuw4s0oIcnfHAG4RMpsBh56ZIV8icl3jmlTB3LzOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qT0p5zPW; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35f1bc63981so1367357f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718286918; x=1718891718; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFttpI6mxFfYOQDKQEDFzq5Zkmvl1Km0kHopsmHSaog=;
        b=qT0p5zPWDtKGsdaCoo476S6sv2vV/B8udGV6WKk8x0iZhvfE41y8mzu+tqLtIG1sCF
         YpbksmzcPpDrLJJg551lMYRJ1+N0telVYmcaX+rC50uDSezNMFeB3X1T6/71a0pPICTz
         0OigWGBqqWmyJ5a4XGUBcr+bmg5mnYK7ifb1ctMCmoDib/yq+xTvGYoJ2T9CXcx18cJv
         4C8XSECqx/UgZLQ2xHv6TADKGTA1W+kg3EJcxwKyQ1RfgbpP6LkPOoHlFUv6clR7RLF4
         hbubJkEn93iPbSvvsDx1ov7KskcFQ439hE2Jj+jgb0zQ56hfWTSZq/70LXQ7vjpyZDNP
         b6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286918; x=1718891718;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFttpI6mxFfYOQDKQEDFzq5Zkmvl1Km0kHopsmHSaog=;
        b=bw+uQHUKCmHjcTN09YmrG1CIrWX3mVzi5beicWCnY5XCx4F9DqjX+GwDmbi3nLhFpd
         vgk6gkejEJ4BmLwA1Rkd/dgnoYFDG+dGF/mCIusobDzADvtw+oizS8pWy1wBYJfpXqmt
         Bnv18Tdc2tO+gJTIaCaEkCLqYqOg/a3yURmNZDsosDYLR6NJx50jFbohh4R6F8UOnqVK
         sRR534iDnVqXqCdvfPhk6xMVs7z94xavt8F/ScaCAG04zlXY3tAvf1Zf3q5slGDvSh39
         S9SZ/lWefHZUfTR2cBtEMBtjOQ0HvP5SIWMlmizk74vC4rnLF2DjjkCKEaQznSp72Hgn
         IUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy2K8cA22VDG7sqS4ZhYpRd3+A1QuLGtIPHc9S6lnvUKQDKGD+8TOq4iDVjhznkJTsATTb1aKZyUmxD5wyFjBMQ2LeuRpfVhr12m0J
X-Gm-Message-State: AOJu0Yx+6LVp2xD+JqEB73nR6YFGSBuv7XymXosceJWsG/sJzOEIg3Rf
	4/p+oQg90eN7ex/4aaZgTp9dLH3hkgtF+eTxOF3KSweeNYHANPz95NbB92Q2f5Q=
X-Google-Smtp-Source: AGHT+IHrkX+CcccVhTGNwfhUGtMYn8rDSIQG438y+DU+7wum/b95cyXAUO7wmOgn1iLVTP1LFzTVsQ==
X-Received: by 2002:adf:e646:0:b0:35f:e890:fbe1 with SMTP id ffacd0b85a97d-360718df02amr2564058f8f.19.1718286917900;
        Thu, 13 Jun 2024 06:55:17 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607510315csm1778848f8f.90.2024.06.13.06.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:55:17 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:55:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec_lpc: Fix error code in
 cros_ec_lpc_mec_read_bytes()
Message-ID: <e0b43fb5-ecc8-4fb4-9b76-c06dea8cc4c4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We changed these functions to returning negative error codes, but this
first error path was accidentally overlooked.  It leads to a Smatch
warning:

    drivers/platform/chrome/cros_ec_lpc.c:181 ec_response_timed_out()
    error: uninitialized symbol 'data'.

Fix this by returning the error code instead of success.

Fixes: 68dbac0a58ef ("platform/chrome: cros_ec_lpc: MEC access can return error code")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/platform/chrome/cros_ec_lpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index ebe9fb143840..f0470248b109 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -139,7 +139,7 @@ static int cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
 	int in_range = cros_ec_lpc_mec_in_range(offset, length);
 
 	if (in_range < 0)
-		return 0;
+		return in_range;
 
 	return in_range ?
 		cros_ec_lpc_io_bytes_mec(MEC_IO_READ,
@@ -158,7 +158,7 @@ static int cros_ec_lpc_mec_write_bytes(unsigned int offset, unsigned int length,
 	int in_range = cros_ec_lpc_mec_in_range(offset, length);
 
 	if (in_range < 0)
-		return 0;
+		return in_range;
 
 	return in_range ?
 		cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE,
-- 
2.43.0


