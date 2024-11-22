Return-Path: <linux-kernel+bounces-418586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3043E9D633F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E731A282D16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0621DF970;
	Fri, 22 Nov 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eeY1oGmL"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6E81DF968
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297018; cv=none; b=NuxInZRcr8lsnCmvE4K4rYPTHTjBgtVEQy0m2d7dMOT5Uaej7NQALG5CevXpkFVt7n0sGhlQU2/paQ7TYaq8lJhgdNA1KQqvLN/eNdy0h0ilU6Xk8iDIkTXezG+rikEZ+FyXs0k4atVTkix6B3kODdVzPFK/bclcQnxMRarX+hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297018; c=relaxed/simple;
	bh=LYHv25BlgnNGezmW4hSk8hWrtuIkhqDvhTcO/j2PRUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gRx2re2Sj5afq0SGdJ4k5Rag+7LzyaG6rpO/F/ufSbvhFu1zapyx1496vINohBfAi6JTMqmgwPZJjQekUDPjEDQMOsPLKT7bcYE2Ok8rlJOwpjfFKVXIcbl3BV9PHcGaiqIRGvA/uy8nySrjetuMpa3LQz3cvEWVlOaebRikirk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eeY1oGmL; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b161fa1c7bso133925685a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732297016; x=1732901816; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3n7nEmxo8kDo/GdhI+k2+p8juIiYwWmm+yhRX/Vo/Ws=;
        b=eeY1oGmL5InSHEKcGfB+60P7AqZpquR2VP/BcLbuUw2778i6xxHVSlcehUPPFuVvtL
         npKdLi5xmZa4SwgHK6yiU8bmpo4ubvhhxwbn4EOFBvSyYT1YbeKUWNF8849wd6CR4IS2
         bgKaGdHLEWjdehPrIwPMbbpSF4HjLYxx2wEWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732297016; x=1732901816;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3n7nEmxo8kDo/GdhI+k2+p8juIiYwWmm+yhRX/Vo/Ws=;
        b=gKzrClKYPywGNRjpob6qb7KCpLDDzWoihsph/xSFKbNn0gaJvKSXSimzxdqvmJbQHL
         ehIz9XiWGuEPSXPhQA5qo5j8tXOOGtf867RMfUlOo/V/yoixIIBrV/iSN7RNTKynVHwD
         +4n/Co/HP0M8qFWm4mcnWPLnQ6zNJbAgWZh82gr1xIrc/zdsmwqeA7CYiT4K0wSPSfL2
         fKJeZmMYCCjbrC3Lm95/DM2zunnHmA0HNPLL+KIg2AboJSvjm4paq4jhkVzrCM0ITkPM
         xnLrVFsItWCm2qMHd/z7OERW2+DAXzka1sGK4K4zkiVcVNcCZEaF4ukn+K2D7c8JpaYU
         GdKg==
X-Forwarded-Encrypted: i=1; AJvYcCXuWeHQlj4TzA2tTMrx3mwOIJOScv5vlkAEvAysC3Wp3X9oac5RK0/4te6XbrFaUIplYjZIAJRxYF/r02U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMq4sbpqEC6VB1vUH++UUaOkD+tvAU4WmiHZUkrkjXT570DUNK
	qJEpu2ibe52EeIR+dntcpeif/qN3JKQud2pDIJUVhAGfJCA/gSFsb5darJeGCT5Y260A+H+QA8M
	=
X-Gm-Gg: ASbGncuIcgeEj17BvxLb0VIyMcU28EmQLDGatRlxbb+UdoRzNAfDUV9riCF7XlPAXC6
	5Ze1K9H3t7ZiCIccbV1H6iaeS8+RftDhKOAEdCSOp2bxlVEU7u8L2wB29dBUk5qbPAmmHnZtkqv
	Yx9Qe6CAJu3BYvR3xsVG/PRTDf41pcSjD55cbOZiHonMX1a7mY9LFSinhCphvt/758JyyJvOGfO
	W9yl+43V4yuSBeWq4sli84B0zBM0uwmdI+87eqMYIsZfLZ++o7gmFKYx9mIgpyt2SwyJ2U005c2
	9SkadugYmxRnBAY5w9THABC4
X-Google-Smtp-Source: AGHT+IEttBBYBx0GyZV8ei3rWb/Bwt7PQPUrxuqdwAxWwX5z/MVNcS8800PxYersM5EOYbVTr56k5Q==
X-Received: by 2002:a05:620a:4045:b0:7ae:5c67:e19c with SMTP id af79cd13be357-7b5146126c9mr498103685a.55.1732297015932;
        Fri, 22 Nov 2024 09:36:55 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513fa4e95sm107451285a.33.2024.11.22.09.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:36:55 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 17:36:52 +0000
Subject: [PATCH v2] iio: hid-sensor-prox: Fix invalid read_raw for
 attention
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-processed-v2-1-b9f606d3b519@chromium.org>
X-B4-Tracking: v=1; b=H4sIADPBQGcC/3WMQQ6CMBBFr0Jm7RimVoiuvIdhUdsBZgElUyUa0
 rtb2bt8P/+9DRKrcIJrtYHyKkniXMAcKvCjmwdGCYXB1MYSGcJe3rho9JwSB+RA7nJuLHFjoTi
 LcjnsvXtXeJT0jPrZ8yv91n+llZDQ9o6btq3D41Tf/Khxktd0jDpAl3P+AhUj21itAAAA
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The attention channel is a IIO_CHAN_INFO_PROCESSED, not a
IIO_CHAN_INFO_RAW.

Modify prox_read_raw() to support it.

Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more channels")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Do not change the condition for applying the multiplier.
- Link to v1: https://lore.kernel.org/r/20241121-fix-processed-v1-1-4fae6770db30@chromium.org
---
 drivers/iio/light/hid-sensor-prox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index e8e7b2999b4c..0daa8d365a6c 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -94,6 +94,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 	*val2 = 0;
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
 		if (chan->scan_index >= prox_state->num_channels)
 			return -EINVAL;
 		address = prox_state->channel2usage[chan->scan_index];

---
base-commit: decc701f41d07481893fdea942c0ac6b226e84cd
change-id: 20241121-fix-processed-ed1a95641e64

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


