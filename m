Return-Path: <linux-kernel+bounces-556117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2968A5C124
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269CE3A9E86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1C2257432;
	Tue, 11 Mar 2025 12:26:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941352356D7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696002; cv=none; b=ky9mddyhwIBV7np5BO0xzmiskN26f/3XkKK4VnAiZ9DdXGBAxHWSMjaW9tuWFCbmfv5HhX2OftDn4z4ejOpvX/IUuydiNpbozhTfajHteQJjzf5Cy2qthsKYNSfK25G9CKIYC8H7fkvUJwGLMc4Fc03JWJRtdtWptc03rdhb3iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696002; c=relaxed/simple;
	bh=3QP0oBTuG17lcSAGTKtF7YT2QD5SMBxytI9UyE2ctsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nT19dyD5ImORxT5L/7vKxUQI2T87mhJz7AtKm7U42QCF44Jt5bdlWQ16bqYq1UZAm3sHkK/upNSIt6WUNrbr8xhH6UgyUsKpCVZh6euwNDYQ63K4rRQZHTiVPK2ttB3hJ07yi+G4h1myWAj/aSZkO2jjfAtipul952YusyCTcx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0841A152B;
	Tue, 11 Mar 2025 05:26:51 -0700 (PDT)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D564E3F673;
	Tue, 11 Mar 2025 05:26:35 -0700 (PDT)
Message-ID: <667edf42-2218-4a04-bbee-fdb020969d58@arm.com>
Date: Tue, 11 Mar 2025 12:26:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
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
 "peternewman@google.com" <peternewman@google.com>,
 "dfustini@baylibre.com" <dfustini@baylibre.com>,
 "amitsinght@marvell.com" <amitsinght@marvell.com>,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 "fenghuay@nvidia.com" <fenghuay@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <TYCPR01MB8804B2389B9B553928A3F3658BCA2@TYCPR01MB8804.jpnprd01.prod.outlook.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <TYCPR01MB8804B2389B9B553928A3F3658BCA2@TYCPR01MB8804.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello!

On 06/03/2025 11:47, Shaopeng Tan (Fujitsu) wrote:
> I ran tools/tests/selftests/resctrl on Intel(R) Xeon(R) Gold 6338T CPU @ 2.10GHz, there is no problem.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Thanks for testing again!


James

