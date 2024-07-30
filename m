Return-Path: <linux-kernel+bounces-267102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE29E940C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628211F2369C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7BF192B9B;
	Tue, 30 Jul 2024 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAPzjXzQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FF1B86DD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329608; cv=none; b=g4EfRzhxj1CN+QpLkD72xFj3i7pdBFihOquZvgFbFqLzjgId/JB1UaiRWCEW4Els2wyd/ab981ypCo16SJq6k7pREWE03hugPfhyURJcJjwQozECZ1M+CfHkDoxf8gBwb0t9AGlq9qBxGxqCQQgWWIffZb0yNXoMYCxe2G/+UPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329608; c=relaxed/simple;
	bh=+Qw8W9JXBVK2KYNrBUnkVpFmWeK8eGoS0fvOLwMjbCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTnMBYWnMIeXnWjk177F8p3vSlG0BnRjCRvF7pJ6vBjVQ9Gag+3bbMrV2KpMRwEbr5uwvFNQkWysEDp2jx5tpXJtrXrVBQ3wi7WzlPcel8TjmRVRfK3a9cWQYQJac7HiV8MSFzulXeIpj0lz3wxUrO4isZcitsRsIFx+A+Yquco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAPzjXzQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722329605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnacwdNXQeiYAN/vyHCjqJ3Z55j/qGrBpNl88GFWc6Q=;
	b=OAPzjXzQf/Y/GXR2QUBwbZBsaom7bDV5lEz5GIAKEhFXBwG2S8DxZL0mUztWrlyBwWVJs6
	EyaM/wmUh0qdxZUwnQS3gTM6qZcPsSTTWw/2U7QOq2wtbESv4mwmLwY/fshyGefGyXVe/I
	oa/D5uFM3woT2fpnmtUx2tcBlPNXiNc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-kZ6CEmZ-Ms-G-Nbg_72n6g-1; Tue, 30 Jul 2024 04:53:23 -0400
X-MC-Unique: kZ6CEmZ-Ms-G-Nbg_72n6g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280f31c668so6045835e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722329602; x=1722934402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YnacwdNXQeiYAN/vyHCjqJ3Z55j/qGrBpNl88GFWc6Q=;
        b=NIDYb19BNMBg7FybpPfLkDK5TovQwtKH47GODWbK9n7zNEd7g7frbVUcQ+a5xe7K1K
         j2hFrOUGdV8iZ46VpzZn8CSlDTCT1r6YJWIW5wEz8Drf7Rx/8s0zuCoOw3qoM9dgVMey
         KFBiEFw4xI36bubo0nuSEFvzCKnlt3IEHWp9alszo6UwbCxl1di2W/BRE9i9wrcdhv53
         phlCNidQW5RZ27UfYJ0aXfu9QqZoUxVkKU1kbwy93jLiubnGQSZRAEBGlbycdv4l9l8g
         MioCHNGoPz/pLQCnoRpuO1WrQyDhfomq09h0+tW9cW5QRGugImYZzEWb6l+PaPj4djSv
         1IuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0lwb9Xd36q/fxmrx0+cIbHRAimOqE+/14RA52SfoZPitRnhUMHQO7n4NN/eJSU+t/IoRaUOE8Pq4VVfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh29xm19gzhJ9xK6ZugAnjpPt8Q3tLFMpbNi5s61Sqrk+ilLGg
	enJgV8dVgg8OjBltuf/nbyRbP3iTp1/zlkoiExSMeHWkKPwhn37eKje6c11KcsJB06SipPRN7aY
	fdF9GS1qdaPY/Wb9c0GMcIPFV6Yk75I7rkuneRQbhS+z8vTuA94+E1YfaqXkKPg==
X-Received: by 2002:a05:600c:4fc2:b0:427:9f6c:e4bd with SMTP id 5b1f17b1804b1-42805713af0mr69580055e9.6.1722329601920;
        Tue, 30 Jul 2024 01:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe5skEumfC7OwYco+fwnLjIRX5mFiP+wG2g0HwUfV8HU5TLSTPaOIm8pjlpNbR0ZWFSuDj1w==
X-Received: by 2002:a05:600c:4fc2:b0:427:9f6c:e4bd with SMTP id 5b1f17b1804b1-42805713af0mr69579945e9.6.1722329601387;
        Tue, 30 Jul 2024 01:53:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410:9110:ce28:b1de:d919? ([2a0d:3344:1712:4410:9110:ce28:b1de:d919])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428089c28f0sm191284215e9.28.2024.07.30.01.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 01:53:20 -0700 (PDT)
Message-ID: <738f69e6-1e8d-4acc-adfa-9592505723fe@redhat.com>
Date: Tue, 30 Jul 2024 10:53:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: drop clocks unused by
 Ethernet driver
To: Jakub Kicinski <kuba@kernel.org>, Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <5f7fc409ecae7794e4f09d90437db1dd9e4e7132.1722207277.git.daniel@makrotopia.org>
 <20240729190634.33c50e2a@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240729190634.33c50e2a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 04:06, Jakub Kicinski wrote:
> On Mon, 29 Jul 2024 00:00:23 +0100 Daniel Golle wrote:
>> Clocks for SerDes and PHY are going to be handled by standalone drivers
>> for each of those hardware components. Drop them from the Ethernet driver.
>>
>> The clocks which are being removed for this patch are responsible for
>> the for the SerDes PCS and PHYs used for the 2nd and 3rd MAC which are
>> anyway not yet supported. Hence backwards compatibility is not an issue.
> 
> What user visible issue is it fixing, then?

Indeed this looks like more a cleanup than a fix. @Daniel why net-next 
without fixes tag is not a suitable target here?

Thanks!

Paolo


