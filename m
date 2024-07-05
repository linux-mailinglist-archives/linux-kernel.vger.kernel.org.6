Return-Path: <linux-kernel+bounces-242089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D6292835F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D4D1C24106
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABA413C9C8;
	Fri,  5 Jul 2024 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cWy83NW/"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0427013B5B9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166564; cv=none; b=r3lU5Rde8iuP0nICIBcmIGu5NqJktVDXe5UduP3clanqgLTRFuOWDCXTuYyWgUHPE3bz/0NLce6Pna7fs2g8q/ZYu38f0R91b3gNCmRlWh/h8WWufSLla5PhgCQI+KUrRjwoSlnOwvb6pt8prq44DsGj/XdBiVSUJxxA8kHvAd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166564; c=relaxed/simple;
	bh=bXpHTK+EyIsqSD7SgLtjIw2t3RaxB8rU2+ilna057xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bAhr0ZXDVqkjDMV6EKi+HK7wg3wIq8+8wx40X5EjYy/xIOabvpRzR1Dc9SNLB0rMVZ5oQAVS1faZOAFtKw9wsycH8lcj10QHhxDYxPMWcYU0cOR6/CdO+mMFtt/gYSY+huL6XVEY59M1P78KBKEds7g1tIeR0ezOcChyUxw3HR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cWy83NW/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35f06861ae6so811517f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 01:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720166561; x=1720771361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsWVg2gQk7KmhjHH+trDWs7bq+X2IqikQ1jZ7TWj51s=;
        b=cWy83NW/3XVb9Z/xXn4mklSQWPddEPBr+BkC/AOiCTudi143aWKw19gnfHVJ1LPHGh
         R6OlFNpj6QNFpXwuHCLX2sos5F7uFanps+J6w1rmGgBd5h1/HdpwuuBqm654GFIMXeBE
         L7Bujr3LI9v6UjizKCeWidgUB/ewvxNZoECyWR48uetjQ/P8DsshBdgdVPofrP3Z1UkO
         xD9hIwz4BfYHYvg72H75og6CK1+o+K4HtF47/X6eJbZ7wJ3yuSxhH5VowuZ5qLAWmZYn
         mCtoguhJNxl9z8ei/9uUdmPAVeUV7fLcvh/HLfQTCkT6MRdYc3u7bvVV/+i/HmewSOcI
         VqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720166561; x=1720771361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsWVg2gQk7KmhjHH+trDWs7bq+X2IqikQ1jZ7TWj51s=;
        b=P9eA/sqp00NY0csZYj4S2UpSlsAQx/bLotIKUmxgjZAi5vDaZ7S0pVl8E/HN6BSxX5
         bqoVRZfafkAC/y8Q9QFtwSDhxxyktwfqQrCIQTPY4D7UdhwiqdYZceEPMfJN6Mzd/n66
         OgmTQ6V+BjvyOlpEOwAuUFqpYZSNDElO1hDQKQe8X5TdxdinR6w+GmbUlj5XO4joIGwq
         PRA5JF5po0HxRdQsA4jcZvKy1lzstJACHhKtTipfLP22xfjYWlrNUksM+wy1m32o18LQ
         Aq3J6Kl7X4f80FkNL4ZclfGZHcshFmqL+ydfdJvHDl2FAzqGh+DevdVPpTDLGEeuQC+r
         siVQ==
X-Gm-Message-State: AOJu0Yyf+1kB0mT5eU7evW4ALjB/1sX9IQbcVzG1H/xtKsSWthMCeRrp
	3BgWPaC5BlA8/yKZrrEdBNc91TOtTtAOMzW4PbVLD2dlP7ZrnIn2K18udbe6Qnk=
X-Google-Smtp-Source: AGHT+IGmKJYy55PSIaJjEW7HBnPMhYROa8AQUDbLx0YR3SeIyFrrSqsQ9kDUR9qIvDuJoCSbm/e04A==
X-Received: by 2002:a5d:6149:0:b0:367:9bc3:cded with SMTP id ffacd0b85a97d-3679dd72b21mr2354768f8f.60.1720166561434;
        Fri, 05 Jul 2024 01:02:41 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a103d00sm20263703f8f.99.2024.07.05.01.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 01:02:40 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Amit Vadhavana <av2082000@gmail.com>,
	"Ricardo B . Marliere" <ricardo@marliere.net>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/1] slimbus: Fix struct and documentation alignment in stream.c
Date: Fri,  5 Jul 2024 09:02:34 +0100
Message-Id: <20240705080234.424587-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705080234.424587-1-srinivas.kandagatla@linaro.org>
References: <20240705080234.424587-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=ObzdssiadOLjjFbY8y71dd7CaLTdaITN7HGkzCnITOM=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6ialOpjk2Ns3qynGkp6TcjfxSsMItanuZZh1 Fa796Pxkr2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoeomgAKCRB6of1ZxzRV NxIcCACQhmv9/MLHnz3cZ24iqMawgn2IlaVK2QLEeEzh/pB3C8DXCW5voP0dCZiQJXc2GqCZTQg ncHVI2Y2maiYbrZXx0mku4LepzhccV952c3jmGHvUKaGR/XL3SKrmzXM3iOWm1bQFgGPO67HB+S JIM2iN1CepaK9XErCcXWwSkvdgORgyOHmzVwcWivesO8sytgy+mv+M+gA9uu7ZopG+Y7S2l71VQ /eh9NuW44J4T7CB47M9ViOkbB1hWAfsZZHvuTDQ9zcWOrncqwevxM0X12f6wtozGP0PAgY1rKcf 250rS78dBDMmDwGKs4Xo1xBJttcx65eDzvZe7GfMYTh7T4dq
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Amit Vadhavana <av2082000@gmail.com>

The placement of the `segdist_codes` array documentation was corrected
to conform with kernel documentation guidelines. The `@segdist_codes`
was placed incorrectly within the struct `segdist_code` documentation
block, which led to a potential misinterpretation of the code structure.

The `segdist_codes` array documentation was moved outside the struct
block, and a separate comment block was provided for it. This change
ensures that clarity and proper alignment with kernel documentation
standards are maintained.

A kernel-doc warning was addressed:
    ./drivers/slimbus/stream.c:49: warning: Excess struct member 'segdist_codes' description in 'segdist_code'

Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
Reviewed-by: Ricardo B. Marliere <ricardo@marliere.net>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/stream.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
index 1d6b38657917..863ab3075d7e 100644
--- a/drivers/slimbus/stream.c
+++ b/drivers/slimbus/stream.c
@@ -18,15 +18,17 @@
  *		and the first slot of the next  consecutive Segment.
  * @segdist_code: Segment Distribution Code SD[11:0]
  * @seg_offset_mask: Segment offset mask in SD[11:0]
- * @segdist_codes: List of all possible Segmet Distribution codes.
  */
-static const struct segdist_code {
+struct segdist_code {
 	int ratem;
 	int seg_interval;
 	int segdist_code;
 	u32 seg_offset_mask;
 
-} segdist_codes[] = {
+};
+
+/* segdist_codes - List of all possible Segment Distribution codes. */
+static const struct segdist_code segdist_codes[] = {
 	{1,	1536,	0x200,	 0xdff},
 	{2,	768,	0x100,	 0xcff},
 	{4,	384,	0x080,	 0xc7f},
-- 
2.25.1


