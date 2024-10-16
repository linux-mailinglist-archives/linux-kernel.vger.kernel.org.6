Return-Path: <linux-kernel+bounces-368549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2DC9A1136
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF531C20F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D393120C493;
	Wed, 16 Oct 2024 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GuvaQvD8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F414A09E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101969; cv=none; b=d7Z6WqWERxuqMlzIjHbOZKcU/NMaxD5/2EHbOCsGc2DYPsgcpMu8MQhsmJeNfcrNx8WS304KfCLMugmF2PDzAFPnEV7NK/+qiIoIQI7FzD30U0M/u//MsShDzvx9RJVv+j6xSaEqyFFvVm5bh/XfKy5UbXa++6rFLpuoiR6ZQu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101969; c=relaxed/simple;
	bh=BF/1BhQsUF1eLE1EbdesXCgiRj7vDd8sk6fDx25KovU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B24lA4QlCc7ndkfCXmntAMtgxD/hOmWL1Zx/u8suGIpgN5b6XW66FHUkaL8jDYJSOpAM18j6QOHWGEfboIMazQPCDGxKStM3n344Sz3srzf/v0NksGGdGVI1FDc6MRd4epS7AgZul3kSUOqdokFBHU1N638voqRtfLCo083PwOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GuvaQvD8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BF/1BhQsUF1eLE1EbdesXCgiRj7vDd8sk6fDx25KovU=; b=GuvaQvD8BFF8nXF2/L5Z2D+99n
	C1T9XHEZXPeCl+E6EpKhJpn12+lv3FDuaQ5VoSfFtV9YiCOyrRa0x5s4Zdh7ZQES9qPVmFVs7c9QY
	4X6jLcVXhg5VaLZP/bUzg2rY+AhYCP1yCnNOuDEs8C0eTCVA7SJL0JnAIKTzjdX7efZ7hnRUlebbM
	hDS/p6q2xq706s5G+QxO70UZzrubB8wrLbfQL3ntySUybIWLzxbcCt2ie9MLfMe2HkTi/TGpoWaTN
	Nv8t9z/5LqLHeaH8vwDAz6iuNgoj0qSXrSMGvVhIjcAj0r9aBbHDl9w3CaJsWc5tiw0Bgzdc/YEBf
	SLmEHzeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t18PC-00000008eF5-3kB5;
	Wed, 16 Oct 2024 18:05:55 +0000
Date: Wed, 16 Oct 2024 19:05:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Waiman Long <llong@redhat.com>
Cc: lizhe.67@bytedance.com, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, boqun.feng@gmail.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC 1/2] rwsem: introduce upgrade_read interface
Message-ID: <ZxAAgikXWswSJ76D@casper.infradead.org>
References: <20241016043600.35139-1-lizhe.67@bytedance.com>
 <20241016043600.35139-2-lizhe.67@bytedance.com>
 <7f7b277a-7019-4bf4-b100-0505c6ce9737@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f7b277a-7019-4bf4-b100-0505c6ce9737@redhat.com>

On Wed, Oct 16, 2024 at 10:23:14AM -0400, Waiman Long wrote:
> Another alternative that I have been thinking about is a down_read() variant
> with intention to upgrade later. This will ensure that only one active
> reader is allowed to upgrade later. With this, upgrade_read() will always
> succeed, maybe with some sleeping, as long as the correct down_read() is
> used.

How is that different from Kent's SIX locks other than you can take an
rwsem for write immediately (SIX locks have to be taken for Intent and
then Upgraded)?

