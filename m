Return-Path: <linux-kernel+bounces-214982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10AF908CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F51D1C270E1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691751A291;
	Fri, 14 Jun 2024 13:59:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C70017BBF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373591; cv=none; b=tKATzyfQfD1m3Qh3b0mhGMltD8AqfokLwJGdP4UF0VvjzTL+8J1Ng517Pde5TqPHKLNKqpQ3WgjDjKlnGe6Isneg8Rdr0GXZd+4iRXYVvUZkp6lVp2SPAQsgy4sPFRcfFeVy24ksiRLjQekN6ZBkYugO1uVMKpCme5hGH3LBNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373591; c=relaxed/simple;
	bh=eSL6R6gPnLa90fKl76Z8ZljcuJVJNJ3a2a05sj7PkaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evtWxABk5ejBghKI8LiJOv//NNEevOB+eQGXvhL6Z44gK6DJdGPv2wb2eRgRfW3MFdbQ088kQMRRYMtZd4MDZtY2jeY2lQ6eXi2RjdMqlw2BR/Du2apX9/xWGNYshX+aqKa+Ja5F+CQZ2VJmEuqg0LPd9aweSM7NIK7c01kz2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93317FEC;
	Fri, 14 Jun 2024 07:00:13 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28AE43F8A4;
	Fri, 14 Jun 2024 06:59:45 -0700 (PDT)
Message-ID: <62d59c45-c154-43ed-86ad-c2d2461054b6@arm.com>
Date: Fri, 14 Jun 2024 14:59:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 31/31] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
Content-Language: en-GB
To: Dave Martin <Dave.Martin@arm.com>, "Moger, Babu" <babu.moger@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-32-james.morse@arm.com>
 <99ac181d-d93c-4b11-84aa-48953d9eb5a3@amd.com>
 <Zh/gA29yEpbinEPh@e133380.arm.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <Zh/gA29yEpbinEPh@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 17/04/2024 15:43, Dave Martin wrote:
> On Mon, Apr 15, 2024 at 03:44:48PM -0500, Moger, Babu wrote:
>> James/Dave,
>> This is a huge change. Can this be broken into multiple patches?
>> It will be a major task in case we need to bisect to pinpoint any issues
>> later.

> I guess this might be possible, though when moving groups of static
> functions around that refer to each other it might be more trouble than
> it is worth.
> 
> I'll need to discuss with James.
> 
> Either way, I think this patch will need to rebuilt when spinning v2 of
> this series.  I've been rebasing it by hand, which is not exactly
> foolproof!
> 
> It ought to be possible to break this up into one patch per affected .c
> file at least, if people feel that it is worthwhile.

That is how I keep it in my tree - but the intermediate entries don't build, so its only
useful for keeping my sanity.

I don't think the intermediate points are useful, it would be better to spend the time
generating confidence that this thing doesn't introduce any functional changes - if it
does, it should be reverted.

To that end:
So far I've done this by hand, but recently cooked a python script to generate this. I'll
include this in the next version instead. Hopefully this is a better way do demonstrate
'nothing up my sleeve' - it certainly makes it easier to regenerate this after other
series have been merged.

Obviously I'm not expecting this to be merged as is - as suggested in the cover letter we
need to find a least disruptive moment.


Thanks,

James

