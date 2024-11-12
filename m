Return-Path: <linux-kernel+bounces-404995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FE79C4B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F7C1F229E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15171F8196;
	Tue, 12 Nov 2024 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qEwXZrft"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6671F708E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373572; cv=none; b=AI7cLY6htZYG49QBxi6UiFuSn2uVK2VMqkSGfsLm59jF9ki9xA/AMNLNU436VwpxW8ai3292/eBHMX1BOyRwlq+zrAG7A7pqxVZ6bQVXyV52/oHHbT4uAFid85AZbh1+oJAfFblg8mPGPSTWRlkoAejJ9LnE0tlZ7VCOX6ghVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373572; c=relaxed/simple;
	bh=rrc1oKb01rK1vEbuHPVJOa+h96ngQQ/gq2O/ooStszo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3q7+2dw4zCp62RgCA6gG7tIvXjfVrH2auexvozgu0mBrVxXFygoAKwyS5U+eTUV5t0Ox5lwfe0kfRFJf27cTQD7EWZmUCk1LC5EPwV9HBLDffHabiZ+JSpdq8YC9Tt11wMuKvGLjlbAbDUfWZqCLX2OqADnpdjk15SDQLaMOM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qEwXZrft; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731373564; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rrc1oKb01rK1vEbuHPVJOa+h96ngQQ/gq2O/ooStszo=;
	b=qEwXZrftWWC6Qq0u4QJLN5assD/o7efodb6BqKdDxTBB/nJzv88APSguB1qkXHmsa0e76Rmao41VLPq4uQa5QxrPpI1InqjmF/nFfeBFfGBTvc/mlzY3VazmtlSZG+0eE5NThrBKe7Od+cmSusdL5yEcJkPvoC5nGRdyMiGHdiA=
Received: from 30.221.128.202(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJExm9j_1731373563 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 09:06:04 +0800
Message-ID: <9cdf389d-75a0-4529-a96f-23a4f2bcd4ee@linux.alibaba.com>
Date: Tue, 12 Nov 2024 09:06:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: add sysfs node to control cached decompression
 strategy
To: Chunhai Guo <guochunhai@vivo.com>, "xiang@kernel.org" <xiang@kernel.org>
Cc: "chao@kernel.org" <chao@kernel.org>,
 "huyue2@coolpad.com" <huyue2@coolpad.com>,
 "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
 "dhavale@google.com" <dhavale@google.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241101124241.3090642-1-guochunhai@vivo.com>
 <0fa61236-e84b-4a3d-9804-612b33d166da@linux.alibaba.com>
 <e1b73e98-496c-4d39-b8b0-232cffa266ec@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <e1b73e98-496c-4d39-b8b0-232cffa266ec@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/11 19:10, Chunhai Guo wrote:
> 在 2024/11/11 10:28, Gao Xiang 写道:
>> Hi Chunhai,
>>
>> On 2024/11/1 20:42, Chunhai Guo wrote:
>>> Add sysfs node to control cached decompression strategy, and all the
>>> cache will be cleaned up when the strategy is set to
>>> EROFS_ZIP_CACHE_DISABLED.
>>>
>>> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
>> I guess remount could also change the decompression strategy?
>> Or there are some other concern that remount is not usable
>> for your use cases?
> Yes, remount can change the strategy. However, the cache will not be
> cleaned when the strategy is changed to EROFS_ZIP_CACHE_DISABLED. I will
> make another patch to address this during remount. Thank you for your
> suggestion.

Sounds good to me.

Thanks,
Gao Xiang

