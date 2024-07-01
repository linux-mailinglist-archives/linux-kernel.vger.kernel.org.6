Return-Path: <linux-kernel+bounces-236315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB69C91E055
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE26B221FC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C68315DBC0;
	Mon,  1 Jul 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZFxPA3i4"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2641EB2A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839620; cv=none; b=V8XIE0xUerfiozHhj9MzCgIuVGM6rfZ25Dm0dmeeW9IdRZ7oQYPtj1Uft9esx2MA34fZDGGNounmuTjkxri2mqGPgvdf9nqO7UdRFgC6c1OVMF9sZ7XMeYKi7O2UI/feaRXdu350RCxtptQRHGD6zykSSi1sBdlY1NhPJxJKGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839620; c=relaxed/simple;
	bh=X1xqYcKxhEqksta9F6+PAgNFku7VwC9TA9WS5zubs+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3z/X/e3hW9KnM9lJ6UJ3CgdFujBR+wArHbgh2QievA8xfjpIbAnnTX1TZT0HRNb9XdwvO5eJtHbp3nhtXG6DIYvXtwYkhAR7ANcbsO2IM6tZVuC1pSlUfV+ZHJoPSK0nFQAR+XEAbIWy2ujm5k7X1MT2dCos2joXWGR3HHfr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZFxPA3i4; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso47955581fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719839616; x=1720444416; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PMZrss2U3YMCU2gehj174wPWeOrCwWO2m+b4W1tpn9w=;
        b=ZFxPA3i4lZMf+OIEmaZsN1sw6gE2vEmMhUATI24+hSvVe/1HYKXs/qYX6YES1narcY
         rhz6xT99FJi8X0HG5ETcXyzHkqj0C6RjfUmI8KGly3b9Hfz/l2kvfLKiKNWtvlu+bBDK
         pbS71fuIJKaV1gZT+q4nr9SxypzB6Ft5DSHo1dY6TpwFMhGs346yGXLK1DsecTM2T471
         oENTb6UoKhdB6Cmd978Mh5KTEd0hhR3pCN4HqpmYYSJ4TKsTk9vEzq7V1kgPzq5PhimT
         7keVl/OJoPjQbgrG3cvqA4+cCdMrq1Z+mzOrFUN8zniSl+F6z9vZzovlHSA8T2TUVCLg
         RnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719839616; x=1720444416;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMZrss2U3YMCU2gehj174wPWeOrCwWO2m+b4W1tpn9w=;
        b=Om1L82amslWjQB3g6JVk3EOwNVu3StV4cJO8SV1EpJrl3f0MAVZ5NGKZABSwfObdlT
         +p4+tc+CKvYDYCsgey5At0ohywYm/+mUiBf8InqAuyPtLWP5Knjgdket56X+UtxOYvjx
         YIaLhQJ2tv1+gc8XK5LIJ+ArXH8SXNpt5urtk6SO7vpxaWtzFGb/PuzKxxvHLSCkMMTG
         Ot4DwHglIVl2S6nNlmlQU4YAGtxzWcGX3jlaBDAv3WQD6X2pKb6wTqIKltdmSgqeoTSl
         criqCv241NKAImYQShVabLwMTwwV4pMKw7wLPivzQ+3aEBVc7y/0EOfeJO/Gn9Cczj4w
         4mVw==
X-Forwarded-Encrypted: i=1; AJvYcCUOn5hbNk9nGoNMxO2APfZkOMqZmPSaOnlA0/fUesl5vVdW6OWtG3y17hGCYeUfNzcJ4iDxhM414B5t0NZAyZTSjWo0QCiWVn8sWUin
X-Gm-Message-State: AOJu0YzutUxjuj6SZaw6jhQc+6V9/siEVyaLXP91BWsac9TBgv9SXPMV
	fQFP1Ia5K8UcBosXA/t3DOXQJWUyVGFcqIpo71MZ/ZjZ9UZC/2JOfhCS+44N45Y=
X-Google-Smtp-Source: AGHT+IF+mb29Cx6OyDWYBUeFAC8VB1iv5b+zJARyMloC2bSs0QHLV080ePtRlc/xmjNtDKtCLGbgfw==
X-Received: by 2002:a05:651c:103a:b0:2eb:eb96:c07d with SMTP id 38308e7fff4ca-2ee5e3936ffmr44184101fa.14.1719839616256;
        Mon, 01 Jul 2024 06:13:36 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a9540fsm6393679b3a.216.2024.07.01.06.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 06:13:35 -0700 (PDT)
Date: Mon, 1 Jul 2024 15:13:23 +0200
From: Petr Mladek <pmladek@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>,
	Sami Tolvanen <samitolvanen@google.com>, Song Liu <song@kernel.org>,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	jpoimboe@kernel.org, jikos@kernel.org, joe.lawrence@redhat.com,
	nathan@kernel.org, morbo@google.com, justinstitt@google.com,
	thunder.leizhen@huawei.com, kees@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] kallsyms, livepatch: Fix livepatch with CONFIG_LTO_CLANG
Message-ID: <ZoKrWU7Gif-7M4vL@pathway.suse.cz>
References: <20240605032120.3179157-1-song@kernel.org>
 <alpine.LSU.2.21.2406071458531.29080@pobox.suse.cz>
 <CAPhsuW5th55V3PfskJvpG=4bwacKP8c8DpVYUyVUzt70KC7=gw@mail.gmail.com>
 <alpine.LSU.2.21.2406281420590.15826@pobox.suse.cz>
 <Zn70rQE1HkJ_2h6r@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zn70rQE1HkJ_2h6r@bombadil.infradead.org>

On Fri 2024-06-28 10:36:45, Luis Chamberlain wrote:
> On Fri, Jun 28, 2024 at 02:23:49PM +0200, Miroslav Benes wrote:
> > On Fri, 7 Jun 2024, Song Liu wrote:
> > 
> > > Hi Miroslav,
> > > 
> > > Thanks for reviewing the patch!
> > > 
> > > On Fri, Jun 7, 2024 at 6:06 AM Miroslav Benes <mbenes@suse.cz> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, 4 Jun 2024, Song Liu wrote:
> > > >
> > > > > With CONFIG_LTO_CLANG, the compiler may postfix symbols with .llvm.<hash>
> > > > > to avoid symbol duplication. scripts/kallsyms.c sorted the symbols
> > > > > without these postfixes. The default symbol lookup also removes these
> > > > > postfixes before comparing symbols.
> > > > >
> > > > > On the other hand, livepatch need to look up symbols with the full names.
> > > > > However, calling kallsyms_on_each_match_symbol with full name (with the
> > > > > postfix) cannot find the symbol(s). As a result, we cannot livepatch
> > > > > kernel functions with .llvm.<hash> postfix or kernel functions that use
> > > > > relocation information to symbols with .llvm.<hash> postfixes.
> > > > >
> > > > > Fix this by calling kallsyms_on_each_match_symbol without the postfix;
> > > > > and then match the full name (with postfix) in klp_match_callback.
> > > > >
> > > > > Signed-off-by: Song Liu <song@kernel.org>
> > > > > ---
> > > > >  include/linux/kallsyms.h | 13 +++++++++++++
> > > > >  kernel/kallsyms.c        | 21 ++++++++++++++++-----
> > > > >  kernel/livepatch/core.c  | 32 +++++++++++++++++++++++++++++++-
> > > > >  3 files changed, 60 insertions(+), 6 deletions(-)
> > > >
> > > > I do not like much that something which seems to be kallsyms-internal is
> > > > leaked out. You need to export cleanup_symbol_name() and there is now a
> > > > lot of code outside. I would feel much more comfortable if it is all
> > > > hidden from kallsyms users and kept there. Would it be possible?
> > > 
> > > I think it is possible. Currently, kallsyms_on_each_match_symbol matches
> > > symbols without the postfix. We can add a variation or a parameter, so
> > > that it matches the full name with post fix.
> > 
> > I think it might be better.

Also, I agree that we need another variant of kallsyms_on_each_match_symbol()
which would match the full name.

> > Luis, what is your take on this?

[ Luis probably removed too much context here. IMHO, the following
  sentence was talking about another problem in the original mail..

> > If I am not mistaken, there was a patch set to address this. Luis might 
> > remember more.

I believe that Miroslav was talking about
https://lore.kernel.org/all/20231204214635.2916691-1-alessandro.carminati@gmail.com/

It is a patch solving the opposite problem. It allows to match
an exact symbol even when there were more symbols of the same name.
It would allow to get rid of the sympos.


> Yeah this is a real issue outside of CONFIG_LTO_CLANG, Rust modules is
> another example where instead of symbol names they want to use full
> hashes. So, as I hinted to you Sami, can we knock two birds with one stone
> here and move CONFIG_LTO_CLANG to use the same strategy as Rust so we
> have two users instead of just one? Then we resolve this. In fact
> what I suggested was even to allow even non-Rust, and in this case
> even with gcc to enable this world. This gives much more wider scope
> of testing / review / impact of these sorts of changes and world view
> and it would resolve the Rust case, the live patch CONFIG_LTO_CLANG
> world too.

So, you suggest to search the symbols by a hash. Do I get it correctly?

Well, it might bring back the original problem. I mean
the commit 8b8e6b5d3b013b0 ("kallsyms: strip ThinLTO hashes from
static functions") added cleanup_symbol_name() so that user-space
tool do not need to take care of the "unstable" suffix.

So, it seems that we have two use cases:

   1. Some user-space tools want to ignore the extra suffix. I guess
      that it is in the case when the suffix is added only because
      the function was optimized.

      It can't work if there are two different functions of the same
      name. Otherwise, the user-space tool would not know which one
      they are tracing.


   2. There are other use-cases, including livepatching, where we
      want to be 100% sure that we match the right symbol.

      They want to match the full names. They even need to distinguish
      symbols with the same name.


IMHO, we need a separate API for each use-case.

Best Regards,
Petr

