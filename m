Return-Path: <linux-kernel+bounces-260519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 076E093AA79
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A471C22DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC13522A;
	Wed, 24 Jul 2024 01:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gHzxUekB"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271FF5221
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721783717; cv=none; b=F2Q4zhEkFwpjYPR/0eFWegkXmKPVVxaxuuiv80dZ4oakoP1EYI5SIMrnjHYF7d7X5ZgpwSG6WopbedPQ5F59wSBaDHTfmVADBC67XaRv8Zxnwyv9l49ymwZUKk6uIPafjTFZexsuooclA5Q3IG0Ytwbo+9Ojtbwn2NWx7ZhfgXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721783717; c=relaxed/simple;
	bh=D+8TjssjLwBBt7vo1blKu5GUtFcDJ9I2gH1+mG2aUCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtrMQoxOs/psZazCS1Tja118NLxsASINjhUL0oROhdTZj7yuQpGHIfUXZ9jgv80Ha8mPUXYAYcUwCxMs5ukPCidg9e3/O9lMutjKfzwM3YhMvrHNGskBgeUZZKbONnK6wiVXAFQytdg3zSWbNg9M95ZyTKC6DcQbr8BXh/QILl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gHzxUekB; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso27841521fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721783713; x=1722388513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVQ5wUBI39PYXrV/PyTM3Jln11fiyXDUUxbA56HJ+B0=;
        b=gHzxUekBRTZmhQRgBeXEfiZ/nrYgZaK9jHcdBwZkmc/G4LFKLDt0gNyEqsDauL0xCg
         MPkbfnJZv8Yccki0FehRBADE4y0xQFKrnJRvamQoWipIvAQCsQZIB4eI0NNTUZnBcNYn
         Okwn9SRAlEfvuik30RGF+2l0bIeQs3bSSwpyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721783713; x=1722388513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVQ5wUBI39PYXrV/PyTM3Jln11fiyXDUUxbA56HJ+B0=;
        b=t7CX2ZnCixtfkFIAAngF3URmVnJ5+62BzuZj/Okyqf0vdYzsQr4FR4GImvoX5StAuv
         HVWO/60+aizzJwFJEoRh3dL+7v6RQBu8Hip+hGxAN0kt8ceg6qzvhUqjWf6Ch2q/GTYC
         awpOMOpx5IN1wjHFh1THr3rmh584RaqBb2iivw6C/ZujNoSe9AdNnniuwEU8yZy8j7Zf
         UsTA7fsj76CNypptRkJqrxGklf3ln9vroQP69G453aC/gUtrGBjEBfFYurEg/A0lw6gN
         LNebL+zPc9HFVAFbnWOQLbi89IFANIsYeWpfbMUnVQkX2PKVR1EyDWkB4v3ad3EYAA/2
         OfCQ==
X-Gm-Message-State: AOJu0YwkQxo/v+/JiawPgE19dJKDLD+7I+sFuu3Vy+sMYTvXNhk8IDYV
	077c2IsscvSVv4Ta08vngBoDK3LTjuU41uvK+s1h/KKPYYx/xrDAtBYYeyzeEBX2Pxpj3+zOQ2y
	Ip+V86Q==
X-Google-Smtp-Source: AGHT+IGQ7mmV0eVv8GuC9zOUtyNsgUDhzFMIh4h0yduasLjMYv1GunjTxump5nt1LtD8ffjfkkh8og==
X-Received: by 2002:a2e:9e46:0:b0:2ef:2855:533f with SMTP id 38308e7fff4ca-2f0324ec793mr2694981fa.16.1721783712938;
        Tue, 23 Jul 2024 18:15:12 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f01a3af7a4sm7372131fa.28.2024.07.23.18.15.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 18:15:12 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eefeab807dso72007681fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:15:12 -0700 (PDT)
X-Received: by 2002:a2e:8697:0:b0:2ef:2d3d:3cc3 with SMTP id
 38308e7fff4ca-2f0324d88f3mr2748571fa.4.1721783711760; Tue, 23 Jul 2024
 18:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGceNzwdb7w=vPf5=7BCid5HVQDmz1K5kC9JG42+HVAh_g@mail.gmail.com>
In-Reply-To: <CANP3RGceNzwdb7w=vPf5=7BCid5HVQDmz1K5kC9JG42+HVAh_g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jul 2024 18:14:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijWMpPk7feEZ8DzdLi7WLp_BhRpm+qgs6Tew1Bb2CmyQ@mail.gmail.com>
Message-ID: <CAHk-=wijWMpPk7feEZ8DzdLi7WLp_BhRpm+qgs6Tew1Bb2CmyQ@mail.gmail.com>
Subject: Re: UML/hostfs - mount failure at tip of tree
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Hongbo Li <lihongbo22@huawei.com>
Cc: Kernel hackers <linux-kernel@vger.kernel.org>, Patrick Rohr <prohr@google.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jul 2024 at 15:33, Maciej =C5=BBenczykowski <maze@google.com> wr=
ote:
>
> Reverting the following 3 patches:
> - 104eef133fd9 hostfs: Add const qualifier to host_root in hostfs_fill_su=
per()
> - cd140ce9f611 hostfs: convert hostfs to use the new mount API
> - e3ec0fe944d2 hostfs: Convert hostfs_read_folio() to use a folio
>
> appears to be necessary to get the Android net test framework to boot
> with tip of tree,
> *without* the reverts we get:
>   mount: /host: special device hostfs does not exist.
> (if I don't revert the folio change then it mounts, but appears to not
> actually work)

Interesting. That folio change was clearly supposed to be a no-op, but
isn't. Which makes a revert the right thing to do regardless.

That code was odd before too, but clearly that commit is completely broken.

I think this part is buggy:

                buffer =3D folio_zero_tail(folio, bytes_read, buffer);

because while the documentation for folio_zero_tail() does imply that
usage, the third argument is supposed really looks like it should be
"buffer + bytes_read".

So  instead of reverting that commit, does it help to just do that instead:

-               buffer =3D folio_zero_tail(folio, bytes_read, buffer);
+               buffer =3D folio_zero_tail(folio, bytes_read, buffer +
bytes_read);

Willy, that function is really bad. It's not helpful when it
apparently confused even you, and the calling convention really is
broken. I think that folio_zero_tail() needs to be rewritten to have
sane calling conventions (like matching the docs!) or just die.

The mount API change is somethign else. Again, it wasn't supposed to
break anything, but clearly does, and so reverting it sounds sane
unless somebody sees what the problem is.

I'm not even guessing at what might have been wrong in that mount API
conversion.

           Linus

