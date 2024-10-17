Return-Path: <linux-kernel+bounces-370597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FAC9A2F71
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451CD1C2135E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B9A1EE038;
	Thu, 17 Oct 2024 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B6WlxQ06"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C931EE00F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199650; cv=none; b=BOcP0B7BbfBpjB1ds4Cd9kA3kUTgNPauQaGNy8Rwoi3Af1IywnLCiyyvf2a7AKqGhFJQmrYgvbwQBjLHFrAE4+TRw7iSyaP1z68f4pqdM7q8qoeFFjBlN71l9Ha3zgCZPlNBoJXYm4foLvLZZVywtZJR7yP6jgijRopc6FcWVh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199650; c=relaxed/simple;
	bh=haUV2i2FCVd6Ah2rrOgeJ+dLZPRJ0/JU+tYRbsG/bpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUA5pUuukI5TXIdUwwGZcnaDFZjGUoeNowSMiGktVbmizjHr8+RMR3GjJO5rdhVpHUyXWSp5Q+ckSGiztYUAH7ActfzyXbS6NabBjfzLlgwFf0MR2464yGcmR3SgVDAKyy3IJ7l7zh85IUWlYu+YRYMkf6EJ3eV3eGLMp+He+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B6WlxQ06; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so8654025e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729199644; x=1729804444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=haUV2i2FCVd6Ah2rrOgeJ+dLZPRJ0/JU+tYRbsG/bpo=;
        b=B6WlxQ06uMNDvRzt9dLetVO6HdFrvWArEN5O4Z65WWd2WSi61WVNkdAGv2CMBftjA7
         jmulhZ0mIx2GNcZgGreKjsZ9UsVeQnpT66H2KDFFz9AZJZ+jzt31YcCXZaM5Xy8SiFfm
         tzv31tOonxdJ9nVhohyo4gi66YWzRn/TEA+YDzssQCae79yZYdtt8Wu0Er6fJkNmnqZd
         RPHpDjbyq++uPpheKaIbGh3CHvp7y68J4jB8InNLMiPfmNqb/gmt6FAxwNB5MJSkM2VH
         K/2/fB/9NCN6uoQsUuWxjXtSdT6RYHSVjD7adPZ536y3S7FoTtgNoi2XyN95x0c2QU/y
         +ECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729199644; x=1729804444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haUV2i2FCVd6Ah2rrOgeJ+dLZPRJ0/JU+tYRbsG/bpo=;
        b=TcsOvwEwgpcUVQfmF5H39GW+aLVh95VFD7zmcDPheU4TLQ3xG3+q8qFy++GuKgmBg+
         pHMuY2RXNPOM/zNhqUBl3WO9T4LFeWWamxNhXbp+Bv33c0o6EUmP5C3X9nYVMHifgdRW
         tviO5tWv0Yiur/+4V98rcgAK2dMVQSXefxRf+BzwwgFKSLFeXWsXSWugear/OtbzmsFz
         KyIloVjdRkErsdhWvyX2/B5N9cV3GxYY2erYj4qT01c2loukJhAeLkoOrQsVlaRroUqw
         K3Nuylc4JKRIh04zEjEDcihYseQ2xSrm9dlOn5KwjLi2vLcyRrsuJ6Zbui3HGMEoJq53
         PLOA==
X-Forwarded-Encrypted: i=1; AJvYcCWKBXDdsQylCfMMFQ8ABPPNLCNC8TIdD1C5YCwr8jIo7n29hZ/vdEzS9C4Ioy+QMS47AKNeR9wxf77fTn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/NNvSHnJ/wPHwuHvo1CZc5adw++Jz2dZUNnCLX5l+QOmD3cuP
	UKh2OsuABNx01m9r9DyXyQ6rfFIZ2apIms/DeboQ8cHmyG3tZQUBEJNmgCsXG9qPD8xrErSBC60
	BxhE=
X-Google-Smtp-Source: AGHT+IExbG5MSiDtsAamfgOhFLU99JDFE6Ngyq1wSbEcfFqTwaNC1JYQmb8uwjM0RRe8EMQcbvQGtw==
X-Received: by 2002:a05:600c:1d28:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-43161686a30mr527635e9.28.1729199643978;
        Thu, 17 Oct 2024 14:14:03 -0700 (PDT)
Received: from blackbook2 ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf06d3casm52013f8f.48.2024.10.17.14.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 14:14:03 -0700 (PDT)
Date: Thu, 17 Oct 2024 23:14:01 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, john.fastabend@gmail.com, roman.gushchin@linux.dev, 
	quanyang.wang@windriver.com, ast@kernel.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, wangweiyang2@huawei.com
Subject: Re: [PATCH] cgroup/bpf: fix NULL pointer dereference at
 cgroup_bpf_offline
Message-ID: <aka2hk5jsel5zomucpwlxsej6iwnfw4qu5jkrmjhyfhesjlfdw@46zxhg5bdnr7>
References: <20241016093633.670555-1-chenridong@huaweicloud.com>
 <bidpqhgxflkaj6wzhkqj5fqoc2zumf3vcyidspz4mqm4erq3bu@r4mzs45sbe7g>
 <Zw_yHEJCBwtYFJoR@slm.duckdns.org>
 <12f57831-6b88-49db-bfb6-eabfc5e1d40c@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12f57831-6b88-49db-bfb6-eabfc5e1d40c@huaweicloud.com>

On Thu, Oct 17, 2024 at 08:17:58PM GMT, Chen Ridong <chenridong@huaweicloud.com> wrote:
> So, should commit 04f8ef5643bc ("cgroup: Fix memory leak caused by missing
> cgroup_bpf_offline") be reverted, and should cgroup_bpf_inherit be only
> called in v2?

Yes, that should resolve both the original leak and the current NULL ptr
dereference without extra rebinding complications.

I'd like to keep only cgroup v2 be attachable by BPF programs.
cgroup_v1v2_get_from_fd serves the needs of traversing v1 hierarchies,
not program attchments.

I hope this proposal is workable also from the CC'ed BPF people
perspective.

Michal

