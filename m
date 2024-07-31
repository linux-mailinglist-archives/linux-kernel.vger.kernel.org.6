Return-Path: <linux-kernel+bounces-269628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969CD943511
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFEF1F22C69
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C972BAFC;
	Wed, 31 Jul 2024 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3rctPcJ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA62E646
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722447337; cv=none; b=u49jdYU50rRNzDVo0/SMM269KPjTQDfwbc1TG6bmAarboVd3sVXBcn38e0JXU8BMPk703iuLrVMGBDCvWvEVHGhnfLsXaueS0HcUhpA54Xin9qtoe4Ot5e4PAXJX1+7OEH81nnfcLClpwB8XsU8WhjuWyPIzmAvk3YE//Iw4SW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722447337; c=relaxed/simple;
	bh=1Adio7d5YNSo8BdMKncTRyiP/Rne5Bb1BX0RdDp07bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTIDJ/EgXQhL+wJqy9Ibz6pXxrJ4SHqB2YEoPgwkyoRsOJ7qNCLrQuSS5fh7P1LaUYOMaaRHkWUsFimow49qjOA+GkNC8YCcGHkDlJDHalTv3vuTFFIyjBUy12TlMqOpJDSxlej2ZlPTFz2Y+1dBqLia+L/1PSk7lxTaxGOchiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3rctPcJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc4aff530dso265365ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722447335; x=1723052135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Adio7d5YNSo8BdMKncTRyiP/Rne5Bb1BX0RdDp07bE=;
        b=L3rctPcJvebNOsP2rnicOjTHNtjSVSKVzYO4GUMUI2ipPFaFeIIrUPY3VP+3t/PfZQ
         smqlgJi6jiKhEmqPiQq1fHeKvey3kJObTknaYU9DPmcFWHnOK/HYe0lrCkJbZklph1HG
         itF6VsuzA2LMRCuvLru7ZgfW31THDe4ZZuzRs8UCyrwoU5Z/EjWF8VsCbh/Py1JFpGVl
         vcE4Meuy+Rm+sypHkxiYsOGU5GDM+pOGHp4Wwzhg969oWkelSoiN0JdiQguj+VRwtLh5
         giYwrhzX25vKZEHYKWzbD7G4bF6F+nNMEevxhfGSvsPu/aiOiJ8gbY4FqiLe9evHmdj5
         xQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722447335; x=1723052135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Adio7d5YNSo8BdMKncTRyiP/Rne5Bb1BX0RdDp07bE=;
        b=t+0V9OEDr/JiWKSpEdJYsG+CRwDW4VcTsbg8cDOpfpVxyG1WEBjKBqD+hTzroC9Sfr
         qDFA95putxmvFkRBG5Yfdj3bUDZvSABbPFO8BLTy8dfcPOFTbbJ8sWeVVgF9iFdiAv2q
         vZyWlXips8gIR3mVG9g1i7zAhASE4lsQQNHnWxeSPAwhh2YcPqPl+PW1Kz/c3AkGDobN
         5vefrIBumSUDi/YNHuHAtebqOPsrRE4g2HfSlr7w8116WXSG5TMkNKGqjolyyy+HRi2+
         ZNeAkfLEpMF2udvm/+baXl/nSkiF2w6v4vqmDA16kcV6xzdswjjGNwyrA3g9qpjUTnC8
         S8fA==
X-Forwarded-Encrypted: i=1; AJvYcCVMWwuLBbiq/tHnPhXgnrZxCLg/VBuKvP+fQyRaaPf1fATXPtHFO3eVN0QF9DyxqTJzGPs6Q7FwRWtrxwQSomSon08azyF4fAKHOSYF
X-Gm-Message-State: AOJu0YwDu+DUGDGmIxO6ffcf/1+M01zgRVSIcUX0Upv9bCIkoJfxj+20
	QOKMzuiuUnFoVfOCq+D28BHrmZV5VbT31MuyzJiqvZnMSw/3UgUuO0Fni8kWnlZJqslH9SvCPcs
	5fdzcuZKb06rUumS6iO7cneKs7cQUxuFR0d1m
X-Google-Smtp-Source: AGHT+IHNitekAJ5MMyaYnF+S2tfRTPUWTapFnl0EhNMc/agVj9zLyzKYcbU7AmjArLiWAP69FyKpxjRK1bsaoD9GK8I=
X-Received: by 2002:a17:903:110f:b0:1fd:d0c0:1a69 with SMTP id
 d9443c01a7336-1ff4263d6femr3384785ad.9.1722447334607; Wed, 31 Jul 2024
 10:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZqpUSKPxMwaQKORr@x1> <CAM9d7cgTrDEdAn=dv9ciRZfpMdYwdmDrAAvsYEYE=GssPS_aWw@mail.gmail.com>
In-Reply-To: <CAM9d7cgTrDEdAn=dv9ciRZfpMdYwdmDrAAvsYEYE=GssPS_aWw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jul 2024 10:35:12 -0700
Message-ID: <CAP-5=fXX5RUgoXR2v4YPYQWJi=A1LejJ-MfhKqe+es+SR3WyyQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf bpf: Move BPF disassembly routines to separate
 file to avoid clash with capstone bpf headers
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Cc: Song Liu <song@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 10:08=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Jul 31, 2024 at 8:12=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
[snip]
> > +perf-util-y +=3D disasm_bpf.o
>
> I think this can be gated by LIBBFD and LIBBPF config, but not sure
> it can express the both requirements easily.

Should we gate things on libbfd? Given we can't distribute a binary
linked against it, I support deleting all libbfd support. Fixes like
this show the pain in carrying it.

Thanks,
Ian

