Return-Path: <linux-kernel+bounces-557391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC68CA5D84A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C11A3A6A09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6512356B1;
	Wed, 12 Mar 2025 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JUS9fE4Z"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6A235360
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768497; cv=none; b=cbJJTRuZBRvSWKZGv81bZ1tLyGTZyLtGkUuw1vRBhnZkC/d4NOj0Z/3geM7ZnadRHAURfborhn+SuiDlNDS0SIVmZO71IaJZtXJnEg6xFgDMJbJiWOf6WNgIcKUiJejs7QGpH92zr2LBV8K3/aLODE1/EYr6FLD1JpNNGoU3THg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768497; c=relaxed/simple;
	bh=osrEN2ym2yqpuL7B/cuo1QR3wOstyWvh9vv+cgRcDhA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qc4ZCEMMFbT45dLAyn7GBywbFkoDUpSS/9oJTPIJ2ocWLDEt1UVpjzQZKdGn3GUJBfWP7Ts9ouVIi+jjiLGz97E6GGZ3Avmp6Rl69mdLxGzUdFQQOuYiHgaGTqIuiwODnQQmLNsbVTf5D6S6UeqbduDcVByUxtetDQ3XMOXIq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JUS9fE4Z; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso23490215e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741768494; x=1742373294; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fArFyg50PD5pydU5ZFimqktWgEs1OFGNquYCJqIcMD0=;
        b=JUS9fE4Z4fGSyssMHCURjAcT4gA/5iV34Ji63WM7MSW1984wR+wL1s+PnRIQ6Ri2GT
         fHKpJzzLRbUrDhJshPIoJ/2wt34a773ApWAv7qTV/H5WwY93hXpoUknBJ4rPwkKrfmBf
         LJfEdI6EjaOD1B9/zPRhlYs7y4aoSZtPodBfMB4DNigWEFdIL2w/Vaj9WIoALSm4tcen
         5OOu9ARQTmCZ9T3jTHS/1D+V2Eoe4kDLmq6qpmVM4h7mrO6V89prEfCZ5Y2gzGcVEFcL
         2Q0V+CHQLLhmKNi9g9X3ySUEmRNbXjHXr1HAgUZIRhbZQKJzSQxQXwzy3IL/F62LoRou
         DYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741768494; x=1742373294;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fArFyg50PD5pydU5ZFimqktWgEs1OFGNquYCJqIcMD0=;
        b=NHkqX0BzSzA8p103MNkIigpk9jgy40FpovhCmL20EhCMTEQtyefTmiCUJCakxzBP2x
         89kHujdpsoC+Zj6g2yPfSFUZraOtapYZ08TEFmE6PSGRdzPKsCSHVhDJNE0HpP02jPhn
         TkL3K6vLYnZuumiJ8GGQqc6nPfaXyG6x1lIdS+wOi0QrLB5mVMUMd7ghK+gb2C6xr5kl
         fJr5DtHXlq8LbpALlL0kbEevfup/FyApqofWnw0N8f7yDsZS04gGBaf/P+wunX+udiUj
         aMNHCmMoFB2tFgeBB22ZAtWP0oCn72t6GBgeUgiwMVIGtkUqhPkELzwhwTxQ6gzsQhBT
         gtfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4/VYvhepSbyi0I3h66MpO/OLNDIpb3vfNm7htqDy0EwuniEqQpvExOVWYpJlDQYshrn0pL9KOufQV2fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbqYJ+MULCLC4pPHC4wXjC8C8izhwguGXCNsXutNG55vSYoTN5
	t2+UBSNiiKwh9WhgKqY2mhwGwTX/VPp9XAlASG7LzBxhk28R/Lyo7HSVfkmb/UY=
X-Gm-Gg: ASbGncuammBxjOAvR/g8Rf28fHh3JggLi5HypHg9VWzeVHb6aRrAqOZkQOgER2gXz8i
	N505Pc/kTjmwsO915sUw+2C/M6vdlQDYlAxXOD6c6LBsa9jAbAzLWcoUe0pRm7c38RkYJqsnXZW
	btleli7WymRTfsvHBB6EULQXITh7O7KdSnsMqR9ykZLNbVxGI8tgvLJw2zrke6/amOJIQ0CyafP
	UmIZ7NqPHeYw1vlY+vnfVhsdlxCL6PoHV3uYMkq5KjSPZay5ezXDcSPSpDPQwQ/Gine7d+/NGYI
	qUqDivYtmGmXzQvAB9jw0/it2Iqx9B72EEN6eLdJ6FFyyMzkmg==
X-Google-Smtp-Source: AGHT+IGHjBnjKqz7j0n2tGlwarxD7Uz84jTKBk1YUn+9ERyojr84A3D+g60nAnIQn0oMlwl9U3UJ+w==
X-Received: by 2002:a05:600c:4f0c:b0:43c:eeee:b706 with SMTP id 5b1f17b1804b1-43ceeeeb95amr92425115e9.24.1741768494113;
        Wed, 12 Mar 2025 01:34:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d0a74c59esm13832225e9.14.2025.03.12.01.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 01:34:53 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:34:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] mfd: cgbc-core: cleanup signedness in cgbc_session_request()
Message-ID: <9e812dfa-e216-4e40-bbf0-d0b63b110bb0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This doesn't affect how the code works because there are some implicit
casts, but the "ret" variable is used to hold negative error codes so
it should be type int.

Declare it as "int" instead of "unsigned int".

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mfd/cgbc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 85283c8dde25..0b3788c2c1af 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -96,7 +96,7 @@ static int cgbc_session_command(struct cgbc_device_data *cgbc, u8 cmd)
 
 static int cgbc_session_request(struct cgbc_device_data *cgbc)
 {
-	unsigned int ret;
+	int ret;
 
 	ret = cgbc_wait_device(cgbc);
 
-- 
2.47.2


