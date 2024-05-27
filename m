Return-Path: <linux-kernel+bounces-191428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828938D0F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F6F1C20A16
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7E3169363;
	Mon, 27 May 2024 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UCcT4bbe"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DD4167260
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716844141; cv=none; b=Hlo/Eiy8nBs/Z1lZ3FP7piQNCEC2Ao29TJzjkObst7junSevP3jMsujgeJNdsnAr1QjZWxgRup10cdfg1cusZ5neP6/6Dt0tz75lpThm1OXDBKXomof5VgTIpznEIf5tJPKAT4HnRw3ts55VsSedEYc4AOAiR8H4R6oRNHz72KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716844141; c=relaxed/simple;
	bh=VzyZzQu2iLKQpCL82ezkV3DfXk0qxb8vZ6CNoQ/jYj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPxVmHuRPn3WrLEDdkJjRixeG6zV2yGjG1zZQcSj5wc8MCfr5fVRPc2juYM/BnSXf7KIMCBUlq8xRsh7X+U3+G7cNTpOXEfIsNfJ9Qt8z50a5us0RzfRUudts6FE15hjyv6yxA3kMQxGnuDNmbEQbuH9Wibbldl6i1JPbkV6J5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UCcT4bbe; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-794ab1bafedso10013485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716844139; x=1717448939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFWoExP/wH3m7hjvZ2JqRkdunbepixaqBCDXaOKvVh4=;
        b=UCcT4bbebR9QE9ZfiHPdbXCh5Y764jzR2T4NqxWFZ9ntEP6XGOfu2n/thpmx6tM+cB
         gt42wxjh3Jg030R6fLmEi6Jq67kWH8KrnohzmJsT1L2xEjl4iY9kztrLx7Q/AylYmOXN
         R8qqh09RYKZle+cZNuM0KslAjKQUK478agkX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716844139; x=1717448939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFWoExP/wH3m7hjvZ2JqRkdunbepixaqBCDXaOKvVh4=;
        b=hJDPRweaRsVeipyMUSv3FBm5MhPt+F09lC+2Ol5JwiOUPYG3f0BdfbC1ivXJKo13fb
         FMIrWQlBumabBphFzVNSRRfgGJByrHxs1BseNnir2dBr90keEW0U/T3wnMyz7meet061
         n7FlaHiWKF4l5JlSCKrUWvPpkGyoxGa9dHnKiWJKE6dwdHxFtw1WAf7h9sMwOPkAi5VQ
         4nvYy84pSiM7dZR/3S7vtvPqEkdgIvWoqFyYzcEoZZGSh19nstZAVtVQYekojM1kGfXf
         nkk65YRnDWm4nRsPoPXK1SFDhOExjQGmAfdUqbtLlUjB1/f68iqqSayaUX9tUYTdJVd9
         oZtg==
X-Forwarded-Encrypted: i=1; AJvYcCWW+r1A8lw3IbXZhLFb44mZnXxXUp3XNUh/z8KS82OpjTg8S+hKGXC55RGPh4RzFHCXag0s6roGezNZwcy82CIXqPONnAD2ieMOxsW7
X-Gm-Message-State: AOJu0Yzt9aPzs3anel7sd9LO87SC9eTITeDH4AHba5R5ZCNwGHV/oq2/
	2Ur4c11cWmT5qCsi2ZyJfygNnBELEtXGObT5s52lebHKn1sbOH/9ur/sHXrzYA==
X-Google-Smtp-Source: AGHT+IFivOXXvR8CUjqaAYwugV85CB4ajDPAOeknJmut8X/c8q8/lFGzrGSFxvIJPA/iWbuRhKRNlg==
X-Received: by 2002:a05:6214:3d87:b0:6ab:898b:42e7 with SMTP id 6a1803df08f44-6abcda62be8mr118486476d6.65.1716844138851;
        Mon, 27 May 2024 14:08:58 -0700 (PDT)
Received: from denia.c.googlers.com (125.135.86.34.bc.googleusercontent.com. [34.86.135.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad850a6dc7sm9511866d6.93.2024.05.27.14.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 14:08:58 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 27 May 2024 21:08:54 +0000
Subject: [PATCH v3 04/18] media: dvb-frontend/mxl5xx: Use flex array for
 MBIN_SEGMENT_T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-cocci-flexarray-v3-4-cda09c535816@chromium.org>
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

Replace the older style one-element array with a flexible array member.
There does not seem to be any allocation for this struct in the code, so
no more code changes are required.

The following cocci warning is fixed:
drivers/media/dvb-frontends/mxl5xx_defs.h:182:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/dvb-frontends/mxl5xx_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/mxl5xx_defs.h b/drivers/media/dvb-frontends/mxl5xx_defs.h
index 3c5d75ed8fea..512ec979f96f 100644
--- a/drivers/media/dvb-frontends/mxl5xx_defs.h
+++ b/drivers/media/dvb-frontends/mxl5xx_defs.h
@@ -179,7 +179,7 @@ struct MBIN_SEGMENT_HEADER_T {
 
 struct MBIN_SEGMENT_T {
 	struct MBIN_SEGMENT_HEADER_T header;
-	u8 data[1];
+	u8 data[];
 };
 
 enum MXL_CMD_TYPE_E { MXL_CMD_WRITE = 0, MXL_CMD_READ };

-- 
2.45.1.288.g0e0cd299f1-goog


