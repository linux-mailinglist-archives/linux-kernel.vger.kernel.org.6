Return-Path: <linux-kernel+bounces-333215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D9097C572
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149E1B22915
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0324B1991AF;
	Thu, 19 Sep 2024 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCfn/ojd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBCA1990B2
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732674; cv=none; b=u1CQQ6VjFXE4s/x3qq70vKK7Fw4X1CGX4AHr/DdOghxanAadAczXqIAOMi3tVTF34G5T1Zd3rCy4Vtd/3Wfjwp59EbMWMGaN8SUCKchrbUtDtFgYsP4WRGVJ1xBRNCxChQpdLQlsEvfe9OmuIiNhgHb3ONxYCNY8ovexYH684VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732674; c=relaxed/simple;
	bh=WjTR5Fl9rB5SyxIdjvbDVCUkIESWrZgHawZRIoKkHas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJnCT3KgKarwRQ/99blYke56PTh2OcvJDm0awVWMnQjow12JND9QApQgacyPIcSopDjBWUiuUjfKdgEFlSQxJaLodp2T2jZKD8ervFsouYaZJXuRxFdx0u25wuzqL6MZdGG5xcA8WdHLeekKga3IUMrINjWm0d+PBHYnW299zDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCfn/ojd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726732671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BveYqjoEFbQN7A9EhNP5LD7TmPQnn8rjTb0WXfJDJ+s=;
	b=KCfn/ojdID7go+XpA+dvg6U0R5/F8kGsvn6aflxgW2+Y+apVtSG41YlnmhYSufOq4/U0z5
	Re7mfgGlDorbeIjn1p9yKz9gmpGNzQ7B8J6g1oYxFK+I3iKj8AlgUkRPlbpxU0OYvUZ/vQ
	VpdPsRI3e8P3RMGB6HZfvkeuwFbnMoA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-7P0RzXVtOsqZWsaky5ZO3g-1; Thu, 19 Sep 2024 03:57:50 -0400
X-MC-Unique: 7P0RzXVtOsqZWsaky5ZO3g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374ba33b2d2so185284f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 00:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726732668; x=1727337468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BveYqjoEFbQN7A9EhNP5LD7TmPQnn8rjTb0WXfJDJ+s=;
        b=dJ+oKpLgHoy8fxdIx24Mak0v/cmPHaZO94cvUYvyef6NAa8UnueB8nBEToXIKIR7/R
         PiP6a9IbZuXvkmu4gMudpHzytfr3FM8M2/RsCUxnoimp6sPPLBgjdUFz0zIUGrYcDIec
         S6DSz40mSm41evQC9r6q2nPsNaDemB7+2hty9io59ItiTOxp+yNeGAVhpwwmJaap72R/
         90S41t/7saN0Jjzd3yR9Jkdv4KgLLeGpnCrTh0sUTsNW7F0P4mMgwqHNWXKXYsstZqo5
         ELXEplhT3DNFd4WNioL6ui7Db0w8PlbueUHVMHczeHCtcdMcXx+4OUQg3HKXB+MVRBUF
         t/nA==
X-Forwarded-Encrypted: i=1; AJvYcCWWwtZ5wuJ4EqdIjss3viykeogzGNnDQY8CHF/3cxvWDYW9X/dErpWCUWUV6E6K7ZsEWoEnaDkVRz3Dr2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzyBZgKT8Upoi96dGLlygQs7eMYee37CIgL5TZaEt0OyuJIYVU
	zPM6zZyQtm/kwIjoLuDUBVc3IzSRCG6gaLzO6/V78brslPdO+sjRvnCA7EGFRBYf38qqz+uMBWm
	Agx93dFQv73FT+zY9QsEaGVS2/MxU/lS3mVJg6CIxx+/fHSwac4+xRGRZJt06d63hEuvvmAdv6N
	8=
X-Received: by 2002:a05:6000:18c2:b0:374:ce15:998c with SMTP id ffacd0b85a97d-378c2d1345dmr12838606f8f.30.1726732668060;
        Thu, 19 Sep 2024 00:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjcuNBkqYHoctjpvy9L9izSMqtg504D/BPyWJE0SJlP13gf5PTW3zCH/yMLyXpqgIpClOBOg==
X-Received: by 2002:a05:6000:18c2:b0:374:ce15:998c with SMTP id ffacd0b85a97d-378c2d1345dmr12838590f8f.30.1726732667646;
        Thu, 19 Sep 2024 00:57:47 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f0529sm14653556f8f.6.2024.09.19.00.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 00:57:47 -0700 (PDT)
Message-ID: <bbeb8c77-1772-45a2-8626-a4e064ab7c54@redhat.com>
Date: Thu, 19 Sep 2024 09:57:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: ioam: add tunsrc support
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240907164245.89627-1-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240907164245.89627-1-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/24 18:42, Justin Iurman wrote:
> TL;DR This patch comes from a discussion we had with Jakub and Paolo.
> 
> This patch updates the IOAM selftests to support the new "tunsrc"
> feature of IOAM. As a consequence, some changes were required. For
> example, the IPv6 header must be accessed to check some fields (i.e.,
> the source address for the "tunsrc" feature), which is not possible
> AFAIK with IPv6 raw sockets. The latter is currently used with
> IPV6_RECVHOPOPTS and was introduced by commit 187bbb6968af ("selftests:
> ioam: refactoring to align with the fix") to fix an issue. But, we
> really need packet sockets actually... which is one of the changes in
> this patch (see the description of the topology at the top of ioam6.sh
> for explanations). Another change is that all IPv6 addresses used in the
> topology are now based on the documentation prefix (2001:db8::/32).
> Also, the tests have been improved and there are now many more of them.
> Overall, the script is more robust.
> 
> The diff is kind of a mess. Since it's "just" a selftests patch, I
> didn't bother having a series of two patches (one to remove it, one to
> add the new one back). Let me know if you think it's necessary for
> readability.
> 
> Note: this patch needs this [1] iproute2-next patch to be merged
> (waiting for David to do so, should be done soon).
> 
>    [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=884653
> 
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>

Unfortunatelly we was unable to process this patch before the merge 
window and net-next is currently closed. You will need to repost it is ~2w.

Strictly speaking about the patch contents, any chance you could 
refactor the change in a more 'incremental' way?
The current format is very hard to review, and even self-tests patches 
deserve some love ;)

Thanks,

Paolo


