Return-Path: <linux-kernel+bounces-237144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EC691EC5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E911F21D12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 01:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCED79DF;
	Tue,  2 Jul 2024 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EfH4ROsX"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4A8BE2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719882688; cv=none; b=tRgxOxs6enEzC7SCn6GNmdpaiTeymkNo0inXkF5s+qTO1b8tS6JS4r+2e+aiE7XIstvY+ircOl582U0MGqYx58L+ypdH7J6uESpfryinaEjQRY+HtkbPXnfRKHng0p/mYb23rb371+UMT3LdEUdUmqDUqubYt+zyMtaTgdQhXTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719882688; c=relaxed/simple;
	bh=biT3U/JccAbT2ojx0tZxE5iP92A3N2y/C6UXL+enRrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oH4nJj7SRw1exiJK+hSSdgW5sPMOOBj1auKVItWnpEUZ3gwoF3zieaJf+zdblxO7y1xyx904UaZhIctZxNLuZQTMv3w7ivW0niv+sYA4kLaTmUu701PUhA2Ow02GAo3MWzZgs0+9i+VULU7EA118UGp96yZkEqUQA2TJmA8wZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EfH4ROsX; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-376208fbe7bso16347765ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 18:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719882684; x=1720487484; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uX6X6yvrHwqLhmQHKxP9UTvaXr+RRFTXVS2da0ydaXo=;
        b=EfH4ROsXN6xs5exZDDyginzKlAnuc5tTQc6L6dNV6gUYfVSK2yg9uQE/ioZng5QScR
         MPeHYLAqCm543JDTpPtLqa+DMM+Q/l/2BQdDNMd7C0Tz4a0WMl+09B62ORLg4XhPEGH4
         FO9DJBN3rkySrW+7hsUAVVeSJt52apMan4WBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719882684; x=1720487484;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX6X6yvrHwqLhmQHKxP9UTvaXr+RRFTXVS2da0ydaXo=;
        b=nlm3b8LLS4ogzbF3JDjXKkzDzXbzCLj0xKEJJLFO5LA1gVObxtgecRVyOjV09yLZjB
         BPOq6x4I87iiNZD5Ql3dznUUtJs4zDBB1N7J5rklaE2MYPrvEOwjqwHXW652Yub7Z1w0
         xyEGA5KkgspbQs0+u1Za9M3eZu+/C1Fxgo6USHtdvDB31dOVTi3JMxU2BbJEs3Dy0Tbg
         UfiODsCwZKzqRJl9zuIR8Yd1FemFyZh6MeJLqZkS0IGs3Y6q6frSh4gfgTg7ecg6qjGK
         H/9XhDgqy0PXm3tGxIk1lrcjdZNQMIS5F7+qtONvzJ406+eZuRhf9ISEJDUz9+Ih8kSU
         VGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDRN20ZkMrj8ArD+ngp74o/7ZUWV0kez+E8Ot/e+7Kt44vP42KjYM5qww9cDH/rvjR+OA1tpxGrpG33EOwtrNAV4ALVtiRT/Jf9nWP
X-Gm-Message-State: AOJu0YyyjnNiJXZNNaSJo8HdlVcbN5WafIX6+mIm4cWZGyQZPuTJJ2pQ
	3VZDUfBUuMDSDVDXKMCC/F4iW55Cx7mVb7bw1Ho7+T7zRC9gnSWzhig+0nMnvA==
X-Google-Smtp-Source: AGHT+IHKvM67M6eFvhtx26GdTIevtvHk/JUwsJ5jHaRe/vO4GAOUaipYYggq2lOfLdjdexOoMh93bg==
X-Received: by 2002:a05:6e02:1d1c:b0:375:dad7:a65e with SMTP id e9e14a558f8ab-37cd2bed7a1mr105954005ab.24.1719882684580;
        Mon, 01 Jul 2024 18:11:24 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:32ea:b45d:f22f:94c0])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-708045a69a6sm7187177b3a.165.2024.07.01.18.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 18:11:24 -0700 (PDT)
Date: Mon, 1 Jul 2024 18:11:22 -0700
From: Brian Norris <briannorris@chromium.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 3/3] tools build: Correct bpf fixdep dependencies
Message-ID: <ZoNTuvhq3tSNpXT4@google.com>
References: <20240702003119.3641219-1-briannorris@chromium.org>
 <20240702003119.3641219-4-briannorris@chromium.org>
 <CAEf4Bzbxu_PJsDE_ex_FBi+SKnWZjVA8vA11vL2BxUhyBB6CAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbxu_PJsDE_ex_FBi+SKnWZjVA8vA11vL2BxUhyBB6CAw@mail.gmail.com>

On Mon, Jul 01, 2024 at 05:50:35PM -0700, Andrii Nakryiko wrote:
> On Mon, Jul 1, 2024 at 5:32 PM Brian Norris <briannorris@chromium.org> wrote:
> > --- a/tools/lib/bpf/Makefile
> > +++ b/tools/lib/bpf/Makefile
> > @@ -153,7 +153,11 @@ $(BPF_IN_SHARED): force $(BPF_GENERATED)
> >         echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
> >         $(Q)$(MAKE) $(build)=libbpf OUTPUT=$(SHARED_OBJDIR) CFLAGS="$(CFLAGS) $(SHLIB_FLAGS)"
> >
> > -$(BPF_IN_STATIC): force $(BPF_GENERATED)
> > +$(STATIC_OBJDIR):
> > +       $(Q)mkdir -p $@
> > +
> > +$(BPF_IN_STATIC): force $(BPF_GENERATED) | $(STATIC_OBJDIR)
> 
> wouldn't $(BPF_IN_SHARED) target need a similar treatment?

Hmm, probably. I'll admit, I only debugged errors that show up in the
top-level kernel build. The only tools/bpf stuff tied to the top-level
build is resolve_btfids, which uses the static library, not the shared.

And now that I poke around at some other build targets, this highlights
that my patch introduced some problems with the independent libbpf
build. Particularly, $(OUTPUT) is a relative path in some cases, and
that relative path gets interpreted differently in recursive make (when
we change cwd). So please don't accept this patch as-is.

Brian

> > +       $(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= OUTPUT=$(STATIC_OBJDIR) $(STATIC_OBJDIR)fixdep
> >         $(Q)$(MAKE) $(build)=libbpf OUTPUT=$(STATIC_OBJDIR)
> >
> >  $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h

