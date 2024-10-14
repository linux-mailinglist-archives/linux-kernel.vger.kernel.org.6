Return-Path: <linux-kernel+bounces-364863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B5699DA50
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B2E2834CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE701DAC95;
	Mon, 14 Oct 2024 23:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dX7f7NO1"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405FF1D967E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949761; cv=none; b=t93akZftguWjEID24rOEdVjaXohBXly7YOHaHqgoO89m10uSHFAshjiY5lBgWksONr/hUoy6Z9Ucr1rza8pzsuf69JH2LfB3bLOGJqS5xhV2w/pwcInBqVnxhQZDBWj68cnDnhNYcA66Iwj28oCQ2NOMJeO/XNTQwtOIlabQ+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949761; c=relaxed/simple;
	bh=1SZ+jfinI7KnF20uWq+5MiVKe7evA6ps9MC+h5JnAKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W93CMM1uTPNTeNY1SPBxc7wcnIls76/W9DY+/8HT8J/iVyMg+qIMXs2rAa/1IKebsbSwa/d52vkCUv9BzzzioM33+3viPraPlcqcOfcpWRxtSOiDBR1z608DH8t7B9cC+HMkG2wpgvSHRDDoIUYJGoBK3Exsnfhp3jr7dj3efXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dX7f7NO1; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso4954157a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728949758; x=1729554558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SZ+jfinI7KnF20uWq+5MiVKe7evA6ps9MC+h5JnAKA=;
        b=dX7f7NO1Mv8agbTmOg10Si5j6tNuhghs7mSwDwB5FadTWbJ5BYDtICgK+6jECJmnV+
         SKkRJcigybR/9ycSl5l7NIiyMXYLfs1v2w789HggCm6SdpCI6Co/LUv2j+3jZS5rbLOZ
         QjozxohQYL9Lm+taBXd+RJN6fDerirUOwWq8I6ZM1rg4Hl/fi86M2id4wBkKNVMRZpcM
         vNKDErA5cRgEs0DclZcmk1QFBZMlJaGaVjBRflywDqjlbYIXJG5SljDoaWmUNy/EY08s
         uPzHZ1FArrGgVm14CHkfVzZwgCzE80mv50NBCLG1o755JXCZENgXuICLLlEkopXMU2E7
         C8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728949758; x=1729554558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SZ+jfinI7KnF20uWq+5MiVKe7evA6ps9MC+h5JnAKA=;
        b=C1rXhudJNie1/XTm6RxJzo6xQQlS6D8gZvfYitdFYDW0D/4N/RxmcOYJj1KTbF5rXt
         nvHYCJnFNFX3k4di8SDIA/ySq7FnpzXkevvmx0kvUzRoFtr3Xyl2wnxT/1p9SnfH6JI8
         Rr4NKxpTlBLyEJV5EMIHSFSi5V0twyTk16aZ9j1dqiRHngiJxJjhlPewqkG7k304stWJ
         Lkw8UQa7QGbRjYIgQxdEsfRqIc+l1wkD9tym/TNDyC6wmXJqoGDgHqTbfz3EjX2+9mIs
         Kiu5TwbFAa4MmVcV6LBR4pYPLc/HDPXloTyau2lcHCtqBJo1HORu0QkJFhuD5PX0YWzD
         MOIw==
X-Forwarded-Encrypted: i=1; AJvYcCVucROGBm1vGdJLr8UVUtXAy4cSLj70V4OI4/D27J8S7Y2ora2bkDvJH/9fEeETFtlGc8V1YTc7w1rWUZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeJJAD5TOKTWassvVurhyXe/0bEgW9wXqbkyuYUzLyjmRmCgE4
	awlWKJz1cvXMJXbg02V3cEBZwUlMfdB7idvVeni/rme4zgOIZ5xLgab1EzfM1FLstE5avYwW3Zn
	xZ3tFWgzgPLDSKhAlEUGG1fCW0UXKmnRbDTzg
X-Google-Smtp-Source: AGHT+IF3LTkRo2bNnzsq5dT0NEdsT3wmUih6L0PdgKsa4EEm9X0C1vz+srf2kxl0ec7RLeunLrfhzidYV/TpVSBkxmQ=
X-Received: by 2002:a17:907:e6cc:b0:a86:94e2:2a47 with SMTP id
 a640c23a62f3a-a99e3b5a86dmr831600866b.15.1728949758341; Mon, 14 Oct 2024
 16:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com> <20241014203646.1952505-6-surenb@google.com>
In-Reply-To: <20241014203646.1952505-6-surenb@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 14 Oct 2024 16:48:41 -0700
Message-ID: <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	dennis@kernel.org, jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 1:37=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to store allocation tag
> references directly in the page flags. This eliminates memory
> overhead caused by page_ext and results in better performance
> for page allocations.
> If the number of available page flag bits is insufficient to
> address all kernel allocations, profiling falls back to using
> page extensions with an appropriate warning to disable this
> config.
> If dynamically loaded modules add enough tags that they can't
> be addressed anymore with available page flag bits, memory
> profiling gets disabled and a warning is issued.

Just curious, why do we need a config option? If there are enough bits
in page flags, why not use them automatically or fallback to page_ext
otherwise?

Is the reason that dynamically loadable modules, where the user may
know in advance that the page flags won't be enough with the modules
loaded?

