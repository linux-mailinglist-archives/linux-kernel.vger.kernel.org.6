Return-Path: <linux-kernel+bounces-513350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C557CA3494F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4C31639E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D607A200BB4;
	Thu, 13 Feb 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="gGpvePTh"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723401FECCA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463207; cv=none; b=T9IeaAfMVbgF9VYxbLdKXp6rz29/zVfwqnqEWjabOFFeiZ4vK6ytJHm/otVr38COCwiwTBmM+0wyL86y2fiiwfuW5HnXzoTwyPpjKKkGHVyP1OsC7EPOry9gYwoqw6TgVr+wdJVpt6FGZoTm7Sm7oj3lWDk+Gx1/9K9/W+hN680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463207; c=relaxed/simple;
	bh=dj/QgEpVTVainOviqrNs84aI3G2nI6U8+K2Q2ckkKmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gLskECSRwYRRd0PnilamTwW0QNoOqicfuzsfcBcJ+WZvMEcvF5zd1PY+PL52dHl1iPDPSwbFs2Ltl+RzKne0L0rIFgOOrMeHpEkx5KTfO0AKXp9dfB0Tl/tPIKCMmsqz0btxLzc6hhHMNDZVy058K2ofqAOkzuPXf+2DX7QDKAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=gGpvePTh; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739463203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9CoS5efnNhs2HIJLsLL5qOupZo4J7abKpW0xblWXuM=;
	b=gGpvePThmOrXYKJAbCRDx3qCBrj4gqVY8GJCPsuAzYZRuO2FxMLi8uf6PfuYjZh/p0hB8w
	d/2tNLl1p75oWWUfTWvEY9xVGo6xUlz0zxXhPwLlWqAb8bOG1atqBBVgnlSDol1ZPCdZPy
	5u8LoQbevgUXTUydAUn+4y4kXMmhbb9j5zCVgh7DQ4I8Jt9YKxIOQW+orgpC8wHsr/T8YC
	IDWeGUz2MfJ5PXvP22N4Rpys1uJh0r75fOi2aHGeDsSM/t+2pweXeunjpgHpNUpQm3iQM9
	vXpQvB+0ZCVa46JfErURVZcu1cnuuS6cIwkhRhx6AvkhiFFU7wLPZ/XNv/0eCA==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Thu, 13 Feb 2025 11:12:59 -0500
Subject: [PATCH v2 2/2] apple-nvme: Release power domains when probe fails
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-nvme-fixes-v2-2-a20032d13e38@rosenzweig.io>
References: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>
In-Reply-To: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=896; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=Cw3j5ZwF0ZpXtZjtAYoiFOLvFEyNrVEWrLNZJYk08lA=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnrhocGrC88sbMtudltmIRFFMhJDEYdLnbqgA1c
 B2attrG8DyJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ64aHAAKCRD+/lBaCvVY
 DcFHD/9HNGYW9xjWXZ9DMBfT4a7mVIYsL65qQMmrdbU/r6jbvPTceMAEFdvhzS4ctH/rfYJ5D1C
 v4roY6Q8CMsuo440S9NtnOQzj9z5RI8gy36qRvhwvKSlWedO/WoVmpibf8YFMPRSvHou3UEK+E3
 VRIQdYkwXXeYNeIfVegD4RcTzZ9D9CEUAF/32UShMSG1zLI433NGESgptfoNZL9Jn/lmgnmiKqZ
 +VMkL4AXhhzmjtdFp8HBTWOFAOSnR7ntWVgO4fv4jwVTRr4ffrM2O7rJos0773rG1lUgnv0llSz
 8yj3Rv5Ja5HAYpoJrtLKr9jnnb0vp4wH0jGytf57fhPiXnxpl+DzzFishxMPjr4CNmZ8XE/1mtm
 PzJm2AXI6HZyXRNwSGfnmN3ekgHkA5k4LWDIxo619yXqj7CbnzHMz8r5ranJeN6gwjNpYRjaYQM
 cxs8ii91su9Fpoj998qGLUmx0coUMuWkxzPpHyjRQd+u1cbIZ3M5so9on6Ta5HjiG5fXYLlF1pV
 ucy1ZNszllRF9RX0gWGsWlDs+f2ctZ6rd0G5Sv0ufOhriJcAe3hV2bVJWWPFuz96SbCGsr5JbMd
 UjemxVBWfWIy+oDu5qO9b6ocCf2dkNHWUmklDgFj5uQ9qorqH4mdpXQ+bYYNr5V47VqJgYAxy0s
 DScqoDigzuEODDg==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

From: Hector Martin <marcan@marcan.st>

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/nvme/host/apple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 5e1c01a67ee81a36faa3da2f86a3a24fefcdfd6f..a060f69558e76970bfba046cca5127243e8a51b7 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1528,6 +1528,7 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 
 	return anv;
 put_dev:
+	apple_nvme_detach_genpd(anv);
 	put_device(anv->dev);
 	return ERR_PTR(ret);
 }
@@ -1561,6 +1562,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 	nvme_uninit_ctrl(&anv->ctrl);
 out_put_ctrl:
 	nvme_put_ctrl(&anv->ctrl);
+	apple_nvme_detach_genpd(anv);
 	return ret;
 }
 

-- 
2.48.1


