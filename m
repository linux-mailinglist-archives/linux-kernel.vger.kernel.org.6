Return-Path: <linux-kernel+bounces-193285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC6A8D29CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 03:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0783D2857CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 01:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C5215A862;
	Wed, 29 May 2024 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="WxkaUUTw"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A37518B04
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945111; cv=none; b=Un/xvT+4wsw4rK8986jiBm5cWmUQzJRJZxWpffjLVC/SmQA+Xj1xu4FzCL4Mwvuvm56HL9dx3mj070x6lSaLHqnEtnVFVnSaiXlHxE6x1IF6kCF3Xaj+AWOoZ1wkS16Afc68BMdORGqzWixjhnZZH2C8J+etDDEYrn2/8sbJToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945111; c=relaxed/simple;
	bh=mtCLC3el6bEP3xWXKXrEM+Cdpht1UY4rwfRbaeK/mLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+QsA13wzlCihyj1dCTU6zkRhCPMf7hoh6VlOAHy2zbDTdOPUL5Vk5eni+m+ca/E56q5Apjp5MX9uoEI5hHtmWLicDf5C/kaNc6nc+5EpzrKiAqPHEW5dk1sNAMLdCcHGiRNBzKzoSSqbeG43LoQFHZKtzXAOjrjKCoeHfSwKAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=WxkaUUTw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42120e3911eso10055845e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716945107; x=1717549907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPNZaoaJtA1xZK2fsp/RvQvPvLoyRAgx50EU+G39ics=;
        b=WxkaUUTw2N8ZpnXqIblNsQ4Ekbqrh8odr+U3cr5TyvdUzp7lOgjlg/aKb2J9h5Eis/
         kSsjT0mfuP2D/h6RSGrFAKd5Isf314lkMY/HmVXurvEDs3PManfhpcV2FrTk6MpLV262
         MPVLzx4T5hn7B58l4zEUPDZwEmMdmEYg53Iz319xJ2w23twGt8gHB0ttq10jmCy3CNT4
         mbiUjLUJf/dQLpBK/skv1ULF2/aHTAxvgyBXBqsQSnnfEay+7n5+g1ucu3nQSjaGPg7X
         5Dg3690NAe2JAkgbH+SDsY6KgQF24Luq3lsRZgJ4flXEDrKaT//ZIQrLXIMXC/ax9Q2I
         xWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716945107; x=1717549907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPNZaoaJtA1xZK2fsp/RvQvPvLoyRAgx50EU+G39ics=;
        b=Hg5pEF4+O3LghYEepiVdoPvx+kIa4MA2DvLa1OJQ7hnS1oDmhqlGvrPApYyUKCK7Zk
         DqC8UH4i13gg8ooKE+NfrxH/brzpfmifuL3z0YoQiV2hBGPclDY/jS8jT3FmbcDetc0g
         94LXFW3ViQ/yDYpUsy96ADNURcyvC2r9FiuR7nhE3Rkgfyg6B1Dh2lyOrVPia2sIkMU5
         SUqVVEUIRT86A+SUoyF3jvdBLhEcHCKyz9sOhyA8VOi+bJBuYnon/csz3LkFaNjn0IfL
         bR8006fMkwE7Iyb9WC4K6v8NcFqUreEp2jIUXIcLiWsWR5zFkaw7rwTuowUqFnh3npN9
         XR+w==
X-Forwarded-Encrypted: i=1; AJvYcCVBl21b64YtpTZ11g99zqDKW3gFrN7o4RibbpV53/qOZYRhKwzlC9HkgYGeZMrFMk7HtX5IsrHsgzIBoK1K7BiP1XqVS4pPBQ6crJ3p
X-Gm-Message-State: AOJu0Yx0TePAkoOShnBsYcrglcygSTlaC5CExeqS5Snr5WLDTG0hTl+h
	PNEJw2WWjCgMX/eROEAQ6xw3MSyP98jFYLKiOJHB35oDNVbIzKrsdYjlx4I0QgE=
X-Google-Smtp-Source: AGHT+IEMCKnHbB6p+UdL/7W8I4STKw4+5Uw4acnirh3UUgvFatwuAO+P0FEkARvVha8lh0p/kUK4Cw==
X-Received: by 2002:a7b:cd06:0:b0:41b:d4a3:ad6a with SMTP id 5b1f17b1804b1-421089d322fmr116587215e9.17.1716945106551;
        Tue, 28 May 2024 18:11:46 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm193491525e9.4.2024.05.28.18.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 18:11:45 -0700 (PDT)
Date: Wed, 29 May 2024 02:11:44 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] sched: Consolidate cpufreq updates
Message-ID: <20240529011144.smuq6dbaxvulxy4e@airbuntu>
References: <20240516204802.846520-1-qyousef@layalina.io>
 <b4036b48-7d04-4bba-b405-f64ee309e874@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4036b48-7d04-4bba-b405-f64ee309e874@arm.com>

On 05/17/24 12:06, Hongyan Xia wrote:

> > @@ -1997,6 +1999,13 @@ static void __setscheduler_uclamp(struct task_struct *p,
> >   		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
> >   			      attr->sched_util_max, true);
> >   	}
> > +
> > +	/*
> > +	 * Updating uclamp values has impact on freq, ensure it is taken into
> > +	 * account.
> > +	 */
> > +	if (task_current(rq, p))
> > +		update_cpufreq_ctx_switch(rq, NULL);
> 
> Do we care about updating the frequency here? p is dequeued during the
> __setscheduler_uclamp() call, so I think it's better to do this after the
> uclamp() call and after enqueue_task(), so that uclamp_rq_inc() comes into
> effect.

Yes!

> Also, do we want to limit the update to task_current()?

Yes we only care about current because it is running and asking to run faster
so we should honour this immediately.

With this patch we don't do freq updates at enqueue anyway.


Thanks!

--
Qais Yousef

