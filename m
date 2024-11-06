Return-Path: <linux-kernel+bounces-399002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB65A9BF926
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D891C21CEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8901D20CCF2;
	Wed,  6 Nov 2024 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RvjM3cOT"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5623520C47F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931593; cv=none; b=KmuqPyftOIOkXnlvlTljNRgYqqrntEZ7t0EJFdbFJPnvnP8UHGXdIHzYguuEgPypXgoGHGbfA8LTV7fXipUvP9/N6wpvGPvI7d//b/AZDLDWwkUeNL4mzfHxfONRuZuBmkfwXFonrR2F4gGALVD2vkx4VTD+OD3BZ5PrYcz94CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931593; c=relaxed/simple;
	bh=oBnBqWpM8lRdtEoqkpENq0fMTF0z3JfZf00+3RNW9zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWHeeYr2HtpJOAPtdd4hItiLRIv7AZ3WEGXUv6X60aoZOKCIUu41/a93Js1Xr13H4X3Kbhx12s5D8RjNyu5rtxHDsaKMv27+8lf/1/zCDgc7DOKX0jQMI2fr/32fHnillhL508OQHxgQuZp2rXLaxGqZ8HXy1nyhgxJhjotEDTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RvjM3cOT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c947c00f26so2427a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 14:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730931591; x=1731536391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VIfMB0/RRt0Ar1Plzd0i42wcI4LGr6zVtLHR+97rgBY=;
        b=RvjM3cOTcqB/hxPw4bBvMJEFKEJsFueDkFcki+11WjTgflchF3SVXTd+1Ay0uD2CUK
         KwPGBCImdQtQU/UYiPcEzzHHd95JAeNnXeyJOqokGNR8IPJEnB8qwaHGvXF/ePSceMdm
         WmDm6c8WDspITHEtx709i2VHyfzomGBHmhVz5x75dy0iJK0gb042cUOdhWwxdmheK7+E
         00v5aQzV9FObAVyhGgPTqB/Usfg5opluGpSchzfG1o6JgELDa56AToVMZXoZp61guguo
         M4ve8BOVjtaVk9PZg1Zz7Ll5FpBkFQqJ9hwX1Eka6K73yvHfEQeI8BesACY2ERg4RYFE
         h37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931591; x=1731536391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIfMB0/RRt0Ar1Plzd0i42wcI4LGr6zVtLHR+97rgBY=;
        b=irvKTrmvU5pw3kQ/hw4PYB7FKnMN6BugcbVijDh0qfW7HWKbfKoYI8czyYJ1AX79Ts
         Bt52WbHzTQ9M5sBoE0Bb7n1olasDL7FrOOl/5p5wDHXhl7eeXJnuXmnQhg8mQWOa1dZ9
         C8OAPFYozebzpCTjchZNKmAY7oGEMPYedUAlwzLluET6m/E4eYm3zXH6Yx02Ifgf0q8m
         mAF4TWmmRAqlrUcVeGNkMlu5Lso8pTo8p/mT1Bx2Xe4tL1uLxDbxeWOckMMpmC6vD5lo
         Bbk4HyCA1Hq5Dp2sXh1ayKeHObitIY7ObPlWkOvVhdgMJanAqd7FRYRcYNZykVbsHKAY
         pQAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHMh3MQ5jNqgp/Cu6QEUxeoNhrSyoxAi5aKIytA5KIdjFL0D5z0/fC/a1lesfkMTYe9kKepPSFT7K1EyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsS8PvWKuhZ9zCWeujZ0+AmVVXwRIi5xzrzixoMKQhi5DGLm2q
	XqAB+Z52EXIBLoiLq4tgMldN6E7xMh4I0rZDCHzZ2mC1goBuiuvjTrMhzreec/1fIDTaSV2B7E+
	Bl1WplMTU+Ky3ijDm2UiVpJcYJEIDGUPSR69J
X-Gm-Gg: ASbGnctVqBz0D4VaY51CfNfPsE4z8yvtZhaagr6+QYz6dLksQUBBEmDEQ4HN7Epwvbc
	5v3iYD1BgxEHLC3WBy+vJ4KsdQqRRnfGMWRd2pyt521+wG3lCxkmIN/3lN6K/
X-Google-Smtp-Source: AGHT+IHr43cQPFdqXPCZMuhW0YfDPZKYdGnYJyq09Flo3eqNIAHnldTJTztppmJyfXcIKbSiu12OxTpcgO6RCsjM9mo=
X-Received: by 2002:a50:8d09:0:b0:5cb:6b7e:9634 with SMTP id
 4fb4d7f45d1cf-5cefbc29fcfmr233654a12.2.1730931590492; Wed, 06 Nov 2024
 14:19:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-extended-modversions-v8-0-93acdef62ce8@google.com>
 <20241030-extended-modversions-v8-2-93acdef62ce8@google.com>
 <ZyNr--iMz_6Fj4yq@bombadil.infradead.org> <CAGSQo00F07viDHQkwBS8_1-THxJHYwx9VkS=TXC5rz3i8zSZSw@mail.gmail.com>
 <ZyVDv0mTm3Bgh1BR@bombadil.infradead.org> <CAGSQo02uDZ5QoRMPOn=3Fa9g5d+VPfKW-vmSsS2H+pOdPYCBFw@mail.gmail.com>
 <ZyrRYUD0K1f7SwWg@bombadil.infradead.org>
In-Reply-To: <ZyrRYUD0K1f7SwWg@bombadil.infradead.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 6 Nov 2024 14:19:38 -0800
Message-ID: <CAGSQo03+1WjUVj-iQ6zdOST6z=p+=OqS2Xk_c4ZUdHOsxa7g2w@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] modpost: Produce extended MODVERSIONS information
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, Lucas De Marchi <lucas.de.marchi@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> > If booted against an old kernel, it will
> > behave as though there is no modversions information.
>
> Huh? This I don't get. If you have the new libkmod and boot
> an old kernel, that should just not break becauase well, long
> symbols were not ever supported properly anyway, so no regression.

Specifically, if you set NO_BASIC_MODVERSIONS, build a module, and
then load said module with a kernel *before* EXTENDED_MODVERSIONS
existed, it will see no modversion info on the module to check. This
will be true regardless of symbol length.

>
> I'm not quite sure I understood your last comment here though,
> can you clarify what you meant?
>
> Anyway, so now that this is all cleared up, the next question I have
> is, let's compare a NO_BASIC_MODVERSIONS world now, given that the
> userspace requirements aren't large at all, what actual benefits does
> using this new extended mod versions have? Why wouldn't a distro end
> up preferring this for say a future release for all modules?

I think a distro will end up preferring using this for all modules,
but was intending to put both in for a transitional period until the
new format was more accepted.

>
>   Luis

