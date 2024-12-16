Return-Path: <linux-kernel+bounces-447780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1639F36E4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357AF16D2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71681206F30;
	Mon, 16 Dec 2024 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5wYv8Wy"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815A1CEAD8
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368200; cv=none; b=QJ8vrTIc2gp3aKfD08ABnE8I87ehPHm86++y/53R32Q7ZTi00+m/CJEDop9zRSdlvr69hUWcKQlAlLf2BMpbE044bg1l4gpz6I+5+qx8aZPWKMWkRwDKQHCPD7fOb3hRjS/fUAcXy7xak+ywUVOzF97zz1KpSaww7XK0hE2xIBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368200; c=relaxed/simple;
	bh=TkuDBvuCOxqouLMJGu5YpZBJoLwlOyDg5Zs782IMdVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UD8Gs8v01xDiJLsJnTVPkykbDEF33fYbYaIkp434+RC1mxPgQygs2gcQK/BMVMKxS4rZ4uILmD+HXQ5ND1rrkp/lJYu7GLoefsiu0QI7Mkt5EJS5g7kFEaNXUd9lC/u53mJu3rHN+S/QorDLV4lxy01hxgbTKRrktwhoo2o9FxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5wYv8Wy; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso52562111fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734368197; x=1734972997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkuDBvuCOxqouLMJGu5YpZBJoLwlOyDg5Zs782IMdVg=;
        b=Z5wYv8WygFkSsZP45aIpP3pGVreEEm7FymQa2tlCZ8//fzw8Eh2Yl8TOje4wIj+0su
         KCbMkA4XF5Flj+I/kiTHh7TFx2AWj+jxlnrOAb3WtXNB5O8GsrcBXLt3cPZ47NHTr+xW
         YZtyC/GoB9/ZqdTzhBKNi0nP97XAGET/jTgsTivLwRA150DIt1nsLQbSrlauwbuhFkee
         cyIU9ckcV94efq7xYgVZsGNLjUbyyWtUZqN79dK0tQxbJCsVWCrjIIL4OrIBZKAg1+Tm
         K16JHhoED7j9FhskYcRWp9b43/kZaenu+svBqORPT0mr1d9TTd6lVx2DeYYu6xzxDVX5
         51gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734368197; x=1734972997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkuDBvuCOxqouLMJGu5YpZBJoLwlOyDg5Zs782IMdVg=;
        b=AWWtedmiRBRWDS0MSBMy6XT+pS4tq19NVTD8C8DuiL++K6zEnM6nSgeHsv6C4t6fIC
         csTgAUzsQLK6RWZh+JCvKj+x4WzJWQER4Vri2XJYKiG17pyYW2ouy8wPdQDWLSB90PTH
         lbfWRgT5AZIgTnC3Yqjs4l3otjvEP09siJs/Lcbjff475WSNwxLHOxmXGNGk/yK396vp
         7wRLRyWxGKjYLVE/jTc8v8QfxTTXmb1KZPSHBswJn9EMfTEuTQps1Hx9UX0clrAP+JSo
         AG44gofhi6ZUw2+Y48EbacKmOyatzXZBZvN+v2eArLh0WYb6Ujjmys4bkE/wtWpliSTh
         028A==
X-Forwarded-Encrypted: i=1; AJvYcCU2fB5aCXhV/JpQVa5A+V10VmlUguieraygXshjXJafc6DbGdH+hvYu30d3yzrhRsmYQFqaZqLZXk6QM5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyozYhkvwt4QZk6BrLHFKkiFylOVxtz8luaT78YK8xcCSSCS331
	IurxCrRD9oRf91GVZ2PJV6i/jUpkgtiv6vWwQp/3hAOgt4Nq/qdmPVIhtaC0FPmEN0xoOrgvcye
	m5C+hH/LaJk9iiF0W27ivQhDmBis=
X-Gm-Gg: ASbGncu7grn70PaJj8NB+NNEXrG7dooc5ZritbU2EZPhsU62ocgOJ//P1k8ZJyK2OFU
	taTqqLZIKLfQjCnRvk4HT+aHtAI+xQD4KuMlHnQ==
X-Google-Smtp-Source: AGHT+IHuhggV4M/ir+1CBgRIUhzghpFAF4hKHdMyJXdsl2HuFvEDdOvAG6/6dSYVCk80LZDxdeIWt390zGvtL2A/duc=
X-Received: by 2002:a2e:a58f:0:b0:302:1de7:ef3c with SMTP id
 38308e7fff4ca-302546115c8mr46722781fa.31.1734368196746; Mon, 16 Dec 2024
 08:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213190119.3449103-1-matt@readmodwrite.com>
 <CAFULd4Zrnn=1=1AP329Qw23b0Ume2A5Z-U2q-M62L1gcpJD4pg@mail.gmail.com> <CAENh_SRw-L3UtBiz2xg_X4szdMJmNg118gL8f2g8gN5w6hc3Nw@mail.gmail.com>
In-Reply-To: <CAENh_SRw-L3UtBiz2xg_X4szdMJmNg118gL8f2g8gN5w6hc3Nw@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 16 Dec 2024 17:56:24 +0100
Message-ID: <CAFULd4bwLyGiJ87fvT+N06ANchEQ0aGZdLvT-U3C8ROwCADr4Q@mail.gmail.com>
Subject: Re: CONFIG_KASAN triggers ASAN bug in GCC 13.3.0 and 14.1.0
To: Matt Fleming <matt@readmodwrite.com>
Cc: Ingo Molnar <mingo@kernel.org>, Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 5:20=E2=80=AFPM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> On Sat, Dec 14, 2024 at 1:17=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > Does your config include CONFIG_UBSAN_BOOL=3Dy ?
>
> Yes, it does!
>
> > There is a rare interaction between CONFIG_KASAN and CONFIG_UBSAN_BOOL
> > (aka -fsanitize=3Dbool), reported in [1] and fixed for gcc-14.2 in [2].
> >
> > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D111736#c42
> >
> > [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D115172
> >
> > Otherwise, please attach your .config, and I'll look into this issue.
>
> Thanks. Disabling CONFIG_UBSAN_BOOL does indeed make the kernels boot aga=
in.
>
> Should CONFIG_UBSAN_BOOL have a dependency on GCC 14.4+ ?

No, this is a very rare Oops that triggers only with gcc-14.1 version
and only when both KASAN and UBSAN are enabled. This is actually the
problem with sanitization of the percpu address when named address
spaces are enabled (IOW, sanitization of __seg_gs prefixed address).
UBSAN creates a temporary in memory, but forgets to copy memory tags,
including named address space qualifier from the original. Later ASAN
sanitizes this location as a normal variable (due to missing
qualifier), but actually should be disabled for __seg_gs prefixed
addresses.

Your report is only *the second* since sanitizers were re-enabled with
named address spaces. gcc-14.2 that includes the fix is available
since August 2024, and since sanitizers are strictly development
tools, my proposed solution would be to simply upgrade the compiler to
gcc-14.2 release.

Uros.

