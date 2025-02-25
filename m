Return-Path: <linux-kernel+bounces-531167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AB2A43D07
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626853BC48B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16850268685;
	Tue, 25 Feb 2025 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiCixUc+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798C267F61
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481488; cv=none; b=IMdhAi8CQRgKPRGVsml+hGwjzuVi/xHInbDenFTsOE8ozIauPD9/bGarIpctVgCTvbjGqraoN3YPBW/3SWUOYX7FPFc1J6+pcAenmsI6T+EGVxkJos3qiVi7J0L++b4vcH2cZQQ6NTBNDJxXF59sCg8bC2a2pZLgcIitxo1eKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481488; c=relaxed/simple;
	bh=gGk+PacptmgN7acYoXH8GXPzPxSKg6K9qKS3X8029eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZ6poZeNhwXc4Gi+GICTGDSi6Hw8iqH/6Mj7WH7dQRQJqFR3bOnyI4rmkjZ6cCaKEyrF15bYJ48TreKXAmPWCN14QpwV7rts2A/xtssTsxURZS5RgMFDfZl5Mjb7XIEPz9eO0cXQTNtFqUtEsly5JDaW56PhOCyp5SQepVw1yPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RiCixUc+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740481485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hf4Gl5VvxPitA+JhAuJ5cDzkRGuYTLJmJvFqT9v4Tag=;
	b=RiCixUc+I3tkDtjommqFeaeUi4/o3tPJ9MGD8suB5vVmecxRvXyeLcoYlzpB7OiakkS8VC
	FgHSFp5RCNcSLVwRser7IzqPiqQXbJhv2cwOTgyR018z7HibDSu6UmQFsZdeRP2cuMKCTT
	zEdPoff1dHAP18ToMIN2EDgQ+NbSFc8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-KihSEWILPVe4_NsA1rpjqQ-1; Tue, 25 Feb 2025 06:04:44 -0500
X-MC-Unique: KihSEWILPVe4_NsA1rpjqQ-1
X-Mimecast-MFC-AGG-ID: KihSEWILPVe4_NsA1rpjqQ_1740481483
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43947979ce8so23640205e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481483; x=1741086283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf4Gl5VvxPitA+JhAuJ5cDzkRGuYTLJmJvFqT9v4Tag=;
        b=pFzOvSfsTsEu6gZHCb0E8H1VQ4CrLCjho224WgZeAOUBdfuxtAcjbTsvOYCdegIsDU
         vgvEnh2p413r7PKiEl8cKRQWRXLDx9L+QsupSMpc3KLIC+vhqAKU7ceFYrupBK6N9LG8
         Kob2s2YyMYqpcEcyMbofRT/bAykg5i14jwAi1BhLkQmnejKIgu78SuHRqNLzmap329he
         Dn6XJ7tlkVzYyXj7gh5r9WZ+8PzoulTwmoZ4m0mrhCIRjSbP3Wf4Kt8mnXzQOcQepDS5
         1jC8uZj8S1BoxfbNBJ1GsK5wv3dmm0DvLmWDVsQ8dsecRhynreYusZ2YZ11GG4rwEqTT
         C+Wg==
X-Gm-Message-State: AOJu0YxJvlnIxy/URu+qrZEIkrhjW6Xs007TZVeuOdZZlUYI6llqUUL3
	OZU7rLPxXbOBUPJPRirQ1vsw6tn5oeT2qtCMm3lTHnBF6NWgWzl9klnpaTaJ5qooHDnWsnUodlE
	pzlumw4ViefTtXXlKE1NB3xXXizg9+WMVl3BXC5+4Sswn+rIBZgpA1033lrdtErSzQWH0fQ==
X-Gm-Gg: ASbGnctZyorX5x9S7V+tF8ugu8hoR6qqqaVnXW1i2juRzh6FysxnHmMorj08bJP81mh
	7QsyJv2Y1ZNiXeokc4W6tKD3IytYpq0T5GK1yOMljABw/f9ErRYfl/L4b4oNEqSU8G0SRTGJl1A
	q98w5NzrE2O3Z3J5D/twEOHNDd5G/I5lm9RyFdh6J8/i+v1XAEDHUFhV7PAFLzwLllX66su4JUg
	+qXeHir6K6PlHtBhIvpHxl9V6+aQRev24Pe+D+ka7qZCQsgZ4HBcGRKAgWIZpeijZ326yCV5K/m
	wWI7rWD9H2LgBFr3bZXnjMF+aWoGIhgXnnwBfvmmpSU=
X-Received: by 2002:a05:600c:3b8a:b0:439:942c:c1b5 with SMTP id 5b1f17b1804b1-439ae1eab68mr160890075e9.11.1740481483154;
        Tue, 25 Feb 2025 03:04:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW4QGYJdOf5T4Y3wYgYzWKvXZ19rq7KgZ0XHgM6DdrekdrQNp7EelFD973ZwHN2Wk7q7WBlA==
X-Received: by 2002:a05:600c:3b8a:b0:439:942c:c1b5 with SMTP id 5b1f17b1804b1-439ae1eab68mr160889695e9.11.1740481482789;
        Tue, 25 Feb 2025 03:04:42 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab37403cfsm12897525e9.1.2025.02.25.03.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 03:04:42 -0800 (PST)
Message-ID: <1f70600e-bb83-420f-98a6-b772781d5a3c@redhat.com>
Date: Tue, 25 Feb 2025 12:04:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: hsr: Add KUnit test for PRP
To: Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, MD Danish Anwar <danishanwar@ti.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
References: <20250221101023.91915-1-jkarrenpalo@gmail.com>
 <20250221101023.91915-2-jkarrenpalo@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250221101023.91915-2-jkarrenpalo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 11:10 AM, Jaakko Karrenpalo wrote:
> From: Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
> 
> Add unit tests for the PRP duplicate detection
> 
> Signed-off-by: Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
> Signed-off-by: Jaakko Karrenpalo <jkarrenpalo@gmail.com>

Only one of the above ;)

> ---
> Changes in v2:
> - Changed KUnit tests to compile as built-in only
> 
>  net/hsr/Kconfig                |  14 +++
>  net/hsr/Makefile               |   2 +
>  net/hsr/prp_dup_discard_test.c | 210 +++++++++++++++++++++++++++++++++
>  3 files changed, 226 insertions(+)
>  create mode 100644 net/hsr/prp_dup_discard_test.c
> 
> diff --git a/net/hsr/Kconfig b/net/hsr/Kconfig
> index 1b048c17b6c8..07fc0a768b7e 100644
> --- a/net/hsr/Kconfig
> +++ b/net/hsr/Kconfig
> @@ -38,3 +38,17 @@ config HSR
>  	  relying on this code in a safety critical system!
>  
>  	  If unsure, say N.
> +
> +config PRP_DUP_DISCARD_KUNIT_TEST
> +	bool "PRP duplicate discard KUnit tests" if !KUNIT_ALL_TESTS

IMHO kunits module are better suited to be tristate. Export the HSR
symbols as needed (when PRP_DUP_DISCARD_KUNIT_TEST=m) and add the needed
MODULE_ boilerplate

Thanks,

Paolo


