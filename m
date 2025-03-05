Return-Path: <linux-kernel+bounces-546997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07332A5019A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA5C171F03
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274EA24BCFD;
	Wed,  5 Mar 2025 14:17:46 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3819D1519BD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184265; cv=none; b=aZFzFwTYPvJslZSn6sJNms249Lm49XYxZGBpMnJeaeHmqrmxL7SkARPMLtwoFIDps0PV14OJEs6xmVuDhKsfbIWFDnpQ3QnmbKEZcaGX4Dsb5oxxzllUDc/JpeTBgCRYsuDdXJTsRr6j8qjAcz4XiY0PMy3p6nx/rgGW0MU2vCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184265; c=relaxed/simple;
	bh=eziZRf8ASee90hLp9xUQFCBux87w7fRv7r5l06eJlk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riG6LVrRzGUPVI1KB8iU73vzyF8wVgXYNEmQE1PxdEsvYRgoz/5pRRbkxoTAcfLjgC2kYYZVix3VvDB+EJwkMTGUKqGpufh1EyPB1Ek7YJBeZhyHdRnLYPVnveaymwYxMQBs1ZFUflYR9+9h8IbVk/iheoXOprTThibmGDLkzms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 753F068C7B; Wed,  5 Mar 2025 15:17:40 +0100 (CET)
Date: Wed, 5 Mar 2025 15:17:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] nvmet-fcloop: add ref counting to lport
Message-ID: <20250305141740.GC18065@lst.de>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org> <20250226-nvmet-fcloop-v1-2-c0bd83d43e6a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-nvmet-fcloop-v1-2-c0bd83d43e6a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 26, 2025 at 07:45:54PM +0100, Daniel Wagner wrote:
> +static void
> +fcloop_lport_free(struct kref *ref)
> +{
> +	struct fcloop_lport *lport =
> +		container_of(ref, struct fcloop_lport, ref);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	list_del(&lport->lport_list);
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
> +	kfree(lport);

Maybe it's just me, but I find the kref a really horrible pattern over
usig a simple refcount_t.

Otherwise adding proper refcounting looks fine.

