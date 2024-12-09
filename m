Return-Path: <linux-kernel+bounces-438428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514169EA141
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AF018880ED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FD019CCEA;
	Mon,  9 Dec 2024 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQ3pdxCG"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED541137776
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733779769; cv=none; b=sTV3C/+hmPJ2Mkp4IYnEnuFCOuOYME0kMmwm6aFAjmRfHNIgkwzcdKaGu70nOGT68eq1Ef9IuBLxpWsxxNJMlpV87rP3fCM1zKEXrPaeha9sZ0sSsyEJ9KhWi4UrZ3d9V9l9jWK6LF88WwrYEmxELFznoLqrqWS8e05FsIeiYvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733779769; c=relaxed/simple;
	bh=k77DRqrYSaJgR2H3E2WehARx7ieaYWTSYSoKpHkMXcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSTUzKmeWbaV1lzCF4EGsTzFLV8OU6g8CCs9M4VK8RTYcxY3leHiCjKD/8VH6eqHDcRvjjWZ2T6V/tJeuxhCzxMDskOj/JO8y5MYNnAgwV8ydgPYvKBYoW4c8bT6Ncx7OSzyv8iM5nh4n1+PXXWTAT4gs95UVFl7u1Oxk0pd8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQ3pdxCG; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so13325ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 13:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733779767; x=1734384567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k77DRqrYSaJgR2H3E2WehARx7ieaYWTSYSoKpHkMXcQ=;
        b=WQ3pdxCG4M0hEJWCCo7u2HYTbJE1ZUvazkID3rF0h+Fwat4Q4fGhJkIJ34yTIdVFP3
         bVUCSV1/69BlLGQtHMrHh8f5M4VZLPwEUlTH21l9fgcNJfK2oenk5yWYtLPI2hVHGtvM
         6nzi5UEakW+UaX1ULzdFq+//AvG3ImNAfxqd/r6csOs6dbEpih3mAB2/0EBwqD5Lu+z7
         0rBn4e15KE+vzOst8t12vhvDHuxc+zPpgmvLa/TGkn8JnBpQ0XQA6nGUkuJdG6b7bsv5
         p42+CDK1K3aB4KvOcZtpfteOhhtqiFo3m+ndgLhGp3Yg1oWseW8LpJyUK4iqocfsRzo6
         8dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733779767; x=1734384567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k77DRqrYSaJgR2H3E2WehARx7ieaYWTSYSoKpHkMXcQ=;
        b=gWzvTRCPyhWeGXYuaUDyVUUmBopj0mvGmnpAJ7drQyBCfYjPC4hBwWlIUG2GrJ+IIv
         JArH3oDGAlI2PfiTwmrnh6fvOKfxewCCgFHpKThrM73Hy8xxLbJE442h0670gcz5GzrC
         BN+uKAlpF4toQHokEyqDvomJC5d5t4Wc681tsHj/ZlQbrckWA3n1pVlSRz4mOXPBY8gJ
         LjDQV8g20/jmXpFqEjNj0P5TRWL0NB6GbXoKLo7+zZqoQvgxCNPrks9OolklLmWRTx/3
         npZJQHokABTknBa2QsNb1dyCqun8zmcqtsfarwdfHmV+TpEMmOWUJWee8ak1fB7pJfQ6
         AAQA==
X-Forwarded-Encrypted: i=1; AJvYcCVemmf6ExP9MNTrAQgsuxbsOXhQ3K5ecYmMxG6fTNF2B4OIphSMfRsTL2PVxfhRzlHJwNlWglF+OEzdp9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhiOl9UggS1gp4yPAj3SUKcsJ/ySQMcHjA8gaD19TsTl2CUPwo
	CkSQD2NkmZGXSl8oqeMB8zDEgReB79QTN3HShaEuDQb0bDlEYprWXCuJ2lMKRp7nJyq4oOHeEcL
	mqBWsUYLt9zPubF4ctOX4QQilM3UXwUL2j1BW
X-Gm-Gg: ASbGnctsDGhleIbWFokbOgkMPTt4IYdTZEgL/QVtmnZXFwNHItWwRCWeFHsGXcKxEtr
	sXCKRpcrjdu1NuSSZcRtn+fk+kOgWW4SZ7Frz
X-Google-Smtp-Source: AGHT+IEHGJbe+AZDiNc+ia7Cyo5iwtcopsBfDtNGQFpU/eanHpvd8zca5EDeaFnnJ3XsqFtZQvOL0ss/1xGdhCkJu3I=
X-Received: by 2002:a05:6e02:20ed:b0:3a7:d8f7:7c2c with SMTP id
 e9e14a558f8ab-3a9dda2dad7mr717895ab.12.1733779766912; Mon, 09 Dec 2024
 13:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113165558.628856-1-irogers@google.com> <CAP-5=fWK-eeDEvE4+LeeScbHFecmc5+H8WB_5fepfrJJLZsF0Q@mail.gmail.com>
 <Z1dS6HrfkVS4OeZz@x1>
In-Reply-To: <Z1dS6HrfkVS4OeZz@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Dec 2024 13:29:15 -0800
Message-ID: <CAP-5=fUze9j8etq-17L0dWVoYfE-bA+61wrEAXN9vJSCj9dCbw@mail.gmail.com>
Subject: Re: [PATCH v1] perf jevents: Fix build issue in '*/' in event descriptions
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Sandipan Das <sandipan.das@amd.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 12:28=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Dec 09, 2024 at 10:35:34AM -0800, Ian Rogers wrote:
> > On Wed, Nov 13, 2024 at 8:56=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > For big string offsets we output comments for what string the offset
> > > is for. If the string contains a '*/' as seen in Intel Arrowlake even=
t
> > > descriptions, then this causes C parsing issues for the generated
> > > pmu-events.c. Catch such '*/' values and escape to avoid this.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Ping.
>
> A fixes: is missing, probably this should go via perf-tools, i.e. for
> this merge window?

We don't yet have arrowlake events/metrics, should there be a fixes?
I'm just preparing the patches for the latest vendor json from Intel,
but they will depend on this. I suspect given the size of the vendor
json it will miss the current merge window.

Thanks,
Ian

