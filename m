Return-Path: <linux-kernel+bounces-170236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE208BD3E4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F752B21F60
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9E6157499;
	Mon,  6 May 2024 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UBUlIBpH"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0499157461
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016971; cv=none; b=e5ZDSkyO9lvcOx7dtjphmw8dGp80gFq1Jeb/E1iyjFjZGNfbJvDGdNIekq6Z59XXwJnMV8b9jRClOMoS6yzqnNi4Hysb6sGPbclR1ICEOHg5IMDUeM3QLWIxZJmMdUgOObtbfdQh0TqefZ+ex1nNijHSP8V1WAw2mvg+Tu0cx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016971; c=relaxed/simple;
	bh=BOv4/FKnDwPV8GTCpu8TlwRJ40xZi31sTqgRiYOmAZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIQDvTdDdwp6my71goHranHdz5ymtnyEiCGV4JZ1zNIBJwNywVgjVdlsY5biCUAFTa8OjslbhCpLxcSY3KvlUMBOshyCA/6cSsvXGbCfOB9scjhLnt2I/uyBc073tbW9fU9dgC8VN7fqt8p/v/RV03zc7SoDPm2FCEJTrzwS5lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UBUlIBpH; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f489e64eb3so425074b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715016969; x=1715621769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M1cirPsDQQFnLCIO2tBGU3gB6zTRLcomHcl4pwwjw8s=;
        b=UBUlIBpH0pseQyy/9SHrVlyC/Kh5tqm+TYI/+LxlHPiF/2y72manS6eh6t+GQTJQsN
         L35Y11H9E1ga+wDVqfPn69BgcZO8Ze1yhDRG0MnSuM+MO6hdbOF4MMIbYlZOAAtKwt+G
         Ghmfb0NLpmsQxvizzWoypqfAwMkil4AjF9Yko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715016969; x=1715621769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1cirPsDQQFnLCIO2tBGU3gB6zTRLcomHcl4pwwjw8s=;
        b=kuHt6NPgv62Bg6zMYRV5ReJZP6+xoBOcMbdvdl/czmxtBSYoFf/POK+d6bWbKJkx6w
         Z4StpMyBRFZHX1x5xn+wvdo5xHwSETWaqFi9xT7XMnw6b61eSVXewN1FzfbVl6URL8Hr
         bju3iYkzFdaKzHW+NvsD/4jGBdb2WxOiwjB/0h5OUVvqGJaQ0Im2y0tw6pMlcfFlHfpm
         lbGK5M7ra2yBd5ZC6NCWceo9QnRmsWsTY6rLVeGB/Ub4j9lprfmnFqTQV6yDAIr9hxHs
         XHXLL7RdZxajIdbI9Y83DYmftbeEag9nhRzISNyGGmsnrrAavtGM7zUn3RbpxqP8hs0g
         BKwA==
X-Forwarded-Encrypted: i=1; AJvYcCXSsx0s9fXxa53UVLvMPuxqJg9LrR3MwiwXRlkFoD5WrhO/4RjwhXDmbcKg60h2Cs4s1YB6FqBGZwBNVZco2n0KUmxxOqmBI1I64HhJ
X-Gm-Message-State: AOJu0YzJ7bMnpPBF//JEfbpBPQm8acBLAeNU9tFaueXpD9THeAKkXM/8
	LHTNYcEcFfUwLWiZ/4Q7QQ97BWan7gJShiqVy4pvDYuZjwJP3mHsGzH/8FwXQA==
X-Google-Smtp-Source: AGHT+IH64A0FOEe5/2xo0QYeaE7m5Kei+LLQ4NIRMhtTPpqVuiCTUVzsc6UrWFJLgPQ8RmxEHZY8ew==
X-Received: by 2002:a05:6a20:9c8d:b0:1af:8ca1:8fec with SMTP id mj13-20020a056a209c8d00b001af8ca18fecmr7727792pzb.16.1715016969024;
        Mon, 06 May 2024 10:36:09 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i7-20020a056a00004700b006f45e6e9470sm4250255pfk.209.2024.05.06.10.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 10:36:07 -0700 (PDT)
Date: Mon, 6 May 2024 10:36:06 -0700
From: Kees Cook <keescook@chromium.org>
To: Joao Moreira <joao@overdrivepizza.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <202405061031.43EE1C4@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08H8zJ5lQ62jel5@hirez.programming.kicks-ass.net>
 <c561dd8ec384bfc77998a6db6ed824e7@overdrivepizza.com>
 <Y08M4+GxoqvuZ+bq@hirez.programming.kicks-ass.net>
 <d219d61420c48a90a2e8bdc29cb8a579@overdrivepizza.com>
 <202210182218.56AD2871@keescook>
 <baced047981ff5fce633156e3e374dfd@overdrivepizza.com>
 <202211011437.F82B61B8C@keescook>
 <1f6069657f4630c36d60baab2e9b3d10@overdrivepizza.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f6069657f4630c36d60baab2e9b3d10@overdrivepizza.com>

*thread necromancy*

On Tue, Nov 01, 2022 at 02:50:22PM -0700, Joao Moreira wrote:
> On 2022-11-01 14:39, Kees Cook wrote:
> > On Mon, Oct 31, 2022 at 12:13:50PM -0700, Joao Moreira wrote:
> > > On 2022-10-18 22:19, Kees Cook wrote:
> > > > On Tue, Oct 18, 2022 at 09:48:42PM -0700, Joao Moreira wrote:
> > > > > > > Is it useful to get the compiler to emit 0xcc with
> > > > > > > -fpatchable-function-entry under any circumstance? I can probably
> > > > > > > change
> > > > > > > that quickly if needed/useful.
> > > > > >
> > > > > > Having it emit 0xcc for the bytes in front of the symbol might be
> > > > > > interesting. It would mean a few kernel changes, but nothing too hard.
> > > 
> > > Should I push for this within clang? I have the patch semi-ready
> > > (below) and
> > > would have some cycles this week for polishing it.
> > 
> > Sure! While the NOP vs CC issue isn't very interesting when IBT is
> > available, it's nice for non-IBT to make attackers have to target
> > addresses precisely.
> > 
> > If it's really invasive or hard to maintain in Clang (or objtool),
> > then I'd say leave it as-is.
> 
> The Clang implementation is actually quite simple and, IIRC, I heard in the
> past someone mentioning that trapping instructions actually provide benefits
> for holding undesired straight-line speculation. Maybe someone can comment
> on that, or even if that is really relevant.
> 
> Meanwhile I'll work on pushing it then.

I happened to be looking at in-memory CFI preambles again and noticed
that there's still a NOP sled at every function that got a __cfi_...
target (which only matters in the non-IBT world).

I can't find a PR for your NOP->INT3 patch:
https://github.com/lvwr/llvm-project/commit/ca9029c4536d0544e35dff85e4806803e256841f

Are you able to get this refreshed and landed?

Thanks!

-Kees

-- 
Kees Cook

