Return-Path: <linux-kernel+bounces-371389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7069A3A77
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547781C20EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97360200CB9;
	Fri, 18 Oct 2024 09:51:37 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70418872A;
	Fri, 18 Oct 2024 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245097; cv=none; b=N8V308NYmX3zNm5ITldZ+Vyu7tZEi9rsanIwjuSqTGS8GNJnMawCgBEja5ErlWJuBtNu3uucZz+OzSdxdu69J3q+cGVtESO/KeBUAa/K+X7E3CKXxctYBggNaXsLT8E06p5eNtLOT8lgbOAhOpatzHetQR1IiMV0TyhxjDO3RU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245097; c=relaxed/simple;
	bh=gJoHP0XRF5M6vDw9vxRUCNkJcFkEWnQH9xpW8Ae5H6w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VS1VI4ydqGy+gKinAdeiPmkIZhhGZGEQjySOGTpfRVML88j9//5rlYpAty+CmvyAatU5AkeCrVyWlr42KQtYiqJW7vxwMFCDJvkM1edsiI2+tMeoIJvc3KXLCRfr4WSy/EUrAt7kyU/PAoU6NMDPllOHKx4/Iwu3GTeicjfYZgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, "open list:AMD IOMMU (AMD-VI)"
	<iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.10 0/1] iommu/amd: Prepare for multiple DMA domain types
Date: Fri, 18 Oct 2024 12:51:21 +0300
Message-ID: <20241018095122.437330-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-02.aladdin.ru (192.168.1.102) To
 EXCH-2016-02.aladdin.ru (192.168.1.102)

Svacer reports possible dereference of a NULL-pointer in 
amd_iommu_probe_finalize(). The problem is present in 5.10 stable release
and can be fixed by the following upstream patch. In order to apply this
patch, the incoming changes had to be manually accepted. This action was
necessary due to some differences in the code of amd_iommu_probe_finalize()
of the upstream version and 5.10 version of the kernel.

