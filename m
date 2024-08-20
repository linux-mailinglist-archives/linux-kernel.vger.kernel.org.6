Return-Path: <linux-kernel+bounces-293400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B85957ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7712B247D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFAE14A0A8;
	Tue, 20 Aug 2024 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB5tA0U8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE018E36D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137092; cv=none; b=SBAz3G9MEJYn5N2SK6JfIkaRzmJD2s3tFBTnT/xIx5CpI6KPaJWmpu/lj2wFf/oCk3jV9loVrudQLMFWnAD5gnOevkdzcZQqYXYwe9LtssacAHqJPFHN7GtLjUdCznhwvdsnoIz+Ew02MBcN/huGMAPwhbI2BTGebI+9ZkYE/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137092; c=relaxed/simple;
	bh=5VzK0arXNZWe9Hr1ikvzK31iRl9Dw1JLNtUWg6K4hyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqzoiczhh+3WVSlV59jFBHv2limHJ76gbJS5ZwRrjWmd+5mRB606K2wMQoXSJAFYlzxRTYMUrH8SCyF0u7Vq+xzreuOL/sKrl788WWIeW5p3ay2P4tQxj6MkFPGqezOViXIhSrCWEHedxi1JFGMwW7qQhr5gE99l1zYOhfuiL8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB5tA0U8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B452BC4AF09;
	Tue, 20 Aug 2024 06:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724137092;
	bh=5VzK0arXNZWe9Hr1ikvzK31iRl9Dw1JLNtUWg6K4hyI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CB5tA0U8kuG192fxvt+AW67nbj1stAk9GvEOkwglk2KqSm0mJVjGZkDKDgAEAfQA9
	 bTSO2p8r6VYUL38g/BuWJkHZ2tHJbM2LqYOL1WPFgbsRQQpfuKNkMW3bW6XW6NggnS
	 c1RcPNiQj3LUJbR2fC1AhQPrpWOUFEjq4vF6Eqob2XVitqzrim4BpqBtCW7/VPpvqk
	 WYyeMr1TJI65l428DLfxvsz9dtK9WkDNE3Q+JzTN2pqi8D9IEUj86Cq8Df81farabU
	 lY2AFmLyaw23+lVlxBHKjr1hC6UKx6gGY52CRgS8+N8xGF9QsjyuIa6+YIzE/Gd8qL
	 8lSLxG9X0TMVA==
Message-ID: <a16d5083-5e24-43e1-b245-12152cac5947@kernel.org>
Date: Tue, 20 Aug 2024 14:58:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] f2fs: convert f2fs_write_begin() to use folio
To: Li Zetao <lizetao1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>
References: <20240820034654.698236-1-chao@kernel.org>
 <a36db618-e7df-4c15-ad6f-876d8cc2bde5@huawei.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <a36db618-e7df-4c15-ad6f-876d8cc2bde5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/8/20 12:38, Li Zetao wrote:
>> I want to apply your patch set for testing, but there is a conflict on 
> the master branch of linux-next. Maybe it depends on a certain pre-patch. Please let me know, thank you.
> 
>    Applying: f2fs: convert f2fs_write_begin() to use folio
>    error: patch failed: fs/f2fs/data.c:3566
>    error: fs/f2fs/data.c: patch does not apply
>    Patch failed at 0001 f2fs: convert f2fs_write_begin() to use folio

We should apply this patchset on top of dev-test branch?

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev-test

Thanks,

> 
> Thanks,
> Li Zetao.


