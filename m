Return-Path: <linux-kernel+bounces-565116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECE8A66134
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28703B96AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB1E1F585E;
	Mon, 17 Mar 2025 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="digeJQvr"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952111FAA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249179; cv=none; b=XeYtE3LOtJEpQ4a0qEzYooZssawqqAZee+5gB4meCUBQRnBsAkBUpvPKkbDyRIFd9NjHjrUFR0PUIO2iLW8fBpeNwoIskR8wXq5K4eVqUGQ6lFvFfuU2/G3iZKbXHyDLmx0xYi8purHamozg234wkO0HsYb+y9ejfuBOKcOvcRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249179; c=relaxed/simple;
	bh=xtmNQAmiddO9PfxnK/vdLxIDc9tf8hJV8/EuKq1TCm0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tStjUa2kSmoT+qQivRChRHJUFpVCuK6XJBqQxE5WMiontDMHHsFRfPLNbajTL8ZRxINp7KwSEwD0pseEkZcMun/kZZmISk846xo2M9QOIJwpvY3Hn8b9fg17ey0i8VQxdRGznim6iR4XMNkRbBtHYK6Xf6LxP1u9w62QeBOoyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=digeJQvr; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2c12b7af278so3468603fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742249176; x=1742853976; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8dAYBGS5lFqHpqqLaiZQj84sBiG0WpKfeLOq4SIiUc=;
        b=digeJQvrZM6XaT+cIa7PNlxs10nlv2zfz8W+OVUVflh7+MmxGfVKaUzTJZVy0Urf3B
         m4NFM+vHYX/b7GcZ5nuem1ctWsRW4UXPvs0HH0N92enll/ym6FlVz42e5E40FEIvFsbf
         geiIsPgI/BmrsKNXYUCKASMIpi//Sbp1/yld8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742249176; x=1742853976;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8dAYBGS5lFqHpqqLaiZQj84sBiG0WpKfeLOq4SIiUc=;
        b=YUV3UBuo8reUWFbyvTuk1Fn29Y0HCerIhnB4ORxrFb56SnXJdQRWNmuHMKO8zOMS7W
         ct2MP2DejxHOZmafqeonu3NMpSN7ocqt1u2KqaAMVegJP252b42f8T8yZ0TMxdiUxd5m
         30O+7gThJiWC2lc5aS+xxX9CX3iGsKDOrNe1Eam5HFrfskJqfNd+BVQETpuMChGFghDe
         NEL4QTGAzl05ldhp2z6/3HEV/puDfS1eKgIE5diTqZuxePcP9k+jn/Z0Xv78MV2kBzzF
         /Xzio7FnZaxIVy7b/0TkVjPBH4FocUk7wiMUXi0GC3Wzr+vtGP1dKYYEoKd528+DXSgr
         L90Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFH8Pj5Xa8X2XHaHpiMFKXouBzT6VISedxr5CyrXCEyHwBD1pyJnflCSTVDajQYA8RNYsDIK5joUa/N4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3QZWiCrdCC2Xa53eSd2w8u5Y7q3iFRUqTbZ6XCG4tGctPO5wz
	wPnl7w7PxG+NlyvtkNPYtOQS9flLHGmIe7vI+0PgI2rYEOyjHIJWh3QEx/Q3hwM3z29DOT3bHsA
	=
X-Gm-Gg: ASbGncvdmYbyrX8AAGNCDdqoY0Wrjp5T+n/pLXIEfouiSIpVXTBkiqX2ZSyhpH0UdqI
	OrJKg4KttX4OH2TEpLE/x7O3uoJs80N9Jl4MxvW1JlJfpiAMt8mlGiuVTgh2mD8TfftpxbmArJo
	ag9m9AiqUky4+Sl2DrcfDEhAfuPAkVVnGX2iVt6S/B2cuMAYsWds+1cQoPjbDXmGEGyMbTcZY0I
	0etRalrJkTJRgYoyh58X+eE8HYo3EzJN0cq9YdXUc3TRI1WLADTmE4iIl86ipvu+lNyTN/gJfbl
	HHHT4YdCnfkyDdDlfIkrmRxAC47tuv33Llv9CwbEFxoA7l5b1BRAQ3qeUnxX16gx7H1k2sDaSlH
	fFAM0NM8HP6mhK84=
X-Google-Smtp-Source: AGHT+IHnaexVn+wNtEptwMdzRuUiiapR8scruXC+PY3z3bzwyGdHYiE4KcGEWLneAJxno4ExoIYhaA==
X-Received: by 2002:a05:6871:6011:b0:2b8:b76f:1196 with SMTP id 586e51a60fabf-2c71a1ce256mr601829fac.19.1742249176621;
        Mon, 17 Mar 2025 15:06:16 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c6712e5774sm2311980fac.31.2025.03.17.15.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:06:15 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Subhash Jadavani <subhashj@codeaurora.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	Seunghwan Baek <sh8267.baek@samsung.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH stable 5.4] mmc: cqhci: Fix checking of CQHCI_HALT state
Date: Mon, 17 Mar 2025 18:00:45 -0400
Message-Id: <20250317220306.44646-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Seunghwan Baek <sh8267.baek@samsung.com>

commit aea62c744a9ae2a8247c54ec42138405216414da upstream

To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
bit. At this time, we need to check with &, not &&.

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
Cc: stable@vger.kernel.org
Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20240829061823.3718-2-sh8267.baek@samsung.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/cqhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 10b36b156562..ae9c184ed898 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -580,7 +580,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 		mmc->cqe_on = true;
 		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
-		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
+		if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
 			pr_err("%s: cqhci: CQE failed to exit halt state\n",
 			       mmc_hostname(mmc));
 		}
-- 
2.43.0


