Return-Path: <linux-kernel+bounces-521692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB33A3C0DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185EA1896BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BDE1EB1B7;
	Wed, 19 Feb 2025 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uVXB7M5c"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D43286281;
	Wed, 19 Feb 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973321; cv=none; b=sy2Bvpu09F93gTgztc5PISLjOUv2Nxuiyqc3Gqn7KqttjQkbikeP1T2j7v2xRsE9YLEzlpG2aNQEcm1u1iUe6NfWQbB5tJQwGyXBguqDwff04KOYNLdQK7Hp0KnUgM/dKKXqhvgV1o2cUVhsvSsN0GeS+dMYJmBo0wmQTi3KyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973321; c=relaxed/simple;
	bh=Rc0k2hXGgw1uh7x0JIX+uzUH8a98VI2YuRrPPA9zVIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DAIrsQZroAIUf6tgFTrgIaov9/G/uZDgwK9Qv/WoF+dYKEWdO0jHqjhX1ZkKZC5kdPfMOvnopsriEL47YLkyyBReK9zkAiZf7AMpt02Ih4lSevHwgxdVsmuu83n85vCHgNYtRj5ykS6Nx2DBwn8vbPcq3KLCdv37anKjan1P7Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uVXB7M5c; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739973320; x=1771509320;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=57nPLxtLibpkK5qPp8QpRrsWkbDlQlqDET5gkkKYRG8=;
  b=uVXB7M5cyZLysMGuSVF/79vI9AyRNj63EwEGDaEnRaCPROiolv3BpNqm
   0xQR3AhHvXUUzDeevCgpSke4aLW1VVOLgLx7o8kkBhNcxw6kOMi/3GULy
   DCkcnzkMyOdxO0GB8PPKWkEKl8gwp6BKnZTbf+5dY8dR31eN1dUtilv5i
   M=;
X-IronPort-AV: E=Sophos;i="6.13,299,1732579200"; 
   d="scan'208";a="173851478"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 13:55:18 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:64466]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.97:2525] with esmtp (Farcaster)
 id 109703bc-b166-4b29-a69a-d899c4750143; Wed, 19 Feb 2025 13:55:17 +0000 (UTC)
X-Farcaster-Flow-ID: 109703bc-b166-4b29-a69a-d899c4750143
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 19 Feb 2025 13:55:08 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Wed, 19 Feb 2025
 13:55:00 +0000
Message-ID: <d8c43707-65a2-4176-85e2-acdb4c9d16ad@amazon.com>
Date: Wed, 19 Feb 2025 14:54:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
To: Dave Young <dyoung@redhat.com>, Mike Rapoport <rppt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Ashish Kalra
	<ashish.kalra@amd.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, David Woodhouse
	<dwmw2@infradead.org>, Eric Biederman <ebiederm@xmission.com>, Ingo Molnar
	<mingo@redhat.com>, James Gowans <jgowans@amazon.com>, Jonathan Corbet
	<corbet@lwn.net>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
	<peterz@infradead.org>, Pratyush Yadav <ptyadav@amazon.de>, Rob Herring
	<robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan
	<saravanak@google.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>, Will Deacon <will@kernel.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <x86@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <CALu+AoRMQyRDFS_4L0KQkmrFT_S+yk=uZ-Mqt86JQYKKnj-5Ug@mail.gmail.com>
 <Z7WJD6eBLuIRnLwk@kernel.org>
 <CALu+AoSaEthfed1NOYPiQgm_g-dhibVMRAp0+=_+9qTT4_x=tg@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CALu+AoSaEthfed1NOYPiQgm_g-dhibVMRAp0+=_+9qTT4_x=tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)


On 19.02.25 13:49, Dave Young wrote:
> On Wed, 19 Feb 2025 at 15:32, Mike Rapoport <rppt@kernel.org> wrote:
>> On Mon, Feb 17, 2025 at 11:19:45AM +0800, RuiRui Yang wrote:
>>> On Thu, 6 Feb 2025 at 21:34, Mike Rapoport <rppt@kernel.org> wrote:
>>>> == Limitations ==
>>>>
>>>> Currently KHO is only implemented for file based kexec. The kernel
>>>> interfaces in the patch set are already in place to support user space
>>>> kexec as well, but it is still not implemented it yet inside kexec tools.
>>>>
>>> What architecture exactly does this KHO work fine?   Device Tree
>>> should be ok on arm*, x86 and power*, but how about s390?
>> KHO does not use device tree as the boot protocol, it uses FDT as a data
>> structure and adds architecture specific bits to the boot structures to
>> point to that data, very similar to how IMA_KEXEC works.
>>
>> Currently KHO is implemented on arm64 and x86, but there is no fundamental
>> reason why it wouldn't work on any architecture that supports kexec.
> Well,  the problem is whether there is a way to  add dtb in the early
> boot path,  for X86 it is added via setup_data,  if there is no such
> way I'm not sure if it is doable especially for passing some info for
> early boot use.  Then the KHO will be only for limited use cases.


Every architecture has a platform specific way of passing data into the 
kernel so it can find its command line and initrd. S390x for example has 
struct parmarea. To enable s390x, you would remove some of its padding 
and replace it with a KHO base addr + size, so that the new kernel can 
find the KHO state tree.


Alex


