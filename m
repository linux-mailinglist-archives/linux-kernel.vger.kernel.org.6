Return-Path: <linux-kernel+bounces-285396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6A7950CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A781F25535
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410631A4F11;
	Tue, 13 Aug 2024 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B729vSPr"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8E1A705B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576299; cv=none; b=Z9YopphTvlr5fKH+tzde32gOH6qjp20zRmw7Hoy4AzQuTYIoxsXC6wYKubnHNQjmxUuxVOtw4c1XmQv79HI5vLyOQg58y5Ad4tPTbRmhr5CowxBBP/WvbZ1p829NnphTZhdU3TOaqxJSvfI6PexyeSculbBXe4mzlf/ygsOMlMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576299; c=relaxed/simple;
	bh=0akCB2lUXwXXL4c4nPCxosaE3I857/U47hgI91ToH8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ze/77pwc6PlFn8zYsYLMYEbIJUD7Sly0kaJwNCvxWWfZXQr4xFOIvgHc55HzjrpN2zzlmjpwZUyFhEHxsyzVYvIymxXC00N64Gt+xPtfCS4gBOfflAw3/XZ8QvYMVtLfUOrvxOS5ATRQicfSsHagoGqRprR9sAIR5u4qCoIVRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B729vSPr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-200aa53d6d2so15985ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723576297; x=1724181097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0akCB2lUXwXXL4c4nPCxosaE3I857/U47hgI91ToH8w=;
        b=B729vSPrcNEGQKlsKDz6guarSKr345ecj6c36vuXCOJpMRNeIm5yyy6dnYwAmStzAw
         JTju1PSEx2fGmj+e9HHOJ8x1xj6Hkxt/WktJ5cNPZ4zy9+itvTiF0BLZB79I7hnG70XE
         STa7LCS/ddZD0UPZ7SD8S7atBtMdqpC3VdDTzS9L5libqZmgm9a7g2Kw5kOZgzZpHrSX
         TdlDhT172CdZ30wccrS7Ak1Bq5xt8UwJwJXEHgancPaMFL98Pot83SBaIAdeH032mTUd
         Gw8+b5KOh24PXehk9ZAtbKMfVYuGXAFhS2f4Lbm9+Q/sFKM9ShTR8N7Wwgn3WOIfnJOQ
         yTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576297; x=1724181097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0akCB2lUXwXXL4c4nPCxosaE3I857/U47hgI91ToH8w=;
        b=eOCnUViD4M+p0MT2cl/XTSfYE9Gnr8TUlk0nLJXiXd+iZIU1Ki9VDOBEJnExkDKR/K
         tA+vRFnBwDnnMwg9BiHnEivVeR0m0fcTx4+xk48fTeAxNyYgmloQ9XanFLCKmBoz+VAQ
         VxqLBhyVErRI41ROucB6lLOqF8MsHiKCGABwu24vlyCd3ri4vxlOWCUuVCRYFgluvh83
         XcPPeBaZET2y1HDW2m/5pEvMjbF6QLJ8/2ORylyLfTVG5xcbWlOSgr6se2AeSrOmkgij
         AHH5sFrYFvt55j99I2Mvi/DRQfm1O3lUGHcagMDbdIW/7F5/NMgro3bqhAbcdyv4KIph
         dSzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU++oFsADJLxI8/QicodypxSQdH291ZJQYpyP1AO7r+X1j8g71PoDQLgzYlVgCsc/s334brHNOk9X1Or9V5caxIWjDViMPqIFPPFYz+
X-Gm-Message-State: AOJu0Yzy6EdGOEsHbrMk3VgV8vO4GKEKjNMd8ul9har2I34zM5Xfo5D/
	dZw9qfp4rvUKDuQwm/305eVQDUV29aVTVRRIj7KRaicxLf8BEYMbJmlKS2shWRgN4GL4FbPECmo
	5gzOQrMH/+M+llvKZMOuc2t7vM9dekGubWhpE
X-Google-Smtp-Source: AGHT+IHdvTrBByfKnXhhh6zwnJjdbwU4J5mMe1EDQZ4dHX8vp3horZ6QsjNBJr6Goj6FpxG/8/69jGclyK5ceJGotzY=
X-Received: by 2002:a17:902:a515:b0:1fd:d807:b29d with SMTP id
 d9443c01a7336-201d747b187mr219165ad.28.1723576297094; Tue, 13 Aug 2024
 12:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813040613.882075-1-irogers@google.com> <ZrtzTTHim_vGX1ma@x1>
 <CAP-5=fUA8T9B2RvXg-Hpj_fHXmwB18ah6Krm3qm5ULH-M04Lqw@mail.gmail.com> <ZruhsN4i6xtc59nJ@x1>
In-Reply-To: <ZruhsN4i6xtc59nJ@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Aug 2024 12:11:21 -0700
Message-ID: <CAP-5=fXVrhanvW6vrUJsubuWUC4jBM5v_NOFp40cqTsqdHHNaw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf disasm: Fix memory leak for locked operations
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 11:11=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Aug 13, 2024 at 09:04:57AM -0700, Ian Rogers wrote:
> > On Tue, Aug 13, 2024 at 7:53=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Mon, Aug 12, 2024 at 09:06:12PM -0700, Ian Rogers wrote:
> > > > lock__parse calls disasm_line__parse passing
> > > > &ops->locked.ins.name. Ensure ops->locked.ins.name is freed in
> > > > lock__delete.
> > > >
> > > > Found with lock/leak sanitizer.
> >
> > Ooops, I meant address/leak sanitizer.
> >
> > > Applied both patches to perf-tools-next.
> >
> > Thanks, could you fix the commit message.
>
> Sure,

Also, it'd be good if maybe Namhyung could take a look. I did things
this way as it made sense to me, but we have nested things going on
and potentially the free would be more natural in ins_ops__delete.

Thanks,
Ian

