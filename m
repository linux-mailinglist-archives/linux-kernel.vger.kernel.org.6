Return-Path: <linux-kernel+bounces-518845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DECA3954D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7683A960D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7E422D7B1;
	Tue, 18 Feb 2025 08:19:56 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E766206F15
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866795; cv=none; b=ORk2Yfc+BIoVOV8VfbW4YlcvhoOQcNCFs/cL2mGTMW5zuF+TayRx4E3XoJWTKpDoWE4CcU+2LDHkyJDhrnm52EtcDy6x6M+MO/y31i9m4LhIuJmdtpwbxFL4D8qakY3AGWxGJ1RbCjgwt2O1/WrjIN1xN0Lv6T6Rt76CMRXQzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866795; c=relaxed/simple;
	bh=LYHGiA6znin6dM8PhXDObFZL1R+f+59JcnUE4XOI++4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEtrOqd3NsORkcNjcFmFn2xq2l63XLVI8ZGysfN+4Hc0ucN/aaCVrbw6vaCp7ko6G66Opo3lYarWWmVlZYUiLvxr8SpCzV+ZOaOOljeddXVAJyezrxG4pXFz/P0j4vXqLsH4nk7DZkoxDWPqyKzHEELVJz4CVKKKgMfWjmM0Fks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so53676595e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739866792; x=1740471592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkZTkbZnkokRK0M1d5m0Kxks/rddfMlEtI55Hvmyh70=;
        b=sckTmjXiFQwfjXCCWvlm8QsnntiFykUJRGVsnABN56G7v96rtJ8MJb9UGqDnHQL5ed
         mF8JrULNqBR1pCvHPo8LhoplxGL8jwIjNfBzRMJlMtVpdjqsZdlxrZ4rWp8H3f1jwlgA
         hMgblFPigRZSU4oqNQbUKSm8VCztzBlq1ijiCmySQoDZIcd8gPFCLC54vea9y1xc9oWs
         IosPFCmHMRz7k5DMxeGY5dbvd7gDSCwzKI+h1nu4oxs3O4kzfZ3XENk3T2IaDz+f8Ik0
         gKgSU0Qx36T6g3Mg6Na5VC+qvL+WrE9cfRcp2t7vkTvr7gcliPzp1d6H6yIytxWEGN/5
         87+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVipp/KJmvRvt27b6CK0S7AQvlFg5tIzr0CpaE8Sn2RLYl5p1mBHYYJxgedWWWxTTNJ+O5Yc+pa3Jrj6AE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwh8NkoMvgHXwf/j8BPdtZ/B/pr+NiOK37Bfp/X3sxKbjLDn8Z
	sS+1mO1rSHlrqZFyEF0NvqwEpGs6DXZTurzEKaSdI5XNxM/ODFEr
X-Gm-Gg: ASbGncsungfFgAih1KPMiQvSnIUn5UR/APNcLmm9WE6i2QrG5BMDBNZgPo1fMX5vyLa
	HeMlGDuH+x6iimCR2K7XqykPLD2W9OiCDPLPyS5f12VAry7wS1FqZCLVypkgWUJWiG6VmIUq5hS
	Uk7nl9texo9faVeksudNi5dh+PtJPEPFT0616Mi9D9ZgBAqQPSRHxfBkjgFyWBi57zr4aFjVJrc
	MGu61kJqT8J1ZTCrrJdtCMZAzu/iWI01VwQL6fLlLqxfo7ZxTdeANz+jcPcdnYLRKMs5k7lBYNg
	Mk3bTNi8ioBE2KrCesapvosnK8kP060Uqonj4rzZJrXVjNqZBpeWlRSt+g==
X-Google-Smtp-Source: AGHT+IGpzKroGCXPMYzXV24w2xGqnCA8wj2NxLDnN+GaP245oMnjUtCkdXhtzKeeylr9e6dtP3b4yQ==
X-Received: by 2002:a05:600c:1e11:b0:439:86fb:7326 with SMTP id 5b1f17b1804b1-43986fb7498mr46336425e9.22.1739866792138;
        Tue, 18 Feb 2025 00:19:52 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7f3sm177488915e9.29.2025.02.18.00.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:19:51 -0800 (PST)
Message-ID: <ccc171d1-8de3-4632-9483-71fd5ea63d46@grimberg.me>
Date: Tue, 18 Feb 2025 10:19:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de
Cc: bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <ea0e6445-9770-4df9-91bd-80f44cd0388e@grimberg.me>
 <ea9537d5-721a-4b37-84d1-df797646fce2@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ea9537d5-721a-4b37-84d1-df797646fce2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 17/02/2025 18:14, John Meneghini wrote:
>
> On 2/17/25 3:08 AM, Sagi Grimberg wrote:
>>>
>>> We plan to ship this patch with RHEL-10. So it would be really good 
>>> if we could get this
>>> change accepted and merged upstream, perhaps into v6.15.
>>
>> Hey John,
>>
>> This looks fine to me, I'm assuming this was also tested with 
>> CONFIG_NVME_MULTIPATH=n ?
>
> Yes, everything has been tested with CONFIG_NVME_MULTIPATH both 
> enabled (Y) and disabled (N).
>
> As we discussed in the previous email thread[1] there is an anomaly 
> seen when you build a kernel with CONFIG_NVME_MULTIPATH=n.
> and the host discovers a multipath capable nvme device (CMIC/NMIC=1). 
> You will see exactly the same thing that you do with
> CONFIG_NVME_MULTIPATH=y when the nvme_core.multipath parameter is N. 
> You see a separate /dev/nvmeNN entry for
> every namespace/controller path.
>
> We can send send a separate patch to address that problem, but this 
> patch, which simply removes the nvme_core.multipath parameter
> has beeen fully tested and is ready to go.

I think that we want to print a warning in this case though. Can you 
resubmit with logging a warning in this case?

