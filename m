Return-Path: <linux-kernel+bounces-285674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E8495111F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336AE1F2352A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD5A79D2;
	Wed, 14 Aug 2024 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EdBHLzAa"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6544A02
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723596219; cv=none; b=DhHank2Gm3mCaUUq+DEDHClrbujxfvYcUGwK0F4znWTPz8VM+0l0yZx3ZXhrDyh3wwIyh+c9NS4vhO4Y04EJhECQnOdN1c+VfeNQIx6xmfMRYmtNrUvWGuYZBSdb4JRpP9C2yvRZlnXzOeExMdg2NVFR4FwermEab9KR31UcF3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723596219; c=relaxed/simple;
	bh=HUc/+dKdoclQJ30l+pQG0Jo6TjouBGA6yWoH3XnWHOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GB0XwABK9Vs0UaFRaDSecp/2c9jBaaiobP0DgblqAMXUX2JK9b+fpby6TUktQt1ksa0dWXccmmb+SQaGl6qzKsHcSrzM56ftjmnw8wcFEP1PZloZEjQ3NsBRc0qlIaBeEA0kHEJ8YA8o7BKFjBID4Ziptm+YyAYztDLZMlSMWZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EdBHLzAa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd7509397bso38355ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723596218; x=1724201018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUc/+dKdoclQJ30l+pQG0Jo6TjouBGA6yWoH3XnWHOQ=;
        b=EdBHLzAaj0gxLpqw/B5dng9VJ3ceAAjHiIEcLZlUZdIOE9uOfO9KU4vzHwSygOan+I
         97ws07vbSGaIRDUAXXzQzw3dtAYo2ABGL7q1io+oZpAPBifBZzCM5auQVas02RYMtcJ/
         NW0yA5aKj5yflQClXbcRdjjy9SHSIrbAOLPcuwEe1V77U6I9HYCBS8o6VPBXSqYqC3vi
         hnTSBGiLTHz7mJ5bF3BMnxQN3D619GsPjII4kWAC13pk7fORUZeoWw5RPapG4M5JP5h1
         ErABZQF45DE2IOYXvgABbRD4NBWFwI2qMCztjpsmpCY6PDERUrV+80Wx50KsifB8laYq
         lNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723596218; x=1724201018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUc/+dKdoclQJ30l+pQG0Jo6TjouBGA6yWoH3XnWHOQ=;
        b=lPvci3BmaINPFhah6a9OrPT11q94h4d79k4d6zONN2+5pAmKDYg8fWMDkaj7titUdi
         ZBY1F5iIQVSPzhKtWMcNGnShH+TvjqYH3Ebk3tfIx9JWHaLfrQUQQBycT1jEDJgW9d33
         ul8ZquYSVbXQV+3U2N5sZsYEWvgqCKe8sR4rV5FHiUbiJz5/cGPJXzUFZjHNlUVhBzcP
         3nfz4eqzA6hHThtpVFuJDwGr4gDBTGcMWKwslWrKjsxQJx0M4/mYkCyGtEfePMQ4nBW7
         IL8Tmd3xmQPe42eUoE8Hj6lhuWg5A0almULs7mTX43Du0aDq0dD/WJtGJD+Q+lEKENZ0
         y6Rw==
X-Forwarded-Encrypted: i=1; AJvYcCX/IBnsdWby+lYenvayVKFSEX7LBI64/2yWEcx6qMcHsOqmL9TbVGJAj/MSn7WmFy2zZEbkFyZo7fkNXlN9M4YJm7wEIW3AYrMRBVZn
X-Gm-Message-State: AOJu0YwPepwDJgRAGdbvjAp1gQOb3ASJ3MN9LjEguoAy+SuQIBGMtiG7
	guzcVHpHawPPQ8yns+Ouv3BocpThdjgF+jXE8Zgf3ntfJWFhFmtRY2S1FvmF9DHXTxjnPUnXycW
	9KuWH2ac1zZGYPJTirmeUNDjqPjZcsboAfzMB
X-Google-Smtp-Source: AGHT+IET8BpalyuCRR3ec4d/UltRhOMUt1gKg+BS5WJWfldGsTfJGsa7NaAJTms1Gk/0y55tUSYbmPRWE04G4jEP/Rc=
X-Received: by 2002:a17:902:cec8:b0:1ff:622c:27b2 with SMTP id
 d9443c01a7336-201d8fda9c8mr367005ad.3.1723596217174; Tue, 13 Aug 2024
 17:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813040613.882075-1-irogers@google.com> <ZrtzTTHim_vGX1ma@x1>
 <CAP-5=fUA8T9B2RvXg-Hpj_fHXmwB18ah6Krm3qm5ULH-M04Lqw@mail.gmail.com>
 <ZruhsN4i6xtc59nJ@x1> <CAP-5=fXVrhanvW6vrUJsubuWUC4jBM5v_NOFp40cqTsqdHHNaw@mail.gmail.com>
 <CAM9d7cgGgXTyTQNPDyVuKWM=Gxt3=J6QZ6FiYDXZRWASgKPskA@mail.gmail.com>
In-Reply-To: <CAM9d7cgGgXTyTQNPDyVuKWM=Gxt3=J6QZ6FiYDXZRWASgKPskA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Aug 2024 17:43:25 -0700
Message-ID: <CAP-5=fXXNCKZcv-5SUcQH7o2E9uiRJ22s=-_UrY+_jWmtmH2wg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf disasm: Fix memory leak for locked operations
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 3:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Tue, Aug 13, 2024 at 12:11=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Tue, Aug 13, 2024 at 11:11=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, Aug 13, 2024 at 09:04:57AM -0700, Ian Rogers wrote:
> > > > On Tue, Aug 13, 2024 at 7:53=E2=80=AFAM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Mon, Aug 12, 2024 at 09:06:12PM -0700, Ian Rogers wrote:
> > > > > > lock__parse calls disasm_line__parse passing
> > > > > > &ops->locked.ins.name. Ensure ops->locked.ins.name is freed in
> > > > > > lock__delete.
> > > > > >
> > > > > > Found with lock/leak sanitizer.
> > > >
> > > > Ooops, I meant address/leak sanitizer.
> > > >
> > > > > Applied both patches to perf-tools-next.
> > > >
> > > > Thanks, could you fix the commit message.
> > >
> > > Sure,
> >
> > Also, it'd be good if maybe Namhyung could take a look. I did things
> > this way as it made sense to me, but we have nested things going on
> > and potentially the free would be more natural in ins_ops__delete.
>
> Looks good to me.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks Namhyung, thanks Arnaldo. I think git blame said Namhyung
because of a refactoring. I'm glad the free is in the correct
location.

Thanks,
Ian

