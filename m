Return-Path: <linux-kernel+bounces-570770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F0AA6B44F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F817AA8B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57CC1EA7C1;
	Fri, 21 Mar 2025 06:15:37 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220F28836
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537737; cv=none; b=hS4ZeuoQm7JRrpw4UOwHT+4EQ2oXq1c1UYeNemOFZf/wlDdumNIiYdLNJew9c2S9TLAL0/CayiR4gL9dizSMfdHRuNbGauCUtnIe1jSK7N35qKN1iTn6r4fPXdg9VbrnY+VRZjmgh4lBHFQpU9o8Yk5SOxWCjmBT8Fsn8hVJktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537737; c=relaxed/simple;
	bh=pYP8OU/E8Wj0kIH0dVBtl69I8XdWVVzdE5KU5CZeCE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pleuitnZhXz/pWKJ/feO0ztvxExqFxSEMJ1WbP3CzsMND4aIE8FWzEuCDQz7WIFzTPWsBAeItIn8xRcKGX6Kw/lZAxgRN/awJU7g4EwV599IwFWNvX46lH7FphzADC4C0QrDZOgXowLZhBzOS8BP505vV049h4TOFWegkoSJ7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5945F68AA6; Fri, 21 Mar 2025 07:15:32 +0100 (CET)
Date: Fri, 21 Mar 2025 07:15:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/18] nvmet-fc: inline nvmet_fc_free_hostport
Message-ID: <20250321061531.GD3198@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-12-05fec0fc02f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-12-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 11:40:06AM +0100, Daniel Wagner wrote:
> No need for this tiny helper with only one user, let's inline it.
> 
> And since the hostport ref counter needs to stay in sync, it's not
> optional anymore to give back the reference.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, given that the series keeps growing and needs at least another
iteration maybe just send out the trivial cleanups and fully reviewed
simply refcounting changes ASAP to make it easier to review?


