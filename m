Return-Path: <linux-kernel+bounces-263076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB2C93D0A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC8A1F21802
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2985176AAC;
	Fri, 26 Jul 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2jtsJ/6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A31EF01
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987461; cv=none; b=Xu5bvDMueMjWdS4VQudNRP/zwx8u6J1tNSWjgEjvUUAXbvwAxg5qzA1Lm3U8oh1qpzI9xiPhIDiGjsvUxT5GsMADsD7eSzpGmUYPNO117UDChLDgnhDJrFE8omoMirjVNsvVlddpIMEB/hJVhvR9LfYtnjC1AQGbaD35kt2X5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987461; c=relaxed/simple;
	bh=kyxWm7vi7Uey+9KCC09pWxJM549AzmLQVR6ZyDB2V3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tzv9NA/zK/adm/lYtNNV6Gua6ow5kJoaBmO5LHjjZWIFI6VIBBTIoyw5CMUJTtSTJERKXd/I4hIPK4AlgwU3u5SOhA1rOCGVHrZ+eqxzOKuv3dYJyXdcMGvjmr9V45w1kY1AO6YoEtfEw1It0jA1y0Lt0enfZ35HIIpIWrzh5Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2jtsJ/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CB1C32782;
	Fri, 26 Jul 2024 09:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721987460;
	bh=kyxWm7vi7Uey+9KCC09pWxJM549AzmLQVR6ZyDB2V3I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U2jtsJ/6IhszHDVTicPZLDLrsVd5S7ryG1SOYMt/2+gK7dZxtyqzgMEYT1z0V/lSA
	 a02xwSeG/mHKEd01ch0QPkdiu2rTdMfh1LSx68JJKJ5soSIRII/HYhuJuziiOEi72w
	 jtsux5x+8VN91ruI/jJEXQu33gCreDTTP5/jSjfqJt21h30IwvfmM+Xx7pnkGUiMUL
	 9NoF0XMNNVErHuC9d0aQXKkaiiiNBCy0wyRDMqn+h159p38j4KWt2TUtN48+1PXxDV
	 +FseXsVM9BeDgSOk76xIxoSJgePUObnAAqv/1mn0/R9lHKc2Ad1l6E4AyXFWKp16d2
	 k1BeQFu6Dtf7g==
Message-ID: <dc70af85-5357-4787-92fb-6da1b298ca79@kernel.org>
Date: Fri, 26 Jul 2024 17:50:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: support STATX_DIOALIGN
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240718063756.2982763-1-lihongbo22@huawei.com>
 <20240718083243.2485437-1-hsiangkao@linux.alibaba.com>
 <f91c15d1-cdd9-4b12-9143-fba6c7bf6565@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <f91c15d1-cdd9-4b12-9143-fba6c7bf6565@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/18 16:35, Gao Xiang wrote:
> 
> 
> On 2024/7/18 16:32, Gao Xiang wrote:
>> From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
> 
> Also I will fix the email address issue
> (Hongbo Li <lihongbo22@huawei.com>) when applying too.
> 
>>
>> Add support for STATX_DIOALIGN to erofs, so that direct I/O
>> alignment restrictions are exposed to userspace in a generic
>> way.
>>
>> [Before]
>> ```
>> ./statx_test /mnt/erofs/testfile
>> statx(/mnt/erofs/testfile) = 0
>> dio mem align:0
>> dio offset align:0
>> ```
>>
>> [After]
>> ```
>> ./statx_test /mnt/erofs/testfile
>> statx(/mnt/erofs/testfile) = 0
>> dio mem align:512
>> dio offset align:512
>> ```
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

