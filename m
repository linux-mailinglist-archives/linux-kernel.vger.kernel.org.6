Return-Path: <linux-kernel+bounces-544404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5F7A4E0D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B7B1693A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EEB208961;
	Tue,  4 Mar 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeiAz6rK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064FA206F03
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098248; cv=none; b=n1+3sVJodJkUZkb85i5a6ZcdkSd6e6QO9w333DsgIF51CnQHxgS+SkrsFO8Uwp+Dt4GoO80StViRlV4xImH1fP1RUQmDXXRKOyTKqfVa6/f7Xdzzvl+ZLaIQ6J3/C4gINc23tokHC+RKK3gCNA3nTGIgfgObsTsYKaqJ+D+ZkxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098248; c=relaxed/simple;
	bh=YToWRXI3ojp5Qpx1iSipk79vN6Czw/zLodfp8xVJwD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAKy+Z3S/X94v7+F16Nkscz1rJl9cSi4R6e33lKSm+fsLvFk35c8iexFOmX7Px2tbla2VXWMylmRJaobxLm63ehzztEGV48bdHxGBPle5Ea0J7qO/K5t+Ht4kfkDTjPyxMeQFq4M9ISNpnxaYoW7vl64Lf62DnpjVrmnGUCXd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DeiAz6rK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741098246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7Jl6RqLE4ySPh0n2/0y55XdmikJ9fMRlsEGtfokKwE=;
	b=DeiAz6rKfjcV5NpgPmhqAEgjxxIJhfqTZNT+LI3Dl8HGWydgRJfGwmPIVM+zUpgRmFuw6i
	ywXcsrYO20+tbGedr+1tN4mjWmTl866PvNUtcN1NqgJRKS6D2C4IkvQXZ/QzkfPjQHLTgx
	LkJNl3T0BOyzVde/Sftow9v3uGjpIbY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-PQ70ayaXOC2FD4Afy1C9aQ-1; Tue, 04 Mar 2025 09:23:44 -0500
X-MC-Unique: PQ70ayaXOC2FD4Afy1C9aQ-1
X-Mimecast-MFC-AGG-ID: PQ70ayaXOC2FD4Afy1C9aQ_1741098224
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4399d2a1331so28211565e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 06:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741098223; x=1741703023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7Jl6RqLE4ySPh0n2/0y55XdmikJ9fMRlsEGtfokKwE=;
        b=PtZXR6WjJDiNdVoDtbAoRqrNPlw5GSc1RI0VjlD1C8/tvD1d9DO5CjyqBLbelNFd9/
         ed9THEtpbTNL0eBRCGNxqhZfzpV5UQzwXc2KcO/7vL6CmSgowk+J2zh3E0Qun1GaZO/Q
         sqXYAR/ZQty1dFsJqybCm7BeT4MziWXHNxAb3J6d1iXnKr7fT4Cx/PZVihpIhdAtsUbW
         7zpGflVjdue3WSiEg8oCeM3EHUd0T+ZPh3u3u00KSmldT3+NW4BFdfI5YfDrG2rOu7gW
         +W5WFYkz3JdGuczxxwy5xaaCCf0valhc8e3ral/ypPKxwUuKghDafAdqzxGXrt/PCcc9
         8uNA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Uttg9cIRY1YreQ9/5LZR7SZLOA+gPEm3hJOjp0b67cClH9hMhSWCXN5zjkiJCcf+j+/VqmI5Y+JDfy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmsdcGPUwBqw4IHogJLtm1Uj5Jr0/3JiDwjyZcvzag4BzKSOug
	anRzIurzSgGMk/mam+xMLOSduozEmTolcmp2Z/XF4K4F/gBgyV1NtQ83rvnKYKBbJIdqOPlslKk
	NJ1PaAcwLRsW2ccsS+Hzk7GJqdszqxq/g7i8hKh/jBNkg3NYyi1Cbson1ZJsYhQ==
X-Gm-Gg: ASbGncuTfLni/ZhH9Eocpa3JkRiozSrEmTNBWRlhFrb6SjZEU2aS/laqLbfCpdB52aF
	scEBoA6Hglwv3NP3Dsuv168x8SXeCxwFzK4BL6JLlsboZ3ZBG0RvVinMO31b3/A8BAoq68r0z6l
	3B1oQofCIz/PkIXMWllqyI/3vysU+6H/9cujul6n0/13lKHzvpDdAnU9v+Gru4dhyRsdgTXLTcl
	ZH0aIDx/Yf7KVrzXdH8cCSGBrWr2Dz/vkKryfNt8bd8lJP9q/C0teHpwLD/+HCp4jZoykUPxc9f
	yjEbUUNfajFPMqcqlNsJzBc+r784/GYp85XS07q2vjTSvA==
X-Received: by 2002:a05:600c:4793:b0:43b:baf7:76e4 with SMTP id 5b1f17b1804b1-43bcae04e19mr29901235e9.1.1741098223609;
        Tue, 04 Mar 2025 06:23:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF52Rx16VjlDS72aosnmdGbcCI7vGQKO/XsIiTckVodJ9P2N/4wxflyj/DJe6Sib08YfVkUAQ==
X-Received: by 2002:a05:600c:4793:b0:43b:baf7:76e4 with SMTP id 5b1f17b1804b1-43bcae04e19mr29900945e9.1.1741098223266;
        Tue, 04 Mar 2025 06:23:43 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f75ebsm199915175e9.3.2025.03.04.06.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 06:23:42 -0800 (PST)
Message-ID: <278118b1-eae8-401a-8501-e0a777852fcf@redhat.com>
Date: Tue, 4 Mar 2025 15:23:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/7] netconsole: add task name to extra data
 fields
To: Breno Leitao <leitao@debian.org>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-5-21c86ae8fc0d@debian.org>
 <20250225101910.GM1615191@kernel.org>
 <20250225-doberman-of-scientific-champagne-640c69@leitao>
 <d0e43d0a-621d-46ee-8cb7-1e5c41e76b8c@redhat.com>
 <20250225-bright-jasmine-butterfly-aa1bb0@leitao>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250225-bright-jasmine-butterfly-aa1bb0@leitao>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 2:11 PM, Breno Leitao wrote:
> Ack. I will remove the check then, and check if the UDP stack has been
> initialized before calling netpoll helpers.
> 
> What is the best way to make sure taht the UDP stack has been
> initialized?

[brosers!] Sorry for the latency. My statement was intended as a
negative example: "adding such check would be as misleading as checking
if the UDP stack has been before calling netpoll helpers". The UDP stack
is always initialized when called from netpoll, due to the relevant
"init" order.

/P


