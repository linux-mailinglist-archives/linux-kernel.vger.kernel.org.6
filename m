Return-Path: <linux-kernel+bounces-561260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89248A60F69
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D9D1789A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1701FCFF2;
	Fri, 14 Mar 2025 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/dulUEW"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175041EDA0E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949718; cv=none; b=Hx+bCjcu4q5hWnPqdQJVydIXl+03dBS/OOy2pkjvnMKmjN7MbOT1kNs7NYDNDU7Odtvq40GXpXlpVFAT+eBNAihiuJig8veNZAgPHKbey295LC1w8LZehpSbPAHtlDzYCZh74fc2D03/1n1xLp028JEmSpEWHWj7AOr1zEQUIzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949718; c=relaxed/simple;
	bh=ccFYrjDHawpi7ROYlL+jckLgHRxPsFrLvnEoHLaQLEo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hfiZ/ekkJw69FCnHkfo2nsvcoA90ZXpD+dLDfameGXDKQMgy0GkvFPzw5uT6YZbI56w369iQxI4pH9aJHmnBsY5LEirvyKK5o4PxcNgXlAZGMJEXT0XWZVBksJ+R+dFpxkyMRf17Srgb/aXyc0YSlMg8kRa0LOS3N4oZ/9ucHE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e/dulUEW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so1139570f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741949715; x=1742554515; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69QxnrDX+ARIIKroQoEvmFo1SyKWNr0b2to7TUKNckk=;
        b=e/dulUEWjQd9h0veqi38XinKvxBQAMOOAQ6TNia9b7rteouJl1QkBI8NtFqF2rVyJ3
         1FrLd/O97ZtVKqOxvXrJjyrvlFCSz98irBnQijikeWlEcJEBJxg/MhqOtq2nxNrKBon6
         tx5XcZMPiw5/FIy6MOn4I/sEE8/9ddcD8YBuwz1PM51+MTVdLLZKxQez+2m219qvYJGT
         pgfKDFnPgYXdMI/INZ9IhjuEhX0tjyfYl5SrArY2p9Eti84GXLn4T3sQTWyZ/up0bV3Q
         GRT+jO1IReHIOXo30v0DhjWW6fNHfUGb/rgQU21Of0zivriO56goaqnlnEOlCYB2+juE
         5/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741949715; x=1742554515;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69QxnrDX+ARIIKroQoEvmFo1SyKWNr0b2to7TUKNckk=;
        b=M6z2nGK/C2/mCZe1c77uPqPkPv2GNbSlIQnUW9IPJMdjLEINi74z7t6ZBCx/Y2nhTN
         9RVu08cQv+BenbFp2D5XwcuwA0wZSV6mI4edCxor94M9po1g8KaXynDBzBrl4daTZtlz
         7oXguouVlWB2WdXyUc0sUYhHQrPGGrvZAw4r2rt6LCNNWEjGiMnq/zl+jRBycph9dk1R
         oPwu4iWcdIRAOJDpXtSdSbRRuU4Tyv7bzJ0K/n4jn3bxwclsNqUtWH0LQIMN0u2u73Gd
         2V3soZUPVfpd+PNqu9Ax+oI6I+Tm1Ta3LUKtNkyXJ2R+2c+4duEdiuunhN93WOZ8uKbE
         hQiw==
X-Forwarded-Encrypted: i=1; AJvYcCUDNgBX2YTtLEVFsA2RoYrgnwbzSb+/5HtMSRkAT+cZJVruK6XIhc1sMKTc+yixRSx3KQaG34E6T+m0o9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr4tgGMGnp02/CYNJxFs1GbUu4HR9cP+IUJgq+T2VC8AQhnkG4
	koctDbv4miq57RX3zrQCApxmCS6WsFK47M931MU9tc/qCOrdYbQHFeqNlIEXsP4=
X-Gm-Gg: ASbGncs4LPf8rvyCFh8pozWmShwTp8No+0vonWJpl7U3GCA83HJNnISknfqrEcVzUcz
	KGKiCI2eeE3/qPgXTnoQREZseJ3M8OCrBnQgWxrKXUnm6dZZjquHrN6VuqJFAe7WsSjTYZ3PxVm
	BXp81b5hzKz/hqvlO17DpgAJtt8DeZvvPj3FDvFFIMvv5zF66XrZhm0dPCsCS2irQEw2rx9ugpX
	q/IxjtyEedFzShEQc38Xjo3eGvKyd6cipAWp7mT/1XPBwzglJxXkbLoXMlBhIsR3YmRjBkzrDju
	CO9zupZ/enqvghvQubkX7TREYPmX1sJ1sO1rbdv6q09okdXmaA==
X-Google-Smtp-Source: AGHT+IFIUbmEzg8hVlyMnrgTdM6eNUAOtW5/W1qBKD80PS2iZfgCvSTaSkNrtRfyXIH2NLPpshVzkw==
X-Received: by 2002:a5d:47a3:0:b0:390:e9ea:59a with SMTP id ffacd0b85a97d-3971d03e612mr2341760f8f.5.1741949715472;
        Fri, 14 Mar 2025 03:55:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d1fe74f4asm8461655e9.1.2025.03.14.03.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:55:15 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:55:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jie Gan <quic_jiegan@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] Coresight: Fix a NULL vs IS_ERR() bug in probe
Message-ID: <dab039b9-d58a-41be-92f0-ff209cfabfe2@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_platform_get_and_ioremap_resource() function doesn't
return NULL, it returns error pointers.  Update the checking to
match.

Fixes: f78d206f3d73 ("Coresight: Add Coresight TMC Control Unit driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/hwtracing/coresight/coresight-ctcu-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
index da35d8b4d579..c6bafc96db96 100644
--- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
+++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
@@ -204,8 +204,8 @@ static int ctcu_probe(struct platform_device *pdev)
 	dev->platform_data = pdata;
 
 	base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
-	if (!base)
-		return -ENOMEM;
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	drvdata->apb_clk = coresight_get_enable_apb_pclk(dev);
 	if (IS_ERR(drvdata->apb_clk))
-- 
2.47.2


