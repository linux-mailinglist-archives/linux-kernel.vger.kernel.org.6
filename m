Return-Path: <linux-kernel+bounces-441393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 896839ECDB5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3957285833
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90215236909;
	Wed, 11 Dec 2024 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="omDj3KJs"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5EE2336AF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925223; cv=none; b=n73sB5TwTpXaEgfpeg9RDw8kdS+3t6LYqtEMWf3wwpMwuw6av090sTDPBEevTZVilD2js851ViCyKRwdpA/Ykims6zHKfcuKdz1vX9fD2vCwKpDY2fNbR3NtMlMV1VvpdSjbtkBr3AZ4Pfrw7EATB2YveX1CK0z1gL+EtUBKiKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925223; c=relaxed/simple;
	bh=1ler+6t5wwhzmcNaLGwLWs8a2MX4ASG3Zvx3gT94VPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxbVi/B2HV+qJZWIrHa+6nLa3WgjHe4XeLdAzSoxl3HGocgUbRMOtOs6AGHPNgZRZz4UhK7gu5FQDzNy+5bjvhQB0fKGvBdo6uV7xBh9cFha3vi4zuljXDiu1GBry9blLyTQlFNp5A71zf+VfWFvRu5ychxknhibgkNHKZuV3GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=omDj3KJs; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3003e203acaso38137491fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733925218; x=1734530018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyglwL7lcLajD1vfvAC6TyqBHbq3YqYRZog/vZd+lPo=;
        b=omDj3KJsPkdP7UDkEBkr8I8BmUFjLlncQnR8U1KHRmWs4eX2Od9WNA0Ge1slgLs74D
         hYp6a4U1CyacZbInWvPD/TL56ag2IN1BQUOKGZ24bAQo1knFloHJGpw6RLyKLgMI/Ich
         FQ/eIr5U5m601YqwpLL3O61FD+9kURKiEawOMu3v9ORmtUW1sFkB3D9mopTziG+ajVix
         8e0RXBaq3HeM/bK2ndvdwgZ4lgGxZ7oVSqCK3Y6ZlazYDPlzbcUJuk9BnvualA6K12vy
         36remNoOn6ih/pluAhyQBzIt1XF6dN0GBvAskyEvdi7SBuoKVEa+r0ga5WUGsgSibr6l
         nCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733925218; x=1734530018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyglwL7lcLajD1vfvAC6TyqBHbq3YqYRZog/vZd+lPo=;
        b=KPRIz0rfxHc6axtJgPiK5F8kRKrocuyvFXpfiSe9m7zQpGMA+r9emhNTREHbQqn6lG
         z0BOflZfHfgIIh5oCgqJ0lZcgb33kZHzvxriprU4p7WgT7okEqCdCDrm4VW5ivUNRXCm
         W10Pxz3gt4Z8R0nDFSAam1bhF15xQoJSVOE9E9QfLUy9BFQI45HSZbikn1GNEfGX3kcY
         DX5zISw4uNU8oceusGGrfLKo9pHbqzEwFRBEYa6GSDpAeJ5jQxsDrisc2GjNyC/kSExJ
         dBlQbC3i3+HzjMsMMVioGB0Xm/VSeTV7nAGGBwDR5FG/TH6nd1zldZ/WB1Eo32J+hv28
         sstA==
X-Forwarded-Encrypted: i=1; AJvYcCUg7WoDeBEndpJAirsySIiDLLTPkypGfdNo1hQnXQ7mF5BVK7jpTi7ttdnkH2SLhyRzn7HL/1Kqe/kPkFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJDkAkengNa9wKM3OK6SLbmp2zDAA95JYbgUsx/JtDZgUtEo4r
	ajMZoDJ+olRmNt4iPyUwjbhJQCpMa/SXn2XlsT/rF6CMyGIVTfuXn+ybwSsMY3n/xu/BFwtTkgg
	T8euLgNiQq3vCwi9TIHCPYztpRSUJHIpv8g0YkQ==
X-Gm-Gg: ASbGncuyPLr7j/8zj3K8eqy05hskl5PLQq4AoG9Kw20mjDTHh/YNfRoUiMvf3d4l4uu
	g9NECbI1NinmVy/rNa4OZ5/Qft9MLJDHn7lyBHAuMGZho6trIDnph4qwqKitB0kBuqkY=
X-Google-Smtp-Source: AGHT+IGPGpFba0wsi4op1Gj+i5/QGCDpVBGPrx3rA3uLS79Kse28wu78qqyJ+hwtxlmidsvWthwfkHUhBW/gtPRZ2IA=
X-Received: by 2002:a05:651c:1542:b0:300:33b1:f0d7 with SMTP id
 38308e7fff4ca-30240c9fc57mr9357831fa.5.1733925218339; Wed, 11 Dec 2024
 05:53:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1e0cf09d-406f-4b66-8ff5-25ddc2345e54@stanley.mountain>
In-Reply-To: <1e0cf09d-406f-4b66-8ff5-25ddc2345e54@stanley.mountain>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 11 Dec 2024 14:53:27 +0100
Message-ID: <CAMRc=McCc3G4D4rHVMfGBTdvi6z5Nbxqzg+k8iN11+vazffSnw@mail.gmail.com>
Subject: Re: [PATCH net] ipvs: Fix clamp() order in ip_vs_conn_init()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Julian Anastasov <ja@ssi.bg>, Simon Horman <horms@verge.net.au>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-kernel@vger.kernel.org, 
	David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:16=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> We recently added some build time asserts to detect incorrect calls to
> clamp and it detected this bug which breaks the build.  The variable
> in this clamp is "max_avail" and it should be the first argument.  The
> code currently is the equivalent to max =3D max(max_avail, max).
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYsT34UkGFKxus63H6UVpYi5GRZkezT9=
MRLfAbM3f6ke0g@mail.gmail.com/
> Fixes: 4f325e26277b ("ipvs: dynamically limit the connection hash table")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I've been trying to add stable CC's to my commits but I'm not sure the
> netdev policy on this.  Do you prefer to add them yourself?
>
>  net/netfilter/ipvs/ip_vs_conn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_c=
onn.c
> index 98d7dbe3d787..9f75ac801301 100644
> --- a/net/netfilter/ipvs/ip_vs_conn.c
> +++ b/net/netfilter/ipvs/ip_vs_conn.c
> @@ -1495,7 +1495,7 @@ int __init ip_vs_conn_init(void)
>         max_avail -=3D 2;         /* ~4 in hash row */
>         max_avail -=3D 1;         /* IPVS up to 1/2 of mem */
>         max_avail -=3D order_base_2(sizeof(struct ip_vs_conn));
> -       max =3D clamp(max, min, max_avail);
> +       max =3D clamp(max_avail, min, max);
>         ip_vs_conn_tab_bits =3D clamp_val(ip_vs_conn_tab_bits, min, max);
>         ip_vs_conn_tab_size =3D 1 << ip_vs_conn_tab_bits;
>         ip_vs_conn_tab_mask =3D ip_vs_conn_tab_size - 1;
> --
> 2.45.2
>

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

