Return-Path: <linux-kernel+bounces-400893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 121489C13BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB444282C2B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AAC17996;
	Fri,  8 Nov 2024 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="23cqamfg"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D95D12E7E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731030026; cv=none; b=aw8GD8zJXPEsMYw0KB7EAUkOTe3i/4SKpXCtxnlwFjeSGApbpo1o7ctY9fd4icg6i3bXeIUFq4iU17ENaCKjL6ex4cKhRVE4W/C9scUleje5R4xUYnP00XMZGX6kmy5zOYgjtFZwkglRzUzr2FRcMI6XTZixLPh5rRZhUcwi8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731030026; c=relaxed/simple;
	bh=MzkymF9uy3YM4gdOXq5UOtYl3r3kQj8vdqgmku5EyP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPBtSTqjvJDZKrezBhICGW/X/SSll5R+N/s49bSDsi1KtFVQS1aZZbUc4TT3yurCag/K9m3qhgg428U1Nwmfv1GEKENSWlSvNe7VfkZ7SqE8J1qoe8VvU9Xye/unMOVmA1MPIorLjeVmYW3tGTj8ncN/pLHWcyt4Bwk6E+lEzC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=23cqamfg; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460a8d1a9b7so69991cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 17:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731030024; x=1731634824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukymtuU99EA2ZHEawF4ZEDVUahugSnJbAfUv5oZityQ=;
        b=23cqamfg6ap991dAANMAcLt2+df+oQS2rCre8xevjKgU5R9Uo0MF+DW+vMPBw7PGcs
         UvZVjcfWC1o9k1+7QBhrjThIafXlQ/gyaiZ7bV+QbJWRBPYH1um8AeKgabwFNUFlSQyg
         dBjZZO2hJzLiQTH8B59UlZ1MEVbo41wPCT6tSOCyeli6l13frV6fUnzF9PUf6PwYbASC
         tZIW1ikd95Sy+ruKdsbIWKzE6bgPWUrSvstJ6403/cUDtVJ5wMHmfjEKkDEn3IdwYpVT
         CFts67o1mI5hOAJtGbrG9f0xSgkI3IY07b1gG87tCKhz0+xxYRaxdkEsbRpgvkadPuxN
         kebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731030024; x=1731634824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukymtuU99EA2ZHEawF4ZEDVUahugSnJbAfUv5oZityQ=;
        b=PdCqKkwRLJCMNsVTs3UfMR8D4nkGnH7+MI2yulJcZHGitkoMjUXRwJojJyg80Kzsk1
         sh2ZxDeWpEvact1INdHhyzjfQr6t8d2/SMck0GEROyecHxz0SfPNIB3iZWZiQ2lbB9ty
         ql1nw87rj74t8+SwbnxXg8PP6zQaTkyOjrDXuNap5/5rq6u1hmEVvnhudpENJB6906KJ
         sYOFwUNrE1mqcEV7/FIBl2MCLs0ASmApCWLiLXLwyKQM/MdSAfW5jdZc6zykhv8Erz1l
         z0UvSfnXZTlJw1HeKAUoGSaNOAvHZlOGVmjYdJbR8qXMWQS97gmJIC69+8YDMxjnEuNJ
         uhrg==
X-Forwarded-Encrypted: i=1; AJvYcCWSWdserihJ1xCKQ1XUQ2sB5aMkh1fbUXirV+J5HX7h2JaSi+YwWGl0B6eAncP136QXnN5Cxm8POsgtv0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOT8a//xouDX3evs0gLaY328S4ttZJui0ShDsN6ZRJ7tQtc5Uf
	HYszalx3xXwtGFFGkUMgPIopCInvNOQU1Obasx+UV3aFzuVjE9keB5Oc25egiSVdg2+vnHiYUa5
	H2YYAIHmjPKIaqhTM46tU5OgO3YGmmBTsNnsJ
X-Gm-Gg: ASbGnctWaAOVkm5Bfs1PbJoi92mkOm03iBgG6KmAOjdzvpfIgQ0Srxkl9X709QRq34R
	vwI9NWBJQim/3/smWjRwlbLpaV0Mzewk=
X-Google-Smtp-Source: AGHT+IGicJxLT38a1Pwdnr2fwM9wKrNXdQUwB1Ovyl7XPTZCRjnJPDh/mYMXzzY5yXepQD/gUW3HdeL2v3WemoBDuoc=
X-Received: by 2002:a05:622a:5b96:b0:460:b4e3:49e with SMTP id
 d75a77b69052e-462fa582ef8mr6840651cf.9.1731030023625; Thu, 07 Nov 2024
 17:40:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107210331.3044434-1-almasrymina@google.com>
 <20241107210331.3044434-2-almasrymina@google.com> <Zy1priZk_LjbJwVV@mini-arch>
In-Reply-To: <Zy1priZk_LjbJwVV@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 7 Nov 2024 17:40:10 -0800
Message-ID: <CAHS8izOJSd2-hkOBkL0Cy40xt-=1k8YdvkKS98rp2yeys_eGzg@mail.gmail.com>
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

On Thu, Nov 7, 2024 at 5:30=E2=80=AFPM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 11/07, Mina Almasry wrote:
> > Document new behavior when the number of frags passed is too big.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > ---
> >  Documentation/networking/devmem.rst | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/Documentation/networking/devmem.rst b/Documentation/networ=
king/devmem.rst
> > index a55bf21f671c..d95363645331 100644
> > --- a/Documentation/networking/devmem.rst
> > +++ b/Documentation/networking/devmem.rst
> > @@ -225,6 +225,15 @@ The user must ensure the tokens are returned to th=
e kernel in a timely manner.
> >  Failure to do so will exhaust the limited dmabuf that is bound to the =
RX queue
> >  and will lead to packet drops.
> >
> > +The user must pass no more than 128 tokens, with no more than 1024 tot=
al frags
> > +among the token->token_count across all the tokens. If the user provid=
es more
> > +than 1024 frags, the kernel will free up to 1024 frags and return earl=
y.
> > +
> > +The kernel returns the number of actual frags freed. The number of fra=
gs freed
> > +can be less than the tokens provided by the user in case of:
> > +
>
> [..]
>
> > +(a) an internal kernel leak bug.
>
> If you're gonna respin, might be worth mentioning that the dmesg
> will contain a warning in case of a leak?

We will not actually warn in the likely cases of leak.

We warn when we find an entry in the xarray that is not a net_iov, or
if napi_pp_put_page fails on that net_iov. Both are very unlikely to
happen honestly.

The likely 'leaks' are when we don't find the frag_id in the xarray.
We do not warn on that because the user can intentionally trigger the
warning with invalid input. If the user is actually giving valid input
and the warn still happens, likely a kernel bug like I mentioned in
another thread, but we still don't warn.

--=20
Thanks,
Mina

