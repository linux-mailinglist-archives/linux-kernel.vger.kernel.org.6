Return-Path: <linux-kernel+bounces-254388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 763799332A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D542825B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCF519DF73;
	Tue, 16 Jul 2024 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="blbU6zTD"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2BE57323
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160662; cv=none; b=JM3CRRT5d8Hn5VV6byBpW2oM6K7lXFg7+rPoLg95TQbmNp/yIqzr/lUyMMnIGbrIJry7lBe+8mN57Rdul0HX47IwBUndaEArlptzi66HbvrHNngkiX0jh10ipiThyfSY0hIALc2m+auk9a9CXV1ECOheEsyP1fd0JKscnZHW/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160662; c=relaxed/simple;
	bh=iHoY9SdgXa2H902UXN8QSIofdiqecIAMFIbY2rjeVm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFdBYJU4s7pskyOOLYl/tny0NUVq4fZtXNdeHTCNcnhCDxhRiUXQ8lofZDV4p9acr75p1okBe6SF+tvbYLj1PkmHzZGjcLlcLyJHJ2QRCNo/EVGvf5xjNitfK8hnN02KDzKaDaZ3Ns5y9w1fR/lQ6AyYuofjUBnx0GN8/YcUFn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=blbU6zTD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77c349bb81so614960666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721160658; x=1721765458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fNp2iJWQXKj3S868U9jP4aHZyjqPZWxX3+VhcHPXu1I=;
        b=blbU6zTDHT50sU1ctlGKYZIg26dCyyULy5SsnLBSMnNJ37zhS4kgHKmi/wbM71n4RK
         TuOqx0LEV54Q8Q6UuYCn2U3XHj1ofldDJ3go8uISymSNA7p19w0qc7rBy+9rBIvjXFg4
         5Ex9T5GQltMFclrz6mcL5he65xwSd4a2jK0Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721160658; x=1721765458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNp2iJWQXKj3S868U9jP4aHZyjqPZWxX3+VhcHPXu1I=;
        b=RylzkHxxgScoBGFeuS7DwE9shHu4wdtg8zuIeO+Q8rOFZZ7kQIiEb/RMi3b45Z55Bx
         AFK6Z1CNJoy7Mm422z6u3M2hrHfE1c+MXVipLwZI/iy+uEoZrMgJ8ypDJekvLH2lJC3Y
         Ziaa7r5lZB47M5TqKpwrs0ULpDE9VF1wxlJ9lEcBG4MEHrXKw+1G+zbV5gWG6qM+1mD5
         6kgDYpDNRb1OUU5W4Z9exKu6fVICYGyHyfQXYf+GMiB6ECfcEpAtLwTDZzemCDO5Lfe4
         iPbcbv5RDpXXrveXmTdH1bPNq7YeCoM+HLAkvBdu+iVFbXWGYsOU1ldLUOe6qmgj38Nn
         E/BQ==
X-Gm-Message-State: AOJu0YwYykGm8jm8UZe5jGCqbnilKUukPaPUTtTubIbpHNEAD16K3Z85
	0dSO16nbQlY6behBtyOThiWwCHCt0i8boK9f49e+4NMnINzMsXzjtD3r0r8ziNnbKnUVx7YZ19H
	xElk8HQ==
X-Google-Smtp-Source: AGHT+IEjdhliyUTUtB/DhwxyeG5hrfmqjVIBExJnfIUEUQN031FPHUlnAiVb9JqstF99NHLBpmh7gg==
X-Received: by 2002:a17:906:585a:b0:a75:3d6f:e4ea with SMTP id a640c23a62f3a-a79ea43b19cmr210785966b.27.1721160658238;
        Tue, 16 Jul 2024 13:10:58 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1d9dsm355756766b.111.2024.07.16.13.10.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 13:10:57 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso725649866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:10:57 -0700 (PDT)
X-Received: by 2002:a17:906:2cc7:b0:a77:e0ed:8c4 with SMTP id
 a640c23a62f3a-a79ea3ebe2amr196311866b.7.1721160657187; Tue, 16 Jul 2024
 13:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407150921.BD2B798C6A@keescook>
In-Reply-To: <202407150921.BD2B798C6A@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 13:10:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com>
Message-ID: <CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.11-rc1
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, 
	"H.J. Lu" <hjl.tools@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 09:21, Kees Cook <kees@kernel.org> wrote:
>
>  fs/exec.c                                   |  49 ++++++++--
>  fs/exec_test.c                              | 141 ++++++++++++++++++++++++++++

I've pulled this, but *PLEASE* don't do this.

This screws up my workflow of just using tab-completion for filenames.
As a result, I absolutely abhor anybody who uses the same base-name
for different things.

No, this is not the first time it happens, and it won't be the last.
And we had that same horrific pattern for fs/binfmt_elf_test.c from
before, and I didn't notice because it's not a core file to me, and I
seldom actually edit it.

I would suggest that people use the patterns from lib/, which is
admittedly a bit schizophrenic in that you can either use
"lib/kunit/*.c" (probably preferred) or "lib/test_xyz.c".

(Other subsystems use a "tests" subdirectory, so we do have a lot of
different ways to deal with this).

Any of those models will keep the unit testing parts clearly separate,
and not mess up basic command line workflows.

But do *not* use this "*_test.c" naming model. It's the worst of all
possible worlds.

Please?

               Linus

