Return-Path: <linux-kernel+bounces-522753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4D5A3CE2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79214189B4F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDEC7B3E1;
	Thu, 20 Feb 2025 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z1NGxv4r"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F694208A9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740012004; cv=none; b=pLnneKnJzpbC54CusXcGGTYxkrANgaI5Nqgwud3auzu6aIV/AsGRWMFBjHYOI/pT08Rlqt/enf0kFO3KacYHeMI9YzxXHfvTDO+1Dv0c99QOC6dgnW8TTDG+YP1motUtRifoc7ZCsKX8jKPeQgJLrMmVrwi7CxYXMg4mcEBDdQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740012004; c=relaxed/simple;
	bh=g7DErytRUuAKrZakuD3eHoT8POJrCda3VPRgb8Uz+54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfTdDumxhcseBe9DbkKU8BJiPKUWSUijpsa8UERJgJKvrBoJwxmvyrZNIQHGQGp36TOIiIZmp9ktfHL0lJ2MDz3B8giOTeK5SGbov7f2S7YZWjuCQtGaLrN7jvPprejYMCL37BrcF4cK+deslOk9NBJlPq1grEBpni9N9YScgcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z1NGxv4r; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb97e15bcbso78208966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740011999; x=1740616799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5bX5q6XO7RyF4eoxd1NJpEY9bnTw/y/W8pyoru60AG0=;
        b=Z1NGxv4rarlXSEpFPzaC6vMv8xCZO7iOpdUsSvy+pqcbNLUWPmKwG+wz0+GfqdORWo
         fW2tDTTo5pEq9R6zLrO3bRyYeqbbxoOm+c0rweOZd7P//LQM8D1OuIG+m28Nvanjly32
         OQEa2mDJKQff4lnsAz4OsCNr7rxoyPwpOUNhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740011999; x=1740616799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bX5q6XO7RyF4eoxd1NJpEY9bnTw/y/W8pyoru60AG0=;
        b=kCAMAfmkeS/9T8doCTTQKNT+6gC9VAbcF6E35Vejhl3M6NUUCbM+RCQuPh9axavSKH
         PCvBexzUHqSG05Hh7CpjPlc0RhCLRgKe0QJA8e6dx95CFm+EzW/DjLJZ35lRJpRx3Hrm
         Bwj3ceppYlW/EtEhhkDHqowIsDD+ji/gRDJXd71KtzqO8Gm8W8AI4Ety48HjZREzkq7o
         z4BmuLAJ4nKuy72acGTFEkdX0Cu4KJxXhaByeok85Sgddr1kwcaDPvj1tCqq+EZ7A/8G
         TiUkXTZVJdVEAwXSMnnTrsDeIidPLJnGhN9vsZu9oZGZ67y5HlpeoRiaGX4EyfyZ9sQj
         CqWg==
X-Forwarded-Encrypted: i=1; AJvYcCVRMCs0X8Fkrizg1LSK69cVNIsrz/ZTtGFUw8cuVjTyN5mGRVmX5uoVG6xSeJZi0/Y/HmFeGxQOvUGKNNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywBA6a2EzfCRdlQmtt0TwN9XDeuA5vTRYq0xw7iEBKpileB6p2
	jAhp8fy1yi1Wa+0ImzmH05bkCH/c9nEHZbbnMtE0Rymr0WY5SEMB5qfFH8YDB0j8go9qH5Gc3yf
	uCM8=
X-Gm-Gg: ASbGncuVjQcqlHLkFDCTQZsT7aig46/0apCXN0ZPUY4kFf/fLaqsdXvKiGgxEQtymXo
	GcmEFW7KYiA4KgbMk8y74VW7YDFE2qi3F9iTt8vhyO7sgn31NPooTKNneTCFpIJz3KJRi0xYOHT
	Sgi4zgz8uLty4EfFqgjtfxB98DDRWGldcbsSO5TASOTeyLk8+NUNG/QOgz7Lt4Pv6rjq8+Obieg
	b1sfJIEMYmZ87BJZofPuGU21OSFb3qGDupeil0I+6IwDN+B8OOq1gUhpi7kCw2AMaLi/bAmFr/o
	ya+b8nAw8vUrPxZJZ1VhZVQuU1grs1YXoxAt/o11eID4Q3TFZpyEaKGa/HkjsvQ/YQ==
X-Google-Smtp-Source: AGHT+IHZ8PWXtlLSoxwbgc/fkH4R2fVMTUOIHHv9Jfg+OmSZGxk9kGe+sPFwznUIkyM4f5yXkWvkIw==
X-Received: by 2002:a17:907:6d0c:b0:aa6:a572:49fd with SMTP id a640c23a62f3a-abbcd0d3d07mr546218766b.54.1740011999354;
        Wed, 19 Feb 2025 16:39:59 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb961594absm733588966b.111.2025.02.19.16.39.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 16:39:58 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ded69e6134so550491a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:39:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLacDUWkL6cbm/fAscvokVzmbR00Q0RksSk3QsGIQFAvrx3gFM1xkVL1shrRXMlalKqsdTMaOJF/OYg4g=@vger.kernel.org
X-Received: by 2002:a17:907:7744:b0:ab7:c43f:8382 with SMTP id
 a640c23a62f3a-abbccf1013cmr573598466b.31.1740011997709; Wed, 19 Feb 2025
 16:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <20250218085407.61126-1-michael@stapelberg.de> <39FC2866-DFF3-43C9-9D40-E8FF30A218BD@juniper.net>
 <a3owf3zywbnntq4h4eytraeb6x7f77lpajszzmsy5d7zumg3tk@utzxmomx6iri> <202502191134.CC80931AC9@keescook>
In-Reply-To: <202502191134.CC80931AC9@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Feb 2025 16:39:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgiwRrrcJ_Nc95jL616z=Xqg4TWYXRWZ1t_GTLnvTWc7w@mail.gmail.com>
X-Gm-Features: AWEUYZlyX3Ars0jVy2kh6EWta3z2VTRB7NefiwUH34z96MyiOgY5ii4BnshdGmo
Message-ID: <CAHk-=wgiwRrrcJ_Nc95jL616z=Xqg4TWYXRWZ1t_GTLnvTWc7w@mail.gmail.com>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
To: Kees Cook <kees@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Michael Stapelberg <michael@stapelberg.ch>, Brian Mak <makb@juniper.net>, 
	Christian Brauner <brauner@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Oleg Nesterov <oleg@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 11:52, Kees Cook <kees@kernel.org> wrote:
>
> Yeah, I think we need to make this a tunable. Updating the kernel breaks
> elftools, which isn't some weird custom corner case. :P

I wonder if we could also make the default be "no sorting" if the
vma's are all fairly small...

IOW, only trigger the new behavior when nity actually *matters*.

We already have the code to count how big the core dump is, it's that

                cprm->vma_data_size += m->dump_size;

in dump_vma_snapshot() thing, so I think this could all basically be a
one-liner that does the sort() call only if that vma_data_size is
larger than the core-dump limit, or something like that?

That way, the normal case could basically work for everybody, and the
system tunable would be only for people who want to force a certain
situation.

Something trivial like this (ENTIRELY UNTESTED) patch, perhaps:

  --- a/fs/coredump.c
  +++ b/fs/coredump.c
  @@ -1256,6 +1256,10 @@ static bool dump_vma_snapshot(struct
coredump_params *cprm)
                  cprm->vma_data_size += m->dump_size;
          }

  +       /* Only sort the vmas by size if they don't all fit in the
core dump */
  +       if (cprm->vma_data_size < cprm->limit)
  +               return true;
  +
          sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
                  cmp_vma_size, NULL);

Hmm?

             Linus

