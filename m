Return-Path: <linux-kernel+bounces-204351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBFE8FE793
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9554B25505
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB09198E76;
	Thu,  6 Jun 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dr0D+icq"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA1198A02
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679866; cv=none; b=gcaNfhDNrMbQ7qOAkVsVqfQmoe2qkrX9kARmneYW16hcA1Azj4Kf39p/HhWNN28ftORFzcStVCBnVAH6T6lgxpf9+1YJs/PV51YwKy+Z9e0qxAazhmekuVz7XHLkVSSVuzV1dVEQjyH1YWyUpoI3anoUPEhfW1BLMNX0unmaM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679866; c=relaxed/simple;
	bh=Avo2Fleh4ujjt70o15EeficxKnpelBo2TOFCLUdZKFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=teSNtIYDdgTz1K8dGWOFKTRsTwdFdgYg9MNP3nKRV1Uy2vHX1fMImbsOhzD8GZqbSaZF+w+VPStXER8Ay8oZXRjAcGlYfGDneRMEqTz4agDWQx1bgFquhN2+TLz0PIMOa031OG/or5bKs1a0SpXQxINjSfhg+ctAiaAabEVjhc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dr0D+icq; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ae60725ea1so5388936d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717679863; x=1718284663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2o9uFpZwETiKeZWYLVPp/h/C01HBTzSktsioUGg06Ew=;
        b=dr0D+icqsuyL2nuQ7p7S3Vud/E3YjHXXW6VdaFnIvukhdpS6XoVSxygvcFuE3lurd4
         ElRlCgM7ovhhl4r98jnxmqNfFGAemoaFK95QcAr78CbdyY7YSZRiDvoAgDLT1m3Hjd6n
         yrt+P0n5v7LJW1e/NjwPDP670UOhdTjCZpvfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679863; x=1718284663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2o9uFpZwETiKeZWYLVPp/h/C01HBTzSktsioUGg06Ew=;
        b=Yk8Dag6ukm1yCvrzH7JGtiKpztKH8ZWT8ukQe3AmghbBa0C3y/A4SCFKVHbE87RhyC
         u6oCSudrMBfjBeUek4eJ4or5SvS7dMC+rDX/Qb8lIYOqCSw28ps5lXoeXwWFrklQtDsN
         A8ERNZALPQGWALQP2Or69TrIHjhufZJwHplAcfPaW05aU/KXVGhg4MbJwKwddE8QaxT3
         Dc8UffR6bzX+km1srDcZZfIrO/9GF1J3jdSjjxoGjrCr2Z7eZFpym9EVfA+LSSdVeerC
         el5rz0OE2K0ncxTtInREaOYdE5WilxsVqMyIxWR7T9ZzKAZwjfFD7tLNr/+kWbAbo4FO
         1wtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmiAGI5aRoZJTVtTc2fIHj8nQqCwGQja3BsxweBpJPbNl2JfAR7zUz04f7GWEv5qEBxCPe5RbUwIVihS9JnFDXclylBpepBFP5k8mP
X-Gm-Message-State: AOJu0YyJF5CvkyzklUmDJfztDxkLsdHeFlQQVD3buiSRaAqTS5Q3Wk6t
	rce1BveykZbQp3GmQZ58YybJBhZg0Avb5Sbt5JKzLbCiVN0ezB/IAYtDAJbOrg==
X-Google-Smtp-Source: AGHT+IE8jXrmgfRC91PfzOqBRQfeMgy1DzBFB7+DOjFIBnca6lzwJN2RUcERx9LU43E0vr3vRV6ErQ==
X-Received: by 2002:a05:6214:3f91:b0:6af:cdb3:5db with SMTP id 6a1803df08f44-6b031cecca9mr63488376d6.63.1717679863024;
        Thu, 06 Jun 2024 06:17:43 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6607f5sm6118036d6.31.2024.06.06.06.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:17:42 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 06 Jun 2024 13:16:45 +0000
Subject: [PATCH v4 11/11] media: venus: Refactor
 hfi_buffer_alloc_mode_supported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-cocci-flexarray-v4-11-3379ee5eed28@chromium.org>
References: <20240606-cocci-flexarray-v4-0-3379ee5eed28@chromium.org>
In-Reply-To: <20240606-cocci-flexarray-v4-0-3379ee5eed28@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Replace the old style single element array at the end of the struct with
a flex array.

The code does not allocate this structure, so the size change should not
be a problem.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_helper.h:1233:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index dee439ea4d2e..9545c964a428 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -1230,7 +1230,7 @@ struct hfi_interlace_format_supported {
 struct hfi_buffer_alloc_mode_supported {
 	u32 buffer_type;
 	u32 num_entries;
-	u32 data[1];
+	u32 data[];
 };
 
 struct hfi_metadata_pass_through {

-- 
2.45.2.505.gda0bf45e8d-goog


