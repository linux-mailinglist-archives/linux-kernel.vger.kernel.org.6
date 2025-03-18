Return-Path: <linux-kernel+bounces-566574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DD9A679F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0071899FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FFD849C;
	Tue, 18 Mar 2025 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="RzSl3JxY"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E52116E6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316172; cv=none; b=cVfkxrvbe//HDIHbucEn1G2H8wBOUQy/8hjGk79nkFbc7O6Z4vnb3HRJ1WgCTfubwWMUVFEXd3r9ByCnGkicq2/iknVS4EoQhjei0DE/fZp+SrpL3N4P/qCxrY7DnvE2jn9Pgvzq5QgUwmJBodeQqz/Kubcn76YdZk2I1Srb0oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316172; c=relaxed/simple;
	bh=LxSqXW2r5Vj9SoBZ1X29YQU2mvLmXT+ZtKFl/VWGIbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7JMTakK/6xln5X4cO8KYVepxi/khnVA9ehsZWV9GV2aYF3Ti3RD7n8pi1gHoGKlfIcQ7/r2aV6sFsej6oYhhU0al+d+xQV0DRfsIbEmBhINw68CuLHUeLNv7krnsRY4bQyfuk0NTWplB5V0oQqlM1RlubgxPw+nyBRqu6b2pLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=RzSl3JxY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c08b14baa9so464040985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742316165; x=1742920965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eBlIzcdc3Xvtj4gWy5HkVWkPOVhbX//nFVlD6LG7nRg=;
        b=RzSl3JxY9QVCzS2d+7n4EGAjakIaDYpVi325CHm0Z2UgIGd73/a7/XxcfsQOAeskwn
         UpbNObZnObtm0pOeexuRFWlWcdxcVwawZBss7yV9Y7AyVb5S4PFH3ced5nRK3bd+ndtD
         ARqrc9f1U2kqqruCnq1TbYm77hcALiWwZA0aHre9gNmN2e8ZWrsB1SD2JRBK2Zu2AnT0
         8nDyMaEnh5LeTiLKdbvrZH52iVlSCc91CPgRLJbNi509NeTcdTDuF3TpXZtI+qM81/y3
         Tivn8WztPGeLxWVjJTR85Ros+PgJt1Z6CvXTVrlquS6PcH/wOzENI4Qx3ac+C4CsY8SY
         5NXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742316165; x=1742920965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBlIzcdc3Xvtj4gWy5HkVWkPOVhbX//nFVlD6LG7nRg=;
        b=clsIoSmd/xvQ7717b472QvgEgtcJqUn50TK81vglctgEyTBhf03iqoETFwBqq1EIhq
         iPUl+RHH1dymiIIslSUKt1QI7UseZjfXkwleVCAVboWxCcb9Jh3yTzsr/9dTaPG8cK0v
         /W3yHWj+IKnb4LPl+6tNZCrVHX001f56Iz4jeL0WGCQK0PMDs8XYYv9VuUOLURgsOnmO
         JGdMfCsXe6PQP82W5LkYfjR8QrFdX0Xie3swiQTV8euqeDZAdrNzg3bzT6rMMzs5yfm3
         70jyLL9c+fF3KdfjBJHaHYIYEYTFRJ6f4rBYgKAu1l4DxqsgHYz5ofUyAstlMtTSwCvO
         6ToA==
X-Forwarded-Encrypted: i=1; AJvYcCVOv6jx46F2FRzQC6ULlxPPk4zbReBTAPUNXmIMlyyB6rFgmMWQ1rKXVi+h/Dc+2cT7genLmTTVaF2fo4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+A1YyYZAMmLrE4vZ8IUnFxwUKFRUxNlKU1InQhgP4Y0Rxgpfs
	s02jXrOF/mESChNDNFKKnfZINVCVtO3O9nn4I6aTHfdveRqUPna4itzUGrqVk+8=
X-Gm-Gg: ASbGncuYBH7kNkMBmE0vC1OQCO1mujUN6q5/h2W6L9fa8EXWFRDUIJRzizTrXaJct2l
	MDc7a2rwOb/6eDCzZm9BMe83rRNg0jpkeIpK8ubx21HCV9o/y7Y0xy5F9EYiX3NMGiuDbQmFP+/
	sibnolPpx21H/r5Q1Yqm3ltk9EB4Yn7uCepmsz3p43DJgVsiWxMUm1FbV2PTIi79gTjLkn73tu6
	Oq3iZtTH5totUq1vzYaQp+vHbBJkkE7350VOrKMh1K0v8/AWaYoW2pikySnH981cVCI5xyx3rTN
	sBHmZk50lViMheE6RIHl9m49HrdEqjwEQVB1c7DV1AA=
X-Google-Smtp-Source: AGHT+IHQoOR0qOOsCpgqnzO8d96clCzHf4jUqi9AdgrkMbiVXfp1OVSHWbWSZQV6YMtBF7w2NI4VDw==
X-Received: by 2002:a05:620a:28c2:b0:7c5:5fa0:4617 with SMTP id af79cd13be357-7c57c8c0489mr2647132085a.40.1742316165654;
        Tue, 18 Mar 2025 09:42:45 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c4f50fsm739505985a.12.2025.03.18.09.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:42:45 -0700 (PDT)
Date: Tue, 18 Mar 2025 12:42:43 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, corbet@lwn.net,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
Message-ID: <20250318164243.GA1867495@cmpxchg.org>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-2-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318075833.90615-2-jiahao.kernel@gmail.com>

On Tue, Mar 18, 2025 at 03:58:32PM +0800, Hao Jia wrote:
> From: Hao Jia <jiahao1@lixiang.com>
> 
> In proactive memory reclaim scenarios, it is necessary to
> accurately track proactive reclaim statistics to dynamically
> adjust the frequency and amount of memory being reclaimed
> proactively. Currently, proactive reclaim is included in
> direct reclaim statistics, which can make these
> direct reclaim statistics misleading.
> 
> Therefore, separate proactive reclaim memory from the
> direct reclaim counters by introducing new counters:
> pgsteal_proactive, pgdemote_proactive, and pgscan_proactive,
> to avoid confusion with direct reclaim.
> 
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>

This is indeed quite useful.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

