Return-Path: <linux-kernel+bounces-571436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751A1A6BD23
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A768178973
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47F51DB551;
	Fri, 21 Mar 2025 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yRwH971U"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676B41D88A6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567746; cv=none; b=ppi2tgLCIrPLyA6YwT6+POqAV5uKC5PfdBmUvsE4v4S2BgzWK8WXkWKek+pPNqVilqBoH8Jxmdc6uvS3LCQbk+U9fVd2Eiga0lbcfK0o5F45U61tt6aK0SKFqiKnlW1yzVgrKww9nzUQIr3CCl3E4gtUShXm1nLmCXbnOIwJQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567746; c=relaxed/simple;
	bh=unOxx1FBF35f82m52qxSk7k7s5uAwciJ4IP8upP94sU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IxfbG6XUW1U/XtCbbWEJX34ixUzJyjZN1VDHD2qCL1HjrACs+HLRU80pF490ApWVnhucOATJehyclnGo7Uma3bvbm44Li28hQu6p+3ualgA/U3AAE0CnIgy3D5LBN+A2GlnexSmmqRdsJ1igHtNr8jvASbZvOLxgVrWj6+6t6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yRwH971U; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so1264800f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567743; x=1743172543; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReU01VkkdQwGejdvSqZN3T6tHm1DJDLTnc3Lm0Bnfgg=;
        b=yRwH971Uj/aI2r211Naevx8knD2GRJvk1ZMlqlmq4RJrnEG5J0ZmcT2AN5ZTxWxzfB
         9mZajiJVgxgS4FhHnQg/VM9E14qwFLtWNjRWuM0T5x6PftQgzjNE8vEdPvgL23QZ2Bif
         RN+mmLkTdwQ7h9vlS5SUF18H+rWTxrSd8iCyKF0yPFK1j6UASVmLsRzoFIguSZBxLdBu
         mrLZMJ7vVvefvJtc77P7idyWYHjAC7FnrPIqeJ+YhsBtprw/0I/ut7+rioSb+dS6hV1g
         QMq27HndM1vw01XJEIstNt8xA3csvpt0kPF67kXrDdrF6hbDwTE2pKz8gfLDd0eeKoN5
         BLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567743; x=1743172543;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReU01VkkdQwGejdvSqZN3T6tHm1DJDLTnc3Lm0Bnfgg=;
        b=h2X6bIf/aj0i7ChbhMj8wBBOcrG0O6gquPr2tE2MrxjJFVDcELydbS9Hn10G6LsW0t
         LTD5IlBuw+iz1kvVmjDzTYrvub4I8kdEKq/Aaf3iXpOT6cgQkXkyABH3CcazFMZf3JWv
         Un6EKKaxFbPBRDipTbgFk9qSIp16DJ03/3GQfGxo1crcfOnGXvUt8nXnH4hAs4hLJGp/
         KmiB/HhPqtw4FmVt3bbpkNUuazrCT+kGpb5lbrMoN4KPiS+HDSLyQysQyeVq1OuAekgF
         YvWqRmGYRJE2Bl+J8EUz24y8mT4z+3AlYx5OD/hkdvy4MLaR3K7jBI354rnvBv1famBi
         dJfw==
X-Forwarded-Encrypted: i=1; AJvYcCXUMdMw3R9g7yPZ3qZZFf6m34Sn6rJv6BE4X2VPGSe0UwAJHcWTgxuS/npbtzUdgB2NlNSf8+3c5uAVvJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzELv9XRoFF13N041w7qGfKo8KzDNGym9+nTEuOMJXGolHohr/j
	SnQiwnNT3jG7BW0PdWvX4J8d2PWDsQcPWP7WiLoEwUcr61WcBoiPDjFTKPrl/5o=
X-Gm-Gg: ASbGnctX4OOw6Z9SeTzTPHv3B6l9gwbiNmqMEA8i71SwYkFWAE3YKtNld63HYJJA5uR
	avfNqSqQ9G4T6Zh0YPn8jK8d9jyvHJVxvV1szx5oMk/La2bJ7mg7+i9mIEbJtCkHpYluOxIFONs
	eFXEOzg/1FyfW7DWu0s7KJW0H2Glut4NZLQxtCLN4KwiEF4mCK3VYXXz9sUEgS6CH01QLPsxLj7
	8TVsQEWZkPd53dA7IF7xkYWExh2H9KiUhd73B6yPRrIMvxskvHofRhXD9bDPtzarlUy6KhRfN2f
	j2oX7LGLCjGdHU40VhZddlVl2iqVvuqGltWQYGeL+k9sN48Fyg==
X-Google-Smtp-Source: AGHT+IGhlqCe2mLQ6QE1+jNsut/3HpyriKLoQPJNlU/O0xCCy9UTKeLE9FjCB0uErwEBPN5BJ/Tizg==
X-Received: by 2002:a5d:5f8c:0:b0:390:e7c1:59d3 with SMTP id ffacd0b85a97d-3997f8ee934mr2979865f8f.2.1742567742643;
        Fri, 21 Mar 2025 07:35:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9957aasm2571305f8f.10.2025.03.21.07.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:35:42 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:35:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Quan Zhou <quan.zhou@mediatek.com>,
	Hao Zhang <hao.zhang@mediatek.com>,
	Allan Wang <allan.wang@mediatek.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: mt76: mt7925: Fix logical vs bitwise typo
Message-ID: <d323a443-4e81-4064-8563-b62274b53ef4@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This was supposed to be & instead of &&.

Fixes: f0317215b367 ("wifi: mt76: mt7925: add EHT control support based on the CLC data")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 63cb08f4d87c..79639be0d29a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -89,7 +89,7 @@ void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2)
 		}
 
 		/* Check the last one */
-		if (rule->flag && BIT(0))
+		if (rule->flag & BIT(0))
 			break;
 
 		pos += sizeof(*rule);
-- 
2.47.2


