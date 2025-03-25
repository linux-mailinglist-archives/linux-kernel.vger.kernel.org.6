Return-Path: <linux-kernel+bounces-575545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCEDA70400
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FA63A7C26
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E35C257AF2;
	Tue, 25 Mar 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Xdasmq6k"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7F2566DE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913558; cv=none; b=q8qwyNGfpnn39rx3GEOmLPNEQS09oEmIDmiwN1qk5oIVFtXlPq5ZOvkJh4lG92zOvM9eojh1GlzwMSHNoMpKzVmjVlzJkB8d45EahzCxurRqazf8hlgbu3idOBAo0QldGjMTspMvTPaotjXs4K3THX60EH8yNKplIu9pkolCbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913558; c=relaxed/simple;
	bh=93eWenbFX4Qctz6lS+ZM7ptfCzMUV8wfEb7lTyzGPMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbQlUh7eY7coSLPhE+Bup2tuaYuttzeTY+M0c40YxCb37teokIf4TuIk/Qeh/Jldy/vNKNuPfnjMpIv/l7nz+l6OA6sn8Y7A672bWvSeWWACO5cQYY4HdCoV6s8hEA7fAmmfPtNAwbl8lwHtbQSSC3xzPUhqh0SJuX2B57OmI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Xdasmq6k; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301317939a0so1688869a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742913556; x=1743518356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5+emjeFfRDf3d8vzGiMI59WxZfGi88bAPj4rxcKWnI=;
        b=Xdasmq6kbva6eSwW0l1wHu71yw6sMqRKaj/k4RILNQo0sLM9Wjt9oU+PUiZVMv+QUE
         F5qVIBXjD04qnte1zLTx3OWp1ydUV0ZEHuJHs8VlvvEd2iWHYAV199g3AhymN7piHR5d
         K6rRQdZaCYD7IUqinp/6pOcAX6QIuTUUH0OmjuNChUvPr4OyhUIp8l4ZdVQ2lGhkoVRT
         hOfxWKsUBw7Jx2MYyMp5AI2z+xuUBFiaH7aBXZnV4GddMCIzELgmdiWKWAz1Qm7gmEB7
         5rEt8G/AZHEroh997xoCv6LbkBxaXhJjAIAsIUHCLjQt/7pHJUAbHB0vvHNOod45a9+0
         ox+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742913556; x=1743518356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5+emjeFfRDf3d8vzGiMI59WxZfGi88bAPj4rxcKWnI=;
        b=PShLlql+VZcfZetLyDzzBG9LALZQTXYynWo5c+Qv1eyRfuqrrg3HUHy0stwyBReJMQ
         VInYcEKsQwOefD1BmQbTLOUOaAu/RnRUluDUPd94p+Zpj+Y9GimF2p/70yokrL8c2b/T
         BWymAY5Ty8UNjiOlUG0VGkBK8AwcwItfbWRYLuR8Hycpx71OHWvUuVpofnaMr9lekpwW
         iW9fg4SOQP5D8mT31u/Pwj0nurKyStryV4mGQcd8bGgxG2GzU0xlph2APTUhugnc0pp/
         qYzTg06yIBHzskmXTqu1P+vMvwMX9XKrrU/K3XQwPFz5THNOjYbCBfshkViEFWNciYMW
         hbVw==
X-Forwarded-Encrypted: i=1; AJvYcCXmorWrib4Bsi/KHRFf4gCQd1qssnZMdTZPwJ0ih5fFccALNbqTWlujYy77e5OxqH+nCJKDQIio9+wyGC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhuKvYYfzkC7YeTb1l6lIpCd1KfhXbedD7U7+gkfObfZw9z+K6
	eQ9IkPDJBHxgTzhXpKOqLxAxe1bOvdOfE7YwgyJovu6wpfCQWsSo8Au+WAKG94cN6OyFhDF+rX3
	ExJJ7V42IEWxiL80NMQz+02PnJ5t+ebcThLyrrg==
X-Gm-Gg: ASbGncuO+e9OLPFsN3Q6sF/tK4gy7JGiLpNNatNB6plRMTo7s5ONuLJSe47QoZwoJjk
	lr+/wqYiA+pFKbG2ceHh13pAm5ws11jGSwa+O0L3gQFqP11xsJ7uuXVswyvF9S7HzIpXhaoeiPX
	c/x5ijC0dusjbicrpJnNqbKq+5
X-Google-Smtp-Source: AGHT+IELDUGTHhhfY6IuAt3IGxep+aF++UUFDx9mIkxkIg5Rky6VYHfF/K2vYvRLeDpg3qkuJHKzbYSL5b1iC44oGPc=
X-Received: by 2002:a17:90b:1b52:b0:2fe:a747:935a with SMTP id
 98e67ed59e1d1-3030fef1da3mr10236262a91.4.1742913555742; Tue, 25 Mar 2025
 07:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324151123.726124-1-csander@purestorage.com> <8b22d0df-f0ea-4667-b161-0ca42f03a232@gmail.com>
In-Reply-To: <8b22d0df-f0ea-4667-b161-0ca42f03a232@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 25 Mar 2025 07:39:04 -0700
X-Gm-Features: AQ5f1JrNvLHl-Bc07IZmeCK7EzYr-z2R9_YgkneyPMAWniWHWnNox-4XX-GkLxQ
Message-ID: <CADUfDZocNe0jm1n3WxO+hHqVcQcgj5PtA4h+S3EsiB0D=-m+dA@mail.gmail.com>
Subject: Re: [PATCH] io_uring/net: use REQ_F_IMPORT_BUFFER for send_zc
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 6:30=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 3/24/25 15:11, Caleb Sander Mateos wrote:
> > Instead of a bool field in struct io_sr_msg, use REQ_F_IMPORT_BUFFER to
> > track whether io_send_zc() has already imported the buffer. This flag
> > already serves a similar purpose for sendmsg_zc and {read,write}v_fixed=
.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> > ---
> >   include/linux/io_uring_types.h | 5 ++++-
> >   io_uring/net.c                 | 8 +++-----
> >   2 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_ty=
pes.h
> > index c17d2eedf478..699e2c0895ae 100644
> > --- a/include/linux/io_uring_types.h
> > +++ b/include/linux/io_uring_types.h
> > @@ -583,11 +583,14 @@ enum {
> >       REQ_F_BUFFERS_COMMIT    =3D IO_REQ_FLAG(REQ_F_BUFFERS_COMMIT_BIT)=
,
> >       /* buf node is valid */
> >       REQ_F_BUF_NODE          =3D IO_REQ_FLAG(REQ_F_BUF_NODE_BIT),
> >       /* request has read/write metadata assigned */
> >       REQ_F_HAS_METADATA      =3D IO_REQ_FLAG(REQ_F_HAS_METADATA_BIT),
> > -     /* resolve padded iovec to registered buffers */
> > +     /*
> > +      * For vectored fixed buffers, resolve iovec to registered buffer=
s.
> > +      * For SEND_ZC, whether to import buffers (i.e. the first issue).
> > +      */
> >       REQ_F_IMPORT_BUFFER     =3D IO_REQ_FLAG(REQ_F_IMPORT_BUFFER_BIT),
> >   };
> >
> >   typedef void (*io_req_tw_func_t)(struct io_kiocb *req, io_tw_token_t =
tw);
> >
> > diff --git a/io_uring/net.c b/io_uring/net.c
> > index c87af980b98e..b221abe2600e 100644
> > --- a/io_uring/net.c
> > +++ b/io_uring/net.c
> > @@ -75,11 +75,10 @@ struct io_sr_msg {
> >       unsigned                        nr_multishot_loops;
> >       u16                             flags;
> >       /* initialised and used only by !msg send variants */
> >       u16                             buf_group;
> >       bool                            retry;
> > -     bool                            imported; /* only for io_send_zc =
*/
> >       void __user                     *msg_control;
> >       /* used only for send zerocopy */
> >       struct io_kiocb                 *notif;
> >   };
> >
> > @@ -1305,12 +1304,11 @@ int io_send_zc_prep(struct io_kiocb *req, const=
 struct io_uring_sqe *sqe)
> >       struct io_ring_ctx *ctx =3D req->ctx;
> >       struct io_kiocb *notif;
> >
> >       zc->done_io =3D 0;
> >       zc->retry =3D false;
> > -     zc->imported =3D false;
> > -     req->flags |=3D REQ_F_POLL_NO_LAZY;
> > +     req->flags |=3D REQ_F_POLL_NO_LAZY | REQ_F_IMPORT_BUFFER;
>
> This function is shared with sendmsg_zc, so if we set it here,
> it'll trigger io_import_reg_vec() in io_sendmsg_zc() even for
> non register buffer request.

Good catch. I keep forgetting which prep and issue functions are
shared between which opcodes.

Thanks,
Caleb

