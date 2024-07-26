Return-Path: <linux-kernel+bounces-262773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CDD93CC8E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8211F2248A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D041BC39;
	Fri, 26 Jul 2024 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="XKszq6Xq"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05E0320F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721958935; cv=none; b=cKGE0EwN6koL1qcuKR3hf7lbmAK/aN3W6RhVkTilD/tz3pPw8qMHpaVy8ywsMPQjh+r8z8zXVlcrnL1rY3Yw6WvFRQ53YzqAJTmebTD7bcIxifIw0kFKT66lDBNTOPED+NwcPuO6xYfWDrvVhzEWIYrUudA2nFaxLvZlYsZMtk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721958935; c=relaxed/simple;
	bh=WYqZridchZzfdN6QnNSxKIdLAnZBSVIQm81qtZ+/BJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxgIYvYOE39prcGqAo4qRy+jA4QHTQu730GRiAOU11WqMBaQV//FTsabpDMoGk/r4fKU0vkEL2JR8mgAeeh/2eKNZ0j9usZD86qvUvPeqqzku91uKSLmJg3li08s/RMOkwIXDcbhXCpcy017y2h7osPBxeoOakbvx/dzeVq+ytI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=XKszq6Xq; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d9bcb47182so296565b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1721958932; x=1722563732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwZLflB06V4tnnB1EWMignUoULBKSrqsfwebBDmI2fA=;
        b=XKszq6XqcG1sJjOBOaUlzpYQurFzlqo5ErX82NJlEZgwnqUSPe43kKvM8SZ42c4+z3
         Y/Z4abuhOL802P0xJWpDTjc/8fMHlTpkreFnZIPn3CWMJVNjnZGmgEiyzNBVX0eWI7+V
         gXvYd98jdWd4ifiirAhvo5GtBiVvsUoSZjBcLuLxrfkJlcxaSAvxoGrRUa0NVtx60ozL
         lDJmNEpdMt1H5+tFj/KARnUmYbMY58ZB5TtKaVhYsvmqNYDFFxmQYs3VclMO3BGh4vwK
         42OV354ErYYJQepZsRRszH2N/nM5ORMDcdQuecRyWRg2PmKKBnVLQF/wM2HklbwiJ4aM
         ZTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721958932; x=1722563732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lwZLflB06V4tnnB1EWMignUoULBKSrqsfwebBDmI2fA=;
        b=bEUJzsnQnGv2fUw9vlNmZVQ189yVIv3TQ6tToOBLPS7QhwRmrEBSmNSdDv4T72qUlz
         kXwizTYSCI8WbJsgC9aVzFWSRfPeQaJ7Gcbc3WOilNLwpquTz9oOyWO3Kxs6KMWpOhdv
         ptva5nRwzaaWglJcP2Pugnx/mK3dMjizgb6BB2H1EWrse1HMSgB4bRp6Ow8p0oWPE0nx
         LcMzV9X7meGFF2TF/aNM+4lYFfAlIL0m3g/hLtDNjC7B8sYlaua6/iXaUNNseyyVjzwu
         LQP1KCkRhr/8kS3yFfh+Y2nhYcifmf4Ug1GhA3it6uDyQqlIT53Uwa3j8zxTjMb6zglh
         KNAA==
X-Forwarded-Encrypted: i=1; AJvYcCX13bo9Ddc7GreFqLe+RW/Ib/ACslwz8S55IrpNSVZYuKpLxN5mE40AEBUgXhy9+NRKyXHPLj6yLMNz8GWH7exTS2Dc8Enoq1qs0bMj
X-Gm-Message-State: AOJu0YwROlDwO1PIFLqpYYNpRHoELFJvp+3ORjZRvWoYmZsdkBXCPFfz
	ampHsKxA/mbo6e6c5b/Ueh1YNheM3ID1K5uKYOu8/iS9KH4bXRbV97cIjWo7RmntI9LQN1OxT7r
	Bpf0=
X-Google-Smtp-Source: AGHT+IHfvKlhTS94BpVJJTIAh0iHmmNCdLG03YYWoEQxpyHfOQ6GoTN0j7Qeo4O9DHpwZL4tivVUzQ==
X-Received: by 2002:a05:6808:1449:b0:3db:31b:1d5b with SMTP id 5614622812f47-3db10ef676fmr6465894b6e.13.1721958931962;
        Thu, 25 Jul 2024 18:55:31 -0700 (PDT)
Received: from [10.54.24.59] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f7c73cffsm1539945a12.8.2024.07.25.18.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 18:55:31 -0700 (PDT)
Message-ID: <ed6f4fc6-bde5-4b04-badc-c4927334f766@shopee.com>
Date: Fri, 26 Jul 2024 09:55:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: don't flush in-flight wb switches for superblocks
 without cgroup writeback
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tj@kernel.org,
 axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725023958.370787-1-haifeng.xu@shopee.com>
 <20240725084232.bj7apjqqowae575c@quack3>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20240725084232.bj7apjqqowae575c@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

             

On 2024/7/25 16:42, Jan Kara wrote:
> On Thu 25-07-24 10:39:58, Haifeng Xu wrote:
>> When deactivating any type of superblock, it had to wait for the in-flight
>> wb switches to be completed. wb switches are executed in inode_switch_wbs_work_fn()
>> which needs to acquire the wb_switch_rwsem and races against sync_inodes_sb().
>> If there are too much dirty data in the superblock, the waiting time may increase
>> significantly.
>>
>> For superblocks without cgroup writeback such as tmpfs, they have nothing to
>> do with the wb swithes, so the flushing can be avoided.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>  fs/super.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/super.c b/fs/super.c
>> index 095ba793e10c..f846f853e957 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -621,7 +621,8 @@ void generic_shutdown_super(struct super_block *sb)
>>  		sync_filesystem(sb);
>>  		sb->s_flags &= ~SB_ACTIVE;
>>  
>> -		cgroup_writeback_umount();
>> +		if (sb->s_bdi != &noop_backing_dev_info)
>> +			cgroup_writeback_umount();
> 
> So a more obvious check would be:
> 
> 		if (sb->s_bdi->capabilities & BDI_CAP_WRITEBACK)
> 
> even better would be if we'd pass 'sb' into cgroup_writeback_umount() and
> that function would do this check inside so that callers don't have to
> bother... I know there is only one caller so this is not a huge deal but
> still I'd find it cleaner that way.
> 
> 								Honza
> 

Yes, Thanks for you suggestions!

