Return-Path: <linux-kernel+bounces-244825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ACA92A9F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFC7284858
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8BC14BFB4;
	Mon,  8 Jul 2024 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A22UySBg"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73033149DFD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467688; cv=none; b=nRqjyFPDOpxRT/zXfs+yJ6Z3ltZCGhmPeW0FtRJMJidONTPCR5Zn3JDbDKTNUnJg4cGP0UXachNotTsIdneXhws1J3xTXBIzlNFeApAcWXIfKZWdz/yqGrRSFQCVPfIkoh0qJSxehfRNsu8wwcwRgFQPzx+TuGENYjFW1R9gcwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467688; c=relaxed/simple;
	bh=J7SMmk8dkfxhtog/4tWjeMnExbVnXCqmGT5M8Wv6bCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8uVvrExMDjxfye6BCl6T6SOlmnrOW4iAaLGg4EYb3ST0lB2292c/rTmpjdJney+4XSNSLGaeVh8WxgQgRI9Xf+2j+OGUxeAf1hShV2T1w1Af7hmuvibP96wYrx3rkFqtwCsqjJ1SoM2A13LnIaQn7oQMCYMPqBGH9CJ5vAm+hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A22UySBg; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso2199910a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 12:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720467687; x=1721072487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVILaPzBf0V9Eob5sjaqfm/n4CHzoRJIANCVQTtCSIs=;
        b=A22UySBgefkGS7ukEfw4aMGekLyuVel/Y5he+WRFURMFdW3g7gX/Kw8bcx6CE2lmB5
         sUyH9lhPFYQNB5LZuBND35ul84dkgfLVk/TCmU2t18ADoNh/b/EeSvroXo6IgoRqEnQe
         CxgaGgpkJhvs7kZ+Ji7PkrVFqEmZd33/FdnKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720467687; x=1721072487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVILaPzBf0V9Eob5sjaqfm/n4CHzoRJIANCVQTtCSIs=;
        b=lX07KtDJTYdKaZUrtexn+2bM0fEojKf0A8pxpYnqp65fZZzX0jiT6N65/FTWi5KYBA
         Ag7GDam2kr7QBNIU/pfPNgO9Zgw9CRH+q5ShGUlo18JKtRaYEpWuegpzFcTffyHVqZk3
         lwBOrvGNsf/bjenlTCLzWXbBK/0O9GIESk8whrlVtnzWIYpuDLfZuLetUioU5EfX72Qy
         j3NNcBLgEsvvhkP6KBA5IwtJlC4A0XhBTf/l8Y3U+hCI8H4XXjRQ0d49ocAa7+M4/UJB
         kMhxdO7aciUayyC6jg6kQy0xMRlSyK/0zJZpo25ValCSzhTsnUCLmB2HzSF71wLsJu3B
         qpqg==
X-Forwarded-Encrypted: i=1; AJvYcCVa9xhW6PTZimno88wd9EnxJSVPvXXlASiz01UNY78ZqQSHXlh32F28APDwREGU2/if8LHxFKaQNInvdfzfJj5mJPS5MsL0f7Exwuum
X-Gm-Message-State: AOJu0Yy53RfGSjtpkxYa5FSMivUqow8ou19g0kPH5FX9ANeWyBUG2LoA
	bMWHX2sDzF5rwXgD8ZOhsEn+ewJcZ1T0x8j4r0qaZWg4B3GsENjdzn22fupbOQ==
X-Google-Smtp-Source: AGHT+IGFI+xvdFWrb7IGzUvJh5OcLaq0riRRLCgKBNM5auJrGfeuMLRHx5Co1Yo1+Ag27hiq8HMFKw==
X-Received: by 2002:a05:6a21:4d81:b0:1c0:e5b9:404d with SMTP id adf61e73a8af0-1c2982211e5mr392455637.26.1720467686832;
        Mon, 08 Jul 2024 12:41:26 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:3e22:9cde:6b65:e5e8])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1fbb6a12ccfsm2414365ad.47.2024.07.08.12.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 12:41:26 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:41:25 -0700
From: Brian Norris <briannorris@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Yury Norov <yury.norov@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH] cpumask: Switch from inline to __always_inline
Message-ID: <ZoxA5cPpfcpKkzSM@google.com>
References: <20240514204910.1383909-1-briannorris@chromium.org>
 <ZnsML1RYMmEhhdPP@google.com>
 <ZoWhPFJIvGpMGKm4@yury-ThinkPad>
 <20240703195724.GA292031@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703195724.GA292031@thelio-3990X>

Hi Yury, Nathan,

On Wed, Jul 03, 2024 at 12:57:24PM -0700, Nathan Chancellor wrote:
> On Wed, Jul 03, 2024 at 12:06:36PM -0700, Yury Norov wrote:
> > On Tue, Jun 25, 2024 at 11:27:59AM -0700, Brian Norris wrote:
> > > On Tue, May 14, 2024 at 01:49:01PM -0700, Brian Norris wrote:
> > > > This change (plus more) has been previously proposed for other reasons
> > > > -- that some of the bitmask 'const' machinery doesn't work without
> > > > inlining -- in the past as:
> > > > 
> > > >   Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
> > > >   https://lore.kernel.org/all/20221027043810.350460-2-yury.norov@gmail.com/
> > > > 
> > > > It seems like a good idea to at least make all cpumask functions use
> > > > __always_inline; several already do.
> 
> > I feel that if we decide making cpumask an __always_inline is the
> > right way, we also should make underlying bitmap API __always_inline
> > just as well. Otherwise, there will be a chance of having outlined
> > bitmap helpers, which may confuse clang again.
> 
> If this does not result in noticeable bloat, this may not be a bad
> idea. I seem to recall this being an issue in the past for us but I
> cannot seem to find the issue at this point. Commit 1dc01abad654
> ("cpumask: Always inline helpers which use bit manipulation functions")
> comes to mind.

In the above quote, I already referenced Yury's previous post to do just
that (__always_inline for all of bitmask and cpumask). I don't know why
that wasn't ever merged, so I instead chose a smaller set that resolved
my current problems.

I can dust that off, rebase it, and give it a bloat check if that's
preferable though.

Brian

