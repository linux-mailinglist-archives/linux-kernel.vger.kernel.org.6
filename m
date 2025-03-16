Return-Path: <linux-kernel+bounces-562922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B06A634B7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 09:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA357A7285
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 08:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FE01991BB;
	Sun, 16 Mar 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVVtjxI7"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91513A88A
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742114441; cv=none; b=cuCNG16kyBjG3rH6e4sUhfsqEeYTy6K+DyLfFwPIyjJKHqoWlBSUOyP9rV2I8teBYjeDus9rqucMO7S7v5FhHzLIzPc4E3x+islFDXI0hJz9IscctRSXOpm37oZp/49eBHDMr5d/CBPIjobWm2glMfIdSShfk9Qsas54ipto7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742114441; c=relaxed/simple;
	bh=qV8xqOkZY9m5MNcUhWV92QjERdG1Ci55GjQy7jAGHeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lpme74Uir8ARkvmu+rWv4vr7lkCLdvsAc4Nk4pDq/uj2+L3Um7wVXOuStRuy9sgWcwTQFz23PlGqz8bXRzGdkHg8YlXUmjUo88nTB3RtbtyLVQyza0p/K2wMdCcGNH25M9Q3ttloMT3irSR1sHXQIiAuU5emgbeFSYXHBLYBskY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVVtjxI7; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30beedb99c9so31442841fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742114438; x=1742719238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV8xqOkZY9m5MNcUhWV92QjERdG1Ci55GjQy7jAGHeM=;
        b=gVVtjxI7YKn2EJ4fq36uOGs4HE7H6FJiXZbh+pAltHRcVjMpGXtt0G2CAS4mTRtU6w
         KcZtHuzc36trhNysX52BU7Zh/eFKzBBKuV8Yk9CYoJ/bgrCoJ5t07eTp+tgNXibo4yjf
         e1wsbFBbtNpMIhoyGbbWphJhblCF1MsUeVIQRrox94FqyQFYF+cBC/ahZWrSQefk9oQd
         ZRnerPBDUuZ2t9t5TxOcmt8o0mv9/MVLCZtEgRyhOWzpG/Ed/RK8P5ySCDRSvBLdDDek
         qX11x9sC00wV8REkOdQJ+k2ZTQLIyghryzVkjcU9P2m08WoaoOFSuzq7075OlcoXogCd
         Z4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742114438; x=1742719238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV8xqOkZY9m5MNcUhWV92QjERdG1Ci55GjQy7jAGHeM=;
        b=Dy3uyub6Tl2gAlKxbN+MipFgOOhb73G9aLUQuk/bZe29Kif59GWgjARsEJxzX1zZ9E
         wkG/qyiNuPbZrWKHR3ZyWWMEv6S1sPEBZrCL6cjwxyTH+mualjDoBLlQu765vjdynAq7
         dYs36PT8taTRBH++XF2ZQKm2Nn48W7r12pnqkv9s75xgJsmN6aV/P5H9+jAkWx8Ak8SV
         24RXwRbWJ8/V/8rbTVyg8lq82AnB9789J+mkLsZ/iK3m9sv14+UcOHCsZuli61oEWfBg
         Khuz2Q/4lk3c9MtsAqNU9VV9m/2GQTAt6iBlXGRznHRa2fADL8aWWEzCVPAqS4XewLEg
         cqRA==
X-Forwarded-Encrypted: i=1; AJvYcCXWT92HsZaq4OwzkS8nRmts1q9aGiNgDkPstJLxB9ZFMmvgtoP3bGTHQ+4Jw601JHFgdrVnzmIQgx3w4dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1xs/OmR7OO20ZeDU4sV8s4CIAyAiFwlJR7KCpUoJHuzsp1E7O
	U0T+W679EAIY8Cn+oTHFwbRPfonxwBnIrUe4QHe4tE0K10S0B+GtWil55NVVTvWr6fxZ1myQ5mw
	ZoH86RIizM2mFtm7KXvLM/LAA5ZY=
X-Gm-Gg: ASbGncteXTZTk0lt6mLI9OqBNSqYK+UFZr2lr8S+Nt26WbyCJWisI88Dp3lVbD0InJl
	Bvhr3uJwuyeM8xuJk2Q5A5fKPZYJ8pT8y6LdQM4nML4wgN4B5QHRtgniWwB05LoIIQgQcfU/Np9
	xERud9Pb+YiTAtL8FusNcjOtmCAw==
X-Google-Smtp-Source: AGHT+IHuRnhkruh3j0Pp8U9dvpQ9IbGTGNWphVH+gn+a0OXH16XIdy08X7v5PpC0UbJWyO8nt7KAqjuOnmXqM+jsLiE=
X-Received: by 2002:a2e:9805:0:b0:30b:d073:9e7d with SMTP id
 38308e7fff4ca-30c4a8fb0d2mr29750091fa.37.1742114437663; Sun, 16 Mar 2025
 01:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314081453.565859-1-ubizjak@gmail.com> <20250314112018.GAZ9QQ8hPXt2Mk22cG@fat_crate.local>
 <Z9XxNbdLCZFiK1NG@gmail.com> <20250315213655.GFZ9Xy986YQZCeK4iX@fat_crate.local>
In-Reply-To: <20250315213655.GFZ9Xy986YQZCeK4iX@fat_crate.local>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 16 Mar 2025 09:40:32 +0100
X-Gm-Features: AQ5f1JrYVG-Yth6fJbofBxDuRJ0_lWEQj9OjFJsrwiKq7sZZeaCJG_3zvzt9BO4
Message-ID: <CAFULd4b+sX1cRHrO-0=1m-yV8WvdJPEW=-ZSmj5EhE1XUnLt5Q@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Use alternative_input() in amd_clear_divider()
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 10:37=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Sat, Mar 15, 2025 at 10:29:25PM +0100, Ingo Molnar wrote:
> > So why does the higher level alternative_input() API exist? If it
> > shouldn't exist then we should remove it. If it exists, we should use
> > it consistently instead of open-coding its equivalent.
> >
> > Cleanups like this, especially if they are clearly part of an effort to
> > improve x86 code generation in this area, are not 'code churn', why
> > would they be?
>
> Because this is not improving anything, IMO. It is simply writing it
> differently, perhaps obscuring it more in the process.
>
> And I, just like hpa, would need to go look at alternative_input() to fig=
ure
> out what really happens there.
>
> Dunno, maybe we should really remove alternative_input() instead...

Please note that all other functions involving ALTERNATIVE in
asm/processor.h use "alternative" API.

Uros.

