Return-Path: <linux-kernel+bounces-429203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E8F9E18AF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97C41659F1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51841E04B4;
	Tue,  3 Dec 2024 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="InEn2InG"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2D1E0499
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220117; cv=none; b=GQQjeGCHfsZHqOEKTtwnsRxOcZoVlxfwrMYERDF+jMs9qPnZs7iWwQL7HNaH8RfhOXWMYihk/Rr0CvtPhD7ixxfXRaaNajEjPmc/TDKoC5mbSiAUGIObbS2OzTm4j4yM5AvzdCiPZur6Kw7VKwVjQ59ga1zYMonYqidn9Vfgm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220117; c=relaxed/simple;
	bh=u3Jt9s6RfY+zcb5GxXzP8H7fgAopZDnLmuUt82FHZzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhURd4p8h0XcFogEky0sTE2iTeTV3CL5pnfexMQHM34C9zSRkZG18agJZjJV30yQl7yogwbGXBScaeat1ET9VoS3vNIoyeamT4AwrLOrfExroRuFYsjGuIbbUdFiIjirMOzjos6BWOiljCYEBZs0RdtvsezOn/N7HGxJegwBKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=InEn2InG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385e2c52c21so1961302f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733220114; x=1733824914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=94lyGAg+T9h5Wb97mwGuy5lSICPbI04Wnq5QT8dG5h0=;
        b=InEn2InG62x2fY6AlfXv4CTyh9FwgoXhLL+OJQ3YZ8CpFLK4eGhvz3dRW21wcgwpj6
         yK1NvsgffgkPzws38Nbf6WuCgxIEB8LCcmFDlW7Lfb48kqvvikgrZk2/lbCE81CbUAW5
         M8gv//IPnO5maaO19MTgGPC/BDCPYqAYJwfZetLWb6YKTMUKlZWWolWksesCw2nzPCuk
         mnTLIqNzT1r2VZhUMw0m96sr2tcjmm1v29RG78JGUNskzIRG7jJw7rfw2EdF4WGreN4g
         oGMpzHHaqPoVKfKMfKmlddar0LxYz4B2QhFB5G9QOOpD8Cld17UjAX1+VI+8lGibvaAl
         sW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220114; x=1733824914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94lyGAg+T9h5Wb97mwGuy5lSICPbI04Wnq5QT8dG5h0=;
        b=a228Oqp/DDVtDmwX5XmfEZ46DZrmqTMivzMzboEpRCgfLhKs5TdW0HjuUQLCJeqxpP
         qyomExr1+WgwrunJ3Xd+ncWAIzc0jbYuEXXbwTsYjWv4D1QuDzUZuJ6XM+fT5MmURHOD
         TAD1FcCNtTsAluQc3/KqEoYZermCy9kiHRW2II3NvUIWnAEGFuVrbun7Q4g6oYNJB8Q2
         eQLdOCQC3IgFwJa7hsazt+K6NAZSclG2tbhJ4eaqc/fKWas90iQ8BGXyPRcG8K+FueIy
         NUWftVvcWdMmA3wzXanrcrGMFdZrqDRlXfhH/VI0ZTGV4kP/MH1CCVUxztwNDWSp2hbZ
         qKmw==
X-Forwarded-Encrypted: i=1; AJvYcCW2vpuwy4Ke/jHBVxV6mDwaHO6MB+Ze20H31RfpqmQBcFci1acZsN/ogMzmEC9kd2Y/Z3RAUxQv9Kb2/EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfIzdE1FDowi0n8inyhedjXTTb1Wc/FoCJc51OcTMiB5jyE1Sp
	3mB9khVRK5h2nykNmGNpFCEx9+7cJekKUH6xD07hzNw4CBpO6eqJwwKTcxVKc2w=
X-Gm-Gg: ASbGncvIV+xiV2GtyzgnKIAew/JCL1BXrbsNvkDLowMCrNJBkxqN8/U53jtqP4GBEtO
	4r/qIa0UFi5N11n6jpz/NfRHCf+pnjnhM0pp8ow+2HyHN8nO2JpyeNYISXLYidOPIccy0nnO5dP
	09ESDBGlGnatAtIfz2dAvlV8tf/XP1Qs6hheYo3I6j4PqUxLa/QJLnGHsN7ylW8xv/eCCTt2dqG
	LXC2hDbDKYmNgBYG2b1Iq7t1veegxb7B4ajc1BRbDc7fx/ey/Yv
X-Google-Smtp-Source: AGHT+IG6NWJE5ZESoebm9qL5bEsfki5rqRtBotVn0tVzHvwLFMY/sHdnZP9ok9qHtBpSKQV8cQjtnQ==
X-Received: by 2002:a5d:588a:0:b0:385:e328:890a with SMTP id ffacd0b85a97d-385fd54dba9mr1908620f8f.49.1733220113630;
        Tue, 03 Dec 2024 02:01:53 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e30c54bfsm9885091f8f.110.2024.12.03.02.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:01:53 -0800 (PST)
Date: Tue, 3 Dec 2024 11:01:51 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, 
	surenb@google.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] sched: Fix cgroup irq time for
 CONFIG_IRQ_TIME_ACCOUNTING
Message-ID: <os5wmuytn2hg2bhbb2x4j3zzj6cpqropgop6lhwlxwqh2ufise@2pbrsxjyt6ct>
References: <20241108132904.6932-1-laoar.shao@gmail.com>
 <20241108132904.6932-5-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o3rmhbonm4iv5daf"
Content-Disposition: inline
In-Reply-To: <20241108132904.6932-5-laoar.shao@gmail.com>


--o3rmhbonm4iv5daf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 09:29:04PM GMT, Yafang Shao <laoar.shao@gmail.com> =
wrote:
> The system metric in cpuacct.stat is crucial in indicating whether a
> container is under heavy system pressure, including IRQ/softirq activity.
> Hence, IRQ/softirq time should be included in the cpuacct system usage,
> which also applies to cgroup2=E2=80=99s rstat.

(snipped from cover letter thread)

On Mon, Nov 18, 2024 at 08:12:03PM GMT, Yafang Shao <laoar.shao@gmail.com> =
wrote:
> The key issue here is determining how to reliably get the IRQ. I don't
> believe there is a dependable way to achieve this.
>=20
> For example, consider a server with 16 CPUs. My cgroup contains 4
> threads that can freely migrate across CPUs, while other tasks are
> also running on the system simultaneously. In this scenario, how can
> we accurately determine the IRQ to subtract?

I understand there's some IRQ noise which is a property of CPU (noise is
a function of cpu).

Then there're cgroup workloads, on a single CPU impact per-cgroup
depends how much that given cgroup runs on the CPU (it's more exposed).
Whole cgroup's impact is sum of these (i.e. it's kind of scalar product
between that IRQ noise per-cpu and cgroup's CPU consuption per-cpu).

(In your usage, there's some correlation of IRQ noise with CPU
consumption).

> That is precisely what the user wants. If my tasks are frequently
> interrupted by IRQs, it indicates that my service may be experiencing
> poor quality. In response, I would likely reduce the traffic sent to
> it. If the issue persists and IRQ interruptions remain high, I would
> then consider migrating the service to other servers.

If I look at
	52b1364ba0b10 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ pressure")
(where it's clearer than after
	ddae0ca2a8fe1 ("sched: Move psi_account_irqtime() out of update_rq_clock_t=
ask() hotpath")
)

the IRQ pressure accounting takes into account the task (its cgroup) vs
IRQ time (~multiplication) and then its summed a) over time
(psi_account_irqtime()), b) over CPUs (collect_percpu_times()) so it's
the scalar product (squinting) I mentioned above.

Therefore I think irq.pressure provides exactly the information that's
relevant for your scheduling decisions and the info cannot be fit into
cpuacct.stat.

Or what is irq.pressure missing or distorting for your scenario?

HTH,
Michal

--o3rmhbonm4iv5daf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ07XDQAKCRAt3Wney77B
Sd6IAP0dnUXEFZ3j/R5XpoNAHYnRX5ENYOqGuG1NB3+bwmP4QQD/XSfg6aRKZsyz
x5GW03vpepgF5LsF5zhTzCVjSQd/ewU=
=PzNP
-----END PGP SIGNATURE-----

--o3rmhbonm4iv5daf--

