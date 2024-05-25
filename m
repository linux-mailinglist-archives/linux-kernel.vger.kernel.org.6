Return-Path: <linux-kernel+bounces-189232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7728CED6C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 03:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EEC21C20B18
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 01:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFBB138C;
	Sat, 25 May 2024 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YeOuKaph"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398847E1
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 01:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716600735; cv=none; b=Xg9geqfwxHxtvxKMtSEuK330EuUU9qCFW7Y8eyfhoE350n25mPaFZe7XygZO79GH1IR5BBvfELALMtR05df8du+ixPRpLRjuuMVQCpEV5VC8b7MgjmG75MLR8gK9uQmRBiBsnz0ycfo+/sINctgJ3X+d9b4CdYJwwr2RHXxwshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716600735; c=relaxed/simple;
	bh=AmRb1euoDS4vvG+sR3/5zbY42oCpsiLFEgxly6UEdkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwTnDKr1ysAGKR0Mxh9o/uDNEN+y+WLvtxsuyu/KCEJUDe7FtjKixT0wyPdBEa1Wk45o+i+HDUGs9uit66weVxq+Hv1+Ut/ZgnUSWFu6mVyKo2fEH5d9mG4M+JhRDjbGXSoaR7A/hagujGB39bLjAJKR7jrtY7ppwHB5RJbTIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YeOuKaph; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57822392a0dso6382940a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716600731; x=1717205531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lAjYvK5/+oIgbwyHngh2RKpRp6/A9MjgsXDVBo21WwI=;
        b=YeOuKaphNNFMJH7iD7fULvq30JjIpg1MzZA3LwdMOomtdyjWzUTNRZVMWUfpgQeP6y
         ALC6FR9rLXNO7qXErpsKHMWPcoX40qx2SbMre9XJdAGISpUnJ6DniP/R1l5FhMvwQqBa
         qTIvxXsSni+tDY8uoyTZVZNLbXSc9Yt18jqeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716600731; x=1717205531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAjYvK5/+oIgbwyHngh2RKpRp6/A9MjgsXDVBo21WwI=;
        b=mJrgddZIJHziYTW4UnIR2udCpuXAQErj1pWW6uFFK0o1O5zjdQeUmeiZoUKi3nZhPJ
         ozVhCqkNXpnAI+Y3zSOM+Evm9YeIxvzxsmANPk4UqmR3ycE3W+feYPJrJYgv2S85eeH2
         FhxhPNyQ4i1EOFXwILlWp7t1UF7nVFj+1XZJMhLt/zYTcr/1TFs+7fdyoiQJ5Tkg996g
         tgMlhJpPlI3oQTH+cPGSJrW0hrx9u5dJ8AMIqrrESxGz/UMk4hpW6mBIk8imAiYHUdNV
         XYlN3jIcGClHE33gQvR1zVYTu2BgT3DT6RE43j6IkYJ8i8fRgYzKSeyHyGdNv+nWE1jU
         mpcA==
X-Forwarded-Encrypted: i=1; AJvYcCVPAqu2EDVd8dTWZz0+PBiita1fTf7t/mU+K4nTLKuKsb8c+ilRqOnAD+kxOKcNfwss34lyAZV64JQFgi/ZwdiMZ24t4W3f7107i/7Z
X-Gm-Message-State: AOJu0Yzva3pPcdELvSX/JUXFuzhMbps1/GvSUQ/JVZphhb11Bty4bFM/
	PAiQaRmQnfwyDmFGPSGKq7eC2NEkQh8kli68vTqW5exW0ffolPW0WfQooy620HqCH3DGYyg09HP
	WU4yxbQ==
X-Google-Smtp-Source: AGHT+IHZOrbDnjq6RJ/7rq30ANI/Gss1pU6k97Pd4DuzG/ZaAQupVeHrwSLP6YvmhScUzqLnpIA8yg==
X-Received: by 2002:a50:951e:0:b0:578:c161:525d with SMTP id 4fb4d7f45d1cf-578c161554dmr102333a12.25.1716600731346;
        Fri, 24 May 2024 18:32:11 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57860a2eab3sm1427494a12.28.2024.05.24.18.32.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 18:32:10 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a61b70394c0so726293566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:32:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmmJmVKs811vdvuDxdkZcUTWdz5npou1fhR8JZIQiR5YlgFPkme3dtwlQFrBNFPdLKpjQcs+kd2rsPHNKWh4WJiw93SiLwh0ZkbE10
X-Received: by 2002:a17:906:55ce:b0:a59:c3dd:db2a with SMTP id
 a640c23a62f3a-a62641aaf08mr236390966b.11.1716600729273; Fri, 24 May 2024
 18:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org>
In-Reply-To: <20240521192614.3937942-1-acme@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 May 2024 18:31:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
Message-ID: <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 May 2024 at 12:26, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> perf tools fixes and improvements for v6.10:

This actually broke 'perf' completely for me on arm64.

With a 6.9 version of 'perf', I can do this:

    perf record -e cycles:pp make -j199

and it all works fine.

With the current -git version, when I do the same, I instead get

  Error:
  cycles:pp: PMU Hardware doesn't support
sampling/overflow-interrupts. Try 'perf stat'

and after trying desperately to chase down what went wrong on the
kernel side, I finally figured out that it wasn't a kernel change at
all, it was the tooling that had changed.

I did a 'git bisect', and it says

  617824a7f0f73e4de325cf8add58e55b28c12493 is the first bad commit
  commit 617824a7f0f73e4de325cf8add58e55b28c12493
  Author: Ian Rogers <irogers@google.com>
  Date:   Mon Apr 15 23:15:25 2024 -0700

      perf parse-events: Prefer sysfs/JSON hardware events over legacy

and very clearly this does *NOT* work at all for me.

I didn't notice until now, simply because I had been busy with the
merge window, so I hadn't been doing any profiles, but the merge
window is calming down and the end is nigh, and I just wasted more
time than I care to admit trying to figure out what went wrong in the
kernel.

And no, I don't speak JSON, and I have *no* idea what the legacy
events are. Plus I'm not very familiar with the arm64 profiling etc
anyway, so I'm just a clueless user here.

I *can* confirm that just reverting that commit makes that trivial
"perf record" work for me. So the bisect was good, and it reverts
cleanly, but I don't know _why_ my arm64 setup hates it so much.

             Linus

