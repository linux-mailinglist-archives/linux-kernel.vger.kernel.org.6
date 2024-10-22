Return-Path: <linux-kernel+bounces-376526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5761E9AB2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1845D281D41
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E651A705B;
	Tue, 22 Oct 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAKEv18a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AB513AD3F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612290; cv=none; b=MGLIHY+foiCNvPhIk/QXXcV3xSmTAm/bjHjg2yagm4TjfrLhYO32trOlcCBqzqe+WkkB8HPmP0QCyPzVaKF+MO/Kv4d/OVv8M8RnTGnF8USPUq7XXBWMzULnHnRuwmaGDtADl/FnBCjFhmIIfmPatcI2SXsVlFH/KeMrlVVfVfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612290; c=relaxed/simple;
	bh=TGHjo7ux9zVk06eBs97w3tERf69Lss5aal67kmZ/qvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aclftkv1OEBwKtsutuFd/0mWgegulKrHXpKX27jRdzxzysSJGYyYAdaLUYWteDNL8vHig/uejETMNXx94m1rqd086VDh50h3gMYUh6qIUcvDzYvLVW/De1MDzVR79vZJMqjUug9c2l5q1mUyo75rCGePgEJPGQSeY2nBSLIJQ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAKEv18a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58066C4CEC3;
	Tue, 22 Oct 2024 15:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729612288;
	bh=TGHjo7ux9zVk06eBs97w3tERf69Lss5aal67kmZ/qvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAKEv18aNEbvsQBh5hFl8/aXagEFU4NGr4xRcRvMjxC/B1Oj5Sy3wjcH/0HeIuw8L
	 ixG6CcMItIKGkns2J5BUxItEJng76RDtNpgrXEK3rs/apDEOIpmJr7oDjVjr1oCORi
	 m+Dxqfn3X+pcNqvVmfhPoCVfPfK7+LLGUVRPBo1Lt6qSDNRi3SAabZ+xfQXHlya8Yb
	 mt0bImaaQL3RmQbQ2OMjDhNe1jtm8RsiSTZvsYca/S5CaIvWoETwu5w2oZ1sjpIp5h
	 9lT8KeDAgWjy2gnjnL/JIqE8UwUxxLcO9TTlZlxhZhY3kfDTCNuiqp7a1RxFt13Tjr
	 MYIKmhxrGtC4w==
Date: Tue, 22 Oct 2024 09:51:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Prashant Malani <pmalani@google.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring
 namespaces
Message-ID: <ZxfJ_TfT7MMGWs4X@kbusch-mbp>
References: <20241016213108.549000-1-abhishekbapat@google.com>
 <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
 <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com>
 <Zxe8e2zS5dA61Jou@kbusch-mbp>
 <6b00d25e-fe6a-4552-9945-d6181af83137@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b00d25e-fe6a-4552-9945-d6181af83137@grimberg.me>

On Tue, Oct 22, 2024 at 06:35:11PM +0300, Sagi Grimberg wrote:
> On 22/10/2024 17:53, Keith Busch wrote:
> > On Thu, Oct 17, 2024 at 02:32:18PM -0700, Abhishek Bapat wrote:
> > 
> > The request_queue is owned by the block layer, so that seems like an
> > okay place to export it, but attached to some other device's sysfs
> > directory instead of a gendisk.
> > 
> > I'm just suggesting this because it doesn't sound like this is an nvme
> > specific problem.
> 
> Won't it be confusing to find queue/ directory in controller nvmeX sysfs
> entry?

It's the attributes of the request queue associated with that
controller, so I think a queue/ directory under it makes sense. That's
how it looks for gendisks, so why not for disk-less queues?

Many queue attributes only make sense for gendisks, though, so maybe
need to tweak visibility if we decide to do it like this.

