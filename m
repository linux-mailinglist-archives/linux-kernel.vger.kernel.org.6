Return-Path: <linux-kernel+bounces-259076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85689390EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8454028217C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424F716D9D7;
	Mon, 22 Jul 2024 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLLfWM/0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8776DC8C7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659586; cv=none; b=bWtQfrBDSFQUdgD6nFb7nTL3vsJMJfJsD17jBaob6mwSUVzcO3Rto36FZiXt4lhh/tYRQEAPoAB4jL7+20bSiN/uday7/ocYnoKi80IAAfCyPuMif5GcaM7KRr6ByUGmyO7N+vJ0t7p2f98kTGDSjvnI93ACHHVGYKt4HXQDoPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659586; c=relaxed/simple;
	bh=/hcAlppWRMQ4kBgz/1HNiIVC3fCjtz9gIVIM83KEraQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhDWY6K1V4/QaFCruaC2MaKZrFTxkTp6o38Zw46aNzQrMi0YvFh6FsuBYBx1BHgk+NjNPUYg2FlqiM8Sz6quOLRnq7Nu30aYzIB53T+Zntse05dPum+9m6ef0sewi+kePIKpMIBiY4Bz4a5rJur97r7N8fx9qk5yhze20btBeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLLfWM/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57265C116B1;
	Mon, 22 Jul 2024 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721659586;
	bh=/hcAlppWRMQ4kBgz/1HNiIVC3fCjtz9gIVIM83KEraQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLLfWM/0pVGMZkkHgUa5pAD5bbMa5puua7grNkCGSN+enk/ac+WHFYF9lC8wc0ijO
	 7uX0G9M7SxatsFKwigQQF02nxdb6apcNxMLev2+946U5GSmjlN8/f9S2GzLcT+23bb
	 Q3Sqy9uvwJAtKNye0xuG58Vep3USTPTdZZo3uC0e4X2Yy9H5ANQEK6jF4LnDDzbfvX
	 6B30J4O7UtUeMtDYwscx3UpJcUkGW7j+DTtkhU0DIfQklY+AXhzG/6cFGfmfHOzm/S
	 KY4AvD/Nj1iiM3UNRIaW++my3zDXzY7lhpg3ua5JzMO5b9IlkFJXFd5zBSc/U8W+Ix
	 B0HQpkYjPmtWg==
Date: Mon, 22 Jul 2024 08:46:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Martin Wilck <martin.wilck@suse.com>,
	Ayush Siddarath <ayush.siddarath@dell.com>
Subject: Re: [PATCH v4] nvme_core: scan namespaces asynchronously
Message-ID: <Zp5wv_cPBvijRUSV@kbusch-mbp.dhcp.thefacebook.com>
References: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
 <Zpgtr33uqbMogK7c@kbusch-mbp.dhcp.thefacebook.com>
 <6629583d-4681-49bc-8a7c-a87c3051c30b@gmail.com>
 <ZplpjJqx0lySDzx-@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZplpjJqx0lySDzx-@kbusch-mbp.dhcp.thefacebook.com>

On Thu, Jul 18, 2024 at 01:14:20PM -0600, Keith Busch wrote:
> On Wed, Jul 17, 2024 at 09:10:23PM -0500, stuart hayes wrote:
> > I agree, you aren't missing anything.  Thank you very much!  If you want
> > me to submit a new patch with this and Thomas' changes, let me know.
> 
> No problem, I've folded in Thomas's suggestions as well, pushed to
> nvme-6.11. Thanks!

On further consideration, this is a bit late for 6.11 inclusion. This
one could use time in linux-next, so it's top of my stack for 6.12 once
that branch gets created.

