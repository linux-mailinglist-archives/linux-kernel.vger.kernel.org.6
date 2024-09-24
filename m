Return-Path: <linux-kernel+bounces-336845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B589841AC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794061F2492A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68D21547D8;
	Tue, 24 Sep 2024 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FeW7qM5H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130A14F9F7
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169048; cv=none; b=FE+LUZPSuF73CCvQdf6fYTOk+FBxPVuAsdNqyKp8y6DoboWBuN9PA9RZ5C8t2CJLh21H2+X5ypm1jDtpyaC59F/sP+R2G/OJxSXzdvZbc/kaoBoK88Iqx5rQUPiscALReq0hM13bdFNYP9/IX4Y58doSojzJcCpgoQ0A367c6cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169048; c=relaxed/simple;
	bh=3skt5Wo6AlJf+uR55V6g4I8HyirPns+bcasO32PPn40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOTik3a3yqz2pzQlhYPJypMzWPcfUiPRZL9pT4rcx/drgR9lsatPjG5UHj2toNuwi/t89oZOZtRU36H0/azxggnzMNFzGBXhtgEds9yEBFp68ChjQ5M6Xebnd01N7xpAbCQexOQSrfzzVjoRVN358D2f5PyBlYcpxsCY3N15p2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FeW7qM5H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727169045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyzdMQ5p5HtOthp5dS0YuWF++p9XPhClxn1EaM/3/5w=;
	b=FeW7qM5HinuDOqXmY6wUhKmRLY00jvQMs8/Ee4TFORMuqZmYnvfR874VROqDoFr+ptGq6c
	lWX6COjL1LiK1QXJND/MKPNmPkPDtsAny5E+8SCG+SisVc9d0qL/F0qIOs5oI2z4MpJZoe
	F8AX7RQR2u2M4qaYCt1PAg9r8FvoI7U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-JuvSMtcCMJaF5o-SSIrAMQ-1; Tue, 24 Sep 2024 05:10:44 -0400
X-MC-Unique: JuvSMtcCMJaF5o-SSIrAMQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cc4345561so35311325e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727169043; x=1727773843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nyzdMQ5p5HtOthp5dS0YuWF++p9XPhClxn1EaM/3/5w=;
        b=lLpD8z7pwGs7lYvHG+DH4bpP9QXmxp9DikQJ7N/xyCrmUOBfkixBVKh9TAJoHSfE+b
         e7nm/eGORQd8Kq/nz9qM3Pl0U+tI6McnB8MHRm3YqCS4bs4YLJc3PzTX1coMlZyOxjrM
         pbX8Xam5WAKVbvjJACWM5lqSM3UrWe/OoVBmw5rKj/mTJu6+n7ZNh+xpVteOpluFfsOJ
         LU05wqpek0elSXfjgLw0wvFTqoKng3NeZHbeJ0qTAkGeDd/7ikjIdma9NO4mIR+93Ral
         qyMo0JyhmkZtoXd2X/kPJOqX3nh8k6naBngfO/Dxpv9KMpagkSfu7zOlRVWE9oZhStOg
         vs5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2h70ai896gZyBGjjrOo8hUFG6sGe1Bocm8fvFusGwqdOZVD9WkWdyTEjK0PuaFFceN1/fP/C3jZwAviU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIF74CQMVudKqYtyXEqmBXLams+yq64lpEv8KF3iJ0gDlNRPKP
	eH3p4D9I1ZBgR/9JCnubVUsj5jTX28zH1Jk29ivJLKuYiSECl94BkuD6nD9cpkht9+e0/R7XJSm
	n5+ScB+zKw5F7WZnZbofl6Mt63cPGribBRcq9VNrVt3Ws42SqkoXP756PCwDFb42LHfaUrw==
X-Received: by 2002:adf:f80d:0:b0:378:80c8:57a with SMTP id ffacd0b85a97d-37a43129157mr7706451f8f.9.1727169043034;
        Tue, 24 Sep 2024 02:10:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUL1mDQeXhZbeMYeSJp2U+mVGZzNG7TEFM3wIXZdZCO/2SNvwSeh/arDlGGkBK+BcJtnLmMA==
X-Received: by 2002:adf:f80d:0:b0:378:80c8:57a with SMTP id ffacd0b85a97d-37a43129157mr7706437f8f.9.1727169042686;
        Tue, 24 Sep 2024 02:10:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2c1acasm1023447f8f.32.2024.09.24.02.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:10:42 -0700 (PDT)
Message-ID: <ba1883f3-7367-47af-a81d-3a59b6d12fea@redhat.com>
Date: Tue, 24 Sep 2024 11:10:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ncsi: Cancel the ncsi work before freeing the
 associated structure
To: Eddie James <eajames@linux.ibm.com>, sam@mendozajonas.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 gwshan@linux.vnet.ibm.com, joel@jms.id.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240917191255.1436553-1-eajames@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240917191255.1436553-1-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/24 21:12, Eddie James wrote:
> The work function can run after the ncsi device is freed, resulting
> in use-after-free bugs or kernel panic.
> 
> Fixes: 2d283bdd079c ("net/ncsi: Resource management")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>   net/ncsi/ncsi-manage.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 5ecf611c8820..3eda24eac668 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -1954,6 +1954,8 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>   	list_del_rcu(&ndp->node);
>   	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
>   
> +	cancel_work_sync(&ndp->work);

Possibly disable_work_sync(), just to be on the safe side?

Thanks,

Paolo


