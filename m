Return-Path: <linux-kernel+bounces-184441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5998CA6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E2D1F21F44
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3859573527;
	Tue, 21 May 2024 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="BeN3rQzU"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D832135B
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261457; cv=none; b=GIp787iJ24QvrJ0VKXO8Qo6MBlts+y1YWrgLl6uytavshvjvGsTL1P2QSe6HZ/APB6mH37Yo7L9t+o7grmjWod0W3S+UIKuYVD58BrWWpR0HgNX5XCuwX2d914u9+v9UGdKmROmgh7Z3shxTrY4+TOL1DLP5U7Mcy2RB6qPWzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261457; c=relaxed/simple;
	bh=IB7CNwmjlf8uC05nV8aD8Ur48AzeMJj/pCJgovi46II=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSzKY/BXVknIp0SLEysdXqfgCXaIZqJe78owXuXqwiThlBfahy39O1hiRrI8h9OOsKyjBfqgzUo64b1lveCjipkMWYRgZKHTchkpMgCgNYNm1oWS9GyTtD9z/DHg6uCnCSFUWeLAb87gBByjddJz4yegfTIViGc3wiwHOKJfVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=BeN3rQzU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ee38966529so24149195ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261455; x=1716866255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3Pa7O0YRALgZWigoHd2+NZIFF5xk9ptOqEgWjtZxvY=;
        b=BeN3rQzUDLiQfb+MyaqOJAdnz5N0V2//V6EbojMfU7o6YJDz2twQwwOyff89tmQ4b1
         FkZWOhlQBGdFlccpJOju+OfX5JT9c2+5OIZOtHHo1UlrnHqFZ+wyeEb4Q0NzN3eFfBQk
         AMkAo2BNHeC4gEXx74cTr8b5ORnqRilp4Org4zzinB5Vg5PV6A6SX7pd/FQWjknFcW22
         zoOGWcKYqPKFC9bhwSBWpudKpe0Fbn6SqEkcYodVrF6pRpK3b/qXFFIIuUyR1RpdAu9s
         w4gDg8IPBBxbIQLvqa7JQ2YyiD/Jl8KYdGYXDvfcRyLYg9shT/MsqOTImpwAt16etN6N
         d/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261455; x=1716866255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3Pa7O0YRALgZWigoHd2+NZIFF5xk9ptOqEgWjtZxvY=;
        b=ngQCG6H+iT+7bI/efIPdysSg+4pr53WygbRi3/Wd2IvZYGjmLLcncye0MlBjcg78kc
         iJgIzMnIW5dQUAczvwLFG6uQAQ4WF3Mg7W1PYetIkW5LQTqomhNCrp47GDadjKrn05jd
         /vfG7uqgSLjAX88Rzh9qAJ+10MEzvuGLzuatfNmiXQ6yVF+QDvfuZseznvKarAI2vRuF
         c9WhFxYkTn/qxWdHYTs+UZ9HTRyyeJe0x0m3Jxhv8aTyqPMKOnB1MNVxwNRYYQPpOQXx
         9DcVI8Fh2sbFlddehXUtd1rFXQlu57kkZSkUc55HH+Qp6Ub9sRpK9KdwrkSKBgVsIFeq
         89dA==
X-Forwarded-Encrypted: i=1; AJvYcCUYdHwkpyeUh0VtI74QlRq5qxFJnZuAymk5C5Yw433i6npQo+FFacvUOl5JbRpfl7wxsYo0i5LSRNXtKW00AjKiuSDIKRvH8kF5d6gs
X-Gm-Message-State: AOJu0YyupM5vVYzhGJ0DhgZp2+/FYaPhEAPu1nVCKW5UXU80XvIhPhYL
	sl6HMq9bgFqnGbP3YSAXESvDAnlwuUX3Ryl2xFiNnG/mOcEPUW0mJAtjVVCEKEE=
X-Google-Smtp-Source: AGHT+IH9SJOgsXhyxaZR2SprumkcnN3Ec5Me2r3sN0mzjmJEBaExV2E/4vuApVw9qjYvznRUmtZ/rw==
X-Received: by 2002:a17:902:c946:b0:1f3:900:e7ed with SMTP id d9443c01a7336-1f30900eff2mr38837155ad.20.1716261455483;
        Mon, 20 May 2024 20:17:35 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:35 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 18/31] Staging: rtl8192e: Rename variable LLCOffset
Date: Mon, 20 May 2024 20:17:05 -0700
Message-Id: <20240521031718.17852-19-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240521031718.17852-1-tdavies@darkphysics.net>
References: <20240521031718.17852-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable LLCOffset to llc_offset
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib_rx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index c32eec733373..52fbbbaf30b0 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -728,7 +728,7 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 	struct ieee80211_hdr_3addr  *hdr = (struct ieee80211_hdr_3addr *)skb->data;
 	u16		fc = le16_to_cpu(hdr->frame_control);
 
-	u16		LLCOffset = sizeof(struct ieee80211_hdr_3addr);
+	u16		llc_offset = sizeof(struct ieee80211_hdr_3addr);
 	u16		ChkLength;
 	bool		is_aggregate_frame = false;
 	u16		nSubframe_Length;
@@ -742,16 +742,16 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 		is_aggregate_frame = true;
 
 	if (RTLLIB_QOS_HAS_SEQ(fc))
-		LLCOffset += 2;
+		llc_offset += 2;
 	if (rx_stats->contain_htc)
-		LLCOffset += sHTCLng;
+		llc_offset += sHTCLng;
 
-	ChkLength = LLCOffset;
+	ChkLength = llc_offset;
 
 	if (skb->len <= ChkLength)
 		return 0;
 
-	skb_pull(skb, LLCOffset);
+	skb_pull(skb, llc_offset);
 	ieee->is_aggregate_frame = is_aggregate_frame;
 	if (!is_aggregate_frame) {
 		rxb->nr_subframes = 1;
-- 
2.30.2


