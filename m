Return-Path: <linux-kernel+bounces-314100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1129E96AED3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DD02864D7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640C63FE55;
	Wed,  4 Sep 2024 02:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XQtjInpL"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A5C3CF65
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725418587; cv=none; b=IwWdnnHZD6qqpb599B/VHB043vArqDEw/SV8XDA8LZbCsDc0s3qZETuF2aJXCTvs0sw2TEx3oh4oJxKbdnpxehnKT1GC78Wgwhmt34b3dCuFqlykDr6NEyWGrZBES91mpaZIqHKMi51oluHRLqIyVe30IGhzfTq9qdoCMeVLy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725418587; c=relaxed/simple;
	bh=14rH4WdkWdWibctUOK+kPWCfmXRDXsOefGe6wfN/PaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PK0r8f1V59Uhwd60Hn82DUjiksDUgMS2Vr3xs/2Yv+kYD9Xxl+1duLjvN7Ixq5ioHlSXon06dCzs9RepWQDHFTwMZOtQNW1qMgvabp3mGopui1EpqjxifUNSlM7G4jpGs/lbAqRg2rfwKRVR9dmnbvubyH945eMPxxbGXFNx9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XQtjInpL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42c7bc972a5so5071215e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 19:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725418583; x=1726023383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ubn5GPjsridgsmOU05JKYbFNp+11/YV274NOu1eTxQM=;
        b=XQtjInpLfulY24YqUCoYayeJ/jR6CkBCzlGnaGK3sEYoxJaTKa5IY4QSTHYWLbZiDb
         vVX5t9r5Mb1dp/RR2Iv2FFljhJA6Leapg2rPxthwKbxsmeI6DYnB+A/K3k4uROqoDF01
         vBI2PKbG8AixxjhevuvhmoHT+dXJzV0n9svQxnO1iN1EULDFZMQWjJnurLVuEXpjCY/3
         zfsk6vogYQ/dGnPosrSf7vQjRJ3bLQotrH1GWHap/A7/7Fz98ce1sS3s293fzDHc0uFF
         WyfFSilfNSqsVstDvo1ZXfOjE32hOHQGnYGJseTIrgxarNbDkj8mLVrwo1pgpxJ0YrsZ
         Ottg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725418583; x=1726023383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ubn5GPjsridgsmOU05JKYbFNp+11/YV274NOu1eTxQM=;
        b=MQvu851xS2xN7+8a4Wp66FUZpYQlJ3c4AQnqBANd1/5BIqeWztpbAJPJBcKO2v88RH
         azW7EGUOy9OL59V1+G7fJ33ybJnlq8eQpsBjvGJL+eeAGm6E4wnGGosjoWD6K3KShNP7
         EB3Spo5tUXVHqvYoYxUNaWbroNDNwpELM49pMtnEALYNoyCCFuEJccfS/LA6XqGG0dKp
         bHHpg3EjbMP9R9Gl8AftTs2cH/DpaJa724T2mzZeTABO1zuFbip284XE/7L+hyDx+r7i
         T4ADEFAcYS0tfYGfMg1QTsZWTjIO5LKRaTmwF3z0oEMN2EJAt42p3UUv7+jqQGRA5B7i
         rXRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAJLT8XESkl+Pu6ZEx0La2p6HjpfSTWSNrV6J0x+iAGZrRMDpHfJVyDVQ1y7JjyPb1V/OQPY9ZKxRHVxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxesr0ki36tIrh+NNaAXL5VpZg+5fcWf5bBZWuYvXN4UAopKPsT
	IpSwIjssYAFbOtUUTNdQ4IGfFZ8BwLffeCklvAfMXlZKLo2TDERIsqD+nadzFXY=
X-Google-Smtp-Source: AGHT+IEJXBKc6njWxBLSEnW5c7t5V760KTvEErAuOB8Hq4eRJ+IEicwbGrEqupTSPBpcNn2ALmi9tw==
X-Received: by 2002:a5d:588e:0:b0:374:d088:476f with SMTP id ffacd0b85a97d-374d0884b17mr2791420f8f.5.1725418582334;
        Tue, 03 Sep 2024 19:56:22 -0700 (PDT)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778533261sm566410b3a.71.2024.09.03.19.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 19:56:21 -0700 (PDT)
Message-ID: <0d6730e8-9a58-45ba-9e57-c22039f03253@suse.com>
Date: Wed, 4 Sep 2024 10:56:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: cancel dqi_sync_work before freeing oinfo
Content-Language: en-US
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+f7af59df5d6b25f0febd@syzkaller.appspotmail.com
References: <20240904020949.1685198-1-joseph.qi@linux.alibaba.com>
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20240904020949.1685198-1-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 10:09, Joseph Qi wrote:
> ocfs2_global_read_info() will schedule dqi_sync_work. So any error
> occurs after it, we have to cancel this delayed work first before
> freeing oinfo, otherwise it will trigger the following warning with
> CONFIG_DEBUG_OBJECTS_* enabled:
> 
> ODEBUG: free active (active state 0) object: 00000000d8b0ce28 object type: timer_list hint: qsync_work_fn+0x0/0x16c
> 
> Link: https://syzkaller.appspot.com/bug?extid=f7af59df5d6b25f0febd
> Reported-by: syzbot+f7af59df5d6b25f0febd@syzkaller.appspotmail.com
> Tested-by: syzbot+f7af59df5d6b25f0febd@syzkaller.appspotmail.com
> Fixes: 171bf93ce11f ("ocfs2: Periodic quota syncing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>   fs/ocfs2/quota_local.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
> index 8ce462c64c51..ebe0dbc8db4a 100644
> --- a/fs/ocfs2/quota_local.c
> +++ b/fs/ocfs2/quota_local.c
> @@ -782,6 +782,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
>   		if (locked)
>   			ocfs2_inode_unlock(lqinode, 1);
>   		ocfs2_release_local_quota_bitmaps(&oinfo->dqi_chunk);
> +		cancel_delayed_work_sync(&oinfo->dqi_sync_work);
>   		kfree(oinfo);
>   	}
>   	brelse(bh);

In my view, there is one problem:
If ocfs2_global_read_info() returns error before ->dqi_sync_work is
initialized, above code will trigger wild pointer error.

-Heming

