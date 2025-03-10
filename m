Return-Path: <linux-kernel+bounces-554334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA23A5964D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB70164861
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1C8227EA0;
	Mon, 10 Mar 2025 13:29:37 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42576846D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613377; cv=none; b=bteCnGfX/Y0dKSycYM+FaIQMbzSGoEhXPEeqNAQZpqu2svtmeMh2ZmfqP7QwSJsFZEdkmZjLKzgJtbsLFASbnsANxCv7wzbvltdBBH5DL7SULLCmZQlB+qTgg2/6zYbYXYo6R8vy0BlP/Icla+j5W5w1LXR8Y30FGjK4sFaX8ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613377; c=relaxed/simple;
	bh=nu6mXMhR4+TWShaYO112XXeIDNz9PClLxgCUD4clIVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0cSKD+dd3V8bnMMKybQ8QptCQ/ffBJ1z0+PofnC6CPvD/DJbjZSMTCwTS0/1K6dgVecg6Ip1TA/JdxZFZs70VTUG025jtBPp9t+VB0Z7st7GecYUbsS10/pVLECewcWOdEoK7owec/mxjplnSTUSOhvEqIaWC09jIzZeIvUIx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 088C167373; Mon, 10 Mar 2025 14:29:32 +0100 (CET)
Date: Mon, 10 Mar 2025 14:29:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <20250310132931.GB8956@lst.de>
References: <Z8jk-D3EjEdyBIU5@kbusch-mbp> <20250306000348.GA1233@lst.de> <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de> <20250306141837.GA21353@lst.de> <Z8m4vzE36UHWjwep@kbusch-mbp> <20250306151654.GA22810@lst.de> <Z8pB9jQALxMN6WaA@kbusch-mbp> <b2c9df64-0afc-46cd-9e8d-6a3f41a4f1c7@linux.ibm.com> <Z8sUB2bbbMsurZmu@kbusch-mbp> <69cdaf9d-2fb4-4ee0-9c32-cc946405a23a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69cdaf9d-2fb4-4ee0-9c32-cc946405a23a@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Mar 09, 2025 at 10:53:19PM +0530, Nilay Shroff wrote:
> Yes agreed however it seems advantages of using an indirect call outweighs 
> using the short cut to blk_mq_submit_bio. Moreover it seems the cost of 
> indirect call is trivial because we already cache the nexthop. 

Indirect calls are never cheap unfortunately.

> If you and Christoph are busy with other work then in that case I'll be 
> glad to pursue this further if you agree.

I'm not working in this area at the moment, so from my POV feel free
to go ahead.


