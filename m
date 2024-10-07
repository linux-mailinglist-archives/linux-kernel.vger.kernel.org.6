Return-Path: <linux-kernel+bounces-352749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959B19923BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5562816F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 04:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EE5136358;
	Mon,  7 Oct 2024 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="f7PKCYpE"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2AE39AF4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 04:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728276763; cv=none; b=RQ+bZ1QRhNNgguFHthALBPSfPDs/WNmdqVAYmeJquR+BQpb8Ri3LssxWJUyZrzkVkt3En8zk/LC54of6JiYlqsPx92T4M64uo2YVZ623Yf4Eb3BuX7g4/bxc2g8ek7HRYJ1Uy8NpnCxt78qmHGmnYswZM3Ty2la7Pm+fs/JLdJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728276763; c=relaxed/simple;
	bh=Pe51Lg/PsZLWAqG9WRRKbxZ4v4+EdZ8UaY5o4W06xTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TClxJTQlEXbpUo2xTlIFCskODnu4WYFFtwkZxSZdpt628Rcf7nTCp6zEhZWVwIWHu5NwmmLIVL6VimJ3RLaUfxwrL0g73+s8HYbV4a3JKJG7AlqiaeSn0BzdG5AGYMzZm1gacC8/hoILxAw6YAGM1h3RNfIdKWdUtyjVNRxXaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=f7PKCYpE; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4582c4aa2c2so30621021cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 21:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728276759; x=1728881559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0JH+eeGvKfz71oS0W6AeXi5f58Oy8T9dmTdRTdFrBnI=;
        b=f7PKCYpEyASYIm9Zx+2bSByq6wqn8r12rCjhHOb503a9RR7oTvEhPCgd9XrZ60DNdW
         +jxhl9mtpI6ONwPRk6yjUrG1G4s7Tdvc0HnpRfPtFwgWBOSA23eZuXHwnRvZTrkQWIJj
         i3U8OxSkCSAjgsUsp5BvaCpNGnQTGM5Tf9baUcYhc8bwYOhvl/KEzYJ0h1KzfHCb+iCF
         A41ROm9rqwDxTaKU+WHRjjaKiq6NQ16kDhveIb+i4RDk/CiB/bKPdnjXj4uDhLw8VYqp
         S+f6+hby1hSaLzvG4Z5x3JC5t2mehY5NzQSOe3Ky61aYPrX2+SLEM+zxLo+sFNtITZep
         kH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728276759; x=1728881559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JH+eeGvKfz71oS0W6AeXi5f58Oy8T9dmTdRTdFrBnI=;
        b=Si6jrAxe+xGv8XfzZvK8loANWIf52+Ak+LJ/5hq0kystHMBgCudHS2d2kOnSZpav0x
         GOOrgRF3PyDQ9C5Wimz53uRGJdcn+InS+6GZM/xXc8QPPTvz/XWRqfmSsiDd0liviVh0
         fCuh9CPn4ADNpFM8QntavrvyjQh/78fLNzwyNUGBmYoXtosneLHX2MpK43tiGiNq1PON
         FcIxMj/xa1uHWUIUDgnW3oNBc/MePqWkBjQDlxq+y/rI9jkkbcPw5ALpFw1wtldbclxH
         tsM36kOpKMQ5eILnL73xK1wWL0RY0XzoUWc4iulpfqUohhf5xTkl32VmJqbLA0xqBmAe
         KTaA==
X-Forwarded-Encrypted: i=1; AJvYcCUgjCh+7eOhMN03A/P8QZT5SKzumZqsP8fUYFeZf/Z+bhs2VhXQpPjNhe83YzWLlR/bf/ePajKnaNDAHRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNxnfAXqdbpNkFXyDP9S0k7hER8R8N33CRdOWG3waZuoq3dIzU
	mnp6su+Q+Gy1GR7SzG7aJUjvkG28NJ0PWbA2rt9J5m86Tcb8sBRuixtDGt3TdSk=
X-Google-Smtp-Source: AGHT+IH/9bsZq7uHy78secXuJvI/6P0sWacsBbySahkLVEBVoPJhgQSm4YakQO1cbX3fBAenHpNq8g==
X-Received: by 2002:a05:622a:450:b0:45d:5d31:89f0 with SMTP id d75a77b69052e-45d9ba2f03dmr192178031cf.3.1728276759124;
        Sun, 06 Oct 2024 21:52:39 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da764043esm22666351cf.88.2024.10.06.21.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 21:52:38 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Arun Kumar Neelakantam <quic_aneela@quicinc.com>,
	linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] rpmsg: glink: use only lower 16-bits of param2 for CMD_OPEN name length
Date: Mon,  7 Oct 2024 00:47:22 -0400
Message-ID: <20241007044723.25347-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The name len field of the CMD_OPEN packet is only 16-bits and the upper
16-bits of "param2" are a different field, which can be nonzero in certain
situations, and CMD_OPEN packets can be unexpectedly dropped because of
this.

Fix this by masking out the upper 16 bits of param2.

(the commit in this Fixes tag is not where the original code was introduced
but it should be far back enough not to matter)

Fixes: 835764ddd9af ("rpmsg: glink: Move the common glink protocol implementation to glink_native.c")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/rpmsg/qcom_glink_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 0b2f290069080..e4933b823238c 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1204,7 +1204,7 @@ void qcom_glink_native_rx(struct qcom_glink *glink)
 			ret = qcom_glink_rx_open_ack(glink, param1);
 			break;
 		case GLINK_CMD_OPEN:
-			ret = qcom_glink_rx_defer(glink, param2);
+			ret = qcom_glink_rx_defer(glink, param2 & 0xffff);
 			break;
 		case GLINK_CMD_TX_DATA:
 		case GLINK_CMD_TX_DATA_CONT:
-- 
2.45.1


