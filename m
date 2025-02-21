Return-Path: <linux-kernel+bounces-525014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D7A3E9D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49FA189B286
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A42E4D599;
	Fri, 21 Feb 2025 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f9HbEo3o"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2DF3597E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100833; cv=none; b=dpkwyUyPtG/uaBOf7AWe0KcFpuPIfu9uCAjUy/ipyXrqyXrfp9FNdtAeO2EeO/pUVTebqYf8zWG+yyOPFY+WJ5D0/dyTQye+655YYBQJlufm4FZpsMLjUNWnLXFgMI9Uo8abw0bMBE3vVvgpRur6H5lt92CZI5LYndiBP3n4IKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100833; c=relaxed/simple;
	bh=rfLUxDYnv0ZpKkoBb/vVU+0mkZ0bBNJNmsu/vUVkc8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6KO1wb5lrK5nOZfui/bcSQyKoIMR05VHj0beyXVP3XgeM6sVZGrw+Jx+qX+X4QtdQiMaWHua37Wkhtb7Dd2wwCHa5drWPJoTZl3GW3nFWc9txh3MIy2c5oeYURoh4sJYs/sjL3s3qrrMI27DjsKXTw9KptSf5W8ehsesTMo2/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f9HbEo3o; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f2339dcfdso28247875ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740100830; x=1740705630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6B3FtZTHArPIPj2ZwcldwX5r+ou1LmGVfI2lo00SHP0=;
        b=f9HbEo3o4A4fFxAUJKEy3wRl0x5Mxx9Ybm5zeKImiyf/B8W7IXAkUZXV4gqAHrcXEM
         6aSe52iMVMU0Ef4ySkTlF8x2TaHdMxUIN5rQExsHrzK/Jv//4YDHimCpPvs6JF6GcwA7
         MD/w6L5Y34ja9Ji2Mx2m59oSiFkw8sGXIZrJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100830; x=1740705630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6B3FtZTHArPIPj2ZwcldwX5r+ou1LmGVfI2lo00SHP0=;
        b=W1RPwaxO7/h88zxpsGhaAaxsO/Dycq/kGZ+FnxpZ3kl0MgRRd8giWouEQsG5FTR3p9
         ONAZG1oXik7XcdCDk1hCV+mohvFZ57OgwI3x6Ru8Zb4vuBU6/UJeLHEkcsnNKMPlTkcy
         DRJDopomjtUFnVPiMT2RQRsJVGPnxdGEfj0KCvl2KwmFtTDXhfqOGjwIBnmefeRVEV0g
         roekAXQhkf47NneKN6YffHi0pbYqskSh2dgY0K6+0RQ5kd8o4KjOw5Z08Pa0r/lv/i9s
         J61akM9ZU6tFZ/Zqw2DyDFPJZteVzYdL+NhMtyqKNSu5cyZN5Uv55x8dAdhrt1oGYUIB
         Wr1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXX3+CkExW5kKlVj3vzoN/go7bsewFam2oaBBwZzcMO5KSk5u+cNcyjWtNMl4UfZoL553wD2JhBhI7Xmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Vn8yuWGQsaVa1wMDfBh1oFJ6TFMoC7WOuJSZlffzk/LJgD/T
	Ww/GzbWTYa/hvXwnYRsg7VFv06R3KpRMC3k2u+tjLfNEUX2P4dwftSaN3Ig9ow==
X-Gm-Gg: ASbGncvcMBJMoecvF9Ww0Rw9fIWE9eS4IGocBDB4cY04oIo3aLQb6Ly/ok670ZRzY//
	pqHoZVY2uf6A+mmkc/hZ3dyPuB4ZGzS4Ng/5o+gsHm9Dc4YiuO2GmQnij3HVfc0FDmxd8Ct2z/3
	wQbZUIqix8O7EslzWXJW/4JD5MKo9v5/P3CPM5ClpilGvkbp+1I7jiVKNEQ+kr8YdDLc5AqYACv
	l8ByrycNuDi3OIZUdoP+tAXYgVuapOC9f8SuZYHvteuMBq0Ll3Yxwg+DBwSqjCRQhHW+GapCR3L
	uaDCek40PVwAnMoorQ==
X-Google-Smtp-Source: AGHT+IHeIFp2n2yLTc12/J5sp5fgmZ4wVfS6kxoyp//xIO+R58ESY9aI1SDsY9hr74s+VIp0ZzU1KA==
X-Received: by 2002:a17:903:2312:b0:221:1eac:bf7a with SMTP id d9443c01a7336-2218c765b1amr90285235ad.24.1740100830599;
        Thu, 20 Feb 2025 17:20:30 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:f8d0:f3a4:ac2e:69d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73270de9b7asm9982285b3a.90.2025.02.20.17.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 17:20:30 -0800 (PST)
Date: Fri, 21 Feb 2025 10:20:24 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>, 
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/17] zsmalloc: make zspage lock preemptible
Message-ID: <20250221-095831-265429292-neomutt-senozhatsky@chromium.org>
References: <20250214045208.1388854-1-senozhatsky@chromium.org>
 <20250214045208.1388854-12-senozhatsky@chromium.org>
 <Z7eAEKpZ7VnGsVej@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7eAEKpZ7VnGsVej@google.com>

On (25/02/20 19:18), Yosry Ahmed wrote:
[..]
> > +static void zspage_lock_init(struct zspage *zspage)
> > +{
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +	lockdep_init_map(&zspage->zsl.dep_map, "zspage->lock",
> > +			 &zspage->pool->lock_class, 0);
> > +#endif
> > +
> > +	spin_lock_init(&zspage->zsl.lock);
> > +	zspage->zsl.cnt = ZS_PAGE_UNLOCKED;
> > +}
> > +
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> 
> Instead of the #ifdef and repeating all the functions, can't we do
> something like:
> 
> #ifdef CONFIG_DEBUG_LOCK_ALLOC
> #define zspage_lock_map(zsl) (&zsl->dep_map)
> #else
> #define zspage_lock_map(zsl) /* empty or NULL */
> #endif
> 
> Then we can just have one version of the functions and use
> zspage_lock_map() instead of zsl->dep_map, right?

Yeah, maybe.

