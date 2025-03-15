Return-Path: <linux-kernel+bounces-562390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7601CA62528
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 04:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A5F3A9BE3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AC3188736;
	Sat, 15 Mar 2025 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIGSpBwg"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91A3186E54
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 03:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742008173; cv=none; b=fJw3mYTYrnDSpYNDRgZQDl/hNFnUPWADJuy0CZvwplhjaGgMfy+kHxKOLSEDmoSj/7yv8v/luWHmKkqTog/j9DkXjwv43WDlz4Bvi4YUZsTR/wl4hMxT8egSXLtrseufiuwzXqa962rcbAu62jodo/Q5lBR0GnwcvJbAEK9JBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742008173; c=relaxed/simple;
	bh=sbIUUtbhKoqaRF1XiCfJiPMT1BQtiAUvE4BMli7XQLM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tLcT2sw84nLDbaseQWFpdPHTjOGZMEjQz239ZEp5gVzy/OCa+6aExspqRIT1TfyZHDrbD9vaUnSAFmWvrw9VC4q3150DHVD8FRtP2mRym0BpB+ci1LxKgFGiX6tFy5Mm/jB27WqYx4WAMtZFWPa+R008qash0ZqeUrx1Ooj+xGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QIGSpBwg; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff8a2c7912so466357a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742008171; x=1742612971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gak29tsjnPuV+z4b5bqPopzZmVyIubK7izsrv5a+gSo=;
        b=QIGSpBwgnN0pA/TVKscxKz8/isclD8TEJbFylnDZIbGsMcqqlxz1B/L1pMRDNYNS7g
         pMsBa24e+3iugQ8iW73F8pA+ZiBtTPDYS3vyD8xZfqSEyJvURMqvc6eF+HUZQdCixTvA
         w3zxJZN0ZkIXQ6sOmH7yCIBwMfMdFDbl/P4BXhdIuPv0cxeabb1b8dvhzVZhkgHKppQ9
         yl7OBJQp13Na00C2nuykeNpwh/wJ1a8yMwomfCfrPyq6AaKkom0xKip1X8+BTfj9OK/D
         BajiiI3SYlqtFBFEZYujkfWxZN2iawq9I1XIZyGBz3H6rsHehGIU9ak9sdH822PCxQEl
         mwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742008171; x=1742612971;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gak29tsjnPuV+z4b5bqPopzZmVyIubK7izsrv5a+gSo=;
        b=ryEil2OtpW4NZUTd2WkDhbTHRVIgy84hY2eIJ6gW675x7Q7cY2wFRpvdeUrCl3e7vw
         asyecmUj4JmgzEEJVL30e0CJDK/eXT7KKXZvgqMBe4ypwnyuOSY9+2+iUOrj79GB/NIb
         gKxEC/1xsLVsTROF8GLqkxkTWIIQRhNWmsObiAFe21YaN1q9riZo5eV2pGkzHLdxw/4+
         Qnr3gQmZ+5LgcLFkmk+7MEgeAl1075MTEYFIq/NteUAVMWR5Xq3FvxJwCtcEQlPaBtSS
         tGvGLzDtMRgVwV9PApC7M5QnqZhXqVzvz8NN0tA4AHNXtHM4U0maDWz6iqpFiU4Z0sXI
         YC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJEcfbQ45revmoK0AHAZ79nuejtqtvRHwW9ON+4gWuKwEWsGIxj/2gGW5K0lkOvaPgAokcdyHFnc09NZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG/75kEk91bERu8fLjQx4uZNB1VUlRBZeyi2hKpgmajktvGqDr
	tHMcTk0i4hruqt7799qk7kSAjJ9bwh4q/VGihnBVpflPB5k+C+cOjskto+8yUAPCGsMbPWslmnu
	iiw==
X-Google-Smtp-Source: AGHT+IHARToxIR6VtRmzurSAC1xRmKsv9pkDNgIgaOjeWW+naTGMb+8yOvOGBklnWsF0Q5GPNfNOFHtDSVk=
X-Received: from pjbdy6.prod.google.com ([2002:a17:90b:6c6:b0:2f8:49ad:406c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ec7:b0:2fa:2133:bc87
 with SMTP id 98e67ed59e1d1-30135eab48emr11511389a91.6.1742008170985; Fri, 14
 Mar 2025 20:09:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 20:09:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315030928.2373250-1-seanjc@google.com>
Subject: [PATCH] iommu/amd: Explicitly bail from enable_iommus_vapic() when in
 legacy mode
From: Sean Christopherson <seanjc@google.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Bail early from enable_iommus_vapic() if IOMMUs are configured for either
of the legacy modes, as it's absurdly difficult to see that
iommu_ga_log_enable() is guaranteed to fail because iommu_init_ga_log()
skips allocating the ga_log.

Opportunistically have iommu_ga_log_enable() WARN if it's called without
IOMMUs being configured to support AVIC/vAPIC.

Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/amd/init.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index cb536d372b12..05c568da589a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -931,8 +931,8 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
 
 static int iommu_init_ga_log(struct amd_iommu *iommu)
 {
-	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
-		return 0;
+	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
+		return -EINVAL;
 
 	iommu->ga_log = iommu_alloc_pages(GFP_KERNEL, get_order(GA_LOG_SIZE));
 	if (!iommu->ga_log)
@@ -2863,8 +2863,10 @@ static void enable_iommus_vapic(void)
 			return;
 	}
 
-	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
-	    !check_feature(FEATURE_GAM_VAPIC)) {
+	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
+		return;
+
+	if (!check_feature(FEATURE_GAM_VAPIC)) {
 		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
 		return;
 	}

base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
-- 
2.49.0.rc1.451.g8f38331e32-goog


