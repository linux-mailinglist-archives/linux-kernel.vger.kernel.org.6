Return-Path: <linux-kernel+bounces-242031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9797F9282EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EF81F242AF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537D4145A05;
	Fri,  5 Jul 2024 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fyd2/foJ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB036144D34
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165277; cv=none; b=o1Qk3DsXAe7J+kLRCkW5Rf4u8c2J3BpiDwfVIMPiWbydtblKRAknXGto9fWaW9oGSZqRsLId7wAYqto5Z+ILi0mmkn/EDx2scASDlviUHu6IftrHWajqApon4Poj1rT0KD6L1R1Cw32dirpiO7gNmDvGiuxDMGxrrxx1S/LAqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165277; c=relaxed/simple;
	bh=bXpHTK+EyIsqSD7SgLtjIw2t3RaxB8rU2+ilna057xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XKQyBSvD1jKcs6+MOnEWWzA7EmAkoGfaghAhmyCed9fZPe64nGDtGdWVtxQNQIoRwL781VjAEKAfpaX3gHQ6t+6EQ6UqtQBij65kCqfS5yX72foaiGVuroDPQq2div4eMRwWNPuMTEC6u/+GRfYRJNokWkaAM0lvDK4g8qwvr7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fyd2/foJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so11777455e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165274; x=1720770074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsWVg2gQk7KmhjHH+trDWs7bq+X2IqikQ1jZ7TWj51s=;
        b=Fyd2/foJ6nEGht+nFrsavQdZqxpZhwksKk2tUEEdQaFoLyXnWz7nvZrvBeWWjSzHQK
         eMkAlEytFZ2MAvamTRDuccPy15zbJJ4/j+nIocFoEm0RdqGGahRXH1vZdorhpq7kV84c
         xD/YKw20LiFLRQDaJMcoXzQQTXr1fg6NIIjctwLIBWf+DzBv7tNUAZ7NHe+ykZcgZgLv
         R0KggPuo0hDvme8kNBWp8zMzbOEYqVEfs6DXImjBCvVmsx2+wqQkDTcnvF0OFBw5hUsd
         mNaUZCL1y2ZqDPdCvVejwRjlM7vVv/hNrNLgDl5dHgdqQoEMwtEuZ+TUuSewltIcyv/l
         kALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165274; x=1720770074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsWVg2gQk7KmhjHH+trDWs7bq+X2IqikQ1jZ7TWj51s=;
        b=WmweuE+w0kpi9wD2WJnD5Ur91Q2izCcwTqyNiBhQvji4PXeQdFqOX5IquEg7T4IK3r
         HZ/muzMyETl53cMmwFSHDAeYVgoHNLtB2EtbP5JxDuRcFeHPuh+s+3PjgKNh7iQ6X9mt
         nSPXCTYwFgxxX7jclvtzbe+OIUxuNvEdW/FciCeE+Isj+V4I9cc2XBS3fxB6exfDkDJp
         aOYDbq/x4t48xEHio+Dnt2baxP8kFLYmUXAiiBWgnOAbDk9/IAddD8zVd2FWMZouAHa8
         zEhu1G/Q847EiLWzb4TGJ7WvwuDX6kQ5XNWMtAIJZMFCWZNA/irgIX90rXOoOaGP3DoP
         F99A==
X-Gm-Message-State: AOJu0YwnijC9am2eTVHsv9bxVxnqRMmhsV1fi4y6FbD1xg7PtMtMqBD1
	9xL01gDvNS3bzLhqtZhh5P+jo+d5TUoRFZ4JsUUThA6yK9ShCjFgCxkYGnYTsdo=
X-Google-Smtp-Source: AGHT+IFeJSge2FqOx6yjNLy6K+cgv8mkJvidh2I/xA1lZx939HqXTuptgnwUcsxv3yUSJOu6FHWN/A==
X-Received: by 2002:a05:600c:1790:b0:424:784c:b134 with SMTP id 5b1f17b1804b1-4264a3bc345mr33033105e9.6.1720165274160;
        Fri, 05 Jul 2024 00:41:14 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm50837455e9.10.2024.07.05.00.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:41:13 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Amit Vadhavana <av2082000@gmail.com>,
	"Ricardo B . Marliere" <ricardo@marliere.net>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/1] slimbus: Fix struct and documentation alignment in stream.c
Date: Fri,  5 Jul 2024 08:40:40 +0100
Message-Id: <20240705074045.418836-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
References: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=ObzdssiadOLjjFbY8y71dd7CaLTdaITN7HGkzCnITOM=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6N9lOpjk2Ns3qynGkp6TcjfxSsMItanuZZh1 Fa796Pxkr2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoejfQAKCRB6of1ZxzRV N2EZCAC8dn9HbK393oygTtOnsohmBFcXYQKd34zTbTF57k0N1Y1/KOFDRDYKt1Ljtkqcc6Du4qP jSB239TBzOsaPvSEHV2oEhiwOUTiva0BXB2sXTViPSrw6jtYvSc9Dpub64dBlaqBXgWqWlHDjKg 0PNOMOSk5ofIPaRYl+F3SgZfBii9cYeMg2b2Lnobozq+sDB7StT8TU1C6ICZa8nLHuwgCfgbrRC uqcuun5UY1z/rK9N73i9YSZKae6XMWo+3YbK7MxHf9lwfupWqnga2xVoI28E6dnzhzheTmQwsqw bGxNFiiw9YZmNJNr4+MRjM3Yp01KfN73yoo4QpfjG6pluqMk
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


