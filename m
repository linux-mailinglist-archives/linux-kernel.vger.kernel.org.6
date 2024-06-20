Return-Path: <linux-kernel+bounces-223388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451D9911225
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E46281CA7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5A51B9ACA;
	Thu, 20 Jun 2024 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jFgq+0Qh"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1311B47B0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718911923; cv=none; b=DLHkF3KBFUyOo3INOdEIwe9dNY1ft1k+7oc94KVXoStBW/qNpYTT2Md1+DK7r3VgBHVPajlbdtKo3rAaeizpuUhdoJ7gvx2dvp5fqx5NMOv9uRGdyaEYhjBDRzdqSvDn37RAHfkBSSRXvHEHlcLB+ZCMbZEsFCZbvgEMTyfDvsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718911923; c=relaxed/simple;
	bh=7rH6ocXQ6md0ogCPmWYTRoZt7UcBXqJMGUr8pOD+13c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMiMyEbVxu1mHLmzenipMIvPY02qu6T2AcB5zoPTpkZ2g83RbD0gqW8BYRNese3Z+0ie9bBnHqVoYN4gZsrA5RoB2fc9Mu65GCZ+1PI0YIuL26LdzGqNFNbNQAZ7Woa9zvTnFDieUoPeSlQekg9zLSYFxKEj5okopeUnAmMyOUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jFgq+0Qh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-362f62ae4c5so761732f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718911920; x=1719516720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3O566UWxDabtyjph9VFA7tB9oYSkksm7L3FfctdN99o=;
        b=jFgq+0QhlMR5UKEoq2nfDET9vn2rS2dhIdcUvY3NywycytBERaAD/U2uR9Kt4qsEwU
         hnUXdK3v9H6FVhmnZN3NN7WS7wMLZMLu6UijyDDU7Z+8N+H/dNO7ppGi5CgloAS35OIM
         KtdZJROwzgy6BArTbfY5XRu37hZC//TyCLAY9EPFR1jz5C1/VuEyWcKz2/18QveI6Opz
         W0qd5xVrTcYtXuPgrgV28++hJO2/eqWmKH3oO8qHMJgozbmW222qAzUY11+hvcRqWnRx
         raWK/kEVWepKu9UL1qfBIIVFE5oouSd/q75Uh4gJPXUQfwnHFk4WJ6PsAgHkicJNzXUP
         JOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718911920; x=1719516720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3O566UWxDabtyjph9VFA7tB9oYSkksm7L3FfctdN99o=;
        b=g4ZpZaanKndVMApIfN44FxDpcnQCHgkXtr/+k6KUbMHWfetOenZb+bCxMPAUfj9O3S
         YLowMtZFlINkM8g5GGMlIFiPfJ+H6dOz8RKapVvtgIh4b/jA29f+uCwR453ySqT/kY3W
         Sm2Z0l19i0Z2kpgB9+BokTsOGwlW6m+z0cu70Xw/GJ5uv+jVLq7HzktDiglTSU5E5QBA
         9d1Zj4v3dZ2srzwVeHC5XHuv70haWk0/wUPBILy2oX1EeU8dB4hJROQxy0DbL2Duzanr
         aDG3OX/mPEpgNQ9SMawg4C6mW4IiNc1X3lDdZ1Ec2MZWyOnVidWji4hmSpFVhpzk35NQ
         584Q==
X-Forwarded-Encrypted: i=1; AJvYcCXg3G3c+EJz6cG23jpuqdsUB2ute6ubizeV7bzAMbEZIXrtBNWVLLJGCCoyuCvI5r/PQ6KyXBAIGjm5MtSX+Z/WpPNsKSnHTVSgPKIj
X-Gm-Message-State: AOJu0YwpetSQuncVHvr/mSZX4JsSjXZuJN0JVCm+fOUSgqyT2W/qGpAb
	3ZG1O52DnAwzuooRq6K2S7O31mL9bPwZx/jxivXS+RWVxksPBv3qCAuTSR0pZk/k+CAtfwsYlIw
	yjaaapXBHjOhTIXPulzPCWr9N52rQLLQyUCf5
X-Google-Smtp-Source: AGHT+IHVqLrYuTkn4xTAztiR7d2LLvztqGHq975Y/kCK38ccFnRNQG3MLZ5h88aQZPd2n8UzJDopYxh2BWKAtoi8x6M=
X-Received: by 2002:a5d:4705:0:b0:363:b3ea:7290 with SMTP id
 ffacd0b85a97d-363b3ea733emr4419410f8f.20.1718911920255; Thu, 20 Jun 2024
 12:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620181736.1270455-1-yabinc@google.com>
In-Reply-To: <20240620181736.1270455-1-yabinc@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 20 Jun 2024 12:31:46 -0700
Message-ID: <CAKwvOd=ZKS9LbJExCp8vrV9kLDE_Ew+mRcFH5-sYRW_2=sBiig@mail.gmail.com>
Subject: Re: [PATCH] Fix initializing a static union variable
To: Yabin Cui <yabinc@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 11:17=E2=80=AFAM Yabin Cui <yabinc@google.com> wrot=
e:
>
> saddr_wildcard is a static union variable initialized with {}.
> But c11 standard doesn't guarantee initializing all fields as
> zero for this case. As in https://godbolt.org/z/rWvdv6aEx,

Specifically, it sounds like C99+ is just the first member of the
union, which is dumb since that may not necessarily be the largest
variant.  Can you find the specific relevant wording from a pre-c23
spec?

> clang only initializes the first field as zero, but the bits
> corresponding to other (larger) members are undefined.

Oh, that sucks!

Reading through the internal report on this is fascinating!  Nice job
tracking down the issue!  It sounds like if we can aggressively inline
the users of this partially initialized value, then the UB from
control flow on the partially initialized value can result in
Android's kernel network tests failing.  It might be good to include
more info on "why this is a problem" in the commit message.

https://godbolt.org/z/hxnT1PTWo more clearly demonstrates the issue, IMO.

TIL that C23 clarifies this, but clang still doesn't have the correct
codegen then for -std=3Dc23.  Can you please find or file a bug about
this, then add a link to it in the commit message?

It might be interesting to link to the specific section of n3096 that
clarifies this, or if there was a corresponding defect report sent to
ISO about this.  Maybe something from
https://www.open-std.org/jtc1/sc22/wg14/www/wg14_document_log.htm
discusses this?

Can you also please (find or) file a bug against clang about this? A
compiler diagnostic would be very very helpful here, since `=3D {};` is
such a common idiom.

Patch LGTM, but I think more context can be provided in the commit
message in a v2 that helps reviewers follow along with what's going on
here.

>
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>  net/xfrm/xfrm_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 649bb739df0d..9bc69d703e5c 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1139,7 +1139,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const =
xfrm_address_t *saddr,
>                 struct xfrm_policy *pol, int *err,
>                 unsigned short family, u32 if_id)
>  {
> -       static xfrm_address_t saddr_wildcard =3D { };
> +       static const xfrm_address_t saddr_wildcard;
>         struct net *net =3D xp_net(pol);
>         unsigned int h, h_wildcard;
>         struct xfrm_state *x, *x0, *to_put;
> --
> 2.45.2.741.gdbec12cfda-goog
>


--=20
Thanks,
~Nick Desaulniers

