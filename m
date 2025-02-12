Return-Path: <linux-kernel+bounces-511942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B0DA331D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893731889C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1DC2036EC;
	Wed, 12 Feb 2025 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="glTpOYId"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2333A202F8C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397534; cv=none; b=NRu78TLpPuqSM3RtWQKaPHCFDKLzM98ou8mJH0A6NmVplLmk1MB5ESsbA+WLSuzu7CyFDHksWz7bmzOUuiNfv1AnlzSQhhedHh1rGlkmc38FWpatIajiePWqUhf5cCRAhCChNjNFo/c/EfG7VnCYKLL6MvuOFG1QkhbCQOmV3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397534; c=relaxed/simple;
	bh=ZeJV606HhNOYcrFNa/6JlfrCAbfQCMj5yvznSZgG+FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNrsPnd3kHYIf65XB/yuAOo6wGKfP9X/Uf1Lh6Dia38Bo8AN8xzZdJwE4ViYlZmNCG8yM6pLsv2+3AT5LB6lirGB2El+qMKreAlQkY+7wWexnA8mRW5jt63YisyQWSPlVwABr8xNyGhfyAOY4RjYiNcOvrjYQ1nN+6h1Tyk8Svc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=glTpOYId; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f8f3bd828so301045ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739397532; x=1740002332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vkMubqrMNCA+P8txMR+PCY+IaB0s5pHKten9Sx9268=;
        b=glTpOYIdb+kLz1ZRA1Vnu9O39TWSqAIQbKMXCHSA5K5/yEOA34LVq8knQGuWLcaLW8
         muAB65UZp60B2GpGIyJVd3IH5y2OC3i/3+Xa3czqbi1bSY53icUXS04KPBEqNsx2JPJx
         HKRBTGjMCuakuyPhgAX92/Buf+CeIRbpv4nphr+n3v6u3dCHM7ld7T5gwuTxh+kaSXOE
         euk6Gkv4tW8FC5WqMR6G2ez8kYMSJkAU0j1+6K8wgrfRKU2t2DvyN4IXNYrMCN/LvKw/
         rYavhUU+x7l/74NMxWNwzqgrTqmG3zUOz9dQv8/thtMBWghLndsA8yBkWNvLR5GWp5yJ
         oBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739397532; x=1740002332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vkMubqrMNCA+P8txMR+PCY+IaB0s5pHKten9Sx9268=;
        b=hnHSYeOl6KkyPqHBf4CI69alzr5b3EFGsL6Xgt/HPLplaj/QV5j1O2hOCYPdFFjZxo
         YUx8WWSm5Ej6CGTX18+oy7AsAYLEeAhYf/rj92nhFnlRO27bVwxnK/R6ESnH+kxK3SOn
         tzrPG6KXyK/lNW+ly5Fz+8bIBYLnb4NLayvB+e/8+pID2zt/SDUDA+rZEOlRQlsmL3Nf
         l0Vx8yr1BV7ASylQO5+LRHbbWX+f+Xzkfkith3IgFb7XSkzDyvC3ORDSnXGH7SnIRyOx
         1YPyySpnFxR7uwn2YHb1yYGpi9IdwGdBVANoeKtAjVlVdecgSRjUbf6E/giG4C9LfA7r
         LINA==
X-Forwarded-Encrypted: i=1; AJvYcCXV1cXgw5adlnv0j9ru21Lna1IvkPHRbF5d9qPqPA2fxw4kvXOECFwd8UWx3thJaneywgPMERYOfY1vr88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE096gy0qI8xyEmMdaH3m0FM60y/iw+YynRZTJsr24eMS+6sb8
	am1m6qPwwPzua2BMDuW8gKVLatSngBV+sjaJrzyIfe42bCpKwmV7lVErPESjYOYD9uCO9ox4neF
	MpnXS/BJHNVyDLf41LtfyeAnkTwPYfUO6IbSw4w==
X-Gm-Gg: ASbGncumAtNdAFgsz1HBlzh6cbfTE3bXYw498i5V3mtQDJdkMBXpSvCpG0BGVznGD+M
	OKMwkSGEgGnUx9YSPgRLzmDrBBGmiIq0KKdOIlW7Jsjz+T8cDTzU1oHw4693H7mLAMy5+KU0=
X-Google-Smtp-Source: AGHT+IGv1A+woJLlJgl63xhuiKMFHTiUoQ/G0lh4kY82QXapUXwlp/DT66Lo83612m9rkYmfcT+rnuzNCLEgGSvUxoE=
X-Received: by 2002:a17:902:ea01:b0:20c:5da8:47b8 with SMTP id
 d9443c01a7336-220bbf3284amr30377295ad.5.1739397532283; Wed, 12 Feb 2025
 13:58:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212204546.3751645-1-csander@purestorage.com>
 <401f9f7a-b813-43b0-b97f-0165072e2758@kernel.dk> <50caa50c-5126-4072-8cfc-33b83b524489@kernel.dk>
In-Reply-To: <50caa50c-5126-4072-8cfc-33b83b524489@kernel.dk>
From: Caleb Sander <csander@purestorage.com>
Date: Wed, 12 Feb 2025 13:58:41 -0800
X-Gm-Features: AWEUYZmI7u_8qzPpg7HXGKAXEj_umodoVjsh9_-byPg-wdS94gn-N9p1Mvu9XyA
Message-ID: <CADUfDZroLajE4sF6=oYopg=gNtv3Zko78ZcJv4eQ5SBxMxDOiw@mail.gmail.com>
Subject: Re: [PATCH 0/2] uring_cmd SQE corruptions
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Riley Thomasson <riley@purestorage.com>, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 1:02=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/12/25 1:55 PM, Jens Axboe wrote:
> > On 2/12/25 1:45 PM, Caleb Sander Mateos wrote:
> >> In our application issuing NVMe passthru commands, we have observed
> >> nvme_uring_cmd fields being corrupted between when userspace initializ=
es
> >> the io_uring SQE and when nvme_uring_cmd_io() processes it.
> >>
> >> We hypothesized that the uring_cmd's were executing asynchronously aft=
er
> >> the io_uring_enter() syscall returned, yet were still reading the SQE =
in
> >> the userspace-mapped SQ. Since io_uring_enter() had already incremente=
d
> >> the SQ head index, userspace reused the SQ slot for a new SQE once the
> >> SQ wrapped around to it.
> >>
> >> We confirmed this hypothesis by "poisoning" all SQEs up to the SQ head
> >> index in userspace upon return from io_uring_enter(). By overwriting t=
he
> >> nvme_uring_cmd nsid field with a known garbage value, we were able to
> >> trigger the err message in nvme_validate_passthru_nsid(), which logged
> >> the garbage nsid value.
> >>
> >> The issue is caused by commit 5eff57fa9f3a ("io_uring/uring_cmd: defer
> >> SQE copying until it's needed"). With this commit reverted, the poison=
ed
> >> values in the SQEs are no longer seen by nvme_uring_cmd_io().
> >>
> >> Prior to the commit, each uring_cmd SQE was unconditionally memcpy()ed
> >> to async_data at prep time. The commit moved this memcpy() to 2 cases
> >> when the request goes async:
> >> - If REQ_F_FORCE_ASYNC is set to force the initial issue to go async
> >> - If ->uring_cmd() returns -EAGAIN in the initial non-blocking issue
> >>
> >> This patch set fixes a bug in the EAGAIN case where the uring_cmd's sq=
e
> >> pointer is not updated to point to async_data after the memcpy(),
> >> as it correctly is in the REQ_F_FORCE_ASYNC case.
> >>
> >> However, uring_cmd's can be issued async in other cases not enumerated
> >> by 5eff57fa9f3a, also leading to SQE corruption. These include request=
s
> >> besides the first in a linked chain, which are only issued once prior
> >> requests complete. Requests waiting for a drain to complete would also
> >> be initially issued async.
> >>
> >> While it's probably possible for io_uring_cmd_prep_setup() to check fo=
r
> >> each of these cases and avoid deferring the SQE memcpy(), we feel it
> >> might be safer to revert 5eff57fa9f3a to avoid the corruption risk.
> >> As discussed recently in regard to the ublk zero-copy patches[1], new
> >> async paths added in the future could break these delicate assumptions=
.
> >
> > I don't think it's particularly delicate - did you manage to catch the
> > case queueing a request for async execution where the sqe wasn't alread=
y
> > copied? I did take a quick look after our out-of-band conversation, and
> > the only missing bit I immediately spotted is using SQPOLL. But I don't
> > think you're using that, right? And in any case, lifetime of SQEs with
> > SQPOLL is the duration of the request anyway, so should not pose any
> > risk of overwriting SQEs. But I do think the code should copy for that
> > case too, just to avoid it being a harder-to-use thing than it should
> > be.
> >
> > The two patches here look good, I'll go ahead with those. That'll give
> > us a bit of time to figure out where this missing copy is.
>
> Can you try this on top of your 2 and see if you still hit anything odd?
>
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index bcfca18395c4..15a8a67f556e 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -177,10 +177,13 @@ static void io_uring_cmd_cache_sqes(struct io_kiocb=
 *req)
>         ioucmd->sqe =3D cache->sqes;
>  }
>
> +#define SQE_COPY_FLAGS (REQ_F_FORCE_ASYNC|REQ_F_LINK|REQ_F_HARDLINK|REQ_=
F_IO_DRAIN)

I believe this still misses the last request in a linked chain, which
won't have REQ_F_LINK/REQ_F_HARDLINK set?
IOSQE_IO_DRAIN also causes subsequent operations to be issued async;
is REQ_F_IO_DRAIN set on those operations too?

Thanks,
Caleb

> +
>  static int io_uring_cmd_prep_setup(struct io_kiocb *req,
>                                    const struct io_uring_sqe *sqe)
>  {
>         struct io_uring_cmd *ioucmd =3D io_kiocb_to_cmd(req, struct io_ur=
ing_cmd);
> +       struct io_ring_ctx *ctx =3D req->ctx;
>         struct io_uring_cmd_data *cache;
>
>         cache =3D io_uring_alloc_async_data(&req->ctx->uring_cache, req);
> @@ -190,7 +193,7 @@ static int io_uring_cmd_prep_setup(struct io_kiocb *r=
eq,
>
>         ioucmd->sqe =3D sqe;
>         /* defer memcpy until we need it */
> -       if (unlikely(req->flags & REQ_F_FORCE_ASYNC))
> +       if (unlikely(ctx->flags & IORING_SETUP_SQPOLL || req->flags & SQE=
_COPY_FLAGS))
>                 io_uring_cmd_cache_sqes(req);
>         return 0;
>  }
>
> --
> Jens Axboe

