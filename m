Return-Path: <linux-kernel+bounces-531763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A5BA44486
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6F53B531B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DF121ABAF;
	Tue, 25 Feb 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="dMSz8DNC"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F42FB2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497701; cv=none; b=Gy1KK33+zSVHQslnH/fxWbrt5jx/DDlU1a8lCwEBNp9NxRaDNCSyjj0jqiGtSgbLtNAwNofYa7AAGXAjGhCWMqi61hbDICyKj7AHS0MrCa9QZfTC6W3u4bXb5tujuUMNZ+RVVVj/eliQtKz2uYsuc26nHbgAZSIKpaBHhKIPqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497701; c=relaxed/simple;
	bh=cH9XXCTkke3kcqKJcWscebkNcrtTiyEFYNCyYJ71YPI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpIpldofHPUwN4A3Ucz8rHIPcpACV83SAo+XX2FNQ8LTiLVbNcsl1Dp3Rm18GY2lJIMMCoghv9zbJTquxiNBXBVqZS/VRGhnsHVmiJ6ZN4mwhBd1V11sNguCe/rp7QUyDI5mUqsSIev3J5HVTZPeLt3mHXOj5r6iak1jPYy6lPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=dMSz8DNC; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1740497684;
	bh=xQdbII/iD5bkXAKYncYT8QMWFld/fkb7ZKGb7EsJbA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dMSz8DNCtdVfaHpmbs9GtyHZ/8qc1SICtKufSaeTVPwzmt3OhGunFWqT2hx4tfJDQ
	 gGMF2BnTAUPM3pt0XX6kANWx46ZGHViazJOTlUMGGpBHpK6+LvHn3l4nB0hFgymDkn
	 NoDxj3lDAsmoiuNu4ZNGbTcn2/6aevT1YeFmNHoI=
Received: from chenyu5-mobl2 ([118.114.56.201])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 8A81E0C4; Tue, 25 Feb 2025 23:34:40 +0800
X-QQ-mid: xmsmtpt1740497680twkk9gkul
Message-ID: <tencent_1A4C28B62DA5726C31A985601B07F664250A@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqfcHTOwq7x0UZAN8Ik6Zg5Qb8N7t8wsIolvnA2zs9KbZ9C9Gp85Z
	 rql3+TknS8MOWkVRXiYIGuqK8u/RMuLKJOxacd5mZ2ZKP1zWF2AGsBSrur9rtMiUPrDbmkSSkGMo
	 pN7vgeej5xssB02mTaV1NvQ+quZ21BaFsI6lywT+8xgNwGONkTLs67N5S74f4QMyfZN1YM2DSL4h
	 IsaNM3/QuOe26CKAHp387sQrKtmoBPqUWr9E1s1bfhtYp4MwHjl2lov9kzaztnbWynW6+85lf64p
	 ghJTIKLipCBrvD/q+7fOJ9VztZNWgcD9uGaaHp26rWidxJS6vX1x+iD0pl94dMSmgJ0GXBrJktnU
	 eh4SmVmoYTMM9N0oIJmq4O1lCwViMIC6OM8jcJFOGEV681epgvjrskYchDbYcA8ITUwSNHwAvV2t
	 WMEdbPkcxZFjFEWefY+1qb+X0O3YN8FGA8SVswQn05s5iDbZ/qtEYjyor7wpLKDkD6AlqJHmkj82
	 JcnPB35Xwf2JHyQlHKmW0EE8gIDNufulOM97C0dr01QcxMD0rpSQuAJ0ntHr1G/V4GIFFevP7JEX
	 IwnU5GtdHYv5xVyXrXDUgXb0SxMu35xdG2sL87C/OiUQUxk7g8P3aYxfoNL9thZxec32W8xlgb6r
	 zE/xEeFnERdPl2DD9Zg6pW4LV2GBA618A3anoJKUQGhdW8D4K9+fBAxW9s2JlzGH5uGdymSsRIHa
	 OTb5VL3C1JRg/0PeIqku7GgvfX/KeMOEA6hWoYlak3jBJmhhs1/rUfONVr5drknogILjvoBBv5YX
	 MrKnEBoKlObSaFeaWKQXMWKZX5UJKxEa0YeM/myjSCn26WGffbNEX0nXWC2WKjZrbIJrfaK43EvS
	 fyvrjJJX5PtTqt2oOHQBA98B47t/YXafOUgIB+xbjZBTqvMpqMZ1UgkS2OBSHlH3oioJMWeO4rDW
	 xXHGbvYjfHxJRdunCO5W8PACzgfnXW4ddQ4xwvlyGhNgF0y1koMgTIauGQVNji
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
Date: Tue, 25 Feb 2025 23:35:12 +0800
From: Chen Yu <yu.chen.surf@foxmail.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Peter Zijlstra <peterz@infradead.org>,
	zihan zhou <15645113830zzh@gmail.com>, oe-lkp@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>, lkp@intel.com,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [tip:sched/core] [sched]  2ae891b826:  hackbench.throughput 6.2%
 regression
X-OQ-MSGID: <Z73jMA2oJGrA3p5b@chenyu5-mobl2>
References: <202502251026.bb927780-lkp@intel.com>
 <tencent_6D9B516AFF16965A3BB652A049D6CA847706@qq.com>
 <20250225122705.GD34233@noisy.programming.kicks-ass.net>
 <tencent_CC411B43EAD996961A06366F606C96DD0406@qq.com>
 <20250225134220.qjctfqwwhjz7bspp@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225134220.qjctfqwwhjz7bspp@airbuntu>

On 2025-02-25 at 13:42:20 +0000, Qais Yousef wrote:
> On 02/25/25 21:15, Chen Yu wrote:
> > On 2025-02-25 at 13:27:05 +0100, Peter Zijlstra wrote:
> > > On Tue, Feb 25, 2025 at 05:31:34PM +0800, Chen Yu wrote:
> > > 
> > > > 
> > > > But consider that the 6% regression is not that high, and the user might customize
> > > > base_slice via debugfs on-demand, we can keep an eye on this and revist it in the
> > > > future(we have encountered some SPECjbb regression due to over-preemption).
> > > 
> > > You can specify a per-task slice using sched_attr::sched_runtime. Also
> > > see commit 857b158dc5e8 ("sched/eevdf: Use sched_attr::sched_runtime to
> > > set request/slice suggestion")
> > > 
> > >
> > 
> > Thanks, we'll have a try during the next test cycle.
> 
> Could you also try with HRTICK enabled?
> 
> 	echo HRTICK | sudo tee /sys/kernel/debug/sched/features

Sure. Is HRTICK supposed to encourage preemption? I thought
hackbench might be sensitive to preemption(downgrading).

thanks,
Chenyu


