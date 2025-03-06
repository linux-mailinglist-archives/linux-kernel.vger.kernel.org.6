Return-Path: <linux-kernel+bounces-548027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBF6A53EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E645A1893298
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0099F9F8;
	Thu,  6 Mar 2025 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx4PrFji"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D10017E4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220122; cv=none; b=DKjRZTVLKgp2XFLwVb1cQjTIer84d8doSz0BnHj0zlHhmbUVC9eT8nQHNqDjuL5Z5SLbcafF1/t0KqeMjZ+X5O5CYora9d+hQqSTrtvo8xsQgk3h9EffNa9guwhg3HveHLftzLdsxDZzBHD+yXEFingYqgo4jovBxtU1uXzXjMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220122; c=relaxed/simple;
	bh=Adg+t74yvHJFHoXDLdfTv32xGE3wVBh+8yopvBgugco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU8M7KOlLJ+x9/pgvRkSrNGEc1+LbZTHF4y7dzyQdUdA3mGQ/TrBK7cqOVQ0XEDeAdWH9jpyXIfYJom9l3v2BZqPhKZPorSQ6Pwn7V4CmQwDAr3GvhLrIyxiAq2BgbJeA+AGRgtcd2fBg1ufzId2abtHWpSBoEZCVDNcaS5iTkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx4PrFji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DABAC4CED1;
	Thu,  6 Mar 2025 00:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741220121;
	bh=Adg+t74yvHJFHoXDLdfTv32xGE3wVBh+8yopvBgugco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mx4PrFjiz7pideDtrB1Pi9/1K1KLoBEmSepuhUg0qkS74e/21ucT+PHiOT31LbxHY
	 sMQz9yqDhjS1FtToBn+F4dki0/zy2ZfhO1LddCPdE9F29q5QlZkWnIcA+x91H9Fesd
	 BrO5ezSG75UinDnJvxr4UCWTq+OJ6KLQV8U4J3DyT3VqL1DKUDROAj7EXAojvHvH+H
	 kVBRxtG4FvI8Kv1axUDCYREFrgriy8ySrMctRU1WsOGdRaBdAyUB+3oHT3SR6hY/+o
	 mzJIdU1Fhgb72pZt3RX4nFkWgJ5OnyI8Nw81f4PQRsywU4/FnHEtltM9czBShyNo6T
	 yq3QJzWjCq78w==
Date: Wed, 5 Mar 2025 17:15:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z8jpFkHsN94nVgEf@kbusch-mbp>
References: <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
 <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
 <Z7dct_AbaSO7uZ2h@kbusch-mbp>
 <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
 <20250305141554.GA18065@lst.de>
 <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
 <20250305235119.GB896@lst.de>
 <Z8jk-D3EjEdyBIU5@kbusch-mbp>
 <20250306000348.GA1233@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306000348.GA1233@lst.de>

On Thu, Mar 06, 2025 at 01:03:48AM +0100, Christoph Hellwig wrote:
> On Wed, Mar 05, 2025 at 04:57:44PM -0700, Keith Busch wrote:
> > In my experience, it's left enabled because of SRIOV, which many of
> > these devices end up shipping without supporting in PCI space anyway.
> 
> If a device supports SR-IO setting CMIC and NMIC is corret, but I've
> actually seen surprisingly few production controllers actually supporting
> SR-IOV despite what the datasheets say.

And I bet at least some of those devices left their {C,N}MIC bits on
despite not even supporting the virtual functions in their shipping
product.
 
> > Not quite the same thing, but kind of related: I proposed this device
> > missing debounce thing about a year ago:
> > 
> > https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/
> 
> Yes, that somehow fell off the cliff.

I'll be happy to revive it, but I don't know how much time I can
dedicate to seeing it across the line.

