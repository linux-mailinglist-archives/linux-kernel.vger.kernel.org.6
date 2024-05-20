Return-Path: <linux-kernel+bounces-183913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007628C9FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EF228500C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CA0137749;
	Mon, 20 May 2024 15:37:50 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA4FC01
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219469; cv=none; b=Ya71KW1g0rJZNVEtZpGR0pznShrYHu95EGjIBKNAJaq/5LP1GukME5SR0YW/HBbj4LdqWoNCmn5VxgkBL7MuclWo4cv+3lZHjopapgDDeuef5qyBoT8y/aqXVEObzYkBUwt9xQWorNcUoS8CC+vNkW1NunT2HimDPXZ5vTaXZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219469; c=relaxed/simple;
	bh=kxLV30ZR/FR45/xibVzF3X5JUn/83gl0e2qbK+KR8OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6HbzyZg28FTvjghgBmk5+B3T7nTC6QYEkLb8hwQ5LiYnA4zVfRmQyXJkL/qHq557LWZcsNd1YgGaguMGYmruv20TZK/MIZQDr7STwAOX/aWVhQTJzgBh4pO91axADgKb8+lI4mcda38ndDIipxyhgkHB265gPOl0NfsAXG2q/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 595D368BFE; Mon, 20 May 2024 17:37:43 +0200 (CEST)
Date: Mon, 20 May 2024 17:37:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <20240520153742.GB921@lst.de>
References: <20240510141459.3207725-1-kbusch@meta.com> <20240510141459.3207725-2-kbusch@meta.com> <20240510151047.GA10486@lst.de> <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com> <Zj6yvTxIpUnOXl7R@fedora> <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com> <87r0e7mt9w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0e7mt9w.ffs@tglx>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, May 12, 2024 at 08:35:55AM +0200, Thomas Gleixner wrote:
> That's expected as you pin the I/O operation on the isolated CPUs which
> in turn makes them use the per CPU queue.
> 
> The isolated CPUs are only excluded for device management interrupts,
> but not for the affinity spread of the queues.

We'll probably need a version of isolcpus that also excludes the
interrupt spread given that users are asking for it.  And I'd much
prefer that over adding radom module options to every driver to disable
managed interrupts.


