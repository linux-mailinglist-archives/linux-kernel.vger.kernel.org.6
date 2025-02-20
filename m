Return-Path: <linux-kernel+bounces-524919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07025A3E8B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCBB19C35EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC0A26463B;
	Thu, 20 Feb 2025 23:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJXDutWf"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C042676EE;
	Thu, 20 Feb 2025 23:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094981; cv=none; b=uiCm/B3PcWN5+PucVEAsgcpeMAe3LN/nMsO7BaafxypKankdXnKzTDdeAY+pIcJsP+BlF7beSY0b3jEvFrJci0bnWfBxtMCJHULaCGM4yswfD0aKgnJetlxZCJD8ESL9+DnDGY//8PSDpmgEahnnAFjrIQsyVYEqa+RNZc0wAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094981; c=relaxed/simple;
	bh=L9Kfv39OqMdK04JAvpnAP/aGdKTvCtAtW1r4CuukpX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLg34HRv29RjA8aAWn3CystrnD+tmZ78xTSMDtHE+Ha4PqmMc3/KOlTNdQwvcnSYfbd1eoGK/7GBhVwyV02ofT+4Ng8MRbYWrEMkLeE8/xEWjXsh79bGqYei4FTobFYuA9a8zGzs4Dw7KBxWWXwTkwqjqiTdInE93OXUDgnM2NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJXDutWf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fbf706c9cbso348035a91.3;
        Thu, 20 Feb 2025 15:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740094979; x=1740699779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5b1NzyX3+oox2Z612BXoXTkh4jjxT+fedPYrwEqKHs=;
        b=OJXDutWfxkQQVg7AdIP4GMzwtJjuZjubn4pIPd+UkrFhP86l8a1vkC1uUq/1QR2gYi
         Q2C1W/vmDOOE9qlyXepjibwBFvrDjwwKOzmjLFqsEjdQD3qrGZEWNErSFvrG4WPM0LMb
         raYbbQEV65F1T42fRj4PWJaNdDl59AqSckgcwmx8j6gqM1YeZqYeWhSIuLyQEQJywFjo
         g5qQZiITMcO6JTt8lrs4NWoWFHD5j7CpwyMUqiwLRm3k1NMZpnlIR36PdhNoXxxcO5/s
         29Fk3QdsAkjiw8/NHW5Mbr5qFhEszwxfPGDDTv7RoVPYW1u278jROMK1KXOPYzNmxs0Y
         dTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740094979; x=1740699779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5b1NzyX3+oox2Z612BXoXTkh4jjxT+fedPYrwEqKHs=;
        b=kY13ERCSNCEuF8R0R5hUziAHNIZ2QTDa2417j1AEhDe9VhbDb/PlfFTmK2ldBMEsuu
         Z/E+IhDwPC51oWebV7//aW9/pdnosoGyK7KlyZmPuQk0lA0QZcjpuDOW/jLAgog3Uy0Z
         FZw4m/nyWvxapbYAgnkeaOtTwcjlzH8BD0KZm9KkFF9j6bTaXcLsCj8U/xSKpAHBlGEw
         3TUNxiUza6ZsEfYKk0HIHnI4nKC8LKLzJtW3AlmhNz/od8NNT32NhBzD2GbqUIeAfKuy
         61dF+/FjuOJUgXdaYs0ay59mcUXgmruO5BQvsDhc3BoR//acpWri7yqGFX9vTlYiew7C
         USYg==
X-Forwarded-Encrypted: i=1; AJvYcCU8cC4CdKbgvrc/JG1tUeqO8xQI1HdkmGCq0cQ1FjuBW0E7Q/iN1mD4TDoFmG74SxJ1LVD59xXDdT29tRoSp50=@vger.kernel.org, AJvYcCWDxBwClVTU+PY3qCnqMlTw5WjB9zUj69yQesG+tHvAWC+X+gZUD1Zw1E0XjqD4KAXE539t5UlKgmfYkuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv59KxBTgX+OvZapd6+FHGLTOe/oTs7ThwvesrlR/QaQvjzLKe
	fD60CMCx2pfiB0Agpdqy/ZdATwKa3qHdfBOegt7oqBrfQAsC2ANVlXeVZNGP3bJMDfN0+OfScB3
	qflLnlDeQMy4oe+3amcj/FFhVa2gbEw==
X-Gm-Gg: ASbGncvMBldAYBzBTsOwJ89oE/+UCEeiIJraTDjhKGlp0dH2IGFMOAxxmiRv3cEEBSO
	1WKVijFymFaPMLWuF35CfuRtIvQICO3BJdvb8wQ7cyLQNCW3bRLvBpd4G4pDyyCsT5I/BHDzK
X-Google-Smtp-Source: AGHT+IEtCMpnIDRlzFsG9k/RqkGrAj4G+X5WTvM7CByob/VUnkpeDuMCZryW/Ycbbb+88dEP0P003NDE1Gqlq/IN4c0=
X-Received: by 2002:a17:90b:350c:b0:2ee:e518:c1d4 with SMTP id
 98e67ed59e1d1-2fce77a63cfmr691014a91.1.1740094979099; Thu, 20 Feb 2025
 15:42:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <202502191026.8B6FD47A1@keescook> <785A9F60-F687-41DE-A116-34E37F5B407A@zytor.com>
In-Reply-To: <785A9F60-F687-41DE-A116-34E37F5B407A@zytor.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Feb 2025 00:42:46 +0100
X-Gm-Features: AWEUYZlZLMmtDWCJImDa9xtbg37S_H3ahSaDF1pmiS0wc6kjTHtRiPI08i7w7u4
Message-ID: <CANiq72nwouotAqJh_cm=9RG3Ns4wxX0LWXcVwp_bswE29kCrYA@mail.gmail.com>
Subject: Re: Rust kernel policy
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <kees@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 8:34=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> a. The apparent vast gap in maturity required of Rust versus C. What is o=
ur maturity policy going to be? Otherwise we are putting a lot of burden on=
 C maintainers which is effectively wasted of the kernel configuration pull=
s in even one line of Rust.
>
> This is particularly toxic given the "no parallel code" claimed in this p=
olicy document (which really needs references if it is to be taken seriousl=
y; as written, it looks like a specific opinion.)

There is no "no parallel code" in the document, and I would like a
clarification on what you mean by "toxic" here.

I tried really hard to avoid misrepresenting anything, and the
document explicitly mentions at the top that this is our
understanding, and that the policy could change depending on what key
maintainers and the community discuss. (If it is put into the kernel
tree, then that solves that.).

Anyway, I can only guess you are referring to the "Are duplicated
C/Rust drivers allowed?" point. If so, since you want references, here
is one:

    No, don't do that, it's horrid and we have been down that road in the
    past and we don't want to do it again.  One driver per device please.

    https://lore.kernel.org/rust-for-linux/2023091349-hazelnut-espionage-4f=
2b@gregkh/

Things evolved after those discussions, which is why I ended up
writing the "Rust reference drivers" framework that got later used for
PHY:

    https://rust-for-linux.com/rust-reference-drivers

I hope that helps the document "to be taken seriously".

Cheers,
Miguel

