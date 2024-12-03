Return-Path: <linux-kernel+bounces-429208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709CA9E18C3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D7B1665D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89721E0DB6;
	Tue,  3 Dec 2024 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uflgpnjr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400BA1E0B6F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220265; cv=none; b=sPuT5pPHcMdollkzO6X/3Qs2BDfpR1J74SfQQrbHzl9GI9hOoJoVkWX85aV2KYngqdNtR7MnNNB5t+TvO7bPCl6RhBaE2TfJZH7Pb9M7ZEJwKowT6GzFIwtYd/fRTGfmNFhW+En2agwMo+fe10pvwmgOug39+bCkSuicokgjbyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220265; c=relaxed/simple;
	bh=HQ44SPqVqENJTbQrYY2kZjK603Ln//DhUNKAfXJorFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1MyP/6cFSkLPlq7R2RfeNlojVR1YJZodt+3LMbKMnZjvAHKtA6lIMaxzcgKglRv4coKcL9n9+QvqkbmuY/kKxdW1kSX4WHq/adJLn0fkNU1S4AJVFnVoj8HhvmLw01Kx03C0jILywLPG1A+wcJoxepP9F5h5fIQ3SrjncZbujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uflgpnjr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733220262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6Yz/wh2DDx3kpOempfoxxI4Bvmg2kZ7VVay1dulTJk=;
	b=Uflgpnjr2EI17bH3TFgQx3OaKrSpMfeVr+1GQp2onAL3Z2LM7xGPyyrClUrMRJ5+bjtI+M
	rE5qQym3FsHVTJrwT4o9QDau03G8jVSEJld03G5qQAx52hZVkxVrxJBJz6pwtDE1ToKork
	6+fB9HvyrZFknmHGlTnfuHdcaA4pGI8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-xCKULXAWME6JiQD0xjZRNA-1; Tue, 03 Dec 2024 05:04:20 -0500
X-MC-Unique: xCKULXAWME6JiQD0xjZRNA-1
X-Mimecast-MFC-AGG-ID: xCKULXAWME6JiQD0xjZRNA
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d88e7976e3so51917286d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220259; x=1733825059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6Yz/wh2DDx3kpOempfoxxI4Bvmg2kZ7VVay1dulTJk=;
        b=KEEP5WewL573MeD5U/S3qpJqQ0ooOuWi1DwoMPGSlk9v6m2BfkptdrKIuwvUricXls
         mm53XN2PNpjejHfQp3FEq72cVpUISMHAsRAvR9r2K/vldnSyTPr+jLOXRs6PffXqQ7fS
         WWJC7AtZXGXeq8O/KZdWJNAzRNVPwVeRf+Q52LZ8BqWQeBnTc6S5mzfxcBkmU7IoK1GW
         W3Mzco4INylkbEB5Zwt4V3Km4+onMh/9L2KElfx9aLccEbMUyOUW5wByyqU4czjHQd6B
         7j51J3yRkpuKikCvkIS6pwiUUYVuGohZj5RkZCzlVnW4Sx5vVf1iLJYH/BMMT5bV6MI4
         Z8UQ==
X-Forwarded-Encrypted: i=1; AJvYcCV47Pemcap3mc+We1gcpJDo7WVTlgOEmWBPOYYBrDlzrJZbeFNvHGiq+6M4LCiRgQ/ispZwHITS/go6T98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXvkOVwqWmsYJVcj4wQsHK7NKQYEdiAZ6/oRbtVm4ZTK4Z2D78
	NnLdwhVL7KcKivNU80V5HIsi2EEo5pvBBDIUFLkSSTb39sdifmv5nDQDY6mlDQM0t+w9qxXDen/
	aBnx4OPi1bFfANntV5m8tdQgnHSd7jLQqs3I7NiiCOnR26YhBSj2N8LDka+0v5Q==
X-Gm-Gg: ASbGncuBytdYrf62VWOv/OW7lmaJK3XYVqlh6FlzRyPZA8Ux4iB30GFUT2bbbCB8JaE
	fhl7BWedjgPBEORv0cumYVFsYdwxAJkiOwiBIJrrvYNckAeigGuADMox3svlN8/YcVSA9Sb6fcx
	PfQ2vYQToJnWUf7XujFuNGAg8gpmUFpTwcvK3DFGPoNUmfXM9wLjftSa/4Q2WLFJU7sQjcGArng
	8rZZl/tMhrZz7KDOlP5oSJN6PEub3YIMBY2wWRXtZqPdxjT/gR/520m6CT5rCq7xAlB4oRThgLf
X-Received: by 2002:ad4:5dc2:0:b0:6d8:a39e:32a4 with SMTP id 6a1803df08f44-6d8b7389459mr32032336d6.25.1733220259675;
        Tue, 03 Dec 2024 02:04:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1K5nqkk2YWvJZ36M/30xTQ0u4uphAR9Xza3eEbd6ZgDvKckxS8QXJ6vo2298noBcWsm6LJA==
X-Received: by 2002:ad4:5dc2:0:b0:6d8:a39e:32a4 with SMTP id 6a1803df08f44-6d8b7389459mr32032066d6.25.1733220259408;
        Tue, 03 Dec 2024 02:04:19 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849c35efsm496606685a.118.2024.12.03.02.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 02:04:19 -0800 (PST)
Message-ID: <62cd6d62-b233-4906-af4a-72127fc4c0f4@redhat.com>
Date: Tue, 3 Dec 2024 11:04:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/6] net/smc: set SOCK_NOSPACE when send_remaining but
 no sndbuf_space left
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
 <20241128121435.73071-3-guangguan.wang@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241128121435.73071-3-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/28/24 13:14, Guangguan Wang wrote:
> When application sending data more than sndbuf_space, there have chances
> application will sleep in epoll_wait, and will never be wakeup again. This
> is caused by a race between smc_poll and smc_cdc_tx_handler.
> 
> application                                      tasklet
> smc_tx_sendmsg(len > sndbuf_space)   |
> epoll_wait for EPOLL_OUT,timeout=0   |
>   smc_poll                           |
>     if (!smc->conn.sndbuf_space)     |
>                                      |  smc_cdc_tx_handler
>                                      |    atomic_add sndbuf_space
>                                      |    smc_tx_sndbuf_nonfull
>                                      |      if (!test_bit SOCK_NOSPACE)
>                                      |        do not sk_write_space;
>       set_bit SOCK_NOSPACE;          |
>     return mask=0;                   |
> 
> Application will sleep in epoll_wait as smc_poll returns 0. And
> smc_cdc_tx_handler will not call sk_write_space because the SOCK_NOSPACE
> has not be set. If there is no inflight cdc msg, sk_write_space will not be
> called any more, and application will sleep in epoll_wait forever.
> So set SOCK_NOSPACE when send_remaining but no sndbuf_space left in
> smc_tx_sendmsg, to ensure call sk_write_space in smc_cdc_tx_handler
> even when the above race happens.

I think it should be preferable to address the mentioned race the same
way as tcp_poll(). i.e. checking again smc->conn.sndbuf_space after
setting the NOSPACE bit with appropriate barrier, see:

https://elixir.bootlin.com/linux/v6.12.1/source/net/ipv4/tcp.c#L590

that will avoid additional, possibly unneeded atomic operation in the tx
path (the application could do the next sendmsg()/poll() call after that
the send buf has been freed) and will avoid some code duplication.

Cheers,

Paolo


