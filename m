Return-Path: <linux-kernel+bounces-418700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C399D647A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBBC280C11
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED051DFDAD;
	Fri, 22 Nov 2024 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8xRwbGW"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D398412C484
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732302791; cv=none; b=PoBsd2+NZmGqZ6kKtuOBYYYak+HvFFaTKf2GU70EyZJu9pTOPWyCLNz3d8P6E4ubsRmKWQ5QRUP4JFHmSCGdY0yOY15A+UxKJ1oi1zRwHIXFUC43YsCEAhvVVuBKtUrBdd/2HiyCpjXQZinErni9WMQcEJZC6u61RV8PjN8J9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732302791; c=relaxed/simple;
	bh=FFXzxJCPETFdsXpWIOyOnfVOEgAq+wBEZmb501A+S9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wd3o1cIZT7OvZc+RFHcVzEh5+1r4YqEmRYK6/zorp8K5tIZoA2zUC78R7f0Cpdb2UKLpisjkER1DSma4bYu+vxIevdpRjRwOU8vTZ9WNEGUOlCiF/PL4PAnmY36UszhuMkyWMiZKcNlW5AyDIlm7uSZAKlxFK9mf1QGFDie0r94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8xRwbGW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3823e45339bso1915966f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732302788; x=1732907588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdqLgPrEIWQNDvWMpf12KJA3H6cLevTc4f34wbV+nIo=;
        b=N8xRwbGWr5hgLAnLrYgjE1VDbJi8x+TPbklGg0DcawzVxVpVYX9J/WxjLlCPMK6N+E
         6996Qt6pD3PD7NSvxAIUt+PYNSBbmnHvYRDGBgt+gYu0lmZOwKdbII7M8OWjmhmfDnFF
         +YHVjWJDOf3Yh+5ulrD81iIpha0IpZpIaAjFDVwVDosH+HSXdQwbZKZJicKuw8C6vCZa
         e5CHKTnl+Sqoay9ItcYP11kqA++J1RyZ/GVSIkjFKxxSl9FKXyPEOO5d3Lssz13IO/Qd
         4yhIO01SthCfgnisXUamMUV7cDCgl2I9mRMAjmFzBDSQ3dkGH9dW6pjDVdblYAMngS77
         us6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732302788; x=1732907588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdqLgPrEIWQNDvWMpf12KJA3H6cLevTc4f34wbV+nIo=;
        b=mpB9NlAPndmEuCJxp3nTh5jzg/+azWRLkMM9R1N6xZI2JpHI5bUKlvuxYON4Y3zwqd
         g9VTwBCtS1t9xfrSCUb72qnpwZTPZlwUKzeURMAo5rqGeFM9mixFXwDNmExyUyIPqAp/
         FJu+hJUuEYG7giZtLXESWqu6jDIiQB0LNXYdF5iwq+aOULLijxF0VvNfd9uPdb/PU27T
         g0qMWy1+WEtsvuG9t1dpnaleexqUzm4z/IO3uVWAsZZ1imlyeVtthya/xUtn1uoYK6j6
         REpCxSUvCcKbZavVIYM+3r0t6cEavsTzczyAZvOX4aSKpEWDkKwftWOcAxHnE/MJQTwv
         Y3jw==
X-Forwarded-Encrypted: i=1; AJvYcCWrq/U/CZGke5Z9p5846OzJKdiydkKhtC9SJjH7NUBw2k0qyzBY6rq5jD/ugqSp/+D6OroW/YNajkfLl30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuxko3bwVC2odwzAaKp2oZ2fT0nTHqJ94mFEnDKC6CNgIPsg3D
	wWEYpTHedAV1vu9fa2Gjaw3FBeB5g18MEms1lTAbsoEqN2o2qvig
X-Gm-Gg: ASbGncu8WYOmzUAap2WMNMySEJygLBKLLCjrCcmxktMmJMeUfX8jvxv2HSv7rvMWRG9
	AyLco5InUzDJ5pfV89zZubhni0AbfyQAmVcB2Y1318lBJSrGvPxTtz5MZz3hvD6vEvo0l1DQH+I
	+GpSypoAm1D+2/krNlKfFJT+4YGYEODBcBUDHurdBuN2X8YvYMEcAGpgDS7vTna4xZI+Qud/Sbe
	fC8Dg4wdHyS2f0cIk80noW1Hz38NwMq+jnnurwx7kcHbRMjd+J8JrumXFNxbQhpvxjmyi6eLWDP
	ikM=
X-Google-Smtp-Source: AGHT+IGIZxV6ElpflFneYyLbkKrb+i5yzmggkxjVYzYLcjY4GLVsFTbZVB3ZGbMkKzd1RKTYOrZIQw==
X-Received: by 2002:a5d:6486:0:b0:382:383e:84d9 with SMTP id ffacd0b85a97d-38260be0ad3mr3289262f8f.48.1732302788076;
        Fri, 22 Nov 2024 11:13:08 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d41af2esm1196320a12.84.2024.11.22.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 11:13:07 -0800 (PST)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Tianyu Lan <Tianyu.Lan@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [RFC 1/1] swiotlb: Replace BUG_ON() with graceful error handling
Date: Fri, 22 Nov 2024 20:13:04 +0100
Message-Id: <20241122191304.4182642-2-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122191304.4182642-1-bjohannesmeyer@gmail.com>
References: <20241122191304.4182642-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the BUG_ON() assertion in swiotlb_release_slots() with a
conditional check and return. This change prevents a corrupted tlb_addr
from causing a kernel panic.

Co-developed-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 kernel/dma/swiotlb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index aa0a4a220719..54b4f9665772 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -834,7 +834,11 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 	 * While returning the entries to the free list, we merge the entries
 	 * with slots below and above the pool being returned.
 	 */
-	BUG_ON(aindex >= mem->nareas);
+	if (unlikely(aindex >= mem->nareas)) {
+		dev_err(dev, "%s: invalid area index (%d >= %d)\n", __func__,
+			aindex, mem->nareas);
+		return;
+	}
 
 	spin_lock_irqsave(&area->lock, flags);
 	if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
-- 
2.34.1


