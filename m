Return-Path: <linux-kernel+bounces-396332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 782E19BCBC5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3021C1F216F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251B21D47C0;
	Tue,  5 Nov 2024 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwISbJSW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B981D4612
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805955; cv=none; b=REr+xUPXJ6/na50zqcR5G3ay8bUVF7xxXSG070qV/4+EYiCypYVVSh5XH3sK5qOZes5d9k2/mPZcwFevvpp6ngIrPYqmkxcxRnSdIEtgUgPzjvJLBVzzQml2CiVUC8/PcWo5KaSFqAHU/IogaL/JM3J3dNqbiShAeKUlGghHgEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805955; c=relaxed/simple;
	bh=8AFVGRwtaJeSF+KSoKYzsx4Byj0svgLauYfW+TOaTno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhq5UEJ5FLdmH2B8yzAt7OP1GWaGe7NFcSimpIMoqY0WTGeqWh2LYzJ3+Ws+JDtTK5D4MACB4IUyhwYPRIBDMortfohA+AjE/8N5h+n3frGiDs3F38U/OOGUSSEd6QimzIgxCM0DhC8dA1AsDFg1UBAK385wtJeXrgdkKvxKERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LwISbJSW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730805953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AsybYOao8j0qbOJ+5wLogVpuC2sFzLXUAO410jIN/GU=;
	b=LwISbJSWt4++gRUA8KOJfm53IMVcvuzSoNqdRMiARnWWeEj3U6prHgwuc5iTjJ88iiLJBL
	+Q5yl6x7UlQ5Hm0z7gJKFhDkBFBlXWlTj7VkuNCG6BV6yY7RC8D+8CHymkmm3vvQz8Ldmm
	/fldtCyVD/OwQINff4nc0hRs7uLlir0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-eLhjL_r0MvuHER-q2e_ljA-1; Tue, 05 Nov 2024 06:25:52 -0500
X-MC-Unique: eLhjL_r0MvuHER-q2e_ljA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-381d07c377cso2127079f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805950; x=1731410750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsybYOao8j0qbOJ+5wLogVpuC2sFzLXUAO410jIN/GU=;
        b=QViufOPUt8U3/4cXyPF4mIn62RTY1rZo4mnz44bKAQUGL6uyrKpd0+D2UbikJYIIQa
         0pClSUPmBjNUtuTTqCdXzNtFVM9XDsNZsDtTjPMC6LQcChJfNliwjKfA4tI/2oeM2Gm5
         VQVBEDcGICoEuBZd8eqBErTIqaWCCmbJEAGARLTFLPQDfgsI8wyQCvvGNsPKKr4zZ2u9
         UbW9WfvVZGrSlNuf9iKfPkdij4Enpn/saqh6IoWLxMJCz1HXR2nvI7dHFkeSQH/Q6fuO
         iumA6jUN+n5NIEPv1oHl99rs705YYh/2gRFsqmZKt+3fXVmzoO4bLDAr0MbSRlvtfNxs
         Pfow==
X-Forwarded-Encrypted: i=1; AJvYcCWlsMuZ4hIYNFIXt8OfcKz5PrzQR022xe+SiluFAb/KDWjhpoKkb4l4Y4BzitvB6qIVrX319ufYi74TFjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32IHBk86+IGHHrzENG28smsmb1dr6ElB5e9eFCBBAAmlQPuMg
	RNWMS7V8EhoGsKEpQvyfXVtnvxSxuTMerT5AYdvl4Q/5kRO9boS0Iz+O1kAG2IGBYskel8UYbmN
	XfUJppXk78ITptrztxHTNLpo3MjCvItp15zU2Hhy7+k27KUaXUgQfREKPY+yFfg==
X-Received: by 2002:a5d:5e87:0:b0:37d:39d8:b54b with SMTP id ffacd0b85a97d-381c7ae1552mr13768276f8f.58.1730805950646;
        Tue, 05 Nov 2024 03:25:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjLB5E+ROQ7F6DRPhVbGIzb5at4ILUKJu3X2OrRGqPJDFCPvEe/hdkUEhFiHeOv+TQOCR9oA==
X-Received: by 2002:a5d:5e87:0:b0:37d:39d8:b54b with SMTP id ffacd0b85a97d-381c7ae1552mr13768245f8f.58.1730805950234;
        Tue, 05 Nov 2024 03:25:50 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7449sm15923971f8f.49.2024.11.05.03.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 03:25:49 -0800 (PST)
Message-ID: <7b8b83b4-f745-4f3b-8cac-2f190937667a@redhat.com>
Date: Tue, 5 Nov 2024 12:25:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v4 8/9] net: ip: make
 ip_mkroute_input/__mkroute_input return drop reasons
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, dsahern@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, roopa@nvidia.com, razor@blackwall.org,
 gnault@redhat.com, bigeasy@linutronix.de, hawk@kernel.org,
 idosch@nvidia.com, dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
 <20241030014145.1409628-9-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241030014145.1409628-9-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/24 02:41, Menglong Dong wrote:
> @@ -1820,7 +1822,8 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
>  		 */
>  		if (out_dev == in_dev &&
>  		    IN_DEV_PROXY_ARP_PVLAN(in_dev) == 0) {
> -			err = -EINVAL;
> +			/* what do we name this situation? */
> +			reason = SKB_DROP_REASON_ARP_PVLAN_DISABLE;

I don't have a better suggestion :(

Please drop the comment and re-iterate the question in the commit
message after a '---' separator, so we can merge the patch unmodified if
nobody suggests a better one.

Thanks,

Paolo


