Return-Path: <linux-kernel+bounces-439990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064839EB735
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA6C188387F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D95231C8A;
	Tue, 10 Dec 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g4BzczLN"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E22309AF
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849647; cv=none; b=nWWGDrQlqM7URL03LFz6rU9ivCw8vLjq2ybqi9UvC1BKy9+JSBpKNJvFLwfdt/Wd1f00NlyWBADLD273l+XXLADtCHnlwwLcqIznTSSGcWxFeVCzhntGXTo5VkhY/dRhEo0VM8L6uAEO8TxIV97YSjF8B3d4llz8Ey1Lnbh5p34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849647; c=relaxed/simple;
	bh=l/8HBPCwyuNycmVKwayvf4SiKQB/PKOeP06ko+JSfEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+8xLfjqQdc2DGuaqX4iUlyD5YpiLeQ57QFur/12oVwuGoaMqBikYbkoASWppxxnlme/Q9mi1L77lUUULVGR7MHQG0mn2ImQeKk/4dca+B+van7YgPJ/C15wli2qCwJp+1/TTH72CTEV1iHYa65giSeiJkBb8vlqBEQgD8rn38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g4BzczLN; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30229d5b21cso16796211fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733849640; x=1734454440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/8HBPCwyuNycmVKwayvf4SiKQB/PKOeP06ko+JSfEI=;
        b=g4BzczLNekrJb9xykIcQgbaEFNiLSj0CCJ3eWSKcD/+/uWw5RZeFIJRAkC3VpEY0sH
         MXo43DWeFo4dkCH6wLMFdE2CtmImISdyA+EHaSpQHURInTdDfZONRi0qrJ9MRIoE+e7h
         QbWppbs7xY0YPQ/w9/u/EhVvTwGGxLsFv6fvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733849640; x=1734454440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/8HBPCwyuNycmVKwayvf4SiKQB/PKOeP06ko+JSfEI=;
        b=i88Jq3gzMy96q8Tlx8Pqcy3KZOwsLf/QUAJoFbhnrfEx1ae9CDC0K5Za4YJNIAlPAZ
         LhElV37x20pgXuPe8QYlZR4rHTIbEh8D5mCGHrm0d0+jGeFD+kP0seXxh6nrM9IcJLJt
         I+JKskH8C9tiBOooEtG1LRsH45cJRPf3tkkHWyJvhQACqc3jxUTPNht1VI67dlzq5p0p
         RDOTBBg8D0ekxtkKgzH4m8CrQ9TI9nAoB+JAQzMMadO//0MkAvKaAikAp6STUrTw+WMl
         yUB5oPE57iyvxnqqnDd3Jn3v93pcTLKLC/olWDbAj4O80CIFFX70hl09E70uijbRVcId
         dBHw==
X-Forwarded-Encrypted: i=1; AJvYcCVF9HKIoh5J5wrxLgADMVpgjJiAo4J/yrNto8T6P4ID7NezRzbxHHpfA/C+EruM1uAr5ur1818a8Y9NnbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjuuIev7B1KIkSbgSShpmaPwffT/+RmLHxs9JdsB4c6kmyhvwH
	oVGRvc8mkb7kUlECuyRju+2roMAqcoVLn5hWGo0qU8Vyckdf+vDkbLEmhUjuHJmQ7DQveN9jIpE
	o8A==
X-Gm-Gg: ASbGncu5uzJ4UTHZZUR/DgyvPngWThFM8FLGhsEUgvxYPoJ28KovNkECQB5l9NPWmLJ
	eKq6CVuYVse9t4NtZF2NdRO/xoz/LS/JbEFkZy1MMgBQvO8GbkMEmyoeD7v8UetvWVAitwcrG8+
	nyUOIjZXsFNpwpUTlkOvxDGCZxQhnITy4Mq8vOSkk6Xa62P0cxegRNvoVLNIDryofRN6fCDJCuX
	QwUDpBkO6pwH8h1gaJbkNMbAOsMitiYUzb4KWj7GufE/RC2UWQ49JD9oteKwBcgbU+IFNjXPLxZ
	K5aL6kbocryMaXrRTQ==
X-Google-Smtp-Source: AGHT+IGYcP+NOWnAY+A0zYg1hRq3LLlTSYFmvNIp/odxi5qGwfA0h7/gjsef8Q/TxuZ0jkcMvZPnWQ==
X-Received: by 2002:a2e:bc16:0:b0:302:2202:14dd with SMTP id 38308e7fff4ca-3022fd3cb07mr17377921fa.20.1733849640394;
        Tue, 10 Dec 2024 08:54:00 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30031e14003sm12942321fa.36.2024.12.10.08.53.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 08:53:58 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54026562221so754672e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:53:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXra8d8VgRnbxZU3dXbXalPPF9kBd8GeHT7ZEzzM9/ZgQQahyGJCscyfwuX0VxN3G6jTSUmhPeF1HViTjE=@vger.kernel.org
X-Received: by 2002:a05:6512:318b:b0:53e:3103:b967 with SMTP id
 2adb3069b0e04-54024108256mr1868839e87.35.1733849637744; Tue, 10 Dec 2024
 08:53:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209174430.2904353-1-dianders@chromium.org> <20241210155604.GA15918@willie-the-truck>
In-Reply-To: <20241210155604.GA15918@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Dec 2024 08:53:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U5xraosVuDGXxBN5Ajo0n=s50JZqtgQGPs1C9jM3YaFw@mail.gmail.com>
X-Gm-Features: AZHOrDk7WvPRzq9z4VNazAXpYtL75nSHpExN5slME765TfN80XYGbQfqOs7VNn0
Message-ID: <CAD=FV=U5xraosVuDGXxBN5Ajo0n=s50JZqtgQGPs1C9jM3YaFw@mail.gmail.com>
Subject: Re: [PATCH 0/6] arm64: errata: Add Qualcomm CPUs to the Spectre
 mitigation lists
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Julius Werner <jwerner@chromium.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
	Roxana Bradescu <roxabee@google.com>, bjorn.andersson@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, Trilok Soni <quic_tsoni@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Besar Wicaksono <bwicaksono@nvidia.com>, D Scott Phillips <scott@os.amperecomputing.com>, 
	Easwar Hariharan <eahariha@linux.microsoft.com>, Oliver Upton <oliver.upton@linux.dev>, 
	linux-kernel@vger.kernel.org, james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 10, 2024 at 7:56=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> Hi Doug,
>
> On Mon, Dec 09, 2024 at 09:43:10AM -0800, Douglas Anderson wrote:
> >
> > Since Qualcomm CPUs are all derivatives of ARM cores they all have
> > unique MIDR values. This means that the tables listing necessary
> > Spectre mitigations need special entries for them. However, those
> > entries are not present and that means that some Spectre mitigations
> > are lacking for Qualcomm CPUs.
> >
> > I've made an attempt at **GUESSING** what the right patches should be
> > to enable mitigations for Qualcomm CPUs. This is mostly me searching
> > the web to figure out what ARM cores various Qualcomm cores are based
> > off of.
> >
> > These patches get more and more sketchy as the series progresses and I
> > have noted that the later patces DON'T EVEN COMPILE. I have included
> > them to make it obvious that I think these cores are affected even if
> > I don't have all the right information to mitigate them. Hopefully
> > Qualcomm can come and fix this mess for me.
> >
> > I'll note that I am certainly no expert on Spectre. Mostly I ended up
> > here running `lscpu` on a device and noticing that it thought that it
> > wasn't affected by Spectre v2 when I thought it was.
>
> Whilst only Qualcomm can say definitively whether or not they are
> affected (and what values of 'k' are required for the loop-based
> workarounds), I can't help but wonder whether the current mitigation
> code is structured the wrong way around in this case.
>
> It looks to me like we don't have a way to identify a "vulnerable" CPU
> for Spectre-BHB; either a CPU has some sort of mitigation or it's
> unaffected. That means that there's very little incentive for vendors
> to add their CPUs to one of the lists -- if they do nothing, userspace
> is told that everything is golden and they don't pay the performance
> hit of a workaround!
>
> So I think we should consider turning this on its head and assume that
> CPUs we don't know about are vulnerable, having a list of unaffected
> cores that predate the introduction of CSV2.3 which can be queried by
> is_spectre_bhb_affected(). We can do that without the assistance of the
> CPU vendors.
>
> Does that make sense, or did I miss something?

It makes sense to me. I'm not sure I'd be the best person to actually
implement that, though. Maybe someone CCed on this thread could take a
stab at it? It seems like folks from ARM would know the most about the
various mitigations and which pre-CSV2.3 cores were safe.

-Doug

