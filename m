Return-Path: <linux-kernel+bounces-214971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64336908CD1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A651C263B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9B88F40;
	Fri, 14 Jun 2024 13:57:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6752279CF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373479; cv=none; b=ujfm1OmPJeQLjVFkmyxm5OVVDQxhe3To4fxSF3EWnMnmahcRGakm+rX4sErHAlHIxjHCtXzR+ZJCh0UccT7cn4TSTa6fW8EswlXDlEM0QG8SjmJMTlBnlfd/zOV1tN9OejCoPf+/NgSYprsDEgklW5x9y4rA6+LyGh8goFaWRYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373479; c=relaxed/simple;
	bh=NLLHY0sm+/6nGzt9ZAvEWauMfCBit/rIFP7jShz2tCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+IvIhoOvUuH72bZMcXS/A5imIpmKDhGMVVLBK5wj+TjOBCKYd65EZjJ1AnK0sOAXr61dCa7aK6lZjhSkKvIBwJ2Y7eqlkZ1AST0Ygoqp6Q34Rp6A4z54PkkIXmTre+ek8awHOuKJezFkmzAUvCYF3RZ4sXUqip3sfthomV9gZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3614FEC;
	Fri, 14 Jun 2024 06:58:19 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D3453F5A1;
	Fri, 14 Jun 2024 06:57:50 -0700 (PDT)
Message-ID: <293d54b8-b664-4106-83e9-64ba8c504f32@arm.com>
Date: Fri, 14 Jun 2024 14:57:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 17/31] x86/resctrl: Move mbm_cfg_mask to struct
 rdt_resource
Content-Language: en-GB
To: Dave Martin <Dave.Martin@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-18-james.morse@arm.com>
 <966b7b32-6600-4b1f-9535-0298fedd57a7@intel.com>
 <Zhfwzh4sHvTYyTJ1@e133380.arm.com>
 <c96cdf6a-02a8-4ee2-91f5-e4329015e276@intel.com>
 <Zh/fqIFJDjsb1jYT@e133380.arm.com>
 <9e57c086-ce5c-403a-9134-9e2aa5124535@intel.com>
 <ZiE7w0P2CWQeXZ5F@e133380.arm.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <ZiE7w0P2CWQeXZ5F@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi guys,

On 18/04/2024 16:26, Dave Martin wrote:
> On Wed, Apr 17, 2024 at 10:18:48PM -0700, Reinette Chatre wrote:
>> On 4/17/2024 7:41 AM, Dave Martin wrote:
>>> On Thu, Apr 11, 2024 at 10:39:06AM -0700, Reinette Chatre wrote:
>>>> On 4/11/2024 7:16 AM, Dave Martin wrote:
>>>>> On Mon, Apr 08, 2024 at 08:21:24PM -0700, Reinette Chatre wrote:
>>>>>> On 3/21/2024 9:50 AM, James Morse wrote:
>>>>>>> The mbm_cfg_mask field lists the bits that user-space can set when
>>>>>>> configuring an event. This value is output via the last_cmd_status
>>>>>>> file.
>>>>>>>
>>>>>>> Once the filesystem parts of resctrl are moved to live in /fs/, the
>>>>>>> struct rdt_hw_resource is inaccessible to the filesystem code. Because
>>>>>>> this value is output to user-space, it has to be accessible to the
>>>>>>> filesystem code.
>>>>>>>
>>>>>>> Move it to struct rdt_resource.

>>> Maybe, but the bits as defined by AMD BMEC look rather architecture and
>>> bus specific, and I am suspicious that there is no guaranteed clean
>>> mapping between MPAM's config and BMEC's config.
>>>
>>> MPAM currently just has "reads" and "writes" (or both), though as for
>>> BMEC, the meanings of these are not fully defined.  I suppose finer
>>> filtering granularity might be supported in future (at least, it is not
>>> explicitly ruled out).
>>>
>>> James' current approach seems to be to pick a single BMEC flag that's
>>> in the right sort of area for each MPAM bit (though not equivalent) and
>>> translate that bit across to drive a corresponding the MPAM bit.  But
>>> I'd say that this is arch-specific configuration masquerading as
>>> generic configuration IMHO and not really generic at all.
>>>
>>> See "untested: arm_mpam: resctrl: Allow monitors to be configured"
>>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.7-rc2&id=db0ac51f60675b6c4a54ccd24fa7198ec321c56d
>>>
>>> I guess this needs discussion with James, since there will have been
>>> additional thought process behind all this that is not captured; either
>>> way, I guess it could be resolved after this series, but it will need a
>>> decision before the MPAM support is merged (or at least, before MPAM
>>> exposes userspace support for event configuration upstream).
>>>
>>> (If this has already been discussed and James' current approach has
>>> already been agreed as the least worst option, then I guess I can live
>>> with it; I just find it icky, and it looks odd to have AMD specifics in
>>> a common header.)
>>
>> I am not aware of such a discussion.
>>
>> Sounds like a motivation to delay this portion of the changes in patch #8.
>>
>> Reinette
> 
> 
> Ack, I'll discuss this with James.
> 
> I guess the thing to do will be to keep the affected definitions in the
> x86 headers for now, and carry the exports in James' MPAM branch until
> we figure out whether it really makes sense to share them.

I'm afraid this ship has already sailed. Nothing about the 'mbm_total_bytes_config'
section of Documentation/arch/x86/resctrl.rst says that this interface is AMD specific. It
just happens not to be supported on Intel parts, meaning no-one can tell the difference today.

Because the documentation doesn't say "AMD only" or "consult the lid of the box for the
meaning of the bits" - I expect user-space can expect this to work in the same way on any
platform that supports these files. As such, it has become resctrl's interface to this
stuff. We certainly don't want two different ways of doing this.


As MPAM can configure the monitors like this, I'm stuck between a rock and a hard place. I
can't invent something new - because existing user-space expects BMEC, and making these
bits generic is being questioned because its secretly AMD specific.


Mapping the BMEC^Wresctrl bits to what MPAM supports is my best attempt at supporting
this. The MPAM driver is all about fitting MPAM into a shape that can be exposed via
resctrl, so this is hardly out of keeping. (I could make the same argument about the
MBA percentages...)

The same argument holds for X86's event numbers. Some agreement on IDs for events is
needed between the arch and fs code - and we may as well stick with the X86 numbers today
- its certainly more convenient for the X86 arch code. Where arm64/MPAM or any other
architecture extends this, I'd hope to do it via perf where numbered events are already
understood to be platform specific, and there is tooling to support this.

For configurable events on non-AMD architectures? We can kick that into the perf weeds -
but we need somewhere to hang the fs/resctrl code that drives these files. I think
'is_AMD()' is detestable, and as these bits are uapi, they should be exposed for all
architectures that support resctrl.


Thanks,

James

