Return-Path: <linux-kernel+bounces-575508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1870A7037D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019A3189E541
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132A325A321;
	Tue, 25 Mar 2025 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsS+bDCT"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB227257458
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912125; cv=none; b=NUlnFeLCTeOPduzirL8jX3FvG4m80qj/+uGXQyuaIQbC1vp8eIsaCc/5EXJPkg2gn6MQ1esJqWljPX8VztxbjwoWQBflEOWNfz4Yt/g1/LdWVflysrX54pY2QbeQj3xV8Da1qn64ESR+7Sh+HSUxOWq8ojdmzlp59jc5+vfUzxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912125; c=relaxed/simple;
	bh=w5EreeKhUAgOFBnSwIf3AdHlAHNu2gpXo2JDwr7A0mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdqlVCBmDLNzFxGRgnWev/nR0+/GzM466Kcgfitb8IetrZszEmyx8KZoArswtllIBNVJWHxBoVUpAfA5RhP8leyi3bXtefDQ4sVWpOz6aGe7qJAl+6v+1KMFkt0kwCjSjhWyo76VaSCQos6WcM3b1JniI4Cr2wiEVF2PRleDzSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsS+bDCT; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7430e27b2so1176084366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742912122; x=1743516922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5EreeKhUAgOFBnSwIf3AdHlAHNu2gpXo2JDwr7A0mw=;
        b=RsS+bDCTRsw3oLhK1k++h3929OfVnwzde299fG6y/mvlEvJffJny3w/LhOYx+YDyeY
         6PzTo+biuHbav01A1cV3Zdw/1W+yzT7+e0TQ8jY4CMNE2EHPCHXMTIp1f2DIrsa3K2bU
         KoNNT7/KiV1h3w33lUsflyg6edKSVTncBekdjym34HcSciT6t7hfx7WOFfKyo/5AdLfK
         5jHaNonj0GYEYrlUENBm2+ZAekTKIX5QjbcgqaQrXAUAbCL8blCufXq4+VRFtgciumGU
         1n5DIS5DvuBur2GaWf/GmJ2WMZM3EWRxYMOfDJVnuTuZsEq8RQ1hTUyQwgcsB7w8E9gB
         YmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742912122; x=1743516922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5EreeKhUAgOFBnSwIf3AdHlAHNu2gpXo2JDwr7A0mw=;
        b=Ybr+3lYGXrOHxT2RNm3d+200a7azG3GRasxEsUDFaz0F9AjhRaRGKGeHugHmnZPK7r
         LDhRdNj1fmjw6bExk2oe1RB28qCC9OvtkLbIlggMVLv3HldFWv9hsgRpndiokBJSH4FM
         WFePn6ga1hpbhi/AYhDJB9zsFfAzRMxYTdg4xn/+BIYsCPymwdGbqSA7J0INLMh2lmR+
         hlSU2AJ7tdHUFz2Ncw5Fo0LdouMSu1g3tlMn7I5RJO9wL9Fs6ho1W+F493cbyVoPcA1G
         YyNac2i+ucuH/0w5kOleCnCGJEhqeOVEsD6Zz642ShqEPRydt5MfCP0pWc66f/xJfXfl
         VJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVw7y16D0snkMuxtoMUR3zFhwzb7a/ai6QRwTtPCpcyyi9AB7tq3cc7VduidH6+5amsW9YRXFaaGHgLO58=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFrSIXrzwRQ5NFyQKGApJ2jmGZ+YUx02ljH92BvHccDlrzvtV
	gakiiQqZGe/4LJ0V6507wTT70KIJdBgvr8bVhMHO/QQM3eQNRbGsmZwsb/Vi+XMORinF9X7R0JN
	Uukwc1wluGpgBX972d7EfWo3kVgPw+S7piZc=
X-Gm-Gg: ASbGncvzuYfR7Jr9tP61xaGBDSmFsl0Wm7ePD5gssnm3BVIkfyllyAWHszDQtkHxbD8
	3eTvIJGs8D/wI8ObcJXeSzNgwLMlmgWBzl1pgG4H1IxIccO8pWFnNC/JvpAx9d5iNhRHsfJotql
	Mc4ms++SzQeyFdJ6OdCh4V+09T4sfr
X-Google-Smtp-Source: AGHT+IHK0fJ2cGUy3PZ7GPK/m1tOr2sUxPAQ0Rh/AzS1MwkJsiVSy6WDJm6paNd+KuGtf2AomV4Ok/Ofy7InlJTm66o=
X-Received: by 2002:a17:907:6ea7:b0:ac6:b816:454f with SMTP id
 a640c23a62f3a-ac6b816458bmr385675666b.54.1742912121823; Tue, 25 Mar 2025
 07:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-x86_x2apic-v3-4-b0cbaa6fa338@ixit.cz>
 <20250322175052.43611-1-mat.jonczyk@o2.pl> <Z998eR-9QNL1R-71@surfacebook.localdomain>
 <Z-JZnueg7EvMFJqK@gmail.com>
In-Reply-To: <Z-JZnueg7EvMFJqK@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 25 Mar 2025 16:14:45 +0200
X-Gm-Features: AQ5f1JouQfAX51lH_jtINaDcfKoo2ATRpdfeDsSCfxVJ29CHbGveW3iY0GsWSoo
Message-ID: <CAHp75Ve++2rEGe7Ob=sRw7qBC-kf5v8_Ag9h99rrn5yd7Kx9cw@mail.gmail.com>
Subject: Re: [PATCH] x86/Kconfig: fix lists in X86_EXTENDED_PLATFORM help text
To: Ingo Molnar <mingo@kernel.org>
Cc: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	David Heideberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 9:22=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
> * Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > Sat, Mar 22, 2025 at 06:50:52PM +0100, Mateusz Jo=C5=84czyk kirjoitti:
> > > Support for STA2X11-based systems was removed in February in
> > > commit dcbb01fbb7ae ("x86/pci: Remove old STA2x11 support")
> > >
> > > Intel MID for 32-bit platforms was removed from this list also in
> >
> > Was it? It's rather hidden and not recommended as far as I understand.
>
> Well, with the '32-bit' qualifier the statement is true, isn't it?

> ca5955dd5f08 removed a MID reference from the 32-bit list and added a
> different one to the 64-bit list:

Ah, right, we are talking only about the _list_ here and not about the
support code. Now it's all clear, indeed.

--=20
With Best Regards,
Andy Shevchenko

