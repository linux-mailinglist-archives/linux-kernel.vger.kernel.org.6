Return-Path: <linux-kernel+bounces-317944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B8096E5CF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C78285AB5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D8B1AE861;
	Thu,  5 Sep 2024 22:40:43 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E6A1482E9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725576042; cv=none; b=pq+vH1iALS45ENXksuit3wNnC2nnxAqkRRJerZrssFHFs7FwUs7TfAsq+ULXCNTkboHmn9lqs1DsHeNSNG0s76yEwqD3HibbE2OZScLH88XTOdGObLCok0jBiVJqGDtqvlo425GC9AyPL7uRq2sA2yikRyMSCAujOb2+QI8oCp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725576042; c=relaxed/simple;
	bh=w8v7RvXqT0KlDpml49QYizFPqdb4aYGrqseedqucWSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hViIBNgldHWsycr7mzh5duELxjOfFYBDZr1kwydozhe2WvdQ+XfYlm++v5Dngm9uNVEG3jP9LzuvNLZ9RrR7In0+t60zBY6O0tlGA67CMiz6PzchYuDI+CPR4pwkxYX4PN7dJL1NlSL7fg4kKG+84ptZ1/wgSfkhgdxMytp3WqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.67])
	by sina.com (10.185.250.22) with ESMTP
	id 66DA29DA00006578; Thu, 6 Sep 2024 05:59:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2911437602652
X-SMAIL-UIID: FE693CDE161143748A508DE683140C07-20240906-055957-1
From: Hillf Danton <hdanton@sina.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: yosryahmed@google.com,
	mhocko@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: introduce per-node proactive reclaim interface
Date: Fri,  6 Sep 2024 05:59:45 +0800
Message-Id: <20240905215945.1909-1-hdanton@sina.com>
In-Reply-To: <20240904162740.1043168-1-dave@stgolabs.net>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  4 Sep 2024 09:27:40 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:

> This adds support for allowing proactive reclaim in general on a
> NUMA system. A per-node interface extends support for beyond a
> memcg-specific interface, respecting the current semantics of
> memory.reclaim: respecting aging LRU and not supporting
> artificially triggering eviction on nodes belonging to non-bottom
> tiers.
> 
> This patch allows userspace to do:
> 
>      echo 512M swappiness=10 > /sys/devices/system/node/nodeX/reclaim
>
The proactive reclaim on the cmdline looks like waste of cpu cycles before
the cases where kswapd fails to work are spotted. It is not correct to add
it because you can type the code.

