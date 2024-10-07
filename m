Return-Path: <linux-kernel+bounces-353949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDD6993504
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6684A1F243F6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2623B1DD867;
	Mon,  7 Oct 2024 17:29:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B251DA2E5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322180; cv=none; b=upzNaLK8eHyXzqTqSb7PckBUAmc5FB4NVYZr7S0xH7V7coxHe63aUB8FeoLLauWQRSMnvMea8Su73KgaYp2W+mYjSRQz+fAznZ+Qr3XbhVKa7O4Mmr8jVy5Rlb68Z1ImxiouRIH0gktkEoCYAi2e+q/K/CykDEiqZVrIvxsZ+LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322180; c=relaxed/simple;
	bh=RF9z7GvdJ4lJotYmyZUHgySTAhJZ08X9FTkedvGm1vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQRuBHwSMldANPOFeuf48mJuQdTsUdjGhyOJCDkts5IirLimN6aN744cg65pIY6a3xfE3BeuQDEhT4Sn2mQfYcbmrMeqEwlim0N1seXj3ExVnA3Bs48OrcdUC3/u5n5WyoJw8HbZedPcKbXt7Dg8rhMUldb+Qz9NhjwPgYorKmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 070B8DA7;
	Mon,  7 Oct 2024 10:30:07 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08D1A3F73F;
	Mon,  7 Oct 2024 10:29:33 -0700 (PDT)
Message-ID: <9479c799-86fc-4d9e-addb-66011ecae9c7@arm.com>
Date: Mon, 7 Oct 2024 18:29:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/40] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
Content-Language: en-GB
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <a1b78dd3-db42-4bf7-b004-e718b582e28c@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <a1b78dd3-db42-4bf7-b004-e718b582e28c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 04/10/2024 22:18, Reinette Chatre wrote:
> While you wait for folks to consider these changes, could you please take a look
> at [1] from an Arm/MPAM perspective? My understanding is that Arm/MPAM also
> requires assigning counters to do monitoring and [1] aims to create
> a generic interface to do so. Is [1] something that Arm/MPAM can build on
> or are there some changes that can be made before its inclusion to help 
> with future MPAM support?

Yup, this is on my list to get back into this week.

I did rebase the MPAM tree over Babu's v6, but haven't had the chance to test it [0].
This is my previous feedback on where the arch/fs split needed to be came form.


Thanks,

James

[0] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/abmc/v6

