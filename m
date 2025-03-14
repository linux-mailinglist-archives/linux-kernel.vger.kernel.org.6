Return-Path: <linux-kernel+bounces-561077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AADA60D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CFF17E74E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A731F239B;
	Fri, 14 Mar 2025 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG5d4d1/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960491EBA07
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944485; cv=none; b=Nw2mkLrj94iU7D1rFQSGlVBjZq505zMAGRxP2sJKWhtmyDMMxu72ZJwEWaYrAE/5c7T5RlS6Qa+mv3NzdfZtJukOcLb7rmlfgGU7qmS/VGczZ4nm0jWCZHEEEF+r4IQ/KmSDrj+sCbGr8zLa4Jk5RSzvu0K3olu1hn2+l5pb+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944485; c=relaxed/simple;
	bh=vsPV74bHjFFKgF9PSNyIa/k5Nno6ObGS6QrL0HdfSYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6OW9IozUdS+5lFvegDWtLtYfCDWBdf13wlndHM+u3M7Mdabf+mQZKGg/2BfV0Qdfp+JaJpCiaRNWo/5tWzgRzWwqtNyKEQK1PdZ4eVGDvRSXJvRbGkvK5hAA9oqXLaihVeJdOkWDJ8K4T+zSTJag3h1H1QCo0kjdqjANgm/1MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OG5d4d1/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741944481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=319xWC7kBsMMKIlkxDgvjIvvfT6rutmSJuA6sY1hnVk=;
	b=OG5d4d1/ResZhWD4CtxyCdEf+fszr2CSWYNVmmo9qQ72Qnr3uAP48ys7ePcju5VMp38bMY
	nPxRGV/bZ8MCpB08PNAk5umx+tEnG7WbrBAIowZSvR1GuEVAj6h3uhS359craMS3juhOQk
	aoeY4XjBSRWKi4T9BdJhcfKQZOV2B60=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-ELV_0e05NAql5aK8SmXcyA-1; Fri, 14 Mar 2025 05:27:59 -0400
X-MC-Unique: ELV_0e05NAql5aK8SmXcyA-1
X-Mimecast-MFC-AGG-ID: ELV_0e05NAql5aK8SmXcyA_1741944478
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39149cbc77dso1142845f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944478; x=1742549278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=319xWC7kBsMMKIlkxDgvjIvvfT6rutmSJuA6sY1hnVk=;
        b=qsEUb7r+6G32pGog5+wUQPZR4uVeY6aiDdBvbQIevN/frMmWoyxHdm40yKgtWM+x3M
         tDYgKi9Usb1OTBFOF1DhbMdKFjF3nW77zJeG1k50opakBhNledQvHqmEHAp0p/NHLb/3
         y4VH60EfDnI03Pn+3PorPX6JcccOAf7OptBMU2IcLQsYT+ow5hL+THIDFb5eHFHPlicF
         EvQUy5C0nbRT1mP+OEvWK/WQk51hKMktRwbbVtCUNY7foNsUVaTPmbfOCSjHFMoBi/hn
         DiXBCa5fYjtWqCY8VYpfFUpHh9CJoUcHVzsyWMeaHSVfzPJdmj6f+nnm88s2cKoW4Vl2
         doTw==
X-Forwarded-Encrypted: i=1; AJvYcCV2bE3ArB2m+0lhe6+sOCoZ0k8DMGT5zxfsCO25aQymWL2mwRvr7nZW9UXVv4wJi7UxWc1lAQh7IpFyE8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLHORAnGMsTbG5TJeTPWLilzuYOEb7UzFl2RQwwJrz/3DVthbY
	054QHM9ljn9J2q3odI5/b48M16Z6JhdpQfBbhztLg8amwJQSs7genM3tQe8VbZMYfk0OM2akIpL
	dTFrS+SrFlcEf7MVS/24yXa6fgerIQe9wzSARtSDLSbzMoLdE6EfJzP1cM4dbZg==
X-Gm-Gg: ASbGnctARnDQoQNc6O3GT0FLlyfhtwWkeJhsLuXHKNjMCxjHjLqhHwVyPmfVulUdSZW
	n/9vmaT+ET9u/ONvakQuNAdvBbP50cUDR6E7WPO9DIvmqH9k18C4aUhH0GGEEaCv/IWlyd6D3G5
	PdF03PdPznNoocN/W/iSyTp3P0gnjvBNrKf6jsUpit890pDcducHZyRZH6pDYM5nDlqczL9jxSd
	r01brpU0egFozqrA1RT5pXfmyerxUME39zdfLQuwMC9fIHraGqZNlwnxTrEDUC4DTL+78iyluwC
	M1cszD7FWBtmK1/jh4sJX13OMQ2oXANcaFFXZDFU5Xh/sA==
X-Received: by 2002:a05:6000:1846:b0:392:bf8:fc96 with SMTP id ffacd0b85a97d-3971ddd5714mr1439405f8f.4.1741944478426;
        Fri, 14 Mar 2025 02:27:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSZopK7VodYGavJXVWlDpju0bgDr38GUC5squ/pcPs+slUfrLvt93Hpt7yU6EFnjFbYLAnfw==
X-Received: by 2002:a05:6000:1846:b0:392:bf8:fc96 with SMTP id ffacd0b85a97d-3971ddd5714mr1439386f8f.4.1741944478015;
        Fri, 14 Mar 2025 02:27:58 -0700 (PDT)
Received: from [192.168.88.253] (146-241-24-221.dyn.eolo.it. [146.241.24.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe15488sm11754075e9.16.2025.03.14.02.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 02:27:57 -0700 (PDT)
Message-ID: <0a205f79-b0b5-4cd6-b237-3c61b61bc806@redhat.com>
Date: Fri, 14 Mar 2025 10:27:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: drv-net: fix merge conflicts
 resolution
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250314-net-next-drv-net-ping-fix-merge-v1-1-0d5c19daf707@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250314-net-next-drv-net-ping-fix-merge-v1-1-0d5c19daf707@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 9:35 AM, Matthieu Baerts (NGI0) wrote:
> After the recent merge between net-next and net, I got some conflicts on
> my side because the merge resolution was different from Stephen's one
> [1] I applied on my side in the MPTCP tree.
> 
> It looks like the code that is now in net-next is using the old way to
> retrieve the local and remote addresses. This patch is now using the new
> way, like what was in Stephen's email [1].
> 
> Also, in get_interface_info(), there were no conflicts in this area,
> because that was new code from 'net', but a small adaptation was needed
> there as well to get the remote address.
> 
> Fixes: 941defcea7e1 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> Link: https://lore.kernel.org/20250311115758.17a1d414@canb.auug.org.au [1]
> Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/ping.py | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
> index 7a1026a073681d159202015fc6945e91368863fe..79f07e0510ecc14d3bc2716e14f49f9381bb919f 100755
> --- a/tools/testing/selftests/drivers/net/ping.py
> +++ b/tools/testing/selftests/drivers/net/ping.py
> @@ -15,18 +15,18 @@ no_sleep=False
>  def _test_v4(cfg) -> None:
>      cfg.require_ipver("4")
>  
> -    cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
> -    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.remote_v4}")
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
> +    cmd("ping -c 1 -W0.5 " + cfg.remote_addr_v["4"])
> +    cmd("ping -c 1 -W0.5 " + cfg.addr_v["4"], host=cfg.remote)
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.remote_addr_v["4"])
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.addr_v["4"], host=cfg.remote)
>  
>  def _test_v6(cfg) -> None:
>      cfg.require_ipver("6")
>  
> -    cmd(f"ping -c 1 -W5 {cfg.remote_v6}")
> -    cmd(f"ping -c 1 -W5 {cfg.v6}", host=cfg.remote)
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.remote_v6}")
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
> +    cmd("ping -c 1 -W5 " + cfg.remote_addr_v["6"])
> +    cmd("ping -c 1 -W5 " + cfg.addr_v["6"], host=cfg.remote)
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.remote_addr_v["6"])
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.addr_v["6"], host=cfg.remote)
>  
>  def _test_tcp(cfg) -> None:
>      cfg.require_cmd("socat", remote=True)
> @@ -120,7 +120,7 @@ def get_interface_info(cfg) -> None:
>      global remote_ifname
>      global no_sleep
>  
> -    remote_info = cmd(f"ip -4 -o addr show to {cfg.remote_v4} | awk '{{print $2}}'", shell=True, host=cfg.remote).stdout
> +    remote_info = cmd(f"ip -4 -o addr show to {cfg.remote_addr_v['4']} | awk '{{print $2}}'", shell=True, host=cfg.remote).stdout
>      remote_ifname = remote_info.rstrip('\n')
>      if remote_ifname == "":
>          raise KsftFailEx('Can not get remote interface')

Thanks for the very quick turnaround!

It really solves the mess I did.

Exceptionally applying (well) before the 24h grace period to keep the
tree sane.

Thanks!

Paolo


