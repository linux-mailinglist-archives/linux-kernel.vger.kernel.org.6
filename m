Return-Path: <linux-kernel+bounces-449053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233FE9F491E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C6C161D70
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460F61E22FB;
	Tue, 17 Dec 2024 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="dZsHYjmk"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195AF1DFE0B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432191; cv=none; b=Uj/Cb7lNJ2aY6miyt2HKHovKlibgBf0jD2//rJRlXoQ2DaXCop4zh5gOeagi6UJV2+6n7qUX9dnh9SHMoDUK+7aq0j1lgacdES7P4nK0cp8arTKIPhfK0vCLUZBulJnJnTaoM5e9WqrFd4AuvoxOadYilJy1CtQB1AdOM+I6OCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432191; c=relaxed/simple;
	bh=y6kN0ytC+JEAm663I+e3ce52E/uTgwxjwdVw6gidIJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YW1ZoRD6TShQggTDz/PZebcKCJk+QATxOJMgVeEicnTaARo/g+Tjux5qA8GsrJzjZZTc5rZ2Tug35IyvrwXLtnMkVRBc4NJjs1frWE9EGOc4O608xX/r0u7fxvnj6ukObXcU6lUgsenJQoXjO86nE9tCKzuAp9p8wFd1PGQRUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=dZsHYjmk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso34024795e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734432188; x=1735036988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lPpgSVaAv355PXrM8WEJ5CO/JUa9i24YlHdFUS1Mag=;
        b=dZsHYjmkhvWBVsm2tNMZTYJ6fifUvbeljbA9rzuGPR4hxzY9sTa1bgk/BveyCJn/Bj
         010mgKQbGqWAeVoFnqoxUE8FX0smvn9wMVd8zLeNMV24ZhSGjjzHDVtstCR8LNh+dOQt
         RQKEHwEtPbCHTIFgMWzJwak1Sj1f5c71F8Fz8X2nUb5qtVihBlaJQ/dkqeAbhgbBxC2e
         bDL6ufuTtwJ0M7OtKhA6d7ncZ1Tf0zrYh35377rPYi/q5NqCA73aCAc2pj51VmqrV2KO
         YO6CUv3jdCn+/5p/brlrKV8WwhevbP9z6V3pTnZU0dVjSuF16UY6u3A3ZdfpCfxcO2+o
         GDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734432188; x=1735036988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lPpgSVaAv355PXrM8WEJ5CO/JUa9i24YlHdFUS1Mag=;
        b=Mpw44pecqXcDDN9DyTrMDb5C/yM10gS4nHMTUa8ZUNnMNFyWC2vAmFR7RpXc+zLdsp
         pn/IzM8UsDq2G+NJc4k1y3eOBH6AdIAVBULMq83pF1amSoMLi7WPkB6jKEZAm9jaS/o6
         KS5v7UDnWnzGM/iuyOIf6OoVR1zFYAkbiajLwQ14QSe/EBaTR4heIN8ApoG83phKMfLd
         rODufJ3xTxsbHTynWysdBNkEAhWfbpcgdTnWHbLvvTQnQxc5RcQFKjI3n7Gq3sK4/7TW
         R06//jgo3oTM4z0J0uEeG2eNe76v+ZFiVSMFK6pSHrbanxRHnPQTuMdEfbtKcQwdi/RI
         L3hw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ6LBckUeCGPQCj4TFmlZCLQLXEH58KuBpshgDsFL9CKC99+5ErPD+qTb3WSngHrAul3CU9Vb+/2CaBmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+2QWtxmPDhqZBMGgskNmnDKGsLiIh5LV+aYHqkL1mp7icQVm
	U5FHlMPgfbG8ORR2Z4Bu9aDPWXS/VJ71Q4P7cJPS6Qlb7uplFNw1LQ57H6ZhYe4=
X-Gm-Gg: ASbGncs48Ad9hq9ZVxfprFomZincpzUoSoHpa3YdyaqAGRw2o+FcreO9n4hkOJ/56Sd
	/l4SjahUPDOhJhBDZ828ZD9+5Kzx+jV7BGVEhNJ9QvkiHtwzFD9/DVwHnOStQygRwBEU1YCEr0c
	+NQeWioXpkEMvkugZ1Roa3pdOg2LLOboiYBru6IGXWsJV55Dsz6AIiaaTJPAuYl+g6fMIgKkfpA
	J5ce55TcUqoS1xWYyB6OEqZrv1ruopsQZKU//MqSxEzkWHMfMjVYDEThhUjXthMKLfYwZ9Do2Ha
	unkRtA2zNVXf
X-Google-Smtp-Source: AGHT+IE+WugOposmvo/jcHeaw0Ch/ihxlIzSWqzgKieKmOo/fttsPn7O0uxSSG2XNkVbg/PrQmJctQ==
X-Received: by 2002:a05:600c:8715:b0:434:f270:a513 with SMTP id 5b1f17b1804b1-4362aaa8b9fmr140737975e9.29.1734432188304;
        Tue, 17 Dec 2024 02:43:08 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706595sm170469495e9.33.2024.12.17.02.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 02:43:07 -0800 (PST)
Message-ID: <66adcd4a-d4ae-4dc6-a706-2761efd5084a@blackwall.org>
Date: Tue, 17 Dec 2024 12:43:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: bridge: constify 'struct bin_attribute'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Kalle Valo <kvalo@kernel.org>,
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shahed Shaikh <shshaikh@marvell.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
 <20241216-sysfs-const-bin_attr-net-v1-1-ec460b91f274@weissschuh.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241216-sysfs-const-bin_attr-net-v1-1-ec460b91f274@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/16/24 13:30, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  net/bridge/br_sysfs_br.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index ea733542244c7e7feeffef3c993404529ba88559..c1176a5e02c43ce32cb3dc152e9aa08eb535a419 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -1002,7 +1002,7 @@ static const struct attribute_group bridge_group = {
>   * Returns the number of bytes read.
>   */
>  static ssize_t brforward_read(struct file *filp, struct kobject *kobj,
> -			      struct bin_attribute *bin_attr,
> +			      const struct bin_attribute *bin_attr,
>  			      char *buf, loff_t off, size_t count)
>  {
>  	struct device *dev = kobj_to_dev(kobj);
> @@ -1023,10 +1023,10 @@ static ssize_t brforward_read(struct file *filp, struct kobject *kobj,
>  	return n;
>  }
>  
> -static struct bin_attribute bridge_forward = {
> +static const struct bin_attribute bridge_forward = {
>  	.attr = { .name = SYSFS_BRIDGE_FDB,
>  		  .mode = 0444, },
> -	.read = brforward_read,
> +	.read_new = brforward_read,
>  };
>  
>  /*
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


