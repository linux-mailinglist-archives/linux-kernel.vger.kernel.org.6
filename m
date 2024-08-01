Return-Path: <linux-kernel+bounces-271893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDFF94548B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB86B2284C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435F21474CC;
	Thu,  1 Aug 2024 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Dg9mD2MX"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E81146D73
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722551765; cv=none; b=BjxJ1hL0d/6aN/Zz3Ow1Afh2b/Ws8Dqj5fo1ZYpxMI6rkPHbc6IiIYrH5sdfy0KA/xlzu2eHyxh7cSQMCdT7SRJQ3e1QM4UROsKOLqwfHdrFMNNvHa/RHdpxMUfbgzecMzWSbbmpHCHNPnKHwc2Nla+267NbYJATTKIFFhs18+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722551765; c=relaxed/simple;
	bh=io5ptOM2yLV7Yx6TkZgB3r0B2lEmO5avVNXyNXIP1Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOdOix8AigkO5ENbXhiEW7mtziwONBIhxME7KHCbzp0tCvhilLT9Q7UmYkg+wVCVV+1TxiEMIkDUurFMbiCTZyuze8SuX0i32aoKH+n2W+78xn9QsOi6MjJgeefE8cr3UZLRh1WYj7mC9m78lUyX3Xy3bDsM8gYfWdDYNjHibYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Dg9mD2MX; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id Z1V7sEiIzvH7lZeOwsbCS5; Thu, 01 Aug 2024 22:36:02 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ZeOvsPjOILd9nZeOvsXg9j; Thu, 01 Aug 2024 22:36:01 +0000
X-Authority-Analysis: v=2.4 cv=C4XvyxP+ c=1 sm=1 tr=0 ts=66ac0dd1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8
 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=SBNduZsKBOnCDnG2JV0A:9 a=QEXdDO2ut3YA:10
 a=IMS77xXFAjTPSJ8Q-sgV:22 a=AjGcO6oz07-iQ99wixmX:22 a=mmqRlSCDY2ywfjPLJ4af:22
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3MRVNS9BLDd/euXQzMdeIf+rl3T+v08bwDEE7pegjac=; b=Dg9mD2MXtuWUsyAV0oB+VR3Okj
	VyUsvtfrWDxL+WkEj4mFlWV5cTB57jpHsXBwr/Z/D9amX8xnFiFHZuxiqY3eDN2OHbjgKOM5bUntK
	Vwzo9y2jITds9KFNVFFSkH5KREnTd6lsajB4/pAeV6jHp+fmuOMmd14hacGX3Lpw/+0U7OAez62aA
	hCKGxPsTZ3rEAKyQXjAQ8I/ORsGtplofKxkOiHICfhDeuWJurziA/hbIlY7NmgFIgC+c1fqRX966V
	zfjGvs/N1wi+MKWV9mfQmRfMjSF0/h3fCMvZ1m0ntzXGJnbtqn97zBnfycVsHVcSUXSZ1TgORd4Zg
	hoVrYIDA==;
Received: from [201.172.173.139] (port=59916 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sZeOu-002cvG-2f;
	Thu, 01 Aug 2024 17:36:00 -0500
Message-ID: <ca056227-30c3-47b9-a19a-fbab87778f20@embeddedor.com>
Date: Thu, 1 Aug 2024 16:35:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [gustavoars:testing/wfamnae-next20240729-cbc-2 11/18]
 include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to
 requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) ==
 sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of
 struct_group_tagged()
To: Nathan Chancellor <nathan@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
References: <202408011956.wscyBwq6-lkp@intel.com>
 <138da3e5-0e24-41a6-bb35-df5d07045eb3@embeddedor.com>
 <20240801190813.GC122261@thelio-3990X>
 <f40160aa-7cbd-4264-be44-45396b09574f@embeddedor.com>
 <20240801221427.GA3773553@thelio-3990X>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240801221427.GA3773553@thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sZeOu-002cvG-2f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.139]:59916
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJHKc/xo4SrLW9f10MvRJ4DjM1wdcK5gSDUzrZus4MUOHNwPwVl0X22VHdvmIgqClR906lRXqoxNEaWjYr5MzXKywjBBKoMFdrk5c9FdExTPnnSlgLVc
 09bSRng1UqnpUmjt3wH0k/TxmIP/dxA4xj4no4w0ewW+O22lQ9Jf2n96R5AKvDDafBua+u7auecPlC+OiCIFsGT+GS485gazOTzOl+J3Al8m/+cDAu9qeIMq



On 01/08/24 16:14, Nathan Chancellor wrote:
> On Thu, Aug 01, 2024 at 02:17:50PM -0600, Gustavo A. R. Silva wrote:
>>
>>
>> On 01/08/24 13:08, Nathan Chancellor wrote:
>>> On Thu, Aug 01, 2024 at 06:47:58AM -0600, Gustavo A. R. Silva wrote:
>>>>
>>>>
>>>> On 01/08/24 05:35, kernel test robot wrote:
>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240729-cbc-2
>>>>> head:   df15c862c1b93b6e1f6c90b0d7971f7a6ad66751
>>>>> commit: e7cd9f429a852fb7e37a706c7d08fc36e7863e06 [11/18] RDMA/uverbs: Use static_assert() to check struct sizes
>>>>> config: hexagon-randconfig-001-20240801 (https://download.01.org/0day-ci/archive/20240801/202408011956.wscyBwq6-lkp@intel.com/config)
>>>>> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 430b90f04533b099d788db2668176038be38c53b)
>>>>
>>>>
>>>> Clang 20.0.0?? (thinkingface)
>>>
>>> Indeed, Clang 19 branched and main is now 20 :)
>>>
>>> https://github.com/llvm/llvm-project/commit/8f701b5df0adb3a2960d78ca2ad9cf53f39ba2fe
>>
>> Yeah, but is that a stable release?
> 
> No, but the Intel folks have tested tip of tree LLVM against the kernel
> for us for a few years now to try and catch issues such as this.

Oh, I see, fine. :)

> 
>> BTW, I don't see GCC reporting the same problem below:
> 
> Hexagon does not have a GCC backend anymore so it is not going to be
> possible to do an exact A/B comparison with this configuration but...
> 
>>>>>>> include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of struct_group_tagged()
>>>>>         643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
>>>>>             | ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>         644 |               "struct member likely outside of struct_group_tagged()");
>>>>>             |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>       include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
>>>>>          16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
>>>>>             |                                 ^
>>>>>       include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
>>>>>          77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>>>>>             |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>       include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
>>>>>          78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>>>>>             |                                                        ^~~~
>>>>>       include/rdma/uverbs_ioctl.h:643:58: note: expression evaluates to '56 == 52'
> 
> This seems to give some indication that perhaps there may be some
> architecture specific here with padding maybe? I seem to recall ARM OABI
> having something similar. Adding the Hexagon folks/list to get some more
> clarification. Full warning and context:
> 
> https://lore.kernel.org/202408011956.wscyBwq6-lkp@intel.com/
> 
> The problematic section preprocessed since sometimes the macros
> obfuscate things:
> 
> struct uverbs_attr_bundle {
>          union {
>                  struct {
>                          struct ib_udata driver_udata;
>                          struct ib_udata ucore;
>                          struct ib_uverbs_file *ufile;
>                          struct ib_ucontext *context;
>                          struct ib_uobject *uobject;
>                          unsigned long attr_present[(((UVERBS_API_ATTR_BKEY_LEN) +
>                                                       ((sizeof(long) * 8)) - 1) /
>                                                      ((sizeof(long) * 8)))];
>                  };
>                  struct uverbs_attr_bundle_hdr {
>                          struct ib_udata driver_udata;
>                          struct ib_udata ucore;
>                          struct ib_uverbs_file *ufile;
>                          struct ib_ucontext *context;
>                          struct ib_uobject *uobject;
>                          unsigned long attr_present[(((UVERBS_API_ATTR_BKEY_LEN) +
>                                                       ((sizeof(long) * 8)) - 1) /
>                                                      ((sizeof(long) * 8)))];
>                  } hdr;
>          };
> 
>          struct uverbs_attr attrs[];
> };
> _Static_assert(__builtin_offsetof(struct uverbs_attr_bundle, attrs) ==
>                         sizeof(struct uverbs_attr_bundle_hdr),
>                 "struct member likely outside of struct_group_tagged()");
> 
> FWIW, I see this with all versions of Clang that the kernel supports
> with this configuration.

I don't have access to a Clang compiler right now; I wonder if you could
help me get the output of this command:

pahole -C uverbs_attr_bundle drivers/infiniband/core/rdma_core.o

Thanks in advance!
-Gustavo

> 
> Cheers,
> Nathan
> 
>>>>>         643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
>>>>>             | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>         644 |               "struct member likely outside of struct_group_tagged()");
>>>>>             |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>       include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
>>>>>          77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>>>>>             |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>       include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
>>>>>          78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>>>>>             |                                                        ^~~~
>>>>>       7 warnings and 1 error generated.
>>>>>
>>>>>
>>>>> vim +643 include/rdma/uverbs_ioctl.h
>>>>>
>>>>>       630	
>>>>>       631	struct uverbs_attr_bundle {
>>>>>       632		/* New members MUST be added within the struct_group() macro below. */
>>>>>       633		struct_group_tagged(uverbs_attr_bundle_hdr, hdr,
>>>>>       634			struct ib_udata driver_udata;
>>>>>       635			struct ib_udata ucore;
>>>>>       636			struct ib_uverbs_file *ufile;
>>>>>       637			struct ib_ucontext *context;
>>>>>       638			struct ib_uobject *uobject;
>>>>>       639			DECLARE_BITMAP(attr_present, UVERBS_API_ATTR_BKEY_LEN);
>>>>>       640		);
>>>>>       641		struct uverbs_attr attrs[];
>>>>>       642	};
>>>>>     > 643	static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
>>>>>       644		      "struct member likely outside of struct_group_tagged()");
>>>>>       645	
>>>>>
>>>>
>>
>> Thanks
>> --
>> Gustavo

