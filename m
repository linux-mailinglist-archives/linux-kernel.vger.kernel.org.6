Return-Path: <linux-kernel+bounces-400887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478D59C13AC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BFD283C67
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30171401B;
	Fri,  8 Nov 2024 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pklwxi4j"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F68EDDD2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029630; cv=none; b=X0pXkPR+39pzbC/zlybKrEJTjm6Kg0BPp3/+VShOM5F4lSzAyhitL4nUJoELN8E8+6Vi1SR4AxVLli+XctCBknoFqEd+HMeDSnyY/RzrK3UA9iWRGoUqDl0xZ0OvZru11esmvIKQrLciXlvrMqzvuR8S1Y+a9NbyAUCNEU0b8PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029630; c=relaxed/simple;
	bh=0CIxROtxo9lkntRR5/pEgOmD4bfh0hD4R2SzeU4lydE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHze7ibdD20uCmmVSfVPGRjcZ8xfdTPEmXjPn6v8vcfBsxXWcHhO3qmxUFD7PuZci5qQY1E2WwTI+QOPR3WZfflFeCJ/jJmReBcAKp4pN8nBZc09yI1PX3gyHY5SpYEU5V7HgEr5h+V503bZeyczYFC79YpoZl9pcTLED8lGoAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pklwxi4j; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460969c49f2so133711cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 17:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731029627; x=1731634427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzVdoP6OciidGt4pR8gTvT8j2Y8JEz3d7rgCHYOZPoQ=;
        b=pklwxi4jsIMY1E/BkMrQ0VlH/Cvp5i6LwAnUQgrMi5OvrSjLXv2ugB1ZqahVhI8MKz
         r56bgOrjawpH/0WOqzgB+OM19QIGyvc2RDpFo5RogTRajb0JrMpBJ4n/V35f+uHUWZft
         haDAfvWn1OmAjdWiRA0SjHB0v8xaPjsXacO337aG3jbvELJIvLxMk1BzhUVhFAfDERDj
         all7eNRqeFUpT27Na9vT+JH1wbLgZf303Z3OCuRvCroBeKrQ9oyvnrLhRiFuVaS68L3v
         EkfWU5XrIlM9XLjvfkeKDY9/W44UNwMMjT7MzSt71fDq8ykwtabgkwvzXcLqYJa3LC98
         2ZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731029627; x=1731634427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzVdoP6OciidGt4pR8gTvT8j2Y8JEz3d7rgCHYOZPoQ=;
        b=oSHbZxpivjFo4I8fiiiw0IwjGQcSlrPePkMVMsXhhIE5UCF4f7JGQA5ooyCMjC/Xmp
         E6xrVjeY1r6erjIo+HgRTxJQblB28y7TWDg+QJeaPMLUGnYzs+BSOEqGm/DunQALHXIr
         sCKBEo8j0SG7piY2LpxSbhSuBnY+8iA5SIPhxFAL42Lsuvkfp01RAxmIa5fekJ1g3naz
         aaiqD7BLkuF6JzVZ/MU49XAsDXz1pQ2TNFgFIU0kJI0AuNJZnBXc36EV+eVVpEK7AuQn
         rVVG4giHf4S18LJSEPG4txTAB9SpPTprFFgvcD48Wl9zQzWjTLERgT27UJcqH+bkjwlT
         LHsA==
X-Forwarded-Encrypted: i=1; AJvYcCVIptESeoEqvtsfFMo0gUdCQFwtSKH9c2OVJBvDRCKaTjlZwou1zLAt8hUnG9ayZqpXwtXYXjgITLrb5iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAXwLZ50DizLw9B6CmwDzT0zkb84ilfUskW/QkH8mjFhgKyi8H
	W8rB1UGczlro87WnoASIy2m3uuEjXqHbXHBNBW7sfxsASGVAtW+YZwD9s2Ea+PpY7Yoj1Ge4qek
	pLTLRLR+j6zrv2cpvsnwuUOzXg2CIHeyx2TmO
X-Gm-Gg: ASbGnct4L1TY76Zg4r7DNUwaA9gg3P97sWaOj7MtoFYNSXLLv+V8EZVvjtyOTVNw05f
	gjzq+rhrQgrBd9/2Q4MXJLILuJB0KfKQ=
X-Google-Smtp-Source: AGHT+IEvBJEp2/ytC5Ldt3ehz7w6UWY37/JOusDhlfa4YH7TdJ+scsvMtHFHwCI6X3S8loz7o4qaaWsBGgUSO4qjXec=
X-Received: by 2002:a05:622a:54c:b0:461:685d:324 with SMTP id
 d75a77b69052e-462fa59ee98mr7010221cf.16.1731029627085; Thu, 07 Nov 2024
 17:33:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107210331.3044434-1-almasrymina@google.com> <Zy1pT_VcNpFoGjq-@mini-arch>
In-Reply-To: <Zy1pT_VcNpFoGjq-@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 7 Nov 2024 17:33:35 -0800
Message-ID: <CAHS8izMOtG4UVJNO2Dd-Zcn3aRL_LZFBzTRXn+xa+W_DGzju4Q@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net: fix SO_DEVMEM_DONTNEED looping too long
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Yi Lai <yi1.lai@linux.intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 5:28=E2=80=AFPM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 11/07, Mina Almasry wrote:
> > Exit early if we're freeing more than 1024 frags, to prevent
> > looping too long.
> >
> > Also minor code cleanups:
> > - Flip checks to reduce indentation.
> > - Use sizeof(*tokens) everywhere for consistentcy.
> >
> > Cc: Yi Lai <yi1.lai@linux.intel.com>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > v2:
> > - Retain token check to prevent allocation of too much memory.
> > - Exit early instead of pre-checking in a loop so that we don't penaliz=
e
> >   well behaved applications (sdf)
> >
> > ---
> >  net/core/sock.c | 42 ++++++++++++++++++++++++------------------
> >  1 file changed, 24 insertions(+), 18 deletions(-)
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 039be95c40cf..da50df485090 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1052,32 +1052,34 @@ static int sock_reserve_memory(struct sock *sk,=
 int bytes)
> >
> >  #ifdef CONFIG_PAGE_POOL
> >
> > -/* This is the number of tokens that the user can SO_DEVMEM_DONTNEED i=
n
> > - * 1 syscall. The limit exists to limit the amount of memory the kerne=
l
> > - * allocates to copy these tokens.
> > +/* This is the number of tokens and frags that the user can SO_DEVMEM_=
DONTNEED
> > + * in 1 syscall. The limit exists to limit the amount of memory the ke=
rnel
> > + * allocates to copy these tokens, and to prevent looping over the fra=
gs for
> > + * too long.
> >   */
> >  #define MAX_DONTNEED_TOKENS 128
> > +#define MAX_DONTNEED_FRAGS 1024
> >
> >  static noinline_for_stack int
> >  sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int o=
ptlen)
> >  {
> >       unsigned int num_tokens, i, j, k, netmem_num =3D 0;
> >       struct dmabuf_token *tokens;
> > +     int ret =3D 0, num_frags =3D 0;
> >       netmem_ref netmems[16];
> > -     int ret =3D 0;
> >
> >       if (!sk_is_tcp(sk))
> >               return -EBADF;
> >
> > -     if (optlen % sizeof(struct dmabuf_token) ||
> > +     if (optlen % sizeof(*tokens) ||
> >           optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
> >               return -EINVAL;
> >
>
> [..]
>
> > -     tokens =3D kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL);
>
> Oh, so we currently allocate optlen*8? This is a sneaky fix :-p
>
> > +     num_tokens =3D optlen / sizeof(*tokens);
> > +     tokens =3D kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL=
);
> >       if (!tokens)
> >               return -ENOMEM;
> >
> > -     num_tokens =3D optlen / sizeof(struct dmabuf_token);
> >       if (copy_from_sockptr(tokens, optval, optlen)) {
> >               kvfree(tokens);
> >               return -EFAULT;
> > @@ -1086,24 +1088,28 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t=
 optval, unsigned int optlen)
> >       xa_lock_bh(&sk->sk_user_frags);
> >       for (i =3D 0; i < num_tokens; i++) {
> >               for (j =3D 0; j < tokens[i].token_count; j++) {
>
> [..]
>
> > +                     if (++num_frags > MAX_DONTNEED_FRAGS)
> > +                             goto frag_limit_reached;
> > +
>
> nit: maybe reuse existing ret (and rename it to num_frags) instead of
> introducing new num_frags? Both variables now seem to track the same
> number.

I almost sent it this way, but I think that would be wrong.

num_frags is all the frags inspected.
ret is all the frags freed.

The difference is subtle but critical. We want to exit when we've
inspected 1024 frags, not when we've freed 1024 frags, because the
user may make us loop forever if they ask us to free 10000000 frags of
which none exist.

--=20
Thanks,
Mina

