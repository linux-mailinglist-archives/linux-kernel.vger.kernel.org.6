Return-Path: <linux-kernel+bounces-272890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F04094625E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA752B21DA6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BF015C126;
	Fri,  2 Aug 2024 17:22:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF73616BE0C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619337; cv=none; b=Qh1nI6IQeIE4ANyfySQXODkM0e5xN2zxkBxWgWw8u/DlRXTVRcCbGtOCObVQr1VCioIQIzQrBlLSxbo4C6lQOvSKYoTHKrBxvtjOaG03msUP8HuSLXJLxPbFd37rumS55u1RK+d1JDcPfbIkXOLpSrthnImdgV3JVqAOYedIqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619337; c=relaxed/simple;
	bh=7OQKEgvzqandwKPwqYB4knvWEpwE95ho9s78axEaw84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDkKDhwxz6IvOEEQScLOf8nK4EjRAQdzu/0urPbul0vmv71L+4DZwX1M5QwRYBQjVkma3QV02YWxByXNOsuqELnCsXl2JyzTtxccRYsHv/ibs5feHFVTI8I4Eg8MoFRcQu+Y1ylDjcJWx2tgpuSaqNp5IqHUNf3m/p6bgDIxiwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17F8BDA7;
	Fri,  2 Aug 2024 10:22:39 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04DFD3F64C;
	Fri,  2 Aug 2024 10:22:09 -0700 (PDT)
Message-ID: <4d20edf9-ecf6-4ccd-914d-a303b827a7bd@arm.com>
Date: Fri, 2 Aug 2024 18:22:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/38] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
Content-Language: en-GB
To: Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <87bk33d1xg.fsf@rasp.cworth.amperemail.amperecomputing.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <87bk33d1xg.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Carl,

On 11/07/2024 23:00, Carl Worth wrote:
> James Morse <james.morse@arm.com> writes:
>> This is the final series that allows other architectures to implement resctrl.
>> The final patch to move the code has been ommited, but can be generated using
>> the python script at the end of the series.
>> The final move is a bit of a monster. I don't expect that to get merged as part
>> of this series - we should wait for it to make less impact on other
>> series.
> 
> Thanks, again, James.
> 
> As with previous versions, I've tested this code (along with additional
> MPAM code from you and other code we've written), to test MPAM
> functionality on an Ampere implementation.
> 
> I replied to the in the series which introduces
> CONFIG_RESCTRL_FS_PSEUDO_LOCK to point out how that commit will actually
> break compilation if that option is not selected, (and I described the
> minor change needed to fix that).
> 
> With that fixed, for the series:
> 
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64

Great - thanks!
(I assume you didn't test the python script that generates the move-to-fs patch)


Thanks,

James

