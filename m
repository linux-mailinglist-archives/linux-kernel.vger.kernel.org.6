Return-Path: <linux-kernel+bounces-249367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D86092EAB9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2901C217B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACE7167272;
	Thu, 11 Jul 2024 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsC5l2Pr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE0D15ECCA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708046; cv=none; b=fXxOe/wZmqMRAmP3XkJTV8QFdzm/EVlc+n9b7y6/3hTcRBCusfhdhtnksHMRHk78+DhLMncUq6tXsIzWrEtXie4/RmR4qJAyjpGS4F0Ceyou06lhdGu25tvcFZSEwtUvjkd775SHLR9eeZpplmGTi25ej/HkYRIqN3v8hbQgbQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708046; c=relaxed/simple;
	bh=XMcLDNucyi6nSPUmygOtXlWNTj77p1UId/vpj/H+HtA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o/5x1kdjSZloD9R+RnkBXBtl8ZJsBIfhYf5DDS3WjHDojHe7cZfnJBKf8wkEJeHWXDp4liulr4XGrx+s8uMA4r89yvUt9nSfpCcmi8kAB89NzjnHK83czUzP+EEHiAJ/I2llAR5tJX7kyAS/dd5N/7eoXe2Rq3bRxKpmSnqq6VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WsC5l2Pr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720708043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmruj8JQx1mckIvgayGotRB4kpYx01J5hU6lzx2ILak=;
	b=WsC5l2Pr9sklarCVGVqyVXrbDkmiGG6iNtZ9LZ0KeQV8IGQKk/skCHFWbtTHgoRhIIvues
	JXPBAZwc3BqYtjz14xl1yu0YeH1OW78tujg53ap5lTWDu+uLGNNKq4qZbEomGEZfEBBdro
	cSFLLzU24Og/xprIRSflcgha7wWx/NU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-xfzCKadoNuGGq2e-TZVIFA-1; Thu, 11 Jul 2024 10:27:22 -0400
X-MC-Unique: xfzCKadoNuGGq2e-TZVIFA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42668699453so8209215e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720708041; x=1721312841;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmruj8JQx1mckIvgayGotRB4kpYx01J5hU6lzx2ILak=;
        b=aUu4qfuT/6zvwzdD5CRS3+djc0eVFMFAJunVZBAuyFDhiI1QV8N0BfbGQbEeuciCfq
         gj++h86VwfL3q283BA7VETpcDXcNwM7IlqDynXkUhTVNvoDDZTb0N5c5yKplltRGEF5z
         +1tY4rT09kSNZbF8tEz/e+Fv+MlQd9OYbkbvU7P+gNitR8M1nSPK/0cTJUorNIOTc6UX
         wG24p21QRevovGtW8EmZ2i2XkEE4WVUqQTsd+1jrpE3hzlQ+tNGwbJbtNaxSY7moqVTc
         G3vDv7caayb5FSGauziXlkR24YpOprI7YxTmONZNaJD3NTuhVmmkEfDIpMtPa791NuDk
         FkxQ==
X-Gm-Message-State: AOJu0YyQGYWs6T1rtpN2Q19tMDNYcMBAZwSZf9+kc16+zvarye2MFgyV
	YHVGAeBsUkc374WeS1+CpBX6i1wivaLGEyU55OK6lTVsExLsoFlyNvqmx5CSkAYFafUZ+k+djeX
	ZTS60LO/KkMpnxDJqb8DSvxWKWSXqyg/KIYI91qYH1WkAfhIVgk88pdzaNCy1ww==
X-Received: by 2002:a05:600c:2109:b0:426:58cb:8ca4 with SMTP id 5b1f17b1804b1-426708f1d36mr69105145e9.37.1720708041271;
        Thu, 11 Jul 2024 07:27:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnWMP7EKz4R63Sf6vdBXXcYvsJMKmcS8ZNh8guNp/zMBSdKX64ea5/eGfU35uCKVEDl19oUw==
X-Received: by 2002:a05:600c:2109:b0:426:58cb:8ca4 with SMTP id 5b1f17b1804b1-426708f1d36mr69104815e9.37.1720708040684;
        Thu, 11 Jul 2024 07:27:20 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d? (p200300cfd74b1cd51c4c0c09d73bc07d.dip0.t-ipconnect.de. [2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f737a63sm117471955e9.36.2024.07.11.07.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 07:27:19 -0700 (PDT)
Message-ID: <151cc130-3584-4b07-96e0-765b7efa43fe@redhat.com>
Date: Thu, 11 Jul 2024 16:27:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
From: Hanna Czenczek <hreitz@redhat.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
 Miklos Szeredi <mszeredi@redhat.com>, German Maglione
 <gmaglione@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
References: <20240709111918.31233-1-hreitz@redhat.com>
 <20240709175652.GB1040492@perftesting>
 <8ebfc48f-9a93-45ed-ba88-a4e4447d997a@redhat.com>
 <20240710184222.GA1167307@perftesting>
 <453a5eb6-204f-403a-b41d-faefdbcb8f50@redhat.com>
Content-Language: en-US
In-Reply-To: <453a5eb6-204f-403a-b41d-faefdbcb8f50@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.07.24 10:21, Hanna Czenczek wrote:
> On 10.07.24 20:42, Josef Bacik wrote:

[...]

>> So then the question is, why does it matter what virtiofsd is 
>> exposing?  I guess
>> that's the better question.  The guest shouldn't have to care if it's a
>> directory or a file right?  The mountpoint is going to be a 
>> directory, whatever
>> is backing it shouldn't matter.  Could you describe the exact thing 
>> you're
>> trying to accomplish?  Thanks,
>
> The mount point needs to be of the same mode as the root node of the 
> mounted filesystem, or it’ll be inaccessible after mounting[1].  In 
> this case, I want to export a regular file as the root node, so the 
> root node must be a regular file, too:

Sorry, I meant “[…], so the mount point must be a regular file, too”.

Hanna


