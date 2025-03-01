Return-Path: <linux-kernel+bounces-539725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0A2A4A7D1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46043189B1DD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D241A5FEE6;
	Sat,  1 Mar 2025 02:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SasezqDh"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942B222087
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740794674; cv=none; b=t05MMMV15/fBIhVL/V/6NR/cABFliiolAhXUyVKjd1prgEuftyvu2gv86uV3X109PdCXJyAr40gycuMU6+fmim9jf3ziOl4AAa1pZJq8GTuy+eyhgdViCUWGvK6ux3kNsn/9cpXBZCRoDW/NAIRO9sgsG/suIHiyBOiFgn5dEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740794674; c=relaxed/simple;
	bh=9xsg0YcftDg7nvIpff5lygFDIzDA5lfF057ozLxjCcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4QspZTVU4ov8AUJTafNy3nusw3b3GA78U14+bfdq7WS0OPaOTJFsBzJCmyPR35Lr6YPbRV72DD1mhCXSJ9z5i8o0qph2y4gm+ttwHgy3iSU05n18T5CvMMeDjGPz/Q5TBUpLQum6irM755g//cGXufzkSEmeXhHYvzOY52ZLr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SasezqDh; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2feae7e56c6so613620a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740794672; x=1741399472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMRMpyLGkuXKFKe3vNfVg0nl7bqc/JfSPYacGN4zRuI=;
        b=SasezqDhI/1+7OVbXArHIagiutFVqnTlVM1wgwsF8XGukrguj9N7Y4ohEBnCdXMmxK
         hJ0K1PGoGngXfGIWSKLjEmXur0JZR2F14yrl9HruDXmC2cJ5ArEhAUlPCSvIU2fnJTnN
         8DgJpT+moFfbxdRkEaWhRfUzPYUVyKJ4IRCglpbKWulP4HPfjCmgTIetGL3Bc4JblgX9
         W946zchQOQx4EIDbcsuHbY9K/i0b6qwRMsGugW2fWNC35WBtgbJw5TRpv5jiX543h5Y1
         H1I5wy6C+s+EC6GmYg0EQfR0VxyWy2a8uDsvXFVo0m6AsT+854aiFoP/SU2cl7dEOpwg
         RxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740794672; x=1741399472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMRMpyLGkuXKFKe3vNfVg0nl7bqc/JfSPYacGN4zRuI=;
        b=WPILP4z52emFKSOwNLF0Vr3mTZCZi8dIUIV+40JRap8ZQjmgszfKN3Ar5L15W7Mavc
         3pp1j50DfiUpocvVYf8m1zVIb9pQzJyAbITxPBIdlI6PLgFWhNOmL/I0bqWj0jX9ZCIh
         iKmS1u6JDVrUDpLa/jwySMHEJh7xppFe8wVldrdSPTXq/sA1DPwGhtZUp4bKtbFBOYOE
         v3x3twxydc8fg1DGV5+MelzBxpflJqF39q9z7mIrDoNl8JFPwO6lJaGfKrINS5taUHM2
         fA7ERRHXzFlLmZTvn0xraMlACcUBJr1fpY8CK+asqP7P32Oi93+dSXT2+WRrSn7OLLcM
         Z1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLLq8amg6DD1tS9IGk7Y+WFRcYxLvMeUv2/d1g+FDFaAok6P4p3Y2qIUgM+b0GfmN7AZXr+JVT0xXfYfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw8oRpFgGp9t2bUS2jMGmoh6X+DmYFJNmWDguJ6GYYRCAnqSjK
	B32PNi6mUqVH9lUgGm+AGSpCK4qGKEOFHMef4bYsmnCaIQQbqv7r6phiwf/cDDsFyw7sJOnh5pf
	7bR43B8uUKUYlNpABNWd1s1D9PX8fcvjIeDCeRw==
X-Gm-Gg: ASbGncuUbPLGSAlLlMgGmBlfHjsuJWnp1vjQ9OMNRjkNOQ5zLqokZv5HVRZE6vnCYxe
	cz9AzlYffjJbogjT/6T6SOpWAMiwmYBadu3wN7Fpg9P50JozT8TyvT7pGoYbf3e/SBaMshuEWqL
	2CofckPbW+Uc5gIeHrS+11q4xU
X-Google-Smtp-Source: AGHT+IG9yG3AscvIs7xF7jEOslIjGL3EISGyHSJ7WZ2CphR9x7QlnnKI9aWzs32OZBuYiwh401z6I5rO7eg54sU/IcY=
X-Received: by 2002:a17:90b:2251:b0:2fb:f9de:9497 with SMTP id
 98e67ed59e1d1-2febabf4096mr3585651a91.5.1740794671827; Fri, 28 Feb 2025
 18:04:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301001610.678223-1-csander@purestorage.com> <86d5f210-d70f-4854-8ecf-eb771f26685a@gmail.com>
In-Reply-To: <86d5f210-d70f-4854-8ecf-eb771f26685a@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 28 Feb 2025 18:04:20 -0800
X-Gm-Features: AQ5f1JogyzdDhsSU4u6-6ldO8cFm2tSqWRRE6OcEpmlX-dpUU4jWdczXcSu4XKE
Message-ID: <CADUfDZrOoSgT5n51N5=UFSum96mj2MAytQbJNbBVC1BJrmNVtA@mail.gmail.com>
Subject: Re: [PATCH 1/2] io_uring/rsrc: declare io_find_buf_node() in header file
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 5:45=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 3/1/25 00:16, Caleb Sander Mateos wrote:
> > Declare io_find_buf_node() in io_uring/rsrc.h so it can be called from
> > other files.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >   io_uring/rsrc.c | 4 ++--
> >   io_uring/rsrc.h | 2 ++
> >   2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> > index 45bfb37bca1e..4c4f57cd77f9 100644
> > --- a/io_uring/rsrc.c
> > +++ b/io_uring/rsrc.c
> > @@ -1066,12 +1066,12 @@ static int io_import_fixed(int ddir, struct iov=
_iter *iter,
> >       }
> >
> >       return 0;
> >   }
> >
> > -static inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *r=
eq,
> > -                                                 unsigned issue_flags)
>
> That's a hot path, an extra function call wouldn't be great,
> and it's an internal detail as well. Let's better see what we
> can do with the nop situation.

I can add back inline. With that, there shouldn't be any difference to
the generated instructions for io_import_reg_buf().

>
> btw, don't forget cover letters for series.

Okay, I didn't have much else to add to the brief commit messages. But
sure, I'll add a cover letter in the future.

Best,
Caleb

