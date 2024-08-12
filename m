Return-Path: <linux-kernel+bounces-282662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0533494E6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FB8283E93
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9955D14EC64;
	Mon, 12 Aug 2024 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBuT0OHR"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BA61537D1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444998; cv=none; b=RSG2tHFUfjIWwrhiH75YPITKwByA+rjN9djmmymnZ88+XX8h4oqY76rialvh8HoXzZluIOR5rEvToeUROnLFeFWt+7HCo88NnXqHyMRbeVSSyd2C9M3pvKG+zBffs06t07XYgKnKmXFF1QYV0ignvt/h21/krjyU9Kv0JhkAKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444998; c=relaxed/simple;
	bh=y2rTkK36HSBOLJ32CSLLN6vZXBG8wpeB/uPQHcQRFws=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=elpjgQSOxHmvKYunAoi5zHKT9C/SsoZPyGR9wNV8i7baLr7Z9A6Sr+4dj1iZyyMrOg9ojGJMieQ80zqtikFWa95nAkjVe+ucPwy4givONlKNBxtheo5rRvWCVuADWArY/Bb++iJKz/dcXiPgNhcdbS418L1fZ7NZR39Yu3z5idA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QBuT0OHR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7d2a9a23d9so427523766b.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 23:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723444995; x=1724049795; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lbk1v6Dq8H0stWDfbtbWzC1hgrGf/GYDIFM0FXly8S0=;
        b=QBuT0OHRlUxlwGKjEp+lmA9GZDvHNh+4r+RbW/w/K1Ky/93dXfNSEpCjz+bx9KVCtm
         7qq0SPhP0QZZfnxkZHF8fGxrMoz+wwqRl5C0ekYIp7sHh9q6m0dohp7SVC0nvLfdGSJg
         7vrhT8RGxK1E7VhTRUL9LbK2u3+RGZTY/uTji3lcsaKHtv02IphhS2ninZLhMB9FH5nl
         Wjd83uoGnWvcOQjvBdCraszk47KLSLpSN5GXLKYfENsVd3yDVC50S+Sx3erIt+RD3h2l
         nsGhemR9nUX0NFDcH/3WOc6DVCIoMi0755rD5guvDBfDblscodW806p5z7PCmrmc3Pbw
         bNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723444995; x=1724049795;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbk1v6Dq8H0stWDfbtbWzC1hgrGf/GYDIFM0FXly8S0=;
        b=uNOoP/89SujQDP1DwtEowCXFRX3364EOl1HCztmSJ/6VaJaY+rPEZovU7ttkiyVo80
         ogLRfq6WsRGr2xdnaA01cnfJg4QEzqVKTOFqOZPa7yOuJxke/W6QjzisgMn8AAiYCxvy
         8ItwkgFquy0QR8yK6v+hWZ1lW9k4LeqX+xlhFQlOHyWjcycsqzZCv1BgVR9tRh+C1WHJ
         FH/YZWkd45NqsaUhA9GT8XF9blNPZ3XReSXcAu1CjWT8NGsv8Ow2RxR95eaqnoeXPzsw
         au6m0gPIvNC9M1cDgoUI9cPwElZssFzJRiSg/3yHF0LxYnezoDv0lWuu/YpVClOMzqo1
         Ex8w==
X-Forwarded-Encrypted: i=1; AJvYcCWQhPuwwn2DSlLo0nRqBPnAs0PO2xV8Iss6LfivaVuOfSnhE43r5UKkxvxtPARSpMy0C3ThamDAz/DeKmvdoHnButZGn6WbrIDOf6lF
X-Gm-Message-State: AOJu0YyGy4I8+yUxVESdpH3571S71/PPwpPmUA+n1fDoLXsIXPi89TtV
	lWSmk7WOii4wszDdsZBrNeLjRKxQs/fbm9q8LgUR2vRBigq+8BNKzGs9W/v5/Jw=
X-Google-Smtp-Source: AGHT+IHdlRAn61sJCLGJXEbG9EdnA7ugHPcm4jgWJ7ruc9zVraAFTLGMOKHsOinX3VlxmZmUEw8fYg==
X-Received: by 2002:a17:907:ea5:b0:a7a:929f:c0c2 with SMTP id a640c23a62f3a-a80aa65ce8fmr633287066b.51.1723444995569;
        Sun, 11 Aug 2024 23:43:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb24246fsm202385566b.203.2024.08.11.23.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 23:43:15 -0700 (PDT)
Date: Mon, 12 Aug 2024 09:43:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] pwm: lp3943: Fix signedness bug in lp3943_pwm_parse_dt()
Message-ID: <5e74df19-4469-4a10-8b87-e918769a2f9f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "num_outputs" variable needs to be signed for the error checking for
of_property_count_u32_elems() to work correctly.  If the property is not
present then we're supposed to continue, but in the current code we will
try to allocate negative bytes, which will fail and it returns -ENOMEM.

Fixes: d6a56f3bb650 ("pwm: lp3943: Use of_property_count_u32_elems() to get property length")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pwm/pwm-lp3943.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index f0e94c9e5956..803ecd6435cc 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -219,7 +219,7 @@ static int lp3943_pwm_parse_dt(struct device *dev,
 	struct lp3943_pwm_map *pwm_map;
 	enum lp3943_pwm_output *output;
 	int i, err, count = 0;
-	u32 num_outputs;
+	int num_outputs;
 
 	if (!node)
 		return -EINVAL;
-- 
2.43.0


