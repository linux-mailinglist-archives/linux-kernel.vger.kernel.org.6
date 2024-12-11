Return-Path: <linux-kernel+bounces-441608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E1F9ED0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A363F162269
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4B21D8E1A;
	Wed, 11 Dec 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KkRguggI"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F3195FEF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932957; cv=none; b=nuGknf1RjzjEfBmVZD+l4Zg0u4Hru+S05sHGpjQowjj6uu5M2Dhg75lLY9y22aCB9b4t1bQy/44F598YSYOzlBier/rxrymf2xy9V6CtNMbfnuRQeY7JwRdmFcjwG4CmHFBdEvHZZ9JnIn3r/IxlqWgsSoE+0kaDfwvO2GSD0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932957; c=relaxed/simple;
	bh=22m9Hqe7UwQ03I8qCrH/Y8yM7muurEK3JAYeyu895HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0TrxNjmKZD8keNxyby3nIz56BnNt3DYUnLLo0rYFZ6y8eFc3xFHKZvAhGT1qEkFHVR1nsgzgRQOqGIU2nPMk5LvsCFvMXAxgOpZiDvjdRxkGiHOa3MKpNiu31q0iZGp+eIFKnR6JTnwNWVQYPRiXj/S+kL1cy1hIYGdj4pvTQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KkRguggI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e0e224cbso3513722f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733932954; x=1734537754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=22m9Hqe7UwQ03I8qCrH/Y8yM7muurEK3JAYeyu895HQ=;
        b=KkRguggIF9oJNUf9GPmRPvwNbExRMoE0X2J7NKM/5e5YLi2ghlqPB901PRFZE4m19Z
         OcomBwfxQ0jcHRfz2P5AJZjaXY39Nm4JCUv7LJNj+iX4w1Uxs2C/AbTXlyQNuIGoVbR4
         0l80RWuPlHDLvJ04+yQ2Ei1W7gW5kbpcte8+1YI3UADwmCXObGbs4w5JfoNUIB+A9l7J
         QO8pJfgk6to95KCfE98UWrAar0IHOUXFIgR3DXd3hExWEnpjZPcvAiIf9L8ivkhxxQ67
         y79W2xFUWJ8aqQbcbh3tyoz6OXg6+yf2HkLyzc45nzy0+NMWr8/oNlfhKznLIKE6mjPh
         RaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932954; x=1734537754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22m9Hqe7UwQ03I8qCrH/Y8yM7muurEK3JAYeyu895HQ=;
        b=ElsdPDbGsCPPU/jZXDy/LA3SF0JYFIlo4yM60vxZJXhEJvdJoxBQdR9lWu0RLWBU6N
         rnifnVemrCvcI0jaalZ3YIYaFYjeZXsS5U+lVE8uB5BjpLruyaHbl5uoF86woVa7pjCj
         Ks6c2EVkt2FTunN6MLUvPSLltxICFD9HJjgZk+z40Ra+NV0zw6vOA8ZEBN/XKqiswlBj
         wohTRPfedENz0VMlddGp/WkVgGo2Y1qdA+ff6UfAyozWwSwUgnxTKblfupPajS/Nttzk
         WqbA8WPyKik0p9N5S5NIPXZdYC71wTDZYy1vudOMReAgZyBOuxdWFNhpfiGUaKzPrEDj
         f38w==
X-Forwarded-Encrypted: i=1; AJvYcCU0juhW8X/xvpP5VeOv+NOq20DgguuIR4QDdoUO1bsTKBhErAjtL5eLOSCxXMSvDlPUYwQfPIshseTWPGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY98iwjViPoNubrtYZGEw6R6zzgjNmch8tFx0ADzetg+xYzNag
	wO1OY6nti+9Q2mVhzpNgrxrhbYY2i0e+GGJeFQfsxvGjZThKAOughBrent6B5bk=
X-Gm-Gg: ASbGncs0E39bTwSysdj2qR3P5tuCJu/wNuvYHJNL8cyhwFjfRDDRHRLhn2fdnTYyahS
	R/72dQ0LAS45qBtGnuOyW3gKQ6asWa5cnU6mo230HOZbTEEPqlofOS0+1E+uL9HLGckMaFak80n
	q7atlEk5uk7BTrC/fcSZ4mplYuOotdnGOPnHOy1+bCtkmADHEHTCwJHMeJyEmrPPfqSsLMP8Dc8
	kC2kNdhr7CRjoEtjGbS1CWr59yw2yOMMlineKnNt98936JRIvTfnTbo
X-Google-Smtp-Source: AGHT+IH28TTauO49D9CRhnae4582tXQC/DhGKODCAEE6KjSHtwVG8K+kWU2MVLOD4bfL62IP7MIxJQ==
X-Received: by 2002:a05:6000:471c:b0:385:e303:8dd8 with SMTP id ffacd0b85a97d-3864ce602abmr2797853f8f.26.1733932951931;
        Wed, 11 Dec 2024 08:02:31 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824bf249sm1584652f8f.52.2024.12.11.08.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:02:31 -0800 (PST)
Date: Wed, 11 Dec 2024 17:02:29 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, peterz@infradead.org, 
	Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org, 
	wangweiyang2@huawei.com, cgroups@vger.kernel.org
Subject: Re: [PATCH] freezer, sched: report the frozen task stat as 'D'
Message-ID: <j5kjjy5ibp2yw4zhaxc7jm5bw65we4oifhawlljvtjzdox5ck2@kdgpgawwr7kf>
References: <20241111135431.1813729-1-chenridong@huaweicloud.com>
 <xhsmhv7wrb3sc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <4f78d752-52ab-493d-8bf5-f12dc4f554c8@huaweicloud.com>
 <ZzYo19k9ZvkC7V-1@slm.duckdns.org>
 <2f755161-ec7e-4785-b0ca-ea68c01785a2@huaweicloud.com>
 <ZzajsLHrXXtYk04l@slm.duckdns.org>
 <3b03520e-775d-416a-91b1-1d78f3e91b1d@huaweicloud.com>
 <c56b2347-7475-4190-85a5-a38954ae9c08@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4gtmoob7ji7byu5o"
Content-Disposition: inline
In-Reply-To: <c56b2347-7475-4190-85a5-a38954ae9c08@huaweicloud.com>


--4gtmoob7ji7byu5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

On Wed, Dec 04, 2024 at 09:52:15AM GMT, Chen Ridong <chenridong@huaweicloud.com> wrote:
> Does anyone have any opinions?

When an 'R' task is frozen (v1) and it's shown as (unchanged) 'R' it's
acceptable.
When an 'S' task is equally frozen and its apparent state switches to
'R', I agree it's confusing.

Showing 'D' state in any case of a frozen task (like before that rework)
makes sense too. Please add Fixes: if you need to restore this behavior.

HTH,
Michal

--4gtmoob7ji7byu5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ1m3kwAKCRAt3Wney77B
SQ3XAQCY6+efIUgmD1GEW265e9Zu6yyIDhxzcZ4xnq/qNuVYlQEAkbW0YC7Nnl7Y
DpKMllh4g0NwWY3XFvALc88mhLrLAgU=
=uTyp
-----END PGP SIGNATURE-----

--4gtmoob7ji7byu5o--

