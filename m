Return-Path: <linux-kernel+bounces-426726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 607689DF709
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260622817BE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4085F1D86EC;
	Sun,  1 Dec 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hraSobH1"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75EF1D6DDC
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733083416; cv=none; b=Cj/9Nnom2vyeFkm08lrxbjvEhADIEwc5Q7ptjk6w0fXUgul0z/DcOTavuTCAVnS4wogbYPALV7OMUDpTxdF822nvHXnl4jItFpT0WmeWa9PNJad6k1AAeA9SMRe84lhXW3w6Vtlbhmd63Ldnc2nfnCXGJAZYQNYp0tF1kugoPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733083416; c=relaxed/simple;
	bh=YQYZv0nLZAWOwjNAYm5v5PWeyQRsVnUgFtgAxx+4OlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXbD/+rBaLcQnTHReDPo/S8V+nxxqBCcSglnLoI1yvEY4Rzk1gI68FmX88bLAg8c5oi9x/NWIK64JDvVsFDsWjCjOXoUNKQ1CZd+aiWesHhQlIrNmtkmGjQkc4uPhSqRbWRBw019MzEyRr/IiHyikyPTDyYdhPJN2OLabpRoEW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hraSobH1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa531a70416so241854866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 12:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733083413; x=1733688213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU0Rubfxf3W1Wj6x6HtwFltcGwCY6ii8b+Gen11fGTo=;
        b=hraSobH1zm7zEBsgGe8ddYua8RjCRz4Qygh0rnLqqqMnk1d4sTUx6rrK1Hl+munB/o
         0hCqJ0E09mDgYR575fDffcxqUfSx7d2p923dqiYRvA7l3sQWGPt9/J4nvQ2iA5YK3kpF
         f5fnjI3Js0IlWk1A+/8dUyOKOJ5xlvy5IWzQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733083413; x=1733688213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU0Rubfxf3W1Wj6x6HtwFltcGwCY6ii8b+Gen11fGTo=;
        b=YDL6D8MfSOMfCibaQ91CGv+7l28++cGiPqxTcGA1Nf3KwxPjvBJ0sltFWawhn4fx1J
         sQB5xSONEAc6+ZZKo1DXRCZyhkH9tW0gPrnseszTvYzdIm34KtZ/Fi7xdiPBLYFhCU6K
         c1y5R6Gx8cFSnFU993er/XGVGLwQso4E0eBUBV9Oyf5CI9UhKA7Bx3nlwgoKhZR6Pdlq
         TPsaBzOMiYo7UDKNl1gS4vHpuX/+UtaqJpEvdekO9ZMja7ILysGBIhqYFck+4N5Gu+Np
         8/07oGohVNoOKta8NJyplcq5TE8C2zfTN3f0QQ3hgDtQLjIJp9xLboaAE1Pct5yvPiku
         EeCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2lU4f/2M8WDnMm7uyfb7/a3PEHgHG1woblTMGEPdcQNjn6S3zhfApuUHRtvKnVPjrYpcEUhb/3MtY+v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE7odCr3WLxTJ1LSnWW2VMLaT2ijmQsuHxqTFNAooAnYA11gqB
	SqYZBMcBh6VeziTGKV935IRYq+WFaCw9tGNoo7JwBI6ze6jZdNpeBpOihCXwiUa8TJVvCbSbPck
	S4Rg=
X-Gm-Gg: ASbGncuLCQhswYDrvpxl17M7ibLWupkIAFFIncv72zo4oi7X1+fb0+m1HTvgJxqiRL0
	YR2Q8plC8xW3j2IVX/XrQVppFn7Pu+VTFHwI/Fu4fffvLla59AA3ZSFOiGK0S4OmAPR7RVn7rcb
	cY55XNAK0b6XzA7UCmTsrVPNKrw6F/eDPxMdU7y8gheCL6K/+ypLticKDQlOzXJrhAhQ287Os0O
	yWwdEXSBDjNJ7poJ/AKtIIyXe3BECg3UCfqqm3PFmFRfsAJMMREZBFVgTMIpEAieunqxyjDZanY
	7mHpCg8+4nZT0b6Eq6CzpNs=
X-Google-Smtp-Source: AGHT+IGYHPDGHRk803HqsJ/h90af6xrIY7Mf7R19/B2Fn7IzgZFYLu/4zxNoDli0QRJMOCD6eIn4og==
X-Received: by 2002:a05:6402:34c5:b0:5d0:d818:559d with SMTP id 4fb4d7f45d1cf-5d0d818590dmr7569797a12.11.1733083412708;
        Sun, 01 Dec 2024 12:03:32 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599905164sm426179966b.141.2024.12.01.12.03.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 12:03:31 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e2880606so1863190f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 12:03:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQM4jYMvSWdIlFAY3mbv9WjgR3X/JcV/lqzWzpl5lzA0TJJAuuPs6Ed1zN0nU3yCzCtugomoLFc+tqC5I=@vger.kernel.org
X-Received: by 2002:a5d:47cd:0:b0:385:ed1e:20fe with SMTP id
 ffacd0b85a97d-385ed1e2320mr4238223f8f.59.1733083411058; Sun, 01 Dec 2024
 12:03:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e654a20c9045487eaacbd256f584ce45@AcuMS.aculab.com>
In-Reply-To: <e654a20c9045487eaacbd256f584ce45@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 1 Dec 2024 12:03:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiG7dGtE6UsynOP3FuvApkh=FYrv1Q42DEVZmosuOFXnQ@mail.gmail.com>
Message-ID: <CAHk-=wiG7dGtE6UsynOP3FuvApkh=FYrv1Q42DEVZmosuOFXnQ@mail.gmail.com>
Subject: Re: [PATCH next] x86: mask_user_address() return base of guard page
 for kernel addresses
To: David Laight <David.Laight@aculab.com>
Cc: "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 1 Dec 2024 at 10:12, David Laight <David.Laight@aculab.com> wrote:
>
> I've built and run a kernel with it - so not broken!

I worry that 'cmov' could be predicted - making the whole sequence
pointless. It would be a stupid thing for a CPU core to do, but it
would be simple.

Of course, 'sbb' could be done using predicting the carry flag too.
There's a lot of ways to screw this up.

Intel at some point explicitly said

 "Other instructions such as CMOVcc, AND, ADC, SBB and SETcc can also
be used to prevent bounds
  check bypass by constraining speculative execution on current family
6 processors (Intel=C2=AE Core=E2=84=A2,
  Intel=C2=AE Atom=E2=84=A2, Intel=C2=AE Xeon=C2=AE and Intel=C2=AE Xeon Ph=
i=E2=84=A2 processors).
However, these instructions may not
  be guaranteed to do so on future Intel processors"

so none of these are safe according to that.

Maybe there were newer updates on this, but in the meantime I'd rather
have just *one* pattern, not switch between multiple possibly
problematic ones. And sbb has been that traditional one.

Also, if sbb is ever made speculative, I think it's time to just jump ship.

             Linus

