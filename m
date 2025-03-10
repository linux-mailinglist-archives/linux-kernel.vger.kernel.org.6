Return-Path: <linux-kernel+bounces-554010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C855A591CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635D41890A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6F22288F7;
	Mon, 10 Mar 2025 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUwfjXp9"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D74846C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603714; cv=none; b=HxozzhSYBgUsY1vp/qSVt6ltcDGabUpIardMuNRj+OuI+6vPiuM4sETHr+cm5+sLWvcsVlmvabG3Z5JEKYR8O6bytYo+arY6P51r/soaRWUfE/xC+QxUBiH74A1TUAgJSfRQOcboFdewFJ1XkjQc+BfYY6m05ApWtRpU5V2F9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603714; c=relaxed/simple;
	bh=j4PdO1nu/lOtJhos8w8kwuTN7slIzAII22YRob34W3M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sehyhu9H5talFPvWK7QXBqNlm8MkaoIAJBaya5UStX87AgIjzMLKNIWNHiTNGklBi74vENFRnHafMSQbGHuhi19iMsodo1fX33vngMnL8I6uapYo3uP0Q0qKjXpR+oUZlzPoFOaqz0chMoAaiEedOvaFct8AVEszEIb7ZDXbCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fUwfjXp9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso8099025e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741603711; x=1742208511; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcnXFhBJsspPY81aHKEpyHgRpt8kbK5A2y07Uh+g33g=;
        b=fUwfjXp9rTFdMI/2jYh2Pa4duCMDN49sgIGYlm0TwNFFy9a2ZRTS1uw6F7bbhYyEkC
         pJuLv97Ai/ibsz6KBsSfEs1Lj8NBHFuNj26D9ZQortapRgDfYqUulw9Dwd8Ow2KC8Kv+
         MVRhXW97OTq31uq3smzJpBlNW6UYZXcfifMl+eQsDrItmIFsYp36ykLVMsit6d8QJliy
         T9upNRfJYVkUTkpkuu++VOD6xK8AFFVhsCwfcAVZq676v/8S2UTS/QgfqkZMl2iqA5/1
         OsvjAjBK2YVa2t90rOnyIrPoFig+tTS6NVMsYSVb1IbPJFbf5J+R4gm2eCvS1mGXhw6g
         FGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741603711; x=1742208511;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RcnXFhBJsspPY81aHKEpyHgRpt8kbK5A2y07Uh+g33g=;
        b=JJH1iGeIXjUjX8UOrECk+CrPJ39/G/OJf//xIm1qS2yWx0+CuNCL83ASuboq8Gx+17
         xFiIup0v+qrFstAvU2N5CdGTAHfYKh9nicOisOZ8P2TWkl7vwSmN4QEQv1E11K8L9naG
         l2iWfBUQTyrTTXFlCjMtLW8jYtmxSNjBVd9e34AFuBXdtks/o5FmIJ/LeGrNTaIfMBSU
         k3W86gKYO3awCDT02HHbgaaxnnugFXkj4G4uFxUa7PbCb7hjEsabOdGUU62xlvN1p0JQ
         raXBBWJz4/9bf20j2dPk/muEUb4P4yNFTl36y088ls+9albfJVM10q5jOC9huUOh16M4
         SZlw==
X-Forwarded-Encrypted: i=1; AJvYcCUFEwXXq4+PdIuoZ9idycANMVi/yEeHZ2/t554tvXedNKV/KFX7ji/I+rctnfCnQEPQD42yUE+NGQbsxd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQILfbl75r19DnhU9p6JBVpNnzlr+6fv62e/SC8D8r1YGeEl0
	eQbxoNZMsb4iaZLrtpogLC1zjOqeTqWGLNQ+qM+N4Ml/CkXchIYqshDc85s2bs4=
X-Gm-Gg: ASbGncvQlEvEnnOrq16tudpCtq5K5rmM+nNKzYl/GGW38wuQ6yMyuYo0EmDHZWNOksh
	0wNkf1BkDhOcOtI742KH3/pHREU7gPf3iZ58LBUBJ0GIG48Eyp/kXy0VjFeKntTFlQir0VwTM9z
	3qEQv0XGUooB1fGPs5eUwZzafmVNdBkCR4FjKEqV1UxjAUCS9yG9Ytp607ks9H+6GEEHsL4zKXI
	OwmvwFggynjewGZJWX/40QEC8Wc0Bt7OKR55PtrouZZm1S7OqC9q6VL0TOCRtXgoBDvzDNXBIJ0
	5PoRnr/IhtjB+kuiVmTtODIzyeTRgHharplTcVeqj1+ma6O8Tg==
X-Google-Smtp-Source: AGHT+IEvyQMgaUHnCuYCt+OpJiqkHIstn9Ui2odq4PjFQ9lNSszLbzPKWSr7S0YVwsCBZMsm/36JQg==
X-Received: by 2002:a05:600c:470d:b0:43c:fab3:4fad with SMTP id 5b1f17b1804b1-43cfab351c6mr15054385e9.16.1741603710881;
        Mon, 10 Mar 2025 03:48:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43cf27f8ef3sm45737585e9.11.2025.03.10.03.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:48:30 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:48:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: ethernet: mediatek: Fix bit field in
 mtk_set_queue_speed()
Message-ID: <eaab1b7b-b33b-458b-a89a-81391bd2e6e8@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This was supposed to set "FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1)"
but there was typo and the | operation was missing and which turned
it into a no-op.

Fixes: f63959c7eec3 ("net: ethernet: mtk_eth_soc: implement multi-queue support for per-port queues")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis, not tested.

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 922330b3f4d7..9efef0e860da 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -757,7 +757,7 @@ static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
 		case SPEED_100:
 			val |= MTK_QTX_SCH_MAX_RATE_EN |
 			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 1) |
-			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5);
+			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5) |
 			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1);
 			break;
 		case SPEED_1000:
-- 
2.47.2


