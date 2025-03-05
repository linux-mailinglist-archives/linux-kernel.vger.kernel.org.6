Return-Path: <linux-kernel+bounces-547087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208E0A502E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C349178F59
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E61124BBFD;
	Wed,  5 Mar 2025 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="t1ah6G4O"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058BB1DFDAE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186274; cv=none; b=D/juQN+T9BjYnLo+6tpK67ieavcWWxDBk9gAMiRu2tq/NbXV2MLCCHtEOL94+RU9ss6LdVWz+6CwHmCU11fniMCeuy0sBUM3FqldAjyg7nk+m6mtBYHiDWk0OEwhFLE7tfHOl0H2WgIEOGWPaiqgkviPl5V9B/JN8uCdYYsOKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186274; c=relaxed/simple;
	bh=QEovUa2vPuSfFEuaGcUn0/mw6ygH2tQWr5wDjTOF5NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKNdBzFHRhAspaFa5xcH/Admv823lXmC7HjRn0cDcbvKVUyCEG1ftSJFYpuesnKRfx9OtXpC/U/9dxhvu+uBpxuOBdyRi1iTEA8yz6xokd1eWfGBQc1Wwa669aO16ZbbgBDpFw6nmv6C3KJiV+TMScL+05qtyDYNVvqt/j/+i70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=t1ah6G4O; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c08fc20194so1141569185a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741186272; x=1741791072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dE9CElg6HDSShGu/kQ3s/bjFB1eIULPlSk57mBPS9Lg=;
        b=t1ah6G4OdpCA6HKqk3ZQZMoYFEayJNnK/9DukkW2JoIjwyf85P+qCdxOqXx4ggLY/G
         1JMBvaxdWuQftMkq/qrG0SG5bLu43RICtafiHsXdA0ufRTvxwilY96crUL0bFG9v0pH9
         K0/JUp/v+/i3sLMVl6AMowtnXFbZcL0clH9v0EG8ldCmFk8tcmo9VXy7lFaYFiu6z+rm
         g7eXYuYFKOEfeBrI4JFAikhqlGJ7/vQynt7VxZ1sFn+jDSS2t2EA6g1cce6jTl+4nsiT
         Dg/0T6uB/jG1CssnddGHoE2jmdN0gZKCTaCG/kB1yFoQpPUfaiI1kaq4yyqfps32esXY
         MRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186272; x=1741791072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dE9CElg6HDSShGu/kQ3s/bjFB1eIULPlSk57mBPS9Lg=;
        b=ZqAFNh/3RPxFlnJTBndBY7JR/She7P2IM2HTeh6ClaphQkVgndwitJGjJ9mqIWdtVi
         b9OB4K8acXiVOYUgRlKjw55pJDANg8WNHV93wgSFR72s2Mp59t2N12Fa1mDlHTBsUJOV
         pz78dalCAW2qYypXO+mRk02YJQMRANnqi1K5HWa4DDyw93hqBJL9BqlHNgM1wcRjdZ37
         dMu24WaJNhvpZCJycihtWjTJBizcGKmlWXkRdmlDKzAHAo1bV1cc2nxvmDsV6MiQh5v9
         wPe1ZMQafNOeWFxvm2QtCQuf11Yb0tbXE4jVUOki2o5GJGt9j8tVAfzboM4DUl9x0xki
         X3zg==
X-Forwarded-Encrypted: i=1; AJvYcCW61XM5jSqZzeGSYm/DKNayWbToERTq304t1tN83D11ZXkfByYrtXpFsAbn8trqr0ziBshZ4Gi8fRGHBbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykThbB4OSpU7ccpnM32GPLYwvR3cj7e2XD7eXZaJ/eXYiIVR6D
	LGMHZ80/OlR1Tbm3LX2j5yX8YEN6nLz2ynWXCLbvA2+qJJfqY5AOZmHu547G7ok=
X-Gm-Gg: ASbGnctuCxnKJj/LS4SFNxIlDTSGHDuJIaBgpX8EpxV0ZuYKhPUmBG5tM8iIDEKTdCT
	Pf6MTFBYvo3CWEDzSiW5iWkmChwuN7cB5XIVdY87EN3g7FNiMQTGWLcU7L0g2Xqv7QneSXPU/JP
	aHKPRY/vWdOWYiWD1wrZnptzs/voGyyuOpEjON9/Wa+dYtaUql05BbC107MyUvcDwTIAJ/HWf3W
	x3bBs05WD11/STAkJrBGVxQTScOvOF5uWG2Obe4ff5OP5EHzKBRDCpXyX6jmps5AzjsUU6fWaoK
	hPA156qnu5+3Y7vE7lbhGXiDdmALediLD0Hvlt+/U0c=
X-Google-Smtp-Source: AGHT+IEeLC5roNaM/wkwvPtWJP1dEnBUAK+Q42BMCB4U/KlD2DKVib/MyRcKmz4mqDyyFQ4coaZA9A==
X-Received: by 2002:a05:620a:2b96:b0:7c3:d5bc:b76c with SMTP id af79cd13be357-7c3d8e093e6mr485551985a.26.1741186271898;
        Wed, 05 Mar 2025 06:51:11 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c36fee8a08sm894054885a.6.2025.03.05.06.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:51:11 -0800 (PST)
Date: Wed, 5 Mar 2025 09:51:10 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 4/5] mm: zsmalloc: Remove object mapping APIs
 and per-CPU map areas
Message-ID: <20250305145110.GD185622@cmpxchg.org>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-5-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305061134.4105762-5-yosry.ahmed@linux.dev>

On Wed, Mar 05, 2025 at 06:11:32AM +0000, Yosry Ahmed wrote:
> zs_map_object() and zs_unmap_object() are no longer used, remove them.
> Since these are the only users of per-CPU mapping_areas, remove them and
> the associated CPU hotplug callbacks too.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

