Return-Path: <linux-kernel+bounces-298812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE9F95CBC5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1FD1F24E11
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BBD18787D;
	Fri, 23 Aug 2024 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LVKUqzQ4"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4E17E01E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414146; cv=none; b=ks2wjOaVTEAUs7Iwvnowcy5wGC5blW2oHyu3wiWpOlq4ytFgJ68V5tr/6ZX8HuovCLOKbR+FnpG9JQ9BkO+ZgofWGPbsfXermQvz2XyD1iH9pQx+m23ByiowC0wkcF8OLn86L8vSISfB5rNMsLCk2aAWiPxM6wr+07gEvePhP6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414146; c=relaxed/simple;
	bh=OAw1ctritTsq/dMDRD2dD5NaMmegvf7DkNQKeVfjH38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXxRSDsaPc7xcpiZwt7mVeQhjxgtIO8TkMojJL3s+Bqhd53SOSpE0ft0hDWIyH8ibjBWDUClBy853zFAfsicazAa7zyteumotG82z37QqKPG7tFlHNueSX2sibrKRdjTQlpGlTLySDWLUzpHPFwcqqkCBg3MYehVD9a2Q//e3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LVKUqzQ4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7ab5fc975dso216972966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 04:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724414142; x=1725018942; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D4BFrh763eCa6FHGzYT0flqYQBNlmub8RNPp8zn1r7E=;
        b=LVKUqzQ4KGjvtvMrZr6glQbvAJFLUHeiMGrh0p6D9laRZsSXN++7NZra/tEZqakd2H
         6Duc2PYSO3gVbafOSsvtYv1QaPWzjo8kK0yPEXoUcf8A+idMIoFFRcqG/lueIeCSQcrj
         JqfrxwJX6kMV7borr0aV4T3lvrD1Yiox/W6L16wrONrav8IleEzMZ/x4QRJsKe1DBFbD
         TtevtnT6e45GrDq84FCiaW+FKzh6bKccbaT/P9mFnanHb/D66vKwHkQf9YVK8k5q5Xh9
         9Gi0oC0abw3/15YxNAxtuzNsb+Gtoj1mZ2UK3mjAGDSqZyipz35R8RmHQ8Sy/MdqdwaV
         rg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414142; x=1725018942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4BFrh763eCa6FHGzYT0flqYQBNlmub8RNPp8zn1r7E=;
        b=rVuSaeVuwjRRH2pAEWOAu1zNoBd4zl7Q5esdourjiVW6/8rmv8vAEQu0uQPjt+WIod
         Do0JgrnIYPHToZHIxGLCoavagRiT2n1DQ7uP238Ie8NYqvFeXmoEpLRUR6/ZDlnoqQRS
         Bh3ZRNa2yx1XKddponDQ59tDwHOVbKMnZ0uBPoeglJ0eH0yp6jifMsrBPdN68zxJlS2S
         GSHbUbqM4RLF10x3+nq34eOnc9vqW1E0YGLKLYugJpzx/rRpQ155tS724SZww64COVgd
         KlqgTKILyF8GSPL1sMWfjWBqa0aW6hko4NPACgKRKtExfAaaH+4E32uPZgozFILdnQ4r
         EsEg==
X-Forwarded-Encrypted: i=1; AJvYcCUWfwBbBPPhPvPTnV5Zfpjvu3L3JOgfr9QYvVvThcsk+KjAV6ZTvLdhgMSd5b+xBiBMPPD0eCoAdeSN22E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj660CVGbUeaBViX+kF40hVJaYDgx8PtRO+iUVny4ETQHMPOXc
	v3ZFR/u6fjtmAr+c2brTfRY0ON/aj8f87w5KdtHLdnKLTtYJSzaYz4ueeK2vQgk=
X-Google-Smtp-Source: AGHT+IHc/MhbYWOLkuVUYhr6jE4YNr3rrbrwk4qzS4Q0NsvUyW8HecvlKHYggdIaUYJD+LQvJaCBAw==
X-Received: by 2002:a17:906:d54c:b0:a86:9ac9:f3fa with SMTP id a640c23a62f3a-a86a54aa691mr169687166b.50.1724414141884;
        Fri, 23 Aug 2024 04:55:41 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f47d1dfsm252646566b.149.2024.08.23.04.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 04:55:41 -0700 (PDT)
Date: Fri, 23 Aug 2024 13:55:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, bigeasy@linutronix.de,
	lorenzo@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf-next v2] net: Don't allow to attach xdp if bond slave
 device's upper already has a program
Message-ID: <Zsh4vPAPBKdRUq8H@nanopsycho.orion>
References: <20240823084204.67812-1-zhoufeng.zf@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823084204.67812-1-zhoufeng.zf@bytedance.com>

Fri, Aug 23, 2024 at 10:42:04AM CEST, zhoufeng.zf@bytedance.com wrote:
>From: Feng Zhou <zhoufeng.zf@bytedance.com>
>
>Cannot attach when an upper device already has a program, This
>restriction is only for bond's slave devices or team port, and
>should not be accidentally injured for devices like eth0 and vxlan0.

What if I attach xdp program to solo netdev and then I enslave it
to bond/team netdev that already has xdp program attached?
What prevents me from doing that?


>
>Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>---
>Changelog:
>v1->v2: Addressed comments from Paolo Abeni, Jiri Pirko
>- Use "netif_is_lag_port" relace of "netif_is_bond_slave"
>Details in here:
>https://lore.kernel.org/netdev/3bf84d23-a561-47ae-84a4-e99488fc762b@bytedance.com/T/
>
> net/core/dev.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>
>diff --git a/net/core/dev.c b/net/core/dev.c
>index f66e61407883..49144e62172e 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -9502,10 +9502,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
> 	}
> 
> 	/* don't allow if an upper device already has a program */
>-	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>-		if (dev_xdp_prog_count(upper) > 0) {
>-			NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>-			return -EEXIST;
>+	if (netif_is_lag_port(dev)) {
>+		netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>+			if (dev_xdp_prog_count(upper) > 0) {
>+				NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>+				return -EEXIST;
>+			}
> 		}
> 	}
> 
>-- 
>2.30.2
>

