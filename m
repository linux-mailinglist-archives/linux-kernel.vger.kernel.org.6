Return-Path: <linux-kernel+bounces-241759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A64CB927F40
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222481F22CBE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 00:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC3D81E;
	Fri,  5 Jul 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="2VA3ggtW"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE67F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720138261; cv=none; b=tQlSjJVomBfJNECPX7tE4vHEH0MLu13RLU/7a0XgAtjsTn1YyKZa99tNT6H8gTpIGHoJq0gp2jl3TBr5fqQnmH/S69doGORc9CQTcFvfKlSMUtt82v4CaDfURZ0Ug0t/l6M7zEzT3ngHmttQMXlD+qgVDgWkAZxN+fASdazTyLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720138261; c=relaxed/simple;
	bh=nP53y8Am6VhQFBiejVxO9FDtAVOQlqSyg9MYgijUSLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1+LNMM03nfO200rWgvQife2LoJ9mWcnof5GDZx/pli44qZTT90rorx/1gnK8GVZICMXleQ18Ofk5IAZWvDm1UqILC/vjkGaWcFfDk0CYSuSwxQIkZgqiiHSjWNn4WH/Z2Mc0ktY6uinzdyBV3C/8PiJsl99K9bI+0BC5T3osCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=2VA3ggtW; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so13062331fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 17:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1720138257; x=1720743057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwAGi3M2PI5hOF0tUUvcLHpg+uLTNB+d46/mvMXrNlQ=;
        b=2VA3ggtWDvcc5GCRc4czd450DplKyskTRCpcpKBk9vHBNVmdhNbQlFlolqu1sgC/5Z
         ktM3AUsi48i09esdDoU9Kr443FJ3XQS6LIH7A74xqqQzla/J252VN8q7q6io0hIDQjB9
         xZmsiTkca9FL09RabvXZRB84xnCl+fm2LV5v/ZduoHMggnWkQ2O87czz2ZCTFFbNCm3K
         FZ9gnhCQZ66/tIF6JFHFGzpEzBXiXe+1q9xaHV0905pRWPnS9SIfLcAhGMWdMPqq1iU2
         lhecxFSzdwxcQz9+Acrb1bgzJrHQXbXPLJihhcFyQVoTe6Y6ylCJ8byGIq90D6AuYfJx
         vzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720138257; x=1720743057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwAGi3M2PI5hOF0tUUvcLHpg+uLTNB+d46/mvMXrNlQ=;
        b=JFKchlKDucI8Kgb7QX+Po/Hcdtk39pmJrNAc/0BmSeq2C/9zjZh9QsuXZAInwwPAy5
         bJNzpuNQqN8xm5cujSDmdQQOWecIpwCnGipmin13x8SmB0tDZq1Q16cvYQ86AL0EkW1m
         ylZ9PH1d+BdR40jKFlCQ2IMK/5D7JxsWQZIAVAH1WUBP671kZaKilBua7kAdlbclk6JH
         /GkZhTkWpJHc/qmdPLnBfa/iXkpdeGIO4uCiB9Q3loehA9XECI5hLwOcRNcC8E+qFKtX
         uhiu3xUpLB4G2SfJ5jc77XeaOriiD26t47HwQs6LIOBYW3B4q+Ca2Sxj40965oqTIgKo
         B/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVszt2rGjN2c7Zu1wu/CW+iTjQGXEkCCevXAjd9NAzSu4QkRCf+xblX8llJyTm8RmtiFOkRbpTjcQNFbTBHpQYRYDh9TMYzE+xP7Z+a
X-Gm-Message-State: AOJu0YwqT1I5s9iCR0yni5erB8bqAHPOW9bSAYCnt+0qn/x+Z3jctWxg
	jKOxzumfB8Ea7qrOFdm+i6A3gTesgw0YEkfgNqRShUe/2ZlrxzrMIDrnI7vDJoQ=
X-Google-Smtp-Source: AGHT+IFEfRcZxHwC3R8SifjjyD31CxKc/yiPtXAwWtwIxWcILp/Ghg4JqhPcawNH0ens0qkn6yPu0A==
X-Received: by 2002:a05:651c:1713:b0:2ee:8407:2f58 with SMTP id 38308e7fff4ca-2ee8ed5ede3mr19931381fa.17.1720138257005;
        Thu, 04 Jul 2024 17:10:57 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a1805e53sm1998558f8f.22.2024.07.04.17.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 17:10:56 -0700 (PDT)
Date: Fri, 5 Jul 2024 01:10:55 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, christian.loehle@arm.com,
	vincent.donnefort@arm.com, ke.wang@unisoc.com, di.shen@unisoc.com,
	linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>
Subject: Re: [PATCH V2 1/2] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
Message-ID: <20240705001055.khior3se6ypklbqx@airbuntu>
References: <20240624082011.4990-1-xuewen.yan@unisoc.com>
 <20240624082011.4990-2-xuewen.yan@unisoc.com>
 <CAKfTPtB=Yk8Bp4sSanr4fCdyWA9PVROM+uiWsQSh+QjFpKb+Aw@mail.gmail.com>
 <CAB8ipk-yAoX5EJ975ZVKfgZP7rP-vzuc3bLVr6yiLtMv26Lxjw@mail.gmail.com>
 <CAKfTPtDuuF8XX3gbsjF_Vgys2UtbzwtaX9QFgA-3kZ7+eqk02w@mail.gmail.com>
 <c4eaadcd-e563-41cf-b174-cd0fb4453c6f@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4eaadcd-e563-41cf-b174-cd0fb4453c6f@arm.com>

On 07/04/24 19:01, Pierre Gondois wrote:

> I thought the EAS was comparing instantaneous power and not energy,
> i.e. how the energy computation is done:
> 
>   *             ps->power * cpu_max_freq
>   *   cpu_nrg = ------------------------ * cpu_util           (3)
>   *               ps->freq * scale_cpu
> 
> cpu_nrg should have the same dimension as ps->power (i.e. energy/s).
>  From this PoV, the energy computation should not take into account how
> much time a task is expected to run. But it might be a side discussion,

I had this discussion with Quentin recently as I indicated in another reply on
this thread I think we do have inaccuracies here in terms of how we try to
represent the running time (or busy time) of the cpu/pd.

AFAIU this is supposed to be computing energy, but we don't explicitly multiply
with any time value and there's an assumed time multiplication with
unspecified period. Maybe it's PELT HF, maybe it's something else. But I think
we do have sources of inaccuracies here, but I need to analyse and dig more.

The cpu_util/cpu_cap, or sum_util/pd->cap is assumed to represent the
percentage of time we are busy during this unspecified period

	cpu_nrg = ps->power x (cpu_util/cpu_cap) * T

where T is a constant value of some period, hence it is omitted from all
calculations. I'm of course thinking this is not best; but sure keeps it
a 'simple energy model' :)

I'm not looking in this area at the moment, but if someone is, it'd be great to
consider the impact of this properly.

