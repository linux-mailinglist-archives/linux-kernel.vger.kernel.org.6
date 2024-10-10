Return-Path: <linux-kernel+bounces-358988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6274C998608
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F4A1C2408F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36DE1C0DFB;
	Thu, 10 Oct 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpPSegfJ"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD451BD00B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563472; cv=none; b=HaDZboGxsvPNyjWGNPiHox8hxVLLmoqN1X+uyO65gw2E1qB2kyzXJ5sEVDwpAFa0vxdCzNjS9qVvKwQS2NTNWXfCAH3In5FDHsHBhsGIHaAcN8WNA2bVCNOTFbvnFJzekKPJrufP5U/W/zOZ9zy6RI7TwlkwPMKk5UOibRAAM1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563472; c=relaxed/simple;
	bh=7yDSV/d/16rmpv123ZpKgyWbjdNAaxbAiFpXXJNhqv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTGhcOzj2h4sezFB3oKoMmfbi3zbPuRbga7tSl9hMp/IW3YWvDMR0OxptklyzUS5LJ9PAAcxmT/oR3Ulc0EeF1t+Eu86Y2Q+1NNnsiVJVhjB+B4JSxBD9XjA1bxQaVt49/Fgq8/StpZmAH4FRZxcaXM0m6up5MM9SJ/oW8uFz00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IpPSegfJ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398d171fa2so1077735e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728563469; x=1729168269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yDSV/d/16rmpv123ZpKgyWbjdNAaxbAiFpXXJNhqv0=;
        b=IpPSegfJFRwjDdQrDpenfsrtjqbtLAlTCh3DaYUfzv4bzM9bfVImq2f1GV+7KzDktL
         T3wlTEBOINlyfd14aK23q4MpugZmH74cqihi6HE11pWkfImYC9tZIuLAd+Xb/k5eiqq9
         6RpdvaOE/I8zlVqN7ViCdLfBvjtdb8F1XFUmTxKO+yIdHdXgc6cvEBtx6oD9dxzO7s4f
         df5pWtH/o5jA4CuBCFE3Dp8ZWx28L416KNgjb7VOuKnjVhlJZna6jK2kNG+i8QQgcod8
         41B9a4RUSOwaHYOpMJyo1bTQhVw1yjbi8GaHbMuLYLDmQQW+/hc6EdCEmt1vUhhhBRBZ
         zAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563469; x=1729168269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yDSV/d/16rmpv123ZpKgyWbjdNAaxbAiFpXXJNhqv0=;
        b=gY4ZzgaTKaStX5cG6aQcJ5thtRkppflzksZam+NKBQLyGbR0HiBPmPwgXTC7lh6nkr
         2L0Nfz2nSL7pnKP5RuZTDUEhF0OgpFp7CY38sKPu/hTA4wMr1e+7nCvefSIK2PFu5s4B
         A14HdudkOY0drsAELR/Ai7Q7u3oHDwB6ruSbjqfuouaQVLUXhklH3sesyKyv5v2l1cEt
         4t2Btf4l1N76sRq6A6kw4bEwuOA1FFYFEtTzMekdT9TGJJNiQ5oQKrFNE6xU2+8X912G
         1k0Hh1hdw5vk4Pf2IVj/1xzKrNcGlkPuFddEYtMkKXwiP4kw8tf+5me3KgG3qA+YjLMP
         VyBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvelVjQm5uIaZCQypEhb72ZqWdnltWGD1RmnTsQXNg8Wo0EmVjyE08gCTraUk1Drx3zq84hzpd33fAnoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwHksDh/W5qk3+7R0uWCo3gHwhN8l85ZRyqTLyC6dm1zv4qwDP
	2Bfi9/04lwBc+A+VFc6J2ybNQSvSiYvpEtG/mE2/cZvp7auk94j0dIZvpIbnxwwoz1iMks3sR65
	bEV5W246uVH5+DaKPsIW1J1M1AZ3vA48kl605
X-Google-Smtp-Source: AGHT+IH+nJwAeFusphQHMdXSoWeqyiS0qj2RzKgb4yE1ZUoWStDR1k3SZj/wGE9Rp2fA1xw2z/4SxhrMG1va3Kk3bxg=
X-Received: by 2002:a05:6512:304e:b0:52c:e1cd:39b7 with SMTP id
 2adb3069b0e04-539c488e56cmr4358519e87.5.1728563468643; Thu, 10 Oct 2024
 05:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZweN3SiUk4bK9N7u@ly-workstation> <CANn89iKNZ4AZVYfxzhGWnx82T44_7tw5P63-TE0-GUn+sTRkZg@mail.gmail.com>
 <CANn89iKvrv+-yMRwmyb_bjus6sN1hOq+QmOwvpCFU9G0UzkWNw@mail.gmail.com> <20241010120219.GA30424@breakpoint.cc>
In-Reply-To: <20241010120219.GA30424@breakpoint.cc>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 14:30:55 +0200
Message-ID: <CANn89iK0a_h2KdGekLdvYKrxOyzwW=L2u33QscDBKH1zKwTdQg@mail.gmail.com>
Subject: Re: [Syzkaller & bisect] There is KASAN: slab-use-after-free Read in
 __nf_unregister_net_hook in v6.12-rc1
To: Florian Westphal <fw@strlen.de>
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, 
	yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 2:02=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Eric Dumazet <edumazet@google.com> wrote:
> > On Thu, Oct 10, 2024 at 10:58=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Thu, Oct 10, 2024 at 10:19=E2=80=AFAM Lai, Yi <yi1.lai@linux.intel=
.com> wrote:
> > > >
> > Florian, Pablo :
> >
> > It seems that bpf was able to defer the __nf_unregister_net_hook()
> > after exit()/close() time.
>
> Thanks for the analysis, I will send a patch later today.

Wow, this was fast, thanks Florian !

