Return-Path: <linux-kernel+bounces-427160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A529DFD65
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC03281D29
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81AE1FAC4F;
	Mon,  2 Dec 2024 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REFzj3s4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665351FAC23
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132363; cv=none; b=gaWlHEyhI8PkOfG4xEFdAjpYd9GTY/eVw3LOKheTYKmdKSLBwfm4e3xMRrCSs8JJvYzOiEozjxJjQP9si2uOmSuVgdV0dPt8gFq/nS65RLkhKXckyW+1HUV/uA7R+bpI+Fe8xCtJZ6eAup4tNrxu4Ssn1JJgzeqsPpQgKktazJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132363; c=relaxed/simple;
	bh=VL1KAE28nssjYWjZvlVI4JLKfUAWqTlZMvB6PovT+/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESLlGcwI69gtBzcsOIb6YyBeJvM2HtRJ4W2bVeUPwOAnylwuVYxBHOHBw/A0KVI9gRo2i1rmtot3iSlqkDygXFnFxdV+QuyC4cqV9PhMdrugjOiqwSTuJXr1JST/rLy7xS5+JK/dtzV84pi7TV9KWI/ZD5+tffqSJpfeMmo/Zwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=REFzj3s4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733132360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXg0dX6FeYyew2ZHmmklA2y1jYBIMDkn+gpJsFpnrMs=;
	b=REFzj3s4kUCK8VaWDshhmCGXPa6nZVM+RholOhkuoi5Lx1aZKnQ0d3ukE+lNMh5sf2JSAd
	J4ouZ0wAvmolLpVVbHYXwMLSqKqjv6BPPSgLcIlN23D1ZSxT8FSm6XE45cpMb28yK7gc04
	cfzQZ4Q69rbWhw8x+yIqKnW1v3nREj0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-rKAeGhnhPbK7VWJP9471iQ-1; Mon, 02 Dec 2024 04:39:19 -0500
X-MC-Unique: rKAeGhnhPbK7VWJP9471iQ-1
X-Mimecast-MFC-AGG-ID: rKAeGhnhPbK7VWJP9471iQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434a04437cdso29770365e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132358; x=1733737158;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXg0dX6FeYyew2ZHmmklA2y1jYBIMDkn+gpJsFpnrMs=;
        b=Rn/287tJsPFK1s9xXcKpRg1CPvoqK2xejpnxUX2nz63WsuPR7RdVkPYftHf8kmB9Yp
         ly/BJu6t2g9YqWvcnyVu6rRw+yFWeEZI7FjW7q4yrj/F4FGEvFo1Dim9uAF/jXcm6NLh
         IirLx06Tz8SREeVSbOrY7NG1t958Y28aixcYPtSMgIC0C6CVLM1WGpkKelh3j6qPO4uQ
         8nMt1gY1SYOKXsKY434slBGNshEoZDgtroTdFkNdNP5OskKeoAblXCCAuSWbGnMDmr+U
         U0KdcveY+KQLWY1JWuXHKpB9PoTSnbv/503HglDZ5l6+v/olNR49j9Pwu681O8o2giEQ
         t0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXjEowDxb+SneqX/F29h7h/vmW1wpFubdLjktNm1DKje7yKFI1GAFKx4UOG3RZoUoIm2y4arAshmiQAM4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBJ85+Nwp7iUceKlE1L913USFLQnIjKqR7g0dWiOybnxoMq+UX
	bxiL//RPb3U5JomgOkctOfKiLisZJqc+KMfl08Coa4zNu54Mv7Ujx8lgL2D0RpSte7SJfjO0uxD
	z5xRIC2Fw3VqdoUaGBeACFtHe4Lb7HFZ5srP9jtCy1KKP348etYo2XP6rtMGjJwDN0d/+Yg==
X-Gm-Gg: ASbGncu7B6cSuJwK3MV2LEbcvnuyQSz5rF107P/9JMUZMWG16W9GO9AMDsEAucJLBFP
	vnK4IxXjVzDb13s5OBhmo9DQM2it8nPz7IyLBgaJTTDfXvD8Lhs2xVaCXrwdMORj46UInq2Fu4r
	Cd06ke1SLDc6Hf2TRbxVg6IlphMAohvXvzwDH6u8vQRnJwVVA2hNvWNqFZOw87hWtEn2AWfkdIe
	VcO+3h5jz5oTvQ3Wv1rppVsOaRHoLyxfS/W6P0XHTJfbwRaKmL7yu1ySsiMN0N8urGwpvSo702e
	A1U=
X-Received: by 2002:a05:600c:354c:b0:434:a5e6:64f6 with SMTP id 5b1f17b1804b1-434a9dc5026mr188275745e9.11.1733132357673;
        Mon, 02 Dec 2024 01:39:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkgova0C1qUvfS9oK+GdfWOaRSM1JljNck7x9igRHWEpZoQOOADjVo+TnZfNXEZhYdN5sizA==
X-Received: by 2002:a05:600c:354c:b0:434:a5e6:64f6 with SMTP id 5b1f17b1804b1-434a9dc5026mr188274585e9.11.1733132355848;
        Mon, 02 Dec 2024 01:39:15 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.75.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm176375865e9.37.2024.12.02.01.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:39:15 -0800 (PST)
Date: Mon, 2 Dec 2024 10:39:13 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH V7 9/9] sched/rt: Remove default bandwidth control
Message-ID: <Z02AQe4iUsOTYa-4@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1716811043.git.bristot@kernel.org>
 <14d562db55df5c3c780d91940743acb166895ef7.1716811044.git.bristot@kernel.org>
 <d3bllrfwji74t3ix3jcdlvdt6jdorw75wjol6kmadpeuuqal2t@io7ghgf7zkbs>
 <Z0c8S8i3qt7SEU14@jlelli-thinkpadt14gen4.remote.csb>
 <tjsas6vkv3xegcgmranxmnkrt46xuitp553caz6vvtgpfrbwl3@252nbydvxaqt>
 <Z0nTZXHDggHD8raj@jlelli-thinkpadt14gen4.remote.csb>
 <2aqeakf4rbed2hnt46yvdospzntpvp7ndrk4xnv6rrh7ctijes@d3nzwnguheju>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2aqeakf4rbed2hnt46yvdospzntpvp7ndrk4xnv6rrh7ctijes@d3nzwnguheju>

On 29/11/24 21:21, Michal Koutný wrote:
> On Fri, Nov 29, 2024 at 03:44:53PM GMT, Juri Lelli <juri.lelli@redhat.com> wrote:
> > You can disable admission control by echoing -1 in sched_rt_runtime_us,
> > but still have the dl_server working for SCHED_NORMAL tasks. By
> > disabling admission control SCHED_DEADLINE can indeed monopolize CPU
> > (over subscription).
> 
> | I'm wondering if different values of Δ mean anything or how they can
> | be used.
> 
> Aha, the knob therefore remains relevant for the DL admission control.
> 
> So if I put it together, I will write it down like this:

Ah, yes sounds good to me, thanks for writing it down properly! :)

If you send it out as a separate patch, please feel free to add

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri


