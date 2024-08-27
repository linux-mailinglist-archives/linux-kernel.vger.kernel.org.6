Return-Path: <linux-kernel+bounces-303287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF198960A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BDA41F215CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44FE1B3F2A;
	Tue, 27 Aug 2024 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fzUSfget"
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54691A0B1D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761732; cv=none; b=itdDBm6Iu8rcyRVBiYEWTSDj+syPTT+Y3h2cWpSXJQW/S3BZZcjHfPZvcY63tVq8pE0VI3gFgfrsSTcsQmhLQDPAvRuLeo+mw+JrAdjcQ0b+vGlgOWRIUzBKLXkCibhyCdfB2/Oin7QjWSMu9SHQsSyHhRXiAmz2JeIuIacpG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761732; c=relaxed/simple;
	bh=2My14gvGxeSZeJtg1BnnA8ta38YZp09dTB+gAu6TkFk=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d+Hcit7ZY369jIlUgOwCAQ4KzhjaffkuCGA1lT9IvWgloF4WCoq3dfeFszu72wYYoy+iKL1nAJqtAKUIuWx91uvWtcZX69RDPMWherBxGxFPNT++vtEqFKwbdaGB7xx1aVERIArXaRhmTntdotUMFh1i6cGQwnl50TUHumswoik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fzUSfget; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724761732; x=1756297732;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=43z38L9ck/FEEnaOFK+Qd+eA4TyH6kpruuxAhEBjErA=;
  b=fzUSfgetbQ19gVxe00wXOTo04WT8wmwMRF7Us+H6cQc/MRnRbQw2ceyn
   eTvW2DJu5sSdhyMR4QN7m8QMzOMqd4rpXgVWa0UmTP0zKP8/QkbAKElgm
   AjlQeJCXe/0l6oZtltKhx8RsTMWT8FwFSWxAW8Bgg/c5uFmlU96Aznk4K
   E=;
X-IronPort-AV: E=Sophos;i="6.10,180,1719878400"; 
   d="scan'208";a="655082231"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 12:28:48 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.0.204:63259]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.24.174:2525] with esmtp (Farcaster)
 id 0e9731a8-47bb-4d71-8b54-f4fd6c78971e; Tue, 27 Aug 2024 12:28:47 +0000 (UTC)
X-Farcaster-Flow-ID: 0e9731a8-47bb-4d71-8b54-f4fd6c78971e
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 27 Aug 2024 12:28:46 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (10.15.97.110) by
 mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Tue, 27 Aug 2024 12:28:45 +0000
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 99C8920A60; Tue, 27 Aug 2024 12:28:45 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<puranjay@kernel.org>
Subject: Re: [PATCH] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
In-Reply-To: <20240827121955.GB1607@lst.de>
References: <20240827121701.48792-1-pjy@amazon.com>
 <20240827121955.GB1607@lst.de>
Date: Tue, 27 Aug 2024 12:28:45 +0000
Message-ID: <mb61pjzg2gneq.fsf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christoph Hellwig <hch@lst.de> writes:

> On Tue, Aug 27, 2024 at 12:17:01PM +0000, Puranjay Mohan wrote:
>> +	if (meta_buffer && meta_len && bdev && !blk_get_integrity(bdev->bd_disk))
>> +		return -EINVAL;
>
> Overly long line here.  If we go past my initial RFC I'd probably
> restructure the function a little bit, i.e. add a new
>
> 	bool has_metadata = bdev && meta_buffer && meta_len;
>
> and then use that both for the support check and the actualy mapping
> below.

Sure,
I will send v2 with these changes now.

P.S. - It looks like we will need manual backports for stable kernels as
this won't apply directly. I will send them after this is accepted.

Thanks,
Puranjay

