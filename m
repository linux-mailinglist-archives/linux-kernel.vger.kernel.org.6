Return-Path: <linux-kernel+bounces-370281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 573AB9A2A50
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2DB728498F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934F71E048C;
	Thu, 17 Oct 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3DaVh6Xp"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE601DFDA5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184735; cv=none; b=C+Q47qWAUOQFr5IkJQizooY8GXcYBA/Wv7MqDTr9uZwZhubpEygVg2pmMETjum1un9maXHk64BV+iqIooNtWeDtNHpyCyVm8K4edT7IIPXnPgiL9OQYHvGjFAPadIYsff5c+rMJcXEme2DvpS9rXvmSlfVcKdD4XEI7wuAH6nFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184735; c=relaxed/simple;
	bh=YlDGtnfGvvX80B/eJZtyrZHBPOgy/mC95P2OySjtvzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KX/CRaztJAU0v0eZjyUlHB4bx/2pZ0DIG5tp56kRxACCYDaJuffVuN1cbcdbQvxGH1LaWItH5bGfxn6ZqdHMZt/+MLGJltT32gPE21ncFn5pe3xTBzQdk6O4Dxmq0zLPsurLRmbS27HnpMN2gxcGrQXqsSJuAjz1yVNbsxHR04U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3DaVh6Xp; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so8085ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729184732; x=1729789532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSVZ7x4+MXTZlgRW8/EerjnKSG0Ie4T19KQTgk4b1Lg=;
        b=3DaVh6XpdkVMjnDXjpI/Z86l7B5o4r0hnC0N9twgpgvYKxzCIB+nSbPckSRqg5gHDf
         YTib/w7MsgNltttZyKOrZBvyrcpSQ2ore8jfhaDEC1EtLenfE2D0eddm7fLP+IvFUGal
         S98jaExtYh0h2gTZ9a0e4pqVRQr0vyD/AQpBASgGZmE6VdXCaks3Y6ijJZ/l7FkNiYnE
         tK81Ypd57czp49a3IemwpRcfMhHmB8BgQxx7lRMJJ/Ylfm7t/Umc46X0+EC8XZVGDf7b
         TXNwY3kdjUP00dF7jVOCITndAJWjhgZLzRFVbRJqrLDLe6IZ4oYWXf13CNtb64Z3o3w3
         ArpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184732; x=1729789532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSVZ7x4+MXTZlgRW8/EerjnKSG0Ie4T19KQTgk4b1Lg=;
        b=CCShAS9pqAPxZxHaqLhATOHHNFBGX5wVCsgay15ENScPzd4PxDsL7O6MLX7SFhWp1m
         qgTMZKp6SDU8TlxjAWiAt5cd+rxh2/NWVjP+K35x6P0ouO80+kqpUuBC4dxsVx6BeGB9
         Ptrk896ipTVzveiZB0B+CCUuIjABb28eJsCBbZZ5sGB5r94U7meaeScNajEyd3FxHOiw
         dNhNII40n0bESCeqL2FoFtEhfQLDRBEw+5nUTvI27Gm0tnX1niphybTHbcLfhLOGxjXu
         UmOgJBQ15G5DlqjcEwTbYq/tJrNVhA2Bx7jCtJeuDHLkGfAJjD6TZal3+OAjpSv35PRu
         HwPA==
X-Forwarded-Encrypted: i=1; AJvYcCVxLRXUGeOkGC37ZoGh9fg8ubLewC8xIWdVzKZBYV44ozmLj65bLyhtBRo29Zcb6rmoETZpOriyYReJn08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDoQZKNOdRB9cWt8TIdEqYl/9ZuckbOHlcRNAbpBxlzjuAeAFG
	MxSBFDBCnbOi4j4J1+lrr8yP8wKCQavCAYiNSaz/cvXl5XxPvvrfKsui0lABP/Z9d+lT4L1asbZ
	u7poCr5u4AKpP/i9yACvLP1oEN76y/5SsABEo
X-Google-Smtp-Source: AGHT+IH+cU0DDHe4rbUNruv0FZ8Fo/AK6Md8CtUAz6iHAAL+y8/sNiCrnpMl3Z6oYfxVbJuXUw9bzFLWViCJwR+BVQQ=
X-Received: by 2002:a05:6e02:12c2:b0:375:bb49:930d with SMTP id
 e9e14a558f8ab-3a3ea039433mr4186845ab.23.1729184732021; Thu, 17 Oct 2024
 10:05:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016175350.116227-1-irogers@google.com> <172918316032.639809.5792146702013848062.b4-ty@kernel.org>
 <CAP-5=fWMkF-z5t6-Oz8e8YRuW0rsMg7JXj4vSHqLZFe0y3=sUA@mail.gmail.com> <ZxFBdCMFZ50oo-s2@google.com>
In-Reply-To: <ZxFBdCMFZ50oo-s2@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 17 Oct 2024 10:05:17 -0700
Message-ID: <CAP-5=fUp8=WYrYT54Cr2XR4yD7gcMP8xP9q8JTs3MYj0Vn5GjA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] CSV/JSON metric thresholds, fix printf modifiers
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Weilin Wang <weilin.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 9:55=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 17, 2024 at 09:44:08AM -0700, Ian Rogers wrote:
> > On Thu, Oct 17, 2024 at 9:39=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Wed, 16 Oct 2024 10:53:42 -0700, Ian Rogers wrote:
> > >
> > > > Metric thresholds are being computed for CSV and JSON output but no=
t
> > > > displayed. Rename the color that encodes the threshold as enum valu=
es
> > > > and use to generate string constants in a CSV column or json
> > > > dictionary value.
> > > >
> > > > Add printf attribute to functions in color.h that could support
> > > > it. Fix bad printf format strings that this detected.
> > > >
> > > > [...]
> > >
> > > Applied to perf-tools-next, thanks!
> >
> > Sorry for the trouble, could we switch to the v4 series due to issues
> > on hypervisors with not counted events in CSV output missing a column:
> > https://lore.kernel.org/lkml/20241016215139.212939-1-irogers@google.com=
/
> > The patch set drops the CSV output metric threshold support.
>
> Oops, sorry for missing v4.  And I also noticed a build error on i386.
> I'll drop this for now and push perf-tools-next soon.

Thanks, I'll need to send a v5 to address the 32-bit/i386 issue.

Ian

