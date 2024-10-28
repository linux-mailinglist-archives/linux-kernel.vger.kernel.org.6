Return-Path: <linux-kernel+bounces-384520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE1C9B2B38
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA241F20357
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C80198A29;
	Mon, 28 Oct 2024 09:19:49 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180C1922F6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107189; cv=none; b=ihA9DjCroy2lLB4I/3bX16ouDxr7R6lLClSCF07N9gwS1Oy8WI5sh+qgw+/rrvG7TdBfXMJ73dWllfLmYizVl76yHJYcNfOMoYBgb87mKIxoEBfHqjZt30Qc9bur1eaiXnZlYuW/0xrqlGoxCv0Fo1eETnycZ/xLAMUkhZJ3lyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107189; c=relaxed/simple;
	bh=tC2mwotgycrCT5+R77leH0psd8567YDuYbO+vb9XUtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq+DB/8DBhKKkOTmwzE7FrbKj6072N8NQze/SeCYiSUoAFhnDtQti0J3NP5Gpz5tsIOVVGSh6o1OZ0i1nERp2L8AoBndvbt6OFqxkgb0PzuCialMKqgPY39MliJ1I2duxxZ0C+Mgmjc4+tzskQmj6laztU/+l8LnHi8gfEFp63U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 039F268BFE; Mon, 28 Oct 2024 10:19:41 +0100 (CET)
Date: Mon, 28 Oct 2024 10:19:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Christoph Hellwig <hch@lst.de>, Konrad Dybcio <konradybcio@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
Message-ID: <20241028091941.GA29461@lst.de>
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com> <20241025113520.GA19521@lst.de> <0fac5de3-3f35-4fc2-bbdc-411dc1018a85@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fac5de3-3f35-4fc2-bbdc-411dc1018a85@oss.qualcomm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 25, 2024 at 05:30:05PM +0200, Konrad Dybcio wrote:
> (Un?)fortunately, said platforms use FDT, so we can't fix that in ACPI.

Then generalize the acpi helper to a generic one checking ACPI and
DT and specify a proper DT binding.

If th requirement to put all devices into D3 is a plaform propery
a specific driver is always the wrong place for it.

> b) Adding such a property to the PCIe host node sounds a bit
>    saner, but the NVMe code isn't aware of the RC. We could add
>    something like:

Again, this all belongs into core code.  The nvme driver is just
a consumer of this information, just like for example the AHCI
driver.


