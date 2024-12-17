Return-Path: <linux-kernel+bounces-449087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213CF9F4998
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3361668EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668971EBA02;
	Tue, 17 Dec 2024 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4bAAEO0"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DBB1D47D9
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734433754; cv=none; b=SIfQbPwYqpNnwvfq02JztBZmIFe0Vc4ypthb+nefYX2sRMrUcp73yqCITyK2hMMYIRw4IEPrjG6dQXl5ifWmu3gJ4CmhVeBfjrNUY2YEIFNkZueAb5rTlCXC10aTNGRBsndS1cWl+kw39zu9kHkzxtWrP5yMHzKydR30Y8IODrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734433754; c=relaxed/simple;
	bh=G/6pg2pdpByK6UOnWxA4JUDE7zurTAIPCyyjxOHzFAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTYXSwKnDHM1v9CY7vlKTNR/PRHrLjm5f7BPReOBD4+NjfOdWNxP49fBP8Nd9+AVt4FnnMK5ClTv5JmfbKA+cjiVxy5yeAlYUBkjtP31ajMYzGGt3ljffplk/HwBHOlcuk3S6jLu8+ubMQOOnQ0SWRDIzKLMWiWwT9rUKL+YvnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4bAAEO0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso6804034a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734433751; x=1735038551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzuI9aLJOWEZZmxnx5012VAErpqqnvkTRbmh8IPMF+k=;
        b=U4bAAEO0t51P1lIB8ucjT/GTf1c+7rwQfmIQcbI9v+DlZCtlz5mpmoUaFs5jMF4f1M
         IVh/6QzgvLRgAgDjJ+jV2YlHHwfgZ1KXUp6UCt72xTJv9VHc5C6pjES+ddSrZ6Z0WOcm
         /5Wcp4jAtcdpUfs+YnoK/RHjhYFVIQHEnuxVrZi5ojDcA9Bdjb15nLByCm9R9mJFUQ0C
         Ac21pyxcx2T7vChBND9guukMdEriyeQR1xJerUr5EvMWDdNVE517yrd/eYTzDjlkHBFc
         X1LGUkI+KYcohO/y640ZI/gsKqWvybIahqhD9OXFBf4U879kjU6QQjEaP3PtgQDFVIiQ
         VPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734433751; x=1735038551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzuI9aLJOWEZZmxnx5012VAErpqqnvkTRbmh8IPMF+k=;
        b=d4v3pUvsNxXOtNn1Yq0teGyrD6MOHmbc2sEvgBilanIRNvMuKmfdm0xuFn7HIywHCw
         iV30zd1TUr3bNhm85FnY+9n+7nUkJeWCHQaW4HjovkOyApc7WDmqEI8aLX9zX8bg3vGo
         Vs/+HhVTYOXeU7SRaRHxrQG0s68piQr/srCHl4OHtrA3cKMJ8saDFkWC2yW1ARmaDLEj
         aNkPSgQ+LgDM0xZAJL9/Dw2lx7snfOSM0StK8AEH3L8VItjwd6IKHSXI4afD61BiG8g7
         J5lfgSVa6Ww+KETkT8TAXWjkrUxrNxc224K2aZiSk8lZ/dacVhr8S7F2TrhOCt9Yjmbd
         s0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8UTOEg+zeLhPRK9OfpnD99EUQTWQmC+qAkw3CC+bZvRNSWAewJpjfMCwFYIuJpDFk8XnGChnPVhbbZYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfvHT5XtkQxyb6FpdyEnLA2LGikkC94nBxs1WwmV+Nr73xsGOf
	PONhVy4NcIYo5XPybljXaXMTWmKhemKKhJ+lqDH1aThCiql6iesfEoJOn47gr87C4vwyexZSpjD
	MNy6i0Mf1GQ5zKAz5kRnZ7JHEMRWKXxEpiafEmgEZA8cQshSRuiol
X-Gm-Gg: ASbGncshu9CNhUJTxWKbknXG3JB+NaMzsxJE/m8moKQbiepfXvLXoR0hJWsnpP1l7kU
	RswgPcpqlj8vEuboP2cxh281wsY5jminnTkXdVA2rlkWKgKY8LDblR5WVQH9OJ09YvSdaYtNw
X-Google-Smtp-Source: AGHT+IHugQf3gQVyGwYhev90BATuj8UeOHv3MMabt2v6JeHVBLsfim5ImjXgNCc8i+EJGN/6fITifC6gPEMntVKH8OU=
X-Received: by 2002:a05:6402:4582:b0:5d3:f6cb:73e4 with SMTP id
 4fb4d7f45d1cf-5d63c3bed0amr14053276a12.34.1734433751336; Tue, 17 Dec 2024
 03:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217105659.2215649-1-yajun.deng@linux.dev>
In-Reply-To: <20241217105659.2215649-1-yajun.deng@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 12:09:00 +0100
Message-ID: <CANn89iKYgt-61ku46p3D1yHtc7RUVqeB5WN83Tfd+ZtyeE+Mug@mail.gmail.com>
Subject: Re: [PATCH net-next] sock: make SKB_FRAG_PAGE_ORDER equal to PAGE_ALLOC_COSTLY_ORDER
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 11:56=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev> =
wrote:
>
> The SKB_FRAG_PAGE_ORDER will be 3 if PAGE_SIZE is 4096, and less than 3
> if it is not. So it will increase the number of memory allocations if
> PAGE_SIZE is greater than 4096.
>
> alloc_pages() only relates to the order, if an order is less than or equa=
l
> to PAGE_ALLOC_COSTLY_ORDER, it will get the page from rmqueue_pcplist() i=
n
> rmqueue(). So there's no need for the order to be less than
> PAGE_ALLOC_COSTLY_ORDER.
>
> To decrease the number of memory allocations, make SKB_FRAG_PAGE_ORDER
> equal to PAGE_ALLOC_COSTLY_ORDER even if PAGE_SIZE isn't 4096.
>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  include/net/sock.h | 2 +-
>  net/core/sock.c    | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 7464e9f9f47c..a33645226577 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2853,7 +2853,7 @@ extern __u32 sysctl_rmem_max;
>  extern __u32 sysctl_wmem_default;
>  extern __u32 sysctl_rmem_default;
>
> -#define SKB_FRAG_PAGE_ORDER    get_order(32768)

We do not want to allow some programs to work on arches with 64K page
sizes, and not work on 4K page sizes.

Please post your precise use case.

