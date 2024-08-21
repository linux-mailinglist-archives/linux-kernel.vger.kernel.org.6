Return-Path: <linux-kernel+bounces-294883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070DE9593D1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988CC1F232EF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFD9155C80;
	Wed, 21 Aug 2024 05:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BKAGViLS"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83D175A6
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724216815; cv=none; b=mA+OoaICWqDbFkywHO1q8SqXtt3UR5guAdbMMLMc/XbOnLjNBFwPlT7o/5kuJxk6wAaZAYd31dK6vx7XFov8TXM1TQj6Mq1CoMpH5UIfSWb/2RnwZBhKTcRbHi0q5+RVS1BC4pIYsv3iXS42XwAyUq1gR7HC9LiOlxOjykYXHik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724216815; c=relaxed/simple;
	bh=2DshrC2wPT+HqiB+wk4KnOX9Ljc4ztK2HKSMQXVrYLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBiLf9Q5RoRjHRj/vHmzbm2VIj82SeV0NwE38L90BmHyXp/xM1IVxmMeV6+zY7LUir3Vmahh7kbO76uDKka4QumxCkFRDTJyLK+KYTl+QDNqRVrkQPpai4jaxqwGMi04iLxdPQdYKPbyMK+Xp7u8BO7sSiV1TTJXeDgQOoRBz/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BKAGViLS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2DshrC2wPT+HqiB+wk4KnOX9Ljc4ztK2HKSMQXVrYLc=; b=BKAGViLSWfMEJV0625RQ5Nq6YW
	fi6KD8w33W2oBpV8nDnmQn4n5XZhE7NWCdJX1vR92gC/C2Rc/JN/5GH7No5gIXKb+IhkCWF6U/w1+
	FKtxs9AzgguhFbmbvIj7Y9A3Kkc766zncuPmer7xuHjTrSI1QgHyq2i/qCT6IyZDZb3U5h8UVDt33
	jEKf9BtzBh5XnDGEfKlzqzgVL27hQ8tf8zhK3vndQelIRwIqNXWU7fmnNCqR5zo+rJPWiiC2UT6Um
	1EtOAkYu2IXLmDvJMhEwE7q3WdZ92UoHDS0flRqw92bUZNVn7SqMdetD3FdKyd5TowJSmXaw06umI
	evK8eohA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgdYa-00000007XQL-47dr;
	Wed, 21 Aug 2024 05:06:52 +0000
Date: Tue, 20 Aug 2024 22:06:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
Message-ID: <ZsV17ACIEelIQuKx@infradead.org>
References: <20240819092851.441670-1-lulu@redhat.com>
 <20240819092851.441670-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819092851.441670-8-lulu@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 19, 2024 at 05:27:33PM +0800, Cindy Lu wrote:
> Add a new UAPI to support setting the vhost device to
> use kthread mode. The user space application needs to use
> VHOST_SET_USE_KTHREAD to set the mode. This setting must
> be set before VHOST_SET_OWNER is set.

Usage of an API is a complete kernel internal detail that has absolutely
no business being exposed to applications.

What is the application visible behavior that the API use is the proxy
for?


