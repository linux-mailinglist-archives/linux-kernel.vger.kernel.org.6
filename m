Return-Path: <linux-kernel+bounces-425075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 983159DBD30
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0F4164A58
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C341C330C;
	Thu, 28 Nov 2024 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Wgr4rUYB"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC214F135
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732828340; cv=none; b=ZNoB4vyZYUEgmRD7t9m25JLimKG40U5REXValk/MhMLfrmdNZbBEbMJsiJeKCNfxP/1Zt4MxkMqVdLtVhCyW1bYXAdwaCTTNHLBt24RfOC9Pgy6aJ6mw/dYMf0ka/ZN7XSvHQI7Y+desAdnHbRBi9W+I2y2hVYXdxC1SYQipFfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732828340; c=relaxed/simple;
	bh=SNH6Vhy1Qsz73JYqfCuZ2bp8yHxqGV6IJ9piA+m/bZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJW4vtB1BsHyylsTAxmslr3gyX6AQEIPlkgHdVwykLLvDOurUfoAf259Xs8rVkGX256XUcBcCwzZhYKa2lRRgBE/go6ZNekXlFh1pUozZkpjuneEYvnIcswaixr4rfUEnsSpP5Sk5GKt9F/kuIdackeri3DD9P8RysOET89ZeVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Wgr4rUYB; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fbd9be84bdso846514a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732828337; x=1733433137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZQjgHCOdKGOLIMC8jx2ghuoSXfBYmvpjKyrW4dIslk=;
        b=Wgr4rUYBuV/V9lT8TlgAYppw3jyi8xptn2CAfFNIu+7EEwzDQtMTGvKbIcuM3VKWrr
         SG84y6AGJRIycUXDyVIuYRq37auNIPbudXiDe90vmIh0LfSC8w8eyar+23/AA2NBk08r
         3VWrKV/wT4EwWIeGADnDN0++k8iD75Y9ankmydg2rd/bIO8rQ53OA8jjfxj03WEgu6Al
         vCH5zt4CsDR/VGkU/31Hg9LUzmutU+gJxcNKntAenSYFYrk7K0Or2K5IVA/LBZdXYo01
         F0IiaK68nW1Qw7SQ1w77cLvUqWUGn0Od7thMPK2Xci3evySpDvJym2DFmRb+1jsI9/g+
         Exew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732828337; x=1733433137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZQjgHCOdKGOLIMC8jx2ghuoSXfBYmvpjKyrW4dIslk=;
        b=L6TcPdgOBEvpoI9KMdKU0X1EzyULdWX+baBixYOUYKhS/3H/rNWqRPNUfEpak1GDrI
         umseygcdPphfQWgjLwNmtczcP80Ko+LrILUYfWgSGjCVONNFiclfLaV+3Bmi53ZliRWu
         FhA5xzgOOxPVCXkw/8J4frC+9o+qE4diqn4lPu1Q5fy4ro9CoHJdS4O4l1nOcWsHOTQ4
         SLzI1UwaYJlZ/H5kBYIiALy1X2M7TWwgx7zRH46Gy6/mNVjwL2hrMO7SDYkFMzRD7+9L
         qiKP87GWXmbiqNQBQ8UXovowcC/lr63OLA3bG5n+6OILMpZtV2/BfUxCOyIEwHYafm7i
         SQRg==
X-Forwarded-Encrypted: i=1; AJvYcCUaZ3rDC+VO6zs9gPYZ8vZnXn5ZHeKNUH9Bs+dtcc7mgDLjd25unLHtqXZrdtMEZT62p0Fvw8IqJml9BA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb3p1HpSomQ6diSTZPNm7XFTiu/VzivIkjUdSNyf6NPf7I9pzk
	dOPTHMlMJcQtTUg4vhJ9UKa7kfU/exEdape6kjdM5RmFpEHM/xi035q2hn+GuWo=
X-Gm-Gg: ASbGncsrUXM5qmZBSeFQLGXNbj7unDKBUqXgH+CLI51Ta8jQHQzp+T+LMTZkUhspyjN
	PaC4TM9T4CnuKdHuNhbfxlE93G/XdOF8P/5ep9lCmpr7EhZ/yAhNaEAPQl691PjLkPUOuQj9p9a
	I9VN29Fw/QL9rbh94UQHkqH4yf2nviuXVElkNpHRr+nSxX6qKe3xUkN252Z9pLSRDFaWHjLeoTn
	b7Tv54NZI+ESsbqltVX749wCxzdnOXpbtnkpaAJOPrMAqb4xVvcO22JFF+4X6J9+DNp1bSIrO0b
	obxqfma0cKOribY=
X-Google-Smtp-Source: AGHT+IH6amO2slru4tjcta7Dz2nO85K3hdLLPHfnkg7IE2FAO0Bdpfqa+QOZGZFc1id6LQ57hv1jaA==
X-Received: by 2002:a05:6a21:70cb:b0:1e0:c30a:6f22 with SMTP id adf61e73a8af0-1e0e0b8cdabmr12970905637.40.1732828336956;
        Thu, 28 Nov 2024 13:12:16 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541761474sm2025702b3a.32.2024.11.28.13.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 13:12:16 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tGlo5-00000004Fmx-35VV;
	Fri, 29 Nov 2024 08:12:13 +1100
Date: Fri, 29 Nov 2024 08:12:13 +1100
From: Dave Chinner <david@fromorbit.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] list_lru: expand list_lru_add() docs with info about
 sublists
Message-ID: <Z0jcrYt1iSKgQecY@dread.disaster.area>
References: <20241128-list_lru_memcg_docs-v1-1-7e4568978f4e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-list_lru_memcg_docs-v1-1-7e4568978f4e@google.com>

On Thu, Nov 28, 2024 at 12:12:11PM +0000, Alice Ryhl wrote:
> The documentation for list_lru_add() and list_lru_del() has not been
> updated since lru lists were originally introduced by commit
> a38e40824844 ("list: add a new LRU list type"). Back then, list_lru
> stored all of the items in a single list, but the implementation has
> since been expanded to use many sublists internally.
> 
> Thus, update the docs to mention that the requirements about not using
> the item with several lists at the same time also applies not using
> different sublists. Also mention that list_lru items are reparented when
> the memcg is deleted as discussed on the LKML [1].
> 
> Link: https://lore.kernel.org/all/Z0eXrllVhRI9Ag5b@dread.disaster.area/ [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  include/linux/list_lru.h | 48 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 13 deletions(-)

Looks fine to me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

