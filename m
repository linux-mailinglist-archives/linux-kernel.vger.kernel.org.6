Return-Path: <linux-kernel+bounces-369446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F879A1D69
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E57E1F21759
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2C51D54DA;
	Thu, 17 Oct 2024 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="QnLwzdkP"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124061D416E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154440; cv=none; b=PUM8eKTkA5IgtqnkIstAbOX1foLih7oAc6MY4+PNrfUrLZCihSAWxwbiUuas9EX21xN/Z5dOas7FdIvBpL8qEU5MesQUZRlPqA3qSEwu99hWLhDNC4VTVeRHZF9r3mCrb25pBqC1UYs6MgZkG9mAzPqDkT0/kJpubfaDejVjdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154440; c=relaxed/simple;
	bh=DoqwkDHaw/s5msPYqtaB/PMRAXavMzh97F+WRmZF/FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIhlRNrJEKMsRL1EvoRBgWAhoElBFO9fu7HEPw6RioON6j5NuLHNXyDLJEkPpj0zR3yBCSEp0p8tF9ipzNaDZJ3QkLSeZJAsrBPU2B/fXamYA1Km0d1y1/CCR2+Z+r2hIzFkZxCAtUS6No3WCrOUYSWtdUhE6gks+Qgn2IVVW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=QnLwzdkP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so9530145e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1729154436; x=1729759236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nswFHJ27kf2VP/BAqhXCzxlHjdJWcgb2R9d96m4tGM4=;
        b=QnLwzdkPIKD3l7PlD5lJRUQA3oMZRJ8s0I3sGkYFLErJCXo9EsErbrSppyK0mAMKgt
         PDFpcwS2PsgQpHcrorfnB+KKpkd6/DOsT2smaNHpZRSmKJOkvT6sNf9vgTZYRuAcqhQH
         Htul/HXQ8Jn1D/8Ylqb2uljqTAT4n2r91NKU2+F+VMyxKT0s9mgF0XWp7gxpFfjMZ/31
         CtnVLRxTWmZEEDr3uVZGriaj9fkjfYSd3wTPuA3K6BiK/aPUvTlmjV30CaER693D6zVk
         WM143EzC3hcnwZxZo15cjCEUR+t2cCuyAQizDGNmyKYBa9D9xOfpv93TyOR6BLPJw9SY
         YwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729154436; x=1729759236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nswFHJ27kf2VP/BAqhXCzxlHjdJWcgb2R9d96m4tGM4=;
        b=Los/1VEQsjzI+6gSssJlJ4p3xGVkN/Up3FIkySzLVj4ooJ96TXPoKykodxJ4Fdp7Qr
         kNo+h2D+XLlJ/hU8cnx1Nxolb2J4FKrQqBmHNifzY2lQykZlltGBuZoQcJ1dGwrTK0/N
         J+23oPWyT+SqeD4w1bxNQtrszB6UTln1dhNtMFj2COxaSIhBOcnLAcjlSY0daAyZmHJs
         V0PXN20MCmYKzHNr8rj0AQNOrb8BIdwdsfhjFzxZgBayQLUOLRBUQ38VhkCLyzSvLx++
         3/q/SAHZb5p0LkvfpidVbA1o/+axY3Cry9o01FZYWboYq3gsIlUY14mPeEHR7oTRnpEz
         pBRg==
X-Forwarded-Encrypted: i=1; AJvYcCUxm2ZBegW8jlYb0F5HaFvFwbET1+6ZnhznqGU0ZmmHb0T7RTgf49bddKuV+KSTqPJFUslMYWH4i9UcWcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0U6Wjb2/hrvhybIWL+Fflm/5dwrbZ1+3Pfj8hWmcrn/BGW80P
	LQ7VJdGs5OQgKpYCvZocuc4RwFHXIM3bQPhezb807df97/VI/Rm0gJ7WhJtZsNs=
X-Google-Smtp-Source: AGHT+IFuF+8cHcrpXZJRb2Yp8KK1CNOhbBWDw0VehuZuC9EeoOaHTNG+4EJu7KGKavy+Z550mFTjQA==
X-Received: by 2002:a05:600c:458d:b0:431:562a:54be with SMTP id 5b1f17b1804b1-431562a55f7mr26663315e9.9.1729154436169;
        Thu, 17 Oct 2024 01:40:36 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c3bd59sm18453765e9.15.2024.10.17.01.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 01:40:35 -0700 (PDT)
Message-ID: <54164763-b635-4ff6-be88-56aeb461b494@blackwall.org>
Date: Thu, 17 Oct 2024 11:40:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 0/3] Bonding: returns detailed error about XDP
 failures
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
 Jussi Maki <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241017020638.6905-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241017020638.6905-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2024 05:06, Hangbin Liu wrote:
> Based on discussion[1], this patch set returns detailed error about XDP
> failures. And update bonding document about XDP supports.
> 
> v2: update the title in the doc (Nikolay Aleksandrov)
> 
> [1] https://lore.kernel.org/netdev/8088f2a7-3ab1-4a1e-996d-c15703da13cc@blackwall.org/
> 
> Hangbin Liu (3):
>   bonding: return detailed error when loading native XDP fails
>   bonding: use correct return value
>   Documentation: bonding: add XDP support explanation
> 
>  Documentation/networking/bonding.rst | 12 ++++++++++++
>  drivers/net/bonding/bond_main.c      |  7 +++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 

Please CC reviewers when sending new versions. I was CCed on patches 1 and 2
probably due to the tag, but wasn't on patch 3 and had to search for
the series.

Thanks,
 Nik


