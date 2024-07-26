Return-Path: <linux-kernel+bounces-262783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF88C93CCAE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 04:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D04E1C21A74
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63FB1BC39;
	Fri, 26 Jul 2024 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqsFsRbZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24C1C287
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721960496; cv=none; b=TZ1nl+8euFVnnu4qP0N98/4vs4Uc8qlrYr/Dqb8S8wTPUuIcFG8VSUbVGdEjK3pdb1+w3WjY2PJyT0gDD/3j1A1o5+UuH8KbI2S8xpVnVsGihCr5EIrveZmN251Hp6WZebptoKHJ14yu2K+wvCHyrRlGHdcvWItm++qKtZWtCmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721960496; c=relaxed/simple;
	bh=9pPNleW41JbaEoT5d7ZdvPpk9ik8QLyyrEts7kTbW5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsSgkr5V/Yr/KRuhgpnQF3My4hIs7hhPYRfn44ObPr54P3+YtRgXiloa+GhpN5wjUGT3A9saB2j8HJlwOhBj8zMrrF8BUiqSHvYbx3tAeNUpw7zWc55bgTR97DhvMjqIaZi91aa87YkhiX2ssuEov0QZUhvuNV9BX93rEmDue2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqsFsRbZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721960492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cD9M07/PagDrXP2ta/1b1JQMk5bjY/PWuJ+NKQsHVrI=;
	b=OqsFsRbZ4TUmoa5MXkurESv9YPA54iPBk5i1jHqzr5+Lk3QnaeyMywcCkHwAYUEaeUgLVx
	EdmxxbBjps3Wxt5XKer7aFdfcPLG0hW6N5SWNAmqXfgl9ZI4z2d5DbxMrN+h26NP9dv/vl
	XLxAPfHY4Q6sRiRqM9nu0ikbvKuM3Tk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-jffx_qqsNgSntPiyBvdaDg-1; Thu, 25 Jul 2024 22:21:29 -0400
X-MC-Unique: jffx_qqsNgSntPiyBvdaDg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb696be198so569614a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721960488; x=1722565288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cD9M07/PagDrXP2ta/1b1JQMk5bjY/PWuJ+NKQsHVrI=;
        b=DlJg72wooIwsDe86YxMSP+01VzcgdWnHVOpQ0UmHlHfj5UzGE0tcKXCwl2VGmNmLhD
         w3fCbY6K40uODNFaANcaaLdhMuR/aMT4tMVVuBMbPyKI/ne6JgRd99CX4qTe5ADs7+nR
         b3tx++iSlJy6NWHN3ddDkEIoIelXYp4T3j23sQiBuBcU03SzSCiqDSjYj2xIHVPH8evR
         zTqpd5NJLxGt13ZzCx6mcs61xtho1s6ZD1nCzqPknk3uD2jX6yPd/ixnAwr4c5GFjc/n
         Qc9F5Jtzc0rmd1EtnJop1E/UtdZG0J/sL2uzI5nPMrFD5h6IHQpZo+BLQKoygFnhVd+K
         M6jg==
X-Forwarded-Encrypted: i=1; AJvYcCUfzlPPSedycYF3lxtl7uuRq5kQdDV0i6cx15oLJnNWyoCAr1iwC5nEPOXKgO9C5yEU0QhNSCx0Ftafmje2+shAU4Ma3r9f/9xm4RYj
X-Gm-Message-State: AOJu0YyyBcP5GvNvENVi3Rr/Vsgw/I4aT/99VjNFGpUsPuMA6WcgThy9
	1SUd72tt12As38wUHthfVjkc6/sXajXvulh2+xViny6/zo0X5DrAQWPbdj+jrYd9ieX3cqNBmpl
	vEQhB3DviCi8XY+rHeOCP2N2sia6OLoTmb819eZ4UNwNhDRwZysC/jcIqJGluFE39D0heFyR/mW
	l3YquHsNpL/No5wrEOScRQzyy0N9OOfIpI+I3w
X-Received: by 2002:a17:90a:e50e:b0:2c4:aae7:e27 with SMTP id 98e67ed59e1d1-2cf2ea0f4e6mr4277349a91.23.1721960488160;
        Thu, 25 Jul 2024 19:21:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0mJhruNRcMlENqGhBASXD6O3mnsHAgEZxCXB60xz9QTVgQMj2Rq6goVxIFQ40Heya4tJ4Y2caqJ4tY1oGqOI=
X-Received: by 2002:a17:90a:e50e:b0:2c4:aae7:e27 with SMTP id
 98e67ed59e1d1-2cf2ea0f4e6mr4277333a91.23.1721960487690; Thu, 25 Jul 2024
 19:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009d1d0a061d91b803@google.com> <20240725214049.2439-1-aha310510@gmail.com>
In-Reply-To: <20240725214049.2439-1-aha310510@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Jul 2024 10:21:16 +0800
Message-ID: <CACGkMEv2DZhp71-QdckH+9ycerdNd7+F5vFyq3g=qquEsm9rHw@mail.gmail.com>
Subject: Re: [PATCH net] tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()
To: Jeongjun Park <aha310510@gmail.com>
Cc: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	willemdebruijn.kernel@gmail.com, bigeasy@linutronix.de, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 5:41=E2=80=AFAM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> There are cases where do_xdp_generic returns bpf_net_context without
> clearing it. This causes various memory corruptions, so the missing
> bpf_net_ctx_clear must be added.
>
> Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com
> Fixes: fecef4cd42c6 ("tun: Assign missing bpf_net_context.")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

(Looks like the do_xdp_generic() needs some tweak for example we can
merge the two paths for XDP_DROP at least).

Thanks

> ---
>  net/core/dev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 6ea1d20676fb..751d9b70e6ad 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5150,6 +5150,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struc=
t sk_buff **pskb)
>                         bpf_net_ctx_clear(bpf_net_ctx);
>                         return XDP_DROP;
>                 }
> +               bpf_net_ctx_clear(bpf_net_ctx);
>         }
>         return XDP_PASS;
>  out_redir:
> --
>


