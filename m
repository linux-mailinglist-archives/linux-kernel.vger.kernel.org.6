Return-Path: <linux-kernel+bounces-549107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 641C1A54D6C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239191893DC2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09F2155C8C;
	Thu,  6 Mar 2025 14:18:51 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C908414BFA2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270731; cv=none; b=uEkkekECwdW/Ky04YHskI4fbyq9y4Gc5bm5LEewr0YDbLsEqGrmHrV2ohOHAQ+MKJSXUUniDZsDltesRm6bbyWtToBdBdaoaGDJaixsyD7XUNcjy9jvVH+kh55JBMKHAs4YbHnJ1VLpwK5WZF8CY+lqErEtkr8OmrCt2Nq283DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270731; c=relaxed/simple;
	bh=0bhAYii0qyUyGy6an9L8nViT7tnXsWn31+Iasof9GXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfUafYUG+wmlRxg3a08t8uRx/1ONDcbSUH6KNncPBXKnwTXEzg8/9PP2QK+Qy1yo6Ti/N53bWkcf9JbpGyxjcvTvc5r5PhbjriAq2aU3oveQ6XcoXORekoLwr6X19AiujtVeIQbIpQbfaFfh5gsUoNsa9Uu0Bms6G7SgaNsFF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B41668AA6; Thu,  6 Mar 2025 15:18:38 +0100 (CET)
Date: Thu, 6 Mar 2025 15:18:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <20250306141837.GA21353@lst.de>
References: <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com> <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me> <Z7dct_AbaSO7uZ2h@kbusch-mbp> <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de> <20250305141554.GA18065@lst.de> <Z8hrJ5JVqi7TgFCn@kbusch-mbp> <20250305235119.GB896@lst.de> <Z8jk-D3EjEdyBIU5@kbusch-mbp> <20250306000348.GA1233@lst.de> <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 06, 2025 at 08:12:03AM +0100, Hannes Reinecke wrote:
> Single ported.
> There is a range of Samsung NVMe where one is a normal, single ported,
> NVMe, and one with a nearly identical model number reporting CMIC.
>
> Causing _quite_ a lot of confusion with the customer (and L3) when
> used under MD, as for the first hotplug works, for the second ... not so 
> much.

If the device is indeed entirely single ported and Samsung can confirm
the setting is incorret and not easily fixable by a firmware update
we can quirk it.


