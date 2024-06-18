Return-Path: <linux-kernel+bounces-219483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388A190D3AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7E7B2DE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64816B3B1;
	Tue, 18 Jun 2024 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aEnGINkc"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A76168491
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717876; cv=none; b=ZZ8ZUiAtm/1zQOaXqkheg6e/s0/26dBact1gZZv2FHXXSpLB9VV1yvxQaQbFA0xjmuW+Q6ihMuswDB/b7EpD24ux81EhjBteDwAMPECf4ihDuKrFZw0jLdIt/Rpzxazh5WSxpXWr8cOi5ccH4lVDrOTcg9jSB3tWA+FYmPT8TPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717876; c=relaxed/simple;
	bh=JCwRzQfJUN4DIo72lM4nWjkcyF1hZtywYkiYbZ3Wb1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJWxTX5ffaS/30IaUnjceNiWRLFavAtEa2Ap4uhfFPZQN5fHNcse6duCnm3oDh6B3U4b2/nc30wpEkwH5CdNV0SY648VrXcXajJIN4ET+MUPY6sH+sz/0+EjgvLoPgg1hKisIY4hw5mZmILVXze/Uh/ionNZxqIpy+1IJgkCwNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aEnGINkc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-797dcb558ebso353021785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718717874; x=1719322674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfmzknDlhP7JVdeMuBVj3S4t4ocBYNX2DjumHrcLghk=;
        b=aEnGINkci36kajF9DwTSi7/Gsy0zU3fBpt589MxJAI34CBMzb7rxpXvXc0/Hqgh3JN
         NFtFBDVI90y7ssk9J6m/pO8+qJqL4UR4OdUKoyo3XynsewHPml48Hi+Lvdws2QSqO7A2
         RIMxG5c1Q3XTqtEGDsad/TUa7LXMQB4jeb6w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718717874; x=1719322674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfmzknDlhP7JVdeMuBVj3S4t4ocBYNX2DjumHrcLghk=;
        b=gn0ItA9/HBC58S9AbFTRXUdwI7LTWAGODkLbhm2i2J1BefxtGbEbLmci0m2Aduik4x
         IhDd0sWdE9zhYYlEk6qMmzlJP05C1rFC2PilGf5U2wkAbuEvcbQ1utid/FghY9qR53iU
         SoO8OvoY1z3O5pzLt3B0Io1KZD5q+LNHwnlN6d3+h4IbACrfb9obYJpuw4CvgXc3xyYJ
         vOZxD1IhIxWplBQRVm5k0hqVX3kR/tzRkM1EDbvBziR/QNePbtVAiowc1okAw3vt/8CX
         uUBSTTiXj/A1idsV3LfFGDsq+CW98dvRURmIFBMmmJ7ceT8Dgu+LXo4AygkpuAvc32kf
         n3VA==
X-Forwarded-Encrypted: i=1; AJvYcCUUUhP4oEGMVY71F7MhHQ3zfZqO+f3eGOlvnXHJy67TXa7Oez9yjD25TGA39K4AvBJPas5LEUPM/XdmUTVXPPEp2IDi07rZykxy/jIx
X-Gm-Message-State: AOJu0Yz2RVwwwcCcGoyy/YDaIDcYRsZvjodbMSwEcB6bJcyLyJX7cnst
	6gue1EskefQuXu+OKIiMT4frboNfUQXpwktWLmidkp0lc0x7PUVBDUTTWDL1HA==
X-Google-Smtp-Source: AGHT+IGEfL8XeSfOM4jwm81aDULa50VWwdKgHpsA+y9HEy95/tn/hw5XDbDctHO+xTMeAiPX0ksKzA==
X-Received: by 2002:a05:620a:28d3:b0:795:5ad3:87ce with SMTP id af79cd13be357-798d2438227mr1412816285a.34.1718717873897;
        Tue, 18 Jun 2024 06:37:53 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc06e93sm521666385a.82.2024.06.18.06.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:37:53 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 18 Jun 2024 13:37:46 +0000
Subject: [PATCH v5 03/10] media: venus: Refactor struct
 hfi_uncompressed_plane_info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-cocci-flexarray-v5-3-6a8294942f48@chromium.org>
References: <20240618-cocci-flexarray-v5-0-6a8294942f48@chromium.org>
In-Reply-To: <20240618-cocci-flexarray-v5-0-6a8294942f48@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

This field is never used, but if we remove it we would change the size
of the struct and can lead to behavior change. Stay on the safe side by
replacing the single element array with a single element field.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_helper.h:1003:43-60: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index f61295819cc1..c53e2fb2d42c 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -1000,7 +1000,7 @@ struct hfi_uncompressed_plane_constraints {
 struct hfi_uncompressed_plane_info {
 	u32 format;
 	u32 num_planes;
-	struct hfi_uncompressed_plane_constraints plane_constraints[1];
+	struct hfi_uncompressed_plane_constraints plane_constraints;
 };
 
 struct hfi_uncompressed_format_supported {

-- 
2.45.2.627.g7a2c4fd464-goog


