Return-Path: <linux-kernel+bounces-512354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33318A337FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9383F162A41
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A13207A32;
	Thu, 13 Feb 2025 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zui295ws"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ADB8635C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428309; cv=none; b=CGGDHxjEZUjOXVr9SuMlVP/pSJ8Co3YEmIRwXdpKAoYfl3m7e/CPq5DqagNNIIHA+qZ5ZXUB8ne+cFb4Zf5fXwFTeini3lKkqoUgSM6DupTW2wn21d2mNTL32FRGim0WFMQz/TY+cyUcVhVF+Fs5Ebeo/LzH/hXIHoYHV1/XyUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428309; c=relaxed/simple;
	bh=TSm+EhFKzQ+nmagJ+NpWIUWkYFzwrLV6u54VSh1bzrE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QAG9wArMgtUF9BUxozQFqnzvq6Z67gNjesw4Ypt9l0zVsnuRvgSkrjrLmnB60nxcqaEztVFXYS1YH9aR6clJ3tpPVE7at+0YN1S6DFh1/oQkWFwZ8sg1nzAm/q611icu+zb0RaQJwBs4Od0hNinWaO8gtxYOw0daOSUY37SJI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zui295ws; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5deb1b8e1bcso880458a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739428305; x=1740033105; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lN2Y2nwgj5zUTnrECdXbocmCWoXI6GrsrPx3j3TC4Yk=;
        b=Zui295ws93WTTPWNXD2buqZj+h98nk+ZKUPjjReH3vwTsDjRZFMZaPwPQvLSajTiAv
         JomKw74jFwMnPz+dAqvKkttjodB+baMP561AxOryUtrehw1zJ5Ob7FWWXjntnpafstFl
         LwUdkCM42isIwRjdXWN4HXNtIFZkkurnx0RDkZCES+iKm91ZigthbRK4EN2v5Axlidv7
         d/onpbbgPaR7JgnRHljLL7ZEPaegRCdEgpdUk2e+9K6cLG1NV50qXh/rLGsmekTlE57s
         Pk8DV2sqWghxRxh+2bB1YgDdM2Sl76O0cdbu6W2vOGJcy6aFhy6xByfnWxmCMp9zOdcM
         xpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739428305; x=1740033105;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lN2Y2nwgj5zUTnrECdXbocmCWoXI6GrsrPx3j3TC4Yk=;
        b=ir66/lk9vXV75tPu5RExe0jThvToEf7OKxU9bHgabJTPBCUj43AoUstqbvCDmD48cq
         5GmuKdb5UiaK3MfgcPK4H7+29Iao7USAhSqxwjb9NBZLsJRvdjH6xDnYgfC1Tw+ByCYL
         oSW9F5EPJFBBaNL/1Nx523Kw4mpjslcrjJcMZVqO5ZZFqFQQm/f9NiSdFCyy6sPEypm6
         Uf7JHzm3WAL2sKQ10Zgxfmro8D6BboqBonuFLInEO07lGEMzfqC25+BXmtWOj1uIsNUI
         Etu90yykJDA0GcTj89we17yd3zlsMePyMLgMQuJG1n4A3hs0Og4fbPGU+H85Okg1Ia6k
         Nmrw==
X-Forwarded-Encrypted: i=1; AJvYcCWrWK553214UGfsbr4TyP6ZhuyoHCbC/cxzecvpLs59YaTJ9JsHXeyCRC7WVXcBEHcCSWw4RxPdNR5Vlcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUWBbdIV+eAXeMF1qPUO09TyMxXB55ZRohC0OATRMI1tVhSnkP
	LwkUOELsZ9RXjri4ylObf1M6r0aD8+5wKQzGaTCsVhmB/Zun/uecXzhk5NR3UvE=
X-Gm-Gg: ASbGncvdjg21GYX/qu3LjodHFGUJkXCPH0QCwp1bzEybNZxvhRGRHP5GmR+UsQ7eJ9/
	U4pgMF/19ceS4I4Obxo9ZA5r5tpaD8T3cgw6c/Xl98gOWwmS5Kcbk4oImdauvju4hl8OyBGjXzG
	zo7y0H6njsAq5t/K0x+EETA3EWP4VyYTyGkyg69DuTOdId68BVrQeXfwVDJpzpsHC4nGTgmkGnO
	6p7vlBm4oHX1fYhg+d3VXFFoEZSke41blr/r4wPPerkRU/wbW6TxwjKGcO917F/ac5rmUewcOuK
	YTJmxONXRKBKA3cpgAij
X-Google-Smtp-Source: AGHT+IF4GmQVmoYV3tMifs3xYxMEmFp8h++H06hQyM0sB214aBjWO3g4Ojs0FH/d8ojvyeWMu3n5Fg==
X-Received: by 2002:a05:6402:5d1:b0:5d9:a62:32b with SMTP id 4fb4d7f45d1cf-5dec9d326b0mr1910867a12.7.1739428305096;
        Wed, 12 Feb 2025 22:31:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dece2880e1sm596423a12.76.2025.02.12.22.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 22:31:44 -0800 (PST)
Date: Thu, 13 Feb 2025 09:31:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2 net-next] ice: Fix signedness bug in
 ice_init_interrupt_scheme()
Message-ID: <b16e4f01-4c85-46e2-b602-fce529293559@stanley.mountain>
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
treated as success.  So here, the "return -ENOMEM;" is unreachable code.
Check for negatives instead.

Now that we're only dealing with error codes, it's easier to propagate
the error code from pci_alloc_irq_vectors() instead of hardcoding
-ENOMEM.

Fixes: 79d97b8cf9a8 ("ice: remove splitting MSI-X between features")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Fix my scripts to say [PATCH net-next]
    Propagate the error code.

 drivers/net/ethernet/intel/ice/ice_irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index cbae3d81f0f1..30801fd375f0 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -149,8 +149,8 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 
 	vectors = pci_alloc_irq_vectors(pf->pdev, pf->msix.min, vectors,
 					PCI_IRQ_MSIX);
-	if (vectors < pf->msix.min)
-		return -ENOMEM;
+	if (vectors < 0)
+		return vectors;
 
 	ice_init_irq_tracker(pf, pf->msix.max, vectors);
 
-- 
2.47.2


