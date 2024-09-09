Return-Path: <linux-kernel+bounces-320655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E586970DC3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96361B2218A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AC1176255;
	Mon,  9 Sep 2024 06:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozirto10"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD541101F7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 06:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725862522; cv=none; b=S/hSSbJvZo89MIIUqaOBwGnh4HlkVV89ZoUF+uTkgfMCNgutQGIwRywY53fjEM4MFAH/uC1XhDE1GnvocSEURZDShD6nW5j0hpQzsu/6gtEb/KxU7MC3dva2h01CxnodNA6EbL0MjxH1ai1hBvwW04ucnATe1ldH8zslU4HZY/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725862522; c=relaxed/simple;
	bh=kUW/3P8daJz9MOQ31FwZmx4XcmtHFw1DBdfxm3pzJao=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i8QFgiT3s439vuOwBlBfL9aNS1Z/KOx4ZUdK9KtFn7nv3S7BbyBdEK6lckHa8pSeeMMaU6ig1vm7s8SlZfupV9OyGWEPFT/SfBtdL2OaQUtxthjFQHg5H7bRwYqoiEoeJZsFW3binTkaBdj4dE+YyCuDuOlbeCNsOfYrrv5z/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozirto10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164FBC4CEC5;
	Mon,  9 Sep 2024 06:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725862521;
	bh=kUW/3P8daJz9MOQ31FwZmx4XcmtHFw1DBdfxm3pzJao=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ozirto10lWutEbenUc0d7msd23goaNLIcYA2ZQZS6STgxns0VYUwodjtK2lUrkaZp
	 3YVS3NH4eBN6IpnX2uMXQcsLiBDQbIRjHFSFz7R7E9CbMlqtFycHIZll+ow45Fq/Pe
	 LXBJa5rZfcLlP0r3qU62FkY/JSwPBvHTuZyOhg7EbA0GBBufjmEtYhNP3FjV47b33W
	 dpWvXtAm1q+a2AX4rd2e3yZ3YF8Wuke5BREuwXhj15t8iwJjm3cxv2fcIHI3OthM7/
	 r7I5X+HFFQjq8wU+BCmkCF5u6drFXOZ1mammtiaZC2Z9UYlApZEGsEHAvtWNmaSKiq
	 LQlY+U1aY36pw==
Message-ID: <7ae3a417-19ed-4b02-ae17-c9cfe9c05438@kernel.org>
Date: Mon, 9 Sep 2024 14:15:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, hsiangkao@linux.alibaba.com, kernel-team@android.com,
 liujinbao1 <liujinbao1@xiaomi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] erofs: fix error handling in z_erofs_init_decompressor
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20240905060027.2388893-1-dhavale@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240905060027.2388893-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/5 14:00, Sandeep Dhavale wrote:
> If we get a failure at the first decompressor init (i = 0),
> the clean up while loop could enter infinite loop due to wrong while
> check. Check the value of i now to see if we need any clean up at all.
> 
> Fixes: 5a7cce827ee9 ("erofs: refine z_erofs_{init,exit}_subsystem()")
> Reported-by: liujinbao1 <liujinbao1@xiaomi.com>
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

