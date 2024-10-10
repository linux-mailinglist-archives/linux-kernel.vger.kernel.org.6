Return-Path: <linux-kernel+bounces-359069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7496F99870F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113271F24A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C089A1C9B8A;
	Thu, 10 Oct 2024 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="m7sn3E3T"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4121C68B2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565407; cv=none; b=oFiuMp56s7Q0DrxjW7OVrG+kQ5Txky/+oC/cQ42bZ7obdx+4/6toDTyG9Ulcp1/sr+/ufNMaRIzzdmVBd960qHW2IR1NwhmbCqyr9VqpTx49/onMZpAZETJpKnh3H4QfXaCimIus+OIx9vQkKSmwLd2p9kjkbzc6acvS410MZuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565407; c=relaxed/simple;
	bh=cqB5smMsozRkB4jP7ySM7Z677IlXYIXG8mmgjSuA9oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ly+9JcthCxEDqwGDHlOARSvjYKtB2ijqMyaeaXqCH1kL7ypXuJzhzcXapWyOFHmphNuIA7Imyl50VDL5lbjHQOYiwzWLjRdrr4XXjRF+yKHNANVv9HtWEo0Cvh8TBS9Idd73PJRjgaIujNwff4U1mLDkGZ0DiTSWgANhPD6Gb3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=m7sn3E3T; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7afc5e480dbso53058485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1728565403; x=1729170203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zz8jctQHQLdkYKPa0eysbx7cndDpR6sJ5ZE98zZOXWQ=;
        b=m7sn3E3TzWoJOm131A0xsibBnd9G5njTbK/sRnq58ldfgFF5LJa1E75cAGbwm+4zub
         Iav/rpbq/ZcI82yB8941+qS184KoJWHg7gcpURu5AbnlvfkIt5LzSdyOtJQrIKEACyIc
         I06ceY31Tp0HjWer5OxOk+RKXkBBWRszIDnPuU2LhNO8uPIILCdGJeinFhkWxQ1abQsY
         0ymz5gSJpS93KEq9Ogt+pmj4bXAzfD24QURNG5GircNY82pWf3vyrenjgiPgPzBmlKId
         1/Ig5D/l991pUFx3Nltp2/X4v5pp1n3BgmLoSGiyIlrGLVbamKDBsuZ/zeSTdF38m8jR
         SR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565403; x=1729170203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zz8jctQHQLdkYKPa0eysbx7cndDpR6sJ5ZE98zZOXWQ=;
        b=OojRQ4Ul+PQXzeVDxlXMx0ZHV6Gcp7jjhzSnB8BgBSyzYwJp49WHXdNZ5sjMQnb5qb
         3O+L8XQy8Pbr2iqSkQSlIJXmJylQZA4KUS/TVKQ0kOQUZBnY/qH5a5FKoZjKBRuKhpGT
         WWkDxm85t/xv4WgMoOgPE/H+dNggJwDGbV1L9JbfF2Y7eWGz/fNMMxa237NJ8JA1DcBt
         oi1PmCjNUJ9nlWWmEEHA6Ff4KK5nAS8Ns2eucpDvjH+JU6EUwZXujApllFn9VP/f0AYr
         nt/xY864VENthUElvcxCB0IKkTbNiG/O/SXobOxmqzwziVrFyLoWFG57dlcE+n8PxHYZ
         7ZDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5AZVFWX8rfi3PxaU6inQVV5rIX10/sLAU5MCr6PLipwpqCZwF6ACaQWkaUXYk1zavcCu5GMwKp5ggbwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEZpWbR3XOf7GLARavS2iV2sYaxlWHRObbiQ8MxM9tY22C00GN
	7+hZePR8mvQv+dPqOSU6nc/2tplyL9MfEGvsKgearlESdHzynQdQUmT35/J/o2E=
X-Google-Smtp-Source: AGHT+IGbRr+pYajEwQ8nR/4EEsQx2+uct5b4CidGwGQ6phMD5igHU+WeqC3mB8dXOKjIpobst/NNSQ==
X-Received: by 2002:a05:620a:394d:b0:79e:fcb8:815c with SMTP id af79cd13be357-7b111d4edd7mr539200985a.54.1728565402986;
        Thu, 10 Oct 2024 06:03:22 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148d6a56sm45021685a.35.2024.10.10.06.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:03:21 -0700 (PDT)
Date: Thu, 10 Oct 2024 09:03:16 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Ziljstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Klaus Kudielka <klaus.kudielka@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Bert Karwatzki <spasswolf@web.de>, regressions@lists.linux.dev
Subject: Re: [PATCH 3/3] sched/core: Indicate a sched_delayed task was
 migrated before wakeup
Message-ID: <20241010130316.GA181795@cmpxchg.org>
References: <20241010082838.2474-1-kprateek.nayak@amd.com>
 <20241010082838.2474-4-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010082838.2474-4-kprateek.nayak@amd.com>

Hi Prateek,

patches 1 and 2 make obvious sense to me.

On Thu, Oct 10, 2024 at 08:28:38AM +0000, K Prateek Nayak wrote:
> @@ -129,6 +129,13 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
>  	if (static_branch_likely(&psi_disabled))
>  		return;
>  
> +	/*
> +	 * Delayed task is not ready to run yet!
> +	 * Wait for a requeue before accounting.
> +	 */
> +	if (p->se.sched_delayed)
> +		return;

This one is problematic. It clears sleeping state (memstall, iowait)
during the dequeue of the migration but doesn't restore it until the
wakeup, which could presumably be much later. This leaves a gap in the
accounting.

psi really wants the dequeue and enqueue of the migration, even when a
task is delay-dequeued. We just have to get the context parsing right
to not confuse migration queues with wakeups.

I'll try to come up with a suitable solution as well, please don't
apply this one for now.

