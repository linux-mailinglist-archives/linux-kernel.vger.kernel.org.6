Return-Path: <linux-kernel+bounces-563447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20090A641F2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2661891469
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7024021A421;
	Mon, 17 Mar 2025 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xpmxTQMe"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321EE219E99
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193819; cv=none; b=VGSb2WGOX+2SP6RkrDQr7WGhfZEPggQsDulphQyOnmk3zxDbwLpXXf5DLsogPtmd6bDRoUVqEZvBzNlmZR8RaYxxUYcqK3FMKLjjQGm888lXIynXWr3OPBrvWz3bg3koodJZYhzuT+TmQ+8L7FXL584y+3mE4pR9pUEO9bXqWpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193819; c=relaxed/simple;
	bh=SAXd+tnqhgdMVTCsrjIAySmhK5q7c0gBaTWPfdUM8o4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qw0re5i+gM0kAJlrsnYnPq+vvtw+Cv1IwAQsXkOHKfj7Y2CWBL+YQpot0YEN1SDj1Lpn4shFOzZB0uJoBpRVD1qNFbR1CkhQJqKYYOx8oEpmx8sy0+1kCl/n/r1osbWuQMHqzGKQCy1JfGUxfMa5BoI8v6fRI1otISO6yYMyUrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xpmxTQMe; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso3671005f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 23:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742193816; x=1742798616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/vwN5dNyCUi97uHAKHSyt9c9XHXLZW11g/S5VxieqU=;
        b=xpmxTQMedA1hmRyqpUR7nncuexcqLzFdvXcZtDLDTVuRItmuxAHZ8yTASrelKsiUT1
         bOCb2HzPHzRnCHhXn14nxOMrly5U1XIVoA9IhwECSShWPURN9WzNWGfCRS6JO6EzybZS
         eFZPkse48mByEgqxDHHOlVW/AlUtwuzxeFrMj+pIR5qDenDgeIK0hSPcrOTlcKQ+4Qq+
         B59AnsmJFikhjyx5OVUuxXnR4w5452SypfFa1I4E6ffkZXtf9hb6lpK79aJzmMaPrMGx
         veudJrNEvdaklHI8VGffj7ef9YfIFOXevSXkfSMNMY5oOILqTqhpgRIPa8oJjmwDxvSX
         wXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193816; x=1742798616;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/vwN5dNyCUi97uHAKHSyt9c9XHXLZW11g/S5VxieqU=;
        b=MZtxiwJ2WAzZvlclPKmo9EgpDJ17tprnIYQfK7WRkx5uGKAMjjan55Fk20UkdG1Tu4
         7egBN9zd1cM662pU8/vB2e0VzaSWlPP+rB5YVYcYgx2Z4qxLnBewzR2a1zBk95IayzOH
         x3ZW64bj2DPfcwAJhQOv2xx3yC3MWe+N3F9NHENjZJy1RvPw3bz2Gj+YyFuCpSo3fL7f
         nZzddQniIOBK+sQylxV273qNXSzX9XVaPoZkEfGrXBpD4iaVZzrnHDei+7g5qe+kspFK
         5cn1h/Gff77zrjaQm5ZldZZKHa0OQewywEFZyB/t87tMmym/J06hGiUGWAk3Q6HZmhFR
         N2vQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4eQxZqK+1gfF2e6+1SFky6MAjzerDZLmCHOl6av7XZexg2u4V3+Xd2Aef8YW8FIUX7m4kqj0Vv2obNgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt72AjU4iXT70HURn8a4IaKcU2RMKAIsPmrerCH+NFOdwnlyU/
	FakRRtiz0YggkR1hoQR5oue5QqEDZJ+nV1Ogt2x8wysTRvHb6Og94jJk6GHN3Wo=
X-Gm-Gg: ASbGnctTwrpZ60LkmDqQK+bDT93jB+/q6525/ZNu1PfSkHq4eawRNPIHE63UJn9GCaT
	IlaywI6MZsUENDpeGH16qW6i8eBSjguODorl7ryhZ/QOZCuvXpXYGFaxIZdesbWoLj3XdLaWzWR
	iHoMzPQCvS1WicS1EH6svau0v674wpPkeTGeArVGpOdn6+s+YkbJWJDtJ2nioBNDoiH22MQe6ky
	6rMpMJUkrpZQqFcglN1YpIWb/SXNKjcALj/+YsTxAQhAQrontiFlpvNdy4CL6RJW89OdXPgtJql
	2WO/obVVAI9b+tvLEtC+3BOXWrmcZLQpW9XWW5Iu5j+9WJk96Q==
X-Google-Smtp-Source: AGHT+IHpbojnLnFsF4gaCO7LQYp8D156la7rfBOhhig4+j9+OQo9S59WfIE2bg6beTxHHhT//jo+xw==
X-Received: by 2002:adf:8b59:0:b0:390:f699:8c27 with SMTP id ffacd0b85a97d-3971d616b99mr8376465f8f.12.1742193816417;
        Sun, 16 Mar 2025 23:43:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c7df413esm13717850f8f.20.2025.03.16.23.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:43:36 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:43:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/amd: Return a literal in init_gcr3_table()
Message-ID: <faa7edf4-a757-4390-8226-2604ef6476d6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960a6d1a-63d6-49e8-890c-5e8a66e50c45@stanley.mountain>

This code intentionally returns zero but it does it as "return ret;"
Returning ret looks like an error path where return 0 is more
clear and looks more intentional.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ce2626801ddf..7cbcc4933c8b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2150,7 +2150,7 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
 
 	/* Setup GCR3[0] only if domain is setup with v2 page table mode */
 	if (!pdom_is_v2_pgtbl_mode(pdom))
-		return ret;
+		return 0;
 
 	ret = update_gcr3(dev_data, 0, iommu_virt_to_phys(pdom->iop.pgd), true);
 	if (ret)
-- 
2.47.2


