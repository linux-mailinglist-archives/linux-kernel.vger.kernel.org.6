Return-Path: <linux-kernel+bounces-174596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BE18C1152
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197871F23DE6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0922BCF6;
	Thu,  9 May 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="rCftu8sv"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457F11A291
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265404; cv=none; b=r2Xup/MAOGWJ3/sZSGlagfgW/24ivCCx5mGsoDbSlp2fgRSYWNfagZeb32JbCSXUH8GYroeJuIcUo4YLbrRnUH8sQNQNxdGeouNLpEu686/diGpstT2tjgIFz4T671txgBw1QrZH50RbvHDlnxeIkzX0W+fKgmPLLAGNInZgCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265404; c=relaxed/simple;
	bh=BohcBGxfaXkDywNMlsvifAfmiZbWLsTZl5XyiAuZCdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IasML5wnuk2F7+Jvi2L6ZDIxUSM/TV311VFhysM5j13+Yq26Ph8CLQq2GEmtuGAesMYuHYvw/iY3m8mnPbS2HHUVsfPcLSINdJT3TCVhwLU0ds3y1U+aT4KCAj+JlGKDu0fQ7NsDBPZB54gXii4Wy9SKJShfAoWK0S9x9A9UfGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=rCftu8sv; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43df3b00becso2647921cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1715265401; x=1715870201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d62sDrbwldQWyfBHNDbH1tSKK2ETROA7S+pTbUfGW0k=;
        b=rCftu8svzkCLyyPVG8dHykHAAbC1WrzQjLghWvllYkYxN36dUHP9hYIvdN6FMTbQDD
         RScs9DD/CUBXJ2RgGpz4RwZcFPGXs2E2BbBKPYzueZ1cIgrbqDIV/lOUw1zoLwwxhty1
         iNUwxCc8wSm+57+nq+T8hxXsVI4UexwEfArU2hT4Y2HgscfFrRW8mponVjA7yKQKuvx4
         Epgex5gzbj7UuxfpCL7Yh7N4IilvTIs3GbS98PS0H9rjB+9VpV3kL2mDoQ50iEQJuoZw
         us9FOc7SEpLZPcx5V9hk3phrUVJ41MSOTSHgdOL+G0rJcVkbcFsxRGjDXRZGsC4x+HH6
         xFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715265401; x=1715870201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d62sDrbwldQWyfBHNDbH1tSKK2ETROA7S+pTbUfGW0k=;
        b=SRogBroZlxtj6bqfDiUNdrzIR9tKPm4F3AJQP21b52R9U5Ku0uN7yFq4GdEGLMPgyu
         W+yaAdpeUubx0L5CYIF7N118VBEHFy8TFRvGQw7WpxwDWFt/Phe6OuqOEEPyCzF+bwdL
         /r9hlq7G15KSrbExEsgTqNV5Pjy9Ex5FlOeABVQfUpuqaG2fbJwejhRuOzt4aU4fegDH
         C9DUj3NqCYFrxq2buVVcXh+kN8wksNmUWm64kpBzBBLeuZIkDWnisFUm9MI4hBjevZa9
         piGQlc/qXtFQy9J5GUWhL7vTzYqiEQSDYcZ0HeEvuLTDj7sIYJw048mjTMve1IQpn+f0
         3P6g==
X-Forwarded-Encrypted: i=1; AJvYcCWx9BX5rqjLrDxgFwFoyLWsgNNF417W+UfchESHFierFp4bB7IL0qJswTKPzE8xtfmiqbQwkkFo34Q6w9JH6qluL3jT6zYzzVw6VOnm
X-Gm-Message-State: AOJu0YwrqDZQvtP+0O98+Hi7nSj7pjVTQ5GMSCHsVGqURuWAEVRK9KaF
	LO09QGcD0oPQf2i0pzxDEoAPPl7v2CJIrkNQo7MX6vTZZnUpK+g49SLmDL9f9hE=
X-Google-Smtp-Source: AGHT+IGzhpNIA1VnsSvpxsB3TI/JCTSS4gbwUUo7lk8tUT24yEmwjA9Ux+WExHDN9IKSEnW0OvzNXA==
X-Received: by 2002:a05:622a:50a:b0:43d:f612:979e with SMTP id d75a77b69052e-43df6129c5dmr20241621cf.47.1715265401015;
        Thu, 09 May 2024 07:36:41 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54d6e47sm8862701cf.28.2024.05.09.07.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:36:40 -0700 (PDT)
Date: Thu, 9 May 2024 10:36:35 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <20240509143635.GD374370@cmpxchg.org>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
 <20240509142205.GC374370@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509142205.GC374370@cmpxchg.org>

On Thu, May 09, 2024 at 10:22:10AM -0400, Johannes Weiner wrote:
> On Wed, May 08, 2024 at 08:41:29PM -0700, Roman Gushchin wrote:
> > 3) Is it better to use a new include/linux/memcontrol-v1.h instead of
> >    mm/internal.h? Or mm/memcontrol-v1.h.
> 
> mm/memcontrol-v1.h sounds good to me.

Argh, there is a folio_memcg_lock() callsite in fs/buffer.c. I suppose
include/linux/memcontrol-v1.h makes the most sense then.

