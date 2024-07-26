Return-Path: <linux-kernel+bounces-263828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D45993DB1B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 01:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D431C222BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF1614A0AE;
	Fri, 26 Jul 2024 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="xG4MevUi"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6ECFC1F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722035356; cv=none; b=RxUvX9mlhZJMfKwwPH6wcJ2Hy7GagatTV/DZqnpOTp/5UBn60/KGTrTLAuiYnBulpUaqKjCFhU+wEzniTJhJtEnAHmhuqs4SijfXYvpC8pmbPCCQz+WxB8M9fP/ji6S0XWELJCdesSG3JhYERJzNuvoMovmnc6IvbFSi1XiNIcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722035356; c=relaxed/simple;
	bh=Cs5Mp1trpruzsM+UrnjGipSzvGq5bDRs6gKnl6VOkg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjPjAQ+MAEow5kjhjVlwgVrPqcpR4ZwLY7Ipcsw66338OaFtYtYxlhR40ph2NJF3m6bfvnq95aauR8XkTViIoFat9h7oCQvMhli+p2vnKEk3qYLu6QgQOQRZ3TdggMuqGbOy7YTBMQmewIuj4IjLrUH+q5mrU8Pvg2wTzEGa9Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=xG4MevUi; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1dea79e1aso66862985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1722035353; x=1722640153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LyseXoYvJrQwi2qmBnkW9qMa3eQBXwqDu7zUnQDqavs=;
        b=xG4MevUixB6Q8pmKj8TDWW8CaJgtNd5NpnKIWB4x5jD0BwdRuC8ik25iQpTfbYbs/u
         gMu+obn+Ad0tbz9xjtWIA4bu3+G2lUFeSJQhEcW9Ol7zTzbKiskBsWI2gjmjy8t6wizA
         4NRoauHXUcVb5u9alqWsQSSqm9/RDoXfUpsNoXEKsZNRcQ36rJxsX9VnKj15hVh/GY3t
         L7ugmKcBPzBgNpliq9GPttSydzQ9dGVvGfW5DJ7xPs4pHvGNlSZIuVIb/Ny5pviDJ7k1
         cPNT7Xyus6hvZ6pvbW7B4OF54BO5/UO7cBVbLviHCD6GfgT4YenVLh09cfhrRpOqjZJQ
         YU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722035353; x=1722640153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyseXoYvJrQwi2qmBnkW9qMa3eQBXwqDu7zUnQDqavs=;
        b=wzvp00z5XxD6f0W97DJRzDFNDTFxlgroec0/v367cqdl3SwnFjozR/EiVXOyq6Tbf3
         wxyIqe+y3FxxAprH4uovlMJTdMcKob0QIuudleX/X19mouYgvT5G6eoReLtKjrLrf+Fc
         MRLeeYRwCyjb+AwrAyVwECcvmfu2E8yDZ2vexoUYFLg8xLZjzR/Kl9tMliawjB8bp7a7
         Dj9IIe2ZVDp9vXzC694fKUosxnl0dBYXfOiA2cF8USx0cnkOYNwkrh2zae9tRbLNLE1g
         m6JDIXNUX1BnFDXybYjT55idOjvrKEbZ+Qc6MlNTpfCnWJUPfpd/BIuXSUXbZ5LvJ/oB
         9yBw==
X-Forwarded-Encrypted: i=1; AJvYcCVMY+/rgwKSytfbRbtkIUsblFsOV4kCnpkVOApK39TrgDrrDUNSATVRSFOAHUCtFvEsDaMcXuR0kVq9DE1TPDQSNY4KiW0t3oEE/Vj5
X-Gm-Message-State: AOJu0YxHdA3Lm6JcdZLAPdMOUqRA9E9UMAVDGF3jwJeETCiGTU5l1seD
	iV10vN5cUkeVjye9G8cECnBcuIB4zq7gahSMPQPo4jjBL/xCsnjfSk5+L4T/Kz4=
X-Google-Smtp-Source: AGHT+IGpQAgp4pv9Nb5eLIOrWJrIJuFWeAgilj6T3/Dvc3wSAWWtQkOCz5YfoMS4j8BYkDsTJc3mhw==
X-Received: by 2002:a05:620a:3952:b0:7a1:d880:a479 with SMTP id af79cd13be357-7a1e524759amr145059785a.26.1722035352854;
        Fri, 26 Jul 2024 16:09:12 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d745f863sm217495585a.129.2024.07.26.16.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 16:09:12 -0700 (PDT)
Date: Fri, 26 Jul 2024 19:09:11 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v3 2/3] mm: page_counters: put
 page_counter_calculate_protection() under CONFIG_MEMCG
Message-ID: <20240726230911.GE1702603@cmpxchg.org>
References: <20240726203110.1577216-1-roman.gushchin@linux.dev>
 <20240726203110.1577216-3-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726203110.1577216-3-roman.gushchin@linux.dev>

On Fri, Jul 26, 2024 at 08:31:09PM +0000, Roman Gushchin wrote:
> Put page_counter_calculate_protection() under CONFIG_MEMCG.
> 
> The protection functionality (min/low limits) is not supported by any
> other cgroup subsystem, so page_counter_calculate_protection() and
> related static effective_protection() can be compiled out if
> CONFIG_MEMCG is not enabled.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

