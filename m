Return-Path: <linux-kernel+bounces-443094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 614639EE710
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8984E1886838
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59A6213E6F;
	Thu, 12 Dec 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfwCKw4o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB511714D7
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007781; cv=none; b=gHpB4n4yfbtC79Sn/OkmXTgoLkcUweaoEL4rSyjt+DCLOUs49U2Xz2N93dgmubAK+GYBqY16QiPm1M6VMNdKbEzLKMgCirYAZxgiariNlyIAG/2zY5f9IL6zMGk87xqSIBFXAiJHe9EOrLUMUeuFlKqZqciqXvIT4LBi/CMEmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007781; c=relaxed/simple;
	bh=YyEpl48QgjEe2bn12JUr/hGhuZXIyNMzlFs8mERZ05k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bje2gaRIzsyDEzUevrDSzQ/0K98kVkinH3PpKcXNLsWIkPfG+ZNETl+LQ12qtYEObc1OhJJC2FoYOs5YkDHOdMrO9BW1opJYZB6O/Ey1S1Zi4NTmUXuIT+A2IBNMGood1tR5SihjhtpOM+n3FW/E1qlgiLvCzvvT5jjD9MoZCck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfwCKw4o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734007778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itGE2V8xhlh187Ac7QymDWhnP6f5RsijIHH7cFJeYf8=;
	b=AfwCKw4oy3Y8QHBUysFatC0lFR6/Q1R6Z2JtC9GYfVi39WPQwmXe2JwNZsza0rhjPmdDrp
	6rhaYJJpZAF9i6Fun4uXs7JSwghZIyqxEJmZivljOj+XIlj3Z089Tl5DSuURtN5D4gOqcX
	WTp+amqlvCrXVOW3LTMf8xST+M2rprA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-mqag62fMM16pG8e1ZF_Rmw-1; Thu, 12 Dec 2024 07:49:35 -0500
X-MC-Unique: mqag62fMM16pG8e1ZF_Rmw-1
X-Mimecast-MFC-AGG-ID: mqag62fMM16pG8e1ZF_Rmw
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8f4a0df93so16923786d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 04:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007775; x=1734612575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itGE2V8xhlh187Ac7QymDWhnP6f5RsijIHH7cFJeYf8=;
        b=SwHzUIvW9cLLLG5kbYUxvWR6dFyRinmCXCVHV2nZzh9YuySrwLBQMxEzSFocnvAZHp
         OBT0f0gKnOHRB0TgMgkHHe+YdBwUEnypb7IN5xhREME6/fdm048SVeLgjSURtUwuoYL9
         GXwh3IKKBUisPC2YScKVeDbT2cYumjSw5RbTPYWPXSLLIp6Z+zUveIhiJUuUm8TR/OBk
         6Z8rW7eB33aloGa8AGndh3KaU/fMoU/ylyVzswAl7haVocv5EAAF1t8HSdzKXq2E4ipG
         SHxCf0LLERsotoAp15JxIRz2e90HUrz4nE8bxlMg8BeiBQSo7zzwb9Td6ilMWJ5KsIFw
         ccgA==
X-Forwarded-Encrypted: i=1; AJvYcCVUJM2shIZH7EuCMWaTZRXEz+XK1c44SvTdo/z5wbOAHyf8OpMWjq84VYc+UicJiZcSnUG5+JlCFdLi9DY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5EWsURIjfP/ffmUvaj6X0MigOK1RYUUlnIWAPA6FxvcP5XieA
	Tuk63Bn9jk8EE3juddD0t+JMJriF9z0GH3ZN54/nkkXHZA36zSh82EvbIIBG20DBpYufnKqFqDN
	PS6IWHlscyA42+37dAIdO7SqK9OVeDifBeLQXAkMMAxjbwthbtls/xpdncNa03Q==
X-Gm-Gg: ASbGncvNLt2QL7qJqsnzp2FnqVDhxqYOed6uPMccGkJsrJS2ZNlqvB+bNWsI8y0pc4H
	74cc6MVkKebC8tLfY3F+yEA/WCCfVbpVAn6NftGNysVP9ck2ZEG1TxgK9zJR6ao37ESzB8+sLZ2
	m00ipqCbX9bxCy13SPMUVYxYWrkob0xLbTDl6+SyZ41KvK10Bm0bXXgwJm+Qd4FcdGBF7KfXxAQ
	MA69JSvSYvGplLNf8gbfCQG9l3w6Qho751C00kh+PQw/NYzalvNHkDhv3/jO/GR26jX3gGC/WBP
	1OselvY=
X-Received: by 2002:a05:620a:1a03:b0:7b1:4fba:b02e with SMTP id af79cd13be357-7b6f88c85b4mr44457385a.12.1734007774830;
        Thu, 12 Dec 2024 04:49:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4Ag6lWJ9NB6/EzRTpVTPEefZcnvZ6mnIYDz3+GXqvWUtfKmm+Nj3KJ0262kDPgAuHx0vVcw==
X-Received: by 2002:a05:620a:1a03:b0:7b1:4fba:b02e with SMTP id af79cd13be357-7b6f88c85b4mr44455085a.12.1734007774551;
        Thu, 12 Dec 2024 04:49:34 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6db04175bsm327709085a.52.2024.12.12.04.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 04:49:34 -0800 (PST)
Message-ID: <c67f6f4d-2291-41c8-8a89-aa0ae8f2ecd9@redhat.com>
Date: Thu, 12 Dec 2024 13:49:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RESEND v3 2/2] net/smc: support ipv4 mapped ipv6
 addr client for smc-r v2
To: Halil Pasic <pasic@linux.ibm.com>,
 Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dust Li <dust.li@linux.alibaba.com>
References: <20241211023055.89610-1-guangguan.wang@linux.alibaba.com>
 <20241211023055.89610-3-guangguan.wang@linux.alibaba.com>
 <20241211195440.54b37a79.pasic@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241211195440.54b37a79.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/24 19:54, Halil Pasic wrote:
> On Wed, 11 Dec 2024 10:30:55 +0800
> Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
> 
>> AF_INET6 is not supported for smc-r v2 client before, even if the
>> ipv6 addr is ipv4 mapped. Thus, when using AF_INET6, smc-r connection
>> will fallback to tcp, especially for java applications running smc-r.
>> This patch support ipv4 mapped ipv6 addr client for smc-r v2. Clients
>> using real global ipv6 addr is still not supported yet.
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
>> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
>> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
>> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> 
> Sorry for the late remark, but does this need a Fixes tag? I mean
> my gut feeling is that this is a bugfix -- i.e. should have been
> working from the get go -- and not a mere enhancement. No strong
> opinions here.

FTR: my take is this is really a new feature, as the ipv6 support for
missing from the smc-r v2 introduction and sub-system maintainers
already implicitly agreed on that via RB tags.

Cheers,

/P


