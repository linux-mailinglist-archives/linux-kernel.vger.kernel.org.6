Return-Path: <linux-kernel+bounces-378301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 593209ACE0B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781361C2249D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B938C1CB501;
	Wed, 23 Oct 2024 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9LPmaL9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4CB1C9DC6;
	Wed, 23 Oct 2024 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695328; cv=none; b=fFviV0/khQjCrLebdttKalaGTWJMWcut1wkcCyPRyvHTDVn8SMS+ztPIANMWr/NP6QaXzjM7gfZ0nLjfysMA4+wnm9F9OccCMQjjbJh0ap7nRntLhx8VxheAjzvHx67c67DXPoP4hCu87ct3WATP4c+a64rtBup0InsT4VEEJUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695328; c=relaxed/simple;
	bh=qWDKmNUBrdLzUZSaopOc/3EXNbxBEdmqLrDDQ6f7uL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZX5BGZ6ihuzXs5apgFe2FewirNjrKnsrNQIdjKvDeTT71V7nB43P6QX9AvUrtOp1ZaK0I694e5/1v4M22zaBJoO3dflbHTg/8c4rhUKCEjsCzAi/0YW04KmowjyD7VHc3qk9hda3xIn1OQX7Py8GF04EVC9gXLY17nEXaKHdYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9LPmaL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D6AC4CEE4;
	Wed, 23 Oct 2024 14:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729695328;
	bh=qWDKmNUBrdLzUZSaopOc/3EXNbxBEdmqLrDDQ6f7uL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9LPmaL92TOIAWY6U7dEpyY8LeAzw6OjJB3tc5GrPeIY/EoC6RUYcMoIo3fNu/eLT
	 fSisBzC7GNhpvhWW0h1wSTl2aL8xgQMZPCPrH7MasVyvZ0fNuH30geTpf84OlUhONG
	 bQlMmHsJ2z8Q+RGgNCkUVdP8fzWBtqEcxHW7tjxQIaGWMajEzoSW1APNmyl+1QFMXv
	 9/JliAaoeNXJOh3jqLpSFPMUz9dXRezbN/J0vk+lviXDJIWXI/Jluf6g3StBshSEBw
	 8yXvxaaj6f/Gbjgn7/a5rL/5lOuQvzSek+2HbSCQ7MFmtREktAY6jST62Jnni1WNtk
	 15hPF9Nvy6BJA==
Date: Wed, 23 Oct 2024 15:55:22 +0100
From: Will Deacon <will@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Andrew Pinski <pinskia@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, llvm@lists.linux.dev,
	syzbot+908886656a02769af987@syzkaller.appspotmail.com,
	"Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>
Subject: Re: [PATCH 1/2] kasan: Fix Software Tag-Based KASAN with GCC
Message-ID: <20241023145521.GA28800@willie-the-truck>
References: <20241021120013.3209481-1-elver@google.com>
 <20241021172058.GB26179@willie-the-truck>
 <CA+=Sn1m7KYkJHL3gis6+7M2-o9fuuzDtyUmycKnHK9KKEr2LtA@mail.gmail.com>
 <CANpmjNOf94nQL8YVr94L=9qXA6eHcm-AxbS+vz+Sm1aHJT2iAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANpmjNOf94nQL8YVr94L=9qXA6eHcm-AxbS+vz+Sm1aHJT2iAQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Oct 22, 2024 at 11:42:40PM +0200, Marco Elver wrote:
> On Mon, 21 Oct 2024 at 19:29, Andrew Pinski <pinskia@gmail.com> wrote:
> >
> > On Mon, Oct 21, 2024 at 10:21 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Mon, Oct 21, 2024 at 02:00:10PM +0200, Marco Elver wrote:
> > > > Per [1], -fsanitize=kernel-hwaddress with GCC currently does not disable
> > > > instrumentation in functions with __attribute__((no_sanitize_address)).
> > > >
> > > > However, __attribute__((no_sanitize("hwaddress"))) does correctly
> > > > disable instrumentation. Use it instead.
> > > >
> > > > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117196 [1]
> > > > Link: https://lore.kernel.org/r/000000000000f362e80620e27859@google.com
> > > > Link: https://lore.kernel.org/r/ZvFGwKfoC4yVjN_X@J2N7QTR9R3
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=218854
> > > > Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
> > > > Tested-by: Andrey Konovalov <andreyknvl@gmail.com>
> > > > Cc: Andrew Pinski <pinskia@gmail.com>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > ---
> > > >  include/linux/compiler-gcc.h | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> > > > index f805adaa316e..cd6f9aae311f 100644
> > > > --- a/include/linux/compiler-gcc.h
> > > > +++ b/include/linux/compiler-gcc.h
> > > > @@ -80,7 +80,11 @@
> > > >  #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
> > > >  #endif
> > > >
> > > > +#ifdef __SANITIZE_HWADDRESS__
> > > > +#define __no_sanitize_address __attribute__((__no_sanitize__("hwaddress")))
> > > > +#else
> > > >  #define __no_sanitize_address __attribute__((__no_sanitize_address__))
> > > > +#endif
> > >
> > > Does this work correctly for all versions of GCC that support
> > > -fsanitize=kernel-hwaddress?
> >
> > Yes, tested from GCC 11+, kernel-hwaddress was added in GCC 11.
> > Also tested from clang 9.0+ and it works there too.
> 
> +1 yes. From what I can tell GCC always supported
> no_sanitize("hwaddress") for -fsanitize=kernel-hwaddress.

Thanks, both, for confirming this. I'll pick these up as fixes in the
arm64 tree.

> Even for Clang, we define __no_sanitize_address to include
> no_sanitize("hwaddress"):
> https://elixir.bootlin.com/linux/v6.11.4/source/include/linux/compiler-clang.h#L29
> 
> So this has just been an oversight when GCC support for KASAN_SW_TAGS
> was introduced.
> 
> Having a Fixes tag for this would be nice, but I don't think we
> explicitly added GCC support, and instead just relied on
> CC_HAS_KASAN_SW_TAGS with cc-option telling us if the flag is
> supported.
> 
> But maybe we can use this:
> 
> Fixes: 7b861a53e46b ("kasan: Bump required compiler version")

I can add that to patch 1.

Will

