Return-Path: <linux-kernel+bounces-283310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C4E94EFEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621F01F24017
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827D5186E47;
	Mon, 12 Aug 2024 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ffg1UBrc"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B5418455E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473729; cv=none; b=ibLFx0z0662YQMVzI5iez+bw6idwFEfF3NMmDPT4cBnPozyWQuT/Ni8PZfcE/sZmwxapbJPJE/wcJDyStX71rgMftaH5TIAhOHCsrj3IIJzkXjmr0nBCliDeCIEIsHb/QYgfg1xOJKjgYVgCoe9X2JtnQ6r2WFa9cUv4a2An5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473729; c=relaxed/simple;
	bh=hp3TIT7n5cW/atCOybJZMvLNGx0RBDTELsz7q/Ijpbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufB5XXJbU18egkHqCthDKR84WKaedjpRIf2vFt9W9U75OhEFXqTZtlYCWLdQ16BnZnoMNe0w1ur0l5NjdCoOsY2L68LrQo5Lq/TJn3APwyyPGrd+7YjrxEG5G73RIn9T7EglY248fVzPWmKjOx50q6fc6wNBmrI34SFyaLqYZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ffg1UBrc; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so70225391fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723473726; x=1724078526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hp3TIT7n5cW/atCOybJZMvLNGx0RBDTELsz7q/Ijpbg=;
        b=Ffg1UBrcmFfVxrIDx7VttEKnlj8GabyrKznDr5Gjb2cbPGGtDWO0eDirTVFF+/0pGt
         CET3C9Bypfx5nbvWWCeY+UB19msmpO54AvPb6Q6eG4djSrYsRUflbU5QwlW3VM0wQBoP
         LGwugBifx9eRiPVjWTo4cj73F08KUMxdYDra9SNj0JMZETq+9gdWMTX1rbNhFzjyd8Rl
         mNg5gcijaMhQ6mdSHZGm9+Wgpxlr51yvajbFViFdtZt7NAiS9DSqhn/538RTM+4AANsp
         PSyJM54kp3Mu3mYv53NlZLyCQ5oVhvoi4Q3wKpy+Gd1DcI49yMPnjfMK1aYvMtz1zk5W
         ZqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723473726; x=1724078526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp3TIT7n5cW/atCOybJZMvLNGx0RBDTELsz7q/Ijpbg=;
        b=JTofrW9baBzQNj4q6iWmbbx0u6vOtPUmcLLd6whkbFg/rL7Dn6XMZNI+Qrhp/U84z3
         6BBIbI399s4IHlLkZqlMZvSJzyXm9+fi5CTrh7si6t3m2d/Z9KuIDoNPQtXRyxoFX5JR
         MxXW7OXJLfEmycxM6IQrEgfmI9iCwE0jne3r4re+bXoBfc7dA8/KC0xG3iFHYhERYyBT
         MQuBYVI8cmrK8FNYXF6Cef754lTbB+HmbW9SQfExYvb9HJTiIzIcrt87xmd7ZgSKd7gu
         xNvPPM4EXFkawaJHlSOB0zSJVUnv3a8rWwE60g7BPiEXcopjSeUfTlz29cF7+eTBuMQ3
         ehBA==
X-Forwarded-Encrypted: i=1; AJvYcCW26hF57WqhMnY1OA9ga81Sd4gofvzgYHlq00eCwhJwYO/47JLfhCGjsS0YSEVFo5zzrWGHjb/OM8EmPpHeMx4DCWW/bsYNi8KmQ9Hq
X-Gm-Message-State: AOJu0YwetuS6BbGS1uas8jD2jXGBmR1RoGZO9nM6C3p5maUTU4nH2jiC
	PGvA0znu8Hhcy+9lLNNsTTYvN2X+PlfgBBmrnDiSEqduMdJPxbRU7KaFE2BMAi00DwjbgCLEBsb
	ukKGek0nAe0vaaBi1IfzCxKAdwK4=
X-Google-Smtp-Source: AGHT+IEUoGy31GPaRF79s0WFT+6WVDuhliGYx1n1OndwrokKpyULKHBRqJc6FWr0qrjHPKabFx+dBKQo/UnbqbHLQAw=
X-Received: by 2002:a2e:a584:0:b0:2ef:2677:7b74 with SMTP id
 38308e7fff4ca-2f2b727ee71mr3877651fa.41.1723473725706; Mon, 12 Aug 2024
 07:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805184012.358023-1-ubizjak@gmail.com> <35c12a89-6a9f-0e43-5b84-375ab428a8bc@gentwo.org>
In-Reply-To: <35c12a89-6a9f-0e43-5b84-375ab428a8bc@gentwo.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 12 Aug 2024 16:41:53 +0200
Message-ID: <CAFULd4a+n4+t4rCTpsyvjd=tNfB-O_c0y9+tF-re1WJPz4JJrw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Enable strict percpu address space checks
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Nadav Amit <nadav.amit@gmail.com>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 10:32=E2=80=AFPM Christoph Lameter (Ampere)
<cl@gentwo.org> wrote:
>
> On Mon, 5 Aug 2024, Uros Bizjak wrote:
>
> > Also, the last patch hijacks __percpu tag and repurposes it as a named
> > address space qualifier. While this works surprisingly well in this RFC
> > patchset, I would really appreciate some help on how to rewrite this
> > hack into some "production ready" code.
>
> This looks like good work to find issues with per cpu macro usage. Per cp=
u
> macros are a bit esoteric and it would be a good benefit if you can
> get this done.

Thanks, I will do my best.

> Sadly I cannot help you much with the address space qualifier.

I have solved this in RFC v2, please see [1].

[1] https://lore.kernel.org/lkml/20240812115945.484051-1-ubizjak@gmail.com/

Thanks and best regards,
Uros.

