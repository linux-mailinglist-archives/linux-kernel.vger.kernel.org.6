Return-Path: <linux-kernel+bounces-557803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A48A5DE0B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACAF17A0FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72246248893;
	Wed, 12 Mar 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVsB1ifP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A871E48A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786342; cv=none; b=unFQK1RgK419fWCFrGkkybc67+f9vnXqXwmoSTREaSR3nhnnO/4To7Yw/cVpDmquW8jxt9o0P/wWv/mieVajoR1LNarPkS1+uqdSYPGyzIs+1i/U1vCnjaU0mvAx3A75NlqAwH4odWMpzbkEn3t6Rcqj2D69oA9Oco/7Vkpj0jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786342; c=relaxed/simple;
	bh=1cWixh968plrgs9DFJw4Oq3vwwUksg0Laamhx8PZPYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fPgAdu+NKEbXUWPMR0rWxawkbtHlTiNxOW+js1pz2wMXqslb7CkrqFSTJ89OEcSLydirjLErxlYXsIgoWxEBsJRKl5s/xkH1Pe9OKpbnW+y3j2qPjV4UxdHMD3Qk/6mii+M2YmfXOkGlzTCPGTqRa49oEBEUVbAEH0G/uXvevsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVsB1ifP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1cWixh968plrgs9DFJw4Oq3vwwUksg0Laamhx8PZPYE=;
	b=BVsB1ifPieZAin16caQQ1iJFWiMoscfDnZ5yPC0QCMCimyN0x+pZotUQCAs35F9uKkV5fW
	aWVxEVK3RydYHFfGG7DIj7CWcjZ0+BxAAJnu2U/koHQ34bJxLzLXc/neF84D5EWKoLTgQQ
	ozf+iS+1i/7S+XPrbrcicFrnqcU/Un8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-BDqX76LnN_a0tGlxDf_Ghg-1; Wed, 12 Mar 2025 09:32:19 -0400
X-MC-Unique: BDqX76LnN_a0tGlxDf_Ghg-1
X-Mimecast-MFC-AGG-ID: BDqX76LnN_a0tGlxDf_Ghg_1741786338
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912d9848a7so478240f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786338; x=1742391138;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cWixh968plrgs9DFJw4Oq3vwwUksg0Laamhx8PZPYE=;
        b=SfBC1WsRZnoprPcTWv6WHNl8XUgo0Gq4qPNILG6HDvl4HnNRryw0n4jQ1VBXe7lwO3
         8RkrDiAoEloMY+xaYIJwnyF5Qgc3jKru7vhkNJn6hRbseViyPzcRdXS9rlzFRhy/zKmr
         IHO2runASlXo1nkaLrywznJtXoZ2DkOsMRpz/a0aYz//Ap25ByhBB758iXQ+ik7ot7CY
         XAs/NCnvLUxMRX+fPKjDaQ4wQYo9YClOGwWq0VBKPuTlpwxksUPK3gWsBD1tVKPwjmOz
         wI703d7irijJKWh3BjugJ1EiNvv6hr72U3KmIq/T9DBuhp/JuRdOTl4mLh9+8QnlftxC
         a+ng==
X-Forwarded-Encrypted: i=1; AJvYcCWfnqloS1w5EoeOAdF5NVbrK5H3Y6khCau9ZYePgxUyd9VtADOYSlPRxPbxTzYumbMLk1pdnYK6mC06aI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycsS45F6jp35AUNVlvM/pYE6UkqOWEICFbsHQDaB+bm0ifRrM0
	s4WZnrGnZmgqaDHVvvebDBmS7XAQo16dHCwkQUdNJGtmlFJjMEiimWVtyqMkFDk2D4D65aVJd9k
	ddJK9b6A4J4rVH5twb3Zy6z4hPn7++ycgT4KjZQ2O/4vL6/wOYpeOeZl8EKmZ+Q==
X-Gm-Gg: ASbGncvgBbHOGpn5F7bMp1Zs4//OgFQ8wl7HuQcf7BjFFOMsqfaMrfUGoRnlP8A1yXS
	gaKaf0hbh2vtO77GfqmuVPIk+U0gVqKrEpBtLYl2SrWmcuXDFX7QH6xVoJvnhtIIDSVZZ75agEm
	rUvK1Hsgu3A6h8dRkAi3BtGal7RmyuClN+JkKUiKukd295t4iBrnfKV+4PPeJY7Ejz/bhCkMeVu
	+j2GTzsEA2tObYBNNxoKEEI3zJpnEIENH3O8oaXCYyp9Ya2BRpm78uVDnd+p7Zbzx3120isf2+4
	IvL3JR4qvRz83YGFxlikhcwCUC7hVUo2DB4DqXDng5zDAoZ0hxP7KGAeMmGNuNym8vO6sPjgJ5S
	2
X-Received: by 2002:a05:6000:2aa:b0:391:2884:9dfa with SMTP id ffacd0b85a97d-3926c8857cfmr8359708f8f.13.1741786338151;
        Wed, 12 Mar 2025 06:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAs3oOT7v6n4w2AauMkyMccFBCDAzBZ2SKWm8b0JnBgGqKoxB79FBQoR9xC12OHr9ON8VKQw==
X-Received: by 2002:a05:6000:2aa:b0:391:2884:9dfa with SMTP id ffacd0b85a97d-3926c8857cfmr8359660f8f.13.1741786337746;
        Wed, 12 Mar 2025 06:32:17 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-394bdd9fc74sm1360766f8f.64.2025.03.12.06.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:32:17 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Waiman Long
 <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef
 <qyousef@layalina.io>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it, Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 2/8] sched/topology: Wrappers for sched_domains_mutex
In-Reply-To: <Z86xzGyT3av5dh1p@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86xzGyT3av5dh1p@jlelli-thinkpadt14gen4.remote.csb>
Date: Wed, 12 Mar 2025 14:32:16 +0100
Message-ID: <xhsmhplimpe73.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/03/25 10:33, Juri Lelli wrote:
> Create wrappers for sched_domains_mutex so that it can transparently be
> used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
> do.
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> Tested-by: Waiman Long <longman@redhat.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


