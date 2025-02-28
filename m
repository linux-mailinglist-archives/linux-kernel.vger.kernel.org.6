Return-Path: <linux-kernel+bounces-538958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA94A49F42
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9A316A28B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4C227002E;
	Fri, 28 Feb 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlYHCYVT"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CBD18E743;
	Fri, 28 Feb 2025 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761324; cv=none; b=c+EZ9G0IwTVdc1LS1i9jEwJtWS5Eoxf6nEmsVCAIr4aCBb+ivGDGK/IudbO4rsGGyc8T5FUl7Kml8uvfqukVKHWArt3y65bzYMy+XPMMt1nuZDY6S7JgdBGPKgIvGd4141CkiIyiBW1foJfq96/fJgTjzLHmjQHs5/fTjFePKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761324; c=relaxed/simple;
	bh=8Wx8PCi3y3Ei9lmVusA+ydkpm74p2Rf/ZTYW8VCXuwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f42zgwjsZiol4Ar6IzrTeCmUNQq1j4mh+zWPlm1IMaN/mqwMSUc+QueT1zY0ROJSTHL7Rj5xvLzuf7ejf0jiwUC6zS1pYSjZW6m3MTsN6zU9CWsE8CSItljhDWEKHfKSvEA/QAvoJ4S1NHlmQZvefPhZBoFWI76y/DAMEIS5ii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlYHCYVT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2234f57b892so5815065ad.1;
        Fri, 28 Feb 2025 08:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740761321; x=1741366121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Wx8PCi3y3Ei9lmVusA+ydkpm74p2Rf/ZTYW8VCXuwM=;
        b=VlYHCYVTIgYsGrKb5ojN11054dabK7hBZhoGxceLEjHHZidWgbjD6sd4kUh5JvDzCU
         It53FsqwKkLfCWlHbloRSW/Da3NeOgFFHj/T01+hTQxKPengtfdcV9qlbFmkZJMdkD+A
         +LlI66GEtcWmVmq7DEcD4a64ow8wN/5N5QOtYF1X4L1Jjw7Oy3zFdisQXp1AFNwdqaWL
         2qe8q9fquaINncTrpPKmkeP4L/pBk2G4YEqPXRA191wEGI3Eu7plH6P/0eFe5nzxViTt
         y2jESHiHoVK7iGlkw6KAaoIHdB4YwoLVhri/M3KFK0vL0QjFBF56C9ANmuUMICoTQXcW
         QmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761321; x=1741366121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Wx8PCi3y3Ei9lmVusA+ydkpm74p2Rf/ZTYW8VCXuwM=;
        b=KAJ5BurafImVLxxIELZAzLgY/RNI2xGlD28zc12gs6zlcNxS6nsSEs2HNinyMlJqbT
         gPaiAGIW1JNbrj15CjrPLdeabLkkir8jRSXT4hP5gugz5PGs51qXAg8lMmfxKbSGXySk
         bFJkwlrnKGc2P/QjjF78KAHrIAgDPnTCbfGkulhRptWGCHidvjosazUTmmjz/czctTK7
         kUEfcdU/f8zgKw+l70EOKZ4DxeHXnQdldciE2ikCcvpBF/8iCLzoAZ24AEZC6MWnOdHT
         2/pGykutyitC38Nmk4kUaCMbqTzeVWW7PnK5fBkuZY87cki7s8YdtvxdzX2gBi11/qyU
         GN5g==
X-Forwarded-Encrypted: i=1; AJvYcCWaR/szpG9en/NqceEOsymBgMliyl3U+0AqAnO+oatc1p3ApHV7gC5GqejkPOudKkE1N1ahDIco4s11J/M=@vger.kernel.org, AJvYcCXeNv5mOnM6rmwg/1nM1MapEFSJKQY1mvz34zR32vyPWORwO4j329cubxnuczVlx3SkQjG24/8Azu+uSLznQWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw73Dz+Oq+fQusUVtOHvM76N72VEn6iRwupPzThue/zrFDn3d1T
	cg303+Cczyj+XGysZ5en7I5K9XERiBAlW3Mr+9BcD/8adRxiT9DFOoArHXO97tn4uvrtDJaRmkk
	89sC46iozZFc6Al2c0jkhfcUi25HKYnhcaBA=
X-Gm-Gg: ASbGncuUBZAi9h4pNdooozcf36y3FdeF7V0ugmKHrKG4b74NLqIoZR9mcL0Pee03pha
	FSEt4NmEjYLgSVAOmC9jdHoLNU0pbm+mi4V03mfXya74kVL8TSyMT+lrDQnFUU90wqbao6GRaU0
	IRjUeLiME=
X-Google-Smtp-Source: AGHT+IGugj3El9yAK30SUX9EGurb6Fbt9h4MivgvtrroI5tAWe6eVR96rioDjdmiSTcrLO0Zb/Ydxoa5N8OCOS8jnvY=
X-Received: by 2002:a17:903:3ba4:b0:223:5e57:44f0 with SMTP id
 d9443c01a7336-2236925928cmr22766795ad.14.1740761321059; Fri, 28 Feb 2025
 08:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228132928.880683-1-guillaume1.gomez@gmail.com>
 <CANiq72mENfqG6iNjgXpq4LVEceZ4174yGhg-RB0MsMxLVed-1A@mail.gmail.com> <CAAOQCfSEUnp8U3+6amWCd6+yPrAmPy6gsjJnQdrqmpER5md3kA@mail.gmail.com>
In-Reply-To: <CAAOQCfSEUnp8U3+6amWCd6+yPrAmPy6gsjJnQdrqmpER5md3kA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 28 Feb 2025 17:48:25 +0100
X-Gm-Features: AQ5f1Jr0HnDZ2nmjCPs5NPNWsxEkHvLxey7W3y8DPQgqSpIaCotbbzniMxffLKc
Message-ID: <CANiq72=UrE5fv1Ymt-2NRzzKo2xk=tXLwvLaC4fo+vhJC0edNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Use new `--output-format=doctest` rustdoc command
 line flag to improve doctest handling.
To: Guillaume Gomez <guillaume1.gomez@gmail.com>
Cc: ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 5:32=E2=80=AFPM Guillaume Gomez
<guillaume1.gomez@gmail.com> wrote:
>
> I'll definitely need some help here. I'm not sure current stable already
> has this change so until then, we'll need a beta/nightly version to run
> these tests.

Yeah, we will need to wait until the "final" version of the flag is in
a stable version (the flag would not need to be "stable" itself, nor
the compiler released, but yeah, we need to know the version).

> I opened https://github.com/rust-lang/rust/pull/137807 to resolve
> this problem.

Thanks!

That would still force us to have all the "hardcoded knowledge" about
the `rustdoc` output (apart from the JSON schema), right?

i.e. my idea was to try to see if we could avoid matching on "strings"
as much as possible, and trying to have enough metadata (properly
encoded in the JSON somehow), so that we need to avoid searching for
e.g. `main()` etc.; and instead generate everything else needed on our
side, customized for the kernel case.

> I don't think `expect` would work in any of the cases in this file. What =
I suggest
> is to add methods on `JsonValue` in a future patch which would allow to r=
educe
> code in this file (and call `expect` too).

Yeah, sorry, when I saw the `Some(...) ... else panic!` I replied too
quickly -- in this case, I don't think it matters to have a custom
error for the "wrong JSON type" case as we discussed offline since
nobody should be seeing the error to begin with, so it is fine.

Cheers,
Miguel

