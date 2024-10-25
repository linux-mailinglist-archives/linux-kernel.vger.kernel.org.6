Return-Path: <linux-kernel+bounces-381601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498C09B016D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DE61F22398
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC8A202622;
	Fri, 25 Oct 2024 11:35:34 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1DF20103F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856133; cv=none; b=LzsbFY/H2bABJC/uUgONTMYS5jklLc4tfG9IDa0YT8g6rZeIS+R7mL9uSyTU2BjYe2xKhP5dJCSWqY0uGep6yqYOL04J2zwTINQUjxtfJ4oEaRYqA43IbHLhOdGXO6b3tZhn3zQmO+RiNTBNM13BKM64695N/TqabS7dsl6AbOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856133; c=relaxed/simple;
	bh=yLCItyMxf1xNU+vD7VpaQ8sE0niUu581iltGIVBU5IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/22uP7FsxYdbUC9BPjCP70Wh5c3MpIBEd8fyPGOahpsN1oW4MNF/YnR+bIMbjlu5PW3Ya6caRn7iDGz1OPd9iYcXBdUqpJTkYyWSbFEO4xEKcPBUYkQ7z85h/Z9rV0IhAst4UDAF1Uh9wMbni17jQpMHDKvSGh2JOgGSK1F02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8FE37227A88; Fri, 25 Oct 2024 13:35:20 +0200 (CEST)
Date: Fri, 25 Oct 2024 13:35:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
Message-ID: <20241025113520.GA19521@lst.de>
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 24, 2024 at 07:33:07PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The Qualcomm SC8280XP SoC requires that all PCIe hosts are powered down
> before the platform can reach S3-like sleep states. This is very much
> similar in nature to the issue described in [1].
> 
> Other Qualcomm platforms we support upstream require more complex code
> additions across both the PCIe RC driver and other platform-specific
> ones, before the link can be sustained in suspend. Hence, they
> effectively need the same treatment for now.
> 
> Force NVME_QUIRK_SIMPLE_SUSPEND on all Qualcomm platforms (as
> identified by the upstream bridge having a Qualcomm VID) to address
> that. Once the aforementioned issues on non-SC8280XP platforms are
> addressed, the condition will be made more specific, with a PID check
> limiting it to only the platform(s) that require it due to HW design.

The NVMe driver is the wrong place for this, it needs to happen in the
core by making acpi_storage_d3() evaluate to true.  Preferably by
actually setting the right ACPI attributes because a check for 
PCI vendor ID absolutely will never do the right thing in the long run.


