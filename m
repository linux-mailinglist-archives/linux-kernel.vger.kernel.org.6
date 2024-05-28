Return-Path: <linux-kernel+bounces-192991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 800F18D2553
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06FC1C2628A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E0417838A;
	Tue, 28 May 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cruORaZp"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B35551012
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926433; cv=none; b=KZCb1UGn66zlv4qWZA8Ex7iM1bJmNTalGlsMU9JI1z31EyJlJGrp/eVOTNrXsPUAdSZowaBekMqLp6LoLQyP8db7uMywcppbtNOxiU9hugFpzu55ngxX94YbzV2qHvf3g9zydrRbfxb5iB/dmmucz1qv53ru5DceeYMECUU5a8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926433; c=relaxed/simple;
	bh=8YWp68qxwuKrMQMapx0pKX2xFIRrKqbrwhPkeTh8yQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enREGNtX851CMDfP7jDxe1w0Okz1OesMcWpgF+Hi6NUNOhbRJMTT1HzxCAqQHoXYTfr59aD16UAzXKkmZDLp0Zm9MK8JitxnCsg8h2JEKi5luNlNd3qjvFmS1+MZt7C67zCqtYIGHPlyVyOM9Z/8kj8btuWWsZAQDeDfvhjCExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cruORaZp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a626776cc50so142334166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716926430; x=1717531230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dEtRoS1f3BiXfOOkD6/RyfWg8b94KE276J+eEUHXYvQ=;
        b=cruORaZp1fEO6fHUqPBS/o+IA89Ds76muFezCuPcc1yD32X4wURefx7j2UslKpxIuM
         E8ZHy+eRdPb8qiPDndDVgKbBWxU/8v9yeN3ti2vUqk8XX/B3r3cyDYKePjo4m0/iGSDm
         9Nn6NncLu2zlDqy6RohIo84rh/TEiD0FCvBzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716926430; x=1717531230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEtRoS1f3BiXfOOkD6/RyfWg8b94KE276J+eEUHXYvQ=;
        b=tXDs/hRszqemS73BbXRdK/Wn7nYibWQt1g+mqXsxWCyji4ZjQolF4kFptV0q8+nlle
         eqbQxhwpx1zRxNMJh/eI6/SwigN1QGUSmVIqg2N6U04tLGm9o81k5SxPBagCALOWJtr5
         qNm4DZXuqnVs/YhgtWqUbmk6PBZ/qEFTpE0CSnHc0N+FdfXZl0FMENbVmA5LSEAOISIc
         R9FG+i+7QPObtuG8karQD9aL7uDC5EkdEQe1wLheEeQIKyCVeD1e6PSqw000CMJr9PZl
         AlI035dZVN4yic/KEtHC+P3kVWS9V3yr+HZCstIclN15lwF5rPiOMWFYKEzX9pzJKn24
         hBXA==
X-Forwarded-Encrypted: i=1; AJvYcCVP8BbVJpHD9KRjaxk+4knvBnp43Za9mTpXqYCaMig8iuKgr9Z32biYCT7iE+UhHku53ZcG3DDiwr82klMs5mHZhstqlh4LUlyqHota
X-Gm-Message-State: AOJu0Yzojba80RvuS3eFkx3tGHz0sNwL/7ylsZNE118RF0rP2oh2l0hd
	byZzBCNo3VUS9B0rgPQCnuamCF/DyymHN8lkJHZpAImCPBY0xGB+FJXDA+oi3l3YA0EcX3xFFks
	SB5GfnA==
X-Google-Smtp-Source: AGHT+IG2h0bWo70+yLps81BXFCT3dUeWnme6S9w7/5h1y4ejw1FuNLWJLvGlp+lQeuNX21US7xWjAA==
X-Received: by 2002:a17:907:7743:b0:a59:aff8:c713 with SMTP id a640c23a62f3a-a62641a69a5mr790388766b.10.1716926429788;
        Tue, 28 May 2024 13:00:29 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc523d1sm640917666b.134.2024.05.28.13.00.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 13:00:29 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5785c1e7448so1285759a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:00:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnAC+O9qmY4S1UalwZaKaT21ErCy+bqFFvtDJ1lkSWMVwS4HF6yrHcq/Z+RJNXY7KdU5/UvuqnZJSd1vulYro4VGox/Y54Q66vbYQ9
X-Received: by 2002:a17:906:c088:b0:a59:db0f:6bd7 with SMTP id
 a640c23a62f3a-a6265116365mr793210666b.71.1716926428911; Tue, 28 May 2024
 13:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <ZlY0F_lmB37g10OK@x1>
In-Reply-To: <ZlY0F_lmB37g10OK@x1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 May 2024 13:00:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3TciVzg7To1KVueCmwJoDEZZSurGPb+a7Dn7Dij=4YQ@mail.gmail.com>
Message-ID: <CAHk-=wg3TciVzg7To1KVueCmwJoDEZZSurGPb+a7Dn7Dij=4YQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 12:44, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> For 'perf record' we're asking for sampling, if the event has the name
> specified and can't be sampled, skip it, warn the user and even so
> only if verbose mode is asked, something like:

Yes. I think that's the right rule in general.

However, the more I have looked at this case, the more I am also
convinced that "cycles" as a name is special.

It's literally documented to be an alias for cpu-cycles, both in
examples and in "perf list" output, and that's what the usage is.

So even if you were to have some other PMU in the system that had a
"cycles" thing, if it's not a core event but some other cycles
("uncore", bus cycles, bicycles, whatever), it shouldn't be used even
if it could be used for profiling.

You'd have to use the full PMU name and actually list it out if you
want to use a non-core counter named "cycles".

And yes, we even have some documentation that says exactly that:

  "e.g usage::

        perf stat -a -e arm_dsu_0/cycles/"

So this isn't even anything new or ambiguous. This is just how things
*ARE*, and absolutely have to be.

                 Linus

