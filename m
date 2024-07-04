Return-Path: <linux-kernel+bounces-241331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86989279D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97031C247E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31BD1B011C;
	Thu,  4 Jul 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3mSUVnc"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFCE1AED21
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106344; cv=none; b=bJNKBhgXCdakbUWT5x0xIGg3hoQ3EUm13MegXiNLvVUCxlNQUk9DOgJx9+7EGcrbqeyqwR3ZNYdaJ8zsL256KmW5Hc5DUdxF1/L6GhA3y0IR0EJ0TEnMPGpqa1TiMPDykQtygBHifCC9Ihk78F/BpzYPBT8YnsCZd9sgXbcviVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106344; c=relaxed/simple;
	bh=buQkhNYWNZ4v2t3m4bQVQhaixs64N6pn2WVCfFRJwoY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EZgs8lCcyD0SpkuUFVgsiQ7U4/2MTnnhHazY5wad6WGNkFkA48DV4tvsnTga8gvvmGyH9qGDgq5CWSxH2UmkvKE7Zl20FaaAb4WsGxDQOmLK/eT769LZRTPWRdv9MCyVRdJ6J11kNPSfay7aPG06Xp5TQAUQrRAVvQFYFTp9LZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D3mSUVnc; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25cb15eed97so426339fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720106341; x=1720711141; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMzeEDWFLbET7EVjJ5/MmFzOYk7qyHAIetPdQnDCD/U=;
        b=D3mSUVncV52gPDWLF/L81hURvQXpLeNz3zXUtINMOlpgP6V2BKwgyOsi37CwVZ6XXp
         qowvCeTrDcnTFizi1QPKsS7kv/dQh705n7h5zmftefs7NLbyKhgqCKvHYR7y9BSxOruo
         DHfkaH2GWn5NMcC92G73pwM8f2swjwVnkD9P1o93XvWPuxhuNFe+ynNBODWMj5zGXvK8
         6qbrXsHsBOGT5FF0tyZLp58orXBlQHstEg01lM0S0ldhJ09vdo+41ctG/j7rsyTOx8Fy
         6iwFT1Bj3Bwbj8vj3+4ES+C0T0jvKq2bVyHRcXzefnSOtfYTROxQSsxzZYefnK8eq0tk
         2IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106341; x=1720711141;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMzeEDWFLbET7EVjJ5/MmFzOYk7qyHAIetPdQnDCD/U=;
        b=U0EB8Zxwvr6vMTEVlZ/+kiVSxlPJ02FQzAoaP8ZxQw09PHe1MXeE2qR98ggI6DTCJd
         XgTYliZt23vOJlwK6Q89FvV7ynCDCVlgYT1mpen164ZvNm1LCgoHiH40gcD26+wVtvo9
         2Fm+z3gYsGLWI/TxWd+MIazLXflT7zU1QuGEEEooEwqjmM7hOp487GB2q1oWajgUG9IW
         uzpKNjG12mJvZqK3CCn1KLU22btPVOSkL2VgSsiBIf1/R7GVkRpdWLFPLQ2smVG1sCAr
         DOpo31ZCYi8/PlTad0GkrAwjC9QdX6YLwG88ijrZOxje4AaXK9s0Rk8STE2AvMf+AX8S
         vvxg==
X-Forwarded-Encrypted: i=1; AJvYcCV/sIdZfQUnPuGl6/XKKweLa24wl1FhMCD6UelSgwjnOd5fwnwprblOd6868/2/OLfGj9L0/LZeuuURClISPYQM3w6uiwFp6CG22lgv
X-Gm-Message-State: AOJu0YzMVHbTpaOO+J3fAgTm5iL9+tbOQtTUHBpnHcO7THw5gFKQ5CYS
	jzPvtFvdtQLvjEX2sohKxLh5JK2FJvVB2Q0inj4cuh4KFDUuIpDEPI4lEg5PzaY1uuJ1Vx0I0Ps
	R
X-Google-Smtp-Source: AGHT+IFa89RkSbBtDLAGPm/Oytl/zqf+l6nNhycW5ftQ0IzdwyLCbQi5qoc2uJ3JD73BLAFEC92q+Q==
X-Received: by 2002:a05:6870:a11d:b0:25e:1cde:f5c6 with SMTP id 586e51a60fabf-25e2bf33b14mr1598496fac.53.1720106341662;
        Thu, 04 Jul 2024 08:19:01 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:96a0:e6e9:112e:f4c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25df20b0423sm1336873fac.14.2024.07.04.08.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:19:01 -0700 (PDT)
Date: Thu, 4 Jul 2024 10:18:59 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] hwmon: (ltc2991) re-order conditions to fix off by one bug
Message-ID: <Zoa9Y_UMY4_ROfhF@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

LTC2991_T_INT_CH_NR is 4.  The st->temp_en[] array has LTC2991_MAX_CHANNEL
(4) elements.  Thus if "channel" is equal to LTC2991_T_INT_CH_NR then we
have read one element beyond the end of the array.  Flip the conditions
around so that we check if "channel" is valid before using it as an array
index.

Fixes: 2b9ea4262ae9 ("hwmon: Add driver for ltc2991")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/hwmon/ltc2991.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ltc2991.c b/drivers/hwmon/ltc2991.c
index a01f887392f9..573cd8f5721b 100644
--- a/drivers/hwmon/ltc2991.c
+++ b/drivers/hwmon/ltc2991.c
@@ -225,8 +225,8 @@ static umode_t ltc2991_is_visible(const void *data,
 	case hwmon_temp:
 		switch (attr) {
 		case hwmon_temp_input:
-			if (st->temp_en[channel] ||
-			    channel == LTC2991_T_INT_CH_NR)
+			if (channel == LTC2991_T_INT_CH_NR ||
+			    st->temp_en[channel])
 				return 0444;
 			break;
 		}
-- 
2.43.0


