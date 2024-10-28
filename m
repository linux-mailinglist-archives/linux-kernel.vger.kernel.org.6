Return-Path: <linux-kernel+bounces-385448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A609B3750
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9AC2837DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FC21DF745;
	Mon, 28 Oct 2024 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMgcBQAq"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87091DF25B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135156; cv=none; b=RHbrqA3rhwLk+u/BFcnZVx86QuDXxjT9S6ewrvNpf6oCITO6EQitVBijW6ZI2KA1eeIhBxpBWAd1AOdgqstDHo3rI9wTToeL9JE4z4IvkS9G+cIIJu7svkUDXCQZgH+/4S1DRC0+jxKJNka2j/0X1rtcTX5dA5Jk2J8zy6XznLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135156; c=relaxed/simple;
	bh=qf4BASZOO83+U0eaTzV9hGsXGZDbSGzCe04IvJPCi6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3ob0ksIMYb1aHfH7vmHxf5WayhFlYYZgLgZMTF5R5L1BxFvPR67BbAWf488ClsRwbMlamohjVG21mHY1UNzgUGWvM7fwkiIN0Z86Ntiyqx/CCLHRe43OfsoL94MajwLEmapMrbsB78hdqMkbyRaWFC5Az+oI+HLBNO930y6Q+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMgcBQAq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d49a7207cso3259573f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730135152; x=1730739952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/k4PyykaU7zaHMCv8bUR8FdZQ8YmUwD9IMewLudEt1g=;
        b=DMgcBQAqDB6fvQytH+JMtSIGarWq0bQOHuu9R3CHsiAK00B1DjpipdE7uozuXu9ACG
         YtpYB+qF5UQ+LuMqsqLhgFcvjhPzeaiOi0ITe3qoUjHPDo+RjRtpcseuZ/L354hA50mJ
         vNP24PoJq5we/KbYQc41ynKaFBVN0SdWPVf/QXbhHHg1Dc4xCZN4GHAWuMV0I4zmrlJO
         7T93JL8XCo5gO5Mo/cTtjnNLJnln1Cp0uc1xKWxTtJ+VXDTAselcjPqEKwNJ0zLOb1Df
         lL1qGUSblMjza4GuvmzqvIXduyDEVeraJFbEDmMx8duqy+k6OSwePEBqPWVjTjwzxR3E
         QEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135152; x=1730739952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/k4PyykaU7zaHMCv8bUR8FdZQ8YmUwD9IMewLudEt1g=;
        b=kyr4KG6L8rSrl+C/pS9NmJzBcqfPE6f8Ku7nKgROfsA8uSjsA4qdZapElktM1RQ3Kx
         1oZG51mW+tuwQyMOFUrZwpb//2iXGNGTVpBp59Edd6+keOtzzJiD30f1hcHhBgoHn8XZ
         mhDkQZ39SAcHXFtytQDh13d7JtnN8QCN2bR7VPDl3ArDLMJoVlSIDt/24C/iJf+d5CRJ
         B7NeyRigmeWAJAjmbdP1fU7rsQjKYnJpm9d0zQHtZ2m/FzplOHhceuXUq1XAA1WiPXd4
         tJ0sLjGs/FvhMr4PojDVMkLkWJ8LGqW9JrXq45zNYxKzPAwI2lDzd/drWWr7BbDYEe7l
         YiPA==
X-Gm-Message-State: AOJu0YwYAm3NJfkcUuT4mMIk8UFj3U5mx8uDLtyMDoM1k6tAlfOmflD0
	n8tC+8hs4FxDenR6Wu1fA2lOGxcW8E36e0Kn2BXHinqbHpShIeF/
X-Google-Smtp-Source: AGHT+IEO9RH4Pja0bIJOCVClRCSa7kNscMqQ9FMgJVqocrKK6txwmIFHj6x83Pf+m+y3/nkcuKwUTg==
X-Received: by 2002:a05:6000:10a:b0:374:ca16:e09b with SMTP id ffacd0b85a97d-380610f448amr6371751f8f.9.1730135152211;
        Mon, 28 Oct 2024 10:05:52 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b273-88b2-f83b-5936.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b273:88b2:f83b:5936])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3be78sm10097655f8f.31.2024.10.28.10.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:05:51 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 28 Oct 2024 18:05:42 +0100
Subject: [PATCH 2/2] virt: fsl: refactor out_of_memory label
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-fsl_hypervisor-of_node_put-v1-2-dd0621341fb7@gmail.com>
References: <20241028-fsl_hypervisor-of_node_put-v1-0-dd0621341fb7@gmail.com>
In-Reply-To: <20241028-fsl_hypervisor-of_node_put-v1-0-dd0621341fb7@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Timur Tabi <timur@freescale.com>, 
 Kumar Gala <galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730135148; l=1333;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=qf4BASZOO83+U0eaTzV9hGsXGZDbSGzCe04IvJPCi6g=;
 b=god0/YyyCqyX14l1T5+0D7+BuDPG4AgCZoVV/A7h6cWARfbbatBZLo2ps9D8j/vI4WN0oI5P/
 wBF8FVvc1j8CFnwqsKdBRGfRs07cb1K1pB/o3hY3hLpiNqudSqGoCaJ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'out_of_memory' label is only accessible by means of a goto jump
that only happens once. Take the required actions right after the error
happens, and drop the need for a jump out of the loop.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/virt/fsl_hypervisor.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index 7c7ec13761ba..bc5d7aa246df 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -848,7 +848,13 @@ static int __init fsl_hypervisor_init(void)
 		dbisr = kzalloc(sizeof(*dbisr), GFP_KERNEL);
 		if (!dbisr) {
 			of_node_put(np);
-			goto out_of_memory;
+			list_for_each_entry_safe(dbisr, n, &isr_list, list) {
+				free_irq(dbisr->irq, dbisr);
+				list_del(&dbisr->list);
+				kfree(dbisr);
+			}
+			misc_deregister(&fsl_hv_misc_dev);
+			return -ENOMEM;
 		}
 
 		dbisr->irq = irq;
@@ -895,17 +901,6 @@ static int __init fsl_hypervisor_init(void)
 	}
 
 	return 0;
-
-out_of_memory:
-	list_for_each_entry_safe(dbisr, n, &isr_list, list) {
-		free_irq(dbisr->irq, dbisr);
-		list_del(&dbisr->list);
-		kfree(dbisr);
-	}
-
-	misc_deregister(&fsl_hv_misc_dev);
-
-	return -ENOMEM;
 }
 
 /*

-- 
2.43.0


