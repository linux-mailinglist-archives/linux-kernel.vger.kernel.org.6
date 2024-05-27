Return-Path: <linux-kernel+bounces-191432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E1A8D0F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823FF1F21E90
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0BD16ABC5;
	Mon, 27 May 2024 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fBlJkwZh"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2235169AC0
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716844146; cv=none; b=Mtzfq9/drGC5ld4mLnUpbvz2cnD8nPOlSzeYeI3UGsXOMzuiplOvkdCLXQ/XuWgdHpE5wuBL+zTdPQHXyB9t8J4mpjXjUu4bM6MjCT2Y3Ecffl/x2xWy2QMmlPCA4UQLDh+YrdPjIawRjJTAFTXjPZAXEbKh/fSz2OPofv39y3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716844146; c=relaxed/simple;
	bh=AtfV+7qKa8OYd7+oqo1EiuFIlY8JnCQ5vfZJ2LNqz98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LzT+H9mDeTX97Vfu+KAlAAzYMyrFTzxLXixiSAkh8hDFUbZwxA9LhUsa6tW1EZR0K8cRBMV/8iMKe1wkLvpzEheNKm9uhIgVDK9xPBQ4T3msJ0lBnDoy5QGjVHABKtpQtxfeGQC4JFef9KkhJHevbpkoVrm2tOkplaVX5YBjx0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fBlJkwZh; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ab9e011f62so30881136d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716844143; x=1717448943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=entYDpzpynGnajXkQLwb6P9rzIVA7SLTRgQ0ZRMWf+M=;
        b=fBlJkwZh03cfC5EuqOptoCFI/qOBKHLf57iMcVRf5YIlgO9EpotNdgRxXXIafpjPT1
         Bz24nCxWikNlyaaih1ioFP4PakP1OSr6kJefHsV40QlrBhtjZAsqr2q1MJ45I2l6KP6t
         6TcwNi5vQdwm2kuOPT3Wkq31WLrahr0DrBVqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716844143; x=1717448943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=entYDpzpynGnajXkQLwb6P9rzIVA7SLTRgQ0ZRMWf+M=;
        b=WWfLX3mxEwkQpNWW8Ld64eB7TtYJfES6Y0i0BC2iYT8wBR1QvdVvNti3sIVsBUZauH
         I6JwNlfW5NX3+ekZmDyoc8V1J5MnsA3ZZ6Tory+hZjwNzyVU/3fj/Aptq/6isHp3v5EV
         3xxpUQwJoS9t6ygFa1FGm1XZczqvLeCny3y6IRoZ948rjNRMObXPW5+a5DhSUcygT1Ey
         AeZZGgz6WZCb2TIiWhSmfUx9A4U1OJEQ6PT2sgA8oD9ZPh77DAo8uSo6tXXN+NxXQwIb
         A2nmihfUYBMLACWdZY3Ylh3UVytb5j5DfmF912s6j8I8ObP7ZSqMqO9zqtbYMn9Su/ru
         7IaA==
X-Forwarded-Encrypted: i=1; AJvYcCWWO0yrT1rRqLouCib+y8+p3ktXpO+PMlafC0MMAnKuYnxH/fVF8y40X/JDsHHU1efh4jJnADrc9/8VUBbP4RBLWJ/UG3jWC0MVsEWs
X-Gm-Message-State: AOJu0YzTz4YBiAtePfYQy5plkPd+YjNCEKsXZvPXGQtE4dlektMigFX+
	cqZIen2+hEHRDxbK0XHs++BzSSHf7naAwpC8O6OJxUX6+dBwglo5c2ZlX+GZ5g==
X-Google-Smtp-Source: AGHT+IGRTkEFJzLLbC9/MtoTsg0EW+dVQWuLn/GRcDLGaCVnhgLZ5sKm7tGGTDdrZIg9lepBsZ8a+w==
X-Received: by 2002:a05:6214:2b0b:b0:6ad:7070:4e1c with SMTP id 6a1803df08f44-6ad707059e8mr106586636d6.19.1716844142698;
        Mon, 27 May 2024 14:09:02 -0700 (PDT)
Received: from denia.c.googlers.com (125.135.86.34.bc.googleusercontent.com. [34.86.135.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad850a6dc7sm9511866d6.93.2024.05.27.14.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 14:09:01 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 27 May 2024 21:08:58 +0000
Subject: [PATCH v3 08/18] media: siano: Use flex arrays for sms_firmware
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-cocci-flexarray-v3-8-cda09c535816@chromium.org>
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

Replace old style single array member, with flex array.

The struct is allocated, but it seems like there was an over allocation
error:

fw_buf = kmalloc(ALIGN(fw->size + sizeof(struct sms_firmware),
		SMS_ALLOC_ALIGNMENT), GFP_KERNEL | coredev->gfp_buf_flags);

This change fixes this cocci warning:
drivers/media/common/siano/smscoreapi.h:669:6-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/common/siano/smscoreapi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/siano/smscoreapi.h b/drivers/media/common/siano/smscoreapi.h
index bc61bc8b9ea9..82d9f8a64d99 100644
--- a/drivers/media/common/siano/smscoreapi.h
+++ b/drivers/media/common/siano/smscoreapi.h
@@ -666,7 +666,7 @@ struct sms_firmware {
 	u32			check_sum;
 	u32			length;
 	u32			start_address;
-	u8			payload[1];
+	u8			payload[];
 };
 
 /* statistics information returned as response for

-- 
2.45.1.288.g0e0cd299f1-goog


