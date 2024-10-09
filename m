Return-Path: <linux-kernel+bounces-356214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE12995DF6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56791C22FF9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE47143888;
	Wed,  9 Oct 2024 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HlU0vUvS"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F319E13635F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 02:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728442692; cv=none; b=JxDsLJ0sn/bi6duLeFKnDyG+VE5Gtt3DkbgZykyKxF9e9oMnfYX5qvkQFZ98VC1XjSTPpPFxlSTI6oadfh+HhZxowF4qbCdAQv4yISBZZ2XiH9BPsqRFmDljZXnMoiezKoWNQmqIgFfuxcwYQIqTxi5/CxhVJocZvmNc+FIUKuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728442692; c=relaxed/simple;
	bh=OEWK5vI2lCBE3KE/69uvB/ekAtGhUNj6TA+SnKCTdxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vad8r7/le2d3RM5+fiUaNtB8zRbROEWrv09r4IIRkB6+GJDFDsT8cY2e38sht0XcB5FHyR9TqPvfYIz+S4zJI+jnueABIKc9ed0M3hn5SigXU4OR3PaOuIW85O4IH6Bk2mz6mbi10FgGbJX0ue7GmeMSvpYZjlkoMioRT2Wytog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HlU0vUvS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42f5a663ed5so9738265e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 19:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728442688; x=1729047488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9o3xjneRzpxTeUAgzBHAVPEaaxarVMtSkH9MOjrIyI=;
        b=HlU0vUvSCRCQg3UAsSrhYdtxvs4wVcv1XOkAsyC8K90ZVEilQiLb4Y5Kn30QCi00ga
         qspdkiN2h+YPMXovg1pmcHfIzYs/8y9+J3HaekpoWZzJ5f9agv5qAyvWH1rpPxM1gy6l
         BAffl2+sXOlJnmDCHsJXmeo2o89XQNigLkBqKCqZqhNRbu3USWyFWJIlKI/MzbJtpWiF
         +q04p7C5zFFvf6zx25vz6Pl8iBjmnr28jRZmfxaq0+Bpyaw8zF1SLC/47xdGxQvBwjwu
         CuQDuXIuREnu9Er4ugnXJe+8sxYU+Rst2duF8WVU60a6tr13T1Lc/YiH+EkHLTi1/6vM
         vsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728442688; x=1729047488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9o3xjneRzpxTeUAgzBHAVPEaaxarVMtSkH9MOjrIyI=;
        b=I51QhL1Kn7ed/lUCAL8KBsKaGxL3uiIGH0j0IawVNw+SYEoraRBRQHVpV2HKXH6hud
         3fH+HrXpceEDBIR2foQ2L136QHPMiO7+mCWkL2BUShIuldNtSvGDfXCvD4tWzRV1IXKz
         G4YxIz87b23U1EaHzg/JxQVEqTkm6CoE/0nhYqXoGw6fIbbMt9+t2Sw7cTPvNf4bvTg8
         Mb0BtBEoqYptZP5y7nrbm5vTbr4S0RrptsPyAuQSVWIino0HuwruYUISn6zp/8Cnh44R
         qgiZf98TuwrIerHfUNR1/oWnxHos4FmDws2c+RDPSwzKFsb8mwlU7MrsAHDz8QJgjJZs
         Fxhw==
X-Forwarded-Encrypted: i=1; AJvYcCUSyYY0xWGlOKt4RGIkn0FgAiqZd86ARwEVD5ppOhrBBHlabD2cXDdoMCnO3nsnFb0cpMX6lUkzIhqRkXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYVTdb9TpVYTrxV3lN4ySvZRmKmslGDb1YYAK4+0FNVZimma7q
	CfZMjFH7kv38OB4fkwtxjAq68bXe3G5bNsAm6iv9JuA2r/n8SG9HkzUw6mEN/OY=
X-Google-Smtp-Source: AGHT+IGtoJvehq4riOWexwfNgKdpkMWWE0VfBGLfW/XSk+dwEt34XfmWnzObtfog0UxhNagZVDH6UQ==
X-Received: by 2002:a05:600c:1d11:b0:430:4db0:3ffd with SMTP id 5b1f17b1804b1-430d7487c03mr2369935e9.4.1728442688278;
        Tue, 08 Oct 2024 19:58:08 -0700 (PDT)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d47a4dsm6819793b3a.118.2024.10.08.19.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 19:58:07 -0700 (PDT)
Message-ID: <262f4d14-1c48-4974-8c14-c01fab7ff98a@suse.com>
Date: Wed, 9 Oct 2024 10:58:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ocfs2: adjust spinlock_t ip_lock protection scope
Content-Language: en-US
To: Joseph Qi <joseph.qi@linux.alibaba.com>, glass.su@suse.com
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240908140705.19169-1-heming.zhao@suse.com>
 <20240908140705.19169-4-heming.zhao@suse.com>
 <52e66e96-5edc-4b31-bc72-df2cf7881a9e@linux.alibaba.com>
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <52e66e96-5edc-4b31-bc72-df2cf7881a9e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 15:18, Joseph Qi wrote:
> This is a standalone cleanup, so please send in a separate thread.
> 
> Thanks,
> Joseph

No problem.

-Heming

> 
> On 9/8/24 10:07 PM, Heming Zhao wrote:
>> Some of the spinlock_t ip_lock protection scopes are incorrect and
>> should follow the usage in 'struct ocfs2_inode_info'.
>>
>> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
>> Reviewed-by: Su Yue <glass.su@suse.com>
>> ---
>>   fs/ocfs2/dlmglue.c  | 3 ++-
>>   fs/ocfs2/inode.c    | 5 +++--
>>   fs/ocfs2/resize.c   | 4 ++--
>>   fs/ocfs2/suballoc.c | 2 +-
>>   4 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
>> index da78a04d6f0b..4a5900c8dc8f 100644
>> --- a/fs/ocfs2/dlmglue.c
>> +++ b/fs/ocfs2/dlmglue.c
>> @@ -2232,6 +2232,8 @@ static int ocfs2_refresh_inode_from_lvb(struct inode *inode)
>>   	else
>>   		inode->i_blocks = ocfs2_inode_sector_count(inode);
>> ... ...

