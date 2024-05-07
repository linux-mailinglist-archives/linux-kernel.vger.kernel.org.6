Return-Path: <linux-kernel+bounces-171803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B088BE8E6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9401F21F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D771416D9DD;
	Tue,  7 May 2024 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QW9gJ5yp"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972E116D303
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099237; cv=none; b=FfYes+qMifTnBDkt9FtUPDJ+5jVpBSINluNgMVASNH2uTFQJWUzi12kGSQYEXrK1lQgp8tg4dimYm6bYZHQFQ88Os35ZeXxfmbzV/ceJ8LeEeT77/K/B4SUjNqK6/asRtfcP+pNSScGWdCG+ejTasN8fPllHpE5ztaon1u2pz+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099237; c=relaxed/simple;
	bh=Ybzvge6Uw1Eh9FNqgRzW6qmy53LUrGIUlQOKIfHH8ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dSxiXvB2+s19IVkoYwM5auJ62SFKTQU1v8HI6k/onEvWvUugk6vfM3zJlZOM2UdRk+7m95K7J7G9OCbCUyRkJ8wAcl+TQijrPFug/dbNKowJa84OVBnvpiyM+zG2sWeeJpVmK2z4CoeZNtR8r+7U1cMruxjpiBP/3W4nOIE2Brg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QW9gJ5yp; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43ab76cac73so31118071cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715099233; x=1715704033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEp5ZozBkj0x9D1ws5SUxXE7DcMsbsSxhL1FOw8KqVY=;
        b=QW9gJ5ypl03UwodfkeFY8pxPS83KW6HL+RNZ95hB3frMgnXPejntZrrwmLsoZ6Irg3
         M+IJCLVXluMO9DWeHleoeguQlKPdg6CVYTYAb6OVQq+IkHkUH5R4c1bQYWj+UVegOOKy
         fzfiSQ6a58hSgddB5ZYYMrg4sKZYRfH+usGmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099233; x=1715704033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEp5ZozBkj0x9D1ws5SUxXE7DcMsbsSxhL1FOw8KqVY=;
        b=C4f57MtU5ZaVhHmxsctcdFi+EGMkCBDL8C0CukiA+vDx/SgmnFtpDwoaWsX5BAfIVY
         Q7OsaLUX/iDlk9CXGD2wnuo4GhkahouzeID2lat5vO1pc+QxljFjvAAIgqOPDtBAi2GG
         +wH8/iWul3b+ZE5Y7spxIA2W162wbES34NAQO1x8x3QIvTefyqajhfZ99Yyvk7JWEbz/
         z4OZT6EW91PhDOQOPEjbHCnPTFa+nxfjAGTuFngy/RGZFPBf4nhmFMZFLdS1nx3JMuB7
         zR6GCzSuMMxorO4UhbZfw+jN1pedRcaka0iGHZB+Q0CQznwVeVHncVC5puJVmJik27H9
         r0yA==
X-Forwarded-Encrypted: i=1; AJvYcCVQmnMDZHKlfUYJV1H0nPFZtW1V/mtrg48H6HogB5tHGmItJn2B8tfX9J6X54gWmrqNqp7pyrkqvnVBEquYLxpKwYwXo+KSPdEgj7Ua
X-Gm-Message-State: AOJu0Yx4ONUE3fRdv548gMsnF50/yBBAHRYOMtKZjwqB7pi1oOQPFr1B
	nVVpmqsLCsp7TtM9pMQe7voqkNm94C/en+6X1WWIgEpLdwMuxsPta2KECZkayjoxiWUsEVJ2JUM
	TNA==
X-Google-Smtp-Source: AGHT+IFG5P8cF3bvogi35ZVCCh3mpoFd/JBPtTJGyHj5A6ptYc39Pcqw/IlsAeEpo3GtlKvW+qflBQ==
X-Received: by 2002:ac8:5a15:0:b0:43b:16d1:a6ee with SMTP id d75a77b69052e-43d8f44bd11mr53130171cf.17.1715099233681;
        Tue, 07 May 2024 09:27:13 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id hf23-20020a05622a609700b0043d1fc9b7d9sm4160597qtb.48.2024.05.07.09.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:27:13 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 07 May 2024 16:27:10 +0000
Subject: [PATCH v2 05/18] media: pci: cx18: Use flex arrays for struct
 cx18_scb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-cocci-flexarray-v2-5-7aea262cf065@chromium.org>
References: <20240507-cocci-flexarray-v2-0-7aea262cf065@chromium.org>
In-Reply-To: <20240507-cocci-flexarray-v2-0-7aea262cf065@chromium.org>
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

Replace the old-style single element array with a flexible array.
This structure does not seem to be allocated in the code, so there is no
need to change anything else.

The following cocci warning is fixed:
drivers/media/pci/cx18/cx18-scb.h:261:22-29: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/cx18/cx18-scb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-scb.h b/drivers/media/pci/cx18/cx18-scb.h
index f7105421dd25..841edc0712ab 100644
--- a/drivers/media/pci/cx18/cx18-scb.h
+++ b/drivers/media/pci/cx18/cx18-scb.h
@@ -258,7 +258,7 @@ struct cx18_scb {
 	struct cx18_mailbox  ppu2epu_mb;
 
 	struct cx18_mdl_ack  cpu_mdl_ack[CX18_MAX_STREAMS][CX18_MAX_MDL_ACKS];
-	struct cx18_mdl_ent  cpu_mdl[1];
+	struct cx18_mdl_ent  cpu_mdl[];
 };
 
 void cx18_init_scb(struct cx18 *cx);

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


