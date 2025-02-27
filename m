Return-Path: <linux-kernel+bounces-535998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5CEA47A52
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB787A2082
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E6121D5AE;
	Thu, 27 Feb 2025 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1Jhue+4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0641487D5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652256; cv=none; b=EAWM4FO9NRbmohM+LWQVCVENtR5rWvM6ls4/hO7F6C8Ire5dujnAqnYPWcTLlLys879GMc20LDfD9FK1lkBlowY0e31n7oYxlAKfMo5tVugwEgkHJWVvYLB2oR2s42Zyy+HiVZnnjrQkS9gNS2F9GNN6uf3njp6xpUZeTgk9WSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652256; c=relaxed/simple;
	bh=+v3xkJS3XMAxcs9N3Ws2L/B6PJdrpS8kXHjrtO6boDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jopsz7wl3qIYX0Tb1Qem4JZEfXIUnTAQ0x84HgXUdmaLU1/o2k5PiTWHCzX/R4PD0fuz8Yfa+OFSy/RMcBzagMEZrusTmpSMoJExbQ1n6MFkWcnlMfFDI3hoEToJ+fhQsPpPTuG5sORG/gHC3kFI7oRYffEHQ+u26NNdIUKj+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a1Jhue+4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740652254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOkzrL8YRVS4cEWE0UGROaO1cYbN8EnDQwWGMEJe0oQ=;
	b=a1Jhue+4BBwxP+eWifeU4hpBTOgkC/2tT3wDO6CzvLS7aKjVhTZkN3j1PywWW+YONEC54B
	THOCM8J4X2Q1SV994sqFFVS2RrRazQ8kCGM02xF/A+Td6rys0vUbFVkKQoCH2H7qTrGGtA
	SB7kdMQrQdwxyZaxGWRV9pKBVSAmK6Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-ZtaUoZxvNs2xImFwwRpHSw-1; Thu, 27 Feb 2025 05:30:52 -0500
X-MC-Unique: ZtaUoZxvNs2xImFwwRpHSw-1
X-Mimecast-MFC-AGG-ID: ZtaUoZxvNs2xImFwwRpHSw_1740652251
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4399a5afc72so4050225e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:30:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652251; x=1741257051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOkzrL8YRVS4cEWE0UGROaO1cYbN8EnDQwWGMEJe0oQ=;
        b=eiDXNv82noXUJN6kcZoM6usHpvUh4zROlRyaWXZ8Y2FCKs7+4q1D8t4B3/ck/Mmjkm
         r3Nz0XhLG5eQ2+3KaWL9zwo47Lyfluc0KjqO41b3knM3HtA2nHuw+RyZdmtxuy2NJsZ9
         HXT7i1uICRGsPh8U5+WkN1urn96X7Ztkf0HmXmpsujiY1LENC+rq5LyQNuz3KY+mt9p7
         TuhZ9cdBCsNfUJVo8+H8GtYsj11i3uEpT90y0EXpPsYMjmm1s09YS/HAC7aeRgNmvcL6
         CdCBBaFjmi0xXAcXGAMX997WVkfFhEHbXnGL43FvwrlraaFJykuNJMaetr8lFC3+mwD7
         H0dg==
X-Forwarded-Encrypted: i=1; AJvYcCXMv7K9wnf1w+YRDCO+ObHWqi9AVRl8KS1P83bLwqlwAyxWhkmybkXLmh9yLwDnHmj///3zqj+Ft4WbSHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLZKknaoaWCGg0b3Ghv5xu563VxvZzpQ5MkNMuIy4aVLNPJ6A
	ngFldLK+xE9Ny6FkKdmV1fvENvcL+L7lpwlzTaZoH8Re6rwX9K4MKX6QEn6hsJtwC9GYwW6YfU6
	rNW0D+MNhP0t10m9fue9oQm5cnr4U0TW73AtTZdJzr6tPehRPopBLWWFsRYRBuQ==
X-Gm-Gg: ASbGncs5FOnLxGjBSEXcWG8SknTgQUVLEzACrq0NAV6+Qx8u6dozJ6qu7NRvS775jSz
	3+HgBl4yvrUJFbiprNswRbUai1J0n+lPGpW/oBxssK7AMngRmpHb2N+CBep6AeuYoBMy21/8IbE
	DNtAb+DNk/ZY7N4VMzlsfpI/iiIMtU0zX3EqgciHkSVpUXwgVBAmQZNmfhQ2JBNo1MK/Ty7F6WL
	W352Q12RBCK8kNoD3aBqm3lEi/VW/iInbxzQ5+6Ovg15uy1c9igJ3ILNAPcYCpP9tjfd4glPnWF
	97Q2dhONA6ZG6rkUfR8gV/JYzIx8YjDTdivp05nyv6fr0g==
X-Received: by 2002:a05:600c:3c95:b0:439:a88f:8523 with SMTP id 5b1f17b1804b1-439aebc2d5fmr171656785e9.21.1740652250892;
        Thu, 27 Feb 2025 02:30:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK6bHmySSujITFjcBPGuRs0PAR8EgMcRUkrPAM/8iUIqIbQEdpe+j6f1uiQXRHE5zW+7ZneA==
X-Received: by 2002:a05:600c:3c95:b0:439:a88f:8523 with SMTP id 5b1f17b1804b1-439aebc2d5fmr171656515e9.21.1740652250529;
        Thu, 27 Feb 2025 02:30:50 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47965f3sm1585669f8f.9.2025.02.27.02.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:30:50 -0800 (PST)
Message-ID: <e71aecb0-9636-42d7-a9fb-2ff9df817cd7@redhat.com>
Date: Thu, 27 Feb 2025 11:30:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ipv6: fix TCP GSO segmentation with NAT
To: Eric Dumazet <edumazet@google.com>, Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org
References: <20250224112046.52304-1-nbd@nbd.name>
 <CANn89iLi-NC=4jbNfFW7DELtHS2_JNAHiwRs7GbfZP2E9rGqXA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLi-NC=4jbNfFW7DELtHS2_JNAHiwRs7GbfZP2E9rGqXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/24/25 2:00 PM, Eric Dumazet wrote:
> On Mon, Feb 24, 2025 at 12:21 PM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> When updating the source/destination address, the TCP/UDP checksum needs to
>> be updated as well.
>>
>> Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  net/ipv6/tcpv6_offload.c | 20 ++++++++++++++++----
>>  1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
>> index a45bf17cb2a1..5d0fcdbf57a1 100644
>> --- a/net/ipv6/tcpv6_offload.c
>> +++ b/net/ipv6/tcpv6_offload.c
>> @@ -113,24 +113,36 @@ static struct sk_buff *__tcpv6_gso_segment_list_csum(struct sk_buff *segs)
>>         struct sk_buff *seg;
>>         struct tcphdr *th2;
>>         struct ipv6hdr *iph2;
>> +       bool addr_equal;
>>
>>         seg = segs;
>>         th = tcp_hdr(seg);
>>         iph = ipv6_hdr(seg);
>>         th2 = tcp_hdr(seg->next);
>>         iph2 = ipv6_hdr(seg->next);
>> +       addr_equal = ipv6_addr_equal(&iph->saddr, &iph2->saddr) &&
>> +                    ipv6_addr_equal(&iph->daddr, &iph2->daddr);
>>
>>         if (!(*(const u32 *)&th->source ^ *(const u32 *)&th2->source) &&
>> -           ipv6_addr_equal(&iph->saddr, &iph2->saddr) &&
>> -           ipv6_addr_equal(&iph->daddr, &iph2->daddr))
>> +           addr_equal)
>>                 return segs;
>>
>>         while ((seg = seg->next)) {
>>                 th2 = tcp_hdr(seg);
>>                 iph2 = ipv6_hdr(seg);
>>
>> -               iph2->saddr = iph->saddr;
>> -               iph2->daddr = iph->daddr;
>> +               if (!addr_equal) {
>> +                       inet_proto_csum_replace16(&th2->check, seg,
>> +                                                 iph2->saddr.s6_addr32,
>> +                                                 iph->saddr.s6_addr32,
>> +                                                 true);
>> +                       inet_proto_csum_replace16(&th2->check, seg,
>> +                                                 iph2->daddr.s6_addr32,
>> +                                                 iph->daddr.s6_addr32,
>> +                                                 true);
>> +                       iph2->saddr = iph->saddr;
>> +                       iph2->daddr = iph->daddr;
>> +               }
>>                 __tcpv6_gso_segment_csum(seg, &th2->source, th->source);
>>                 __tcpv6_gso_segment_csum(seg, &th2->dest, th->dest);
> 
> Good catch !
> 
> I note that __tcpv4_gso_segment_csum() does the needed csum changes
> for both ports and address components.
> 
> Have you considered using the same logic for IPv6, to keep
> __tcpv6_gso_segment_list_csum()
> and __tcpv4_gso_segment_list_csum() similar ?

I agree with Eric, I think we should try to keep ipv4 and ipv6 code and
behavior similar, where/when it makes sense (like here).

@Felix, could you please update the patch accordingly?

Thanks,

Paolo


