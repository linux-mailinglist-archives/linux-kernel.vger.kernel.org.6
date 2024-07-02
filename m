Return-Path: <linux-kernel+bounces-237961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E60924141
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A51287180
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E761BA883;
	Tue,  2 Jul 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6NSwcB/"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A2A1E48A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931734; cv=none; b=fYmJdbPOy4LKzejHCMYGTOz2aAFArzn0w35uWv1wZJSpdkYCxDwhU2yKeoiHU6T0MXwyZ5tFnKsPDd9GYksUu3a5wVkUpg3ExMJZfXTUleqQTdgDrZiTegsQSEmLsjmwL4CF6CVE1ovKG0t1v2XjEmLHfWJ+QxILSFPBDDWax4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931734; c=relaxed/simple;
	bh=AQVlcyF9Tip+It54yHXr1yZmmTS5Q3x12TvMoh8HyDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sbHuTvgQHNtCknQUhyhdhtgyruqrWqJFnwnE8aNgTOwYsCqyll8dwKDquQB9ZWFAMYFs20bUB23veMsF6C66BipC/MK71azgnP5aHB2J/7sRr3IxlMqCMnNV2DKoOzAy111QVcM7Ir/0CsiQ8kXycX2V+r+CxRw3EhEk+mvESvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6NSwcB/; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5c410776a80so2219297eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719931732; x=1720536532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbzSX2jm/CLVUUZ3qU6O92SO48UCb5doHo+EGGpsX5s=;
        b=D6NSwcB/eN3N+o0MJRF6V53Ey7Zi5Qj7P53fWKgOUo03+lUqbWcnkKb4EyW27tFd4M
         pNl1KNfi0VVNUYTXGez/DJTntxLg5exiVFwF0ArnhQLPH63GIicnqULuv9RClqyJWFMK
         JBkJAd9uAxQVsqky2sWFSqzSvlCDvWNjxL5ebyd/Wt4NAONT/sgDwFSrnLw+Fmcg5B6p
         FGX08Z6gkUTMPTEcBH0YMIFbgVFb9HDzeUJeXl0d46QMLIB8MHdx/aex2kTknGBK47tl
         ZMLJ6Qoz7v8xXiGXW4iaOmG/1MPbVX6KL6Ex0YCvpPStkbIBv+gXqCBdxKPFMOrUF8E3
         5HqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719931732; x=1720536532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbzSX2jm/CLVUUZ3qU6O92SO48UCb5doHo+EGGpsX5s=;
        b=SQMO180w9gPqtMTzwIZ5Hk+941IzlXSyK7OA9cjKT86LXOptI/hUL52q1awdb9CXFx
         uqXZoo3R4pFNkD3UuLvqhvwUe1yFgmw4lqnmjahCKdoN9JGSwBI5PT9iBBPx56YYEGYp
         znsnMLL6uAio+U1B8e3TBu15NZeYG5g3VCJVGCVDPHjulr1mYntMwaih6kgpPbCBEDD+
         6P6PeE1iwyWT0H8kZxj0auj95S9nHWzhWtBjxGbavPlkVoM4vJr3QiY7d3Hbuv4nSIBw
         HKnrAmiYOlUtb8+TSFpPofQd9mt7LycFqAcg/dsUvsHd6DYA46qi1C8TIc/eljmXvH+B
         bXhA==
X-Forwarded-Encrypted: i=1; AJvYcCWrpi1MOFkp0XBTIsbn+PIB7e8S4hY7R5cynIpouYlp/zl6WCMfZCzXuYmqL1id9sKjKs9FojvR9EJt4tT25SyJ1x0fUn4wRogMoxxu
X-Gm-Message-State: AOJu0Yxux3Lb81xH3/LJBHHp+qAdB1libbP7X0h9mfTeNtiW8DpVbJ6Q
	bmyTmVXrebf5nhPMtP9huXnV8XDdV+RR3Cxcf/I4ysM3u5SYqpH7bTXjLomg
X-Google-Smtp-Source: AGHT+IEoKjeHNdhrVeltAR3pigvzckm+881yE7i+H5fpSRXSBafQKcZfdKbF9Ig4QexHTY4SMiyIBg==
X-Received: by 2002:a05:6358:9486:b0:19f:346d:d1d1 with SMTP id e5c5f4694b2df-1a6acdc06e4mr879562355d.16.1719931731801;
        Tue, 02 Jul 2024 07:48:51 -0700 (PDT)
Received: from dev0.. ([49.43.162.163])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6b48e198sm5687831a12.51.2024.07.02.07.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:48:50 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com
Subject: [PATCH] gpu: ipu-v3: Removal of of_node_put with __free for auto cleanup
Date: Tue,  2 Jul 2024 14:48:36 +0000
Message-Id: <20240702144836.1001916-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove of_node_put from device node of_node.
Move declaration to initialization for ensuring scope sanity.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 drivers/gpu/ipu-v3/ipu-common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 71ec1e7f657a..f8cc3f721d2a 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1150,10 +1150,10 @@ static int ipu_add_client_devices(struct ipu_soc *ipu, unsigned long ipu_base)
 	for (i = 0; i < ARRAY_SIZE(client_reg); i++) {
 		struct ipu_platform_reg *reg = &client_reg[i];
 		struct platform_device *pdev;
-		struct device_node *of_node;
-
 		/* Associate subdevice with the corresponding port node */
-		of_node = of_graph_get_port_by_id(dev->of_node, i);
+		struct device_node *of_node __free(device_node) =
+			of_graph_get_port_by_id(dev->of_node, i);
+
 		if (!of_node) {
 			dev_info(dev,
 				 "no port@%d node in %pOF, not using %s%d\n",
-- 
2.34.1


