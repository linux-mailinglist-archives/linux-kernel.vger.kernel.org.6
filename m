Return-Path: <linux-kernel+bounces-316699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6523D96D2E1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B641F2110D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF88C196D90;
	Thu,  5 Sep 2024 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="brIO3LVF"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B733F9D5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527626; cv=none; b=N0YJRlcBwwKiF92KeWPB17z0WsPSjVyzJWR7qHnHEM+j19U26MXmIj3RViCbLMQLByAJ4tx7Y17VnBFnl7+ESIFk683w336qC536DXuK32ldXIBaSLFbIrx2sSkjNaUL/h/aGiWSs+IgFQLHVpG2ASCLUKbMvCW1u6Hcx2qI9Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527626; c=relaxed/simple;
	bh=TiYGH2pjgQeZuiXElIDZ3jJq5kY19o16TkPjT+AQoxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmrL86T4rjQdPJDnDimOKKJ/6zFZlJnXuNsLBf/rY+RjZoa+8cc1NsS5IY+59852jlLAsODQoGPZEUEgJvYW0dNyc2EbGjXbF4I4K4PsoRXJXWt7te242P3s+0XxkRaMd6bIxzL1VZ4n7pwBPl1gpCJWsGP5TQXIaZCc42KYWfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=brIO3LVF; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725527615; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UwYdzizBlQz7pUl5vXmSdQZIKg/oWOvKB2rkQfbqDBg=;
	b=brIO3LVFdWVMImURtN7lalYqSWtdMUWdbXiHP/Be2cJ82gNN3EJKkTQpilaS3LPa/klq7BlY6UZwLd/fNvu53ayUW7xDPcTUr1feLpCFvMjfkkiakyQEbupHTC9qocwODFj1ZZ45QUCJWEWMeLsH7dj/rr6YzEQ5H2KUrjQ2ii8=
Received: from 30.221.129.218(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WELClc._1725527613)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 17:13:34 +0800
Message-ID: <55267cdd-c832-45c9-bbe1-9c02473a2269@linux.alibaba.com>
Date: Thu, 5 Sep 2024 17:13:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] erofs: support unencoded inodes for fileio
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-2-hsiangkao@linux.alibaba.com>
 <d095a86b-a1f4-4b31-8092-afa3ef1dfdb5@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <d095a86b-a1f4-4b31-8092-afa3ef1dfdb5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Chao,

On 2024/9/5 17:01, Chao Yu wrote:
> On 2024/8/30 11:28, Gao Xiang wrote:

..

>> +
>> +static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
>> +{
>> +    struct iov_iter iter;
>> +    int ret;
>> +
>> +    if (!rq)
>> +        return;
>> +    rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << 9;
> 
> Trivial cleanup,
> 
> rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << SECTOR_SHIFT;

Will send a quick fix version.

> 
>> +    rq->iocb.ki_ioprio = get_current_ioprio();
>> +    rq->iocb.ki_complete = erofs_fileio_ki_complete;
>> +    rq->iocb.ki_flags = (rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRECT) ?
>> +                IOCB_DIRECT : 0;
>> +    iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
>> +              rq->bio.bi_iter.bi_size);
>> +    ret = vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
>> +    if (ret != -EIOCBQUEUED)
>> +        erofs_fileio_ki_complete(&rq->iocb, ret);
> 
> Shouldn't we pass return value to caller?

I don't think it's needed.  Since ki_complete will handle error cases
for both (a)sync I/Os.

Thanks,
Gao Xiang

> 
> Thanks,
> 

