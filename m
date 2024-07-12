Return-Path: <linux-kernel+bounces-251153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F114930149
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1BA284001
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749AF4776A;
	Fri, 12 Jul 2024 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JIeZ24R1"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500B84778E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815841; cv=none; b=MMcHrbsdQjWpmXjSyhhqjApn3iiO0r3EZRsT7DqD0fNbbM2dpOU4AHgtDorI24q0dDojwhw7wnGaO4ktynTpBjh4vhgewC1MRwhuubtDa8ZjEWa/qOsqFj1gj9CMso7D3KStHIB0X8zTm3YmtwMXxZddkY1GiQWDAMAv5Me+/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815841; c=relaxed/simple;
	bh=UWpkjm+bNJpSBeffNgCexDtJjnqEBWkOkbBoIfzuPfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naAVnp4zyeYNVlE1+V9Tn5jAsQBnRcHDMdn5LeBBWcTMTvdl2uISJenIPRyOr5fTdjauY5wZfchR/NV278miqHkFzW1bnjNER8IdZbsAkyE+3qkGd8KCwy+MWcwguR4KYM02pEbZnpoysE6cZE1hf4le+9P9gZS/4cGxFH+8CEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JIeZ24R1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70af4868d3dso2137951b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720815839; x=1721420639; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hf9lMH8FXC/GAp1YqBmmTVjDYJ9ZMKh92cvFp4a7iII=;
        b=JIeZ24R196Y28caDGwTyWDp2ZDgxzWT71yAP3qvMiGrN16ZBK+Pq01JX4DEWmpgzCT
         uIZxa8w97Tz/F8Q0Z8Gb2Y+/xp2plf8+Ax8vm1LH6Urkegz+Cey/QrUuwIQPwgY86e6T
         t50gZJV2a18qoMv3IYrmoonOeQAqPIgBmIsVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720815839; x=1721420639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf9lMH8FXC/GAp1YqBmmTVjDYJ9ZMKh92cvFp4a7iII=;
        b=eWZNYIFhSKJyTcPHs7y77zlZt0dv2T/K4rX4RrCkGFpHA39XeB5pFUwGBjQ0dqZdMv
         4Ryw2fqTJP/xfAVEC5xBVe67vb1AwlD8gnl4z0yoKFQkp5BR0ACjUI0tJtUZfnOEYUya
         EgqAZYPISNxhs/swAer5zcoCp8ypg6/NIOM1RE+BXuLuwJBJCOf9gE1XtHCsx9qHmsO2
         uBdW6623Y2o4ZdAXszx0XsJE1MU5whm49XVOKnXswh+C0YVC46Oso5h3WMYg6NkfffW9
         iKW7BecSsG7C6h3XKwufLr/go258aizGTwWt2Y7jM52SR7R2+VgFRqc9ewiJrCXTOpcf
         GisA==
X-Forwarded-Encrypted: i=1; AJvYcCVOd/8WNT4sWsyb4/vfinFGY6YPK+8dAnqSjH8MZt6PMgjkpPMFYdETzi/p/Mvg7+1rpPnOM/hewM2U4IJd+phyE2zVcG7c/TKw9+M7
X-Gm-Message-State: AOJu0YxlQD2/6IWe4FDuCnq/wUl7VA8CinrP2vZM27MZOzfUcKaVmPpC
	erQ9O3zJSi2eNyeXDsn51hZ8nQ3NBEpsZ9AeHFrdaD11D2PaeL4J4+4/rugnhQ==
X-Google-Smtp-Source: AGHT+IG2GTXZu2uRjdFrTSv44X2Ka4Gg2maPyT6oX8YP7inykgDj54rRDX10nXgMIvG0pX0ZIkLKtA==
X-Received: by 2002:a05:6a00:988:b0:704:31dd:a28a with SMTP id d2e1a72fcca58-70b435854damr15091453b3a.18.1720815839444;
        Fri, 12 Jul 2024 13:23:59 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:7546:30be:53d8:7f93])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-70b438e538fsm7923889b3a.87.2024.07.12.13.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 13:23:58 -0700 (PDT)
Date: Fri, 12 Jul 2024 13:23:57 -0700
From: Brian Norris <briannorris@chromium.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v3 3/3] tools build: Correct bpf fixdep dependencies
Message-ID: <ZpGQ3TShk-IGb4b1@google.com>
References: <20240709204203.1481851-1-briannorris@chromium.org>
 <20240709204203.1481851-4-briannorris@chromium.org>
 <CAEf4Bzb6-DLL966XKyMhe+nmpvdqYVrzfmfkAiDdFHNyD0qGWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb6-DLL966XKyMhe+nmpvdqYVrzfmfkAiDdFHNyD0qGWw@mail.gmail.com>

Hi Andrii,

On Fri, Jul 12, 2024 at 12:38:28PM -0700, Andrii Nakryiko wrote:
> I almost gave my acked-by and tested-by, but then I noticed that this
> leaves fixdep, staticobjs and sharedobjs directories as
> to-be-committed files. Please check, something is off with .gitignore
> or where those are put:
> 
> $ cd ~/linux/tools/lib/bpf
> $ make -j90
> $ git st
> On branch master
> Your branch is ahead of 'bpf-next/master' by 4 commits.
>   (use "git push" to publish your local commits)
> 
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>         fixdep
>         sharedobjs/
>         staticobjs/
> 
> nothing added to commit but untracked files present (use "git add" to track)
> 
> 
> Other than that the changes look good, but we should be leaving
> uncommitted (and unignored) files around.

Thanks for looking and for the diligence. At first I thought I moved the
dirs by accident, but that's not the case. The problem is that I'm now
leaving a 'fixdep' artifact in these dirs (they already had a variety of
*.o, etc., files, which were already ignored), so the containing dirs
now show up in the untracked list. I've added a 'fixdep' .gitignore in
my upcoming v4, as well as proper cleaning (fixdep-clean) for it too.

> On Tue, Jul 9, 2024 at 1:43 PM Brian Norris <briannorris@chromium.org> wrote:
> > -$(BPF_IN_SHARED): force $(BPF_GENERATED)
> > +$(SHARED_OBJDIR):
> > +       $(Q)mkdir -p $@
> > +
> > +$(STATIC_OBJDIR):
> > +       $(Q)mkdir -p $@
> 
> I'd probably combine the above two rules into one, but it's minor

Ack. I forgot some Makefile-language details when writing this part.
I'll update in v4.

I'll probably send v4 next week.

Thanks,
Brian

