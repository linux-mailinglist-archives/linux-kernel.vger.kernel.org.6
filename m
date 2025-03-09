Return-Path: <linux-kernel+bounces-553171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7E9A58523
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1F5160F70
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEAA1DE3DC;
	Sun,  9 Mar 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IfSBg2tE"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F31DEFF4
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532258; cv=none; b=IQ34CR3Ej16ZspzP9JeED6GE9IiAjef9dY0IHOZ9/0ozOPkbxYoKy/7/GeAYRb6nvKLnS1N5lDH9KQHQm4FJCd10DC2UKPH6zn0lOKT/PErWe66tATcNkgt29jZpNvLcr1bKkml38WdINcOSDPSgkRNwAxXjkM322EJIah7LoXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532258; c=relaxed/simple;
	bh=pN/3K0c07mgtPTRPXPCJpX/AGnbpoFURyIzTH/nlVaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IJHk8vMPLZbjvtHzr5v/yc7Ey+e0fUbv4FicpwqZ7lUZQMXny+8lh7ri6MDq/13Q/EYUGznnsB6VMGLDlsLWnRICcuAAMpH08Vh7iJ2n10gqyzi5s4jP+DmB6b6JCuB0hJLgHEOks2i0U0Mw+HRt7qJ/n380tCM0egz00db9MdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IfSBg2tE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3913d45a148so802219f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741532255; x=1742137055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r0/g7jMkIS31rWPP+0eYALjsbxAMAbdDJjBS2LpzoY=;
        b=IfSBg2tEwCxUlHUtzq6Sd9gbDu/cWIfuW2FWaNvmG5+RBSuaHJ9kNkNdBBP2Y48GEH
         wxTf2sINOPs71hJYHI23/m59VAOqU2DSSisDftARnm+KiqTO+V+BkrWTvKzsqSPXE7f9
         iJJEWNyC5Ab21QxdqmpsZbMgyTaIxrjZ330pgaal5g8SjjtPsNY69KBs64Q3u9nG1BPe
         QZt8uAkme2M2Bhxw32HD3wEAtlyAjGaHtl3wLgzuFA96FTa/d3OcxoXG1IrpV/l12NLc
         rF5tW0K0GWMydaRpdmfKjQ/p5Zheg5/NmPk08SG5ZRxLG78ezz6KdptzboAfLVVjSEdO
         WTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532255; x=1742137055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r0/g7jMkIS31rWPP+0eYALjsbxAMAbdDJjBS2LpzoY=;
        b=QGPZuB47Oi7G26MwSdWdQADfZGZeA+4IH0kPKm1Zop+25dQq6fPfNbxI7LFyFGIhSL
         C2znZn3IeI1qZ4GbuG9fYgPvSTyiqrJl6AjNo10mTMa5aLTWEXzMtmUNZC4fgPHnFnDZ
         mtw/i6Iu8kDih/8H38mR11JCEWyHANQk8If2G9Y02TY5WsHkVdO2GOyMpludQyoIMpxN
         8dfEN2vR14tMVKaxSDraFDO75wwYbcUlNnew7qgyba1chkwUWOcaWYASoKG2U7TuuW4n
         T4Kx/W+QOHtirU2CLNZOnwIyJ2VI6x49XYA3t6213vc/ve3L0X7QnBTPWhT54r3le9Wf
         g0/g==
X-Gm-Message-State: AOJu0Yw0mud8KiaXm5xUplKf2DqfTc5aQ2rgVG5G686M0X4KAlqL7VXr
	A87Q+rWqDbqPJDhkr88/JzioKuC/UiEJzbkDZkybht8Z3knxyVqtoZXtm4eViuw=
X-Gm-Gg: ASbGnct+She35jLFN1SmtRlFjtZ86Dqw6ebRmUrvm3UuAhzLlJzkElS6VXC+NWiUxXn
	ciOGUoWrH4m/dWWxekGG0eF1TdaO2TmsM0na6FHOqI/iMUZQ4PWqGfKkicWqy2T7hQGKCtwW+Hb
	fZXWBgHwBUZ0QRXtqTRQnBq8ZNunNZevwAm1wmK4sKRUFACtdEZPLMr8w55ucJjZIbxtqEZAGI2
	evfjXIAnb+iMSSv7mric8e6uye336QqJkdxY7F+2TekPmeYwUGeMuE5nNr9+WW51Ankm5exoRpl
	+KdP30yXooXZWHriZC08geUB6cfk+//21oBwj3zzm9SCcGAvou31bLLHnnpusm1I5+frB0kTfNg
	XOz1m
X-Google-Smtp-Source: AGHT+IFc6TseDpHfLdz/7p5kDlMaSOndsEKWUw95bi6AwAuygsgDOCdntYQD7jLj3rNYJMBEZKCwFQ==
X-Received: by 2002:adf:cb01:0:b0:390:f6aa:4e7c with SMTP id ffacd0b85a97d-39132d7b7f5mr4878970f8f.28.1741532254768;
        Sun, 09 Mar 2025 07:57:34 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm11744899f8f.89.2025.03.09.07.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:57:33 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 04/13] nvmem: rockchip-otp: add rk3576 variant data
Date: Sun,  9 Mar 2025 14:56:54 +0000
Message-Id: <20250309145703.12974-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
References: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=3Ys4IkX8eCFRNDyZ5cOnVGSBTrGSodl3ymtNu0NI9Wg=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnzaw5zrcabPVsgwcqQzznbddwl7Md0kDIrrWvM 52dXNcO/WyJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ82sOQAKCRB6of1ZxzRV N0jDB/9WwG+CkweFPv2/bZixcM8RV4VCTwisdA0KTd/Nzn51fg5SqfOz58B43vAL+gufCQv8BCB ldeSqAVEVBNH6p8Oqalew5DC4h9H+NDmGYB4eG194GB6n8Go1lDOgDr0ydH+abmMwZeFgRkcynA NwH5i0VeV/3aHkpSVOoyANsQzrVIo4vIjHvVniN4eMbmLXoOFpcrp0JxKj6PInGwUnxMcz9cUx9 Sbii0y3kIwkTOnXnDJ9FPjAWwxA/VHs/zTKqiOAnLx7kK2iDRQlCzmWnLvVOOTGLBQicRtFzaEL Y0AA64qDf9u6pRs4rs9GmLP9xmRVW94F5/IGQUx+NIJik9O+
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko@sntech.de>

The variant works very similar to the rk3588, just with a different
read-offset and size.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rockchip-otp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 3edfbfc2d722..d88f12c53242 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -274,6 +274,14 @@ static const struct rockchip_data px30_data = {
 	.reg_read = px30_otp_read,
 };
 
+static const struct rockchip_data rk3576_data = {
+	.size = 0x100,
+	.read_offset = 0x700,
+	.clks = px30_otp_clocks,
+	.num_clks = ARRAY_SIZE(px30_otp_clocks),
+	.reg_read = rk3588_otp_read,
+};
+
 static const char * const rk3588_otp_clocks[] = {
 	"otp", "apb_pclk", "phy", "arb",
 };
@@ -295,6 +303,10 @@ static const struct of_device_id rockchip_otp_match[] = {
 		.compatible = "rockchip,rk3308-otp",
 		.data = &px30_data,
 	},
+	{
+		.compatible = "rockchip,rk3576-otp",
+		.data = &rk3576_data,
+	},
 	{
 		.compatible = "rockchip,rk3588-otp",
 		.data = &rk3588_data,
-- 
2.25.1


