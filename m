Return-Path: <linux-kernel+bounces-445555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267FF9F17A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E3C1888112
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CF518D649;
	Fri, 13 Dec 2024 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P87UrOQW"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E348D18B492
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123491; cv=none; b=d5tK+KOAxmJbYSY8qQkKfWVZwuDNBMQqFzOl8SgBnx2r8q3CQRhzvi1+kIHUf4B72jYeXxfrZoUSl743K1vpH7V2Mon3+ytkK2mM19OaOhCyG9PurLlweS1KEsGpOFFM54p+MMDGH/0Ngk5fLnx3rMn50Djpj7x45OrBaq6RJio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123491; c=relaxed/simple;
	bh=AMFyDa2waJbDtQEqF+pSjIPS4HLmTfo1/bF558eIdmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVcqoRYenDNQm5hYYQFjf1K102gsbkpO+3xuE2yGE2Kgx6H0BfftXcoCILdRYzk7iiQaYXDnhcJwnlcF7pYeHrXNRFqQZXs37RztHVKuNoXqZSDtHprMJdSE+zVqI+fMLgif2vipgUka4Ftv7q88mqL+ILRXsoMncLwNj6FR2yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P87UrOQW; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a814c54742so1705ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123488; x=1734728288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IPebKZoDc4cq9RTO8NfPXE4gbH6+uaL4YtlB4CSwj0=;
        b=P87UrOQWns11tHNT3QYfL2kce7eVQ8rOxD4r6O472KY10AK8sYRiq8zAVinhnOmDud
         q3Wmp/cBkbt1t6UdPEQvdO003+e6Qc26qBA9WTCAG6Wp9DlpNoAbvPbJHUeSi85iDCFr
         BxSgxN75zHuWtrv8XcE7MKTMlRpMNwAXLJZWXZJY7oxmWTZTeZ259KXhjXtS8x830pRt
         sWA8Z5VfWH9e4hhwLl+kcDbXqGE3CAtg3cTRlvMQx19+jJcawBeZctcjQdAlozTpVkOh
         r8f2oMLLNoJpS5zSt6Vf8ZNoI6hG3cwTsFK3IPaU2GkwGqNuBFbW2luBWzCnPyQHBueV
         LraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123488; x=1734728288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IPebKZoDc4cq9RTO8NfPXE4gbH6+uaL4YtlB4CSwj0=;
        b=kNR6lvdUhzBvsZ/JO2CxzZm7y1FFjUBdXopDcgM+fBVozkPufSV/9+F9mmuE4O/MKs
         W29IwT0+BJ1L+Y75S+ihp1NOT9kw4nTgjXpHTT1QZqEtjCSFvR7DZZyd9nSOQ5AgLMqC
         vkpSnpBFXjQ5LsDnDWw9ifFaNmdMimUDB/XMA9tkziBsXIps+pm7gyC0IWUAKBk8sn7+
         Q5of+UuxERJql6EIXQMEc7ugt59u3S3Pcx5Uj6KxaArywwICWC3bi+g2q7kXdN+wHmat
         1bScCXOh4oVZZft/asIsGb6jfkujI9m90a1E8Y/GDwtxH73mQieIZVfjjnMLIMXNpquE
         EYmg==
X-Forwarded-Encrypted: i=1; AJvYcCV/M4Ok2OsuwsG1AulQ/ihCPZfdAsmrO4z8o82vsYRwxsCCSIKddHpUdPd6refGYo1vudn3qnkZ7AqH34E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzMT8kxHeAutJGfWa0UnwnebGpuahcfnQBcnFfh3ZDDH4bk83s
	G6AY//qgK2Oad4fqghMvBWPWspiXSpBGdY2y/crEs5pPxhqrzeWA6lyqlWRr7ZbNkJWzfCOdDtW
	F6RhZBd7cFQmKEuRYGUJv7G+rUdkqoGEZJUmr
X-Gm-Gg: ASbGncturEp57XAPwmjNpBNIME5iSjMH1/JGiF30bBBft1rDjHCp+vydDIYPjgorLkq
	LdjKt8c5kORnfaHXUsu/RSoWm4VWPptafnCfAzDE=
X-Google-Smtp-Source: AGHT+IFSYEl59MfLtXFXH4y2N6tuuaJ6F99N8iq1eoc67wUQ5QCGC8GRoRh8B300l5jEa9E2FeJkBl8QXCNaiL7MWL8=
X-Received: by 2002:a92:606:0:b0:3a7:aa54:ce07 with SMTP id
 e9e14a558f8ab-3b273372381mr518825ab.22.1734123487953; Fri, 13 Dec 2024
 12:58:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128010325.946897-1-namhyung@kernel.org> <d40c6d0e-3755-4cfa-bb9e-e2aa520edb0f@linux.intel.com>
In-Reply-To: <d40c6d0e-3755-4cfa-bb9e-e2aa520edb0f@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Dec 2024 12:57:56 -0800
Message-ID: <CAP-5=fXAhYGmBpnCZ_YkePAD5hOpiKoXZ8agHWPi_wHyzjWyTg@mail.gmail.com>
Subject: Re: [PATCH v2] perf tools: Avoid unaligned pointer operations
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 6:59=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
> On 2024-11-27 8:03 p.m., Namhyung Kim wrote:
> > The sample data is 64-bit aligned basically but raw data starts with
> > 32-bit length field and data follows.  In perf_event__synthesize_sample
> > it treats the sample data as a 64-bit array.  And it needs some trick
> > to update the raw data properly.
> >
> > But it seems some compilers are not happy with this and the program die=
s
> > siliently.  I found the sample parsing test failed without any messages
> > on affected systems.
> >
> > Let's update the code to use a 32-bit pointer directly and make sure th=
e
> > result is 64-bit aligned again.  No functional changes intended.
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

nit: The commit message subject is somewhat generic. Perhaps "perf
synthetic-events: Avoid unaligned accesses for raw samples".

Thanks,
Ian

