Return-Path: <linux-kernel+bounces-536562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D43A480FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1713A3FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7A42309A8;
	Thu, 27 Feb 2025 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRpFTLhJ"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034521CA14;
	Thu, 27 Feb 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666105; cv=none; b=GxvyhJWTlfKvRDRlK5OzbDdmJdme5wK+OWW6kR0REeuNDzh0SjM7WvGmAaig32v8DbO3TiKo1pTe0fy2yRqoqgbR8PAiRkxBlMmdr17IQCVkSsYi5W6q11uTOLF/EnOi9ZIBYOnpXn+dVj2rX8ZlNMCyVFHl8QHKXmqosGljkCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666105; c=relaxed/simple;
	bh=jDiKd5u/UNI0PpWyrmjqelJqvH1haIS0fYaKH/QWppw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZL/t2ZWCJNSfx+K3Yo52xPxXJbzntfW4dxOrNlfAMlar90TIYFq5wCmvMN/y3teDDSJaSaAsHPD21hUyQil8csQ3HuXCVQNI/qHAUpHO47ryCuNKAEspbQBFO23KIEiVGMJj1hviChcZq8VryG4A+hoNInCbnP2AZjHX6VUmdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRpFTLhJ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-307c13298eeso12716841fa.0;
        Thu, 27 Feb 2025 06:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740666101; x=1741270901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDiKd5u/UNI0PpWyrmjqelJqvH1haIS0fYaKH/QWppw=;
        b=XRpFTLhJdur6pPeaeA714OqV3lgnKemJ+KcxdZNE1US3PSeo7kUoyJxa3c5BMHAZ0T
         kVqLdnum5Hs/IlcWCP8KHH7/OxcWl8Mem8WTGRYD9oUnYG4rj+adoJC6MHumbbkqsXSP
         452EN2Qbil72XKMc5FdyAysjfjbbRArb/l6MssMtlg5VBRq+abwFQdWmCEdd9/LZDup6
         dpegh0ryzObWUbZdunGdAJgqM33AVjD2IVKLOJQkuXI8nP0gIyCkd8CUkY3q7oqvAm4u
         Do32PFYSC3epvYziAQJi0sc+Zs1M9+PKvEtNC8bP3MwYF/7aJrEwzIiqohOgLhVv80v5
         MB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740666101; x=1741270901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDiKd5u/UNI0PpWyrmjqelJqvH1haIS0fYaKH/QWppw=;
        b=aaWVy14uYjVVQ7pFJPi0F1GC2yyrXkWYjNBhoqWrcBCr1UAkCG7EKbsMovSV92LTCS
         ax9fiRlZyLyCMgopUZrONH2s/txep35zmMaDqZtY/tZohf5Uf12VwytVd4KRJu1achzY
         llj1UL18NWsJzAE2YdE7MQsLzIVq6ezvZXJCeCMNRIXSNL9kOTgbYgrXUKxOcRla07hU
         vyKcAx1WcZ2eJp0A1nr4w59KVGMDbmam9PTQfvT13S63on9u+2lIXcsUmn49Dz6eMBvl
         Qc27fshccJGbT3atFQCBQhnEMSGBxAtzX6KSGqqRy8GydGIctGi2gDig7Kc7U6bnZxPx
         xvzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiliBe+/dFT+uuZJf8/quIMPf07MBzLAM5FnsGtjrsEpoNjBxxpOYE/0A/ibqkrOBTssboFwt5DNI9Eo0=@vger.kernel.org, AJvYcCWq67UIE4qR4oWPhJvMB8p9kkxlnoh78Jps4y+sEL+V6q5ATHs18SppzMMlPuVFSjNz0pZTPOwBMAWBm868sM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrH2OKezD1aBNDNZCMREuDfeLQkSY3FElsKDCMice+xiF4rj6x
	ASZ2PLLNY8XzFd+d/OaCglctZOZW3gJBNONaYac8HHdjknu3QVD5B0bV5s+vfrSUQ9xy8d4OSkq
	nTpBvLEaJ9A3Xitg27jsAbicYZcE=
X-Gm-Gg: ASbGncutt+PL5lh7vOokIVjuQV5w/0xEZUBjE6Gz++CB21glFyrlLLzusA7Jggmu/4/
	DXK36GggbjGeML3UddY1OvMDJZiVpYHS1enkm5d9yL4xoB+RpGyLzKp5kEp0XWl3B0VSIjJP6b+
	4POsT/PdlQ
X-Google-Smtp-Source: AGHT+IG8QcFnsM4lFejfj+y9wVmwF6dAuaeJdmE8EIPO23hcK5koKsJkkZMquT3UfIGMPD5V0moetP1n9GXZ3jY+Dv8=
X-Received: by 2002:a2e:ad0b:0:b0:309:2999:77d4 with SMTP id
 38308e7fff4ca-30b84650d3dmr18509101fa.6.1740666101136; Thu, 27 Feb 2025
 06:21:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de> <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
In-Reply-To: <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
From: Ventura Jack <venturajack85@gmail.com>
Date: Thu, 27 Feb 2025 07:21:24 -0700
X-Gm-Features: AQ5f1Jp4j22pclUqXy_NRJGy5SyMDK7pivJm3KtHZ3o9BTX4Sjg-8m5F9ik4fjs
Message-ID: <CAFJgqgSjRwOUkcC5v6wGcfQ-53oWyWW+wBg3PZ-w7vRweHekpw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Martin Uecker <uecker@tugraz.at>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ralf Jung <post@ralfj.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 1:00=E2=80=AFPM Martin Uecker <uecker@tugraz.at> wr=
ote:
>
> I think C++ messed up a lot (including time-travel UB, uninitialized
> variables, aliasing ules and much more), but I do not see
> the problem here.

C++26 actually changes the rules of reading uninitialized
variables from being undefined behavior to being
"erroneous behavior", for the purpose of decreasing instances
that can cause UB. Though programmers can still opt-into
the old behavior with UB, on a case by case basis, for the
sake of performance.

Best, VJ.

