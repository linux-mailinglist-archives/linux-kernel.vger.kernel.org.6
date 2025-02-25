Return-Path: <linux-kernel+bounces-530309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94F4A431D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A7B189B659
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A6DC8E0;
	Tue, 25 Feb 2025 00:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="vDhJJHKe"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A03FBE46
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740443131; cv=none; b=tWQWHmCwSmoYV4YeRiJUcu70N4/y4dftImt3uQLKCa1x0Z/oNXp3yNMB15qM7g+oOKQSVIIMFii/AeCK+WvQFQJg+XXCDAoJszQYAI37diTvxwbFMCTyi/U6H2WFES4mokSy870kQkzOfeyvig+Y+YRyMCS0yZny82QtQtcRKJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740443131; c=relaxed/simple;
	bh=tvlajT8qWuDj3Fhs0Xo5MRHMhqbpNkMKTYg/Y3XZd9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYUDcCKFAaDOgLjIybsfRiRaaRUJNMlaGVDQGfSxlHnpKYzgJ6jzx9i/MBTXqHZYVQmrweyxX3S+LOKGwHi7PKCmpwKLVR9yvYRJqwbTAzrpPOegkJyCFRJi+yVYK7xK8ZHT/lFdy4A87cc7pXNdzksTVpHuTDnRPb+Q+C3LgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=vDhJJHKe; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e0813bd105so8534891a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1740443128; x=1741047928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kU+2XxQ2q9oYyVm6uQLEJLRhRkA4TUkmQFtp53frJz0=;
        b=vDhJJHKedtMgYs4xE88qMUMD0e1W8+le5mtlxrscrovokX7nI4fbZe481pEYlhi+0b
         QaWbF3mAQehq+uyvYBcNIHaTKJDnPv555wa+wqgtq8G38ITQTUv63e4pVPsa/5hz/R1N
         OY9YzQ8tWL5AgpuOSBkQWiYVcDy3Qu+SReainNS3BVncdry0f+EXif9eNS1T9JzF/lFo
         xErYRZO7HTkOGuHEamfIq8NM/kuo6dVWgdNsZWOZ6Lj6X2J/bTysfnDsApTsLH/egPCV
         6yhbkjF2jU0Nr4KrVyPJ01WawWoaWhnMIMUKSGMX0KFnEeZsuywpKSTZiqHp2acWsO9W
         7YVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740443128; x=1741047928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kU+2XxQ2q9oYyVm6uQLEJLRhRkA4TUkmQFtp53frJz0=;
        b=uqv2AXIW840c0IKfy4fbHc3TCOVggRHZoaOSz5iiiUzb5zvVEzQh3CUxATAvCrmytF
         ftDI7GIYolmlM5iodBVSBrFwhP39MoELCG+PDy7UBvH6B/qJVXPjx5P9TsQODvHTzZcm
         TsyNcpATmUieOQhjylIbgoKDNCvmC8KJ3w+cWS69D1ue/OuVZRaU0d2zy19yRe/sbZoG
         mPe3oNRspE8UYUmO2TuRPQz1WdIUVq6Y9qTsglPcTg0cWoRg9RUbzd9QdvbNI0cux1jB
         AvHtmUCjLuskwQvRprKXHL3G+hK/QFcltimn+cgRXhCsK+KKhpO3Bzanb9NPAZxfynEC
         JoZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUsr7uNjX9L2LXBn6KY8PJBZU4kk65W+GXVhmkxrQ7cDTu0szmUm3TerkEBdnz+mx++/tkIv3SOC6Hvds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrU+q3GEpbuWcdxUuteeN9mruJHjO2aWnwvXkQJv76s7mcXPpu
	eRxRNnRXjg0Fy0PPrVRvPXLefJ2nirxR7KL3ShkSEvmhUAh6a96NGzGCclp94Sw=
X-Gm-Gg: ASbGncv+Y9Xj2PmFsq45w5RgE/xHjbM3bYaT3/xIlDjvheLDyKO9smG+MAWt6D+dQpn
	Y3PZahRsWAuA+BEy242zKiG1Hu2zpQZXvLtLx1Vz2YV6fgMSiXs0Arym8rARqIDTmMQJcw1n0An
	e4pQiSL6eDri90W1POKBdNVZRM6cwwnWl9gQ8EhZNmOI1nu1wR0pmCf16IfKgTla+/ptJWdgwEY
	epELzd4ZQtw6KuF7gLo5Tr0oTOHozGk0HnJi8K5AIJ9Dt+2agHs1qbBjkD8ewxZRCebKUm+aVIc
	NfiLHcynVDa1xl7cGF60
X-Google-Smtp-Source: AGHT+IGYbtq4Z8afg6aY9/SHBdQ/mavEIiz0/hm230ExiB7J+bmVV5zpuDR5ltZB+TllS24cHKxLSg==
X-Received: by 2002:a17:907:60c8:b0:abe:cbc3:a148 with SMTP id a640c23a62f3a-abecbc3b1c1mr291087466b.50.1740443126336;
        Mon, 24 Feb 2025 16:25:26 -0800 (PST)
Received: from airbuntu ([46.186.201.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2013586sm44917966b.108.2025.02.24.16.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 16:25:25 -0800 (PST)
Date: Tue, 25 Feb 2025 00:25:21 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	zihan zhou <15645113830zzh@gmail.com>, bsegall@google.com,
	dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
	rostedt@goodmis.org, vschneid@redhat.com
Subject: Re: [PATCH V3 1/2] sched: Reduce the default slice to avoid tasks
 getting an extra tick
Message-ID: <20250225002521.t5w2deyyw6uqxo3r@airbuntu>
References: <20250208074821.11832-1-15645113830zzh@gmail.com>
 <20250208075322.13139-1-15645113830zzh@gmail.com>
 <20250210012931.ym337oexdcjmwwzv@airbuntu>
 <20250210091352.GC10324@noisy.programming.kicks-ass.net>
 <CAKfTPtCLg_kuRtknPsiLwRdKpvb4CYHqv+BRh5yJV8Z+o4oQcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCLg_kuRtknPsiLwRdKpvb4CYHqv+BRh5yJV8Z+o4oQcw@mail.gmail.com>

On 02/24/25 15:15, Vincent Guittot wrote:
> On Mon, 10 Feb 2025 at 10:13, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Feb 10, 2025 at 01:29:31AM +0000, Qais Yousef wrote:
> >
> > > I brought the topic up of these magic values with Peter and Vincent in LPC as
> > > I think this logic is confusing. I have nothing against your patch, but if the
> > > maintainers agree I am in favour of removing it completely in favour of setting
> > > it to a single value that is the same across all systems.
> >
> > You're talking about the scaling, right?
> >
> > Yeah, it is of limited use. The cap at 8, combined with the fact that
> > its really hard to find a machine with less than 8 CPUs on, makes the
> > whole thing mostly useless.
> >
> > Back when we did this, we still had dual-core laptops. Now phones have
> > 8 or more CPUs on.
> >
> > So I don't think I mind ripping it out.
> 
> Beside the question of ripping it out or not. We still have a number
> of devices with less than 8 cores but they are not targeting phones,
> laptops or servers ...

I'm not sure if this is in favour or against the rip out, or highlighting a new
problem. But in case it is against the rip-out, hopefully my answer in [1]
highlights why the relationship to CPU number is actually weak and not really
helping much - I think it is making implicit assumption about the workloads and
I don't think this holds anymore. Ignore me otherwise :-)

FWIW a raspberry PI can be used as a server, a personal computer, a multimedia
entertainment system, a dumb sensor recorder/relayer or anything else. I think
most systems expect to run a variety of workloads and IMHO the fact the system
is overloaded and we need a reasonable default base_slice to ensure timely
progress of all running tasks has little relation to NR_CPUs nowadays.

[1] https://lore.kernel.org/all/20250210230500.53mybtyvzhdagot5@airbuntu/

