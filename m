Return-Path: <linux-kernel+bounces-415882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DFA9D3DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58FB2B23F83
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A241AA1FC;
	Wed, 20 Nov 2024 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQhOARw2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDDB1A2C0B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112884; cv=none; b=g1HuqEQLtvd70j91hbNnmswuoDDJfojqnj/6PgnT1pSF93yZ6A3l30WEYWQdrSQUmRh1M2xnlrdWlZ8BpFqFH4EZTOMqKr659en+O6F+7RmV/W465X5VnjPBQ8zkgQ7FqDxzU4mwnOtUQ/1Tj8G9ggq9HtFtmqZlhja+Ff8qxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112884; c=relaxed/simple;
	bh=b2dOhAceJSD3kqQt9+Jcd3JVZf4eh0JzExHUTxlRIU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOj+URAXi+svZqA5wD8nSu4UHcjiRMJ2rBGJPeVEULQyZuoTfJJ8va4fgqP0meEM3yHnA64TE3fdcRP5wKlCe7g6TiKtK5HIxsxxSPIofu4kr4MCVD3YqjfgSlChh5+yJKcD5CsLkCXUqRlRPN4b0cz6oC+gIszViQfTQrnzgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQhOARw2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732112882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8FqI6bon1QS1nbiupJDYJ5P5cl8zCH5ATXfrWn/wQM=;
	b=fQhOARw2TEJF+ad9c+aySM/ewdowqniXFxQoWcore+uagMzfGnxBVsNtoA5xFKYB7ngHpT
	NjiOpcO5aG8oh7V4bh46IeCr7kXOFAqPsg5ZtaTMF1FP3Fv3dcp6AIcZK8zAIiw+aY8PFn
	MsRiMsHZyBvFLNTCfaq/AI58pKDUmq8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-WuwsRWXIN7mdWCkFHdSXZQ-1; Wed, 20 Nov 2024 09:27:59 -0500
X-MC-Unique: WuwsRWXIN7mdWCkFHdSXZQ-1
X-Mimecast-MFC-AGG-ID: WuwsRWXIN7mdWCkFHdSXZQ
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aa6bcd7b3so519026239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:27:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732112879; x=1732717679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8FqI6bon1QS1nbiupJDYJ5P5cl8zCH5ATXfrWn/wQM=;
        b=LPqnGt5RKRblLLRIybRhJKTqxJPbO7g5c6T/EhaoT1aszbqWy7EmAuFLZ/2MrVCuY1
         aPc+Vd3mx47Hqe/XNmolI0VN707E2DpKZhXpzPvdc+53pvJqKYc/Z5yUMKJF7LMxKpjv
         YKQH3RJw6q4Yj08iqmYCbiuSMmJBCqmgmN6aAb/irIg4vfzBY6Jo9nAXNk3gIeCBldJ5
         nc6WOlBo1oj0M/kASNrC+RJwLALpe2u5xBns1flz/bPHLqD67C2SAcl8HHtzotzeiKof
         xhWczVqFi7CIDuzvM3pjvnyNxqYF4I9rzotECDitiJ+CVTIMijL2SLqYHNP6TcjYP6Qu
         Kq4w==
X-Forwarded-Encrypted: i=1; AJvYcCX7KSe5kJGx+eGdY9RwkW+TZ/t0mCYJHnj+NG0ZAlTbSjZUkI1cFpKfWWIlx4FC3EQLcNY+IS7Qao4fK8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDoSMpd7nmWJiOHGtx0ArfAI5+Pfq9OVKtWFzoIEwYA31YMyf
	9aZF4bvYrJm1a8kGJ7a7FEOzkSMj8XUS7/r715l2nr91L3rtwdxiaR6XugYUmyqiqHsLUirYVnP
	ks4LMomw8FKIGP1gFamArPLVyZdHVx8ISttCdKx9U4h/wTKSEveiJFUs9jUL61w==
X-Received: by 2002:a05:6e02:b21:b0:3a7:6825:409d with SMTP id e9e14a558f8ab-3a7862bdeb2mr30647415ab.0.1732112878954;
        Wed, 20 Nov 2024 06:27:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBqdKIPt9WPJWK5kvNRHw1ul4I/pgYBloYCTR7r3E0Kf9ycgztAK7c2iqmaxbfhxQuCnm+5A==
X-Received: by 2002:a05:6e02:b21:b0:3a7:6825:409d with SMTP id e9e14a558f8ab-3a7862bdeb2mr30647265ab.0.1732112878678;
        Wed, 20 Nov 2024 06:27:58 -0800 (PST)
Received: from [10.0.0.71] ([65.128.99.169])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a74c2b477esm29631795ab.11.2024.11.20.06.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 06:27:58 -0800 (PST)
Message-ID: <493ce255-efcd-48af-ad7f-6e421cc04f1c@redhat.com>
Date: Wed, 20 Nov 2024 08:27:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "f2fs: remove unreachable lazytime mount option
 parsing"
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org, Daniel Rosenberg <drosen@google.com>
References: <20241112010820.2788822-1-jaegeuk@kernel.org>
 <ZzPLELITeOeBsYdi@google.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <ZzPLELITeOeBsYdi@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 3:39 PM, Jaegeuk Kim wrote:
> Hi Eric,
> 
> Could you please check this revert as it breaks the mount()?
> It seems F2FS needs to implement new mount support.
> 
> Thanks,

I'm sorry, I missed this email. I will look into it more today.

As for f2fs new mount API support, I have been struggling with it for a
long time, f2fs has been uniquely complex. The assumption that the superblock
and on-disk features are known at option parsing time makes it much more
difficult than most other filesystems.

But if there's a problem/regression with this commit, I have no objection to
reverting the commit for now, and I'm sorry for the error.

-Eric

> On 11/12, Jaegeuk Kim wrote:
>> This reverts commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc.
>>
>> The above commit broke the lazytime mount, given
>>
>> mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");
>>
>> CC: stable@vger.kernel.org # 6.11+
>> Signed-off-by: Daniel Rosenberg <drosen@google.com>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>  fs/f2fs/super.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 49519439b770..35c4394e4fc6 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -150,6 +150,8 @@ enum {
>>  	Opt_mode,
>>  	Opt_fault_injection,
>>  	Opt_fault_type,
>> +	Opt_lazytime,
>> +	Opt_nolazytime,
>>  	Opt_quota,
>>  	Opt_noquota,
>>  	Opt_usrquota,
>> @@ -226,6 +228,8 @@ static match_table_t f2fs_tokens = {
>>  	{Opt_mode, "mode=%s"},
>>  	{Opt_fault_injection, "fault_injection=%u"},
>>  	{Opt_fault_type, "fault_type=%u"},
>> +	{Opt_lazytime, "lazytime"},
>> +	{Opt_nolazytime, "nolazytime"},
>>  	{Opt_quota, "quota"},
>>  	{Opt_noquota, "noquota"},
>>  	{Opt_usrquota, "usrquota"},
>> @@ -922,6 +926,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>  			f2fs_info(sbi, "fault_type options not supported");
>>  			break;
>>  #endif
>> +		case Opt_lazytime:
>> +			sb->s_flags |= SB_LAZYTIME;
>> +			break;
>> +		case Opt_nolazytime:
>> +			sb->s_flags &= ~SB_LAZYTIME;
>> +			break;
>>  #ifdef CONFIG_QUOTA
>>  		case Opt_quota:
>>  		case Opt_usrquota:
>> -- 
>> 2.47.0.277.g8800431eea-goog
> 


