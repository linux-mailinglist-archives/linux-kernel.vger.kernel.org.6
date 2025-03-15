Return-Path: <linux-kernel+bounces-562391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B6BA62534
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 04:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B6DD7A9C35
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31D18B484;
	Sat, 15 Mar 2025 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOi42XZ2"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EAD178CF8
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742008252; cv=none; b=gTJnaXRSlbvMy+n1PpUil+zxbOvcd/EjHEBc/Fh4+OlTQH+MekL5GmCBG8xH2bKa/Q2fERMjqbQvMfoXZEXRgTcIKDbKdGtlcX9ieJDHqeD9xt1c6iwvtqyWnYygzUr2tTWIHJX1wKV84PEOzbXP8IqWWNO6ww/rrBmzyyX5Z98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742008252; c=relaxed/simple;
	bh=OLizbiH//ZIur3H0hcedWvPa4Ex9i8tuAXKdIf0Ss7w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jZLlIC4r/6vpkqlzU0eUp3bMZ1RIaFPwj0ipC+c0KBVXPdLgOoSNTNwVC5nc4Y5P26MrXg/1WwPGc6U23LGCSuhwiN8DGyZ5jupA4rZW1m7UvZhYX07hj2kUgYSPk9blJ0R/XaIx8eSW9s42eHl39Ue5J6xmJb/dLAYJTuvTGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KOi42XZ2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-223d86b4df0so52422335ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742008250; x=1742613050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7gds+58q6+VRF9HZlaEhINqjYzInTmh9/a/W9pln2U=;
        b=KOi42XZ2u5uvi6nqRmvHASR8zDrMWjF7LB+fhH/t49jA5PgvZ5cvzFR/gk4vOwZn8b
         I50xzl6J4rEWzz41uH7sdmmy/ItKlOtt12h0zMGUNLmB7T2V5AsMLwPgIRkgRIntJpF+
         O1OpWzHsKfdvw5palZxxoWjWraZDiQD9Q+nkWBvxtkoqF/x+PqrrfNfZKJ+hLBXEDe8K
         RRzv2MF8DPsPdc3OO4cNEb9WK6i9ZYDiU3ODsw0ni81crkaq0+Sa403Hiaonip9lR9lW
         iYCtAEiLUZjKELvSNhxfUI275B6PaEWzpnV1YrRn8FsOlfaPY1v5olcbYXGPt1jTvFqD
         whNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742008250; x=1742613050;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7gds+58q6+VRF9HZlaEhINqjYzInTmh9/a/W9pln2U=;
        b=diaWk3jCHq72Zl/iEVYUl1UIduGznx/bHzNF05R3/QXyI4LGF0RHkrnkLDe5wu1YwB
         jPpG091LsPeNdKUtHqRP56+sOMN1NUwL0iheEawFytYsz0WRzdC05MiyMUR9vArQCpRt
         SfJd5KpwPReqbezP0TDwm/WO/3fafvqI353a8VhNIo4R260MRffxZUU50oXZ5zL4MKxr
         xBxiCE3JWUdxi+Y1LZPZCF5ZEu40e94iXsJkvg+BRdeHSaWy3HCI/leEFfzWnOhDitHL
         4c25HjjeDaTxJdTIOtGoxAjoUOnMgq04zcIHdfYaAkwos+hkGyXP2HpJdv0TThQPih8Y
         XI8A==
X-Forwarded-Encrypted: i=1; AJvYcCXeR3H+PgU+rYn4S+a4lXMkosjFF8JYl6bd1G43fPMvEyOEoSGtCOdToi1UDveLwUDJezzzBGES9lT2CKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaFcS3ohQKbIwLrqsU+o5rW35Nf42N62Qkrq+y/vjDWSstGdxL
	is5KMNx4lNjfsjBD3FCgenlF6AycqxXQwKfxpT+Tn5s+CAf4bE1c+KDLK5eFVhfNqj1jpVIsiaw
	GIw==
X-Google-Smtp-Source: AGHT+IH7AfjlFM7Z9PNPtzJaUSCYK7f83WWLXt8NM7UXP61+YAys7SZHeLCK+pprtrBAnSdJ0yquC3LZQhQ=
X-Received: from pjwx4.prod.google.com ([2002:a17:90a:c2c4:b0:2f5:63a:4513])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b6d:b0:223:fd7f:2752
 with SMTP id d9443c01a7336-225e0a954abmr60595725ad.29.1742008250480; Fri, 14
 Mar 2025 20:10:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 20:10:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315031048.2374109-1-seanjc@google.com>
Subject: [PATCH] iommu/amd: Ensure GA log notifier callbacks finish running
 before module unload
From: Sean Christopherson <seanjc@google.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Synchronize RCU when unregistering KVM's GA log notifier to ensure all
in-flight interrupt handlers complete before KVM-the module is unloaded.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/amd/iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b48a72bd7b23..b314523d9194 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -982,6 +982,14 @@ int amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 {
 	iommu_ga_log_notifier = notifier;
 
+	/*
+	 * Ensure all in-flight IRQ handlers run to completion before returning
+	 * to the caller, e.g. to ensure module code isn't unloaded while it's
+	 * being executed in the IRQ handler.
+	 */
+	if (!notifier)
+		synchronize_rcu();
+
 	return 0;
 }
 EXPORT_SYMBOL(amd_iommu_register_ga_log_notifier);

base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
-- 
2.49.0.rc1.451.g8f38331e32-goog


