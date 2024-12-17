Return-Path: <linux-kernel+bounces-449196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439E19F4B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A6B16F63E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A671F3D3F;
	Tue, 17 Dec 2024 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aWn5r3Pg"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A41F238D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440080; cv=none; b=m1JzV6k7JGm3LjjLt+CWVpv3LCigaerfSPKpaDca56Mws2FPiQ5AgVwWMB6IMHAKK11ACSDWiXIAj0uOyfrRHboLQl9LaCiI1nk3mcRRPxvZI9SAv/24tENIw5PVOvTRMY3883dMeWnic9yJhCofMmEbCkh96cUkBXoW4ZlQnz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440080; c=relaxed/simple;
	bh=enEM7izX+IlEaXtIAqMApARsvSAxsklzletXgpXLJvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q65w8bsnsCpJIlAoYcVnup0JD09JEG4mIBYeQDn1uyWOR/7pVVnfua4aIX2JWtfMULXPf1BWdqkpldQrJKql6hrl25o2xjUs2CBKFmq6ZpaEJB8A6eLhAvttySt/U2qAF9pZcjJWTcU6ACoLlRrNylmYs5nUB27KYKussjeI6as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aWn5r3Pg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso5685243f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734440076; x=1735044876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wNJH0bZIRp/lLbJRiuys3BD3sasknh5mv0Tb1tCrHk4=;
        b=aWn5r3PgcX+VuwKF1Qb4xaF3EGvbi5fUxCm2vWZOna3CZtgNfsNCOFduUlpkZYElkQ
         SPdqDxqgv3AAdJUPSIkvm/t4MvFlla4Q18kVdtvJsy9cOtmdX2Z5DQOoGxIe6U8h1sf7
         gDu5WHDdf2P0e3ePy+Zzx21sJG9Y2yNwDGLKc5YjTrHVKah18RE1oVSQkmqbkf4m2cf1
         9MfPzcYKK0zjqNeZsc/MRYoPRA9UeFga+4Tox3unPEHp8BQHE4GG63eN1DUGHsObyI0M
         yf+1QaSteR9vX1WeN7r/RT6Tktsg9Fc92G4QKM3sh92DmY744qe95yBocj5ZX41kOWNM
         ihnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734440076; x=1735044876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNJH0bZIRp/lLbJRiuys3BD3sasknh5mv0Tb1tCrHk4=;
        b=SUg/HnAXgtcbV+gLOCjyZM2Wt500OYCsjVJOFh9vLMyDsEW/O5YMEpGCs30GlOgIEC
         +2/rUdf20yZHSxp8zx6Ub51S7LYlzkzjVCfMUwJLV+RmYXx5Qkls7+6UT1CXeMlT0dfm
         hEhWo9UOQeL+vhiPaZ5Ssve8G9jNPXJdDe6xAIKTUX+/R8VfoGkLkEsXc6XdDxmuw3nm
         UvdkXJMg2kqHQDx47uyWQQsSKIqZOI8S4axelgiBbNqqP9xScvNrtjIMtUL9QYgG3aYH
         Et/lz/VIgVwRSBkmrQCzWpHBeJAzlEKMQ/NEd6wmzbgeD2kgaFTGtc7eZAoVlvls07wI
         mRXg==
X-Forwarded-Encrypted: i=1; AJvYcCUN/NKTtQHYmSCtir5PZtzsIwKWbfdz8JV5XU7Rpa6BLxtqA5xC6wo/mzh81MEoMjCzDgE8uOA4Q59m6U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsEy7w1x95JtGM53bnlpolQiZCwJcbwwdXVX4s2NFsWJatlniz
	nPslaPb9Qw6ITSPkSJDmDCz7E9dl/NdhM4RrGHlNElSBF7HDKxH3Aw9aAtMTvUY=
X-Gm-Gg: ASbGncuJUmgwdIX3F2d7mC6WCvjUcweSSrNYTIn3iLFV29tRw/XaP9YrBLiSceHrceM
	8gmABu205zjRPOQ5E2+LW0DS/b813sBQ+L2w45UaPwjmjBYNNYcDGs1yyFbNaBL0X5eJHFftr+q
	7BcMvP6plOrV210fQd8ajmShG85+AdCvkYm5701ng55Cbj6at/y9FvXl+KiuZYJyu/JK1NauTL7
	IEYaZwMEJQxCeKCqd3TpyrF6km6rvTfRgCkfKeSrmsm+l6QLSReCSjYMUfhVSkCRoQ=
X-Google-Smtp-Source: AGHT+IGIkCksbdZEfvo6ki5xx29/1TnH2HLfVEMtjsycZHejT40HWMLMjlwqoedRINBd6o/828MIhA==
X-Received: by 2002:a5d:5886:0:b0:385:f66a:4271 with SMTP id ffacd0b85a97d-38880ac61f7mr14775811f8f.4.1734440076073;
        Tue, 17 Dec 2024 04:54:36 -0800 (PST)
Received: from localhost (109-81-89-64.rct.o2.cz. [109.81.89.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963cdfa5sm442501466b.199.2024.12.17.04.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:54:35 -0800 (PST)
Date: Tue, 17 Dec 2024 13:54:35 +0100
From: Michal Hocko <mhocko@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	handai.szj@taobao.com, rientjes@google.com,
	kamezawa.hiroyu@jp.fujitsu.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v1] memcg: fix soft lockup in the OOM process
Message-ID: <Z2F0ixNUW6kah1pQ@tiehlicka>
References: <20241217121828.3219752-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217121828.3219752-1-chenridong@huaweicloud.com>

On Tue 17-12-24 12:18:28, Chen Ridong wrote:
[...]
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 1c485beb0b93..14260381cccc 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -390,6 +390,7 @@ static int dump_task(struct task_struct *p, void *arg)
>  	if (!is_memcg_oom(oc) && !oom_cpuset_eligible(p, oc))
>  		return 0;
>  
> +	cond_resched();
>  	task = find_lock_task_mm(p);
>  	if (!task) {
>  		/*

This is called from RCU read lock for the global OOM killer path and I
do not think you can schedule there. I do not remember specifics of task
traversal for crgoup path but I guess that you might need to silence the
soft lockup detector instead or come up with a different iteration
scheme.
-- 
Michal Hocko
SUSE Labs

