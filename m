Return-Path: <linux-kernel+bounces-368437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6618E9A0FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E501C21A94
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9EB20F5DC;
	Wed, 16 Oct 2024 16:34:23 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F6717CA1D;
	Wed, 16 Oct 2024 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096462; cv=none; b=MjmoNrbXYk7sZlQYkmlUeBn883EcqKlqtGJ9hyyeo3ENDqETobDQoB7DYjvXiYfyxxOTYF2hF/6jcRePe9yt8XiFD7OiP0J/XX4mR83/bAbljhUdWoKvDU7gYC4VaZNwSPahvZqa7pfujP9V+Awd5S8lMJzRcQk70HT55CNK+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096462; c=relaxed/simple;
	bh=2ZEI9hUJ/eG8J9tqMxLov+QtZjHgeL2+nf2gMo2b/Ww=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pwdmiAnvMj6mTNjJMi9v1lHegI4pfeo+/J7I0EFrkSgkijIYnvctaVZFmOtEdiLBqX2cVmRh7WxWiGqFRmY/vrAFiHlnZe6J0E8vRDEkGkiuTpevanUHdugJucZHJ7UAHvV+dGEX/JYfpta01nO/jQCFzFKpWnTE8onv/XwmdQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTGj12xFVz6J6bv;
	Thu, 17 Oct 2024 00:32:37 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id AADA4140A46;
	Thu, 17 Oct 2024 00:34:18 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.158.191) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 18:34:17 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 0/4] Updates for CXL Event Records
Date: Wed, 16 Oct 2024 17:33:45 +0100
Message-ID: <20241016163349.1210-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec rev 3.1 CXL Event Records has updated w.r.t CXL spec rev 3.0.
Add updates for the above spec changes in the CXL events records and CXL
trace events implementation.

Note: Please apply following fix patch first if not present.
https://patchwork.kernel.org/project/cxl/patch/20241014143003.1170-1-shiju.jose@huawei.com/

Shiju Jose (4):
  cxl/events: Updates for CXL Common Event Record Format
  cxl/events: Updates for CXL General Media Event Record
  cxl/events: Updates for CXL DRAM Event Record
  cxl/events: Updates for CXL Memory Module Event Record

 drivers/cxl/core/trace.h | 201 +++++++++++++++++++++++++++++++++------
 include/cxl/event.h      |  20 +++-
 2 files changed, 190 insertions(+), 31 deletions(-)

-- 
2.34.1


