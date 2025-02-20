Return-Path: <linux-kernel+bounces-524324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD15A3E1EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD663A48F0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57810212B02;
	Thu, 20 Feb 2025 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp1lqxQY"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF041C5F26
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071155; cv=none; b=N+IRPugeD9PSRTxKwLALqNPkxjYMiS7DvvCJs8AClyXcWnV5qCegH1gWHQ/2eL6LU3MU+9i+IdSFlSkLk9Cc0zk8zt7Sl4vIiUND6CBNMm3eX1kx4GsV817d2RSrugTswyrAYshJ+YgGlEJAR0BHTK1YNyOQyyo0qLTRMswJ1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071155; c=relaxed/simple;
	bh=bJlowZ0iSqUS6kngqAMlL3TU5kMrUs1Dk75f7qsjxBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOJqR4ChmZOY288WVsVfp5Th8HmPcAeA60k72n0rruFaY1QulVSb9yut/cf42v3w3gXt87lqIlvjMXAZG50W7DCU0svxNhGuftyfMJNc7xCKU++8cO8D9m+Y1+BVbu+N5H+lRXmW21BodabzHi12sEnsuoSEU/7ANIlGdWh2FYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pp1lqxQY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5462ea9691cso1343356e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740071152; x=1740675952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfeMZTQKy6XPCUQt3DsDTx5q3kMNEgxvMLYJua1RFZE=;
        b=Pp1lqxQY2F7AJDvFqFI2zEbeG+dXiPftL1r4uDHL4E5XZ3l0TkDXiSm9rl652edQ++
         tc5CE0/4He4gRkFi1CgBZIf6baG4CCbJsyCczbcqha0tb7/iNZ8W6wlEXwj6hpM8MlGe
         eU/QZopMwSlHgyAJt+rzmZuHZOijrnTzorIOfhRE5fXhSmNdliL0jLyCv2yIUiUQEoCp
         xmL6BmFtdeqNe9gYt2seICKyktuTGwHT8KiZTGysc3m5Dd0mzgI9WiDw6Offc5bgvVvp
         tDdLDLyinNlEW+4VtcTUsIux8zVLNNq4Z/ne0xg4Iy5SpWQKOo8tsUKPsYJNSLuamXJf
         jHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740071152; x=1740675952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfeMZTQKy6XPCUQt3DsDTx5q3kMNEgxvMLYJua1RFZE=;
        b=riLoUXLroQawTsz1lmvambhRxNtr7ZY/OZIxj5lTBymBFCn2X5X+dU7zP1db8QFEsu
         SsvVD6ln2F/dazi25v9j+tUQ90FDyV+AVsCNFfasjF7fd18vjNjfGRKaeO2yQ5SvOVkE
         PBrN0TbjOM75Vok7f4uEVeX+G8Pib8wfTg6AWugZqYw8QLPu1bBt3YJVtZ4GSA9wPlgn
         tMzUeFmUM4db9SCrnkU8cYxtY9cmEcRTcE+kAeX89A8VJbJnVVzn4BBJbY2Le6rIe2YM
         g4uoGId4KjinZVpbH2laQughO3MWV5B+XBOj7yPhTZR45K6ZKiL2Yx9BpqVVywAWY4E1
         Xa5g==
X-Forwarded-Encrypted: i=1; AJvYcCVIqs7DyqEm6HP5wgma5vq9X50JJceVH/1UOD7E8GZ7SIoF7wNxUyYVRV5bkjak1vkG7B4t1UjXqnVOFzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGDTHxMyMCm1Ynndud6oIOqw+H05Xt9e4TX7e5lA2OaOmYHoZy
	hx2PCLHseIp+CDAJG/GGc2bicDHihy66iYlzpC4YkxM0QKg2fS/FtILA4j6df93f3o/wlno7aD0
	Yg4825hEE2Co8VIf0wFpssMymyg==
X-Gm-Gg: ASbGncuCzF1om82Zo7R4fSS0pHqRHdGzhbt5zpfdsuTc0R35b1vRyTVtvSH8ONTcVFV
	gH9bKvPbHLBuiZa/cOxBNSjdgZqKSfQJ+E6ro7dwTNUp4oMbtTU+GltK1kWdaJqJSxzzOUZ7hHi
	iY1X2D+xQShZE=
X-Google-Smtp-Source: AGHT+IG/QuT9I+oIRm/lV434Pbkvz/uKTigRRlIyfuUfYHgcOCiIoKbrdl5ccikgSYnjygMag+JeT9KPzWd4+gpsiQ4=
X-Received: by 2002:a05:6512:4004:b0:545:1e2d:6b8e with SMTP id
 2adb3069b0e04-5462ef1588bmr3055735e87.42.1740071151966; Thu, 20 Feb 2025
 09:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <Z7RRZ0jdqsrADMm0@gmail.com>
 <CAFULd4Z_QoOLKCOawyeFtRe6V4+oaaGxfQxav9dS-Di-Ne7tfw@mail.gmail.com>
 <Z7XE0P6ZFHxtlYXw@gmail.com> <CAMzpN2gyhEnYsimxLhLNPc4HTpVdRGTiBfm9pXiFTL6_3-O=sg@mail.gmail.com>
 <Z7ctmL3HDGxzyX0g@gmail.com>
In-Reply-To: <Z7ctmL3HDGxzyX0g@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 20 Feb 2025 12:05:40 -0500
X-Gm-Features: AWEUYZmB2DMqgpDKMaWCXoqygnfYCtjcXCZ6N0ZEa-r95zQrRTlmgnAtJjLIiCs
Message-ID: <CAMzpN2iwtA2fuNgBU2rrQzuUUD57_=fVzngn7AaJo-UAnJvVoA@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
To: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 8:26=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Brian Gerst <brgerst@gmail.com> wrote:
>
> > On Wed, Feb 19, 2025 at 6:47=E2=80=AFAM Ingo Molnar <mingo@kernel.org> =
wrote:
> > >
> > >
> > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > > > Thank you for doing this series - it all looks pretty good from m=
y
> > > > > side and I've applied it experimentally to tip:x86/asm. I fixed u=
p
> > > > > the trivial details other reviewers and me noticed.
> > > > >
> > > > > Note that the merge is tentative, it might still need a rebase if
> > > > > some fundamental problem comes up - but let's see how testing goe=
s
> > > > > in -next.
> > > >
> > > > I wonder if there would be any benefit if stack canary is put into
> > > > struct pcpu_hot?
> > >
> > > It should definitely be one of the hottest data structures on x86, so
> > > moving it there makes sense even if it cannot be measured explicitly.
> > >
> >
> > It would have to be done with linker tricks, since you can't make the
> > compiler use a struct member directly.
>
> Probably not worth it then?

Actually it wasn't so bad since we already had the hack for
__ref_stack_chk_guard.  Do you want the patches now or when the dust
settles on the original series?


Brian Gerst

