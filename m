Return-Path: <linux-kernel+bounces-528289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A086AA415D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06EB3B5A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB9E24167D;
	Mon, 24 Feb 2025 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MrlsSQcZ"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0220B20A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380642; cv=none; b=sJfkkRIhi/Egj6mpQl8kaTwhJ+oM550tbxQJvm50ai1eTNqNu0I82jq1SkdKKZYc90dhFo+2U6lNAStZaY9bFKi3/Q0+YfN6HIi6oPGJ1xzcwguBWw7Rxjml29CaSIme+xvQT1ru2jt2NUpQgfeoZ6F3ugRO00PZAKEhBX0cKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380642; c=relaxed/simple;
	bh=gxhapjJ2V7VmgaU4ygU27WoYv9liMFZHBLfXA9uaLac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m5AxCRZd4EtvbUYkAlPSSERuXl1mwu0Za1Ct5rbQxUupzRaDwn/6qapHs4Gg0+yMjYYn/w2ftKvPwLvX3OJj0nFLRx5pdCj8szQQ2Q+hTV/skbQBJyHgaqm+5pFFH1bR2IDPbRYVTH306dN5L8E9PYCQsqNnRAYO59Bi9Kfdxx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MrlsSQcZ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c2303a56d6so58044485a.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740380639; x=1740985439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zNBSiNN48vAuN3f6QiTHcLYM/YjS/mOVk8GlAcAGX0=;
        b=MrlsSQcZYiQPKGDyNH4bQfoY5eUpyg0fJk+ViixTJ8pRRnwQ6hQFWzK1U8yrVIMJ+H
         GUOsysBQGsWM2huhXAikce7Ne33qE9HoH0/7lh6EfNhMdhlp/8VdSpm13T+HevnEOEuB
         T+e5BrS7ntkCVfOY2qhPgK4IjT+TZitoNQV94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740380639; x=1740985439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zNBSiNN48vAuN3f6QiTHcLYM/YjS/mOVk8GlAcAGX0=;
        b=jB8N/6kk0fgnJh3b02XNP99H1oS5iHmbq0pjm987iI05cBkFONZWgZU6OSJDaxcZO/
         Vw/l1cRIiAMV0IAAojNF+eHrjnKPRLkvn27MXEwWzOYumHsCOA/n6EZOnoYExdVneRV+
         JBPzbAufCQ/SFN9PaKpUHQZR+KKPU1hzS0EkFAMp1rOFo+IwfArPQequRrkcxJeYbsAV
         kEGdpEdH7vCtKdvLIOIIQZstwQ0M2mOiTMfZAvvDfsMPWwFyBus5zCBE9zRjiwixRD1C
         1oTNBGDlB7PVOcdSBSbix7MZVO9GsoHLLPp1es19mmjp6RoGEG9KLVS/mHhcgZRS4gyA
         uArA==
X-Forwarded-Encrypted: i=1; AJvYcCX19swoShZ8hWv9ivMHmvn+fQB615XEk8DgfsrmUI4XafaNj2MIW1ZfJPuq1d+9C9UNYnNgS6EIbtPwb0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdlrDHJQOkWGKNk1oIgWa/0klkC18gFhJ/yWEAH6JnDQuDzlqO
	2UaKWgWD8gTzgwtPj02cKqQZGvUGRI7c04++nZklzWvfnUDTdA680zOfhViuTQ==
X-Gm-Gg: ASbGnctpykMPZnf1DXqtHVtmDdYSo81T+5KXD32EHYzlOn98DX9YN4tIlpA6xjjEJ/5
	mLVBo3VQ8TzAggLjeMNkMfsrvTuzDOB/3z3MLt71eJuV3pQU+8OyJFkJtn4HdzoHYAEDGYerGEK
	VHiHSl+nvisiiBGFf47vYA2L+ek07qmsnaod0mR7A4OnxQl12X1LuY8vEKj/zEWoguyaWjUt8Tg
	SOZjHjZFC3gyKcK4bPLw0QFqBALkU8EmCSgnjFmiZYesYdxg6PrQ40/dktkpsWBxMRcG6zZvNDw
	CloJTqVryxZeVom1AIPLehEttiv6j7Nt9cs3VEmiWntZyZdpKXntPxsmfP4SBZQjLT3tvyGdJ4T
	8JH4=
X-Google-Smtp-Source: AGHT+IHcm5l4vj+qLy5nO1kcV2ISxYp1Ig6V5tDSH+3S1QoU9rYnKzcGaZk0NeL01r9155s+2saw4Q==
X-Received: by 2002:a05:620a:488f:b0:7c0:b018:5928 with SMTP id af79cd13be357-7c0cf96eeacmr1637963085a.47.1740380639403;
        Sun, 23 Feb 2025 23:03:59 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm977920485a.47.2025.02.23.23.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 23:03:58 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 24 Feb 2025 07:03:54 +0000
Subject: [PATCH v2 1/2] media: nuvoton: Fix reference handling of ece_node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-nuvoton-v2-1-8faaa606be01@chromium.org>
References: <20250224-nuvoton-v2-0-8faaa606be01@chromium.org>
In-Reply-To: <20250224-nuvoton-v2-0-8faaa606be01@chromium.org>
To: Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marvin Lin <milkfafa@gmail.com>, linux-media@vger.kernel.org, 
 openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1

Make sure all the code paths call of_node_put().

Instead of manually calling of_node_put, use the __free macros/helpers.

Cc: stable@vger.kernel.org
Fixes: 46c15a4ff1f4 ("media: nuvoton: Add driver for NPCM video capture and encoding engine")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/nuvoton/npcm-video.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
index 024cd8ee1709..0547f119c38f 100644
--- a/drivers/media/platform/nuvoton/npcm-video.c
+++ b/drivers/media/platform/nuvoton/npcm-video.c
@@ -1648,8 +1648,8 @@ static int npcm_video_setup_video(struct npcm_video *video)
 
 static int npcm_video_ece_init(struct npcm_video *video)
 {
+	struct device_node *ece_node __free(device_node) = NULL;
 	struct device *dev = video->dev;
-	struct device_node *ece_node;
 	struct platform_device *ece_pdev;
 	void __iomem *regs;
 
@@ -1669,7 +1669,6 @@ static int npcm_video_ece_init(struct npcm_video *video)
 			dev_err(dev, "Failed to find ECE device\n");
 			return -ENODEV;
 		}
-		of_node_put(ece_node);
 
 		regs = devm_platform_ioremap_resource(ece_pdev, 0);
 		if (IS_ERR(regs)) {

-- 
2.48.1.601.g30ceb7b040-goog


