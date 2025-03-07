Return-Path: <linux-kernel+bounces-551722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3A9A56FD7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058A517A763
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA6E24887E;
	Fri,  7 Mar 2025 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eP+DIP6Q"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13612459D4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370283; cv=none; b=I2V3JKBldFvHmExQ/wXQ9VbkgBea9Eik+NpwWHs/DNgegbYBfwSUJjevFmfTgharAY3aoRh/LoXlcwfSEtwXX/51kp7g/7JyOGExnS3gVludC/BO2HaaNCJ24f86sdeq21aC7jsSvkWrLUZgYSalxN2aDsgBh3jVCWJ4MwaTyaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370283; c=relaxed/simple;
	bh=scwFGPFSlbelb4jWmPxSj1MlJcvwnSqeGqWL5Fg/f+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N3QLQU7h/Lj057yfTCEh//hexAwGmPe+r+oVLvWgnpSK37NlaFTVt9rs/mO/BfoGpjvI4z8tqcKjudoWPF/kgUPwGm+Ehuv8WtYVZmkwtnla8C3OYX5axWW++ltm6+Ys49XnEu81GLotWreyVcO66YFscRC6z4IYoNCLZyBDFkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eP+DIP6Q; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so3273524a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741370280; x=1741975080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QDtj1LyVw6hxivCjtd6Hjl5YiMg71/R2X/tB6KW2ss=;
        b=eP+DIP6QL6TqEGRSTbmZ1wv4Gaj1TWoMPC1jElb225h236neQue6H7eWoa14AjUFkk
         JGsPeslIVcEjzQUyV14/3Fr/6MUdHSsOqyGtxEqkQ1K8Cx1TLoigY/PcrKdTWJKiIgCD
         hFtShq4fGF+0bwlC0FQdk3cwcFu+uLsKLtbaCptzhPY5iYLniEJoS2dlDGKAESClNy8+
         /pgALQuw2Kgh1YXPyxMZwkF0oDB2koWZo52kLs9MsWH9Nbp7iLDYjkmeasShzV6npzYI
         EHGiF4CAsSERe4SSQEJusbwCH7J/+Ox+j8Ivjv3NsPxR5EY9/9BQYXjCzJHRMZ+RMnXM
         hZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370280; x=1741975080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QDtj1LyVw6hxivCjtd6Hjl5YiMg71/R2X/tB6KW2ss=;
        b=ppq5O3uEHtdbtLJGMRh6nWnEkgh9tlmigyTC+I3vR+JsMJw98mJmfrrNsn2Jf6vKQa
         BJSKqs9Gl2n/HmjbfPO9O2zxwWaIkYWzXMmHFY0qoNcU8lTAmVC7ZSEbjqWbBQAt7SAo
         cIcTsLXXrgywA/lB3DE59rloMHNTysU0YNga4BdcLG0XwHr/5ILbKjCqKJjSK6V8zFXv
         XugKEKLgB0cEao59P6zr0KIrFqJKr9MXFP3B6skIBB/xlR4x7E7t77XWea1w+yxKJZfy
         czaejf2OljRy7M8oZQsZ5D/IxYiMz6CHvE0Leti3L7uwXWYEiss5H0IEjx9mYYwEsFT4
         8IDQ==
X-Gm-Message-State: AOJu0Ywjll7bMl2u3mbAY742PJqYnOTsSET9knQBLfA/KlLPDL3+nfEC
	g/LNL5cc7oIwrnNZv756uxn8Gr0v20u4bblMiP5u1BHijfGFvQoN5zQIyZ8JFSp0pN/FCMsYEXX
	2
X-Gm-Gg: ASbGncu6chJCLnj+3F/NJBOslMBfApQN65jEJ4uuCKcmjMr1TDCqRPC2mcfpXnHnFv+
	vdTUY6WZHGVTGdmrkS4L9bO4feyqEk1iE9qhkTCPlZ0/CLoEnBuD2VLR8EL12I1KyDunk8UuFUK
	BRi9mv9Vl5XxpdNclKmCpTiwj0xeWie8xwI3YFiaL5LhNPfjY9EOcXnJG01vmmPDc5eemc6+MQm
	M41gc4Ke06h9RyQnCaa71LTjsu8uQciHvo4eQ2bvFObhmSFi5sxiph71td6Zxr1XDo/E71izQu2
	r3qdTlg7SOpUEvbmTA8PZdesGL5BOE8jegQCS8hC5ZVmbRh7HzWpFLkkeKJCsqv1QUo6VA==
X-Google-Smtp-Source: AGHT+IEbsPIxwq0yPMuce+h0ER2jOaosq45j6fMrwEBQHYxFslV1JQdRmzs96QSyAiWpOYZ/jPbN5Q==
X-Received: by 2002:a05:6402:51d1:b0:5e4:cbed:cb3e with SMTP id 4fb4d7f45d1cf-5e5e24d3854mr4471481a12.12.1741370280031;
        Fri, 07 Mar 2025 09:58:00 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745c5afsm2803622a12.18.2025.03.07.09.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:57:59 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/14] nvmem: core: verify cell's raw_len
Date: Fri,  7 Mar 2025 17:57:19 +0000
Message-Id: <20250307175724.15068-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
References: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=rsBDmOxFNJXqrf7DDy8vxhQi2Qrki9Mvt8Gf6fd2xe4=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnyzN9aTfq5YGsImCpSTTBQ1BXjIroAQ8oBZ7Gg hKNtvEqyWeJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ8szfQAKCRB6of1ZxzRV N+RtCACJjXfm0UdHhPPxsrVFabafGh64fRpPSKDYrau/q0f0z2zeaagDD9fUgOTQiR3cFZMIjKq fFjaqvu/AE1VLAxpIZWB2CJeQ77MC5f8F4dVsM5IV1Q+lTnPjyPNIgu2Qhez8HH6joZRxbtOmut nTA1pVQAFQ+rJNT6WHeryIIel8hPtxTxUNx2qzPl5UmnrIIsnQlivXW7/7oAtFCAWYwb/BqFXPV WAifHq14LHQQaIX2Mk3O+l+z+Njg7o9N4QBC+AnfhQn8CSAVRxdtsm86k5YKTKnVUQj8uo8iNdL pfY5jMNU4p0tJA92ix0u3X5eD+E5t5J1aWAXZzfuGQPKVvQm
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Check that the NVMEM cell's raw_len is a aligned to word_size. Otherwise
Otherwise drivers might face incomplete read while accessing the last
part of the NVMEM cell.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 7872903c08a1..ad9b716e8123 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -605,6 +605,14 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 		return -EINVAL;
 	}
 
+	if (!IS_ALIGNED(cell->raw_len, nvmem->word_size)) {
+		dev_err(&nvmem->dev,
+			"cell %s raw len %zd unaligned to nvmem word size %d\n",
+			cell->name ?: "<unknown>", cell->raw_len,
+			nvmem->word_size);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.25.1


