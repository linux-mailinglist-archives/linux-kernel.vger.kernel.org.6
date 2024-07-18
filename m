Return-Path: <linux-kernel+bounces-256695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EE993520D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C973B2821F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB89E1459EF;
	Thu, 18 Jul 2024 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnX7RWM6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2A953E22
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721330064; cv=none; b=Qulwkcy2UnorTfQ+C+ZBOsn+9xBhM/LuwLC8fiQUuaqnTWG6fxk3nf05mgpqiH6QqvhRu56/TiTcDBO0PBcGkQ11uz3zYdcrtQGaWZTfjh9Nc/KmtmAunTPtAdYSjNyzLwBFomDWecZQK9UjZQN/1vnrB51k+X172iffHh21Lug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721330064; c=relaxed/simple;
	bh=hjw2ZHoWiAAWYOiH3UPbafpIIzKkmrgLJRhk4yJ82G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHYjz21uvU+T4iYIcPcCi292ztTgfMCLRPVOh0FdqbxEqIqDEy2IInOD+4QBSoA7L3Hm/VbFg2Oau/3eUUvDdJONAyjHayE+CGedwMp1GQk81oo5euXakpTXgX0jvlQCrdtapA1J9i2qZndxj7gYipsj4BL3814whqpRnryZUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnX7RWM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6971C116B1;
	Thu, 18 Jul 2024 19:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721330063;
	bh=hjw2ZHoWiAAWYOiH3UPbafpIIzKkmrgLJRhk4yJ82G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tnX7RWM6+lksDboMwSPGdwb6e1sP9iabDwBZJMh8Hf52hZp7aIkbYsSgMLf5FVQSg
	 172/yMT7pomiTNl4lyzg40Pl7x6KkeaAGFpyHkGiapiKCHpvnf+eshnv3j88hMvL3e
	 qxnbC1jmXLRytwvPzLHSTYTMUhtGfbbMVElDQTcjspSRyP18mmfWDPI4jIuG0svlKZ
	 MdxGIcMymW6gy8EYCRSD3YVVJQE/rGmqMZC09bZC3b6Dj/NOBlWhgYZb5fIUtKOhmS
	 qmX/GBLjhYthQy8iK/CLyhNTWbHSPJRbRiW8FQXPiYinHxU1CDJX9zmDx5el29FVtF
	 /+xkFq4al4JzQ==
Date: Thu, 18 Jul 2024 13:14:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Martin Wilck <martin.wilck@suse.com>,
	Ayush Siddarath <ayush.siddarath@dell.com>
Subject: Re: [PATCH v4] nvme_core: scan namespaces asynchronously
Message-ID: <ZplpjJqx0lySDzx-@kbusch-mbp.dhcp.thefacebook.com>
References: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
 <Zpgtr33uqbMogK7c@kbusch-mbp.dhcp.thefacebook.com>
 <6629583d-4681-49bc-8a7c-a87c3051c30b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6629583d-4681-49bc-8a7c-a87c3051c30b@gmail.com>

On Wed, Jul 17, 2024 at 09:10:23PM -0500, stuart hayes wrote:
> I agree, you aren't missing anything.  Thank you very much!  If you want
> me to submit a new patch with this and Thomas' changes, let me know.

No problem, I've folded in Thomas's suggestions as well, pushed to
nvme-6.11. Thanks!

