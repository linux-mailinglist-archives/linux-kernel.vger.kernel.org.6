Return-Path: <linux-kernel+bounces-186884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E79E8CCA60
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59C0282494
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094021C3E;
	Thu, 23 May 2024 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+R65Z0N"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1028017C2
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716428224; cv=none; b=lxg38nFFVX/2HxgIjzL5bC5dsckq+F3ON74YrN5w1BGpvSEXi/fNA7AORpAgoAh9ZY3WLVTQnAcvYy1vflWgmRR8DBBcnvZnLAy+sCO+JAa5ty0dWV98LYP8jvdIEpE4nJj04xeBz5tcBAApMUOsCjakyvUmRiBZ4VNhlM3vRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716428224; c=relaxed/simple;
	bh=kGBbqwGpDg6T3bWDaXa4CFJBOaPaxIvM1oeqk0BblFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EsRzD0YsQGZU6a0WhAkbyKBxQ4XLENh6sP+wfSVt6aMrQvLIG8mlWIXqbGmvr6BGSCuKrdm1THBCBqeNi5sgT1rwgk3pXvxrY5fHLO6oVhjgd1f3p7kQti2OuiK1O/B1aS/x+zTeX3sODdotvVpbGYd9Dw1TMv8zOOGxtiwedIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+R65Z0N; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f693fb0ad4so2360678b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716428222; x=1717033022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=79R7s8pLtoHIhwmaKcD4cPtvcVhYcyKme0j/iJFq8oI=;
        b=i+R65Z0NivWT2ORoYy04qgFDD8FHobF+7DNT0UZfFZ7l6QzoyJsyo/yjxJB5PsMj/c
         n/assegw9NwrraxD79PyRzkOwPNrTLLiXg4wR99v5YoY2irBxzOtpZaFANR5zYvlhcb/
         QyBOSefWrFaBHSdaX5xaYQUlqkH+qEN8L+55ObHZNkEl1Z8uTFKi2QWjT641iNGKXX2/
         H85oV/SI1k8hbwUoGMuV256eCOVX2vK9DRvBLSPweTq6hU/AzEO3wwIZSOUPPuf01B2S
         LqFg7nq4i+UtclThfyxcBefob5bFeeYqV0AFeeQi22tcMMCDGpMOprVtAIXj5kTGVz3x
         RZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716428222; x=1717033022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79R7s8pLtoHIhwmaKcD4cPtvcVhYcyKme0j/iJFq8oI=;
        b=YamxT9JzWTzjqw7/8JPCyDWOQwZ5Z0X9Mq28FySuxZ5Gf/qPErIX5Y4QmydGGioTH5
         mEqsDSg1nGMjBwad9qz9psYSb3Uze8eBcUXbIlTy8/iNkTCH2zJKHSZpPEI0d8XyxJC8
         SwwnJ83hGazpE02xc1u1RzMB0gCC9kf6St3/LHr8oIDOBhoPVLQm5DywIWFGkfeI5JW0
         M+DhEWQ17NT5nH0LFiwuNT5DcZKKFUk0naeg9Zc7Y3qYzSyMiFRNaajNjfi1J7thNg7K
         rd7tAdnVrKkSMFataiIYBmELBIO7N2MHjrMxDIx8yVsd44rj6jZX6XrH7Lp/sZmF5DaM
         +wGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjTnBfQ5Zb2JTXnvtORwnKfT97vx84+sCQODWLzQYgES5WITiyUPPkJvMM3e/FgfHzaSx5Py/GQHKWBkHZp/o4ZBVi2YTVbrgSfVMK
X-Gm-Message-State: AOJu0Yw9Smhzu3jqsPeZO/4OteH5BjmStm0leg4+lwiY+SjUs2lLwWLi
	6ZuWyirco0D01OVsvpAeiJAHKLypo0guxYWmEWOC30/ZvdbtDxri
X-Google-Smtp-Source: AGHT+IEgY5c8x1NpF8C+D4SR0pxgeqkG8oa5nkBRDkLxwKhjHAFBSgrbeVQygPQStNDU8hKZjCXsHA==
X-Received: by 2002:a05:6a00:9284:b0:6ec:fe38:d94 with SMTP id d2e1a72fcca58-6f6d620ac3amr3860825b3a.33.1716428222167;
        Wed, 22 May 2024 18:37:02 -0700 (PDT)
Received: from [0.0.0.0] (74.211.104.32.16clouds.com. [74.211.104.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f668dc48b9sm15896289b3a.143.2024.05.22.18.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 18:37:01 -0700 (PDT)
Message-ID: <b09604a0-83b0-4317-85ad-ead3d7d5bb3e@gmail.com>
Date: Thu, 23 May 2024 09:36:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] workqueue: Fix rescuer task's name truncated
To: Wenchao Hao <haowenchao2@huawei.com>, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-kernel@vger.kernel.org
References: <20240513140115.3892827-1-haowenchao2@huawei.com>
Content-Language: en-US
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <20240513140115.3892827-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/13 22:01, Wenchao Hao wrote:
> Task comm of task is limitted to 16, prefix "kworker/R-" is added for
> rescuer worker's task, which cause most task name is truncated as
> following:
> 
> root   81  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xprti]
> root   82  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-cfg80]
> root   85  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-nfsio]
> root   86  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xfsal]
> root   87  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xfs_m]
> root   88  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-acpi_]
> root   93  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-iscsi]
> root   95  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
> root   97  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
> root   99  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
> 
> I want to fix this issue by split rescuer name to 2 part like other
> kworker, the normal part is "kworker/R" which is set to task_struct's comm,
> another part is wq->name which is added to kworker's desc. These 2 parts
> would be merged in wq_worker_comm().
> 
> The first patch fix the rescuer task's name truncated;
> The second patch fix workqueue_struct's name truncated.
> 

Friendly ping...

> V2:
> Add another patch to increased worker desc's length to 32 to fix compile
> warning reported:
> https://lore.kernel.org/oe-kbuild-all/202405131400.sEYZHYk2-lkp@intel.com/
> 
> Wenchao Hao (2):
>    workqueue: Fix rescuer task's name truncated
>    workqueue: Increase worker desc's length to 32
> 
>   include/linux/workqueue.h | 2 +-
>   kernel/workqueue.c        | 6 +++++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 


