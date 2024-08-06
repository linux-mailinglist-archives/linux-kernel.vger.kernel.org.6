Return-Path: <linux-kernel+bounces-275667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E21C794882F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC96B22257
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2811BA88A;
	Tue,  6 Aug 2024 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fk+BkAmI"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08CC37147
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 04:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722917140; cv=none; b=jITWKm8ufxwb7OeAwsqnm4in1L9SIK3nlibUtRx7YoLER6OlPm8BW5ILh7dTuai3MSGAA3hyZe+nL85p6cheYcbXvHot658DQZtGqVSv05zGQBh1dpTZfjZMEc9+oWlfWoSThyczmkXSBtwImeU/gW++6JvMw9y6kOopCPhEqUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722917140; c=relaxed/simple;
	bh=ksgVEwS2g27EUf8mDdFHEkzlF4wPGczulQ17tbgdkZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ap5jUwpOErUHYqB22sAedPn5HazHjNvaJUtNzVrP1N9fsaBB4UyVCB+C1ZjW6zkW1uQlTLzojD5F1fU7ReRrgre8fYFV30lBmROwQDkSgHJFBKPBlpGyWipCUUfpspN1hKpYRpCc7hJz8O9TkP2/6s2v7aAyo7z+zVMe2wmtodo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fk+BkAmI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd7509397bso144575ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 21:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722917138; x=1723521938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksgVEwS2g27EUf8mDdFHEkzlF4wPGczulQ17tbgdkZ0=;
        b=fk+BkAmIM81iMoqcenMeoSA1x9HFTxk0sXMd7lUaXkC64r7+B0ruzt5eNaYwljIzoO
         nes7Jwg2aYO3OT6yrQAgTuq2Zs+9aKVqLcYOCYoCyVbuejz2JX7bwVs1DRFKhUHj1iZV
         mSwD7YEKddUFugJRyzr8N/7GmeGFjNQC8SA79vi7ZVasY0Ux59KxSm4gVLheeyFyWcAy
         CMmlFqr87erWW0ydI6p1s6HUT8IxsqeULHP6CAV3SsZKQP3W6i9M3uHVLMdwy8BKu8RS
         J/K0CP4A4Aume2B3PKyT/NBLaKnMyic91NiQoSxZKjWDbYFxoo5bp3E4LxQKm54udy9n
         fvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722917138; x=1723521938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksgVEwS2g27EUf8mDdFHEkzlF4wPGczulQ17tbgdkZ0=;
        b=v0+i+mqAdc0OZXbC8HYKxb8+jCharuT9DZm3oaOVgnqGRNRJiPbgYUKcAMHUseqNrt
         H0H4bX8TltE8KkNhjzGxHmg3dWBOQNda/gw5zOhlaDLyp3y+snxIRI6XXkgdaQoJhN1h
         HqurGzLCpvfomxg3mFvuHadNT+bBY8BrqqFRvywvbarA3YRHCqJfvPDJBuD0VsBNUNye
         HdvzBiRMi0b33OWm6TvBSzhojLYqxLvQV8meSIqAy5CRGldEEXLK75uaiSDBH/WpBXST
         9inqL+2iFNFCyuzhPqEQsLsiEu6L03m+4ZSLlKPcVapZ8TDm63crdEDLt5G9z2xbxpKA
         IZdA==
X-Forwarded-Encrypted: i=1; AJvYcCV2G5FuJAaG7Vjk2X76AkxmJLfcYezMpqhAV8pUCzS1363XwJluxkk3ixeq8TshVm84asYasYSOW+u809vuqYZzd0rIQnwrs+YTgTBa
X-Gm-Message-State: AOJu0YwgnR4lUnPkt0vSQ7IWcxfSuIxhnHJPbBJ3YuK84e9/6NlgeRga
	TbgfqyFhZtN50PNZ+hO6yG5Wl+wON1WnKKxbvVsfCjgioQGZ3/NEZPTjdG/W+JHB1YVgXbLAI5M
	9QHZeINPvvGiL0hJLhwWlUlin5VyETbL+BeFd
X-Google-Smtp-Source: AGHT+IEDrxvK9R3CWrSgJD6d2CzZl94gIXQbXiLVxjCNAOq9smV8d5JjmmD4IsrOF+xZ+lcRwE0maLH4oISqj8kMB0o=
X-Received: by 2002:a17:902:fc47:b0:1fb:19fb:a1f0 with SMTP id
 d9443c01a7336-2007666c84cmr1815415ad.4.1722917138011; Mon, 05 Aug 2024
 21:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805194424.597244-1-irogers@google.com> <20240805194424.597244-4-irogers@google.com>
 <CAPqJEFpiy307B4OBHK4WJGjgbVm_woUrdZ+Vy_LSdQ=ECqZX-Q@mail.gmail.com>
In-Reply-To: <CAPqJEFpiy307B4OBHK4WJGjgbVm_woUrdZ+Vy_LSdQ=ECqZX-Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 5 Aug 2024 21:05:26 -0700
Message-ID: <CAP-5=fWDmdAkJSoncedZTaSgFwG+p3--jywDj9krnXSfkhh6dQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] perf pmu-events: Remove duplicated riscv firmware event
To: Eric Lin <eric.lin@sifive.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, Charles Ci-Jyun Wu <dminus@andestech.com>, 
	Locus Wei-Han Chen <locus84@andestech.com>, Atish Patra <atishp@rivosinc.com>, 
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Guilherme Amadio <amadio@gentoo.org>, 
	Changbin Du <changbin.du@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, vincent.chen@sifive.com, 
	greentime.hu@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 8:54=E2=80=AFPM Eric Lin <eric.lin@sifive.com> wrote=
:
>
> Hi Ian,
>
> I've sent a patch to fix it and the patch already merged. Thanks.
> https://lore.kernel.org/all/20240719115018.27356-1-eric.lin@sifive.com/

Hi Eric/Arnaldo,

Right, I already commented this should have gone through the
perf-tools-next tree:
https://lore.kernel.org/all/CAP-5=3DfV3NXkKsCP1WH0_qLRNpL+WuP8S3h1=3DcHaUMH=
5MFkVHQg@mail.gmail.com/
Arnaldo, please take Eric's patch in preference to this one.

Thanks,
Ian

