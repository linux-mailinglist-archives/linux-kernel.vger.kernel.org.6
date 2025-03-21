Return-Path: <linux-kernel+bounces-570764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063FBA6B448
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DD8189E9B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3291E9B18;
	Fri, 21 Mar 2025 06:12:59 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641622611
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537579; cv=none; b=Uly6Id6k7stwdmCCicFLdHAAB62hO5tH/nwGv6LWEHe6yuPOT532uQUj0xhExFyUmY3ROkf3CxmBk0SQPEjCpwuxpHeozr5vqTKv7RIw1saSF3SXt+tEZjyRElF7NJPIPrdbwQmMhQuecimsX0U3mcnswJsZa1KO5qu8tbATekA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537579; c=relaxed/simple;
	bh=ZgP+WyukfjJQWUvYrLxseSgRJwCsYKW8ZU2TlqklT1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkGyiBXgFF16QG20o9YKmTXWYenOgd6zyb7cCKF96a7dH6cW5KDnSq2jcl4DBF/MFkGWUuyPVBe4un9me7USL5XnGwCDvPw13pEUiq5T0oEu45H6IotrtEf8gB4D6Igcu02KlVGXVwQlxsV303o7otT5wZR+hSvM5vmRzOxGxOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F26FF68AA6; Fri, 21 Mar 2025 07:12:52 +0100 (CET)
Date: Fri, 21 Mar 2025 07:12:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/18] nvmet-fcloop: add missing
 fcloop_callback_host_done
Message-ID: <20250321061252.GA3198@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-8-05fec0fc02f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-8-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 11:40:02AM +0100, Daniel Wagner wrote:
> -	if (!tfcp_req)
> +	if (!tfcp_req) {
>  		/* abort has already been called */
> +		fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
>  		return;
> +	}
>  
>  	/* break initiator/target relationship for io */
>  	spin_lock_irqsave(&tfcp_req->reqlock, flags);
> @@ -982,6 +984,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
>  		break;
>  	default:
>  		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
> +		fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);

Maybe share this using a goto?


