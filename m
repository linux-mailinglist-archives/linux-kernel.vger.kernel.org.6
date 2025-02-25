Return-Path: <linux-kernel+bounces-532640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 247EAA45027
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5DE188A1EC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F632153C2;
	Tue, 25 Feb 2025 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMTGW0On"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A96E2135B6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522582; cv=none; b=F2QwR5b+0EG1IfgX8lmM63xgRUSvfODcjpTE0khCE6LXvT+R9o7LOJodKze4ImmWLU1isFxal6TVEFtQ+l/RLIl+9c/XsHVKoxu+DdCPQCv22fBMTo4QPSV7WHjXEp5JI5zkAakCPml+YfgbXnpIzPsmUoXbY7rZXq6Fy2SSHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522582; c=relaxed/simple;
	bh=2n42vMVBrkBuXEXndwN/e+HY6V8DnTMtF2qIFoV2j0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsVB7GDFzcWS5puuBCNnRnjOKf0xy1MGVhptEhWdXGuG6dkfFDyUC69jpRX+Bv8YRwgIZyG0Re5Wi4pegaPEm0Tp+saBerfHh5VrKwdMt8gt44Q16SPP/BEoFvaFr4K6Qjg6bGp7XQhGDNH4mcXFYg8C+d63Y0g1yGzPv/Jtpxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMTGW0On; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740522580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ycavXvzUd2OipGDnToYGwHS9CBgJhI/fNGgrXyEu+g=;
	b=GMTGW0On/6DVtb7HxOqLIZ4Ge1LO9cMvaUF7Mq2L69uz30KljlftGQ+w1dp9fo1ld3/kLP
	8ynoGMGvCXjMy6bogaWFfh2o8l62DJdBYkBhuHpxB1HcOm5eofn8dYUgjyHS3KdHJaCCJK
	PdqyLARy7W/zTmj2xj0n/ij79JlPGg0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-rwomGSoYN4WDzTzkaK8AAQ-1; Tue, 25 Feb 2025 17:29:38 -0500
X-MC-Unique: rwomGSoYN4WDzTzkaK8AAQ-1
X-Mimecast-MFC-AGG-ID: rwomGSoYN4WDzTzkaK8AAQ_1740522578
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220d8aa893dso96304165ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522577; x=1741127377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ycavXvzUd2OipGDnToYGwHS9CBgJhI/fNGgrXyEu+g=;
        b=wyCLDCQSKcswjMfHlURDhORWbhdXvaEc8KRB1bnjyNH4X1raCw3mR8gAxq7Kr1Jr8p
         Ttmz0Wc2h7smgBcd1oLXH9o+ip5X7W9gL2kiAYkq1EcxvKN2WSy1d42+6jkr8e1ns45O
         EAv51WAlFhdElaC3/1Fd8zeMkUc8UAqOtY9+3bvog5kqSPbtDoS6UmbQbo8a7B86BBXP
         aer6096amke0beSn0aLM3r4vOlt6iRxGLmAsP3+xun4YqmjVx5UujKDlfSxqS1KshJhE
         idZeXpswTIpEEvuiy9+6xkwRyT1eKbxNpgB1deG5c5Ev+ZkfNthqdGx57RsDZXDs5BeA
         U+fg==
X-Forwarded-Encrypted: i=1; AJvYcCUsRA90xdP28F5fBkyBvMNDE8E8e94lzFMNkm3m8JqkAfZGGCMT0457am/io4u+WLFihQa1/Nd32DZoA7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjL2beu1xvNh8rXaVDW3SXeuTY8lLKWbX466vZbwycMWTTksbM
	ZqETHPhLLMwMzCfVL3q+Il0Jxx3xzBCW4M96R7hzHr+VWPHBgh1HNJnOUj1hKttk8JR2WLQM3qA
	ZrQ1jrewuMUxZeMV4NyBY2+wHj1J67iLI1PZsF4yixGIiTt/ShP9Cfndk1cnFPALI9VOnKg==
X-Gm-Gg: ASbGncvJxI0ukKffb6BJ5yYnfPLSZ/nI8UhJIzUo+8IjjNmyoFVtpp2KZX0/rkSpqHn
	UJAtR9vPtoj/4uR5cHbBCDJAo6NBQvduibuPNdC6/zTHZkRqeiaszpwuBsU0S/hdX8m6KblkTfC
	4KuOaMKXW0HpA9NiHGPcxt5etgTVpAmFuS9DFtNkUTyxIgtq4c2UnbDua2p2A/7E6ezmAgvCXm9
	cGoz4bVgu3Rk/05ApN9gW3Hlg9Zg97QncUbNsHrILhIzI4xAof3LuIVP+/H0dYYLXZQ8fgeKjHc
	3Jf+GfY7DZaqDg8DqoLBLQLr5VVVsAjwPUy9nLMkSghNF+qMN5K0WAZjrF2NReS5K6dlHshDwMn
	V
X-Received: by 2002:a17:903:18b:b0:21f:61a9:be7d with SMTP id d9443c01a7336-22307e78b75mr78678445ad.49.1740522577689;
        Tue, 25 Feb 2025 14:29:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzHdYJjfaEjzTI8TNe1ZJJA53HlV9GGE5qN3I8XA0Ony8wab90mV2RJz6tEymjqoSiVERhFQ==
X-Received: by 2002:a17:903:18b:b0:21f:61a9:be7d with SMTP id d9443c01a7336-22307e78b75mr78678205ad.49.1740522577381;
        Tue, 25 Feb 2025 14:29:37 -0800 (PST)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-16-70-52-24-57.dsl.bell.ca. [70.52.24.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a09301bsm19476025ad.136.2025.02.25.14.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 14:29:37 -0800 (PST)
Message-ID: <7a811e0d-bb9a-4f99-8437-e974db5d3210@redhat.com>
Date: Tue, 25 Feb 2025 17:29:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm: page_ext: make lookup_page_ext() public
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1740434344.git.luizcap@redhat.com>
 <fb46436ec9ef892b6f40b9e48d40237b9855ac16.1740434344.git.luizcap@redhat.com>
 <6b9f6679-8655-44cb-8a0a-16d4032a89bc@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <6b9f6679-8655-44cb-8a0a-16d4032a89bc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-25 11:38, David Hildenbrand wrote:
> On 24.02.25 22:59, Luiz Capitulino wrote:
>> The next commit will use it.
> 
> This should likely be squashed into the next patch, where people also have the context why this is required.

Would you mind if I only squash it if I'm required to send v3?


