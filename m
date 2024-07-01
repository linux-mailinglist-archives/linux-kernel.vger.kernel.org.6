Return-Path: <linux-kernel+bounces-236785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F94991E705
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F2D1C2218C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E861A16EB7E;
	Mon,  1 Jul 2024 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chrisli-org.20230601.gappssmtp.com header.i=@chrisli-org.20230601.gappssmtp.com header.b="2Gz+YDoq"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939BA16EB71
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856735; cv=none; b=Jo5f7yWWTdrG1jlMpnbAC25h/UhGKAtuz9UjTOnFJjFD9p9PwBhUVNhodv66WvNk4mfSjGR/A7UUuabTPX/krBrtVGZ/ieVHCAbF0xAgNrjgrdkS156iD70l5aaHfXvGSGOI5ZSjv9ZPOn27joMIpBR6O4cCn/Gpqab1hbCuSMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856735; c=relaxed/simple;
	bh=9uA3Y+CKDQgcpbSj76MBdoSDbtnzadrzu8XP5nWZpXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3FumIaqIZ2UNSoS4b8h9sNQNxqE4Rq5F7kYKtFS1wbiMt83/HapkICYON1cYjI6iMr2qwMh0oQbagnehVRf9OS2rJmc1LcpAYzZN/6eArAkLBcI/VziuLVYOqTcz3/Aotu2R2BH4N3qx2J8gWEP70jaRZU4GEw0lvnxzN1py/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; dkim=pass (2048-bit key) header.d=chrisli-org.20230601.gappssmtp.com header.i=@chrisli-org.20230601.gappssmtp.com header.b=2Gz+YDoq; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-64d408a5d01so15764837b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisli-org.20230601.gappssmtp.com; s=20230601; t=1719856732; x=1720461532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9StUTNhxwCy/pDRuf8/7L71MaUer3QRVVlv9U1S2xNU=;
        b=2Gz+YDoq8m+XuStUY2eBBWXEkygpgcoGU2zaHRO0s1ZzVRkxQOlkAan0OHJDqHogjS
         0m6FnU5S0JS8QOIYApJ4C33xE8RGekvjV7OqU7l9p2bhvEMFDXriuGJtZ886QblgtvD2
         /92drCS8hfGO2hvwvr4bl2yJaOeqQ3ZMPuMwdeFF2NZPtTM1D3EUURc6aioWKpQVYR8t
         eq4UrNa7ktkiyr6IKgVr+F+qLasae9KROKBVzxQjBvLI5dljwXRfgohjAs27flvJGPgL
         aBtmHaVhNhZMwseqFvpuJxoKWYabnzHJuQJfdF+d5P0BoFv+XHUUdclP76bMkYirdwdP
         AESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719856732; x=1720461532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9StUTNhxwCy/pDRuf8/7L71MaUer3QRVVlv9U1S2xNU=;
        b=ZjQaCrt/hhCERbNXrd7AqoDOdwrIdOdtS96N2lD36IQ1A3pdqBtYL4wmyVTc2XcyMo
         nLz+c8WgTesc7lC3qs3zaVAWXl82mktFbKJzSgMlm/5i3/OPEGODiRy8apLNJeEB4qd9
         F8imtj+gywiOSQQZ8ub5RCti0pCe72cKQzWXTfjDr8LHAV5KdaqVdsykUdL8z59Qj+W8
         VRq2fLdNbDEmtwVdHgAsFA36r+yYqiZLUQJ5/56eNsVwLn4NpRRjyUcs+KNLkZsHh4E4
         IAfL/vhcL3B7y/+cfNZyFd08ubNPazV2TfLZTg1egiJ4JxgjIf8iW7Pl1ufJd2/dDuyF
         3JPw==
X-Forwarded-Encrypted: i=1; AJvYcCWHQix5YL07MfYcQS78AS/hyA3X8cNSFioG100uCY5AtToR3gq+aLpDfjaZtjbEyGLskFta0TBrcfbPEskGW/mgQ5WgFGpVVjOPZbz5
X-Gm-Message-State: AOJu0YwI2QCV9dlKMYzB8bcYEWx0xxThYc/RPphnJvCX7GyUb3HjjfBV
	Iz2gOtUttOO7vc2zUsc4y600u9XC+drl14nDOckqcpnjg+o44wwa+eWJLjEcm0zz4StfXyrztOZ
	a6appMmFvAqwKJAwvlNOQo6Mx65PMrNvPabOQEA==
X-Google-Smtp-Source: AGHT+IFJluQuwD1WcAotSkbFXZSCdGFCSEJsz0a4V4lxTs2mfUgp3DWk5Hz/0vqUyKZs3Prk2hk7RE+AVR9pUzOtbpY=
X-Received: by 2002:a81:ab4c:0:b0:630:d0a3:d2e6 with SMTP id
 00721157ae682-64c73bde7d6mr59684427b3.49.1719856732638; Mon, 01 Jul 2024
 10:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629232231.42394-1-21cnbao@gmail.com>
In-Reply-To: <20240629232231.42394-1-21cnbao@gmail.com>
From: Chris Li <cli@chrisli.org>
Date: Mon, 1 Jul 2024 10:58:41 -0700
Message-ID: <CACePvbW+0j0omqwYcJR6RKSzJu9Kf6aYK7rYJZFtWo3f_bXhWw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix zswap_never_enabled() for CONFIG_ZSWAP==N
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Sat, Jun 29, 2024 at 4:22=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> If CONFIG_ZSWAP is set to N, it means zswap cannot be enabled.
> zswap_never_enabled() should return true.
>
> Fixes: 0300e17d67c3 ("mm: zswap: add zswap_never_enabled()")
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/zswap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index bf83ae5e285d..6cecb4a4f68b 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -68,7 +68,7 @@ static inline bool zswap_is_enabled(void)
>
>  static inline bool zswap_never_enabled(void)
>  {
> -       return false;
> +       return true;
>  }
>
>  #endif
> --
> 2.34.1
>

