Return-Path: <linux-kernel+bounces-562303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1946EA62249
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579D2421984
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54D61F4625;
	Fri, 14 Mar 2025 23:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HPS6WaFG"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166A11C6FE8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 23:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741996463; cv=none; b=pk1wzW9nPbkzEX9KRABn+6IGrQAZE4fbQgraREygMmXJ+BFFxqRjOMivk8KHS4TJZ0N1jvv9VTAqWqR05K65E8VvSmRXjR7rCZUaw8BGBToOiLtZVEp0CaIBBblPtpNk1ryJMUeJ9p4cOFnGSBXI3x/eyVc9Y2RhOx8V4IYXl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741996463; c=relaxed/simple;
	bh=DZdf7RgSiCRrzf+UAdvfAu7rVIfauzDNvoLADFdCFhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYa70IwzhJcujW7jk48yAZXddyuMDGTP680/3Efs3IQGDtws4fM55GWwFujEFneWwCIowfqTJ4TTtScmdg47Y8Vu7JNDjLfvZCWBxaGFTCeSx/u6IaojqvjhDoiEH16AOZGj0weXDQ2+s0e/sKaDoXiRgUy+C1aruIov64FzKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HPS6WaFG; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac25d2b2354so467785366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741996459; x=1742601259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ghXMKs5AqAJAAmdiWHRRx6w4E1IZQYGoD4s2TGuSX/E=;
        b=HPS6WaFGVZQQb3z07uP4eVK0JCbP0x2lltXmcbmk25xwpQOC9sSG7CG9VTSdPBL+OL
         dUJ4FK3JWHeyJo4eZ7f24afPgh+He9KJfiJt+ku+fjt/2wd8rtpFugGWUTNKF3LzA3sO
         25S7ClgBgBj3MoEJJeutY7SCajahY5aYGRhdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741996459; x=1742601259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghXMKs5AqAJAAmdiWHRRx6w4E1IZQYGoD4s2TGuSX/E=;
        b=HHAGVyrW1oVfpl8Rx0N6n6P5w/O96aLtapfVtttmWgBEhQ+fYDmNPZHYz6jgaeXSmE
         bUXS0M2PoauDpokgKFN4Z/vqQc8PMikLjvoFVa/S1cHYvotJaIOXTcbqbSDwJQ47dghr
         liqaVO6djzWDZFeCTDy3juesCe5DoGJr3g1EW3fXOyygAnx4rMAZJwDdyf2nk4lUxOtC
         HgAqD8FWlGKZO8Bm/n0cuaZLxUt9WiQYkN2QqC5OdZGjc0ddpCj3z9YY6IFNN08CFw4f
         G2y1FvMTFTijkVShvSlpzUXjp02PYeEV0kBUB4+YA5Vp3yGMgKjhiVuAi7RQ6nFkQ97h
         s+CA==
X-Forwarded-Encrypted: i=1; AJvYcCVSmb553QgutTTScUsx22w1Mh6YQ1PgTD++GWx32MFtHA+tocgu+zjCP47yUn/PD6/e3dn9sqFEWbeZnX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYmF3uW7UsmCHjAsG0+9TNvFzG6Kk81FK05xsDYIV5npi7R0xj
	AAMpfCgRtTQhUplPnBwvzyV37VNYpwuXQpi4sseoI2ZL5r9mbsiCOxiqo+Wr1f8hKN8KwTu5DRT
	+DlA=
X-Gm-Gg: ASbGncu+uel2lGeu7bj9eLpdc4gLwf2c/PYmEM3BxgS48NpyvMxe0pZ8Nstm6WL9QpY
	nj3HZTU4YSGAFBTrBlwI898OkRbJvGmFFPaN9w9kMVGNIH9337K8BrGXGyypN25R9CIrnMyoRfO
	IB7Y3u3LzZL1N3y3w3i9GVbTCPK4VXKdnbUtOt59Zkh9v9crYkvmTCYDXrfB+pxr2PzogF3HgPm
	JojRXgYG8PwjuvE4qWvRIU/gJ9Wfn+X5Qt314tGKcx1wL2pMmSyu0OcZ1L+oK2uL1rolei1XSMB
	HTjINq2rISfqhmnV2HJKw1Ay+vJs0RvRhqCAFm9RwRT9Jdtc68cl7tmds29thSxN95u0ncg/d7Z
	uP8YnL79rZWark865d9A=
X-Google-Smtp-Source: AGHT+IFMlZsDAbphTPqXTLT5r25lJQ5NHKyRy3lpiP7iVrDOxVSmHNymOViKxJs7g0jjiUdbH1D7fQ==
X-Received: by 2002:a17:907:9487:b0:abf:4b6e:e107 with SMTP id a640c23a62f3a-ac3302c8e3bmr465839566b.25.1741996458978;
        Fri, 14 Mar 2025 16:54:18 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e75f6sm294682266b.50.2025.03.14.16.54.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 16:54:18 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso3367369a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:54:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGUZ99yk6qg52W9ONcXt+oWHaYbHfvbBq+x5f2gWdEW+CoXydVv9C4KiU27uj8C5YkjFykf4wf+DHwZfA=@vger.kernel.org
X-Received: by 2002:a17:906:c10d:b0:ac2:cae8:e153 with SMTP id
 a640c23a62f3a-ac3301dd86bmr608130966b.4.1741996457836; Fri, 14 Mar 2025
 16:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741988314.git.jpoimboe@kernel.org> <1c2fe7f93c4dd8a87c2e1fa8b780a8a2968be445.1741988314.git.jpoimboe@kernel.org>
 <CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>
In-Reply-To: <CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Mar 2025 13:54:00 -1000
X-Gmail-Original-Message-ID: <CAHk-=whH5bHRYB12aAcb=nK7erOmOSo6o2FXjHtxObWumFANHA@mail.gmail.com>
X-Gm-Features: AQ5f1JrjTA7XzkiRXi5JF9cMHZP6yEjNS56E9rLPgJo40XYqBlDTrCExiwNKElY
Message-ID: <CAHk-=whH5bHRYB12aAcb=nK7erOmOSo6o2FXjHtxObWumFANHA@mail.gmail.com>
Subject: Re: [PATCH 14/20] x86/barrier: Use alternative_io() in 32-bit barrier functions
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 13:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> because that ARG(), ARG(), ARGC() pattern looks odd to me.
>
> Maybe it's just me.

Oh, and the other thing I reacted to is that I think the
"alternative_io()" thing should be renamed.

The "io" makes me think "actual I/O". As in PCI or disks or whatever.
It always read oddly, but now it's *comletely* pointless, because the
new macro model actually takes pretty much arbitrary asm arguments, to
the "both input and output arguments" no longer makes any real sense.

So I think it would be better to just call this "alternative_asm()",
and make naming simpler. Hmm?

            Linus

