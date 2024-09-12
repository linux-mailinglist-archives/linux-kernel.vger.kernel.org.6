Return-Path: <linux-kernel+bounces-326283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 214A29765DE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE571F24F37
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048CA19C54B;
	Thu, 12 Sep 2024 09:40:27 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7853195980
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134026; cv=none; b=SsJjeJzXJrSU6buhHhWulGtLEf2Fa108C1La/kA5cOgOGhokAO/403RUYBPkpoD8/sq0rckNBhT4Efhz/dfpTzPr/x/0Gsgll8e3unyY4ud7isN52E2BO73KZ5sD5vCX3kYJ84t9otu0A5rrsU/5poHjJHOlrTaaFbZ9HqrcWO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134026; c=relaxed/simple;
	bh=f/Ky1qRo/bBl5XpPNJ+b1s2pFw0Z6N57XaTz54sWdm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/2X28WgtCwMMc+x9OlPkdhInzbmR8hXqGGS6Jbby1sTo7EtfK3UKRjxDoNdgzoepGyf8X8i+mfkYqtn0NeEI5VodAGxts6BrgJav7pcfciQ/pqzusGwyuwiK4vbUakndYTPc6JGYsE4+wMpIhClbWn0xgw+F7VFGafGZ+E9hzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 979D7227AAF; Thu, 12 Sep 2024 11:40:20 +0200 (CEST)
Date: Thu, 12 Sep 2024 11:40:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yihan Xin <xyh1996@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Force ns info updates on validation if NID is
 bogus
Message-ID: <20240912094020.GB13465@lst.de>
References: <20240910095006.41027-1-xyh1996@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910095006.41027-1-xyh1996@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 10, 2024 at 05:50:06PM +0800, Yihan Xin wrote:
> When validating a namespace, nvme_update_ns_info()
> would be skipped if nsid changed. However, this
> happens everytime the in-use controller is
> reattached if NID is bogus, causing nsid not being
> restored to the previous one, eg /dev/nvme0n2 ->
> /dev/nvme0n1.

What do you mean with restoring the nsid?


