Return-Path: <linux-kernel+bounces-405006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6C89C4BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6F0282E32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E45204949;
	Tue, 12 Nov 2024 01:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfzA8fd0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564F24C91;
	Tue, 12 Nov 2024 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374714; cv=none; b=GBFxbyi5fCuCOfmhLL/vLWzI2pkzgW2d5l2IpBBkpxSFb7LZjGHzCqU3Q4XUoZxO7VL0SCCxp7MGT7tkldfDBAbC1IbPSb1s0qlO7jS1DjKFlv9O6u4Sb2ogE8EOYK8zrGVp0B8/HXNXQAa4D2B9av9NTDLxnlQVXPgv8VDeXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374714; c=relaxed/simple;
	bh=ajlOMkDBBhPwwih9QbgiLjrtuGoUTP90BUjo+Qgjh6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJ+aFA37NzLQJ0ovEeuqEBKkeEvHMFgnci3pTMRLV8NKih0AADkG+KOdN3/wLO9JsSmsFdpcUpop5S7HYtGgD7VenZGergHf2QgwzoSN2GhYpkLWx0LrSlpbTQWawRcspAu8bJ9LHZP7pvq4zT1c+4zu6nCmPmvmhVk8AMx2eLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfzA8fd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB58BC4CECF;
	Tue, 12 Nov 2024 01:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731374713;
	bh=ajlOMkDBBhPwwih9QbgiLjrtuGoUTP90BUjo+Qgjh6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KfzA8fd0pETwyYLinnu1k0mQTTKvKELRW4i7faoBwBldWHr02vsTE4zrbkG0Uh8zw
	 lnKJRShWAkZK0d5ZzMSVnjt6aXCIiu/qFsm/JbZGn+j+7AEi/e/6Hf5T7YUiWb81sP
	 mpGSzdd5iELo+Gxd1foT6IivsoctI0MHBwZ3Py9l02SfrI1Ek9UAYlT5nBHwmBSYr5
	 MjvrmedvjhWz1j/S+vIi+ha1jvgmQc2LXf1f48kOJVL3QynNGUoYa2JPQ4RtG5I798
	 7IjYvo+i48mFDcM4xlo5pL+txl50dOSX0HS44cl5iMk57PsEblHSYIXXnCjvXAe6Y3
	 Q4nzK0O7BxbsA==
Date: Mon, 11 Nov 2024 17:25:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <salil.mehta@huawei.com>, <liuyonglong@huawei.com>,
 <wangpeiyang1@huawei.com>, <chenhao418@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND net 3/7] net: hns3: Resolved the issue that the
 debugfs query result is inconsistent.
Message-ID: <20241111172511.773c71df@kernel.org>
In-Reply-To: <20241107133023.3813095-4-shaojijie@huawei.com>
References: <20241107133023.3813095-1-shaojijie@huawei.com>
	<20241107133023.3813095-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 21:30:19 +0800 Jijie Shao wrote:
> Subject: [PATCH RESEND net 3/7] net: hns3: Resolved the issue that the debugfs query result is inconsistent.
> Date: Thu, 7 Nov 2024 21:30:19 +0800
> X-Mailer: git-send-email 2.30.0
> 
> From: Hao Lan <lanhao@huawei.com>
> 
> This patch modifies the implementation of debugfs:
> When the user process stops unexpectedly, not all data of the file system
> is read. In this case, the save_buf pointer is not released. When the user
> process is called next time, save_buf is used to copy the cached data
> to the user space. As a result, the queried data is inconsistent. To solve
> this problem, determine whether the function is invoked for the first time
> based on the value of *ppos. If *ppos is 0, obtain the actual data.

What do you mean by "inconsistent" ?
What if two processes read the file at once?

