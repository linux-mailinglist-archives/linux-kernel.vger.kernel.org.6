Return-Path: <linux-kernel+bounces-332756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B687997BE73
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D19B2109F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C901C8FC5;
	Wed, 18 Sep 2024 15:11:15 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E0D156F3C;
	Wed, 18 Sep 2024 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726672275; cv=none; b=FZ1npKIzp/C8NVUp7RziACOiAh9ShRRyPtRZHdi5KYu4uzx1rUjvTEJDQtrimuMZXBMUkoEJM+0xk/2zH+sqZTxgZErx4o3KgiOV0Vnr2A0c2j/MpOgP5+MtcyVAWEaaPCp1FqxRIOMV2E6ZRY2RV18pM+tvY1zdj0zYYoS/G4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726672275; c=relaxed/simple;
	bh=xUTDN6cjyd1wpyN3j9KqdQo96F+WfsdoLshqT0YFbzc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SuRyo8XNeSOO5Ry0f7ryPdGsyQvWz0bgrsu0xwkIKJJxIDjjyw0YfMgcL5RaS6+hxqGYuVeur66eDrYeakHeMJtjBLipaU9X9OAOKVsbscY/uSPbnW3MnNtodlGebDTqrRCJjYjKKCCuNqLd0v3hpgrTSEH2DHMc8XDny+EMVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 18 Sep
 2024 18:09:58 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 18 Sep
 2024 18:09:58 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Steve Wise <swise@chelsio.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Doug Ledford
	<dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-patches@linuxtesting.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 4.19/5.4/5.10 0/1] RDMA/cxgb4: Fix potential null-ptr-deref in pass_establish()
Date: Wed, 18 Sep 2024 08:09:48 -0700
Message-ID: <20240918150949.7089-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

The following patch aims to fix a possible NULL-ptr-dereference that
occurs if a call to get_ep_from_tid() fails to assign nonzero
value.

Upstream commit 283861a4c52c1ea4df3dd1b6fc75a50796ce3524 has been
backported up to version 5.15. For some reason, older stable branches
have been ignored.

This backport can be cleanly applied to 4.19, 5.4 and 5.10 versions.

