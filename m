Return-Path: <linux-kernel+bounces-442975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFE29EE4DF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020BC1886D82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF70210196;
	Thu, 12 Dec 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skW5zytn"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAB82101BB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734002332; cv=none; b=W/RQrOYKfOtWMSuNLpegDlO71BQuYQb8xck8zxjGr23WjvDGZzX/x9zBY4wUpsZVUGTiKXNvtX/9CvCcZqD0RNcIcvCQ471mX+G6S+he0kXUeA1bztKnN29aqGRIXA8Oa/7VesVt6mQWe6FyJrh8qFLjdCS75xrnaivpXcw2IMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734002332; c=relaxed/simple;
	bh=HDh2JxUt93x+UJ+AzGqapBkSIyV0cGFYYJs0GCaSmRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWAtT02nPWtFW+Rbufb9JUyadZViFg4kebA1Xxv/XIwztjCeqkDzShQw3fzxn0e9RMl/aqYiKFIF3Y/Qsyrn/QvNSEqSGMTx1FofDYDVAFayWQuAhOZtIly2TLiudhcX+IegRPMgVOpRmkGGMWsHI8PG51NZazL0cNXLCe2ZAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=skW5zytn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2165448243fso5098485ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734002330; x=1734607130; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0bZLN4mh4pydusdLaDx4TuK3J4Kzz2Zs27oz1N/o29c=;
        b=skW5zytn6VRu9IAadKlGHdhBF6qIYofLZQivjw/0PazziNm5VCKsEulva0/N1Srnf/
         5rhBq9yqk4eus0CvLPnYCVZsPl6PDRpvzhcuOo2uw5twy5sgiWwG24F3OyjMmNldPIJ8
         1ti+Gje0sSB3pSwj0J6ZAigegJpq2VbA4QNfzyq3YAKYORxIwVfttGSxZ8/OILPGjVYF
         S2bPk/VomMt7DcGoT7iUCKRG74s5Vac2aoRmRMcThFk4FXTcoPKMOeWMA/+zuSNF7OID
         tAMOHpfanQRRhZAfW8qPWYRmEV8QUOrqY+KTinN17MoQVzYa1ASPcCROa+m+0h5afm/U
         UF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734002330; x=1734607130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bZLN4mh4pydusdLaDx4TuK3J4Kzz2Zs27oz1N/o29c=;
        b=nAIEKiK0SiikcJDuswPzmZFO28nXwbexrUX3oPRDfWbxKXCtLD18XVqMh4x7/NZjdX
         DMHsJcDxubgHPoyACWRMkx0xQ6YkjKM93ICFXbIGRqXa5lRxH0qOVploF8iYirWHLXF1
         jp7grJh8HEp0I3OBKWPW0Q/nwoQCYT54CtpiA34YRDS3ddGnjrRnKpUc3VnC4NjkpqAn
         EHB/b1WmxsXHidLw4n0RuzlnwqefFOQLkij2PJQcDjkw5jFnLkYdYZv8vFrzyoTt3bwF
         MqGEkR2dXqxZ79UxQtJKHBAgwelWLm1hwo6/x1wtYYOd0ie0z3jXUZjwmgbWATGAJbak
         uQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCVmjH7zgUpoiveGsmQEWkESTusmCCmt650PPp4zQzbwi4eZPJQnb6g9rAcS9E2Y4UJSUetOr9zsnasuFBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOXCj3nG2weJYzIYGT9vNsBCN4pDFy4mS1mclo3TxsUEq/iBDh
	cegfZ/eLSuvdchy2b2O/G0wzvWGduWaq5JAvY1iFf3MXNUwqjyja6bLcH7s8UuThI4CArBLaVur
	z6BdhSfyml1CYcfOTa6HTyxMktMRYWGpR256TYg==
X-Gm-Gg: ASbGncts0k8yPHQrBsZhIemJhftG2476XylFiLnKiARfHLZQgQsOvJPgDxX9J7fCQrG
	RzrS2G057JJGb9HUDImCXo1/f5/a+KKs9w8WNP41z3/qlAM+HstnkmISXnkpWlH2wSMA=
X-Google-Smtp-Source: AGHT+IFNhULjCwLkMLP2XySf/6s3wi494mvF0NARpwZ17Mty9d4vPtpvpUXRsOFkeEn+g7dkPFTgHRmrAjaOR8Qv004=
X-Received: by 2002:a17:902:c403:b0:216:5af7:5a6a with SMTP id
 d9443c01a7336-2178ae8845cmr51216625ad.32.1734002330385; Thu, 12 Dec 2024
 03:18:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211185552.4553-1-kprateek.nayak@amd.com> <20241211185552.4553-8-kprateek.nayak@amd.com>
 <CAKfTPtDQy=VfH3Ta8zLSACX7QV+LWaRvj_ueN=iSu5i4t8oBtQ@mail.gmail.com> <a79e0e83-d1e8-4a16-a317-599e063d4797@amd.com>
In-Reply-To: <a79e0e83-d1e8-4a16-a317-599e063d4797@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Dec 2024 12:18:38 +0100
Message-ID: <CAKfTPtDN2rrKVgdDxtSeFtdQkjLXV7FUx_0JmYc1Fv4FZZaLdw@mail.gmail.com>
Subject: Re: [PATCH 7/8] sched/fair: Do not compute overloaded status
 unnecessarily during lb
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 12:01, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Vincent,
>
> Thank you for reviewing the patch.
>
> On 12/12/2024 3:26 PM, Vincent Guittot wrote:
> > On Wed, 11 Dec 2024 at 19:58, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> >>
> >> Only set sg_overloaded when computing sg_lb_stats() at the highest sched
> >> domain since rd->overloaded status is updated only when load balancing
> >> at the highest domain. While at it, move setting of sg_overloaded below
> >> idle_cpu() check since an idle CPU can never be overloaded.
> >>
> >> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> >> ---
> >>   kernel/sched/fair.c | 7 ++++---
> >>   1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index ec2a79c8d0e7..3f36805ecdca 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -10358,9 +10358,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >>                  nr_running = rq->nr_running;
> >>                  sgs->sum_nr_running += nr_running;
> >>
> >> -               if (nr_running > 1)
> >> -                       *sg_overloaded = 1;
> >> -
> >>                  if (cpu_overutilized(i))
> >>                          *sg_overutilized = 1;
> >>
> >> @@ -10373,6 +10370,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >>                          continue;
> >>                  }
> >>
> >> +               /* Overload indicator is only updated at root domain */
> >> +               if (!env->sd->parent && nr_running > 1)
> >
> > nit: may be worth checking local variable 1st which should be cheaper
> > than env->sd->parent
>
> What are your thoughts on passing NULL for "sg_overloaded" when calling
> update_sg_lb_stats() at non-root domains? Would it be equally cheap to
> do:
>
>         if (sg_overloaded && nr_running > 1)
>                 *sg_overloaded = 1;

you will have to test it twice as it is also set for misfit task

>
> >
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Thank you.
>
> >
> >
> >> +                       *sg_overloaded = 1;
> >> +
> >>   #ifdef CONFIG_NUMA_BALANCING
> >>                  /* Only fbq_classify_group() uses this to classify NUMA groups */
> >>                  if (sd_flags & SD_NUMA) {
> >> --
> >> 2.34.1
> >>
>
> --
> Thanks and Regards,
> Prateek
>

