Return-Path: <linux-kernel+bounces-331688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C8B97B009
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3AD282ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399CC167D98;
	Tue, 17 Sep 2024 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJW0SVc8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8tRFJZpA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FABF156250
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726575590; cv=none; b=ZcvH2hngXPMq1vRLzY4Sbg2AIwl+gGZjQtX9dAj227KkJZ7NKPEmpUkRhzcEquUjHFWghUNURju3fK9GaXqD/N41huqtLd1+DHm4L0so2+7RJdAFynOGHhMx3s+oLWNRFnJFRXnjHClfvvbX3nwY6bcUV4hY14nT6lEFSTt1wIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726575590; c=relaxed/simple;
	bh=ysMaVrmccLvAsJpHtXtCUt5fwM1sEzRh4w2ysymCwgQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cWCT30NW9QhjzxwvyttE2AjFPEnEb7XAzZHlmVswy6DOXmco9UkpGIbTDnCNBtCc4A4awHnmfI5Go3ui6fF6Ozbk0Y20oiJpvWsi5R0Q3YpPK+ugNRt8x7Bc6u3v6Y9auQLAFdcx7Vosz3l+n2N5TI+eptUwgF20mkJLfICEjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJW0SVc8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8tRFJZpA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726575587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wQndafcmk9PWFnoR4Ov7CRlR9eb2pjcJP6NIxwAilGk=;
	b=WJW0SVc8Q6XAwPs3vfR2orQayevGv11zzXUsEhT3NisKn/cAEEXibQC2pZlS2ifViDRptR
	jdgDJBM9FsGPNbMVYOaL0HFAJ1q0OWpbMgIy9MEoOqguxbEwJs4hhMN6T4rxM9g5dyWPd8
	+pmwjPgw9Vz8o4olzF6naXr/p3OmvIOpnYCKiyJkwQzWs5XsjG8dY40xBV+7qpavzFx9E6
	F23okdMpaltllyTqWoV7ymu0efYz7/NjAEWinqwWRyKQ/hWNUeVzhjE0/c1OfFLV2NykDm
	+zkm+bFqzHPyepOripFJbj/zvJnID8SP4Y73csRo8wus04pEraDl94+q+QMVYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726575587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wQndafcmk9PWFnoR4Ov7CRlR9eb2pjcJP6NIxwAilGk=;
	b=8tRFJZpAcOzI6i4As9JPOfRX5L9HcnqUVpDeGAdE6LooQkh4kKEnuu3fqoPFGeGe+twc5G
	C72cKmtmN4HLPLDw==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] debugobjects: Reduce contention on pool lock in
 fill_pool()
In-Reply-To: <90546c16-52e3-b92c-d99b-724278647809@huawei.com>
References: <20240911083521.2257-1-thunder.leizhen@huawei.com>
 <20240911083521.2257-4-thunder.leizhen@huawei.com>
 <90546c16-52e3-b92c-d99b-724278647809@huawei.com>
Date: Tue, 17 Sep 2024 14:19:46 +0200
Message-ID: <87ldzq1nh9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 11 2024 at 17:04, Leizhen wrote:
> On 2024/9/11 16:35, Zhen Lei wrote:
>> Scenarios that use allocated node filling can also be applied lockless
>> mechanisms, but slightly different. The global list obj_to_free can only
>> be operated exclusively by one core, while kmem_cache_zalloc() can be
>> invoked by multiple cores simultaneously. Use atomic counting to mark how
>> many cores are filling, to reduce atomic write conflicts during check. In
>> principle, only the first comer is allowed to fill, but there is a very
>> low probability that multiple comers may fill at the time.
>> 
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>
> Hi, Thomas:
>   I was going to mark "Signed-off-by" as you. Because except for the
> following line of changes, you wrote everything. But you're maintainer.
> It doesn't seem good if I post a patch with your Signed-off-by. Please
> feel free to change it, but do not forget to add "Reported-by" or
> "Tested-by" for me.

Suggested-by is fine. I look at it after back from travel and
conferencing.

Thanks,

        tglx

