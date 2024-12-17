Return-Path: <linux-kernel+bounces-449077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 278169F4967
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7761188B3E3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD781EBA14;
	Tue, 17 Dec 2024 10:58:39 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FA21E0B7D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734433119; cv=none; b=edTe5LQEyhPjJuQI/F4OAzSuECW7TFFc/j3Ef/BxMxOEjoLOcyQl27kF1110R0YAz6yssC/W+wSpgdWPV18lhj5HK0ISiMaE3BubsUTQZiUH75WzWr7BZfgCqrnfOgk5OvU5mGalX9uJcwUoJbOrW1M0t5WFBBc4AVEcJGHdSPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734433119; c=relaxed/simple;
	bh=y8z1kwBJCvbTP4SyoXW87BufV8wvbYIzm1ZCV/6Rj+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzS3IeG2bVCJ1kCOX+85YR+0mFp9eUs/KzhJVBnPnL1JWFYaa4AkwsMLUEzkcAVPzDUgULly9du5x96lv1b5jv71RKq/Ie14CulFHgicT4UFILb2WlbVcYHiGOl8b8NUQxpT3WKJRR87K0nV4rdC/bwTsNsi3zw4jatTXXDkUFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.172])
	by sina.com (10.185.250.24) with ESMTP
	id 6761594D00000F0F; Tue, 17 Dec 2024 18:58:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 67580610748259
X-SMAIL-UIID: 81ED21B85121424D8371BDA0E718E341-20241217-185823-1
From: Hillf Danton <hdanton@sina.com>
To: Liju-clr Chen <liju-clr.chen@mediatek.com>,
	Jerry Wang <ze-yu.wang@mediatek.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 15/25] virt: geniezone: Add memory pin/unpin support
Date: Tue, 17 Dec 2024 18:58:12 +0800
Message-ID: <20241217105814.183-1-hdanton@sina.com>
In-Reply-To: <20241114100802.4116-16-liju-clr.chen@mediatek.com>
References: <20241114100802.4116-1-liju-clr.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 14 Nov 2024 18:07:52 +0800
> From: Jerry Wang <ze-yu.wang@mediatek.com>
> 
> +struct gzvm_pinned_page {
> +	struct rb_node node;
> +	struct page *page;
> +	u64 ipa;
> +};

To avoid inventing wheel behind locked door, feel free to use page cache to
keep pinned pages in shape.

