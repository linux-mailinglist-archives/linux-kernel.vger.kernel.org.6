Return-Path: <linux-kernel+bounces-515961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AC9A36B42
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038583B10D0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33957F7FC;
	Sat, 15 Feb 2025 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DeYXD+m/"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88074DDA8;
	Sat, 15 Feb 2025 02:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739585086; cv=none; b=rO0U/j5bWvvpS8BOQBKblJ3AoyNQtCdkaB3EPfANGE8TEYS0vFlTZ+scLY6LeJk7ivGUgAQAgEjTW5SPr2HcrCnAC8F5ahao7lVuvGwfkQeROPjYBilSCxI9EFmx9abvnoSYhaNX8A1tZ+cwCGaBMJ89Y/AEEzE6XoENQRId6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739585086; c=relaxed/simple;
	bh=M0upLoFPndDptHey1Fcz73xMNLIS6txJ8x7vbsBptNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsFbYhMmZy9ukecn/a+8oiKecW/9LQcWAPUxHIcGXapdsQUy2MbpUfSJop/vfBysEsESKAC0+CD/k7E8ExjUPtH9V91I1b7RVt6pSFf1+JgyA3esgXQoB4AJxoBorUBfDB0lAXk0llzO7vW5GGTfZFDX1FRJ4/DcpXhz/JnQ8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DeYXD+m/; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739585075; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0vS94aBejcjqMgts3e0c50StL2HUB8lQYljkWqVTZs8=;
	b=DeYXD+m/8Nyw2wt41cbkXprR6CbSbdCQFP3B7PZMGSs9gP31Ql2qr7fDaLxvJ4syHD2Lqk3+GmcwAsgCkKynhPt8wRtBCkdltg68PSTso0lTIzBQms1SQbqk0aEjK9hp3ZNZGsFLZvpwiCCn9cvCVtgVRcZen2zBqZN5x2PFODQ=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPSP6rS_1739585074 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 15 Feb 2025 10:04:34 +0800
Message-ID: <1edd2e83-81fb-4cac-aaa0-f9581bebac77@linux.alibaba.com>
Date: Sat, 15 Feb 2025 10:04:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] dmaengine: idxd: fix memory leak in error handling
 path of idxd_alloc
To: Dave Jiang <dave.jiang@intel.com>, vkoul@kernel.org,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
 <20250110082237.21135-5-xueshuai@linux.alibaba.com>
 <5fa82b64-ac38-4d4d-9ff9-a2083a3d92a4@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <5fa82b64-ac38-4d4d-9ff9-a2083a3d92a4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/15 01:01, Dave Jiang 写道:
> 
> 
> On 1/10/25 1:22 AM, Shuai Xue wrote:
>> Memory allocated for idxd is not freed if an error occurs during
>> idxd_alloc(). To fix it, free the allocated memory in the reverse order
>> of allocation before exiting the function in case of an error.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

I received two Reviewed-by from you for this patch, is this (the second) for
Patch 5/5.

Thanks.
Shuai

