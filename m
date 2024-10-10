Return-Path: <linux-kernel+bounces-358541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF3E998091
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73C21F2867C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C621E7C24;
	Thu, 10 Oct 2024 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XN+e3ePy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB791E7C05
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549041; cv=none; b=NfGGPXQMSaA6D/mIvx8zNUYsQdBrPnowyfDKJwq8oRT2Fh6CtxSQ2clQAO8V710Ettzoe4K2HOHdDl7HsUzshj0ygZQtQOlLESvcM69J/urrAl0dSU+Xi21jGpPvdmBrDE9JnKGRmOmiXL+GaJRdg0Ts8khzSkRInJ6LVEgaWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549041; c=relaxed/simple;
	bh=81ZjBvLUwY6eeqLyJYGD5q162fu/lz7B7IRHnVgSMbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZXXgBzHCH8LaIf02z54c/0A5a0J939CJh1iai3lAwxDA6OIQTzjy8botE3ZZ8Q+iTj/WU2wIBqnBlCXP7U293WjLr4X4AqSs4rYowX3n9h6BWzIRpLXklpFkl3K8XxSEpDhiRca0rQaLiCzyaQybqLZzh6WEFKwT2dB+hcNDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XN+e3ePy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728549039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNbzRipITp2ZX+tjoP83fC53vO8P93j48ZH+sfRT9Js=;
	b=XN+e3ePyUrHxtrMze/DsF1hrVZQ2e1KbuVCd/6xHlH3LUAOTkzYbJt2yNFSYY6DffV7zrv
	ehbD6VhDx1HC5BjIl5pWZsoaI4OMU/62IqWYUtlzdMb7cFEW+XASS4xSw+/lqH/cpFOd1n
	tRmYkkYpf4aShXOTF/tjunu4qnlWjkk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-fffd1RwZNfCUUdqTskpjFw-1; Thu, 10 Oct 2024 04:30:36 -0400
X-MC-Unique: fffd1RwZNfCUUdqTskpjFw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-431159f2864so3151705e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728549035; x=1729153835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNbzRipITp2ZX+tjoP83fC53vO8P93j48ZH+sfRT9Js=;
        b=tcWLuGzhSTfDmvGRIe2Xcg54qbXYhkuDyFfw/9bKCOXAgkUqW0YFLIGlQnLi6qa37r
         AZuu1+lty+NswbtjOIabh3xYtpXLQuP5lLhIw0q4ULZf/Xqo+7IoV+tFBFg7t+yumbSx
         /FQr9h5HMnZzufJXba0sTpnBcMRYQdxX04EwEaT+az8CMGaQxgx/lJlst3kfbFvFbEo4
         CCHNliBC4+oM/VFNv25Exku+pIFuG8vngKZzP7lyD/hTKB58frCswpdOMHLbYD95qInb
         1AJzfsSg0+IbO2i7Im9Q2h8NlqwEnfaZ0EE60bNwi85H+TXrHapSmxGuj0It97erh8jQ
         2HoA==
X-Forwarded-Encrypted: i=1; AJvYcCWqH7i+oH5lx0oWnR0t3Macml04ZjnFv5IH0bwOYJgqOEEG+bkS2QPU840C/C7g9WbaWliOStjPOjW/ozY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy7Q5l3EuAJXS0eIujpuwsjwV4dTJhz9rCa+VGHa/zR8FqF0LK
	xkjMYNtyGWK7tnOf8wZIy4MfxVRZ5ecCsX7PlvuBGBlI70GnJ+Sed8TH1sUOueV9heuCwbmEuyp
	AiILJyf8jDFXaeld24dg5Klo73kJhzV4h/Ya/T1y1lym0h+CX8wL2GKp7gV2QVA==
X-Received: by 2002:a05:600c:19d4:b0:430:54a4:5b03 with SMTP id 5b1f17b1804b1-430ccf089fcmr38015315e9.6.1728549034891;
        Thu, 10 Oct 2024 01:30:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeQK3ESd3VwoQDVpFI6ih7FY4v1pI7Ubmg/YooSwZcbyZPfJMPk+upbulnUHJyo4gp+F3rfw==
X-Received: by 2002:a05:600c:19d4:b0:430:54a4:5b03 with SMTP id 5b1f17b1804b1-430ccf089fcmr38015025e9.6.1728549034560;
        Thu, 10 Oct 2024 01:30:34 -0700 (PDT)
Received: from [192.168.88.248] (146-241-27-157.dyn.eolo.it. [146.241.27.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf51c69sm41070265e9.28.2024.10.10.01.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 01:30:34 -0700 (PDT)
Message-ID: <3c2ad895-3546-4269-8e6d-6f187035f4b5@redhat.com>
Date: Thu, 10 Oct 2024 10:30:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/7] net: ip: add drop reasons to input route
To: Menglong Dong <menglong8.dong@gmail.com>, edumazet@google.com,
 kuba@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dongml2@chinatelecom.cn, bigeasy@linutronix.de,
 toke@redhat.com, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241007074702.249543-1-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241007074702.249543-1-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 09:46, Menglong Dong wrote:
> In this series, we mainly add some skb drop reasons to the input path of
> ip routing.
> 
> The errno from fib_validate_source() is -EINVAL or -EXDEV, and -EXDEV is
> used in ip_rcv_finish_core() to increase the LINUX_MIB_IPRPFILTER. For
> this case, we can check it by
> "drop_reason == SKB_DROP_REASON_IP_RPFILTER" instead. Therefore, we can
> make fib_validate_source() return -reason.
> 
> Meanwhile, we make the following functions return drop reasons too:
> 
>    ip_route_input_mc()
>    ip_mc_validate_source()
>    ip_route_input_slow()
>    ip_route_input_rcu()
>    ip_route_input_noref()
>    ip_route_input()

A few other functions are excluded, so that the ip input path coverage 
is not completed - i.e. ip_route_use_hint(), is that intentional?

In any case does not apply cleanly anymore.

Please answer to the above question and question on patch 1 before 
submitting a new revision. At very least the new revision should include 
a comment explaining the reasoning for the current choice.

Please, include in each patch the detailed changelog after the '---' 
separator.

Thanks,

Paolo


