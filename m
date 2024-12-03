Return-Path: <linux-kernel+bounces-429666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01D69E1F6C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321B716751D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4AC1F7073;
	Tue,  3 Dec 2024 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AboyqhrQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05A1F6694
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236486; cv=none; b=MNQE94fuITUzgTuJxbFGpcS6yKRWtx9gDCKcjnp9lzYy0vmUG8YMUCdw6AMELLboOLNDhCTqYb0fJWb7zKrG9yd6E/3SqW004ucf38snL2TF4XNB/3TucHyOIVOmIAtXUbU4fqI8l1ziL377yodJN6N+XOaAiETT0mR566C5jkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236486; c=relaxed/simple;
	bh=gU5uGWIiPYomCEI0yBgy+uwiwvPmTlkKp/76+gyNy/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=La2Km85i4ysXlSk1mFop0tt9t1JHMiZeO6pjyFDXVoIqiIq9kCqnc9SZ6Y2RM7q+2575sTBRELbtEW3ClBB0gWKvrI5+WIbUhQu5zCdv+yWGiRTX6b2SfGCs30+1U3+sL0kgwLr11qITEp3wJe/HAAhrvMG/p0wlzBIVSnp80Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AboyqhrQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733236482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZAKk8offspn+CrsLMVAdR0q4qmaIQ+sB/EB4y+6k2o=;
	b=AboyqhrQWBXR8vII+HFqmivS/kjGuZvP2cmYoTD85OzMarCe6tV1sqoFE1kKOU3DxM+xGN
	679DyLbfpVg03I42UXFPoljPKJ/S5WOqP7bF2JrxfOptenuAJ2Cpj3Cnltq3cgmi0nB3yw
	41W7pAJFbe4BqWhdSZ/CTPN6j6s7w+A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-VyIyXYmmM8CSR04vKJu8KQ-1; Tue, 03 Dec 2024 09:34:41 -0500
X-MC-Unique: VyIyXYmmM8CSR04vKJu8KQ-1
X-Mimecast-MFC-AGG-ID: VyIyXYmmM8CSR04vKJu8KQ
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b674755f8eso901916985a.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236481; x=1733841281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZAKk8offspn+CrsLMVAdR0q4qmaIQ+sB/EB4y+6k2o=;
        b=FO1SDMmlKMZqbigifh/RiEIhFIiugSUqBj1e5Hy8ytrrYVLC6vbBVAfrE9ILyeYAhV
         ZIhpLc55WrdX2x+0EFhY/TDDFjHSTlnB71FJ90cmtcnZN/cDZV5XMnoOn40CLz+ioDYv
         PFe6zc1zzEr4qac11mDdzi9h43RqD45mNz4DzcbaSniyg32rRkX0jNbin09KQhrkHnTD
         kxPmb739MRY5w11x4KlBb80cJ7hK/9Kv1ImMaIP3E8bjaHHp96ShOgj3BwQMvskx1iHQ
         44fMoEdgIMDArxoFwzK2wlbY8+zQ9spsdr+RDqPpoq7vXJx8BjLpH68mgDq+Hotynj0L
         5iOw==
X-Forwarded-Encrypted: i=1; AJvYcCVg183iV46nQamH2Pk6U3AzH66nwDlMPpWosxz3KWrW741JLWl+1qgkGeylYaCeuaM8xz+apoxjOdbqoJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1mwkwbc6HHwM9T2sGDU5NRheC9T1gYminGeUOcGjfS2KRRFL
	1NL+ta+txz2/zkWLYS5w3T/3MJdiREQUsXbrdEdID2cmb+zpH5CHim+vnC8+7onFoTN5mtvd73I
	KPepl+rZM4wPMejuU9Ohc6i3lv1Uch/6AmtAoHuDYDBX2nsUh2brtlcLrozmwZw==
X-Gm-Gg: ASbGncvQpkDSr914LSL4W4vCIPkhQshFvDOwAaIENnC6ZX+42GLtZ8lxDGRyoXAA931
	j1HIyQ7NiEO1tPlxsuTCeyq0Z6qojlylirDsgHXM5PjKakZPzpnf0AaPdMJiiOxNg/1696segHa
	BJUN5XiuINotrjrw8IH+IvviTeXDPaMI6/8gWCan75YIk4DErBdEVF4kQGKykmhuaLu4T4PlN33
	xchqgp0KH0iBgISr1v8jIVP5+8SZ+PPo72V+fM1Se0StwvU0QM0HC+/aRX+O34U2C9TfhossCAX
X-Received: by 2002:a05:6214:21ce:b0:6d8:919a:ac43 with SMTP id 6a1803df08f44-6d8b7404d2amr40441356d6.36.1733236480917;
        Tue, 03 Dec 2024 06:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhgK4e/6IUinGGlgMgRZ5guoSHMdFsmcfdl9enfUkbfdJVlNSUwmvuv0H4sImi572qlr1nLw==
X-Received: by 2002:a05:6214:21ce:b0:6d8:919a:ac43 with SMTP id 6a1803df08f44-6d8b7404d2amr40441096d6.36.1733236480538;
        Tue, 03 Dec 2024 06:34:40 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d898045dcasm37681596d6.102.2024.12.03.06.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 06:34:40 -0800 (PST)
Message-ID: <c49582ff-5fe6-4d0a-8d03-7b3297cadd6b@redhat.com>
Date: Tue, 3 Dec 2024 15:34:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 08/22] ovpn: implement basic RX path (UDP)
To: Antonio Quartulli <antonio@openvpn.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-8-239ff733bf97@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241202-b4-ovpn-v12-8-239ff733bf97@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 16:07, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index 2a3dbc723813a14070159318097755cc7ea3f216..1bbbaae8639477b67626731c3bd14810a65dfdcd 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -9,15 +9,78 @@
>  
>  #include <linux/netdevice.h>
>  #include <linux/skbuff.h>
> +#include <net/gro_cells.h>
>  #include <net/gso.h>
>  
> -#include "io.h"
>  #include "ovpnstruct.h"
>  #include "peer.h"
> +#include "io.h"
> +#include "netlink.h"
> +#include "proto.h"
>  #include "udp.h"
>  #include "skb.h"
>  #include "socket.h"
>  
> +/* Called after decrypt to write the IP packet to the device.
> + * This method is expected to manage/free the skb.
> + */
> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	unsigned int pkt_len;
> +	int ret;
> +
> +	/* we can't guarantee the packet wasn't corrupted before entering the
> +	 * VPN, therefore we give other layers a chance to check that
> +	 */
> +	skb->ip_summed = CHECKSUM_NONE;
> +
> +	/* skb hash for transport packet no longer valid after decapsulation */
> +	skb_clear_hash(skb);
> +
> +	/* post-decrypt scrub -- prepare to inject encapsulated packet onto the
> +	 * interface, based on __skb_tunnel_rx() in dst.h
> +	 */
> +	skb->dev = peer->ovpn->dev;
> +	skb_set_queue_mapping(skb, 0);
> +	skb_scrub_packet(skb, true);
> +
> +	skb_reset_network_header(skb);
> +	skb_reset_transport_header(skb);
> +	skb_probe_transport_header(skb);

This is a no-op after the previous call. You should drop it.

Thanks,

Paolo


