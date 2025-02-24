Return-Path: <linux-kernel+bounces-529360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D9DA4234F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C370189AD34
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B826170A13;
	Mon, 24 Feb 2025 14:33:58 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87B12E5D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407637; cv=none; b=fkasCM5NGTZk5uQWOi0Ee71ce64BSxiMSFmKaiKJq4Ivt0Om/Og/dqKNo97QlePdlXqLgOGBAZKgXbD5UAqoKUCLy6IIoOqAwlIyZbJM4O25rA5x3fLtD8hA37gJbotV8Bsrsm1gQQpz4Fcqz9pBjHi8JeUDeRn6Gy+kaO9y7nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407637; c=relaxed/simple;
	bh=L9yAKW/n9arxFYNfRqvP08T/QJYXWLCKzl6Lh+id6G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/Q/+5dN8FoXwhjEK1mdwGDmyURB/aF1GDJgA828D44Y9RfT/Xsy9KhBGis+lMUSvc5voFoBVqsNv3Ypr/0gF+oegudnICegk7eWQ8Qgq0D64njrFKV+2oXz2zbLvrda417aW5Tb2njk8TQKjj2cHNaZYwhed+WJMMoxDpIHFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 91FF868BFE; Mon, 24 Feb 2025 15:33:51 +0100 (CET)
Date: Mon, 24 Feb 2025 15:33:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Xinyu Zhang <xizhang@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH] nvme: map uring_cmd data even if address is 0
Message-ID: <20250224143350.GB1406@lst.de>
References: <20250220235101.119852-1-xizhang@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220235101.119852-1-xizhang@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 20, 2025 at 04:51:01PM -0700, Xinyu Zhang wrote:
> When using kernel registered bvec fixed buffers, the "address" is
> actually the offset into the bvec rather than userspace address.
> Therefore it can be 0.

How is that actually going to work?  Who is interpreting that address?


