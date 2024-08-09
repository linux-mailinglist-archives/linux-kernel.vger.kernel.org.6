Return-Path: <linux-kernel+bounces-281007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF3994D1D0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624C51C210AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E934F195FFA;
	Fri,  9 Aug 2024 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QnYkZqg3"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66EA174EE4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212487; cv=none; b=qrDZQOSdPM0VLaQkbEgWPBg/eaWXWnz2w1hDbDN1RsiDLGkYKojx3rfAzNVOEOxeERmEsjy5w8lWC3p3ZrkYH+5WI4j51FhQggQfcsFgRxPi734UOfgo+0JjipemqVVTRURGwwvncPsGzen2JzegG7P6WPjkd6/BC3hubGVZyn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212487; c=relaxed/simple;
	bh=DNN4byC3duuG6/N7cmuPMVx+KHHJ7kvnDtKxhYMiJfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnOrXqVd9KffngfVaH2mNry28XHSW9HsEVqFlnEr6F8Tpqych61ja8K4rCc3TDDZTOJQ5HE+/d6umTD2pBMQRMkzqFTcO1m015FV5N4Nick6QjcdNKz7ilfIPlUyQRbWFCx+X5XKMIzTFbIUs1ESyVMCMpeI6/p8stNLrYwnEhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QnYkZqg3; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b791cddfcbso12127076d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723212485; x=1723817285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNN4byC3duuG6/N7cmuPMVx+KHHJ7kvnDtKxhYMiJfs=;
        b=QnYkZqg3D233MUaZ9kgxfxQcpVn6skNz5m3xVACDzWUDLKm1syuFK2NSj7Xva1auTX
         3VTd4uT9eiOC8nL5gA20aMg5D+hANzreZ5UC9whG2yZ0bPQOZwieJNfcq0ulWhs4Gwbn
         gjsFapu4YeNMQs0wyKoX6tzJWqLYqRldX2GvcMQQtk006lAtcOQn3fd+tBWkUDpOCuuu
         uq9B2DiTxr/e3/DIx4RPRQPxCd7FjTG++3UXh1WwlbQM8Tud977WbhxE4VW/jdSQaP73
         o7DBmjsIXG7eEyo9agb5YSHpBtARSCBFXF64sP0cHgqMjelv1TzTUmmihfeZsyPCZXYQ
         MmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723212485; x=1723817285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNN4byC3duuG6/N7cmuPMVx+KHHJ7kvnDtKxhYMiJfs=;
        b=eKAnmUWF8QVNgyAKOwzJH95cXhDOybqZ5cEhH0Q0SU7odnz7vcJ0BRWk0uR9LIlvXi
         49fBpQP8t2CPVsj4MDH9cHR5bdQWe48sAUVip1tUKNLop3YJ8tSBNnBH5YcU2WQdmIsx
         rQWdwzJ+OZkZx0x9mSnbiRg8MdXLUZCPpzzrZkRdTmPj/8S2IWalSdqdg4XVLh2yHOBH
         xHKbmAw4bjiRov0G8sPy+UQ3LrPMq1sHkyjvBtN/cMTGFyrLToCtvxE2bNvQfbMvSSIx
         lj77KylXySZbmEl43gUxlLSEK/XE5cyiJHA3LpiG6Aomoe9FroVu3xWu9X/or4feW86/
         azfg==
X-Forwarded-Encrypted: i=1; AJvYcCWsyF9Cle0dztL8b6Ssf/iUi3ecbA5Eny7NlCc7lEmL9ouLtYN8qT8NH7lhsy6wGDuYicA3YtasKgdjzpUrXtVlIVuIYRR5+VExMDPv
X-Gm-Message-State: AOJu0Yznc3F18PJDQqBaQUJJpII9rxhLjLFspDIuBzQb04gIj7NzmUT7
	OoVB8snFU/1e46602b9R14N+WCpoIJz4MHOYyaMYZfyLYvrwgU3HxrpRs2I4+zwzJEDY3Qnbbrg
	8FIGKY7t29yr9jbtyrh2EcXrWMAurpgKe9q1BZgm+QM7BarmG8w==
X-Google-Smtp-Source: AGHT+IHOMGMbExYBvwAgoAoVClbmwPPE45AiYosOhA9dH4Tvhkpnm8xwWX9UH9oHr8vQJR/4PaAJD3ehQ6kT/mBObIE=
X-Received: by 2002:a05:6214:4308:b0:6b7:b277:dd12 with SMTP id
 6a1803df08f44-6bd78e9ae00mr22675886d6.49.1723212484337; Fri, 09 Aug 2024
 07:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808214520.2648194-1-almasrymina@google.com> <3e78e255-d50a-40fb-a438-bfcebb11b049@kernel.org>
In-Reply-To: <3e78e255-d50a-40fb-a438-bfcebb11b049@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 Aug 2024 10:07:52 -0400
Message-ID: <CAHS8izM=fOXCbDykObwqxH9appKOR-NsQcHzQ=eEnKaJ7Upscw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] page_pool: unexport set dma_addr helper
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 5:12=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
>
>
> On 08/08/2024 23.45, Mina Almasry wrote:
> > This helper doesn't need to be exported. Move it to page_pool_priv.h
> >
> > Moving the implementation to the .c file allows us to hide netmem
> > implementation details in internal header files rather than the public
> > file.
> >
>
> Hmm, I worry this is a performance paper cut.
> AFAICT this cause the page_pool_set_dma_addr() to be a function call,
> while it before was inlined and on 64bit archs it is a simple assignment
> "page->dma_addr =3D addr".
>
> See below, maybe a simple 'static' function define will resolve this.
>

Unfortunately I can't static this function; I end up having to call it
from net/core/devmem.c file I'm adding, to set up netmem dma_addr. So
this is a genuine performance papercut.

To be honest, I didn't care much about preserving the inline. I think
the only call site of this function is the slowpath allocation which
does an alloc_pages_node(), and a dma mapping, so uninlining this
function should be a drop in the ocean AFAICT.

However, what I may be able to do is to put it as static inline in
page_pool_priv.h, if there are no objections. That accomplishes the
same thing for my purposes.

--=20
Thanks,
Mina

