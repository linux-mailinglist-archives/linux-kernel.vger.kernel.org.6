Return-Path: <linux-kernel+bounces-570773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429DBA6B454
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DA73B4E43
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCD31DEFD2;
	Fri, 21 Mar 2025 06:19:09 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD468836
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537949; cv=none; b=t0qbQv3WViMnewtxT1Eo48L4XzkSUecJ6PiCgM6dTCH+pvjjLYs2ELGyVO0jkD+NstFyQzvjbyHb/ApAh5+WCnyAJpCD7UWims3L4kLsLXND9QIJixy3b2lFo2b4P0ti6wwoBv9tODHZj5XRRqayTV9xu3/iw76QzRH40Ds7Q48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537949; c=relaxed/simple;
	bh=OiPWheBq4sIn/7ldeutLnNLNBywJ8KNi8kKiRFNSx8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZS2XF3q16NFnGwaj36WBsQ6gYOGwtnwG/NUEx/pK5eB/q8macdRo3XcSkjw8vFX0qpnpYB/GoZgsQkApOVnad7kCr7B348C9IBWfPTNRUKjM+PuatG8LCb6gtDbhstO+j1w5U891QpCJ+vCamFJU63AvPLqX5mb1iFO6M187gI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E317768AA6; Fri, 21 Mar 2025 07:19:03 +0100 (CET)
Date: Fri, 21 Mar 2025 07:19:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/18] nvmet-fc: free pending reqs on tgtport
 unregister
Message-ID: <20250321061903.GG3198@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-15-05fec0fc02f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-15-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 11:40:09AM +0100, Daniel Wagner wrote:
> nvmet-fc: merge with f200af94ac9d ("nvmet-fc: free pending reqs on tgtport unregister")

What is this supposed to mean?

> +	for (;;) {
> +		lsop = list_first_entry_or_null(&tgtport->ls_req_list,
> +						struct nvmet_fc_ls_req_op,
> +						lsreq_list);
> +		if (!lsop)
> +			break;

	while ((lsop = list_first_entry_or_null(&tgtport->ls_req_list,
			struct nvmet_fc_ls_req_op, lsreq_list))) {

> +
> +		list_del(&lsop->lsreq_list);

Another case where I'd really love to help the list_pop helper Linus
flamed me for :(


