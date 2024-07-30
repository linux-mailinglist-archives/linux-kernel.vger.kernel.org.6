Return-Path: <linux-kernel+bounces-268339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592DD942361
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EDC285523
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F4719409C;
	Tue, 30 Jul 2024 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LUyH/i+4"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA168190468
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722381534; cv=none; b=AKiXKoP6cAjxd3yiZYXz9TmWaoCdwtZ9MtfpD4U7q1k0A3/qeIKJJqWEGPCJ3+Nr4aBzcDey0FhYPeG28Vlu6eR1ZIGWag1kzsLZZMiJbNwWcd/PDUx+wnLAj504QipnI+9ps6B1hS25o2FsBjadFK1v8FkKvsP9I+V2q0GW1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722381534; c=relaxed/simple;
	bh=L0PFJlPNg2nSFAwbo1MUufU0ZJpnKOJlq9Zz7UzENlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4vipWR8BDcLYHr/CBZo0kxOIE/ZkAJ5XsQMPWdXD2ceapmjDLZkRAiCtCpL6AT8YFr1dDVLBh4601y09h32TT26otd5hTX538kUiWA3FJZf3kM+TEgXeQ9jwH4vfg+HwOHwYc2NU3BMBukfiuBj/9Bh9j8txKDvNfb+wBdcPQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LUyH/i+4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so159108366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722381531; x=1722986331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w4KvUDxCv3JZzkJ14qFXFaCRicGT3v3Xu0J6Fixv6r8=;
        b=LUyH/i+4jDT5bE4URJyTFujqpAZxmWvwf/xO57JopMjanlblkfWQTssjMnjHklDkEp
         seDlFF3A/f+EpadRHhLdClF69n5TG/Inkr6x0JNLV5WwPytpKP9NtH5rv7NeJd9L/ROZ
         9h81OFdMh05qQpkjOJ8e4/jGCCebIZEsEDWtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722381531; x=1722986331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4KvUDxCv3JZzkJ14qFXFaCRicGT3v3Xu0J6Fixv6r8=;
        b=fySFoyoGf2MQctBrTCtL7GdfvtSvAI7OC11pqieWI96wGo9VE8lxhYBrUXNH/ObjgI
         L4r5zRvfJzBZe6i2E5a2Xl34UTGzC1Vv/APDkgggaxBNko8hgtlgWt9sLUG1aMBrlPDA
         9qAYMWe/wMRzykWhp0QxT0FgFAzopQwo42Myxehl4exyiG+d6CwteS8MXtpJuO+nGhcg
         /pT10YajP0Ze69kldCSRMp5CvuW58Y9rNTYRF2wo15ewriOseBhrdb95SRuqR3kZMTFH
         sVSEXZ2T9IsfKlA7T6yS3vYCCJqkiOH4U0bi/43LSjxShc9feeIYwG7x89JSBmTzk7xu
         xtXw==
X-Forwarded-Encrypted: i=1; AJvYcCUqwtRc4UJnSQdELxjjlk0G5DG7ujus36xi5YksC0y4HE4NScAccQHkr/4KS5Sq7+ImAO1HH19CmLmFAbwv6IBk/LApOwmH/64hFPA0
X-Gm-Message-State: AOJu0YzQpqeF9zk9ua5eOoKEziXYIyMde7tIpDQSXPTakByA53YHBn41
	xi93iu8Xbiy/E9+eRMGmfqNwmxjpeYPpsbIx9zi1FvgxgmISsQuSYZKXSw0eoRfDr7NinQjYysR
	m8+oTYA==
X-Google-Smtp-Source: AGHT+IFOkhNcpTU77l9qzCXXsJnIaQmP7S0MhcNpzRfDsq5IACjtIek4CTDXb4H8PwYj8q/wLMdhGw==
X-Received: by 2002:a17:906:6a2a:b0:a7a:8da1:eb00 with SMTP id a640c23a62f3a-a7d3ffc24ecmr1063745266b.7.1722381531010;
        Tue, 30 Jul 2024 16:18:51 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab5367fsm701500966b.82.2024.07.30.16.18.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 16:18:49 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so6996489a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:18:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEhASi/RNhaZJmQVVaRR68UNVWsdu9EPso62vDXNDg22sa9tb9pyMK8XWaCGxv32xIs7K8b338GkwDAFh8FjR330NeSTPDO1yamj01
X-Received: by 2002:a05:6402:430d:b0:5a3:3cfd:26f7 with SMTP id
 4fb4d7f45d1cf-5b022a95ad0mr9903249a12.32.1722381529467; Tue, 30 Jul 2024
 16:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730132528.1143520-1-adrian.ratiu@collabora.com> <CALmYWFumfPxoEE-jJEadnep=38edT7KZaY7KO9HLod=tdsOG=w@mail.gmail.com>
In-Reply-To: <CALmYWFumfPxoEE-jJEadnep=38edT7KZaY7KO9HLod=tdsOG=w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jul 2024 16:18:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAzuaVxhHUg2De3yWG5fgcZpCFKJptDXYdcgF-uRru4w@mail.gmail.com>
Message-ID: <CAHk-=wiAzuaVxhHUg2De3yWG5fgcZpCFKJptDXYdcgF-uRru4w@mail.gmail.com>
Subject: Re: [PATCH v4] proc: add config & param to block forcing mem writes
To: Jeff Xu <jeffxu@google.com>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel@collabora.com, gbiv@google.com, 
	inglorion@google.com, ajordanr@google.com, 
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 16:09, Jeff Xu <jeffxu@google.com> wrote:
>
> > +               task = get_proc_task(file_inode(file));
> > +               if (task) {
> > +                       ptrace_active = task->ptrace && task->mm == mm && task->parent == current;
>
> Do we need to call "read_lock(&tasklist_lock);" ?
> see comments in ptrace_check_attach() of  kernel/ptrace.c

Well, technically I guess the tasklist_lock should be taken.

Practically speaking, maybe just using READ_ONCE() for these fields
would really be sufficient.

Yes, it could "race" with the task exiting or just detaching, but the
logic would basically be "at one point we were tracing it", and since
this fundamentally a "one-point" situation (with the actual _accesses_
happening later anyway), logically that should be sufficient.

I mean - none of this is about "permissions" per se. We actually did
the proper *permission* check at open() time regardless of all this
code. This is more of a further tightening of the rules (ie it has
gone from "are we allowed to ptrace" to "are we actually actively
ptracing".

I suspect that the main difference between the two situations is
probably (a) one extra step required and (b) whatever extra system
call security things people might have which may disable an actual
ptrace() or whatever..

              Linus

