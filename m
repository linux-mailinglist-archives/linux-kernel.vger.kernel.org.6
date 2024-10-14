Return-Path: <linux-kernel+bounces-363787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA10A99C705
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5767CB236B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB2415B122;
	Mon, 14 Oct 2024 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0A5McQS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68141487F4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901194; cv=none; b=kBCoa5xEWDeRKUUNRLM9a16Q9KXZRVHO77txLCwYFlnO8XliHZKzqXjhM0dy46qBXQmuMzjR3EvXabg6jHUhLWiO2svp4JFfA2QVZtJcHwDqHDRpOrtkIK+FolWI/eKqFMm57WafJoYYohmEDjQHCxbu/UqDPPoIGYhMK8QsIQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901194; c=relaxed/simple;
	bh=B1eKaysnr/CwGZ//oHQpcL4jtQLUGrwYz+Hf9mgFVhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVayzVjOWqSHu7YIe+dGy6wfIXvKxsiqkMJL1fRDs3AnqqkxBNmbV3LIGwoIzMccud/B4CrnZ/1t2yCtDMOdbBSAfsE+FnMXKs1z/MY3Js9ESmXecVDKUmvjBTdMhTP1uaWzBkoeY1Mlwm8gFf65Go442q+GHa/1Udz5SSUqvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0A5McQS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728901191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTHUqzvtiZs0La6Sa9CMCWUG64x+7/nx78p4X7/24lM=;
	b=L0A5McQSd96yyjHFqYFCntUOPDcDPtnu4dA2e6Usj1uOsuy0gNmV0Ji81z2LycvE0yoS5v
	V6uO7Ki5eIY6+Hgo653I9P35tUHWQ5Jb8DWpeSHaUkr/ZxeyP0WCfuW8GFxwPAHL7uvemt
	z0w5XGqgbD7LByfFeTSu+temb9fIHN8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-GEsUFFxEPFiQfBrHT6kNpQ-1; Mon, 14 Oct 2024 06:19:50 -0400
X-MC-Unique: GEsUFFxEPFiQfBrHT6kNpQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d60f3e458so1127274f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728901189; x=1729505989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTHUqzvtiZs0La6Sa9CMCWUG64x+7/nx78p4X7/24lM=;
        b=V75wpI0+x6h8q7jo8Dp57PImDSKuKFFpVi1w/9dgTyqEM/MIIOPOwv/AdT3SR9Fv4v
         Tqu3lPk+9qkUFx3kOqGcct3LgHsOo0dFz49yLJTHsd5OrTfXw5zthnI+GhaZ2xhDDlmr
         8YVYuOVSKcyGpLp+5yAoRqriyVszGH7R+80ioyteDW3RejrYwgw/pRp2A9lXC+D5mEdD
         dZFMTSF1UhhUuGrzGkITNweKLls3Z3AhCjg3ipSRBp56M8h8u9R9/9JyhSGiI4iaJm6u
         yYC5cKwCLmJnQ1g+VIFU3NXVHAkOVWpywLHkzXRfcq7ATu2WtHAyZIA4lTNItG675Lud
         90YA==
X-Forwarded-Encrypted: i=1; AJvYcCXbugTLxkd96iOBHdSje1vwK0fJwyWhecNhKLayr7x8ooQlx1KHIa6b4girIYfoMmZnfSN6AGjlz1E7zrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1JTlwjIPe+p1kkHa9Nu/huAjXssO6Ko0FD58idjO095pblBC5
	l9dA7ASW+WhlTYlyveZItWwcMm41dj7fsPswGlzgGHuvE3hQWnMUhK/PqNIURTSyM/Gr7rwy0jC
	XCZXbQJI6L/TpNAGWcD7u/Sin9+2kwwYJC6QEKBP0WejnvQoVAwFvWY032Tkq7w==
X-Received: by 2002:adf:fe08:0:b0:37d:39bf:37e3 with SMTP id ffacd0b85a97d-37d5ff59707mr6636093f8f.16.1728901189451;
        Mon, 14 Oct 2024 03:19:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHi9job+XsmNFpeabtOZPzGOYwfWd8AfURhtNkFtVblKgF7EyFl56Q7Tf5TlUEMuoxeKrkuQ==
X-Received: by 2002:adf:fe08:0:b0:37d:39bf:37e3 with SMTP id ffacd0b85a97d-37d5ff59707mr6636059f8f.16.1728901189000;
        Mon, 14 Oct 2024 03:19:49 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f873sm10998742f8f.75.2024.10.14.03.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 03:19:48 -0700 (PDT)
Message-ID: <9c636d54-4276-4e28-abd3-0860bc738640@redhat.com>
Date: Mon, 14 Oct 2024 12:19:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 3/3] ipv4/udp: Add 4-tuple hash for connected
 socket
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241012012918.70888-1-lulie@linux.alibaba.com>
 <20241012012918.70888-4-lulie@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241012012918.70888-4-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/24 03:29, Philo Lu wrote:
> Currently, the udp_table has two hash table, the port hash and portaddr
> hash. Usually for UDP servers, all sockets have the same local port and
> addr, so they are all on the same hash slot within a reuseport group.
> 
> In some applications, UDP servers use connect() to manage clients. In
> particular, when firstly receiving from an unseen 4 tuple, a new socket
> is created and connect()ed to the remote addr:port, and then the fd is
> used exclusively by the client.

How do you handle the following somewhat racing scenario? a 2nd packet 
beloning to the same 4-tulpe lands into the unconnected socket receive 
queue just after the 1st one, before the connected socket is created. 
The server process such packet after the connected socket creation.

How many connected sockets is your system serving concurrently? Possibly 
it would make sense to allocate a larger hash table for the connected 
UDP sockets, using separate/different min/max/scale values WRT to the 
unconnected tables.

Cheers,

Paolo


