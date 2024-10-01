Return-Path: <linux-kernel+bounces-345654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54F698B8CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563C91F2276E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2336319D069;
	Tue,  1 Oct 2024 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdLn4AH2"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A298B1A01C1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776812; cv=none; b=qfime59TH7Hl5za9EPplkl9GOD1KHtHdE5E75dAIX12jCE5ZFjPuvul2ewe0whot8t7nfnqHNR1zoptnCsaNaMjCfbciR0vKMuaskfSLC/sEHUkFmw7FkufP+OGqfQWAhZ2+ad+7QrqUonS0fHvaoyYI+A3LCmkdoZhaTQLoAu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776812; c=relaxed/simple;
	bh=chVTHdhd0gDdOEdbDvm09Wc61YsjZvYCuI3ACeLNtaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uemh/ksz++tNiamqFNqRuOGgiqr0ly/RecPLpZp2wl06lgcxsvgd1H62gcOJTIpyTnvuO/iwiNjnPehJ/VVU2HOcM5tSo4G+C+8agBa+NwNKrtti3ciHE9Cpui4QVqsZj+2iPoi2LASB9VsxIjuhfJpea1FIkH4cStVtwIFMpU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jdLn4AH2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b9b35c7c3so16080225ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 03:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727776809; x=1728381609; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fgo6NQBG2E2Q+wVlE8fJfIpF8d3CXP6kqHrR2eYck7Q=;
        b=jdLn4AH2yhaPnkhvuJkYyoy7UhKwYHYEuipeyeUz/e+UmUHxgizXe2AkyOeb96bY1b
         oOSKRbsP0a5cO721/iywbuUXeYwugLdio7jNyGeMFwOg95gAo4rXwY2m5K6ipVejl0e8
         ZVXjXUr9nJkoKh6KLxx0gELqoJkVqZC/ZCeFJ690EAjIw98i2rP6m1O3aUSTYSzIIGKa
         nSJbD4sCyqMTOP8lLeQEtCbo6vy/fpoCNixU4saoZN9xnM1B/s4e8NylST92En2nkAWX
         +E+CigiRe9qdS3zXOH12ougYGOiQTtDn6X4nHSPsPn0UZUn3mYJfBnGKGXyg4cScKXyS
         iNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727776809; x=1728381609;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fgo6NQBG2E2Q+wVlE8fJfIpF8d3CXP6kqHrR2eYck7Q=;
        b=fPXnUhCWO71tVuhvQn0gAkJ78OkVs43PfUBSAlrWjIRXU9wi5aVXuZCj/T1L67bZaU
         o6h+c/MnVCsaop5NmkLM6vKITZdotqDsZkR/QZuLy60UWgmDTrGpVnHRrIpME+WeUPzB
         +0fef7elcHLPNRitP5wRy61/0TVaRKLyvfRyMIxQBXogzKUpcL7vSmYqi83vcPKviGzq
         iMnrsyV2aI05IwrlbuYg1BOqlKRN3U9gZgiQk85ua9A6zOjGJRaXHEsRzSk17jWJGpdr
         uhoFG/xcu2s3HxcWy5g2Y0TIcD92m+LNRLhC30VXAJv+pW6ISZABPUcX6c1asg1ACzgj
         dXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4O3fTkgDqbeLo8OCUKTgzImETs28uumdAr4dCY8wkmLaMjcj4xHGnHZg+zX07Lw4zjdC05SR6U6jifcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb6CZA+oSgTgxAvFW21RU+eXLfHayp7vaw0TR5cH0APHNK/kJL
	x9StzwcOfuV1E1+DGLuILiUByUg4w3v4XWfFPEGS0Bdm8Lf52j1qcI0yVnlHieQ=
X-Google-Smtp-Source: AGHT+IG/DI2UjrjSYePkW0ACa5mp6kJ3VOpU6rqNfNhLfoLoPo6XSArOKM/sBe5dyxG9nqD/EHVSqw==
X-Received: by 2002:a17:902:e74f:b0:20b:6457:31db with SMTP id d9443c01a7336-20b645736a4mr144453445ad.30.1727776807347;
        Tue, 01 Oct 2024 03:00:07 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d596sm66955565ad.166.2024.10.01.03.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 03:00:06 -0700 (PDT)
Date: Tue, 1 Oct 2024 15:30:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pm <linux-pm@vger.kernel.org>,
	Qais Yousef <qyousef@layalina.io>,
	Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH] cpufreq/schedutil: Only bind threads if needed
Message-ID: <20241001100004.nbok7s7zmgbcmqnz@vireshk-i7>
References: <480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com>
 <CAJZ5v0h_AFNe2ZynDseE7N_5U9DV4NnLEhw9w=ErGuBswfpWow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h_AFNe2ZynDseE7N_5U9DV4NnLEhw9w=ErGuBswfpWow@mail.gmail.com>

On 12-09-24, 17:41, Rafael J. Wysocki wrote:
> On Thu, Sep 12, 2024 at 3:53 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > Remove the unconditional binding of sugov kthreads to the affected CPUs
> > if the cpufreq driver indicates that updates can happen from any CPU.
> > This allows userspace to set affinities to either save power (waking up
> > bigger CPUs on HMP can be expensive) or increasing performance (by
> > letting the utilized CPUs run without preemption of the sugov kthread).
> >
> > Without this patch the behavior of sugov threads will basically be a
> > boot-time dice roll on which CPU of the PD has to handle all the
> > cpufreq updates. With the recent decreases of update filtering these
> > two basic problems become more and more apparent:
> > 1. The wake_cpu might be idle and we are waking it up from another
> > CPU just for the cpufreq update. Apart from wasting power, the exit
> > latency of it's idle state might be longer than the sugov threads
> > running time, essentially delaying the cpufreq update unnecessarily.
> > 2. We are preempting either the requesting or another busy CPU of the
> > PD, while the update could be done from a CPU that we deem less
> > important and pay the price of an IPI and two context-switches.
> >
> > The change is essentially not setting PF_NO_SETAFFINITY on
> > dvfs_possible_from_any_cpu, no behavior change if userspace doesn't
> > touch affinities.
> 
> I'd like to hear from Viresh on this.

Looks good to me.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

