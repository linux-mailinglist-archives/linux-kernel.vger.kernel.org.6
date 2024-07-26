Return-Path: <linux-kernel+bounces-263073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8809293D09D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315B41F22078
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773BA17836D;
	Fri, 26 Jul 2024 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaPSsyuC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0A13E3EA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987292; cv=none; b=PiKp46E30sddCipAzQOfej/6mg6ODnt7edyCrbFI77YO+GWfjs+Tb9mMN2dU4y/XhZC3Tl9I3Ro2ekoeZ6aOTbYxURkGF9wCyA/1Sc65/7xvr8fmYjMJna7+DIrjv5fFLwqF5YCPxB3nkFnTNUvEjGnTYPJEH4/8UjT+9UDeMiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987292; c=relaxed/simple;
	bh=ayFiWm/WuLiRqH9qfUcMqJzUthosUQpNHRXQfqPxzh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aq+HvfDoZVfxeP2vXzQqu7yHYUpI9muswfOBIgi9eyj01VNhB6d2NI1YBCgpWj3R7hG/YzqwP/nXZcp1R/xDMxcaHOxrx5wtYcR2Nv9hy07tZ0qtqblbqxZxvj+E7wGK2VPD5CaYWpQnwjgTvtToT420yVp7XPGQn4tVwPSwVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaPSsyuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B3AC32782;
	Fri, 26 Jul 2024 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721987292;
	bh=ayFiWm/WuLiRqH9qfUcMqJzUthosUQpNHRXQfqPxzh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eaPSsyuCMQP86llfgQDA1ySdbYR6aBaLeNkBRtKVR3X6CHh69RkYzp2JzVIlpi01d
	 lGHolw4U+Pfyb97x6qOgs6jBS8z70YRixoApdAR6qWPo38re8JBrWCYUTyrNs1sTbC
	 47HYB6nXLVu7T9mzqrsDAjPfAnfl8ujwmGnYF73VeFXSQEOTdrYXZ/FIL8dUrS3iCZ
	 pKIdiVpLAOWWp2v41kBMAIl+WAI6EjECKORLUBgZAEhKdJ6iqBKcTtzWYzH0XcM87l
	 VmUYTMTFin18+kxe1Vj3Ab2fIDYFKrYkwT6rFN+KudvjlznCIowQPztZfFFdCjdTkY
	 XQdAaroVat6gQ==
Message-ID: <3b871ee3-c246-4eee-8929-d0aab014a41b@kernel.org>
Date: Fri, 26 Jul 2024 17:48:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dump.f2fs: add checkpoint version to dump_nat
To: Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Wu Bo <wubo.oduw@gmail.com>
References: <20240726022550.3117469-1-bo.wu@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240726022550.3117469-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/26 10:25, Wu Bo wrote:
> The cp_ver of node footer is useful when analyzing data corruption
> issues.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

