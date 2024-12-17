Return-Path: <linux-kernel+bounces-448568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 244299F41D8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1FD164C49
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A17314F11E;
	Tue, 17 Dec 2024 04:55:35 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5629613777E;
	Tue, 17 Dec 2024 04:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734411335; cv=none; b=QeyDi4flzxygmzrZbMRsw1eO6JBdfCDzoVusPCFv5tSnAFhFLFe/V4sgO90qGmOJ39bZI67T009x47pjPTbU+kOWYubt2xTp4XvXZ5sW26luqbmUU63n51JpP+UDL8Xh3rWfrdcR8WmdGwgfSCbrobLYfpL6WuvVV3g6pt0O+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734411335; c=relaxed/simple;
	bh=738IlYxdBPF9gCox1lkth0MSWywe9FmjspwmBXnR8FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVSLqovUcGulNyF4shYgpyPtZYJXUeqn3t5mJJhykHA+83gsdH5/zRNO2scCjGX/4g5AgyVTFYoBgnQCL0tMUUIGpLmFopTacaQpDVv/PKjBGS5OB1y5u09yiT9jBgpRxsHie8g/Gd+8Sdv8WQG5TWgg5nEAQ8oJ6gOh7R/6YeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6443968BEB; Tue, 17 Dec 2024 05:55:28 +0100 (CET)
Date: Tue, 17 Dec 2024 05:55:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <20241217045527.GA16091@lst.de>
References: <202412122112.ca47bcec-lkp@intel.com> <20241213143224.GA16111@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213143224.GA16111@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 13, 2024 at 03:32:24PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 12, 2024 at 09:51:45PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 49.6% regression of stress-ng.aiol.ops_per_sec on:
> 
> This sounds like there is some other I/O path that still reorders,
> which got messed up.  What storage driver is this using?  The repro
> material talks about an ata disk, but I'm still curious if it's ahci
> or some other driver, or a SAS HBA?

Do you have the information on what hardware is used for this test?


