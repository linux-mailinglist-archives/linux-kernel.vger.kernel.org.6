Return-Path: <linux-kernel+bounces-320593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66653970C5F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 05:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C091C209DD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF307171E4F;
	Mon,  9 Sep 2024 03:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLe0vO0g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F39BA42
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 03:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725853078; cv=none; b=c5Ta4CeyDp0hjhaRYqDTJi3xUpyl8Kx+bGGmsUB7YTSXLcFBy/vWKKNXj+lZmiN/yrTQMSTwRiSbYoMuVV+xnqAnnZmPtrWlDM4bT1Fbl2uBHejoweG4Zz1U6OsL+CdFYuatnyvd54FJ6jPymbQ2kZ/QMWEIEwXS92j7ilE7oQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725853078; c=relaxed/simple;
	bh=Ebsht7pufR8973XS6Pew/zX/2W72fELou862g4wEc/4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AhZeBxqpebR+01WI0RQCzugncn5jkEDXfDBN4LwsxqObMqz6cbEuxOHYAM7GEfXv/ZO8AKu5ZnPXCutU/q/1MDb5A7lAIeHfk0+VUs+3vv54aqb6h7W8lIk8aOjudJpmpYOuA8D1cX2Yr4wWljMYkUFuT3A9mZh63eUMF91pCRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLe0vO0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884FBC4CEC9;
	Mon,  9 Sep 2024 03:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725853077;
	bh=Ebsht7pufR8973XS6Pew/zX/2W72fELou862g4wEc/4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=vLe0vO0g3h4DHaXN1Ji6laLgSaDkXmxsegVdqr+Xd4XL8O17ZrtKeJlzWIownnYxf
	 VjSqE5TKc+iX6p08aHG6BoGMGL4nYZEjcusoFCpb2jS54KCs+l8DEq5ZT8wDQ29F08
	 /9TqIpFLPRR03M8qQq0QZro6F7n453HqDlQr2TU58uEv6BMIWT3KxDFF/ZD9q95T+M
	 qBL0sIMFNPxmRLwtsfDYUXUrQqDbmvVP+nCdmJl1xm0R0+Wk4zUbn3vr3PHBYxLzZe
	 iPZAm0rYIhtmxvCj3kmbsX9ZMb1q4iT4dnX1iFFncCtPABS0h3YeFJ/m/C1EVnpZoz
	 0JEym1WJ8MYGg==
Message-ID: <aacfdf82-6b8f-44ef-9efd-e5356147d91b@kernel.org>
Date: Mon, 9 Sep 2024 11:37:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [PATCH V4 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Yiyang Wu <toolmanp@tlmp.cc>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>
References: <20240902083147.450558-1-toolmanp@tlmp.cc>
 <20240902083147.450558-2-toolmanp@tlmp.cc>
 <5783ccbd-34cb-4f1b-8376-d795df2db4e3@linux.alibaba.com>
 <ZtV/speqypBt99sE@debian>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZtV/speqypBt99sE@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/2 17:04, Gao Xiang via Linux-erofs wrote:
> On Mon, Sep 02, 2024 at 04:52:30PM +0800, Gao Xiang wrote:
>>
>>
>> On 2024/9/2 16:31, Yiyang Wu wrote:
>>> Remove open coding in erofs_fill_symlink.
>>>
>>> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
>>> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
>>> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
>>
>> If a patch is unchanged, you have two ways to handle:
>>   - resend the patch with new received "Reviewed-by";
>>   - just send the updated [PATCH 2/2] with new version
>>     and `--in-reply-to=<old message id>`.
>>
>> I will apply this patch first.
> 
> I applied this patch as
> 
>  From b3c5375ceb2944a7e4d34a6fb106ecd4614260d7 Mon Sep 17 00:00:00 2001
> From: Yiyang Wu <toolmanp@tlmp.cc>
> Date: Mon, 2 Sep 2024 16:31:46 +0800
> Subject: erofs: use kmemdup_nul in erofs_fill_symlink
> 
> Remove open coding in erofs_fill_symlink.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> Link: https://lore.kernel.org/r/20240902083147.450558-2-toolmanp@tlmp.cc
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

