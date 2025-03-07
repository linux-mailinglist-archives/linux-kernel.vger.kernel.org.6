Return-Path: <linux-kernel+bounces-551725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0342AA56FDA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C99E07A6CC4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C2924166B;
	Fri,  7 Mar 2025 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJZsc8cR"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148024BC06
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370287; cv=none; b=kd+fzIW9rhKhnSitTbgbnE/2VLsB3Ammx9zadizW3BsAUe/gwo9JN7mNAl9du890kz7pRE3HWoL3H/Mvc6dGDPeqwGClkAZ3SNYszP8nsEaTNKdsTxlzCjaesf32YAdHaHU79+wgxEa//kkrylsucowYRIRIRiwj2B8FJFlNltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370287; c=relaxed/simple;
	bh=xaxaP0UQk0j3ORJrav6GGF1BISJq8o8JnZOkO2EghUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WEPe9O1Hz7NIBlw0nFjTIg2C82WX9nwJxqFd2vIxOK7xNAxJuocx20OHeA6zDHXzOVb18WnsTEAiDcu/+RqP3EQNtjUwpXC6iXKR+tGmfWua/jxU9qloAi4a4dbb1nttDYyeFa/dcKxI7NAgvFaMe3lyOlvxMma4AjvdKEf0+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aJZsc8cR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e4f88ea298so3725199a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741370284; x=1741975084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxLoQqhP7alWc8Ntu9qEPw7paLjhlfWycr5k9Xi4Dxs=;
        b=aJZsc8cRUSNdV6e9Z/2ql9afuCK/fwXSVJAHLHI8jBJ3SPnL3Kr3IpxpqxaeZip5Lt
         uMJyBAPNQfcIyBfmlGwwu/za86hFQwK7LgxIoXcHVDPA/yH2eybugObmTzGkG2nULOsO
         +n5T6SsdsoBLKOy2UWxpwFbXyujNjNd86KOkt1bUq4G/T9Q3kPZbMBQZoXmOG1Gx8dAO
         /b9tAUZ1Sq3/0EJHXxdYFF3mdr2QyJfS8EMh/xzXgIErmQc+raQCUasjFJME4WV/xe2f
         07xHkeUDJROYdQ0Pk9xUL+CX4QGpNeWPs1IJkyEkzVDVJjAoNyVMouN6eduuitATb5Gk
         F5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370284; x=1741975084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxLoQqhP7alWc8Ntu9qEPw7paLjhlfWycr5k9Xi4Dxs=;
        b=gZexobwb6CAlQPsxs7ywPXTF9rugqvM6FKjZxjpAeb6/otOzTE1xPxFOS3q7BXJFMu
         RtFCKwmuNcFmj468mJveI+6xrMCwBpWEf/yd4taXg/BtSxmc7XqIGrih613A6DH8Sr0a
         uGjgMSridS/DA475107UEpKmFzOzkXzAXmA8xzdMUEWYvao1uk9ydh1xBJiXqe9wUxJE
         5D+2Z4td2opTwi9Yvh1xvigUfyT1duJFzCCg/wu+BiJ43hCGDUcIECyEtA16ZkI//+pr
         p43gyfmO4HC5aBg5/6t1Qprh+wIXRCPq351doCU6NQ792UjigovIo8XfttgYa7eebdsl
         /9wA==
X-Gm-Message-State: AOJu0Yz895OrQTq0SMr6pDCVNTjbn93aHHngHFnGmq93ZiTr95vvivc/
	OtMJ+yBmqsi4z4q331f6gJ8t/z1prOu+LbayHiK5UDzjNRT2towvFZ/7tl1Sajc=
X-Gm-Gg: ASbGncsz8clz73pT/GX06WgDQJCkFfsRJv0fS5FykYWwQWe3KGYrjOLdIMbxxkY82TJ
	g4dkXJjSQaEpw48pjKFTALs4rBd8wro48I4pNsL+p8Gh8Ox/cudUqemlhjeg03jHkfcuSIaz6Bj
	j6kxkwCkVpp31RDzhPe2HZIavRSb5U4vrLQhYuAh0gnVKwI0ylftRSpX+R165gDVhkUwxVOXqxH
	UmZMzUjPHj0Bfc0ERT3l1Xb+oo0yDEkxCELg7CwjrEU9Y5lifjV3dNKYF3tpYYb6TZWaq2607xX
	1jVywa2zUOyxbNnSB2e8Dx2eB+D64Dfhny8esWzQWR/sz6niOBbYgbFQ1kIbeRYp5v+WzQ==
X-Google-Smtp-Source: AGHT+IFuJNJItIEbZeyh9F3E9+ggfjfUpDTQV0yu8dur2Sw/h5tu0VQgtw/21k+qqebF4K5s7vvqYg==
X-Received: by 2002:a05:6402:26ce:b0:5e5:c3bc:f4ee with SMTP id 4fb4d7f45d1cf-5e5e250cd5amr5647569a12.31.1741370284341;
        Fri, 07 Mar 2025 09:58:04 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745c5afsm2803622a12.18.2025.03.07.09.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:58:03 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 12/14] nvmem: make the misaligned raw_len non-fatal
Date: Fri,  7 Mar 2025 17:57:22 +0000
Message-Id: <20250307175724.15068-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
References: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=9QZjd6mQ88in1BGtGMk3bYHEXDJuYcnE0RuCLJqKxlE=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnyzN9IZKCrf2NaI359lPwEfGXiJ7+5dLr1X6Mp KO0risUtH+JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ8szfQAKCRB6of1ZxzRV Nw6BB/9+y/QfU4PJOKIXO60eBVIhU1IS3QOkYY44/NG6yBQvzhqeTF39PkI1z/ZWa+KGPi9A5Eo keKdSDWzF8xbbFrrXy/qIJi0zIodfdTNGHPw5Ect3fHVh28TkpZcDgKqY34CB9j+ubTJEyuwNcp krpLehXKL4upjzmIjQJSYG0TM5X+z29gJ76/fkevIbcbCPgtFX1qdRs3r+6nlW5Eii6ETecy3Y8 NJgDX/PIF9ZrQ1Xjcwk+8qS9GqMVeeceUU7gjYAbpWE+doU9R33AJzBxfRSnz8bFYUPQcg9f4tb Fzrm6jKtqcC/cuXQWTohQh0EK2VMwlivJJ9pWiHXUCSJruuR
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

The commit 11ccaa312111 ("nvmem: core: verify cell's raw_len") enforced
the raw read len being aligned to the NVMEM's word_size. However this
change broke some of the platforms, because those used misaligned
reads. Make this error non-fatal for the drivers that didn't specify
raw_len directly and just increase the raw_len making it aligned.

Fixes: 11ccaa312111 ("nvmem: core: verify cell's raw_len")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/linux-arm-msm/Z7Xv9lNc6ckJVtKc@finisterre.sirena.org.uk/
Tested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b6f8544fd966..e206efc29a00 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -612,7 +612,11 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 			"cell %s raw len %zd unaligned to nvmem word size %d\n",
 			cell->name ?: "<unknown>", cell->raw_len,
 			nvmem->word_size);
-		return -EINVAL;
+
+		if (info->raw_len)
+			return -EINVAL;
+
+		cell->raw_len = ALIGN(cell->raw_len, nvmem->word_size);
 	}
 
 	return 0;
-- 
2.25.1


