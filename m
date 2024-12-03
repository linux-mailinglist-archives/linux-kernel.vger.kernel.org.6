Return-Path: <linux-kernel+bounces-429422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74A19E1BE9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F358167598
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85541F12EB;
	Tue,  3 Dec 2024 12:14:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75BE1EF0B2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228088; cv=none; b=Yp5m+IGDj/kaPd5hhZwFFk5rynLxGys5trOGHcZiz6//2YMFyGJlXSKQcJFHMec8ItGpV4pKMDRz8tTF6mdRdGTnFWtKYBbbEc6rjgVnRkLUj6anEv0UeCBDZbRAMH/RmQv6tT3yr1QZLg+PR2630jUqtAHwlIoLw80lyuiOMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228088; c=relaxed/simple;
	bh=oqZd/P3Fn1E9WzKcqeErAYO0bnFhHVIb5g6I9XtABuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTC/YNT1OG+LlzxUVEVu9a2dMduoyKCNk4nHu+sSItY7ZYT6NSrvAkRIz7t2nfg2jB7ZbST3+/Zlm5wzYz+q3eSFwnx2bvmdz6hKpZXZu8rXiL8m8LxuCb3L/YaV9DvfAyZvf4Mv1Ln7dqIgo9RVC8fxW28B+p3/5XIAb/A6kwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B3C8FEC;
	Tue,  3 Dec 2024 04:15:14 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 801D43F58B;
	Tue,  3 Dec 2024 04:14:45 -0800 (PST)
Date: Tue, 3 Dec 2024 12:14:42 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/3] firmware/arm_ffa: remove __le64_to_cpu() when set
 uuid for direct msg v2
Message-ID: <Z072Mm61eE_Twx1B@bogus>
References: <20241125095251.366866-1-yeoreum.yun@arm.com>
 <20241125095251.366866-4-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125095251.366866-4-yeoreum.yun@arm.com>

On Mon, Nov 25, 2024 at 09:52:51AM +0000, Yeoreum Yun wrote:
> From: Levi Yun <yeoreum.yun@arm.com>
> 
> UUID is saved in big endian format.
> i.e) For uuid "378daedc-f06b-4446-8314-40ab933c87a3",
> 
> It should be saved in memory like:
>     37 8d ae dc
>     f0 6b 44 46
>     83 14 40 ab
>     93 3c 87 a3
> 
> Accoding to FF-A specification[0] 15.4 FFA_MSG_SEND_DRIECT_REQ2,
> then UUID is saved in register:
>     UUID Lo  x2  Bytes[0...7] of UUID with byte 0 in the low-order bits.
>     UUID Hi  x3  Bytes[8...15] of UUID with byte 8 in the low-order bits.
> 
> That means, we don't need to swap the uuid when it send via direct
> message request version 2, just send it as saved in memory.
> 
> Remove le64_to_cpu() for uuid in direct message request version 2,
> and change uuid_regs' type to __be64 because UUID is saved in network
> byte order.
>

  |   warning: incorrect type in initializer (different base types)
  |      expected unsigned long a2
  |      got restricted __be64
  |   warning: incorrect type in initializer (different base types)
  |      expected unsigned long a3
  |      got restricted __be64

We will get this warning back with this change, wondering if we can take
up BE support separately.

--
Regards,
Sudeep

