Return-Path: <linux-kernel+bounces-570759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FDDA6B443
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23A507A92EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65FB1E9919;
	Fri, 21 Mar 2025 06:05:57 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DAE22611
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537157; cv=none; b=cGFP29xTkeAlKSL9gYyVIRnIi6lfGLLJ6bbMEMrj6oEKxsf3Bj2i28+WGl6gOWlvZcHm23IYJssm1nEFhWRZnmslvQXOq+aLsoz4Jzy5OqUcsR2sLLpa5GDixwfPS0/E6jJoL92HSs2aYPZcClMj8gJk+XnUGoOXY7snur4hJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537157; c=relaxed/simple;
	bh=h2knnMckMZ0izjwEcheIUZNyeODfuqvdip/IaorTQIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6goDpOPEhIn+J4RLLKa+YJ14Rbt7kTcAZIk01RuP5CDFiEfPvBex22HPoKwP1dC9ACd9pYiKVZyQyzlEewaW8CGNaXhTblSWhRQYl+hv3Ccy4LLnOBkjXrlg/+oQUivRfUjQKfsrdrPwm31zW5xG+Jgfk9hBNEdWT4BbIlCSxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F0B1D68AA6; Fri, 21 Mar 2025 07:05:50 +0100 (CET)
Date: Fri, 21 Mar 2025 07:05:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, Daniel Wagner <wagi@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/18] nvmet-fcloop: refactor fcloop_nport_alloc
Message-ID: <20250321060550.GC3007@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-4-05fec0fc02f6@kernel.org> <a9055e3c-d36f-4706-9fdc-f4532d14adb6@suse.de> <66261f08-5386-4b22-aa6f-7be1d4023fee@flourine.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66261f08-5386-4b22-aa6f-7be1d4023fee@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 02:38:56PM +0100, Daniel Wagner wrote:
> This means the new entry has always to be allocated first and then we
> either free it again or insert into the list, because it's not possible
> to allocate under the spinlock. Not that beautiful but correctness wins.

Yes, we do that a lot.  And if finding an existing entry is the more
common outcome (I don't think it is here, but I'm not sure), you do
a search first, allocate, and then search again.

