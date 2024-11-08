Return-Path: <linux-kernel+bounces-402205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CE29C2505
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB52C1F231EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07601A9B4C;
	Fri,  8 Nov 2024 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zmGUJLZ+"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9331AA1C7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091524; cv=none; b=s0DQ53NCWMZzd6HR9RkUj4CAJIvfrBLicsx3+4ESAbx0hcoOcH58M10u/Vk3/jWPdwaMXiQediHzUYJF4J21LVt9EXpCQk6rsalkVgsG6226bkLxmrJ3qL57CoigheJFwMxobOqQhlfPKx7DShNxKx1OjKiAx5W8VCErZAkpPls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091524; c=relaxed/simple;
	bh=lcqVxarSnIw0Wfqck48GyQe2gVWyEkUqvNLjJFQRkik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZC6Oi2pveMwSZ5AYQOPTr6oqCZ/4G+gwbzW8djK5zQSrLoTyxKvvvEzIDevwNd8EFSqlAVESCBSijAWbvJhfgtjW8ov9hLbS6u39XRqxx31XYXxegblpzpbzcS2z/KJPc2PM1iri/nps1yaK+jA7Hud4zSYjlM8F9ymFF7qXGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zmGUJLZ+; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460b295b9eeso16701cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 10:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731091520; x=1731696320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQWXX3Y2NemA0Bkmo9oa5lzAWU2FAVxuxVlJNZmkK0g=;
        b=zmGUJLZ+pcVZAPYmE5NQNZ1QyU+AVEmoHit7jYqG/Te+gUl8cPqXR+OqeVAJjyXem2
         QS3vOswWcTAxLs2Ql/uZUJtNip1uB3dJLYOgT75dQJqgRAQutB2/8NQCctZQK8+ejFvM
         WVXE/LD0fN2dbzV4LbY4ra8VsD8WXBjG0BEhlxTHfiCD5o/ZXeOlm0fGMDSCSlqxh5rH
         h6/0Wu2e0n5q5M+it4GZUfqrh6nbsrGQG+Eje4VBy1Mj+pGK8ZkTi39aUBy236+DJTna
         47T1FQ7OBTSKZ3yLslb8K1CPY4YrchjGXwWZszR6633+G0UNDoKRBhZVqOcV2c31sJC5
         q80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091520; x=1731696320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQWXX3Y2NemA0Bkmo9oa5lzAWU2FAVxuxVlJNZmkK0g=;
        b=XFWrE0QXjxojO9+gGQGj4/3tksy6EQcc//phwqkDptzIcLDU+kT2FJTLP82ciZMn5Z
         WsXKkFRY0pjua4nGuNZhdacGCe7zYXu5TGesv1QTC0QsPeKETl1Ok3/nAE6D6OorUZwK
         bfMuqFaehyuDXQMbzkWOmxM+pdtOVdq6PHeNe+Gy3+FWdtx3kNUW9HXxtN102nlS/ylW
         X45gdPrbs5LTpFSFHEczBzvDcod6Gcwlt4ebPb4aQnheO6DufC1nFpP21D4lVJ5fbWl3
         h4RtvcLi4Yd2DcUvtCaCQCDpu4Cv6MLpADc3Q1aT4k1Lbh+4eg2QZ0UfOVUL6A/vkndL
         Mu7w==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3XzCJWGgGfqGpDPd2TdvrZxjVx0vLtblMHarE2Nwnvj1xkDYzMtgzxrQ5xTZ9+PuAOGKhIlvY6niK6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNtuBHtbGue6y2loK2uKUV6N9FgeYEqyxlsajZ+K5q3ZCc+TIr
	rb1ioZlaPtbp4nmQ15ldq5I2esx/drXeJCnXcbRuP2tB246KXiOrQisi5pAVSqJDIrsdNYYnC1U
	itCGzLGk/eWI8Jw6hrVb9UEET+iDj3yOEeb/o88hqbOADfUogww==
X-Gm-Gg: ASbGnct4BXkNEowB5YnqsooN9qTUxa2oVU74oRqkkNpUnxmQ35M9aCgwa2Qydyds3XC
	PQpnS7IHnOQOfp1da3Jc5KmSwkveyFto=
X-Google-Smtp-Source: AGHT+IGvwPp9TjQSnwda6uC40OLtKbAEUpz4aO9CgT19b5ZFDtcU/z04H3hO5fbFjqfA/TFF1ZaKphANpOjVSAC2lfA=
X-Received: by 2002:a05:622a:548a:b0:462:c4fe:ec19 with SMTP id
 d75a77b69052e-462fa619d7dmr8710451cf.21.1731091520108; Fri, 08 Nov 2024
 10:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107210331.3044434-1-almasrymina@google.com>
 <20241107210331.3044434-2-almasrymina@google.com> <Zy1priZk_LjbJwVV@mini-arch>
 <CAHS8izOJSd2-hkOBkL0Cy40xt-=1k8YdvkKS98rp2yeys_eGzg@mail.gmail.com>
 <Zy1_IG9v1KK8u2X4@mini-arch> <CAHS8izP8UoGZXoFCEshYrL=o2+T6o4g-PDdgDG=Cfc0X=EXyVQ@mail.gmail.com>
 <Zy5Ta-M868VvBme2@mini-arch>
In-Reply-To: <Zy5Ta-M868VvBme2@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 8 Nov 2024 10:45:07 -0800
Message-ID: <CAHS8izNK6xJHDB+W80iCr2CEwbo=OecG-1UW5dB9X_0aowo8Bw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: clarify SO_DEVMEM_DONTNEED behavior in documentation
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Yi Lai <yi1.lai@linux.intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 10:07=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 11/08, Mina Almasry wrote:
> > On Thu, Nov 7, 2024 at 7:01=E2=80=AFPM Stanislav Fomichev <stfomichev@g=
mail.com> wrote:
> > >
> > > On 11/07, Mina Almasry wrote:
> > > > On Thu, Nov 7, 2024 at 5:30=E2=80=AFPM Stanislav Fomichev <stfomich=
ev@gmail.com> wrote:
> > > > >
> > > > > On 11/07, Mina Almasry wrote:
> > > > > > Document new behavior when the number of frags passed is too bi=
g.
> > > > > >
> > > > > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > > > > ---
> > > > > >  Documentation/networking/devmem.rst | 9 +++++++++
> > > > > >  1 file changed, 9 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/networking/devmem.rst b/Documentatio=
n/networking/devmem.rst
> > > > > > index a55bf21f671c..d95363645331 100644
> > > > > > --- a/Documentation/networking/devmem.rst
> > > > > > +++ b/Documentation/networking/devmem.rst
> > > > > > @@ -225,6 +225,15 @@ The user must ensure the tokens are return=
ed to the kernel in a timely manner.
> > > > > >  Failure to do so will exhaust the limited dmabuf that is bound=
 to the RX queue
> > > > > >  and will lead to packet drops.
> > > > > >
> > > > > > +The user must pass no more than 128 tokens, with no more than =
1024 total frags
> > > > > > +among the token->token_count across all the tokens. If the use=
r provides more
> > > > > > +than 1024 frags, the kernel will free up to 1024 frags and ret=
urn early.
> > > > > > +
> > > > > > +The kernel returns the number of actual frags freed. The numbe=
r of frags freed
> > > > > > +can be less than the tokens provided by the user in case of:
> > > > > > +
> > > > >
> > > > > [..]
> > > > >
> > > > > > +(a) an internal kernel leak bug.
> > > > >
> > > > > If you're gonna respin, might be worth mentioning that the dmesg
> > > > > will contain a warning in case of a leak?
> > > >
> > > > We will not actually warn in the likely cases of leak.
> > > >
> > > > We warn when we find an entry in the xarray that is not a net_iov, =
or
> > > > if napi_pp_put_page fails on that net_iov. Both are very unlikely t=
o
> > > > happen honestly.
> > > >
> > > > The likely 'leaks' are when we don't find the frag_id in the xarray=
.
> > > > We do not warn on that because the user can intentionally trigger t=
he
> > > > warning with invalid input. If the user is actually giving valid in=
put
> > > > and the warn still happens, likely a kernel bug like I mentioned in
> > > > another thread, but we still don't warn.
> > >
> > > In this case, maybe don't mention the leaks at all? If it's not
> > > actionable, not sure how it helps?
> >
> > It's good to explain what the return code of the setsockopt means, and
> > when it would be less than the number of passed in tokens.
> >
> > Also it's not really 'not actionable'. I expect serious users of
> > devmem tcp to log such leaks in metrics and try to root cause the
> > userspace or kernel bug causing them if they happen.
>
> Right now it reads like both (a) and (b) have a similar probability. Mayb=
e
> even (a) is more probable because you mention it first? In theory, any sy=
scall
> can have a bug in it where it returns something bogus, so maybe at least
> downplay the 'leak' part a bit? "In the extremely rare cases, kernel
> might free less frags than requested .... "
>
> Imagine a situation where the user inadvertently tries to free the same t=
oken
> twice or something and gets the unexpected return value. Why? Might be
> the kernel leak, right?
>
> From the POW of the kernel, the most probable cases where we return
> less tokens are:
> 1. user gave us more than 1024
> 2. user gave us incorrect tokens
> ...
> 99. kernel is full of bugs and we lost the frag

The current wording doesn't make any comment about probability. More
information is better than less. I don't see a strong reason to omit
information. I think the docs are better now and will be improved
further in the future. Lets not bike shed too much on docs wording.
It's painfully obvious invalid input is more likely not subtle kernel
bugs IMO without calling out.

--=20
Thanks,
Mina

