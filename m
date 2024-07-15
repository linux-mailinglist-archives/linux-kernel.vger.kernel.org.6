Return-Path: <linux-kernel+bounces-252162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ABB930F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B173F1C2131F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C87D184113;
	Mon, 15 Jul 2024 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="EFbRq/xn"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EF8146A6F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030671; cv=none; b=Vx9KXp86WS2WdHZFm1VoUZXi56bhINntktp4w43cD/0V35EtYmpX/G0radIjBIK6KldbeWmWRImGVFx++Xm5HDdPfOGr7j5OSgu78gyO6GuovWfDol3YJOmh2jjJFfJ8MIAhi/I7IstdpqlLRRgisLY9n1RkUQkv08jLlsHs5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030671; c=relaxed/simple;
	bh=pfgmG4zZrrqRhVkanoP0xDLU9g9d+TR1rmNzguVilz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByC8mWRIyL1GdcfbjBatczH8Imi6dOOmKHyheD0hT7GwK1WaMKwhaex+M+cuOKyS2BzqJS6W2FHoi/7hBIC4RU7w/heWG8/JoW/SpWUqBot/IdJRFC3AIlDH28CRjS74ixWQ44Up/XvdRnWnAcDE3GWLY9ImaYzS8lqk3eMlXQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=EFbRq/xn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so5336797a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1721030668; x=1721635468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YiwcX9F4LtfC80GM31isd5gHfQz+XWLWe2fZmeMxBV0=;
        b=EFbRq/xnbNG8ZVVoiMu5zOXmxigOdgnqGXmn6rkhtv322S2CKqLuoJorny+DqsUL3e
         GSPhYW3Ks0ONr+wmmHnnzzHpfqbtHp2LWxWrJjLME9qurUVGm6+lmXVcwSr5XMfs3cbO
         SfprEqnO5QGFsEtiYBVenhsjEHFStxi2AiADt2qA3QWnBDaC9T97E8CrhU5rRf5JO2T7
         THjAvJ32DMq4ZWbnb0h2GLXm45KfFMwTF6iDc2bIXpeZibtkFJC26HLL2OSj5yhVJ69M
         R3h/C0NV4HJ5P0tmYk4h2w8T1HYEBRMagcc+PklPZFAot168LQlXBYejSp/fqx7BmxmM
         obIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721030668; x=1721635468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YiwcX9F4LtfC80GM31isd5gHfQz+XWLWe2fZmeMxBV0=;
        b=wLeM0aKv0byXbm8CA/8K69VUHijCWYl2PhF0UYGMQgwAJCzi+Z7RDUjSkePwKqGM+N
         Yds8wo9Ji/DuH5n9BHuOqteE/gVCAwXL9UoikXaAa7gU0Ajht5PQzaYEiI9c7dEiVGzZ
         8vamoMuBwKqqKJMC+ZmC992sYzjthGrMAznXjK3yVjpqAxsfNh7fwqBWV0U2iTR5pfSu
         5wD9y9fc7wbn4k1I4QzCyNkdRNBm7w8aTcisOjs8GW6vD7A5DjSf6/m8EIYc7JjphcAy
         yAEeXrgOgDdcoHKiiSu6rHUoSqkrmQ83pWFMNBHI7kfSbRBgGGwekVKrP8kk/2td+g23
         ugnw==
X-Forwarded-Encrypted: i=1; AJvYcCUgkNAK3w6CL2z4Xv9x9WO9ZvcqYAHBIPkEULHJhejgUGGHmaSOog7SsQaF3Nf/8ky2gm4RF17sTAxR3bW7SFmDHSQasaMhzvwuPtWa
X-Gm-Message-State: AOJu0YxkaH0nve+DZKx7j9Bdvd58cverXliFItBOn28zLwSkBidJmXF+
	EJnj/lYFcGcHaoHKe7Weif9UZwjMQu1HUiPqoJ9gpf+VBLdHvd6i0LdLdRxctC0=
X-Google-Smtp-Source: AGHT+IGfLMp93Lvm4ZRrsDZSB1JnFiH19NTLePtvoM//z2ksSs/I+r4ZV/EUEPuFeQJ8h0publy2Mw==
X-Received: by 2002:a05:6402:350b:b0:58f:ebaa:64bf with SMTP id 4fb4d7f45d1cf-594ba9975bamr13862271a12.2.1721030668208;
        Mon, 15 Jul 2024 01:04:28 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f621c3sm3070229a12.89.2024.07.15.01.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 01:04:27 -0700 (PDT)
Message-ID: <7476d4f9-3a45-4586-99c5-9e878d4e02ac@blackwall.org>
Date: Mon, 15 Jul 2024 11:04:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: remove unnecessary cast from netdev_priv()
To: Chen Ni <nichen@iscas.ac.cn>, roopa@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240715024457.3743560-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240715024457.3743560-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2024 05:44, Chen Ni wrote:
> Remove unnecessary cast of void * returned by netdev_priv().
> 
> Fixes: 928990631327 ("net: bridge: add notifications for the bridge dev on vlan change")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  net/bridge/br_netlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
This is not a fix, the code isn't broken and it doesn't violate
anything.

Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>


