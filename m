Return-Path: <linux-kernel+bounces-231234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB309187F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3286DB23EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080E218FC7E;
	Wed, 26 Jun 2024 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN4JmXCc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE4B18F2FB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420868; cv=none; b=CqrwSqZf7/RyA/4mjACB6GlLL9Bmr+8kNyNtR0aQBtZwN2C8XtmIH1uxgtmxPe1Ua93G5an16iv0qA7OvIe+0a/k0eRZe1t+U3Nh6zE+b1VYKfWM3N/gNtfCnhbupqgHThoiKb98EWMsEZw1lX5+LECURmaMWT/ayqy+8yI7Jz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420868; c=relaxed/simple;
	bh=vuQ95v/XobD4p57iVF+boo7bRhPNg5WjVwCG2jX4hE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tK57R+wcVpj+nLJBwOy7uyjnQsD3HJDvLcYIaJdSVdvJNBzDQnTjmQRET3PoTIlPBhnFgLVxbAMP1taWJx2ropYIYyd0VvLbz9+Z2I2iQlLZcpMRBj3pbCwjRBIZWjcwIwfLCSp4aXw0m7yRzOaEnGLKv9IdqcjluPJ7LE0NH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN4JmXCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBC4C116B1;
	Wed, 26 Jun 2024 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719420868;
	bh=vuQ95v/XobD4p57iVF+boo7bRhPNg5WjVwCG2jX4hE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LN4JmXCcpc3Ja5dPcrcqKeuOqyyAboTn8KDXhrHKF1MoH62+We4Uw4w9CHP7yWrZP
	 tbJHxcaLCqaMBujOOK2526j21K9Mi5MNA97OO0213urR/YAWepIeqrFSj5nyw8tsjK
	 mjcAfh2NmTsm6i28ux2HmerKXgtI+O1gdm8qjLLYhVno9FVjOFS9YQEE/MQSAVjRQB
	 qRSNojsTISMxz/vMIoWt1KaAXWwaMbqYoWla6/tP6u2IXHxwpgCr8JM28Rfu/Uaa1N
	 XuRo3bqH4Klfo66yXyPUeRGgrp2SBaBNfBHmCC3CRE7YnmW4GP/VsYUeCG7ZaMPPWk
	 JMKpTqmEt1Jjw==
Date: Wed, 26 Jun 2024 10:54:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, emilne@redhat.com,
	jrani@purestorage.com, randyj@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH v8 0/2] nvme: queue-depth multipath iopolicy
Message-ID: <ZnxHwNflN3l9EN8p@kbusch-mbp.dhcp.thefacebook.com>
References: <20240625122605.857462-1-jmeneghi@redhat.com>
 <ZnryTZqwlz61s0D4@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnryTZqwlz61s0D4@kbusch-mbp.dhcp.thefacebook.com>

On Tue, Jun 25, 2024 at 10:37:33AM -0600, Keith Busch wrote:
> On Tue, Jun 25, 2024 at 08:26:03AM -0400, John Meneghini wrote:
> > Please add this to nvme-6.11.
> 
> This looks good to me! I'll give another day for potential
> comments/reviews, but I think this okay for 6.11.

I fixed up the suggestions from Christoph while applying. Thanks,
patches are now in nvme-6.11.

