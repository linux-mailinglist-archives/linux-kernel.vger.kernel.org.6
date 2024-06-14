Return-Path: <linux-kernel+bounces-214981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF36D908CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8C6B28099
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFCADDA5;
	Fri, 14 Jun 2024 13:59:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D399463
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373587; cv=none; b=lMZc9cA0FYLcpMEwRkd9WW0KSlT4hdKkBKxuGH7epqp/kOevklG3fRgzpDkfoNV5D4aKVeHj50CQlSuP6xYUiLfNH8faA/q4d98m9gwfESnbFGlxw7EaiKIW5nzYeAdLuq7ixK8ut1kO1uCPv/hortYcO9G/YpHca1uC3hCWiMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373587; c=relaxed/simple;
	bh=FtCr0npCjA9yY7wMb8livEo1L4HMW/pWJ3OjYRA5x8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csjKxvxCsSEFY3/xWQBqQk6p0OhSQgiq3UfHaGO6wpHXWzFzh+jxgLCtBsJPAdG1oU0vMFiLKcOBnpBpPSRJp5h1m0vsKg7VMieeH1d4SDqtQCByI7DMoVvjA549gn+H3+sX0Erhxl0zHBe5bNuNR6x9Hcf8KnwJXKa7f/31cQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 278F6339;
	Fri, 14 Jun 2024 07:00:10 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AB343F5A1;
	Fri, 14 Jun 2024 06:59:42 -0700 (PDT)
Message-ID: <43fbb922-643d-4c9f-8920-071c5ef1e3f7@arm.com>
Date: Fri, 14 Jun 2024 14:59:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/35] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
Content-Language: en-GB
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
 'Dave Martin' <Dave.Martin@arm.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
 "lcherian@marvell.com" <lcherian@marvell.com>,
 "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 Peter Newman <peternewman@google.com>,
 "dfustini@baylibre.com" <dfustini@baylibre.com>,
 "amitsinght@marvell.com" <amitsinght@marvell.com>,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <TYAPR01MB6330BA857DE02BF5655774778BF42@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <TYAPR01MB6330BA857DE02BF5655774778BF42@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 23/05/2024 01:39, Shaopeng Tan (Fujitsu) wrote:
> I ran resctrl selftest on Intel(R) Xeon(R) Gold 6254 CPU,
> there is no problem.

Thanks for the testing!

James

