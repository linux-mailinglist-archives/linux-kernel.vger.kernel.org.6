Return-Path: <linux-kernel+bounces-417267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C259D51C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD681F210DE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7D21D3656;
	Thu, 21 Nov 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTipAVX/"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933691ACDE7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210094; cv=none; b=ju6XBeshhKRph2nVevC0z/yD8GztpyZqYwuw3Ncn9kJl0R6+TfQ4OTGfK1Q9WHhtioq/Z+tTBFruXigo8F3cqTWJIgg2JcXkKvvauGWPvgdVILCNE911vHdoLncShrXsTdINfjK64tzDHCTDzfLeHaTTtCtAo7rec5yQfMSJGEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210094; c=relaxed/simple;
	bh=HDlO+c1C2yLuRLkGcMdW31ieHzzoqKOZatA2RnIXkr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOIVyNUEcBg5HxG2+Z2cZnS7C+y/74cbborpwcC4pvfoBlXNuHabD7qQjtNbRVJZ0VM8se9kK4FoXePck13i9WL/FckmslmSa372/x7cGS6EbdlRJEszgwNu/mF0SfUrM/npsesIq8JQekxct9soWLSrppCK0kvvX5C01WeAxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTipAVX/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso938408b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732210092; x=1732814892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUujZ0vfqIHopDqCO24kOSaCqkx5c2bzcxIPVMvRxJQ=;
        b=KTipAVX/535T62Clm77BoajDNe3cHqOzE2zz1uj+LJNQ03l3f9VAMx9deS9ksX0126
         TSlmpJO+jzOxHL+Ey6xkFLU8cxidmikpJTCVWuyTcqvfFUh2Tgf7c94T0GuiwyWS8ibN
         m6YtS5/OMtsqNltEQjN6b2iC9xjN4scqgsDzudGNC8Ro7UzOU94jWXeSnn3nx9d5ESFQ
         cr3I6Jppa4Xyq5o85BkZTav66dGO/VeXDnHbB8L9TZcI3ziyTO5PTXiRNWhJnMJboeWG
         /RAg2yL225P8hpxHucK7SZMRIo2VIpX/mS1ru83z5wVqHObeGgrfs1I3zOuv4WAdfi0j
         z7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732210092; x=1732814892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUujZ0vfqIHopDqCO24kOSaCqkx5c2bzcxIPVMvRxJQ=;
        b=hjz6s7c7hE6oK10M2B27xcE+LNs6IJ/V8Yt7m54Py301W3Al4bI2I5GIJoJilYNNHq
         uGrS2iqJVElNFKrWJzW+HWNIIBrAUFC1fFggtgNm6pDN0M5Fnv4U+FmS9asVvHZs3hJd
         gpXY+vnTD8RUMAO6ttccjCNywCIMafCt2KZpgbBAuifdPcjqt3xU5OLINDrt10E4/Gpw
         ev+XAq2UPVyykCBM5y1ExwqAzSsDTTr309v0NTH6mSAxUrWGN5177Zf28dknsYoNh4XO
         RuM/thzrUsxtHdL38lW0FQdpPJ7pnw34YcK+KzBZaAHUBYlW0JObe8Gl6x8+MgmVGeGa
         4vxg==
X-Forwarded-Encrypted: i=1; AJvYcCXskLu2fXM/gJA5P5RXmgQn8t8/Hb3eOxbKoVxO67Qj9G29Z3t2Nz3ZDR6xQqQBSv1Rhhw0K3ESjToBnD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB49D8joL7PTBKKy8XKk/GOsn1vgN/HnQpCIp3Jrycs5OR7CNR
	u3atfpcClaYnJg6IbTYLVWlLoabQ+tcrMZtG+P6b2ANXLUPSN7iRRr9ddeDX4y7HMq6M8bXR1yw
	LIHE5xynVjVyAbdqBGYqcyT03iqQ=
X-Gm-Gg: ASbGnctxKlSkHkc6sol6+K3XddOfCQEMB1Zfh9+se3dO7QG1sx4ZOyVmtoufC3YfKm+
	J11f8trHHLm/af1ubVDHOMsCdLNoi4iORWAQ7msaIuaK+t+UbDadUd7cRCIB5oWYC3A==
X-Google-Smtp-Source: AGHT+IFm10HXjJM98hmkDah4HHzt/rH6rZ2L0hImspsuEVGx/bCXSs8+l4R92v7sRnEUnS/7ZCEi75F8/P2PEeZqoHg=
X-Received: by 2002:a05:6a00:814:b0:71e:58be:3604 with SMTP id
 d2e1a72fcca58-724bec8769dmr8028104b3a.4.1732210091801; Thu, 21 Nov 2024
 09:28:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-fix-dereference-null-x86-sev-v2-1-7e637851dfe2@gmail.com>
 <20241119210336.GEZzz9KMiZwf6R9hwd@fat_crate.local> <CAE8VWiKQ4fdeBeoWbGf55QXaqHrEdSCxo5qTJ=S2vKVd5W1scw@mail.gmail.com>
 <20241120190318.GCZz4ydl5z5mUHrJd4@fat_crate.local>
In-Reply-To: <20241120190318.GCZz4ydl5z5mUHrJd4@fat_crate.local>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Thu, 21 Nov 2024 22:57:59 +0530
Message-ID: <CAE8VWiKubZ5Z7yEgLh5ourc+0W1OC+54y+vC-i=xLVLYK=_YGA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/sev: Fix dereference NULL return value
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 12:33=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Wed, Nov 20, 2024 at 06:23:09PM +0530, Shresth Prasad wrote:
> > lookup_address() does return NULL in some paths so I do assume that it
>
> You assume?
>
> Well, do you know or not? You can simply read lookup_address() and more
> specifically lookup_address_in_pgd_attr() and see whether it can return N=
ULL
> or not.
>
> As to this particular case, I don't think it would return a NULL. Otherwi=
se
> something else is very very wrong so perhaps it is better to crash'n'burn
> there.
>
> What would happen if you continue instead on a NULL ptr? Would that make =
sense
> either?
>
> Basically, I'm trying to make you think before you send patches. Just bec=
ause
> some silly tool says something is wrong, it doesn't mean you should trust=
 it
> blindly.
>
> You analyze the situation and *then* you send a patch, only when it is re=
ally
> an issue.
>
> > can happen, unless there's a logical reason why it can't (please let me=
 know
> > if that's the case). I've also seen it be checked this way in a couple =
other
> > places.
>
> Kernel programming is not voodoo. You read the code and think.
>
> > I'm not sure why you can't open the page but would it help if I was mor=
e
> > descriptive in the commit message?
>
> SYNOPSYS
>
> Username:
> Password:
>
> is what I get.
>
> > Really sorry about that, I completely overlooked it. I'll CC them
> > when I resend the patch.
>
> Before you do, I'd like you to turn on brain and think about the question=
s
> above.
>
> And I'd like you to please read
>
> https://kernel.org/doc/html/latest/process/development-process.html
>
> and especially
>
> https://kernel.org/doc/html/latest/process/submitting-patches.html
>
> before you submit more patches.
>
> I'm not typing those to get ignored. I mean, I can ignore emails too if m=
ine
> get ignored.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

I apologise, my approach here was incorrect. I'll rethink how I submit
patches from now on.
It wasn't my intention to ignore any part of your message. I
absolutely went through the docs that you linked.

Thank you for your time.

Best Regards,
Shresth

