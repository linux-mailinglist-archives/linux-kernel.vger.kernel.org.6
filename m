Return-Path: <linux-kernel+bounces-174434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6FD8C0EA2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24566282C44
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB8B130A4D;
	Thu,  9 May 2024 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0ipQ+M0"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A812E1EB
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715252538; cv=none; b=gHtCLIWU8edNo5O77UdPWH0AORRaqmLoRPOO792jcTnuYJPbcZU2+4I0vwFt1OpqiHL903wUyqds074KAgBiYHnyFONmgHo95ExbvW7w34bzKDLYtnEIlUykNK8BpNuzE9eAUd7VyrmsxkG7PXDTk6WUQOBBSl/Ni1/xl90+Mqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715252538; c=relaxed/simple;
	bh=A3vBu1+lM8pshELKRiGuf0seEpLOmb3b3ZaRgmMoH+E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Yz6RuVi5db0mgwvhTyl1uOF/BPryZPO7zZL2I6BiN7P8jabKRyvTQpUO1Cvxo808eg4eN+meV7JwXObQ+TNp2n46lyDG+T9avWXh8aOfJFMj/u7o6Z33EqYHL+aYKmVObh1cw8W4zevb4xEY3Bm3QgFvR4aRssks5Y8mxKHTtAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u0ipQ+M0; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5a1054cf61so170954266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 04:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715252535; x=1715857335; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wuXHAIfnkMBAUhyPZI5mP5lslC3VrOjOuRB2Uj+Zic=;
        b=u0ipQ+M028bRXeIQrD9VTjIUcpKypoWcwvZytkvEe20m3PhlnahU0VFFKoafBu0YSH
         eKxU8yUittAikxDKryt8jR6pfj6Jj2Mcr2jvnsTOjS2w1ek+qPM/7nmq4fIuqMBF3z3L
         Fi3FGF8KSFJmN2Yn1tzOyftxV1KQKfML3lkppohSyq+PxZjhwfK7F+Wt/9vR2dGI/Ve+
         0nj3gUcZsZJcAZE9Cg/s6fEEY43SX9Ab3mx4pAAS+yKDqf6RPQPVwcuQGNH5dx5K9iaU
         Je5PmZJGq1IIjjk0V8jvoFagZ7kdIbPm4YkKnA1KKRR29UC9favt7eOFhISL0EMHCJOF
         KztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715252535; x=1715857335;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wuXHAIfnkMBAUhyPZI5mP5lslC3VrOjOuRB2Uj+Zic=;
        b=pxlU005ecN/xSmrNBoTOtr9QTFC2iI5+LHf/8xzgmQUrUT8t/bnDvAehz6BpdmItuQ
         qd4zl+cDayiW0T9pyDgLpobc4KQRFU4eHq1PV5kKxcGjwF3CIe5mzl8RyCYWjVMTE5fE
         +c1ITvlW/LZVghqknl5+zwm/Lqld/wMHjw6fJwzcRqZ87obqijZYaHv0Y7yfm8PYLRZq
         fNSIfTqV1n7Tmb1+vqqrtr/fTYKw8KGPP08QOrycsMgxTOK0Og5OFiLCOnyi+WL40lQV
         U8ZAQUuFvmq9X33ztaLt4yvmRFj9ZHdv90K0a+RocHC0b7nlphVwzu5iFNLSnvAtl+WV
         UrUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp8Nf8GUceoBhxEGEHfT1TpFH2qBs3U808/Sjxxr8TwNyuC9yBI7CnHkPS4Nfr/VuZWKAuMOmqKDT32zwo7qEBqqGwHV3AQoXttDl8
X-Gm-Message-State: AOJu0YyMvds+vch7XgBUiSl3lMIcZDcf4+rjpumjtI77dQZsDOO+QW03
	eM1o3sYAx2XxyrLrvJRUq7PoXJrbfz/9zZyCLpRORrJLp60VWJ1rPr5fo9nOEhMSoeCplQOBBqm
	u
X-Google-Smtp-Source: AGHT+IGHxe72lWDhQ0aCoZ86yCgXcL/PPUZxUSmPMufSVnI5xrZmniOhMXjiFBMVNiepfD12ToMK2A==
X-Received: by 2002:a17:906:68c6:b0:a59:a2f0:ee51 with SMTP id a640c23a62f3a-a59fb9c6ccbmr432024466b.54.1715252535132;
        Thu, 09 May 2024 04:02:15 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17987sm60970066b.201.2024.05.09.04.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 04:02:14 -0700 (PDT)
Date: Thu, 9 May 2024 14:02:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Yangtao Li <frank.li@vivo.com>, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: qcom: gpi: clean up the IRQ disable/enable in
 gpi_reset_chan()
Message-ID: <8be473eb-65e0-42b4-b574-e61c3a7f62d8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The calls write_lock/unlock_irq() disables and re-enables the IRQs.
Calling spin_lock_irqsave() and spin_lock_restore() when the IRQs are
already disabled doesn't do anything and just makes the code confusing.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dma/qcom/gpi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 1c93864e0e4d..ed7918c8bda1 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1197,7 +1197,6 @@ static int gpi_reset_chan(struct gchan *gchan, enum gpi_cmd gpi_cmd)
 {
 	struct gpii *gpii = gchan->gpii;
 	struct gpi_ring *ch_ring = &gchan->ch_ring;
-	unsigned long flags;
 	LIST_HEAD(list);
 	int ret;
 
@@ -1220,9 +1219,9 @@ static int gpi_reset_chan(struct gchan *gchan, enum gpi_cmd gpi_cmd)
 	gpi_mark_stale_events(gchan);
 
 	/* remove all async descriptors */
-	spin_lock_irqsave(&gchan->vc.lock, flags);
+	spin_lock(&gchan->vc.lock);
 	vchan_get_all_descriptors(&gchan->vc, &list);
-	spin_unlock_irqrestore(&gchan->vc.lock, flags);
+	spin_unlock(&gchan->vc.lock);
 	write_unlock_irq(&gpii->pm_lock);
 	vchan_dma_desc_free_list(&gchan->vc, &list);
 
-- 
2.43.0


