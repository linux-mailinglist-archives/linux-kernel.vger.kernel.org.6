Return-Path: <linux-kernel+bounces-359997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5D799935F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011672832FF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7721D0146;
	Thu, 10 Oct 2024 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="fvm1hmXw"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5B11CEAD8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590993; cv=none; b=X8UiD78QppvWCdwGgJYMb7kTqccfIlBdaCy8E9icjwXnNpg5InY+4XRGAs7/uaTZlonQ1dNqUyOPZLufiY3vn+KDckliCrnAx8IzAf0t4hM4CYaCaZJWb2zJniV/CnVboaasc1fPSetHTB7QWDx2lsE9+7edzOjjQNrl+sZWZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590993; c=relaxed/simple;
	bh=hfP8kIySYPoXGp3X3utwwBQMk8qm/KR8k9kaAp2Ign8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jp3UtBgAAJACWsxgENyKo5o0UrwjlepaELZdnAUySzSvybYKVZQ80nXH46T8bkqd+z2Q/LYkGEHcX6mJfU1LA+HXKIiD7hj2lhIad8p6PBtoEbHcsQp5SfYdND8bJTZ5WMlXlQmNYk0fv4HMSL+zdbo0Iu5JAGi6PEGIw/HOjmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=fvm1hmXw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d461162b8so817544f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1728590990; x=1729195790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfP8kIySYPoXGp3X3utwwBQMk8qm/KR8k9kaAp2Ign8=;
        b=fvm1hmXw6bUalnThjM0e5af94TvjIExG7S3vti0VzYleuEr5eM6nNQ3FpKImTvAYIM
         FDEhySG2BNeU8yDpxLuFxsfd9+Q4PjRdgEBXaVf9KDFP02eFnyNcARz654Tcg7Wquatp
         BlICzt0i5mIpFkNHPp077Pz9VSReFZYLiOsIoaGWXUDb8WkAghKYlBysWC+aphWYIJK/
         ZVYb7UeDU73niHRZ14eJ8D5lBIaGa7gHbt/+xJYbp32K65SZJ+20yUtHFN2bnHs1z2Gb
         jpBRhPEDWfRwgRXW20CeAuGwFgwf48OlOTxAwNRHPleSimv2hs6yXjXmClrj8CYqJg8c
         KJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728590990; x=1729195790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfP8kIySYPoXGp3X3utwwBQMk8qm/KR8k9kaAp2Ign8=;
        b=gwowUUnD1CVE2xaIxBaMQiJh1qT4xnVnJEBKXORXnRtqjXx/8rATJ1dzRAg1bXFc4Q
         vWFDJqgdcn2uUbebt79FNEkp5lloLMMLVOebGjdex/NR01bJBgGMxqu3y7rm3htg+/h7
         4XdToCOInXuapsB/8RsG/HjcRkm+KUV4FALV5Xw4bnxI3m7Hfa+CarbZNCiG1oe/Aovu
         ViZaBUS33ESA1qvjltjGvVqwc44CakqxvVoVHIHn91LQRaOgcLuro+t9VO8lB9xvOonl
         f0+sO2pg03L4G2eam46EQUOD/NTKY1vD5AcRhGRIzQSL7Lgsmn/ErCE+vT7elma19gkE
         ZYDA==
X-Forwarded-Encrypted: i=1; AJvYcCWCb0vAs6NatmTLSdtW6ADqBDlagy1EAC7QEo84ue1/3kpTYHWMhimnaffL3iXrH43JNNfZJjtuwYZcV68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGm+TeWsRIMJHpd26SmHEvnIutIzAQfc0ZYa0osnA+aOltTDeP
	EzqXDflObWHoqrYbbH8afAVSXTcrBhrOmbnPM17HP1X2nLDn8NRxnk7CdWlo0cKNt1GVRdHiNi2
	B
X-Google-Smtp-Source: AGHT+IHvYbcRjbuHgWljkcZYeI7PgKjgFCQUwV/nJm9bloQDOoNiOZTe1Ek1HHrlNApudatd2qiKag==
X-Received: by 2002:a5d:4389:0:b0:37d:5113:cdff with SMTP id ffacd0b85a97d-37d552967a0mr171577f8f.37.1728590990144;
        Thu, 10 Oct 2024 13:09:50 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf204f7sm57729835e9.2.2024.10.10.13.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 13:09:49 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Florian Westphal <fw@strlen.de>
Cc: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net, kadlec@netfilter.org, pablo@netfilter.org, rgb@redhat.com, paul@paul-moore.com, upstream+net@sigma-star.at, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH] netfilter: Record uid and gid in xt_AUDIT
Date: Thu, 10 Oct 2024 22:09:48 +0200
Message-ID: <5243306.KhUVIng19X@somecomputer>
In-Reply-To: <20241010134827.GC30424@breakpoint.cc>
References: <20241009203218.26329-1-richard@nod.at> <3048359.FXINqZMJnI@somecomputer> <20241010134827.GC30424@breakpoint.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Donnerstag, 10. Oktober 2024, 15:48:27 CEST schrieb Florian Westphal:
> Richard Weinberger <richard@sigma-star.at> wrote:
> > Am Mittwoch, 9. Oktober 2024, 23:33:45 CEST schrieb Florian Westphal:
> > > There is no need to follow ->file backpointer anymore, see
> > > 6acc5c2910689fc6ee181bf63085c5efff6a42bd and
> > > 86741ec25462e4c8cdce6df2f41ead05568c7d5e,
> > > "net: core: Add a UID field to struct sock.".
> >=20
> > Oh, neat!

I gave sock_net_uid() a try, but I kinda fail.

Maybe I have wrong expectations.
e.g. I expected that sock_net_uid() will return 1000 when
uid 1000 does something like: unshare -Umr followed by a veth connection
to the host (initial user/net namespace).
Shouldn't on the host side a forwarded skb have a ->dev that belongs uid
1000's net namespace?

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y



