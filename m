Return-Path: <linux-kernel+bounces-311177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EF39685A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A422851F0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9CC1D47D4;
	Mon,  2 Sep 2024 11:02:44 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA31D47D0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274964; cv=none; b=SB/mnqAXupV3B0B0m/PltoI8UNvOJ5WLi6uXPFU0ZPPIET245zfBRczUgEYC5wb0CF/cD8zdsqqel1FmT+ajCZvBN5a4eAxmLtagThp/EtrEuukAfqi0EocmZXbXGP/4pES1/cf301jHevSPFiev6lebTXzWVFOlAw6vDmLV3sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274964; c=relaxed/simple;
	bh=lzEgLnysjmucHok2BwVSVd0LFb47D5k+j3RmpDmPkcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oyDDo6G4bJFz50wppUYvrch6XPs8SnxmIAcF0uTWpdILLZOmoIhW35vb0/TMsLZGsZZiBm9jLVM2p5O1ZZjz9VL9teFEifF63EX2MlIeWrNnjo8viik9cGwchfh4DCcDPKAfwu7iOumwZQCQZWmurxMs0LyjmBC46h8qI+r2UjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.163])
	by sina.com (10.185.250.24) with ESMTP
	id 66D59AB70000390E; Mon, 2 Sep 2024 19:00:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 27753010748533
X-SMAIL-UIID: 4ACC053AFF234F318DC63C4F192F5992-20240902-190010-1
From: Hillf Danton <hdanton@sina.com>
To: Jingxiang Zeng <linuszeng@tencent.com>
Cc: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>,
	linux-mm@kvack.org,
	Yu Zhao <yuzhao@google.com>,
	Kairui Song <kasong@tencent.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: wake up flushers conditionally to avoid cgroup OOM
Date: Mon,  2 Sep 2024 18:59:59 +0800
Message-Id: <20240902105959.1637-1-hdanton@sina.com>
In-Reply-To: <20240829102543.189453-1-jingxiangzeng.cas@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 29 Aug 2024 18:25:43 +0800 Jingxiang Zeng <jingxiangzeng.cas@gmail.com> wrote:
> 
> @@ -4919,6 +4920,14 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
>  	if (try_to_shrink_lruvec(lruvec, sc))
>  		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
> 
> +	/*
> +	 * If too many pages failed to evict due to page being dirty,
> +	 * memory pressure have pushed dirty pages to oldest gen,
> +	 * wake up flusher.
> +	 */
> +	if (sc->nr.unqueued_dirty >= sc->nr.taken)
> +		wakeup_flusher_threads(WB_REASON_VMSCAN);
> +

Because a) the right domain to processe dirty pages is writeback and b) flusher
runs independent of page reclaimer that has nothing to do with WB_REASON_SYNC,
feel free to erase WB_REASON_VMSCAN instead of adding it once more.

