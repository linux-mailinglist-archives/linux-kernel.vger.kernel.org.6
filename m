Return-Path: <linux-kernel+bounces-527151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CABDA407EE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C1B3A602C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124E420A5F1;
	Sat, 22 Feb 2025 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/ra/qV+"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF820A5DC
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224236; cv=none; b=X/yJ5u/WREhwC0KVppCpcdfyGFKixQ6LlV2ZmAqZjGTGAPdX48LLf8UDol2+7UGd3Ka4EeLsgpP6OQ3NbxWOxZiskR1PZJYcbvlqUiUV0eauiqfoQ0AM6E8jQj9WSncQsBzrkKw8TW1JfLETps2G6P14PdYw8RHnFC8v/Kq9nco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224236; c=relaxed/simple;
	bh=+gzPCzgwAKNM8/ZJWJjxU1G7s5YBlENvtEAXPshOQRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d4vXHjaKALa5B9pWoDFikLOiwdHv9jJaLWkWEWa7jXUXoyYumroR7AN1LawVb6PBuZq2pBy+UiUtjILAAEshc4n15LHnsa5oeI/1obLWe9fy/s1B9BQk7sJIJhwAeFNcPDNQH2F/SYgWWco/7G6geKGWF34f8YP/AXNXPPrJ2Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a/ra/qV+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ded500589aso521000a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740224233; x=1740829033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOIbgSHtjXVN2bMi/fs7NSMZMhuofukk1MwFWusZZog=;
        b=a/ra/qV+kHsr10x4hdaxK4ohBoLbGBWVPnh8+s+mC9/XRCXN3iNjeCLwrg/wGfsV3x
         h2D9leldXHpQyb2MHKwZeQWUz3eRqN5qqNXQF6GD73ikxgUsANctCeKvbXsdUZjkyX+Q
         Ivl2Zv7d3O5FJKG2t3GsT2VxDFGavmZRvA+SikhX2954HJD1wjT+uCD4RViJyxT3K9fr
         7DYRCZAK04kAjqk9d/GgMbhxHuxTrwN3CGafQGtyhQAevkU3++QWmnk9TKGZF/MWiJsb
         9v743vJheA2NoYqnCx8CzbLU0T6b8AMnjxh7a8n90wKm6RAmDg+oWtxzve9gPWOk/KLa
         EfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224233; x=1740829033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOIbgSHtjXVN2bMi/fs7NSMZMhuofukk1MwFWusZZog=;
        b=edqXK/V/bG6YL9jKafy7LXkA5VH9ppUjpOD/nJ6YImxNd8niS71Ah6rU1gmy/ZWxnU
         8btO98Puo91s8xBTfbxUYxM4TUkJimQSp0MwiH8RGt1WDa2qzxJDEK9hw6s2i7XKXBdl
         5ZINhxrpe8GBEGEvhkeVzTIUhIgLI+bN6SpkrCi870XdJCA7RyzwJSAGapkAIW152I6d
         vR/OWV2s1zwTl0VIULJmKeV93LNY4f3xKQC7DlhbZQJ7ttnl4HEbv72Hjwmj00C0dMm9
         fGmE5rHUEuijSkc/YIdc1iRy7TwIk19ouuNDxG/t/x+/4o8Hprj/Wk4TrMYrIzGY7om0
         FLNg==
X-Gm-Message-State: AOJu0Yy7mNOn4vwF+d+1XezKSzVzcFK+IrOMRHIt2BpGmPHHn6uGiWXp
	UYcY1uA7uxms3cxPG9CRC9PiTVGdlro6UEn/rhK7J9SZSQ6Wbrzqci2HMXdirErzL8qloFtspVo
	OyVw=
X-Gm-Gg: ASbGncsvcJ7kJAKoVHY9ZAoJUDnG5M1UC8uiZ8CSiAoBa3AQnvf8//YgXJLFa0TlZ4X
	pimHv3DbZWQL6D1ujZqjMBKztJZtdSJFCtCWdXb1Ym9x8KnP2uPmozWqMwmHwSWLInAXzHiH0M/
	r3nV4voYdDRrRC6fyYqL41wgXQdcQQlk5566IFAOxyiqewOiCZMWFS3jgqcM7OhMhHjB8cMvbGc
	X7IV/7C3Jre7crQUO96il/F4RyQe8WTi8hWvCXDqjX1PFxGhYVyUrb7Z1QUtDg4/ZJ0mT7N23UX
	/IXaSz7e5YO8ou67FWibTZGEt0PJ1X0/UFXYMGJfj2tU20UksTcEdUvPXChRs3ejBdKGEnrxG4C
	D
X-Google-Smtp-Source: AGHT+IEtusslXjOqZDcLl3BrueWgxJmH3meFIZLd3KJN94Q7dAGd6XAzw4rj6OZR2HjyjFUwIC/Upw==
X-Received: by 2002:a05:6402:3589:b0:5e0:7ffd:a6ef with SMTP id 4fb4d7f45d1cf-5e0b721feacmr2208882a12.5.1740224232785;
        Sat, 22 Feb 2025 03:37:12 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d369esm15011493a12.37.2025.02.22.03.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:37:11 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 22 Feb 2025 12:36:19 +0100
Subject: [PATCH 3/5] mailbox: arm_mhu: Constify amba_id table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-mailbox-const-arm-id-v1-3-d60589215a24@linaro.org>
References: <20250222-mailbox-const-arm-id-v1-0-d60589215a24@linaro.org>
In-Reply-To: <20250222-mailbox-const-arm-id-v1-0-d60589215a24@linaro.org>
To: Jassi Brar <jassisinghbrar@gmail.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Tushar Khandelwal <Tushar.Khandelwal@arm.com>
Cc: linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=735;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+gzPCzgwAKNM8/ZJWJjxU1G7s5YBlENvtEAXPshOQRU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnubbbj2muX8OHj/uuIaSzmF3ucTnAv1VKrs7j+
 Yt84ycqEjaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7m22wAKCRDBN2bmhouD
 1z4xD/94dwchMbK3Ou9dG2zdR89h8G5w4RftC/ZnfracN84D+Lvdq1CscWW2+2rzf916N8J+5Xk
 f17QGxL8OgWFfhaCDHgnnsBgb4Q6bWrLyUPa0Q4Mw8oI54jV4ernw/DL7ASk6NuGUVf7WGOiWhl
 nrmBO7zcZzj98tNlpXyD354nBDxy1fiam01xomVGziwSaSc9+1A/4Aywk51mAm/QNe6UDI8/YlM
 xLgsop2i063ZTA4SUVdxKxjYx5LBTtbv91M1I4VlgAG0TWuGWEgHsFbvBhR9Xjcd4Q6UlPI7h82
 i5EZdL1cHi8qzrKNxaY02jS/POYoJz9BxjX4/W0ekSVl2HbVquAsCyZkC76MVVpNPyrM2TabiDO
 Gh96R1QFlAwmzbUJfxcSolFxr/eKjdK0CGUhlE9+xG8CoL3tqIJn/ptmpSdec0TofQcdfxNNxB5
 cpb4fBzv1oHoyCIMIj3PNRgZ0xIvCUA9l/jqLP1wvxasSC4qp1ZCyCrhk2rP+8CJ0Z13cqVFztI
 cYytOOQI/n8X6c4M7uOHzUIrHa8+rvyhQ1fW+1jcvAVgjEJcU694SJV6rffemEAfG0R26qHBWWj
 Z/6bNkL8F9/RQ1oCDFwyZZMDGcP6qgwJ/zU+gzCaZJ2q6XGHkRinwvwI2ts/88qwlaoWxLYrEL3
 PH39E/EACZPXiMA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct amba_id' table is not modified so can be changed to const for
more safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mailbox/arm_mhu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
index 537f7bfb7b0645538363d0b0a1ec0ec59fa10eb4..0950b7bce1846663ad09276ab9f53eda69ff02b2 100644
--- a/drivers/mailbox/arm_mhu.c
+++ b/drivers/mailbox/arm_mhu.c
@@ -153,7 +153,7 @@ static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 }
 
-static struct amba_id mhu_ids[] = {
+static const struct amba_id mhu_ids[] = {
 	{
 		.id	= 0x1bb098,
 		.mask	= 0xffffff,

-- 
2.43.0


