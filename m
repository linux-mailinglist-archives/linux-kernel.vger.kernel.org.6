Return-Path: <linux-kernel+bounces-398675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD69BF48D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8AE286279
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B180A2076DE;
	Wed,  6 Nov 2024 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BF8u8o0M"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380B2076CE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915295; cv=none; b=J0JjH5sxbdGIuIqDip2Y8ZVzYI+blkYXZsQ3GajN0yyAyDPcCQCUz8ljZK6yUFVacmk+Tvxzo3PzREOv0iMiPUpxA5U1t7dbIAjk/IwlOX3tFY5XwMJKnrFH0YzZmgwmAbqplRYD1kJG2eqgGJeqhU8+GlC0yBg80Gzqlt1+g4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915295; c=relaxed/simple;
	bh=XHGR4TbaIFA5RiOjgpvGsz6oPFk+rF9NAYjLz+uUjKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DX33qCeM+ylLCVZSwqtbjDFkOA/0urQ/jTjtD/STFvYlOR0fP1PVWF+5jRywX3x+mpGJop3howr77J0oeBcmeXUVUykKXsZd5Ler0BXbnn9IBWAmujq7vSJmdVYhUSaR/ZaW0s1yLg+6f8cvoWvbR2zlUCZoWzrmy7lgbY1MX4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BF8u8o0M; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso2829866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 09:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730915291; x=1731520091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kSRDhdffu4e2+4oYE1K3ibBkFCx+1qf9H7kDEjsKsEc=;
        b=BF8u8o0MFRMMfkaBgmIDHAXqzXQhQO+6disO2QZey4Uvz8lSxm6aK6/0FjRr/hvQo+
         2Z95QkbIAKxNtOtZJuVA4Kj6u0X9fjLBFtvEdwh8oP6PLVRubX7J8gPxXakOanqvDDBB
         7ldOleyAlRvRP/t+S98VsJdwLCzEOc2wP0miE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730915291; x=1731520091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSRDhdffu4e2+4oYE1K3ibBkFCx+1qf9H7kDEjsKsEc=;
        b=u95zouuYBYkObmXl4ShNulCNLm8wXkSWR13LiromXTBHkDjI/i0liHOTJHznwJOCOf
         RUGVvdSF4oTn/FYoKX+Pp78VJCH9/XtTeOZviSCbOTkKY2oGI7OnaDPABcy45KZP2mmQ
         eJODGR/ADS76i3GriYPbWdgnEmF61exrLGvfyaQhwELObG+aLG1RU00na4ZtDPiXuhxi
         K2tEssZ8DtiUI87D5aMaKVuBxJaiTNAvOPY4yS7soIohmaJptL0rXtbpbrRd1mkAp8cG
         yrWMeaeosGeHUloxZIBy/+oSzMepwBKrRDFJaJlDy62OCj2EDJwNIRmbT5md0xRQ9VUN
         PbtA==
X-Forwarded-Encrypted: i=1; AJvYcCWYUtxfiqkO2wcfMJUc2hsysvHkfO+4tzke8mzacM/dlcWxR4Kyi0a9Dwxo9/Xvqp7uZa6F84R1dO/Q5B8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz91Wx0una7HtELc/Wgg9tDkiGHfUpgIGxdjml78RboxepqoG6v
	llIXUg/A4f9wuhTVlWnOXgfhZMH0a39G4mcI2+Prasw/FxcExocY1bcH9/INaY7uzj72yd39h85
	7
X-Google-Smtp-Source: AGHT+IFIKKlFHI6HtNyziSVe4BIHcE2PZkuPBmNbi3jNq5hN7RnM24DWLSB3igEgJXhWs8pSlc/9ig==
X-Received: by 2002:a17:907:d29:b0:a99:4b56:cf76 with SMTP id a640c23a62f3a-a9de61d6bb6mr3991912166b.47.1730915291256;
        Wed, 06 Nov 2024 09:48:11 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17f964csm311358566b.159.2024.11.06.09.48.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 09:48:09 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99eb8b607aso1227366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 09:48:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCValODFP0at80kPCIii5yFsiLX4FL9SrS8cKaYSnWSaYBM2k+KvSXaPVpp9nsdiy3fgqT7HUvzzEgUxquc=@vger.kernel.org
X-Received: by 2002:a17:907:9405:b0:a9a:1792:f24 with SMTP id
 a640c23a62f3a-a9de5ee19acmr4107136066b.24.1730915289172; Wed, 06 Nov 2024
 09:48:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106140414.760b502c@canb.auug.org.au> <20241106100234.189029a5@gandalf.local.home>
In-Reply-To: <20241106100234.189029a5@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Nov 2024 07:47:52 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjSKCbbQHr7gm9G0z_hdjBSprCyMidi4LhYL7YECdRfqw@mail.gmail.com>
Message-ID: <CAHk-=wjSKCbbQHr7gm9G0z_hdjBSprCyMidi4LhYL7YECdRfqw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the ftrace tree
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Naveen N Rao <naveen@kernel.org>, 
	PowerPC <linuxppc-dev@lists.ozlabs.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Nov 2024 at 05:02, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> This fix looks fine to me. How should we handle this when we send our pull
> requests to Linus? I may forgot about this issue, and it also matters who's
> tree goes first.

So just mention the issue in the pull request - preferably on both
sides. Particularly for something like this that won't show up as an
actual conflict, and that I won't catch in my build test because it's
ppc-specific, I'd really like both trees to note this, so that
regardless of ordering I'll be aware.

And hey, sometimes people forget, and we'll see this issue (again) in
mainline. It happens. Particularly with these kinds of semantic
conflicts that are so easy to miss.

I've seen this report, of course, but I will have lots of pull
requests the next merge window, so the likelihood of me forgetting
this detail is probably higher than the likelihood of individual
maintainers forgetting about it when they generate their one (or few)
pull request.

                  Linus

