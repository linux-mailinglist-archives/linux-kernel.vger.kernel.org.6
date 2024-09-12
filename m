Return-Path: <linux-kernel+bounces-327302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6270F9773B1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2645F2849FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5F91C2307;
	Thu, 12 Sep 2024 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vfs2330D"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314CC1BE851
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177147; cv=none; b=p8UYLRi9sHf0NZ29SC99eI1puuN9BXxJ3PbfxLpU6w2d8Oil6Rqb5H8XxtrGIByLxDQOBZJvY7OHswl2eODKpdgfGM8H7WLHZC73oGAe38NMfpgHVJ9C7QKEAtzFJY+6vsdTx4Xth/mLkjJfrcBKAAIjl/uyb/MnkgmzG3dEUO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177147; c=relaxed/simple;
	bh=4Z3y2ExjN+sfTTdyRG0DobCkSSROnQTal3/BbxZMT9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmIksZnFXA10Qlk+o/b8cu76oC5IVCfngafQ3gMd/9XvjBMPkKyW4lKxLM06JAC4QgoowK+AQrWRAAOnu6BfuocxFPaBjckZLLE7nCbsZByoToFS3+2sRsmlGVvHKVgd+mEk3fBhOWYXYO610b/kqYjLEvDBLKTgwXKWcuUTJns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vfs2330D; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-846c59979efso414061241.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726177145; x=1726781945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnUGUKViCW+3BbsFSQi1k9zreDMxoTLJCm+OUAY9KGo=;
        b=Vfs2330DNJLq5xxxuyFZxGs3WNFutnpK40tzMZWQmWVEW3SlXjEoNQY+83ncFFP8AL
         VtPIKa5W+jTlDZivm4/B01taHcY1psLA7U2zgECcxQlqDyODTD2Nt0N1JweEyDnfXeyu
         Du1prOVsF2+tpJevfSU3nXj9tJwO98i2Er+9mqXFNCieK2TWFB3kc4u3eMsbeBXdaafw
         nrrgVayxzf9c7Srfzdb4WX1FViw7Ic1a3lJPvui3PxtnOPi8nh5fkddMtCpAvMhFveTC
         RAqsXdPu7Tv5vkjxBWH9t7VRAiKw4d/PMuWi0+/2ylsNun4Ig8+7dadL7FmDKJ80Q1tE
         bDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726177145; x=1726781945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnUGUKViCW+3BbsFSQi1k9zreDMxoTLJCm+OUAY9KGo=;
        b=ePqfRjd6f+mg7hdPA+dRVhg2K66Ky0KIo4Un7BsyszFRfioHDZRqS4g1EH1SFP7KTV
         4J1iugJFTktqX2QfO32uO0KwwOwEFnM1f3cDyKfYlr+4QQOsG7RtJ24E0Nnq9YQc9HWN
         9upc/gthdGTd2pOo3wMrv+S7DWzRN4pihTb3cxEvYGeBxSVvF/7ppkuoZBCy/BnMOAKb
         TmcmoUk1MjH5HCdytBKQK5BcZ/yUiXcXH4sZNJPNjnftsqt9S/DNK9pvKbYIhWF9SDgl
         MqyXaAI2Nk2NNPpKN1X9QTWA6tfF7f22luoUF4dJ8NHEOQbDi60CwdIKfk2cBntwSwF9
         PNCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXagd8LcL3zBL3+iQifpUTfyY1Agt8InQzBENcspdMT9uQdQvWNrPPp3BkiR30OJT3ZWzgXRlrO6liKr9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3wW2KLUVk350Tq9Tv7oJ3++y0JWPyusObyQ5xv6HGXt1Q+/b3
	FiYDIqVcKyhRLmDC05FLnisvUzWbkTkLGFgJD1cKgnMByEJog+Tph90F7DKoliGHtJfJevdWTRo
	r44wtVwb5pEMbWaSB/NOn2b0Zl/vIIzoYeVPA
X-Google-Smtp-Source: AGHT+IE9lzQsVM3OtKM1DDO5bp6YhBv9ztTqMYR0Z4axeHZ0pxVhuPDcMiTJqM5GQZoQwIGD5+xxoKWGH0xp0FCEwsY=
X-Received: by 2002:a05:6102:3750:b0:494:3a01:e340 with SMTP id
 ada2fe7eead31-49d4147e662mr4516160137.6.1726177144959; Thu, 12 Sep 2024
 14:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912110119.2025503-1-suhui@nfschina.com>
In-Reply-To: <20240912110119.2025503-1-suhui@nfschina.com>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 12 Sep 2024 14:38:53 -0700
Message-ID: <CAFhGd8ruRrZM0Q2Z0UJdf98gKvtP64H2k08gvB_=97pWs4p8cA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tipc: avoid possible garbage value
To: Su Hui <suhui@nfschina.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, tuong.t.lien@dektech.com.au, 
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 12, 2024 at 4:01=E2=80=AFAM Su Hui <suhui@nfschina.com> wrote:
>
> Clang static checker (scan-build) warning:
> net/tipc/bcast.c:305:4:
> The expression is an uninitialized value. The computed value will also
> be garbage [core.uninitialized.Assign]
>   305 |                         (*cong_link_cnt)++;
>       |                         ^~~~~~~~~~~~~~~~~~
>
> tipc_rcast_xmit() will increase cong_link_cnt's value, but cong_link_cnt
> is uninitialized. Although it won't really cause a problem, it's better
> to fix it.

Agreed.

Reviewed-by: Justin Stitt <justinstitt@google.com>
>
> Fixes: dca4a17d24ee ("tipc: fix potential hanging after b/rcast changing"=
)
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  net/tipc/bcast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c
> index 593846d25214..a3699be6a634 100644
> --- a/net/tipc/bcast.c
> +++ b/net/tipc/bcast.c
> @@ -321,7 +321,7 @@ static int tipc_mcast_send_sync(struct net *net, stru=
ct sk_buff *skb,
>         struct tipc_msg *hdr, *_hdr;
>         struct sk_buff_head tmpq;
>         struct sk_buff *_skb;
> -       u16 cong_link_cnt;
> +       u16 cong_link_cnt =3D 0;
>         int rc =3D 0;
>
>         /* Is a cluster supporting with new capabilities ? */
> --
> 2.30.2
>

Thanks
Justin

