Return-Path: <linux-kernel+bounces-390117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D659B75C2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4777E1C21A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013BD14D456;
	Thu, 31 Oct 2024 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXADya1n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162C13B592
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361142; cv=none; b=pyuixBcnTMq7/QfJ7qDdBwfAtu/Ob7hNCq7YlxvNC2BMEQBZu/2fkDAHzgEEva+scsxnmFAIXCmrzYNmnQVXlB5DKz3UzBsIMu0akXYIYE6efAhx88TSkjPcXFr198BTOS21Oavhq1P7dG57Jh6EEGvrrQmlGtWSAyno0stUL/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361142; c=relaxed/simple;
	bh=Jl0XW52+cFk9nrdRa6KzZgnMH8eJ0pB33RCLMYvamS8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X6Nlr/Krndrf4FIiWeWLN9vlHVMgVe0f5mbDgXVZCcnuP+rmo+LOokGOhd0X5nmeY5dxgw2PZOTlby0PaN8nm3aprlXbdhFg8rwnRkZxeBVn8fiSHazkM4dcIKQAyxA8wa48rn7ArIj+Q4j6kNzsXuiu8LZJXRoVDnbYtod7ga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXADya1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0D2C4CEC3;
	Thu, 31 Oct 2024 07:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730361142;
	bh=Jl0XW52+cFk9nrdRa6KzZgnMH8eJ0pB33RCLMYvamS8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=rXADya1nPv23ljwSNaT5ufh62cgCTwzHcalOLNZerQfPWbBudN2pNyDFDqnv6p6ZR
	 UHQI0pXlZg7fI3HE2P31DkD5zes5k0lUPXCurOr4Kh6QKlCagO+hrRmcXTxdoS9k0d
	 vbOmstGmkce6CbBHio89wOSwNQ94DDWmuFS38Qu4KV3nkg8lsJ7RVvbmadctmMV9ES
	 gEznWe0ZFmOA5/vkf8TVowjvhB6W56PP6IWRPypGFWe26J/P0/X64uwEPWBV9dSxg9
	 T2pn+me3zncpOcb6zPp3Esmh0lg+IVchDFxqXodgZu/8GNSaXspJhFWtlrA0m7+Hub
	 6r4SXQrjZlcRA==
Message-ID: <8b06aaba-e626-4b9a-9963-85ad8b89c866@kernel.org>
Date: Thu, 31 Oct 2024 15:52:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Hao_hao.Wang@unisoc.com
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: remove redundant atomic file check
 in defragment
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/31 13:59, Zhiguo Niu wrote:
> f2fs_is_atomic_file(inode) is checked in f2fs_defragment_range,
> so remove the redundant checking in f2fs_ioc_defragment.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

