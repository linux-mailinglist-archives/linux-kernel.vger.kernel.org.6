Return-Path: <linux-kernel+bounces-283690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF1994F7CA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F0B1F23167
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE712191F87;
	Mon, 12 Aug 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYLGLk6/"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8836C2F2C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723492887; cv=none; b=gC+QwT6UU6sZipuDETuVDoebo3gZPTmPLZ0cZCH3KLL0OJjLYgIlQt1p1XAmJT80+1si7W6KjcoDPxZdRVTmnwYqt3BXGbuqGzDU5qMEPaiY4PH+m35BoVc4MgIAt+UQvQSufE6EzujPbgCqErw3FhXJRk9T59P+4hYovjYkmUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723492887; c=relaxed/simple;
	bh=W5Yx7wmfJadyZ98Ftxz994iHsE07kweuWZC3GGJyTjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FR/v4pfJ5zp/lCRhgG+FF6f4G6OZ4SkqE61dolwf1Rohe+2oz23voYee1t4a6sqEmwQfqeqD1DbgjhITnPQ+hN95OJH0cXtrSlD0TaReUk7ToeB9izspesGHr9rzcW9bXok3EUAyLk3TTHHA2+nQpN2OeHUCRW59fQpwOzEYpOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYLGLk6/; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f1a7faa4d5so38283491fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723492884; x=1724097684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5Yx7wmfJadyZ98Ftxz994iHsE07kweuWZC3GGJyTjs=;
        b=HYLGLk6/dLMujLD8i2Y2t+LvRfQ7i9IFZJbznIfLypwyE5wiSXagoVrJoFrYNDHLbC
         usWRT08B6QjMEcq+gUTPaMYXxzCsBEP302opF59owZqbC4fE80Dl4k0vzNlKo93z3pJa
         dCOYbllSzwpWBANhuOCvjtKCnHehiOOk3+nZtg4mU1UMx68mAZ10OYr/En/k60QZm8wn
         uvQkOt2DUeBtOF3khssqEqXcpXmpEHfkJ2WTFturAszsP5c+Fp1DaNpDKsY+5Gc54XSA
         wgu7eWgNLdFMeGaDGRVApumgNWHi7jz3titIQarfK49FegCay6saChdTvfJzXDleQMRd
         P2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723492884; x=1724097684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5Yx7wmfJadyZ98Ftxz994iHsE07kweuWZC3GGJyTjs=;
        b=EDW7VqILuVNHrQgykVN8bxMxtD7gnw6N3V/GNFApWBX8tk/HlvAsy/BoGOu6j8EOKI
         VQJMihyX5a5W2KOxAnpfqBX35w6Xv/qwHQeXsw8gdclf4RIYnkR7145AoJmQ+DgvCd8B
         U7qHSKxdXncRduq9dy1LdbBKvGJpgFjVLuajSej2doKHdFxTO9xvISbjC9DR/2D2i4Sa
         CmmbUKCMRvhWesYVwgO8iF7xYG8oQpTZu5cN4Pi2Cg8RQBun+CXQSR823F69MrZ+Knof
         7UssO+QbvvpXFBO9tWEVkVHl//fRi6RIeyvfR3KptloI+h1q3RfKS7W5ZAQgC86wzZla
         DCGw==
X-Forwarded-Encrypted: i=1; AJvYcCU1iYyMIzZSgGucYOwneNVsv/7uEYOPkcCaAezk3mH9mMrFCt9avzz0YAKpeREYmdacemU5WIew+fbaKtyFUbYkfzh2p4cWbXTvCv7f
X-Gm-Message-State: AOJu0YylDeeWvWW68q6c4j1x3I2UH/IVh3dfxRNDyO2/syqHcI4nQ6P1
	3v+aSa8pPhDInJx6eNcWtHL9bgDCVJzGsXmEBGhASqojcK8YzXkCAaypmrSlQZpm1XQiG6JG6dN
	el8ywrC+WLuy8b8cQTSkYNyQdLUg=
X-Google-Smtp-Source: AGHT+IGionQLS5IyXeqEOQC3WPCU9dMgtlCsG9B/ynMKv5dAyo+w0PHeF15TTmVeuf3otAgmeOPBU2gCsiIqZqFQKc0=
X-Received: by 2002:a2e:9990:0:b0:2ef:22ad:77b8 with SMTP id
 38308e7fff4ca-2f2b7154e61mr8477911fa.23.1723492883087; Mon, 12 Aug 2024
 13:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812115945.484051-1-ubizjak@gmail.com> <20240812115945.484051-4-ubizjak@gmail.com>
 <74B42046-E39E-4068-A6CB-F3315A702285@gmail.com>
In-Reply-To: <74B42046-E39E-4068-A6CB-F3315A702285@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 12 Aug 2024 22:01:11 +0200
Message-ID: <CAFULd4aG+9Sg==PyWcAgi_2ERWzs-arCv+67tuuA2ZMBkN1FMQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] percpu: Repurpose __percpu tag as a named
 address space qualifier
To: Nadav Amit <nadav.amit@gmail.com>
Cc: "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Andy Lutomirski <luto@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 9:12=E2=80=AFPM Nadav Amit <nadav.amit@gmail.com> w=
rote:
>
>
>
> > On 12 Aug 2024, at 14:57, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > +#define per_cpu_qual /* nothing */
>
> I wouldn't do that (the =E2=80=9C/* nothing */=E2=80=9C part). It might c=
ause a mess
> unnecessarily is used with a comment.

I took this /* nothing */ idea from the definition of BTF_TYPE_TAG in
compiler_types.h. But yes, it doesn't bring anything here so let's
remove it.

Thanks,
Uros.

