Return-Path: <linux-kernel+bounces-429360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298D89E1B0C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4538166CAF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93F31E47A6;
	Tue,  3 Dec 2024 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcFlMqJe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C2C1E048B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225622; cv=none; b=C1ThJ89mwcx9teEu2rGXWBMsyrY9L+5Y1gzLfMmpu46zrk3rdxGd3ZdHU5iqeXXQ7tY6kD4XqJPb5Vphbn4RhYhPbo4JUiX6sK6uBZLEGatmmPNe7XSrsA/TPe/zHu8bGiwUgKNaC7ZS2bUdczg2yDl3iGEEDwfKmMHzf9fHBc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225622; c=relaxed/simple;
	bh=AHmmkPHjvu7RIKywEf+EAV3LQMeU6/vP4mpQ4B4VTxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlnAvlHko4n+h/aOJBbd+kAK7oyLrNj52D5yvm6VyuV81ud05QslamlhhKHLbkz0GZzGIfRhy6AfPdwazONf6Ik+b5SpJ1gKmf8FD6tQPd+XRozHXw30lD1b3bT/tiv6VUT+dbVAn8L5XZqxx7dWBcbMkZzD6BkffuL/4kEQvVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EcFlMqJe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733225619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zREU+lwYhiaQLLeLq6O0V37r0ooXMYuGzQk3sQUa+FM=;
	b=EcFlMqJeFGV/mn0p2xgtXEmScexNjCnI91qxteotQYOSJttkmWwM0b++xyS18cbVq0zENz
	JgDMg1Qhq2y8r1fQr7aceVbZO/3y0tmg70vvVwWtRZrIvJsBOmVEYqcm3Cj5KKbV4mQ3+J
	JfkvSjN5nZ42pEs+an48nAGWjJCN1P0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-GvIppP9JMGqAhyEWOQHYKw-1; Tue, 03 Dec 2024 06:33:37 -0500
X-MC-Unique: GvIppP9JMGqAhyEWOQHYKw-1
X-Mimecast-MFC-AGG-ID: GvIppP9JMGqAhyEWOQHYKw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-381d0582ad3so4151777f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733225616; x=1733830416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zREU+lwYhiaQLLeLq6O0V37r0ooXMYuGzQk3sQUa+FM=;
        b=UB6t/GdpbahcQM9XR66T8LVKTEhSX5BuFY421f1ZM1pQD7Em01Q1wAt05rpjEGrPkh
         cSorGWQiCuc2fA1ZMCwO3Hj6Y3ULaAoZ8zS6qTfNh42fMZZWMdo5k5w0a8b702LaXof3
         YhMapXxYUHcGpMh6a41l9GfELLnyMl2XZ4U8PF5hrab7t+p50WnSuCZ1BEZtBVGURIj1
         46mHgPZKKiPpC1vI9rRIaPztqqwB/OFVYyaa6TRumXTnLSQCCss8oGxejPmRmFlYtaDl
         F1zQ1m0gxe2GIEVDA7Gu8MNmofG/AfrZSZ6eDIUkv/4Vp6i4u4FO0IsKbqk5kTPCPJ8r
         0TlA==
X-Forwarded-Encrypted: i=1; AJvYcCUTjG/b5Wkzp3rv9ZTAJ6fJH5yrfcu/rmv+Ep0T+A8C/dgPZEBzZDu3w2KF5SURwsUhQd/QTBdcXWj/9Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLi1X6PqH/wPHGj8oYCuq67qib5DV40WHo+anMWLV/tc7FRAUi
	sdGm28p1HzIdSZy3Muj/XnTmKLLbtgS4zwT3akST8vlwRrg7l97lx7LTmrt4QNwG5ImN1yiCwn6
	uIKgDCBWetOoEKcnsuoJlz9IXuDl8WThuaYas0QKzC2ZyqCB93sOWBZBs09w12Q==
X-Gm-Gg: ASbGncs8e5h4VGskS3Z26aCRnQlItMx+u0siRLDFYWBbbV6I8b5DD21yaoVqJk43Gme
	327Fn4JDA9/o+f5DSNFWfKPniXbzPf8S5nUaJEJB/qv72iCrngv9pcEm1hnJMn1JrcdKjiSPX8/
	MaQPJcwEvhLMfwyBjpoF+fbDMCJP9xEAfI1q6C9pRRv4bSgRufn88iZ/puiWG/q/2hpyYBThici
	knry56eWo++n3umtOVO37KUvztbLXfmqmX4DVVWH2lX3GRM4tU4sZxhm6x8KU9xAU56bIF4lHOq
X-Received: by 2002:a05:6000:1a86:b0:385:ef8e:a652 with SMTP id ffacd0b85a97d-385fd43c331mr2302343f8f.56.1733225616654;
        Tue, 03 Dec 2024 03:33:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhUjhzZs78Nz7CtLp5MQzYsLnMpSAwzkbqY7OFNZJSdUe3DRiH8XjGzF8cD+LMHI88SBHTyg==
X-Received: by 2002:a05:6000:1a86:b0:385:ef8e:a652 with SMTP id ffacd0b85a97d-385fd43c331mr2302316f8f.56.1733225616306;
        Tue, 03 Dec 2024 03:33:36 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385fd599b31sm1570921f8f.21.2024.12.03.03.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 03:33:35 -0800 (PST)
Message-ID: <4c426297-6215-46a4-a9bc-371fb4efe2d1@redhat.com>
Date: Tue, 3 Dec 2024 12:33:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RESEND v2] net/smc: Remove unused function
 parameter in __smc_diag_dump
To: manas18244@iiitd.ac.in, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Anup Sharma <anupnewsmail@gmail.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20241202-fix-oops-__smc_diag_dump-v2-1-119736963ba9@iiitd.ac.in>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241202-fix-oops-__smc_diag_dump-v2-1-119736963ba9@iiitd.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 11:10, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
> There is only one instance of this function being called and its passed
> with a NULL value in place of bc.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Manas <manas18244@iiitd.ac.in>

The signed-off-by tag must include your full name, see:

https://elixir.bootlin.com/linux/v6.11.8/source/Documentation/process/submitting-patches.rst#L440

Thanks,

Paolo


