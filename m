Return-Path: <linux-kernel+bounces-268321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BF894232A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908D71F23275
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CBF191F67;
	Tue, 30 Jul 2024 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chJMdlIU"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58E718CC1E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380181; cv=none; b=nzFOD3JQlQHRL9QcsOEQPBgIbfOaO2f3b4CUtcoIyi2LvbACppgYZI1NgyX4nZG67X9QYxRSPGsjk1GhnDKCLO2a3FQY7oIVbVigpqLCfVx3bJbPgw8G6XmuhddpC3UK+P4Bfmunqux8lwtRObC/SKeyl04lDF8RaF6r2JU6VqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380181; c=relaxed/simple;
	bh=Jy1zXet50TvN+hFwIwsUpfDkUL5Lu8EsnFXzE1Xq/iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4Tz/mOkvECEL0NtXS4wHQz342KkiaIM3oYb9fJKeAK4BiaxB18hmeGmVk64/cuj8Um0EN5TDd451TaaMlOyLuhEDSh2Z088syXRcKjFYkdsvAopj5YVpA7HJ3B6RMpXR1/x5JrqUU0lVjKhKNe+/HOdYfW0o7lQ2BD/j4lrYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chJMdlIU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d333d57cdso3558578b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722380179; x=1722984979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpezHkvdjy1MlA+dO0gKXwYP8ordkQyr69OAF6y3Pjs=;
        b=chJMdlIUndbooojtYL7u6ztEzvyjOuLHka7+gqBp1/HbBsTBiulvAKpAoTT2QJT5x/
         7PNvlCqp5a5qF3Z55a8q5H7nF74jI4H6AfPhhjeGaYRj5X5vUfmBxc9vQQ2kOjRflIyb
         fErKXRs4AvjZ/y8JMbRLfNTwe+bOyUmMMlVD8MmgW7sCi+lVvGBjkrYaEyasCc6YgRli
         Fchk9/AQmH3Q2Hrlgu8wQoHZBsmxmwnJ9wtXvtiB5dMNhOLtP4yH5bu8PW05cCYZFeMC
         BxlbJ0ASwlWziwPrtxiwXvNYNEkmYbFHC5h5sYV21+Ma21BwvgKNgjpIp1FjrfdXj9Su
         CP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722380179; x=1722984979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpezHkvdjy1MlA+dO0gKXwYP8ordkQyr69OAF6y3Pjs=;
        b=j3azUOrN6cTpf/HsHwCVfPU1eRE1TTlQri7ZoUtSbhWycXaVOpGTn73HxiKKuKSWgp
         rFD8GVH+3G5wIwllna+TcMQcqqr26gyXfv0HsviNQTCI5dbzK0lvn94xMkvglIB1QnPu
         9CaSbcJmAp/ExI4ajsFuJ5OXNvyFp4V88A8meD2vblNJwuJaseho+CoLKJGzbvYE4RbG
         kJfSMTVetmcKzvq5LSZ1NUr8rBKGcFXN7YjWcPZv6D1TWHAKJPlfg23jvGnu8Ef+qkjk
         he/UVJaDCkwY7r5+Q589nwtAmJI1tWXyNXgEGTWuRhZnC/hfhHLTgYFa2tSpHEkC4n6I
         kkUg==
X-Forwarded-Encrypted: i=1; AJvYcCU14NEkxTTNFvAuTU1SF70H/CubjCTCjdwu5NRCj/pIbh2HWOEqwBEsui3Gw5axAU9Ac8iuQ0X2o/IU6gQD3m/ai9XNF+5yNR7har1u
X-Gm-Message-State: AOJu0YyzoRJM10vt25J/UhTzMut4gdvopAGtcS92DBXcTvXD7o3R5woa
	pTnDwTzkQ9VTZlHL4DztQh4+KG96XdK/6p1aGuGZa4Wn+OHRx0NGmRzkkw==
X-Google-Smtp-Source: AGHT+IEFsNvh6YZbrzZOxYWiNatZm9h2D+IzSj1fF1gCLZedtbzz+noDtkqPWsgKmSkEqz2qKNP5Kw==
X-Received: by 2002:a05:6a00:2e90:b0:705:9ddb:db6b with SMTP id d2e1a72fcca58-70ecea2ed28mr11584399b3a.13.1722380178823;
        Tue, 30 Jul 2024 15:56:18 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a2bebsm8917764b3a.212.2024.07.30.15.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:56:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 12:56:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	christian.koenig@amd.com, ltuikov89@gmail.com, daniel@ffwll.ch
Subject: Re: [RFC PATCH 1/3] workqueue: Add interface for user-defined
 workqueue lockdep map
Message-ID: <ZqlvkdIoZAkVrvvx@slm.duckdns.org>
References: <20240730221742.2248527-1-matthew.brost@intel.com>
 <20240730221742.2248527-2-matthew.brost@intel.com>
 <ZqlqYLZWCiLKhVJf@slm.duckdns.org>
 <Zqlu8gq2d8mtn7rC@DUT025-TGLU.fm.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqlu8gq2d8mtn7rC@DUT025-TGLU.fm.intel.com>

On Tue, Jul 30, 2024 at 10:53:38PM +0000, Matthew Brost wrote:
> I didn't want to change the export alloc_workqueue() arguments so I went
> with this approach. Are you suggesting export a new function
> alloc_workqueue_lockdep_map() which will share an internal
> implementation with the existing alloc_workqueue() but passes in a
> lockdep map? That could work.

Yeah, add a new exported function which takes lockdep_map and make
alloc_workqueue() to call that with the embedded map. No need to make the
latter inline either.

Thanks.

-- 
tejun

