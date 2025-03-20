Return-Path: <linux-kernel+bounces-570307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 923D3A6AE97
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAA21890B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563C522837F;
	Thu, 20 Mar 2025 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOgqCeh/"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C14E227BB6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499230; cv=none; b=JiaUYMRSDiwvNtkTq+M6dSQqt07+B1MWQJZTEm2h1sxpYB/DM6rcUPx9eQN1rRJ0+F4m7XA5aXuuWGt+53nJ7EOfxFtLvDOfYDsH1/UGDkSqQvEnIIWmwxg+nvObCMDClatyDV7OwJ60n8r4/JT4CfevXLxSRgz6S+nlSDvgEaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499230; c=relaxed/simple;
	bh=H69w/dK6lBZzFe8CtNTVmt/q4w+i93j6i7vyJs8q3/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ay5GG5zgu+O1cajc9lRqVLvgDCiabzLMshFE5w7Y1zt7qWo+nOhWcinX+XpbGdFROE5kZ1aXG+aoDQsP3yu/bUGTo271lWhMLf4Uy5r3HMU8p64tphFYeVfVuN4vkj/zxQf2jRdxy2oYy5q/id8OltOj03/pAKVjBU2wBCUaL8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOgqCeh/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so1974387a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742499227; x=1743104027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJ3CjqPxZOLFj5zkXxGtp5z65slUkGX4/8QoAE4cz8U=;
        b=KOgqCeh/4izAzVy66E5NU1yjvu6C6vhBo2MdaiAVAC9iu0TEyZ/v2fYj79dmvwsKYS
         OxAKqP8lkwXkmi98mM/DyCweONGZ+PYlyxL7NYDMzaGP0GaKcltsWprvmNE77udQvidq
         lQlhXnHfLnkvYq+PrLTNDeKGGiWCdip+lBFaJB/rm3+38fB8zpQeIi6ZDf3LFQOM7q5r
         S5H8XzJlQOzM9xyA/N7vWtiMONUOFDHFxwnI9CFHTH/5kmOCTXlyS55ijxuCyX0lzJkf
         5/HZKccCRLeirEAGfgmSYTxKqwxWyVpaTuGQK9eSZadSQxPr5IVmh2yCIu7n7jeoEfuC
         S7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499227; x=1743104027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJ3CjqPxZOLFj5zkXxGtp5z65slUkGX4/8QoAE4cz8U=;
        b=rEJaqzzuGZnp5amVEekliMB94+Ol8CaC+Gr0RV/7D9cH2bClRTr6sZKq00OOTnQ7um
         lBlLng61qn96yPqf8Ub4hAQyuuEG4+S0kVpnqC2mqJn1LsVKpupyV8GBmNK4iZhZKMU0
         WhqxopK3qlcViqO6a9T/VCUF06eNEMg9r5yWGI7nXP/cNSh6RhhiXcIwGqhRE0SyNblD
         o5xiU8lKvF20tHaUablNpyJ7eEUHpNb6Sx3eM8oTDEi9UjAzEshPdOTpryEh/t+JoWjq
         aOJ2cd2AKqz/QnVHyILo5pNLi0Ja9/Ga0b2wI+eAfpk9pe0SGIND/K1yF+L+Xz/NHlMA
         NB3g==
X-Forwarded-Encrypted: i=1; AJvYcCULTXAIlFc1/RqEnpRRdhLcn0qc5MR5k+1jtmX7x0fEYd7YmoeIE0cMLzdasU8YV5K0UqlE/dEtEdNv20w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkWxwPwYh5txeNR/sH+yB/nLJkXovlJc8a9Qt/mrRVq3o0maAx
	ndUMlz5GgDYWLfrqpBm8RrUSxrNne7997pMli1NmFUlwK/ULZnSmNPmv5UWqdjm23yTYX/ndtvf
	M6b3ssmWoVnYkDOhB0meRR0wixbg=
X-Gm-Gg: ASbGncvv0xUIF1PNDBlNMYMxeoOoGy+zKfnZK7YU0fOcY3gMGGoEuu0LvqR27Hdg5Q3
	0y4kkUiGIMN5U6xus/5DkKQyM+V1qdUeeHIIuWha5f+sffxMHat9DvwVaJ8Hdv3wpFru42kjcr0
	55iJwT2axAAqhF49ZWhCtPFpCxmg==
X-Google-Smtp-Source: AGHT+IEoJtGHaGXt+B/1W9/TKMjxX1iVOTmidDFYTjagaxFy7ZJ6FaE2l5M0hsf4bNLxMN72pe/e8OPbQXK+TjG+1UE=
X-Received: by 2002:a05:6402:5190:b0:5de:cbed:c955 with SMTP id
 4fb4d7f45d1cf-5ebcd45f681mr512243a12.17.1742499227040; Thu, 20 Mar 2025
 12:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320190514.1961144-1-mjguzik@gmail.com> <CAHk-=whd82fzhEbFRw9d_EMtR1SeefOJabjCHcm4-6jzeqqd3g@mail.gmail.com>
In-Reply-To: <CAHk-=whd82fzhEbFRw9d_EMtR1SeefOJabjCHcm4-6jzeqqd3g@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 20 Mar 2025 20:33:35 +0100
X-Gm-Features: AQ5f1JqhDFREplKa8qDUGcWjvE2bSGMP6M86i3aXdjpcYdtx6Ut3SNBGSOGtnu4
Message-ID: <CAGudoHGNFT+LC24842ZKLWBxD3vvvddBqDKa6gkixN4Esor+RQ@mail.gmail.com>
Subject: Re: [PATCH] x86: handle the tail in rep_movs_alternative() with an
 overlapping store
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86@kernel.org, hkrzesin@redhat.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, olichtne@redhat.com, 
	atomasov@redhat.com, aokuliar@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 8:23=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 20 Mar 2025 at 12:06, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > Sizes ranged <8,64> are copied 8 bytes at a time with a jump out to a
> > 1 byte at a time loop to handle the tail.
>
> I definitely do not mind this patch, but I think it doesn't go far enough=
.
>
> It gets rid of the byte-at-a-time loop at the end, but only for the
> short-copy case of 8-63 bytes.
>

This bit I can vouch for.

> The .Llarge_movsq ends up still doing
>
>         testl %ecx,%ecx
>         jne .Lcopy_user_tail
>         RET
>
> and while that is only triggered by the non-ERMS case, that's what
> most older AMD CPU's will trigger, afaik.
>

This bit I can't.

Per my other e-mail it has been several years since I was seriously
digging in the area (around 7 by now I think) and details are rather
fuzzy.

I have a recollection that handling the tail after rep movsq with an
overlapping store was suffering a penalty big enough to warrant a
"normal" copy instead, avoiding the just written to area. I see my old
routine $elsewhere makes sure to do it. I don't have sensible hw to
bench this on either at the moment.

That said, if you insist on it, I'll repost v2 with the change (I'm
going to *test* it of course, just not bench. :>)
--=20
Mateusz Guzik <mjguzik gmail.com>

