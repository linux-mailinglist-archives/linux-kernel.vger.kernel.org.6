Return-Path: <linux-kernel+bounces-362035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA9099B02C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1BC7B21F76
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE01D17993;
	Sat, 12 Oct 2024 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBobiBMB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBDF15E96
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728700847; cv=none; b=uKUcxWy0rvaBgemVni+ycKvEC/WaH8QTJRJi19fdWTVqGixDcKosm01jYtnon4oePoURLbp5O9SkGZhcn3e029rg9uSZHbFobg1ySuMQ8L2qvQwlk7/BCkTCiWf7yWVr8gu2dmTBuZbQFsGBNHlkXYe/PMQa0ztc6AiZsVsPza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728700847; c=relaxed/simple;
	bh=51zs2tkWqRZZcFAKIWaq/hBNo7OiVYRdIgURsxXA+VE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Js+q2a1+Wev2wCZDMZcBxL118OxdqJE+B3f2s/1waZZVCiFtGWoG/Nl2GJjAL3lwqckvQrZABp5JKBZRhz8kHrT7Qlhhq+a4uvu1vPDs2L/9/uabTm5F8D8Ect3rWwzZVPhdHnpwMlVPIdy6M5BoImt7RKmpk3DKKvO3s1vkyn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBobiBMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B53CC4CEC3;
	Sat, 12 Oct 2024 02:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728700846;
	bh=51zs2tkWqRZZcFAKIWaq/hBNo7OiVYRdIgURsxXA+VE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=uBobiBMBmW9NqfiAfqSxYBmEkJnS0OEq5W3CgyWE0rBZXjEtBJDh4McCgbr1v21Rr
	 diF3+/vBEuVK87BRTUci/0daWjogwOZUSNrJg5AAVA2aebVaK26cEAAvuN9aQpl7+h
	 LGkobN26niS2UrHOjwGRhANj1sUGbMHXUoVdbx25hPKieUnpp7JfTYWD18XjXO66is
	 hUaJ6ckX9/LPCrdMNerMwSNCymF3A4zbKdpMkl/yD5Akp4LXNxX1lnqgxHH3yQ/JcQ
	 Ciq2iTsUkV32X4RspqJKOf2BO1r7ORxHYqA3+GVf4BcvImmf2pf4xE/IJreVapCj6e
	 NXhmGlWf+fNaQ==
Message-ID: <54325522-b7fa-4629-bc90-ca5e5127ae85@kernel.org>
Date: Sat, 12 Oct 2024 10:40:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v5] f2fs: introduce device aliasing file
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20241010192626.1597226-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241010192626.1597226-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/11 3:26, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> F2FS should understand how the device aliasing file works and support
> deleting the file after use. A device aliasing file can be created by
> mkfs.f2fs tool and it can map the whole device with an extrent, not
> using node blocks. The file space should be pinned and normally used for
> read-only usages.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

> ---
> v5: added a ioctl to know whether a file is for device aliasing

IMO, maybe we need to add a common wrapper to export all trivial flags of
f2fs, which can improve scalability, it benefits the case whenever we want
to export new flags.

Thanks,

