Return-Path: <linux-kernel+bounces-176002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E16B8C289C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF57B23ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64039172761;
	Fri, 10 May 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnNrBJye"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95721A2C3A
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715358005; cv=none; b=msVXS9hCYCz6n2o2Iiv0naPahHyhRSz/d53SQ7SRppbyrE5No6HodWCbMaS5zDxjn98MndvX/VmXgeca3WVL3OkkAd+qTReyOJVpv1tQfTT45p1Lfo4Pjj5Ya9ugdQ9aaOBUV5rNzWaUUuzGvfss3x1TOViF5NRQIfKhKi9ZnOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715358005; c=relaxed/simple;
	bh=CF8Nf3rfqr2ncS/J0xp4oHnRS2E3OUw0FJDGJKNSq/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtVWwgp57ICC5g4jxZU3mU69gdNPDLDSk6hFbiWFDRoMSZhiYpGbZ81dZM/LyinuuI7f/bSvj47qy2VSYdTyG1qVftEJUPEWgIMKhiUGcZB+XAEP5Nu2S8sbhmLmatKM9ZyGqzc9EcZZKdgH6JnIErzA2q+dRZLV+U/ChoWD8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnNrBJye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B721BC113CC;
	Fri, 10 May 2024 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715358005;
	bh=CF8Nf3rfqr2ncS/J0xp4oHnRS2E3OUw0FJDGJKNSq/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnNrBJye4r8wFkX4YaHhnzSf6Bj+yeERi0onolrcgAKGavgSIbw4SjvRooP+Gzpw2
	 kd8BTX6RWWVo6C1cKeItxfFCxv7hXCfNbBOHxXhCJoYUftI1PtScLxHkaEGVGmqRLB
	 c5fPQHLIK55ILI+j177+w+GYhYi+lz83hB1i8gRTVQtGLqtB1MoDjDdmWYLYtl9uod
	 eSrZpLTWE/33O3xd5dusWN4o+GtwsFPu6UyULIz9RvPQp3ltTPxn5n8NLiC5F0/AO2
	 1NEoqh1VnO+SubjSRRkSAfH8iX364gA9mhoDibbx6pZc+AUti2p3c6chKQ5XfzUxXF
	 QUqlw+bE2Ul7g==
Date: Fri, 10 May 2024 10:20:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	ming.lei@redhat.com
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com>
 <20240510151047.GA10486@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510151047.GA10486@lst.de>

On Fri, May 10, 2024 at 05:10:47PM +0200, Christoph Hellwig wrote:
> On Fri, May 10, 2024 at 07:14:59AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Some people _really_ want to control their interrupt affinity.
> 
> So let them argue why.  I'd rather have a really, really, really
> good argument for this crap, and I'd like to hear it from the horses
> mouth.

It's just prioritizing predictable user task scheduling for a subset of
CPUs instead of having consistently better storage performance.

We already have "isolcpus=managed_irq," parameter to prevent managed
interrupts from running on a subset of CPUs, so the use case is already
kind of supported. The problem with that parameter is it is a no-op if
the starting affinity spread contains only isolated CPUs.

