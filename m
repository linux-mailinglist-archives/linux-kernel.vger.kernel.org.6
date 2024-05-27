Return-Path: <linux-kernel+bounces-191439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4774F8D0F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041EB283596
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C376E16D31D;
	Mon, 27 May 2024 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Et8YXUpY"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BF916C841
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716844153; cv=none; b=iNEL8t9yIW1pmZnFSLSu3fQIXhvlYl+OQeBnqZXLpVP4dr95MUmp9mJAvIwO03KYmeu9RhKmg5U300P6pf+OgK92ibl2IUeBS9qKgOYBH8XF6EYPq7obAPz76crP6vatMUrUxRRR3HZ3xt8SLSP5uCtLVxpMv8zQGknQUbeCPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716844153; c=relaxed/simple;
	bh=hodq+gCLyqsJ1R1uHGMq0ldSTiTA2zY9HKvfL0U27m4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ksjs080eRWNLOvn42dwKymj62oVVYHj8DxhfyZqhDXOm63o8wUWqiE0/1WcoKQQovnGawc+/1C2hxM2rPOdJT0dtUWuapRRzSSqsXR5y7JPLb62wMObXkvneB8pcXcjCLD0q4+nj1ETUwwS19tOUDQZg4EMwGOnKAtaAmDt3ZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Et8YXUpY; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d1bc1e5d14so119964b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716844150; x=1717448950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BUOU53Y/Qs7SwrH1hNBNdnMNU1q19wfN3LEF6XYAR0=;
        b=Et8YXUpYRkC+fJnYcrzpCWm5+JBCN4thulctQtyzT1jOAQiiJdcYjjUVXeZ2pk/CUP
         5q8n04dbSTCtnp+9S8w7qq6SRUGak6xRJoX1DnhyQoPs0CNnC4qI7d0g0rJchXGditpE
         KztVGhqBvXNPOteEN3fYneOR7FrH4O5WcdVas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716844150; x=1717448950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BUOU53Y/Qs7SwrH1hNBNdnMNU1q19wfN3LEF6XYAR0=;
        b=MnTaeZHOvuQ23D4S2JgiTweoHZqpt01etq1SICzjm1tw4b6X5yDASwheU6DBSaUtko
         SRX5uwwuxg0nO3kwgeJ9x+jXvZ5oCjNGrLo0oQ6BOCMGlSVoiSMANtti9/PUrK+FSZuZ
         A00NpqIPyQcc7ewLIivyz1d7D/oOMae3ZELkE1SK9R/lFfR8l6J5mnLY9JZY8hrkP+y2
         iJAij47AvGbrAd5ECF7sC9kjISdP/Rq3B+p2ZFT6sPtnrfHgdhVzAueEmqJWUzXILxBd
         S+kaJV7OU+XRhcjXl0zVHfM54jSsHYGN9PQqRVmnlNGLHfJ9mXBxxXbzDffrC6/v3yvg
         Dmuw==
X-Forwarded-Encrypted: i=1; AJvYcCU7G7wPhNhsQj1rooI3d0Dzo6g0z5rKCUue1BkixqL7mdiKix1HhFW1lLhNp6zi6TTguXP1+oUWg2GYCtbjGiA14j5/wW1RmhihP2Hr
X-Gm-Message-State: AOJu0Yyd25407O5JdtD6uZQXaQefDmDVleT6o0J5A50C/EXHuXi9bxaT
	gqkn/6ifqYyv3nGFBEkL2gy19FYR6TtBheO1ETBBm8xLM/79OgxlLP8y7eVlNg==
X-Google-Smtp-Source: AGHT+IGpU7e2bDXtLKHzBuQGg8VU63q3btltKxhtl1G2R0LWEM8uDkQDnfIvjE/wdw2CIfox8IrWQw==
X-Received: by 2002:a05:6808:3d0:b0:3c9:639b:f821 with SMTP id 5614622812f47-3d1a7b30743mr10023918b6e.49.1716844150503;
        Mon, 27 May 2024 14:09:10 -0700 (PDT)
Received: from denia.c.googlers.com (125.135.86.34.bc.googleusercontent.com. [34.86.135.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad850a6dc7sm9511866d6.93.2024.05.27.14.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 14:09:09 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 27 May 2024 21:09:05 +0000
Subject: [PATCH v3 15/18] media: venus: Refactor
 hfi_session_empty_buffer_compressed_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-cocci-flexarray-v3-15-cda09c535816@chromium.org>
References: <20240527-cocci-flexarray-v3-0-cda09c535816@chromium.org>
In-Reply-To: <20240527-cocci-flexarray-v3-0-cda09c535816@chromium.org>
To: Michael Tretter <m.tretter@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, Andy Walls <awalls@md.metrocast.net>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

The single element array data[1] is never used. Replace it with a
padding field of the same size.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:146:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 8768ee052adc..2c56ae303989 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -143,7 +143,7 @@ struct hfi_session_empty_buffer_compressed_pkt {
 	u32 input_tag;
 	u32 packet_buffer;
 	u32 extradata_buffer;
-	u32 data[1];
+	u32 data;
 };
 
 struct hfi_session_empty_buffer_uncompressed_plane0_pkt {

-- 
2.45.1.288.g0e0cd299f1-goog


