Return-Path: <linux-kernel+bounces-547051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86FEA50264
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540CC165356
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DC0241132;
	Wed,  5 Mar 2025 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="QNyf5eB2"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BA624BC1D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185507; cv=none; b=bDe+SRyMtjTDHG22MWS3BbXNeIIB9GA/t9xefMaaqJEHOnlL2mefL1JDPaJC+d22om2FuomoacxIqeocbNFWJotFNhrcp58QXLv7NnzrmJP/q2lE18JLI2bsEXifWQrFdOa5ZnZot40VfzD7j/OhF0ZTsH9RHNoGIQl7HJ8xvY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185507; c=relaxed/simple;
	bh=BqeLWYpmzx08akl6bVj7sB5B/GwdFFEes1rYrt+d1vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujW8LvtbyOMqE9FgHK/oj6UkLH/nP5JAkBKg9kSJokJ/akcgAlGp2JvrBl32Jzjz32bXZphk6wZAaCX+k/XICbb+YQX07/7Rtz+CrQgMVlt6F6xAV+ek+mQFqiUmNmQXu1Y+m5JfR3YkgHzayhIIKpPfFPMXMWaNpHxBX1Iag1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=fail smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=QNyf5eB2; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=andrew.cmu.edu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-474fba180cfso19037281cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1741185503; x=1741790303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka/zF6Ds/g/dxAZATcvUkbSWy5jstJ9gLeo9m4izlug=;
        b=QNyf5eB2mqnQQeMpgkW87arbJgUtBEc7JWfQd6ZrCE1OKOEnIsCxlYQe5kgl7a5ilu
         XDmJ1mTraa+K0plwSwHUIuj+aLWBotfgSiLcMfT1OtNIg+vZRxN19amUAsXCKZRj2Hbv
         g7uFMr7UrUrnuOmVC2qTouuHc5PYMNisNyIBFXI/DgNRK6LJ7kfjug1uFy0krYnG7kuG
         ElsX6MGo+aRMMuKUThCRIu1ur6FZpJp0Sa6yAtb+TQuxGY2zLW24kEYIdZQzwX7ITKYk
         2rYOV0Ftx4EoLDzgaMDJ13w55D6mv4CVdZQva18GNi/F52M46Ia95g9QrCEoQmxiR82B
         Bqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185503; x=1741790303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka/zF6Ds/g/dxAZATcvUkbSWy5jstJ9gLeo9m4izlug=;
        b=d3r4SRQKIzEEAJDdPGJeyaLs+tO5M5rn3dSrKGH8lPpAsIFBb5Y1w4K+wrLOMYw0Rt
         mmHzwbHp7iBQYfiZtaGo5M3+5fab7dHtsZeJ/jbYNFdB+xIFiY6pXGJDHpGp72u+0jAm
         5kMpXMHUpt8Hxf6uvuYvcrlUW2WeD1vJ8dtw5/weydeNF0RzzAHbp8zYotFdQAV2BT0W
         4wMeQJUmrcYVeQRv81YcxHlIw5U6/927dWZjQbrEzKnhLrLsGHnqyVUmeLS/H/W7ScmY
         vUPpgWVSTfC23GUU3mVlfaf9oK7qoMuD54PgX8R950P6uHu4GKdnlMZ0k33t5IT94UJr
         139A==
X-Forwarded-Encrypted: i=1; AJvYcCVzdSj+7VH4oDdtdIbNRHbCHCZ3jkuDq5l2koWRweym38yFkuV3nSBayc0wYT0JZx9LQEyDdkbaP/OGpIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4b2sICfVGpa15eD5OPky8wJDGk9c3A0XdCrBQ8RSs2qgKxWV8
	YRiGOWy8UZ4PsJKFQc+C1et+Ml5KceELe56RAVEw1kjGuSUdN7+hUGManMUTeQ==
X-Gm-Gg: ASbGncvBsH3oFOAkXOLkL+c0MdkTq2O5HUO49hTiNg3nYtJmkRnBB3THfoJlaTZ8shf
	KpKNE43WiNDevhf7tQLtMArafLNW0+PmdziVhJbHKKayhv9oNO+LZJG4efiofBm9lrS3yXaPLMM
	t9ti8b5bcK92oZ93XqbBpyXjGG7Gz66Ul1bXvXpBtJEfTf85+MrsmXbCBvM2zCI8NJD1IMnloGM
	bP1cN68mkl6MiV68qH1HpGLOjl1dZj6O61OZoYS9sm6OXvPzj+ouq6AE6N0yaW+gTYmIbzX2wAC
	o6RnS9Cc8+GJAgK4ruQwi+PYQaIrgrd5N6XwKatc24VWTpDBC/KJK/Uye6tHLyYoGYhSDvzW0JV
	PR7YQin4AQy4Y7XzJ+ZjNwQI0dA==
X-Google-Smtp-Source: AGHT+IHgmaMykJuMYvv7QD/ziX2omMhk+AntnG0Px6ZBZpdvG36UzbAoKiAqQ2mp1n2eBu3/c1Y5Xw==
X-Received: by 2002:a05:6214:2241:b0:6e6:602f:ef68 with SMTP id 6a1803df08f44-6e8e6d1065cmr44842656d6.10.1741185503461;
        Wed, 05 Mar 2025 06:38:23 -0800 (PST)
Received: from localhost.localhost (pool-74-98-231-160.pitbpa.fios.verizon.net. [74.98.231.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976346fcsm79902296d6.14.2025.03.05.06.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:38:23 -0800 (PST)
Date: Wed, 5 Mar 2025 14:38:14 +0000
From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rik van Riel <riel@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Tim Chen <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>,
	Michael Wang <yun.wang@linux.alibaba.com>,
	David Rientjes <rientjes@google.com>,
	Raghavendra K T <raghavendra.kt@amd.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] sched/numa: Introduce per cgroup numa balance
 control
Message-ID: <Z8hh1urLnpmMxHqW@localhost.localhost>
References: <cover.1740483690.git.yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740483690.git.yu.c.chen@intel.com>

On Tue, Feb 25, 2025 at 09:59:33PM +0800, Chen Yu wrote:
> This per-cgroup NUMA balancing control was once proposed in
> 2019 by Yun Wang[1]. Then, in 2024, Kaiyang Zhao mentioned
> that he was working with Meta on per-cgroup NUMA control[2]
> during a discussion with David Rientjes.
> 
> I could not find further discussion regarding per-cgroup NUMA
> balancing from that point on. This set of RFC patches is a
> rough and compile-passed version, and may have unhandled cases
> (for example, THP). It has not been thoroughly tested and is
> intended to initiate or resume the discussion on the topic of
> per-cgroup NUMA load balancing.

Hello Chen,

It's nice to see people interested in this. I posted a set of RFC patches
later[1] that focuses on the fairness issue in memory tiering. It mostly
concerns the demotion side of things, and the promotion / NUMA balancing
side of things was left out of the patch set.

I don't work for Meta now, but my understanding is that they'll attempt
to push through a solution for per-cgroup control of memory tiering that
is in the same vein as my RFC patches, and it may include controls for
per-group NUMA balancing in the context of tiered memory.

Best,
Kaiyang

[1] https://lore.kernel.org/linux-mm/20240920221202.1734227-1-kaiyang2@cs.cmu.edu/

