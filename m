Return-Path: <linux-kernel+bounces-312775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E7D969B16
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4A11C2388E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7191519F432;
	Tue,  3 Sep 2024 11:04:03 +0000 (UTC)
Received: from smtp134-32.sina.com.cn (smtp134-32.sina.com.cn [180.149.134.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2947A1B12C5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725361443; cv=none; b=pY5J008u30OkNAjUVhh3T6qXJZ3jOua3ktqXphhUJGlmnuhKOM8zV6DEioseL1FSBKX7tbFtujfws6qU4h/yZgVLSMU/cse9+rwB24nRo2SiZVWRyUYaXXP/MWeQ80rWiWspqT2JfnfCEW8dDgNLYj6knAXmY9Hp2av83bdnS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725361443; c=relaxed/simple;
	bh=3dMPXlP4anTNwq526dg5Oec267dyszU3OtFkgdG3AeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oU548U2yXn0nq4gg/Cc1lnLXQxhH90id8nllNqe8w88Pyze5QaheakaaqdftJKTnYiNiAlAAiwt+SYyEtLXmVGBx1WnNnn1l7u0z8jNS8szAo39wMAYW5S2y5gnp8bqYTd5+14Kf5f3d1AU0i71ffCVr9rjwMmF3lpRAvxW5Ztg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.172])
	by sina.com (10.185.250.21) with ESMTP
	id 66D6EC7F00005088; Tue, 3 Sep 2024 19:01:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1103633408533
X-SMAIL-UIID: 7CAF2982F7F24C768F9BEBA86CFD2D41-20240903-190122-1
From: Hillf Danton <hdanton@sina.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Barry Song" <v-songbaohua@oppo.com>,
	"Carlos Llamas" <cmllamas@google.com>,
	"Suren Baghdasaryan" <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Tangquan Zheng" <zhengtangquan@oppo.com>
Subject: Re: [PATCH] binder_alloc: Move alloc_page() out of mmap_rwsem to reduce the lock duration
Date: Tue,  3 Sep 2024 19:01:09 +0800
Message-Id: <20240903110109.1696-1-hdanton@sina.com>
In-Reply-To: <20240902225009.34576-1-21cnbao@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Sep 03, 2024 at 10:50:09AM +1200, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> The mmap_write_lock() can block all access to the VMAs, for example page
> faults. Performing memory allocation while holding this lock may trigger
> direct reclamation, leading to others being queued in the rwsem for an
> extended period.
> We've observed that the allocation can sometimes take more than 300ms,
> significantly blocking other threads. The user interface sometimes
> becomes less responsive as a result. To prevent this, let's move the
> allocation outside of the write lock.

I suspect concurrent allocators make things better wrt response, cutting
alloc latency down to 10ms for instance in your scenario. Feel free to
show figures given Tangquan's 48-hour profiling.

> A potential side effect could be an extra alloc_page() for the second
> thread executing binder_install_single_page() while the first thread
> has done it earlier. However, according to Tangquan's 48-hour profiling
> using monkey, the likelihood of this occurring is minimal, with a ratio
> of only 1 in 2400. Compared to the significantly costly rwsem, this is
> negligible.
> On the other hand, holding a write lock without making any VMA
> modifications appears questionable and likely incorrect. While this
> patch focuses on reducing the lock duration, future updates may aim
> to eliminate the write lock entirely.

If spin, better not before taking a look at vm_insert_page().

