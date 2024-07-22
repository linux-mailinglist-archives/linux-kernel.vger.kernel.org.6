Return-Path: <linux-kernel+bounces-258440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1529387E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFF91C20D25
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34BF16426;
	Mon, 22 Jul 2024 04:05:52 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9518030
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721621152; cv=none; b=u73C60XhFdVzVdZLzdF1Yd9kvQlZR6HaVNd9jUY1NreF9uwhdrpZ+NJDTR1k4/fBT4pt4NH7Tmx4rJEEnKCxZg7jg8+8XSVBorrUbmZG0QRskP5ggrMMaXffBUH1dG74m+fCWjvbDoIaPcAIb6ysm0Alzg3tQl6TwiDBlxY/AvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721621152; c=relaxed/simple;
	bh=CIdA4fQA5z6QtGa9EosPPpNk2YWKcLz9OOlBkgr1yUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ftcKTnXlsVjITZeK7AaHidI2goM1W8AaCeZOK8NskAgri4I3HShk3IwZXdpw2YixQKGZqrr9y1eVNsgmlfKB6XJRj9SFa/H8a3twKqvsqfQKnY+OxxpvWdYCKaneIEmTja2P53BI3Yu8wmt+ifxfu0d6gbGIuSJhbP86TpVIvMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WS6B62g4DznbX1;
	Mon, 22 Jul 2024 12:05:02 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id AD5E8140382;
	Mon, 22 Jul 2024 12:05:47 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Jul
 2024 12:05:46 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <rohit.mathew@arm.com>, <amitsinght@marvell.com>,
	<sdonthineni@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<zengheng4@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH mpam/v6.10-rc1 RFC 0/4] arm_mpam: Fix several minor issues
Date: Mon, 22 Jul 2024 12:01:36 +0800
Message-ID: <20240722040140.515173-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100008.china.huawei.com (7.202.181.222)

After completing the necessary software adaptation for the local chipset,
the MPAM function is successfully enabled. After related tests are
completed, some issues were discovered and here attempt to fix them.

Hope to get some suggestions for modifications, if I miss any rules should
be followed, please let me know.

Zeng Heng (4):
  arm_mpam: Correct MBA granularity calculation
  arm_mpam: Fix the range calculation of the implemented bits
  arm_mpam: Correct the judgment condition of the CMAX feature
  arm_mpam: Fix typo about mbw_min controls

 drivers/platform/arm64/mpam/mpam_devices.c  | 8 +++++---
 drivers/platform/arm64/mpam/mpam_internal.h | 1 +
 drivers/platform/arm64/mpam/mpam_resctrl.c  | 4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

--
2.25.1


