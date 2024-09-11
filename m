Return-Path: <linux-kernel+bounces-324387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D09A974BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197F1B21708
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A15A13A884;
	Wed, 11 Sep 2024 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jf7mYAfT"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5133086
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041299; cv=none; b=KdmnPmSVceu9Ilu4MAVSKoRqmgSiHtxUaQ2SohB93+Rsny3d+vN6Z88gLbdzP1d94NbXF7QHF8wcygbgK68/62yhD6Vzu515o0bABHcYwsY/OM8uj26VvzfIjSpkjXHXIF6ks997UvSd4qb7/xYfRjj+1/IWGPRItErVB0Qh3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041299; c=relaxed/simple;
	bh=FCNL3enQMB9b9oZ6WMqPum3crBISQcFGFq3X5va//7g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q8ikoyp3jdVdG1IWe1KZbU+8bIwOPlM28FC4bA1Ri8WioRrcT/RiuYQyEjAs9MiFZYcuNVUtGgAUtdvxtBydMCG7HpJhODjyvupBpQWnHBfiA1gjAVp9ujiuq59IjRrc9WXOexbctwxOwXQbDWLrk/G+4yNRcYmS20gHYp4J4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jf7mYAfT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cc8782869so11282105e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726041297; x=1726646097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6g1B5VNTS3oGUnmfFgas2SEgEdUHJ25qE4oeaeVF28=;
        b=Jf7mYAfTK+7+nLfpBRrzt0teLyOUOBMRtPJ/i1G7CgGswcZhh463d3hCCkYh5M567s
         p6GEiQUSDDt7Uo7ywZ6VogEQKaOA1vfDtuAYqBAs/qHXPveUcBkXipIzoqO50ZYwbxKP
         4ox9vNR6RWmXfvM7p2xN7QferFy5wu0d03IrFWNdIWuf6wqdtewS4MXsN6hBdb606mS3
         XByXBe99T7wxDTiconDnKE4JHTP/7PEPqCJ4PIrz+sU7R6+Gs0t7jSY9zqMA8CsY1/6L
         PwYGVg8RwY8dUp4aAwNTDROesiBEZXLzcdqDseEwFz/4HcoV4rblNAnfn8513YNYs0Rg
         0Yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041297; x=1726646097;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6g1B5VNTS3oGUnmfFgas2SEgEdUHJ25qE4oeaeVF28=;
        b=UZjKvMQdBOlklA1Baq64Q4GNROTHyc4JTZjxFCzsJA3rczwdQVs2NpmKUuhdZnqFl8
         4HQqquwmQfCTfWd0duPIuBuGstvPAcWjm/jNGYY0rA/NVuzsqVs9QgtexCBYv6aD6OpF
         TEm3XthDNwrKMKiGlFCitC3KVjyrMD26BmBHyQFPhY1+mDHUHiBCW+SA+bRTnKXwQ3mE
         dv+4ytq0lP/3PunMvBdArkX2ScEIm9I1tP+2K704N44rNLDKUSahuhRcrstfwWKWISkO
         7FAm0V2ROKZyG7M27/4Ljis7lPPqmTUNDiY5od09o/onkIkVydYngEx1G/1ts4Wo+spt
         Y0sA==
X-Forwarded-Encrypted: i=1; AJvYcCUUh57rInKrrkInJmU5Jlsd+S1jLsQd68Wav7jPod94OQeLzZUoP9VXyBkeAaJ6RT3MzHuUV97oymrlhf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAc16jW5m99W8xQLjspJkQFurpEKzo/7mgPsfy+SCPF3msUkHq
	ZMQCuz2YnKTgGQzkLeV4LyT8/CyRYJLvOeVqAumvKd+xQgy64APAoC45FAw/UuA=
X-Google-Smtp-Source: AGHT+IGMaGtd5pusGWK5gC/LDrjf44vrtvtmz1nIDEiCzD9gkk+z8vd9V1M7P304PtExRrT4QkP1sw==
X-Received: by 2002:a05:600c:1906:b0:42c:bae0:f066 with SMTP id 5b1f17b1804b1-42ccd325863mr17424475e9.13.1726041296559;
        Wed, 11 Sep 2024 00:54:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc137556esm42959305e9.1.2024.09.11.00.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:54:56 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:54:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jagath Jog J <jagathjog1996@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: bmi323: fix reversed if statement in
 bmi323_core_runtime_resume()
Message-ID: <273b8f96-0d32-4913-bc6b-e91b391e7d7c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2efd1dd8-5a4f-4df0-8acf-972c91b7c9a0@stanley.mountain>

This reversed if statement means that the function just returns success
without writing to the registers.

Fixes: 16531118ba63 ("iio: bmi323: peripheral in lowest power state on suspend")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index d415b6542089..a56259c6434e 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -2232,7 +2232,7 @@ static int bmi323_core_runtime_resume(struct device *dev)
 	 * after being reset in the lower power state by runtime-pm.
 	 */
 	ret = bmi323_init(data);
-	if (!ret)
+	if (ret)
 		return ret;
 
 	/* Register must be cleared before changing an active config */
-- 
2.45.2


