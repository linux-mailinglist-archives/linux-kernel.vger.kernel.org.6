Return-Path: <linux-kernel+bounces-511360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A551A329EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5F73A53CA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348961F94D;
	Wed, 12 Feb 2025 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVt0IQ3F"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EB72116FC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374036; cv=none; b=cnnA7o1QZuEmuoCGYIJD2+9X2JcIYXYBQeeMgjYencSCMtTsGp7JqADf7S6S5Wh5U+2cYxwQs9xrf0BzEGZeX+VftBC9FwR+QCZGdgJ5xkiQBbed710wSFYe34l05KuKg6UsMRCB4IQP+3hBgVMPTj0ERvR1ET5vqkCW6k31aEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374036; c=relaxed/simple;
	bh=vT8V7lsGJePHRPxn1DhEuL1JPbBPo0A5217Nn0dXSCg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bM6QXVFGvRfOix4yLuHVlFCotrARngB+ScN07cwB5zX9vDGHCtJ0kh3gHtyNX4MwrWiG0akd13ZNY8soF4cIfhAM055gobkGplRAc1UkwRQup5MGU9wenemJkSjdjZUwyFzhw7EnUnDWx6LTBbwABuwb4GQretUS2t98mAIOEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QVt0IQ3F; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so1055551666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739374033; x=1739978833; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+v2zlsZVCTCaFO8Ecu0yqe/8KFXTvc0pR9tUkdrVCUw=;
        b=QVt0IQ3Ft3T0kCZkeUUozt3rj0FoFWoSfRDDmny5D0E7rwGBcb6VeIochAW4QcxtPR
         L1AAAq54QeuB+2Ivwd4/HYiZ6Agv9CsYxwdNptp3t+sZqdqHEKrE2Z/wYc+IOk7Vyc2G
         pAvL8oH5A48OvG6nkOlxjWekw7iT162EuIazbBGk82YiNheSWKMc+YQ0+rRvc01UEDXw
         CLFd5L6Y3uzlcDjKXV7f0rOBJK3Fsdj2kviYSlOAi2MCOFVxgfMBQecIEYlBPeDkC89D
         zK/+brhhq97slXHm5ea+6dH+pKDnpGNLfS02xP4oYyiwPuJKXTe0yhwK1Kcn9lmvRKzR
         PfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374033; x=1739978833;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+v2zlsZVCTCaFO8Ecu0yqe/8KFXTvc0pR9tUkdrVCUw=;
        b=iFcRXQmcIKqjl2S/Ldq1U+Ruw9j2GDUABrqYCiLYnWz01WA2JA3B0YpQq9fDblnlVw
         UO8oXCOca+w71rpONmiJ/9+MfNulXRWsqilNfyME5MOcUVLGk/u9NbTiccj7Z/v4dy5s
         gfYEH/ficXadrQYs+8Lde8+9zY11G8sHjNp1N8Hx8ikDr0nd/9vs2//UP3naoxM5hzRc
         WwnnU7xISBhxsp6wJ2ly1teYJQWG8+Vev1d2IqldHcHL1t3U9oRz6qckQyIIeiavAQuO
         wfF1SNSIisXr3HtB55azsI0yDCqj+yJBNu5SGnXH6itg0fIXbc20O5xYLkMadP+9lNrL
         Zxbg==
X-Forwarded-Encrypted: i=1; AJvYcCWSZeL8SlRj0gFvN4fz8SDoHqgZ7ibRa6CvtUgKOXsn0VTEFo3ExVuZXscMxE4rXE1dii0Jpo1vocSIyDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNm1Rmb/Zkm4c53FdcpUEzFwuzEs7VlTv9UKPJZxzAFOzj0+42
	4MzNkWYBlwWG9IQqf28Qvo2DuSCJzfBDUBwgg9seUd2bBAOrfL807hOXveAGLoU=
X-Gm-Gg: ASbGncudVorfrY+ef7lLGYFlWlYwef5Oy3hpFcULHlVw3ZISyY6HzlFXgkjlxpdjiMc
	hhPGUS7EGax1012KOdvZW3FplWiyWH0LPCYMChcq3JY+zCFEZga5+qACSHoZWO+tbBxAeU/HPep
	m9SIjC2s735qGyj2H74oqPhzqSX30l9RV/UEXaxNyph7b2KqjJZ3gwqGzZRsoOzUjoGil+5WNM2
	prl/yA+Y79BvtBNWn69g8dRbUBOhxb/kVqLsnO11/NpZjiJARAiryILsmRMYqePTBxzUeF3w5lP
	b62qOHARb75uDDu+Viw1
X-Google-Smtp-Source: AGHT+IGudd/dN1L+NiUERa8stm+ICSFlfU46rMuNR2Hncaq6Xkixith7aRyVs5EP4RRtpT5jd1UaqA==
X-Received: by 2002:a17:907:7e97:b0:ab7:b826:d84e with SMTP id a640c23a62f3a-ab7f338113dmr293815266b.17.1739374032574;
        Wed, 12 Feb 2025 07:27:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab78e3e212dsm1122175766b.147.2025.02.12.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:27:12 -0800 (PST)
Date: Wed, 12 Feb 2025 18:27:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] ice: Fix signedness bug in ice_init_interrupt_scheme()
Message-ID: <14ebc311-6fd6-4b0b-b314-8347c4efd9fc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If pci_alloc_irq_vectors() can't allocate the minimum number of vectors
then it returns -ENOSPC so there is no need to check for that in the
caller.  In fact, because pf->msix.min is an unsigned int, it means that
any negative error codes are type promoted to high positive values and
treated as success.  So here the "return -ENOMEM;" is unreachable code.
Check for negatives instead.

Fixes: 79d97b8cf9a8 ("ice: remove splitting MSI-X between features")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/intel/ice/ice_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index cbae3d81f0f1..b1fdad154203 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -149,7 +149,7 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 
 	vectors = pci_alloc_irq_vectors(pf->pdev, pf->msix.min, vectors,
 					PCI_IRQ_MSIX);
-	if (vectors < pf->msix.min)
+	if (vectors < 0)
 		return -ENOMEM;
 
 	ice_init_irq_tracker(pf, pf->msix.max, vectors);
-- 
2.47.2


