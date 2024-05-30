Return-Path: <linux-kernel+bounces-194832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502488D42A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 03:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6F9284C54
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1E817C64;
	Thu, 30 May 2024 01:02:55 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD80179BD
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030974; cv=none; b=AFtslRQlVhzoEn9JL9ngtOmzuIIj1gmiieCN3M1+Hy7K0WO4cezwmeKrsw5F863yj/bdghpu96W2bFXFb3U+M+G9LFazN2NO9+njUACYqlMjJG5iuEzaME6x9e4fZHXGvatfi3nM3ktZLu+zb5Xwis29eUXaQwD9uS8YgW7NK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030974; c=relaxed/simple;
	bh=CZNRSfPLGQjWHXtJQYBgMZX4aKatL++hkWztde+0DK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZJKAh3Goy3GpPA0yjf5hV951xaz5YZuUaFOp/0MPSh9yzpvqb2oEzqRjYLkr51QdMYssM2rWu8AuYkILJAzl9t+UPgf9OHJeHDENpjKzT0pOvEShmdKz+KVXhC8zyXuLgkIO6+8vWhYYGRNj8PSBN0bQxCoeKbNrAPqTl31kMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-64-6657d03a4331
Date: Thu, 30 May 2024 10:02:45 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com,
	akpm@linux-foundation.org, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20240530010245.GA66154@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
 <20240527015732.GA61604@system.software.com>
 <a28df276-069c-4d4d-abaf-efc24983211e@intel.com>
 <20240527225843.GA50818@system.software.com>
 <87le3t5pmt.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le3t5pmt.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsXC9ZZnoa7VhfA0g+cHdCzmrF/DZvF5wz82
	i08vHzBavNjQzmjxdf0vZounn/pYLC7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfPY+svOo3HqNTaPz5vkAviiuGxSUnMyy1KL
	9O0SuDIurpnGXjCXvWLG98vMDYzHWLsYOTkkBEwkLh94xwhjb5txByzOIqAq8fzFG7A4m4C6
	xI0bP5lBbBEBDYlPC5ezdzFycTAL9DFLrFl8CKxIWCBEYtqHNUwgNq+AhcT2tueMIEVCAmuZ
	JObM7WaBSAhKnJz5BMxmFtCSuPHvJVADB5AtLbH8HwdImFPATuLK9GtgJaICyhIHth1nApkj
	IbCNXeLX2YvsEJdKShxccYNlAqPALCRjZyEZOwth7AJG5lWMQpl5ZbmJmTkmehmVeZkVesn5
	uZsYgVG5rPZP9A7GTxeCDzEKcDAq8fAekAhPE2JNLCuuzD3EKMHBrCTCe2ZSaJoQb0piZVVq
	UX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGRo71jpW6qkUn+qT/pb+S
	Tfm6tCEnvflXNcNKMdfUao6EnU4Hlvhu/Sr1NvjLgb6QhQdPLHzvmRv8mWXBgR17FfbIbD39
	NnD5fEb93i+z1tydv2ZV1JSOQodG4elfl06/qF2ZzfNsktqjPdwvFMzzEg5P9ZeesthBIrXv
	tZDrhuub9W//3pJeMVmJpTgj0VCLuag4EQBvUzE4xgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsXC5WfdrGt1ITzN4OBVSYs569ewWXze8I/N
	4tPLB4wWLza0M1p8Xf+L2eLppz4Wi8NzT7JaXN41h83i3pr/rBbnd61ltdixdB+TxaUDC5gs
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUPHJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH4xQcmj62/7Dwap15j8/i8SS6A
	P4rLJiU1J7MstUjfLoEr4+KaaewFc9krZny/zNzAeIy1i5GTQ0LARGLbjDtgNouAqsTzF28Y
	QWw2AXWJGzd+MoPYIgIaEp8WLmfvYuTiYBboY5ZYs/gQWJGwQIjEtA9rmEBsXgELie1tzxlB
	ioQE1jJJzJnbzQKREJQ4OfMJmM0soCVx499LoAYOIFtaYvk/DpAwp4CdxJXp18BKRAWUJQ5s
	O840gZF3FpLuWUi6ZyF0L2BkXsUokplXlpuYmWOqV5ydUZmXWaGXnJ+7iREYY8tq/0zcwfjl
	svshRgEORiUe3gMS4WlCrIllxZW5hxglOJiVRHjPTApNE+JNSaysSi3Kjy8qzUktPsQozcGi
	JM7rFZ6aICSQnliSmp2aWpBaBJNl4uCUamB84Nmy8u+hU/vClfgY8m4aFWzfNM+yT3yK69un
	XmYCGj+WpNpM7DuSNtciq2rOm3lzF3tNTbc89TvshdObxf8/fm8VzZG4zSRfs4FVfkEUk/wP
	x0u7rY1Y1Y6lHqvO5tnN8zrCfEGh6bYosQeJ/3mtenq5ztw+8WGL5aSjWbtkQi+Jyd5VD5+k
	xFKckWioxVxUnAgA1GH8dq0CAAA=
X-CFilter-Loop: Reflected

On Wed, May 29, 2024 at 10:16:26AM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Sun, May 26, 2024 at 07:43:10PM -0700, Dave Hansen wrote:
> >> It has absolutely not been tested nor reviewed enough.  <fud>I hope the
> >
> > It has been tested enough on my side, and it should be reviewed enough
> > for sure.
> 
> I believe that you have tested and reviewed the patchset by yourself.
> But there are some other cases that you haven't thought about enough
> before, as Dave pointed out.
> 
> So, I suggest you to try to find out more possible weakness of your
> patchset.  Begin with what Dave and David pointed out.

I will.

	Byungchul

> > I will respin after rebasing the current mm-unstble and
> > working on vfs shortly.
> >
> > 	Byungchul
> >
> >> performance gains stick around once more of the bugs are gone.</fud>
> 
> --
> Best Regards,
> Huang, Ying

