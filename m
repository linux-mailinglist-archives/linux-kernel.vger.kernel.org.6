Return-Path: <linux-kernel+bounces-539322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C96A4A336
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E389B178992
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DB327FE7D;
	Fri, 28 Feb 2025 19:56:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF208270EC9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772568; cv=none; b=gw3OyXWYxW21FuakRFWQ/wSizHpQYY3LtMte57YaVrbEiVFrqyMO/pLaSFYxCHa0/C9VNFzpu4G+H7EfPe9lVqfwOjf728p8ryTGklFsNSzxOIsoJ/LqYt8vdC/pOWTcieRmqy1F9k8nkYNFjkIoumD9UWxnWVfeP3QsFgdm67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772568; c=relaxed/simple;
	bh=QTPljLvoBRjxcBFgG8scRYG7iEFNAdEAKaFBc/QNG+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQtFKb4haCi0f9oAQF+TaG1mPO73YBSxoetznF9LxP7obQpG+zI9NHQ/JE4f86sh0VXlnuZTPKsCVxIQpmHc/o/C5wG/fjVcW5vI4tQ77iEnI5gy6bdQcSWpnPl39w31xqGeUypdq5HwFbLzlAl9sGNUMulR1SfWzEfdVY7pbuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D711176A;
	Fri, 28 Feb 2025 11:56:21 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFCE53F5A1;
	Fri, 28 Feb 2025 11:56:00 -0800 (PST)
Message-ID: <5c5b0519-73fd-41e4-92f4-939a9b43a8fe@arm.com>
Date: Fri, 28 Feb 2025 19:55:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/42] x86/resctrl: Move the resctrl filesystem code to
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
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <OSZPR01MB87981757570A3299E8DE0A1B8BCC2@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <OSZPR01MB87981757570A3299E8DE0A1B8BCC2@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello!,

On 28/02/2025 01:15, Shaopeng Tan (Fujitsu) wrote:
> I ran resctrl selftest on Intel(R) Xeon(R) Gold 6338T CPU @ 2.10GHz, there is no problem.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Thank-you for your testing work.

James

