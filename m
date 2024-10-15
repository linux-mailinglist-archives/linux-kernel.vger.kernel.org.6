Return-Path: <linux-kernel+bounces-365064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB5499DD00
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1A51B2242C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C81E1714CC;
	Tue, 15 Oct 2024 03:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NlP2IHtH"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3941C46B8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728964052; cv=none; b=ER+M3uv0OejaLa3Ct7SJRIGmYRJhKSjhTx2GmllMhgD542tlvtlxzzbDfqbbJF7C2S36mAbIeqTqOR0vr1BoyKrI7/GBcEi9ftxlm7lR3rfkuY1EHRkjh2HcjIAvbyZUNToxCTBL7iilfnFRSpJjupep+IufjP9VhY4AmMRrJ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728964052; c=relaxed/simple;
	bh=2Ep/QAB9DEwmQD+dOwJTBB24RqOGHJIyRcWHNkFkgXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ja+JihjtUsx6DiLaf+JovCfCywO3hYVs87vXE8ge7uelTKfW3CS4YSVXu+db3cN1CxyyOl34LXtklgcPM4nMfsR1nd0YxEyY6sA1ACgCQPSiVC6ON0dLIvqxY53Dc6Y1s9QKMRkuUK3erGtEtZkDkI7yCcMYevyJTTXjNk5UpiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NlP2IHtH; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728964047; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CwxB1Vthx8aMmA8+rN/HOXJXgXbO9JZ2ug4RUwzvkh4=;
	b=NlP2IHtHLckrbf/so0ZTRDmpH3pXsn4CVz6xdAEXyY7g2TiLL23EHRkECUi6g8W0u1oBHsDqpDkZW2j+gbTheUtzxmerCLosdQ+Va73fa4KW6boC1gMES/GFUQ9B18zTSdCzPLZdE3HVWZc4GP6UI4nVuOxPBY04c7RHqNTM7DI=
Received: from 30.221.130.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHBmJiK_1728964045 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 11:47:26 +0800
Message-ID: <231e17e3-82c1-49f4-9cc1-b376b89205b3@linux.alibaba.com>
Date: Tue, 15 Oct 2024 11:47:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix unsupported blksize in fileio mode
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
References: <20241015033601.3206952-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241015033601.3206952-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hongzhen,

On 2024/10/15 11:36, Hongzhen Luo wrote:
> In fileio mode, when blcksize is not equal to PAGE_SIZE,
> erofs will attempt to set the block size of sb->s_bdev,
> which will trigger a panic. This patch fixes this.
> 
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

File-backed mounts should support < PAGE_SIZE sizes.
You should just fix these cases instead.

Thanks,
Gao Xiang

