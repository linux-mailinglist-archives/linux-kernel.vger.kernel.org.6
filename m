Return-Path: <linux-kernel+bounces-413628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1363C9D1C30
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF87280F94
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 00:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE84C149;
	Tue, 19 Nov 2024 00:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc3H6m8d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58BF8F64
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731975580; cv=none; b=S2P4eOLupMSGMWEwjmHfYh7M+miqVHGQ60oDVtSzyo6f/bT4uu8zs70c4BsnSlpDnsu93mGA7A8Epz40oih+36kX+IYgo6Et3vM7d1tHXbWk7lNSvX1LwXZgtz7tPjcE67kLhVZlmmbq7SdMRunLs++ALOqXjb41H8ZBlURx5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731975580; c=relaxed/simple;
	bh=Bitr1y2JR87Mi0MkN5uuN6orB7x8ndsHYtU9A62KhJs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W+i1CiuQKauzcUa94QGo/MTfvJP1Mt4nZrCD02SDF9Drb6WBkNkUGA31b55k5yPuamtIEetwDwJdDU06xwPITFwcPN1BORosolDdZossdNaBvr+GFQVQXTZkRIy16DYMc1l7SNLo1EHF1qgvU3wLd6+NTQUFpgyuS2IBQNOzwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sc3H6m8d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731975577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=nl8ywQLjASF9Zz0aBIQ1C3qovRQpxOk3WPW3oNZTibc=;
	b=Sc3H6m8d7y5agCBZlW70ZHiImvO/W88xbvOVKFz210Fh6U9ZWzKBNy3HTlS2AABqfy5Pwv
	GfsJHmc+15Zmwh19lgo7PkrklvMA0FaG0f8PFEPQnji/72frgymCuTJFsNM6Px7lKZW9Qc
	MrGFgrCv6/VgpsmKwvIeoZtTLCobIc8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-XFuaW9rPMoW9R673VHcpFA-1; Mon,
 18 Nov 2024 19:19:33 -0500
X-MC-Unique: XFuaW9rPMoW9R673VHcpFA-1
X-Mimecast-MFC-AGG-ID: XFuaW9rPMoW9R673VHcpFA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECF111955F41;
	Tue, 19 Nov 2024 00:19:30 +0000 (UTC)
Received: from localhost (unknown [10.22.81.145])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5433E1955F43;
	Tue, 19 Nov 2024 00:19:29 +0000 (UTC)
Date: Mon, 18 Nov 2024 21:19:28 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH] iommu/tegra241-cmdqv: do not call smp_processor_id in
 preemptible context
Message-ID: <ZzvZkMKhwmJESpdM@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

With PREEMPT_RT enabled some of the calls to tegra241_cmdqv_get_cmdq()
during boot will happen in preemptible context. As this function calls
smp_processor_id(), these calls will trigger a "BUG: using smp_processor_id()
in preemptible" backtrace if DEBUG_PREEMPT is enabled.

As tegra241_cmdqv_get_cmdq() only calls smp_processor_id() to use the
CPU number as a factor to balance out traffic on cmdq usage, it is safe
to use raw_smp_processor_id() here.

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index fcd13d301fff6..3ea4369e838fe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -339,7 +339,7 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
 	 * one CPU at a time can enter the process, while the others
 	 * will be spinning at the same lock.
 	 */
-	lidx = smp_processor_id() % cmdqv->num_lvcmdqs_per_vintf;
+	lidx = raw_smp_processor_id() % cmdqv->num_lvcmdqs_per_vintf;
 	vcmdq = vintf->lvcmdqs[lidx];
 	if (!vcmdq || !READ_ONCE(vcmdq->enabled))
 		return NULL;
-- 
2.47.0


