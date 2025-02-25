Return-Path: <linux-kernel+bounces-530591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE48CA43586
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F1C167454
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E86F256C80;
	Tue, 25 Feb 2025 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWhO5Yra"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD0257438
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465597; cv=none; b=SK5bbr3JZ6QF5rYchi5pCiEUKM0nFyWQItdxjQCu4ozn+niXGfs5eDePSkBsz9CqDZhbdI2VLfevnfuv+yyfzlzt5QQ40xvF0/r3imIrQQs6Hs5UDB2YsBA3vZktGj1a2Qbgd8raZASxLF/I/3255utJH3M4R4nUh9euw9uQxjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465597; c=relaxed/simple;
	bh=VYVyWSL41gzONtU6hCsxIy3y5hnE7xAKsQLJOUa3gXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7R4MvbOyQnK2pxDn7OxRIgt9/ZVmoujJ/qxbMwpt/PXk+ZxtrhjsiRc5bxFneyXIyLlwt9I5am+COCDywtthdQpvT0hLqX93KPSDRxYkyghZ/Q2KewYAAP9/UkSfVHYX1qqMjBAmApf8eTRkeOjSdROAWMdZgv3BshfzMUiaoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWhO5Yra; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740465594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hj5D227ch1iq8F50kZ0cjU0+st5jyGocbEADkQeAaXY=;
	b=CWhO5YraPc+GvCRN6NshPWtyDAi/Ysl7Sam7MpI29+XCm59ey4kFssUELeuZ3BkO893wpB
	V9EMwkU6fNOzAb3l1KNBui+XAHDO5VOQf58ZUZXMBp4onP6zISmM54D2H/q4+jSrd0S/ol
	tGH0BN6Hz5mJyhs6l7IjCGcFuWtCsac=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-T0i9WcdWNCim8CMnpziD5Q-1; Tue,
 25 Feb 2025 01:39:47 -0500
X-MC-Unique: T0i9WcdWNCim8CMnpziD5Q-1
X-Mimecast-MFC-AGG-ID: T0i9WcdWNCim8CMnpziD5Q_1740465585
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E979A1800877;
	Tue, 25 Feb 2025 06:39:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13E1219560A3;
	Tue, 25 Feb 2025 06:39:42 +0000 (UTC)
Date: Tue, 25 Feb 2025 14:39:38 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] mm, swap: remove swap slot cache
Message-ID: <Z71lqkZfnDeLCjEx@MiWiFi-R3L-srv>
References: <20250224180212.22802-1-ryncsn@gmail.com>
 <20250224180212.22802-7-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224180212.22802-7-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 02/25/25 at 02:02am, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Slot cache is no longer needed now, removing it and all related code.
> 
> - vm-scalability with: `usemem --init-time -O -y -x -R -31 1G`,
> 12G memory cgroup using simulated pmem as SWAP (32G pmem, 32 CPUs),
> 16 test runs for each case, measuring the total throughput:
> 
>                       Before (KB/s) (stdev)  After (KB/s) (stdev)
> Random (4K):          424907.60 (24410.78)   414745.92  (34554.78)
> Random (64K):         163308.82 (11635.72)   167314.50  (18434.99)
> Sequential (4K, !-R): 6150056.79 (103205.90) 6321469.06 (115878.16)
> 
> The performance changes are below noise level.
> 
> - Build linux kernel with make -j96, using 4K folio with 1.5G memory
> cgroup limit and 64K folio with 2G memory cgroup limit, on top of tmpfs,
> 12 test runs, measuring the system time:
> 
>                   Before (s) (stdev)  After (s) (stdev)
> make -j96 (4K):   6445.69 (61.95)     6408.80 (69.46)
> make -j96 (64K):  6841.71 (409.04)    6437.99 (435.55)
> 
> Similar to above, 64k mTHP case showed a slight improvement.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/swap.h       |   2 -
>  include/linux/swap_slots.h |  28 ----
>  mm/Makefile                |   2 +-
>  mm/swap_slots.c            | 295 -------------------------------------
>  mm/swap_state.c            |   8 +-
>  mm/swapfile.c              | 193 +++++++++---------------
>  6 files changed, 71 insertions(+), 457 deletions(-)
>  delete mode 100644 include/linux/swap_slots.h
>  delete mode 100644 mm/swap_slots.c

Reviewed-by: Baoquan He <bhe@redhat.com>


