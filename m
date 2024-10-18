Return-Path: <linux-kernel+bounces-372084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1B09A444C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA411B21C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A025A2038BF;
	Fri, 18 Oct 2024 17:07:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013E714F136
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271246; cv=none; b=HYhYQ8YrwbrNEYhzPxydwgqXBtZV8US937PO0izzxwECqEcfxKXHQ5Ubd0nDjt4+hIwN2x++aG7ystDzGEWqsr3EA7xP3IUl2o+trU83s1946JyyTBzEfT6ExkliVf3VXMxdXQxQJKlMGTfCgYWAs007mSQaZJ3aYElVBacrdVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271246; c=relaxed/simple;
	bh=CuGdVK1w7PiY/gjlLOe7VQNFKjvGPPG2aAu3muRUTzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DW4MH59PWQ57tyYT1NHQBd6t/BYzUSRl777JLckrn9voz2l0sY+yi9eScxFvEzTUo+l/lYULz9OPHp6ZVqFaJBrU694qmuHM6WQGfk5aR77y1nSyhxHo2O9k0r1zJQBQTraJ0LOzgzWHZn/LDljTvOkBdEftSGrWugDKjhPDxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEC3EFEC;
	Fri, 18 Oct 2024 10:07:52 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0CAE3F528;
	Fri, 18 Oct 2024 10:07:15 -0700 (PDT)
Message-ID: <3649810f-5f52-4af8-ab8c-503ddb594691@arm.com>
Date: Fri, 18 Oct 2024 18:07:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/40] x86/resctrl: Remove data_width and the tabular
 format
Content-Language: en-GB
To: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-7-james.morse@arm.com>
 <Zw76wLvdGax2eSiP@agluck-desk3.sc.intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <Zw76wLvdGax2eSiP@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tony,

On 16/10/2024 00:29, Tony Luck wrote:
> On Fri, Oct 04, 2024 at 06:03:13PM +0000, James Morse wrote:
>> The resctrl architecture code provides a data_width for the controls of
>> each resource. This is used to zero pad all control values in the schemata
>> file so they appear in columns. The same is done with the resource names
>> to complete the visual effect. e.g.
>> | SMBA:0=2048
>> |   L3:0=00ff
>>
>> AMD platforms discover their maximum bandwidth for the MB resource from
>> firmware, but hard-code the data_width to 4. If the maximum bandwidth
>> requires more digits - the tabular format is silently broken.
>> If new schema are added resctrl will need to be able to determine the
>> maximum width. The benefit of this pretty-printing is questionable.
> 
> Agreed. It's particularly non-useful for L2 resources on systems with
> hundred+ cores. The L2 line in schemata is very long and doesn't look
> "pretty" at all. Padding may make it even longer.


> It never worked with the mba_MBps mount option because the field
> width wasn't updated for prettiness. E.g.
> 
> $ cat schemata
> MB:0=4294967295;1=4294967295
> L3:0=fff;1=fff

Good point - I'll add that the commit message.


>> Instead of handling runtime discovery of the data_width for AMD platforms,
>> remove the feature. These fields are always zero padded so should be
>> harmless to remove if the whole field has been treated as a number.
>> In the above example, this would now look like this:
> 
> Huzzah!
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Thanks!

James


