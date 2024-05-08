Return-Path: <linux-kernel+bounces-172572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2818BF3D6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F715284820
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21063E;
	Wed,  8 May 2024 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ShBxnWHS"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FA038F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715129484; cv=none; b=ndclf48qDI2n1LqOkH+lIAvC3iknN0kuNQ56XdkB+UMBpDhGgenXxxlPC8axMGC0Nj2LHtehBptFhTM5P6VZ3qsUY331lOa2XnK+oGHnZAP51yfge4SCRzkQe1RRQxi5HJz+AMQ1ctFf0tHPPkwm+LKUbvJ+m4QMFE/BKuiYhdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715129484; c=relaxed/simple;
	bh=J9f+ozTQRVvFEaj/RTq9sBDGm3e0WJAgiC7XQw+Bzo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8zvMbcpeDGP0Q0T8VW+iwXEMiAL9jjwoh+RmuWkMboAvuLhFLAPZaCEltvusoovSqDGCtHsPnofm4Jz9iCRQOl2PeOXhdvqoIyspQCQKtQnEv8x4Ike0cN5UR3UVjl35cwvgGpLMeSbBgRxmsGpeDtd08DXKPt7BSDYAC9Fz08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ShBxnWHS; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-439b1c72676so130131cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 17:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715129482; x=1715734282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yxY1w9XvCxUPvXqMAMhe9NTxvR+eY9pH/XL6Sd2kTk=;
        b=ShBxnWHSbUv0gI4AcmlLXXju+PAA041ExSciSa8xn9uJ1pMt9EuE8UlQVyX1xU4D5i
         JA4Y9bDVQKxtFfjtoguyElXBanujAyJ0uVAF6i4bkq+Kutr7dAt958q+Z7zclzNtJIUS
         bvNGOV9PvGNd4wJAyUcrrsPIYPNeuzbVKiE72RpAeew3n2hDmrbOoQ/ADYsWjU7TyrpL
         H1q0/lyTTglP+VdSqgzMtlHIh7D/l4TSBXzBhFytCFOZJ1sbnyX7E8AJAoErm/DDrCRc
         mLf1772L4paGcCaTFsWcMuLG209OtevIBcmyqdFA4Bcr9k618LOfw65Y5HqdMh9d+ALP
         nz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715129482; x=1715734282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yxY1w9XvCxUPvXqMAMhe9NTxvR+eY9pH/XL6Sd2kTk=;
        b=Q4FFvQVBZVKXbgEXp+LMzJTDta0z21hcdNf8vqFK6pOsbNFxbTESC3uZPxcNYGizc1
         PGIykXMCRMrW03ROQSKuc9iN/vIBouveMOkqvhVJCDEVPJYJaCany+PldMhl56o4UNvZ
         F0wo3egOp6Ue4VH4aybGe5HsWXsLbeWuHzA3wLypwQL9vs/X08s5NioghYmRuRbvDfyt
         t4eUtyFlZjwNJpejoZ6N507usqgTqkdhP0pbVhIR+M+qJbhULFIdkkuWJBQwdPccSKxi
         REnL8TJ4+0W9jTbeQvykCIIYxxMpmqfY6nXPlYhLPd7Oz6tnwbXYyLX+ABSEIXPBuTnp
         brxg==
X-Forwarded-Encrypted: i=1; AJvYcCWAt0/rrgFTIJ0sAGfpZfjLNZJOsa1lFX73WUqQsFKUYtlpiADGKMnUFovxtArvURYZD1unS/awe1bZpKB1DthkWTT3hADUxltSpdBc
X-Gm-Message-State: AOJu0Yz5ylsrmGMYJ8Hq8MZug52TZTlPKXsOwXs3KYiLuDzHOIJ18J6q
	yRbHVtPvgVNuBl0B/kSl0sRmjRdsC7aSz+I9d+yQ7vT1iKJaelPqQtt95iaX9xmRI6xc40D82Iu
	d4Gbr+F5vzsO1bygyrl2awpKKgZCTIqlGj7FX
X-Google-Smtp-Source: AGHT+IG/cDhocQ0+FppCnl9oKclXai6sCmFa5FJbky5InQn/IU58BxdGTkJqtIyS4tha1kcPXsFT1AJn7wIJoBMOs8Y=
X-Received: by 2002:a05:622a:5490:b0:43b:6b6:8cad with SMTP id
 d75a77b69052e-43dc2d9577amr1413111cf.10.1715129481777; Tue, 07 May 2024
 17:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507183545.1236093-1-irogers@google.com> <20240507183545.1236093-2-irogers@google.com>
 <ZjqNKPgWR7mBFaV4@x1> <ZjqNjrJ2ElrT11iB@x1> <CAP-5=fUsQwKsCi3us+dp-Tj+PayNPrYTqTQeo-YLbvSuOt1=9w@mail.gmail.com>
 <ZjqXa25BnFncJmw-@x1> <ZjqYD-q7EqQW6hVE@x1>
In-Reply-To: <ZjqYD-q7EqQW6hVE@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 May 2024 17:51:10 -0700
Message-ID: <CAP-5=fVRBXv0H3vRNYO_uwWsNGvBxWVXd78UOu0QvGK04+bERw@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] perf ui browser: Don't save pointer to stack memory
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, James Clark <james.clark@arm.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>, Paran Lee <p4ranlee@gmail.com>, 
	Ben Gainey <ben.gainey@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 2:07=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, May 07, 2024 at 06:04:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, May 07, 2024 at 01:48:28PM -0700, Ian Rogers wrote:
> > > On Tue, May 7, 2024 at 1:22=E2=80=AFPM Arnaldo Carvalho de Melo <acme=
@kernel.org> wrote:
> > > >
> > > > On Tue, May 07, 2024 at 05:20:59PM -0300, Arnaldo Carvalho de Melo =
wrote:
> > > > > On Tue, May 07, 2024 at 11:35:38AM -0700, Ian Rogers wrote:
> > > > > > ui_browser__show is capturing the input title that is stack all=
ocated
> > > > > > memory in hist_browser__run. Avoid a use after return by strdup=
-ing
> > > > > > the string.
> > > > >
> > > > > But everything happens in that context, i.e. hist_brower__run() w=
ill
> > > > > call ui_browser__ methods and then exit.
> > > > >
> > > > > We end up having browser->title pointing to returned stack memory
> > > > > (invalid) but there will be no references to it, no?
> > > > >
> > > > > If we return to hist_browser__run() we then call ui_browser__show
> > > > > passing a new title, for "live" stack memory, rinse repeat. Or ha=
ve you
> > > > > noticed an actual use-after-"free"?
> > > >
> > > > And I'll take the patch, I'm just trying to figure it out if it fix=
ed a
> > > > real bug or if it just makes the code more future proof, i.e. to av=
oid
> > > > us adding code that actually uses invalid stack memory.
> > >
> > > My command line using tui is:
> > > $ sudo bash -c 'rm /tmp/asan.log*; export
> > > ASAN_OPTIONS=3D"log_path=3D/tmp/asan.log"; /tmp/perf/perf mem record =
-a
> > > sleep 1; /tmp/perf/perf mem report'
> > > I then go to the perf annotate view and quit. This triggers the asan
> > > error (from the log file):
> > > ```
> >
> > Thanks, it is indeed a bug, I'll keep that Fixes tag, people interested
> > in the full details can hopefully find this message going from the Link=
:
> > tag.
>
> Nah, I added your explanation to the cset log message.


Okay, I found I needed this to avoid a segv introduced by this patch:
```
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index c4cdf2ea69b7..19503e838738 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -203,7 +203,7 @@ void ui_browser__refresh_dimensions(struct
ui_browser *browser)
void ui_browser__handle_resize(struct ui_browser *browser)
{
       ui__refresh_dimensions(false);
-       ui_browser__show(browser, browser->title, ui_helpline__current);
+       ui_browser__show(browser, browser->title ?: "", ui_helpline__curren=
t);
       ui_browser__refresh(browser);
}
```
I also found a use-after-free issue with patch 5. I'll send a v2.

Thanks,
Ian

> Thanks,
>
> - Arnaldo

