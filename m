Return-Path: <linux-kernel+bounces-271491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4DF944EF9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73F8CB2233A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679F11A3BDA;
	Thu,  1 Aug 2024 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHwnqw2Y"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF79D1AB53C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525518; cv=none; b=n0ML/wiecQK3GnkCdkdg1Yy0rbvp7Gam1Oz0dOtCQRqNSEiISa0639PI3PZmJxILFiS0DDr256c+mFox7xpuDe0uMjYFyeFDiuZ7PfLwQto3tjQcYYnU+eeO1RG3A6hVPIJc25ySstWYJJWnPQ/PAFss3YlblTh5H7Kem2sRXBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525518; c=relaxed/simple;
	bh=RCCX9kUhm6dzrQwEgPKxLl80PE2ks8Eu3d5MKbtfBpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8cJHzSHNNKs2zR29dsQnfj3sqt9+x2mtUlmZ2IJ6Vd/SZx/G4+SmLZ+uJ7IzkkNA+nykcDLR4VB9X1mOOvDIVNbNFfATzenTpLUFv93O9RgJY5CuLHNWVlaoEZ/+ej1GZ7V4y3k1S2tBKd3yXfgIxfs5R4i8eycrLlEE2ntcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHwnqw2Y; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-398b599593eso354715ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722525516; x=1723130316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCCX9kUhm6dzrQwEgPKxLl80PE2ks8Eu3d5MKbtfBpI=;
        b=bHwnqw2YhQS5sYBfCzM72YIZPewNrLoCHvwSPTS+fAIYxVS+EzIeWKWvvvEx8kvo0F
         rKFQhdrNV9Z1QukL+qNYa4YY52hsYimKvDG1d7dFy+s3xuyQvyM6l/UHuZheub/NwXJF
         0fJoGABjvGC2KMxWmfei9L+DYQcQ0u21dA2Is2jG4GwQ3f0q9D3KTkfxm5Aoe/DSA8qx
         TgaPEr4qhiYyEIq5K6B9iy0dMXh7pU28Ma34GbhDDOT0B8DWRIhjv66AeHIyt3GQ9xF0
         hC/Gggn/Us/ADup3dFE+FNpp+Gk0CWSRFf5x3o5BVTvu7yYHY4VitedWUYR38GMBpAKc
         B/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525516; x=1723130316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCCX9kUhm6dzrQwEgPKxLl80PE2ks8Eu3d5MKbtfBpI=;
        b=NSDCcFgy/M7ibyB4vpDh2eNo2RHWebzhEXdoKSYpSs4IOliuDZ0m5YxwD5Uj5faBd9
         0Sm1iiVFD/0CK5/Fi6/ntOPM6E7Q7RFGpCVIDeiun4it7ewz7Kq5Ld55CWdr27jUsst9
         ZXt62aIefHQBuzt6N8wyO4G7BTfk9K9vSTafi4f5h4thiV9LwkgGkMIjjoipUU3YLfrN
         j2njPi4r/BFaf7XXhs0m7FNXAMt+Q8RCn6o8+wBFzGgk+uGVfbOCVHJm/pMRSliI11vo
         6yvxkxi1Kdfhig7NRSAYiSfm5oN62C1ckTaVJMjtvU/BUVp9+ebsjVFeIe/jNBPSvfzv
         lqgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAVQYD77NDQRXBzxC/2W7vLr8hkue1d/C3qPY5mfehfgME/icNO+nIhQ4KGIPWlqEu+EckBl59p5i7cH53GiuWQOd3whLvVsKV1hXv
X-Gm-Message-State: AOJu0YwvLKgAJVcPGG1j7/4km1PV35Pdqjd3nQBWZmCkjLWHt0dDVyhc
	Jfg2SKuJ7rsVFLzHOa0zcYgcn1FaT+PnYrk7UwxTYqQx+uEFygxyUtxj8vbIzdQcc/rBYIahpan
	uXPva77Gbk3jMeM9BT6xabNtMS227x6CX6LQewVaAnKp1NAVzj/YGgZw=
X-Google-Smtp-Source: AGHT+IE1fs3QT8ob7T6liF70Caa5CDDhEVM0uPcEcbFwxd4HmRZCUGYF6X8rWsD+GJSdPGI+9amZQ5UdcQic/tEEWOQ=
X-Received: by 2002:a05:6e02:138c:b0:375:aec4:eaa8 with SMTP id
 e9e14a558f8ab-39b199dbc02mr3030965ab.8.1722525515670; Thu, 01 Aug 2024
 08:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZqpUSKPxMwaQKORr@x1> <CAM9d7cgTrDEdAn=dv9ciRZfpMdYwdmDrAAvsYEYE=GssPS_aWw@mail.gmail.com>
 <ZqqHnlgG0YS4DRAt@x1>
In-Reply-To: <ZqqHnlgG0YS4DRAt@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Aug 2024 08:18:23 -0700
Message-ID: <CAP-5=fVH-YG65AmFz-N0uSXg2OcGJrmkw5tQtuEuFY=h_4K8_g@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf bpf: Move BPF disassembly routines to separate
 file to avoid clash with capstone bpf headers
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Song Liu <song@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:51=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Jul 31, 2024 at 10:07:50AM -0700, Namhyung Kim wrote:
> > On Wed, Jul 31, 2024 at 8:12=E2=80=AFAM Arnaldo Carvalho de Melo
[snip]
> > I think this can be gated by LIBBFD and LIBBPF config, but not sure
> > it can express the both requirements easily.
>
> It is possible, but as discussed with Ian in another message, the
> cheapest way to do it was, I think, like I did, in the end it is just a
> stub returning an error when those libraries are not linked with perf.
>
> When we manage to implement the disassembly of BPF using something other
> than libbfd we can spend more time in this area, I think.

Not following this, can you show an example perf command. There is a
BPF disassembler already in the kernel tree:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/kernel/bpf/disasm.c?h=3Dperf-tools-next
and in use in bpftool that we use in the perf build.

Thanks,
Ian

