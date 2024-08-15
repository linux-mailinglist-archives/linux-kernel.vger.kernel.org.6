Return-Path: <linux-kernel+bounces-287875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A3A952D80
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EA41F264A4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE68E1714D0;
	Thu, 15 Aug 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GuDeUI+P"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5B01714B1
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721375; cv=none; b=dNv2/Lb/N6PEvErJ00sZvW/fvRIjDbOZ61rX2F0gLxV2GlJ3UXY7lJ/N6pcU77txqQQFbHsjq/qtvbceG8XS2zfAJMA306bTYhMR+qheIms1lZ4cUmIeEr3VPDrmItvSLX9v4n8Y4tli/dlMiQ0sZdrtJnRENlRmwICAxZkixWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721375; c=relaxed/simple;
	bh=sr7j5UxC4QXw2ypOBkx4S07fGjjwP6NxkB/0YC95P0c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p/MLr4BzrBfcIVC20eafjdgQD9HnC2AZJqO74qnKtNRO1UKi1BCF2BazpbzV90M7r65CvZFoY/lche6AHsOI70JjPMTUOOU2VVwPwbQHtNjaIWQXwsom5uTVGZ4KTZj5YlBoubnbwPXkZKt8uAdMcNtJoQZZhVuUi1EYr0koJso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GuDeUI+P; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aac70e30dso100191766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723721371; x=1724326171; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTAEGW3OQZ1pLkxp14RqDDaQpOm9zbUm4HJdeRXWAT0=;
        b=GuDeUI+PD6t2GHTXyS9clkXdr5c+3iuodVEPzDFGaNMIQdJaAH7SSLCdokYM0mHziE
         f3xmzmjqbbHnbbz8j17h/+xSxLFWVn1wyieDUbEXydIKsg8Lq6jeSQfZbHupzRHfpJ+a
         cyvqAetO1Yz3psYN9MaRJg3vuduXx2+ybclb1jwo5gy4WkQ2Hxt/slrWBeXTnjZJ1Tq7
         Q3vMmV2c1rhESMyQClBAU+RpS0ZqFAhcijQiTams4dTPAy5zl+gHgREr4/jZgm8JyASy
         SNMzEJ+Ey5Q5vi2/q/DXg0/ktaNck4x/wmhFIYMEICgWDqSb6UXaWX0HlbsEaGYIL9Yd
         MohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723721371; x=1724326171;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTAEGW3OQZ1pLkxp14RqDDaQpOm9zbUm4HJdeRXWAT0=;
        b=Gq6vMamE9T8YSOshlGw/uYApr0HBa0TkWT3oDAUzjZPA7BjZnf7Ptlsci4TMZOtw+p
         cEC4G4OjBnNOPalYSOAu8by6GrRP4i0OmxsbAaNgTECBHf5kA7LBgl0WGLwbgJ88fgB4
         N3nN6nZKdezfuZdRqx0Ulqx2JPFmBOAf4ARHUYrVBqM3EEvJdL/9dxLFhik4/l6JH9IZ
         95qGIKHr5N/NZ8eEqDKmqOzXK5xXxoR5Y2QY+uANtZn4D0NTIEo4GNt4t4G5AN4Urumv
         rZbzaz5sDCo8sl2hjy9kThgrSEd9yMXW2oqPJBgoxO+/043DEYZqQPW3knDEdBL4LDGz
         Uh2w==
X-Forwarded-Encrypted: i=1; AJvYcCX2FvdsYZzLYxIEWAEvMmplbAXAcEE1JHNh2bev8bLKqHvdYO7Yeg41CwPbfRlq5FFCFswXcWdVirejWXyYcvaI8FlpPBhIY+OwWV6U
X-Gm-Message-State: AOJu0YwcCjTT9wZYNBsfhleyF8aAWSOf4nQgKD2h6VoNm/rOqtX5xD7d
	ImCGS18g5+9i6cfCBAHXxPi/eo0KGJVhbKBFqs4dL+lD/d0lxhRtd+v9qjlcda4=
X-Google-Smtp-Source: AGHT+IH9/KXxc6zq/fnEB4afFMropsvLrpcMCVRcWcQLh3uIT597PZfVNI/aJoEfYCz472UFpsw6NQ==
X-Received: by 2002:a17:907:e9e:b0:a77:c330:ad9d with SMTP id a640c23a62f3a-a836709548emr424568866b.61.1723721371552;
        Thu, 15 Aug 2024 04:29:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839356e2sm87568266b.105.2024.08.15.04.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:29:31 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:29:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Rafael Beims <rafael.beims@toradex.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: Fix uninitialized variable in
 mwifiex_cfg80211_authenticate()
Message-ID: <d7d043b2-95d5-4e1d-b340-5d7330053ac6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains that:

    drivers/net/wireless/marvell/mwifiex/cfg80211.c:4408 mwifiex_cfg80211_authenticate()
    error: uninitialized symbol 'varptr'.

It's a check for NULL, but "varptr" is either non-NULL or uninitialized.
Initialize it to NULL.

Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 722ead51e912..7505de304052 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4284,7 +4284,7 @@ mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
 	struct mwifiex_txinfo *tx_info;
 	u32 tx_control = 0, pkt_type = PKT_TYPE_MGMT;
 	u8 trans = 1, status_code = 0;
-	u8 *varptr;
+	u8 *varptr = NULL;
 
 	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP) {
 		mwifiex_dbg(priv->adapter, ERROR, "Interface role is AP\n");
-- 
2.43.0


