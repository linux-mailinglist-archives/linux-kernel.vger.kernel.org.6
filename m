Return-Path: <linux-kernel+bounces-390677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB499B7D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52B91F22587
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A911A0BCA;
	Thu, 31 Oct 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHg5hZvt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA4142AA5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385711; cv=none; b=oKLV3dW8UjLZ/jd7LVAel8aoqy4mdIeCYQgC0bjgHoyCuEpH5mtjxl+KihANn7PkqkMrAzlKQ/y9rmqXN2hSLfAZM3ZoEyQnFLTQa5xT8ofBcTEAb6eO6hIPOO4Pcl0sThKdGLGGH/J8N/aOXHV7kzLlCRCesOJg60/A4SUb41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385711; c=relaxed/simple;
	bh=9eS5ge2alX9b56f6i6Q7sWV1uG4Sj94/LDvot5kpaqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g89sO/TKEUyvYWN5h1bHPQD+KeXeN2U2ThqbtkvIdkB4z6Rgbe6XzKtoqoyuU/r5mBcjHEjLJhR2O7tmVOSKZsqpg4ydqp3GJpPErOoRoKCN/xLstEswewqKtnK0Dog86TN/+u9Z2MWz7zQBaj1RYmlq+9AQljUhYlF63NQExoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gHg5hZvt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730385709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dlgmPQjrWN8bcG64Fgx2fujRr7yOykhTLvlfDSXZU4=;
	b=gHg5hZvtDcsQMj8nDqVk+t/4Hxzzm5s1ArmOkr/fWIlUt0bW/SWM4f29cP8XxaKYcApbjo
	VAKrDDB+9AMVQWU6Wy3x4wQuohUsrRwbkOiDKHCKiJHqPArzUBUbrAlf4byDPUol55zhVN
	BDScEhvDF43jTE5QWgSyBOdpC2K+Mng=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-xKdT_W7YNnqRTBOWd8tmYw-1; Thu, 31 Oct 2024 10:41:47 -0400
X-MC-Unique: xKdT_W7YNnqRTBOWd8tmYw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d45f1e935so414823f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730385706; x=1730990506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dlgmPQjrWN8bcG64Fgx2fujRr7yOykhTLvlfDSXZU4=;
        b=XY7m19MWr0ejPJSi0RGv4m8/8fzusjCLptyn7q0i/Q1C/xc/SqUoUY2sbz/33lfKky
         oB1n3x8dD+fLkSmHTEGXBnXqRAjD+izogiDKV+6XpnTi6dkz5tYrjkHOVh0H0mN6j/ge
         SsPBTdghnu37VcfgXSFpLUGNrOqP8pdISeaUUK/R/VfTSR4GHFiGQdU+sRwalri919ED
         MSjxuSX8PtwtNBGVa66eA8RU0vkwQKLlGQurMwrsTleB/hsAzDurrm/wNWy4sA5MyTpd
         XbxREOXunKlg1dbTIelAN37LRuxb854YuE7s9SqOeuOuBnGQrRLcU90hsRJ1vLU9nSbu
         NK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUT3QO+KDeWOVP7tVgpRsupX3iphuw1GCkrBgLb5sddpWGzYzMiAxhKBWr6jDapSK8uUMwbOLn/dKgpnJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRAuAucdVWAD+KOgoASvPB5KcZ0h7rbAZRvyIFdXg/yLUHfMku
	K3++8bK/WHTczwBX83CwwVwmh2BnP+4QNZ12zpilnexI7UW4TZfXQ+j0r+BlZcc3GfmIm0OmudS
	A9z6WxfE77g6Z1sLG45M2p8qcvsQCWkGpyzRigEi/ZPqda4saKyJITfX/2w/9Ug==
X-Received: by 2002:a5d:6d0e:0:b0:37c:cc60:2c63 with SMTP id ffacd0b85a97d-381c7a3a23dmr216434f8f.5.1730385706492;
        Thu, 31 Oct 2024 07:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg8FMucp/9+qkpBZFRMIEgFHrJyFQGjPuPNs4cDJVO5fafRU341aNOfiA7iUPsBELpgYtCyQ==
X-Received: by 2002:a5d:6d0e:0:b0:37c:cc60:2c63 with SMTP id ffacd0b85a97d-381c7a3a23dmr216386f8f.5.1730385706081;
        Thu, 31 Oct 2024 07:41:46 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116b11esm2278221f8f.104.2024.10.31.07.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 07:41:45 -0700 (PDT)
Message-ID: <3e443eb4-d15f-45ff-8b41-a8215fb4032b@redhat.com>
Date: Thu, 31 Oct 2024 15:41:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] selftests: hsr: Add test for VLAN
To: MD Danish Anwar <danishanwar@ti.com>, geliang@kernel.org,
 liuhangbin@gmail.com, dan.carpenter@linaro.org, jiri@resnulli.us,
 n.zhandarovich@fintech.ru, aleksander.lobakin@intel.com, lukma@denx.de,
 horms@kernel.org, jan.kiszka@siemens.com, diogo.ivo@siemens.com,
 shuah@kernel.org, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
 m-malladi@ti.com
References: <20241024103056.3201071-1-danishanwar@ti.com>
 <20241024103056.3201071-5-danishanwar@ti.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241024103056.3201071-5-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/24 12:30, MD Danish Anwar wrote:
> @@ -183,9 +232,21 @@ trap cleanup_all_ns EXIT
>  setup_hsr_interfaces 0
>  do_complete_ping_test
>  
> +# Run VLAN Test
> +if $vlan; then
> +	setup_vlan_interfaces
> +	hsr_vlan_ping
> +fi
> +
>  setup_ns ns1 ns2 ns3
>  
>  setup_hsr_interfaces 1
>  do_complete_ping_test
>  
> +# Run VLAN Test
> +if $vlan; then
> +	setup_vlan_interfaces
> +	hsr_vlan_ping
> +fi

The new tests should be enabled by default. Indeed ideally the test
script should be able to run successfully on kernel not supporting such
feature; you could cope with that looking for the hsr exposed feature
and skipping the vlan test when the relevant feature is not present.

Cheers,

Paolo


