Return-Path: <linux-kernel+bounces-524572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E140DA3E4B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1631D188F54C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C7E2144D6;
	Thu, 20 Feb 2025 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwgxDtbC"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA5A1E9B1C;
	Thu, 20 Feb 2025 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078445; cv=none; b=Ce5QLpJzktdp3qghB4dFrEVpi2i0tlZHZR31xA1s5laLhH8OkeaOvdiHJOvTGL6s8CQiSur8vN9Ydpp3f6yhyJkRupgYHMdFx/D6knPP0rwKlHkTmeaWw4HkrzvNgj5b4Dj9oH99KQG+GB85mZjprXurdqBVW42CjqTdb1jSfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078445; c=relaxed/simple;
	bh=2lv22/0ZdmRvcEbZ+G4sLiYdzTRf2qzrZtEczUjiOqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJa4mvD+/PON1Rl4iKfGQ2/KzJBmiwMy0k/0deV2pNUgifhFBdB1FdgHsuwQCoEouUY9hPouXMuNgVoqHtyoc44AeyGIb286gGz2Ix60Hr0T6pbiricVlfbzF4nivNByMmkf8aPK41rX9HcSNYub40VIRS6LOh9H0vIsNBHq/QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwgxDtbC; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54838cd334cso83738e87.1;
        Thu, 20 Feb 2025 11:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740078441; x=1740683241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4tA+hBCjxCkj9qawoVnWYVmgmO9YLxcA7VHjkl9NMI=;
        b=RwgxDtbClLdFbIGlXpWcA1q5z9As4MXQk++Ae3irCI+AOdpapEIv7heQSyVjEMy7eV
         O4kwYv3AdSwceelhcEYTNSgdWj7y0ITV/5CaPvvvMTHAkG+n7h64X4HkOrYlfyDUAMql
         fDVBPjxZwJF+WKllOP/cjEkHvGWZhp+hOnpqi6UWxGtHXXfbzHI/DdWoHcez8GrcF7PN
         qUk1R2NvGA1h2yIGl0LSwtoeCzkWfhDy+mmrBY7v+gR7KA2BW7r36X9aFzwKuQnLOfLB
         ZOqMjFJH5JPEyw41gk24tWNsPw6VWT+i5oqXhoN90UUyizaZ56ngcTDU7IIdryjPbarp
         AiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740078441; x=1740683241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4tA+hBCjxCkj9qawoVnWYVmgmO9YLxcA7VHjkl9NMI=;
        b=FT1NUazmw5vjyPrb+vFvtLN9Ic8j1/PboiNEvvXw1OycT+pcXNZvVX98aC8iL+p3Tc
         YM5F7s7r1rrhLnPSQZIuJaVN2l5KtdK2MKJVXkMzVs9UI7yGk70Dz1n5eno0bzDfrCkq
         yr1QlYhTJTWIwSZp6Vw4Om+vAhOXeU1Ga736YZyO9WX8iRpTKvGepyVNgy7uq7Q1zZ08
         RYN9kB40x+8T8c8cECMx3yXjMflfuQIJsAByFM6XZ22juOSaJ5PhSWDgU01+xQNwRJpa
         0zPE4ZCDrKgRXCavXj0nuvYQ3EnL7TW782Vz4tV5CkFGFcBJmmV0+47k7TkD6RFA5DVs
         BCmA==
X-Forwarded-Encrypted: i=1; AJvYcCWA+4Xp+NzZBnKtxDm/O3kHfUEr5M1fWAANtC3M9fPSWu8WkL3Dt4mabvLP+hgADTChdAYVbYs7VSL3Rg==@vger.kernel.org, AJvYcCXHlwFbpiEtdSw4tctM4wAdAbc0u6CQPkqPRUBYKtrwQzou8dnkbNKvcSsF1f6Rdy02m5JmCrSi50HlTcOB@vger.kernel.org
X-Gm-Message-State: AOJu0YwwgIZ/gM1/85JtIyYl+G27+Lo+KwoGusjyDcGBLLTbF49JO19i
	zd519N6LI7QiP4QjXNyLs0ZGL2mdaODHaDTcf/ZEfJ5D6uKWaRBwDDc3b0m85HStfCy/Bcgb1Zm
	f60vV+o/FrRGhwKV9Bw9S6Z/l3wU=
X-Gm-Gg: ASbGncs11m6AEt6sF50gWz1KQ+gPb0xk1ItwYnPLfgSO/KfI/kYXRlYf9JQNBJfdXy/
	ztPpHQODv0YE5H61SKGWaSWknALtlcDoq92c7fpovhm3iPNaYc/6FVeoz/ivEiHTQV+zEnEw=
X-Google-Smtp-Source: AGHT+IFXSri0zhcFQNr0oSzZzzluMpF6T39ljhMXJ+KkLg0h0xQyKFiBkEwV5jKHrZ/24YAmhMsx/x/p+sqBKNTt++E=
X-Received: by 2002:a05:6512:1591:b0:545:102f:8788 with SMTP id
 2adb3069b0e04-54838ee917cmr69686e87.19.1740078440721; Thu, 20 Feb 2025
 11:07:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.DEB.2.21.2502181912230.65342@angie.orcam.me.uk> <45155869-1490-49ab-8df1-7ad13f79c09a@linaro.org>
In-Reply-To: <45155869-1490-49ab-8df1-7ad13f79c09a@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 20 Feb 2025 14:07:09 -0500
X-Gm-Features: AWEUYZmmsKYVlkSJ5dA-0IiuQ1seVgYz6jVGprgpKWssltV6SOSLNiiH1EgGHU8
Message-ID: <CAEdQ38FMnWwT4bM41y2Zxh27KGbMokwc8YTBw4mYDZnaJPsSUw@mail.gmail.com>
Subject: Re: [PATCH] Alpha: Emulate unaligned LDx_L/STx_C for data consistency
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Ivan Kokshaysky <ink@unseen.parts>, Arnd Bergmann <arnd@arndb.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Magnus Lindholm <linmag7@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:54=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/19/25 04:46, Maciej W. Rozycki wrote:
> > Complementing compiler support for the `-msafe-bwa' and `-msafe-partial=
'
> > code generation options slated to land in GCC 15,
>
> Pointer?  I can't find it on the gcc-patches list.

I believe it's this:

https://inbox.sourceware.org/gcc-patches/alpine.DEB.2.21.2411141652300.9262=
@angie.orcam.me.uk/

The first half or so have landed so far, right Maciej?

