Return-Path: <linux-kernel+bounces-303149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3967096081F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8DD284122
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A0019EEB7;
	Tue, 27 Aug 2024 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ar5yNACr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2854648
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756629; cv=none; b=PRVGHuZ5ma1WBAAjRzfkoJkpQeUNdR/cO6ZFzbRiUlqqM6gOzpMNZ1iNn/wLxLJqt6PKeAfdp5SH+sqFgEUDDpYSqZd2PYcEdp3buufSEppaQr4c5s5hfzyDtDMxKW+Eg0y1Hqa11hrT0TuDnGyQ6XrrepFKWTmGDEURJA1IWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756629; c=relaxed/simple;
	bh=A+MNWj+OQxto9jsh0jURUa7HxhqCaOn/gLNcSl4YUqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sy6Mq1TIW2h9bNHDmO/FqC2Lgnt1xtXLgt6j3JIZPQ5t9j15ei+fG2romg6rZJ3vmv1YRw9D3dbO1vMxnpwp4zFqTeoTVMnRIT5ebDKB3O1vwx4YE/SHfBI5vgnkVXsAbdSwltD0VeEnV5sL+lRZ4LTp+OXRB3rarahmWWpWyj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ar5yNACr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724756626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgSQAdyFzCk1B7hAbRKds1KXjrwE0OwyWBIAVqcPcqY=;
	b=ar5yNACrRYC75CCOD443LBCYnW7bDLCRUQTJXH/9xhqzow/fJJ7ewWImEYe1MZw9rpMFfX
	3xFG55A4HZ8sovxQi+7W5SFODG9banpZfh156WKnO7EA9ZX0059/CPeJegUbAa9ueKxxXa
	zslFtwYwmDgVY7jb8PeC/NpBRiyQPiM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-R2Ga3nu9PfipDostbjI-WA-1; Tue, 27 Aug 2024 07:03:44 -0400
X-MC-Unique: R2Ga3nu9PfipDostbjI-WA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42816aacabcso47254855e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724756623; x=1725361423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgSQAdyFzCk1B7hAbRKds1KXjrwE0OwyWBIAVqcPcqY=;
        b=rdsVfSnDxgvzvNtyPMxn/+HXOmgOKp+jJwNKmZFdowuheiR63H9YmW+R3yIia3Be0q
         bXdS/7wNEF5prRJaRAkL9cbtAR0Zj0Vhan98bkEjtI2i6XtvWr6FmpBt7ugBnQ41M6k2
         idyfej/gR6hI7P4UX1iOc1n0XMO/fnJYtznGrOfCMXIeUujNxP4tTJ8S+xXi6aeKAMly
         73VenPXlQPY4xSGQ1Pc0fnFCgRe/8Hk1VmfC1XFqceUMIE1BhcqrrhNjIZeFKjZsp1FS
         VWNRqruF5QNbU4nPtFge+Pl8J1nkO8AGrJefCVApmby0Gom9sizpgPCrW3BH1lvbSjHG
         80NA==
X-Forwarded-Encrypted: i=1; AJvYcCWc8lrGQCqIdZbUCzaBeQGfTKiXwFqB5BqVK3/aNLffFDxKaorz8qf/ttxExVfrr4JSeGKqnK+CgHv9SzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMrJCLtRyDdL1X15qkGeQ8s6Fc2mxvVb+0yCXgfRTlFP2x1UUy
	M4zd7URdmZa1HjPQeZ2uQKuU6hOMR4Rz3Ms1dF0h9xE9gcr3mIc9NhXI25ZORwkL802MuoYbZEj
	Lx0vGVCq1XzWxIOwnmo3amncbEguon6jVGnqa8AyduXf517d18RnF9Er8RuArDQ==
X-Received: by 2002:a05:600c:1906:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-42acca0228fmr88165335e9.31.1724756622874;
        Tue, 27 Aug 2024 04:03:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5rXVSWLGAoMAVG7lpEUZCl6uE3GH7MnHGgSFiGY/SippMRXHtMs4XqJiD5ahbRzNGg7baFg==
X-Received: by 2002:a05:600c:1906:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-42acca0228fmr88165075e9.31.1724756622350;
        Tue, 27 Aug 2024 04:03:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b67:7410::f71? ([2a0d:3344:1b67:7410::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42b9e7b7f87sm12193365e9.1.2024.08.27.04.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 04:03:41 -0700 (PDT)
Message-ID: <a7a33be8-6ef6-402e-b821-8ce9d4620a1b@redhat.com>
Date: Tue, 27 Aug 2024 13:03:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: fix switchdev host mdb entry updates
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240822163836.67061-1-nbd@nbd.name>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240822163836.67061-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/22/24 18:38, Felix Fietkau wrote:
> When a mdb entry is removed, the bridge switchdev code can issue a
> switchdev_port_obj_del call for a port that was not offloaded.
> 
> This leads to an imbalance in switchdev_port_obj_add/del calls, since
> br_switchdev_mdb_replay has not been called for the port before.
> 
> This can lead to potential multicast forwarding issues and messages such as:
> mt7915e 0000:01:00.0 wl1-ap0: Failed to del Host Multicast Database entry
> 	(object id=3) with error: -ENOENT (-2).
> 
> Fix this issue by checking the port offload status when iterating over
> lower devs.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

This looks like a fix suitable for the net tree and deserving a fixes 
tag. Could you please repost adding both the target tree prefix and tag?

Thanks,

Paolo


