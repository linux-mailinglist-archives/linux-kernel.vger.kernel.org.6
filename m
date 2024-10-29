Return-Path: <linux-kernel+bounces-386143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5399B3F92
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD071C21EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E6F20DF4;
	Tue, 29 Oct 2024 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXiXPyAy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A917C96
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164168; cv=none; b=qfYsrtjkvtYe1qlfCIWV41Xlq2UrPgqIGnFEi2OxUbfSAjqFVuOWkWqGhxtmj1BswLwklpbn22bSTzf+RNyj/WkW3sU6bJl1wp9IskkLb9Wvv3SQV/nf18l6O9/VM9uezRbTcq9VgYR16+5bSEPS9g4h34VxI/FC5X4sxsknrWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164168; c=relaxed/simple;
	bh=Co1WaJga7dR8mWqJppxdhIoIdaLUPCiPfOT5nWs1W2A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DL7eJw2Z1ysSDNWAzJha0nClgdgadSkUH7kaOnbmndfSga/D3BQvSReyyhT2l3iNr8TWeTzxKnMsy/L3/SYClqrdexYhsYXlfIsGP6VXhvx3BlYv+7nm1Z52pa52m3fO88BRZorRzFOOHGPt9HW/WdUhXChVhSOEnXvBlBWfeMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXiXPyAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765F4C4CEC3;
	Tue, 29 Oct 2024 01:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730164167;
	bh=Co1WaJga7dR8mWqJppxdhIoIdaLUPCiPfOT5nWs1W2A=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=jXiXPyAyiMmmfv/Q7ctR1c9yggGO/TTKYyvYFQzBNMAndYuBDZbVkvyn3qCCZIBiO
	 o8jxrUibOhwe7ErL1cnH23x3y9oPERdqTRG5A55AUh1gc6X9Ry76YUaWrQdDepjM1b
	 BwKbGiNoL9qdms+pwjyzgtyTmdWL9ZkjJ7zFjTiME/bRTiLWZJjTvks05Q2J0phI7I
	 Jsu/7ge7yVCglEnb25iug59pUGzGI/heoM0qV3sMNuwKjvqAHX+C4xaxjeJqMMki12
	 GKlo5mYWGy99sqCmr4jlknU4E4DWxTrO+qOAh2UsGgra6+6J2gQjENss1HBXxOpUe1
	 VIokz26QJEghQ==
Message-ID: <a380fc63-a78b-4be2-907a-e466d7757a99@kernel.org>
Date: Tue, 29 Oct 2024 09:09:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: try to allocate sections from zoned area
 except file pinning
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20241028200953.2010714-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241028200953.2010714-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/29 4:09, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We don't need to allocate blocks sequentially out of the section
> boundary. Instead of that, try to allocate sections from zoned area as
> many as possible, since conventional area should be used for file
> pinning.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

