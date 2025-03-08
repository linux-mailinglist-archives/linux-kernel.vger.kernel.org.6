Return-Path: <linux-kernel+bounces-552846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58045A57F5C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 23:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D6316DA51
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DD11EB5DF;
	Sat,  8 Mar 2025 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVXR4FB1"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAA519006F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741473545; cv=none; b=r530EB4apD/WpyqKTYNwP2mH9V66XAaBVcXEskBQYi8iZTO34sv59ZPYPJZm4wr330R29zLyoPwv1LjxZv+PdVJDJt//A56G+n9FiAmZhG/b2e6y6EOzQWGsSglxSo6a8TKyokXik0w/yt7kLWYXNP6LbS3AhasT2N+P5mMDlT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741473545; c=relaxed/simple;
	bh=qQ2gt7duVoxoCXPiSaRWKdMzeq+6kQJO83giNgRY8RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trbPsYNnkwk3rXtEobHyqbjuAg+ebshUc/6B/F7/V6svQnCuZRXjpVkC280vwqTT5SNqk9isEahI8RbV44dEsaqGVTvJ45p5+k0F642YwNCU7OTRWcct3B1tn+kXSNCHy8UZ9cpD/C8QYyYSBqE5WHvfcLmug214UWblLwoNP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVXR4FB1; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so553072e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 14:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741473541; x=1742078341; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G06SGv4GweN16TZkskRsMVNAONyGavm2HmhknCI/78M=;
        b=HVXR4FB1hWLu0W3T3K/o3WknPOEiC7CEqxiByiQ5K4Z7UhYQLV3a+ekx6nyyZguQ+V
         ObIfZLoC76gRpu7VqM+SZgUGae2CqQuN/PARssfUSoaazS4RM3xs3uit/RXpZJyuspmq
         w0qSsern5NTONu3QoK+PlW1iMhUY5jumLgY5SaSsgspjA1LzkCdFpudJpDyDbHtPdkeR
         roim/t1kRz2ZneHNew10vtGFoGUm68BEZtrseKTMz6kAjeP8Onep6GEl6/Mrx8EqRTBz
         LkhJ9Quv/+bglU5j+W+cSn5aaUCxaon2ZKKPBj3hmM3NdheJq7PR2jLC+UTTPIGAdta8
         3+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741473541; x=1742078341;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G06SGv4GweN16TZkskRsMVNAONyGavm2HmhknCI/78M=;
        b=d4vi/4AIAXtPOqy4YCKGZXPSIacrJgA9TJdgcgvRe4DxqzF9W/v79Tm6QVdR1XHrOj
         neT5TyhGbDrnf1xudWT8sf1FCvCSdKu5EOpfAgZTftSRVgPExZDE++yNl/mqqjLGL4+o
         HrBwZHdRCc8LhcszIUptMOaiV/Hw3s+2xC0PySoLVxqEBppubMbnObd8il4Q+VaFEyCO
         3308+3p9J5KPVR5MuwcJbu17C1MhGTb9r9UF4LxNotWIIj0D+tZbH1P/Mv1pFKr03hKN
         5YcoVWUsgdmhV7Uwo1rrl2RkVVyWYYMZiF9HmibFD7o5NXGbUNwXyEH/JE1KHfY1LxDU
         iy6A==
X-Gm-Message-State: AOJu0Yz+7b/dmusS/MiIlQd0CkCtRugvAer4udwFbnbndJtciL3vyqiR
	F/vR2MAwbVP9exlQlNd27ZAGXmsARhlRSLPy7lWLqYJBOeCTt//p
X-Gm-Gg: ASbGncsrTENN/V/B/ZKe8VxLUXjpF3S20zthJU81v1CLusTvhQlnvp3TLUczHyol1Dy
	UlNUbI3Csg1XpN8uVKTBoGf5Fdd9Vxq9I8nWlcj0IMDa6ohYzf8U8j4FvKO32yYTxy0RH23fEoj
	RPfbYWXi67dBELsVSLZRMKD+Chf26abbdP8zBXFzoeQ0jjJeqC6/s5XxYKn7zB6O/HYi2aisbh7
	ckzVR2bcfDgZXD7B2r6MfduSLpyuohvndaptEOAC3gl5NCayMrVi1zKg7bdi374HyleYGc+iGd3
	TAbO8R8eAD4wi+fmEaD7LzfQIJywvmKl/8VdqkW5j94L8Q==
X-Google-Smtp-Source: AGHT+IFK+ZTQdP+mU7Hx7M+t/fhphhUi+ODz78UMU6WJXFTf/aTYncv4uaZUYHC4v7kXLjJOYJD8RQ==
X-Received: by 2002:a05:6512:3dab:b0:549:5b54:2c66 with SMTP id 2adb3069b0e04-54990e66e8cmr2935247e87.23.1741473540007;
        Sat, 08 Mar 2025 14:39:00 -0800 (PST)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1bc369sm930079e87.177.2025.03.08.14.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 14:38:59 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 3FFF55A00A4; Sun, 09 Mar 2025 01:38:59 +0300 (MSK)
Date: Sun, 9 Mar 2025 01:38:59 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V3 16/18] posix-timers: Dont iterate /proc/$PID/timers
 with sighand:: Siglock held
Message-ID: <Z8zHAwpFDECRYVC6@grain>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.465175807@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308155624.465175807@linutronix.de>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Sat, Mar 08, 2025 at 05:48:45PM +0100, Thomas Gleixner wrote:
...
>  
>  static int show_timer(struct seq_file *m, void *v)
>  {
> -	struct k_itimer *timer;
> -	struct timers_private *tp = m->private;
> -	int notify;
>  	static const char * const nstr[] = {
> +		[SIGEV_SIGNAL]	= "signal",
> +		[SIGEV_NONE]	= "none",
> +		[SIGEV_THREAD]	= "thread",
>  	};
>  
...
> -	seq_printf(m, "notify: %s/%s.%d\n",
> -		   nstr[notify & ~SIGEV_THREAD_ID],
> +	seq_printf(m, "notify: %s/%s.%d\n", nstr[notify & ~SIGEV_THREAD_ID],
>  		   (notify & SIGEV_THREAD_ID) ? "tid" : "pid",
>  		   pid_nr_ns(timer->it_pid, tp->ns));
...

Btw this nstr[notify & ~SIGEV_THREAD_ID] has been always fishy since ~SIGEV_THREAD_ID
doesn't give a proper mask over nstr size :-) It just happen to work but if for some
reason ::it_sigev_notify get screwed we will get a surprise. I think later (not in this
series) we better provide an explicit bitwise mask here.

	Cyrill

