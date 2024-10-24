Return-Path: <linux-kernel+bounces-380165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03359AE9B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F231C22DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C2C1E7C21;
	Thu, 24 Oct 2024 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjpmjCiK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF154738
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782268; cv=none; b=nGgjunc2usqwGl4eZ8YehmUTQRMK/HxRLmdY/4zvV3Rfcx2ft74H1+Jkj6fbSYd3Dqd/u34dWUThlYHbc6Jc9JwzL05il7DPHuw4CoihEV5BMq7ZY5AGWpb8QjXFyWwgLn9YdLR7RzGPwEX49DSwwl3oGew6gLG4RvRydt0AnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782268; c=relaxed/simple;
	bh=gVY0G67miwqx2BkcKLWPrJDyOIUFUKhCFj7HLBOnq8M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Els78uo9ZnnAA4XNd+KntG9FuMV7JEv9Iz85Gr0x6p7qmbfD389u4NgCBJIarIhzTjdSOz/k3gbp8WaOqahDT4fLz8bwfRFlBOnfUZPg8q8D7jz/SjVZa+pQLOGKQdGcBPKf+0c0IG3ZC3+UuY0kMZYMKHPk2OthyfsswFOB/iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjpmjCiK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729782265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVY0G67miwqx2BkcKLWPrJDyOIUFUKhCFj7HLBOnq8M=;
	b=JjpmjCiKiigpdqG1oy0CkqgjCRdq1qMJ3/VJl/NAQqZaDs0qdxTfKO+lzVrWSrGTTyxVb5
	3r+FiRnXNDcC6UIEAN1A19dMeT1NWFlTBDY3TddCuviQpIYMKLIduG6vosVCUFwr/sZqoQ
	G2gdGmZM7RBRKrYCEpWs/w/d+Yix3+I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-FCfBEKBJM3i6b523lFUwpA-1; Thu, 24 Oct 2024 11:04:23 -0400
X-MC-Unique: FCfBEKBJM3i6b523lFUwpA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43151e4ef43so7326885e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729782262; x=1730387062;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVY0G67miwqx2BkcKLWPrJDyOIUFUKhCFj7HLBOnq8M=;
        b=Ym/xjLmOo+wTYGw2EYIL1RFvnX+2Zkb88Y/ug6MO+qBbElTEU171p7PuK49gH0LEyO
         9QT5DyH0FxDeT3UMj9LB43E+f6xU1nqABglQ/CdERCyO8ZzvNXbqMU0PecTMUD7Ou9PL
         tem8OZCT5wA31K5RampSfoJ5TmxvkNmNOxR+JWkr1F4vOmeEYWFdtEquw9dpWwHVs7ZO
         vjIyaUMudCLucNGWAFJx8pymZ93ybC3jX97QJGBC9yZiMoYwwSjiBF6APVZUY/m+V2l1
         hytD2OUqsI0zwKoPYlnkZwTHmaoQTeKwZeN0F31CyJZjTCCs/aALqkWCP2Y0phx0U1pB
         fcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfLGD7ub9aqsggZcPfiJAVJvx/KcKMBW6JceuXFtcUOr9flT0Tc2z+Ae+JxZp9io8/5SO2Gx1ncwth4As=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzh5F54J7GkhjIh+HVP26iEWQnmerZYezFvFG/Jefbk8YdiQKT
	LcZF8eRAdBkfmh7Mlz6gbX9orUaCwxVDVcpGCKE52/ib3XXsV/9MeCZw50xS1+ZgoxuF0jw9UAQ
	+Xi2cLfD8G2KXrUvZzti5u8gFE2GAdT2OBBOM6bDdtH6q8q6sZRvD5325EXbOnQ==
X-Received: by 2002:a05:600c:1e04:b0:431:5c17:d575 with SMTP id 5b1f17b1804b1-4318413eaf7mr49391095e9.11.1729782262400;
        Thu, 24 Oct 2024 08:04:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEup5emfqJAziewFEMpqqZpqld4FxCYvCJsegqkMVL+TKP38UhuZ4nvxCjoDdnnu+B2YT3hww==
X-Received: by 2002:a05:600c:1e04:b0:431:5c17:d575 with SMTP id 5b1f17b1804b1-4318413eaf7mr49390475e9.11.1729782261878;
        Thu, 24 Oct 2024 08:04:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4317dde7b70sm72342435e9.1.2024.10.24.08.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 08:04:20 -0700 (PDT)
Message-ID: <d797a175-2e75-472d-ad53-9904bcce7fe7@redhat.com>
Date: Thu, 24 Oct 2024 17:04:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 3/3] ipv4/udp: Add 4-tuple hash for connected
 socket
From: Paolo Abeni <pabeni@redhat.com>
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241018114535.35712-1-lulie@linux.alibaba.com>
 <20241018114535.35712-4-lulie@linux.alibaba.com>
 <b232a642-2f0d-4bac-9bcf-50d653ea875d@redhat.com>
Content-Language: en-US
In-Reply-To: <b232a642-2f0d-4bac-9bcf-50d653ea875d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/24 17:01, Paolo Abeni wrote:
> The udp4_rehash4() call above is in atomic context and could end-up
> calling synchronize_rcu() which is a blocking function. You must avoid that.

I almost forgot: please include in this commit message or in the cover
letter, the performance figures for unconnected sockets before and after
this series and for a stress test with a lot of connected sockets,
before and after this series.

Thanks,

Paolo


