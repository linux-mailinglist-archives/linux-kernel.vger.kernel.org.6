Return-Path: <linux-kernel+bounces-520636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A61A3AC88
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55BA17A3698
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393BA1DCB09;
	Tue, 18 Feb 2025 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKpxckDU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F219CC17
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739921436; cv=none; b=X6438S8ApG0DWnXt2PV85e3OKgMaLr2gvRYDvXVBxjzM5cj7WN9g26JXpLrdxM0ugARe1Q4IWXawvS8GM6WSebloZ0XWncW53QwawB+qXOrzShAqOdAWGSGk+Op6zHvnqJ3YexTsz1dtWknk/0VQhkIQ/UX/Vcl3ErKgNk8A47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739921436; c=relaxed/simple;
	bh=3jfQmyFQ0KDMA1mSMKOSU9E0eHnBhC6uavEihYVjEu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iwp7xGXFoSiQ50/vQqJ+rlrh6Ba/wmGtQsZSuNztNVW6GywG1QyevaIyO1JmXo2cw4NPY9R/KR9XScODAaDtD7CVwII5RgGfUQ6p+yelOBstArwnubXr7HLDe4k0YwDs8AWwDAXTTZlzLnYBMIGZKhPnjie+PU/jDXV/HZpA3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKpxckDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E351C4CEE2;
	Tue, 18 Feb 2025 23:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739921436;
	bh=3jfQmyFQ0KDMA1mSMKOSU9E0eHnBhC6uavEihYVjEu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKpxckDUZC3iQ94ikHGqNvnO6oX88QULGTf16h3QWyKUkHLWp/RBoVJ3R/k0uUxUN
	 CX31lA4J4rhtlc1OE1i9Uke2mMDJ6aLkKmvYNNGHaLLxAixalPKU46L6GDa7+iIarm
	 MnOAtl0X1akT5TFG70CJGbpcC9PIZs4OC2ASFL/8Ytua/sRCLasmhNH7BEsi0eBKWE
	 EE0YCSnpTx8FkuMPW+wsvAg59D1DHP6EEFAoYCrCr3zkHOWY6OOwAgXQqm6iuoHZhD
	 yuzHapHtBjqYQWfnluLBu0SqaDOxDZpIscXt3OYwsjFd/waLjER20ryK971yDH5wvm
	 n/3sHVT/bFpOA==
Date: Tue, 18 Feb 2025 16:30:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk, Randy Jennings <randyj@purestorage.com>
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z7UYGc25aKFL6oFj@kbusch-mbp>
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <9495391f-eb31-4da5-95bf-e5f8eaafee38@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9495391f-eb31-4da5-95bf-e5f8eaafee38@redhat.com>

On Tue, Feb 18, 2025 at 06:06:05PM -0500, John Meneghini wrote:
> OK, maybe you have a use case in mind. I'll assume you do: some
> applications want to disable native nvme multipathing and to see
> all namespace paths in user space, and they are using this parameter
> to do it. These are ostensibly user space MP applications.

You can have a ublk frontend device with individual namespace paths on
the backend, and let ublkserver do whatever it wants with them.

> So what happens when one of these user space MP applications needs
> a change or a bug bug fix in the kernel?  Are those patches being
> merged into the kernel under a different auspices... is it just
> DMMP that we don't want to enable support for?

I think patches exporting driver private information is a pretty clear
indicator it's for stacking drivers.

