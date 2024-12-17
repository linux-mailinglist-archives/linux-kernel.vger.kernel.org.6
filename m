Return-Path: <linux-kernel+bounces-449034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AFC9F48CF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4CD7A3C59
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159C21E5726;
	Tue, 17 Dec 2024 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ZfXbkZaL"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3A1E3DF4;
	Tue, 17 Dec 2024 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431102; cv=none; b=IVSLRsXwUjvPysUo4Q4dI79jBoRZFLpP0fIC+vSNkcAtNtqKh4NfxmmT1+QiQVm/7MK0lNJkOELB+0uME/gsv1s3u/TCNCv6n8ITB1HuYEeQkYXMfQywDpmkEzyFvPDIEPev7NnTKPXJQsAuX9QvY4IEPV4nwOgmITx6Aga/4x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431102; c=relaxed/simple;
	bh=fvOxptUDJkKhRMg6B7X5L307c4AE27xkBnHRuUkedDU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsvXQfAc8BVlLEN6q1NMD6Ng0rnxOxuIK92tc0VS4AS8H4Y8SixP02A/0jWTLmzmTxrZQHAC8LZkPxM1tRBj/xr6JW3reeZ9DEiSoExSsitxomxAStXXZCg8sJFZyprdxRRI3bWcuZF3RPdWnumFEpmiMlS8ccEhpwLc/i8TZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ZfXbkZaL; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH59Kkr017522;
	Tue, 17 Dec 2024 04:24:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=qlg9VacJZiR6r1+ghW
	Nbp56zd1uNub8WDjVBF3OucJM=; b=ZfXbkZaLKmBqvyWIHxB2iybSp7ZQH/BhRX
	R12rbJLpR9DB141pxnjCTF8vB7jTz0HSMWRwAVmeeZS1Z7H+kjhkLigpaDLniuLA
	rvv0gnKrN3yTtSZPzFtwr2tY1/2iJZRNZecjI4kCtT1wG3KSAiGTER6le+dDT2LW
	1i2ILf9kb/koXCoRlgc9Liqo5nDFaCdoi5KuAB97b+C+ZXF+xH8u3Y+dPTdNWoy1
	Qph/d2EnjR8+V9f1jdZsFBEuhJN70LmT/ebuf/FLlRvXlnjLzfOoSp26oHraBn7V
	dIMrsEJCRtByN3TXCVS0KFBUWHPqpaWoDoV6KP9CB/vAWirZMuqg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 43h8a237gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 04:24:37 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Tue, 17 Dec
 2024 10:24:34 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Tue, 17 Dec 2024 10:24:34 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id B1D0B820248;
	Tue, 17 Dec 2024 10:24:34 +0000 (UTC)
Date: Tue, 17 Dec 2024 10:24:33 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
CC: <vkoul@kernel.org>, <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH] soundwire: intel_auxdevice: Don't disable IRQs before
 removing children
Message-ID: <Z2FRYfHoHX4Dv+C2@opensource.cirrus.com>
References: <20241212110221.1509163-1-ckeepax@opensource.cirrus.com>
 <3eb98099-75da-4464-97d1-9e8538375e34@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3eb98099-75da-4464-97d1-9e8538375e34@linux.dev>
X-Proofpoint-ORIG-GUID: EsSGbeVkrS5v4q5LqwshsvR3Zb2aVO26
X-Proofpoint-GUID: EsSGbeVkrS5v4q5LqwshsvR3Zb2aVO26
X-Proofpoint-Spam-Reason: safe

On Mon, Dec 16, 2024 at 11:35:23AM -0600, Pierre-Louis Bossart wrote:
> On 12/12/24 5:02 AM, Charles Keepax wrote:
> > Currently the auxiliary device for the link disables IRQs before it
> > calls sdw_bus_master_delete(). This has the side effect that
> > none of the devices on the link can access their own registers whilst
> > their remove functions run, because the IRQs are required for bus
> > transactions to function. Obviously, devices should be able to access
> > their own registers during disable to park the device suitably.
> 
> What does 'park the device suitably' mean really? That sounds
> scary. What happens if the manager abruptly ceases to operate and
> yanks the power? Does the device catch on fire? On a related note,
> the manager should *never* expect to find the device in a 'suitable'
> state but always proceed with complete re-initialization.
> 
> It would be good to expand on the issue, introducing new locks
> is one of those "no good deed goes unpunished" situations.
> 

I would agree that one should never make hardware that needs parked
to avoid damage, but people do stupid things. Also, it doesn't
have to be as catastrophic as that, it is usually a case of wanting
to move the device into its lowest power state, turn off regulators
on the device etc.

> > It would appear the reason for the disabling of the IRQs is that the IRQ
> > handler iterates through a linked list of all the links, once a link is
> > removed the memory pointed at by this linked list is freed, but not
> > removed from the linked_list itself. Add a list_del() for the linked
> > list item, note whilst the list itself is contained in the intel_init
> > portion of the code, the list remove needs to be attached to the
> > auxiliary device for the link, since that owns the memory that the list
> > points at. Locking is also required to ensure the IRQ handler runs
> > before or after any additions/removals from the list.
> 
> that sounds very detailed but the initial reason for all this is still
> unclear.

If you want, I can add the exact reason I am adding this change to
the commit message, which is that regmap IRQ sensibly masks IRQs
as they are removed, so when the cs42l43 removes one sees a bunch
of failed transations, as the bus has broken. But to be honest I
feel like it is overly specific, one could construct any number of
similar situations, the real problem here is it is completely normal
and reasonable to want to communicate with a device in remove and
we should support that.

Thanks,
Charles

