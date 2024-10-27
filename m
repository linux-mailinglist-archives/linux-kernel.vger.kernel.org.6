Return-Path: <linux-kernel+bounces-383489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2DC9B1C69
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 08:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8141C20B60
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 07:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DDA3BBC5;
	Sun, 27 Oct 2024 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knimQV7u"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D802C217F3B
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730015651; cv=none; b=Rf9odi4WRzS8M+sDZ34Ys0jG94BUUtErIyU5fLi2LdBPGnMoGHxdXY+dcN0W6nSsYaLVawUodyUpwVCS9DoeQ4EGtVQLqkolG6iRSBHMiiCYmRq1zOqUq8oet7Um6gPQsMZfkFCkYKYyNnhB/trWni8pvFKjPBq654CxmAUAr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730015651; c=relaxed/simple;
	bh=j4vkh6HZA0+rPQ7VID1SOK98y2la8NwZsrhmQT25mOA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oynxXK0XDfZZqksCBGn9nUKvwZqcou/StB5QSaCIES+CTMyjOnj2QdHKJ7x72zxSskg5SZPqY9ZDLX5Rs/LXE0sbxMpr2JdKzzOX/Gqs5gAqbx0Y7nm8YTNQONUXfLcnyWwfjFMrzkrgRLEYjfL6N5K8ABp9hz0aVFtAQ8zjgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knimQV7u; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c714cd9c8so31748395ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730015649; x=1730620449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KWickdyVmCsECTe9uWE+5e70fKgYSzHKZqcNgghgJWE=;
        b=knimQV7u7SJYOax4OgYlKk6cygXARYjwsKwqZd64hI8wIiZLpekEDO4U2eB5XSTdnQ
         iUWtvugrfGyM1u5Wb3s3J1vGpDvvWMdAxfxhypdR1leDF8XqxvH/fF5fa+5JbN3CIo8x
         f5fapcYLGbSCPuTDomM1A5xrxphAj2X2MUN6TOPNyZnhun78yRhDe3zGcz+sQiGDw+Kc
         SXcOVu3Txhf+n5VcGg58Ote2zLjS79X9SDqKPWAcErKRPloNHQvgAa59cICDhzlnTzAO
         CXVR3VKO/CSPIj07keG7h2fGpVtNfa+8elWsRa19etSvSwNJaBJST+nOQus2Yp23UImE
         lIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730015649; x=1730620449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWickdyVmCsECTe9uWE+5e70fKgYSzHKZqcNgghgJWE=;
        b=tru9dIxVFZ08wxZKa7Uf2QB3qG/HeHLTpgEMJNPecbeidg0CLfK+eVQEmgHD8tdoeR
         PZivJrD1dDCJm5Mpxqk3xu+GpC9NHrORZSnb2uOFzv3aVZKf+WYWD04gZ81olBkIZHSU
         oTb8YHx4e86QU8cQSO9iFJ4ggQAAR0FS5hdbVG095xjfDBFwZdPevh+ay+b3SHeta+b/
         tozHdcvWZiwTAOOZCbg5cavcU8fQySeJvCcRmPUTsNXue1VzB+f6AgKgOUdfz3YykfIl
         B/Gec7kA/5P80z1a8ZZBvz/+/0LS7Zsi5dRdPurMzFFsa93bqmvb86UnZe7m4XDZoe12
         nl6A==
X-Forwarded-Encrypted: i=1; AJvYcCWKEhxAGc6paXzZt+TWRXYhHCTEX/iDPl630JU1TWc7qPg2n7NURZ7p6eyvNU1Wd14fmskpd7VnZRbRTN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwuuWTX9u4FTbyxo32/oinw26BPaZFItslhjXWQKFGyp8q4PlU
	7+3wOHvjtPBJLeXXA6iyGnE13Cv4BbzHFRXeiczFJ1CH6w0c4wuX
X-Google-Smtp-Source: AGHT+IFx3Mxj2UYdS6rcKUmhPqMKikjEiuq8NHR0Aq8wItg1uU6BpL7wNNtVlEM1eRsgtZFqMDZwlA==
X-Received: by 2002:a17:902:f790:b0:20f:b54f:400e with SMTP id d9443c01a7336-210c6cde236mr55853975ad.61.1730015648938;
        Sun, 27 Oct 2024 00:54:08 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.lan ([2409:40c0:233:2700:b026:7bd0:77f6:16a6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6d311sm32282135ad.81.2024.10.27.00.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 00:54:08 -0700 (PDT)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org
Cc: greybus-dev@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>
Subject: [PATCH] greybus: Fix null pointer dereference in gb_operation_response_send()
Date: Sun, 27 Oct 2024 13:23:04 +0530
Message-Id: <20241027075304.7301-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue detected by the Smatch static tool:
drivers/greybus/operation.c:852 gb_operation_response_send() error:
we previously assumed 'operation->response' could be null (see line 829)

The issue occurs because 'operation->response' may be null if the
response allocation fails at line 829. However, the code tries to
access 'operation->response->header' at line 852 without checking if
it was successfully allocated. This can cause a crash if 'response'
is null.

To fix this, add a check to ensure 'operation->response' is not null
before accessing its header. If the response is null, log an error
message and return -ENOMEM to stop further processing, preventing
any crashes or undefined behavior.

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
 drivers/greybus/operation.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
index 8459e9bc0..521899fbc 100644
--- a/drivers/greybus/operation.c
+++ b/drivers/greybus/operation.c
@@ -849,7 +849,13 @@ static int gb_operation_response_send(struct gb_operation *operation,
 		goto err_put;
 
 	/* Fill in the response header and send it */
-	operation->response->header->result = gb_operation_errno_map(errno);
+	if (operation->response) {
+		operation->response->header->result = gb_operation_errno_map(errno);
+	} else {
+		dev_err(&connection->hd->dev, "failed to allocate response\n");
+		ret = -ENOMEM;
+		goto err_put_active;
+	}
 
 	ret = gb_message_send(operation->response, GFP_KERNEL);
 	if (ret)
-- 
2.34.1


