Return-Path: <linux-kernel+bounces-321407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C5B971A12
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50C71F23456
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4051BA28F;
	Mon,  9 Sep 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NCvuzoPk"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8177A1BA276
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886481; cv=none; b=Kkz0G29XoCkIzTt/+MpyzEMG1wLB8JTBKErBwUA5OS+fc61Md2ya7xegr1O+YjGdljBHhb5CJO59Cod0etdnPbW1a9Yrg2ivvMuhtFdbN0UgqyjQ3bRZr707LvXfZw1t00zCq6YQEoTqIGlW6kRJgTUZPQaucGvxAf0434VCUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886481; c=relaxed/simple;
	bh=TxIhcw1I4E02FX0DTYH9rqZBEI6JY6/AcgRBzKSHYTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx6GXt6moxVehj4OQ6QxsVkDiidP/xwttMOS8hMoQP3tDnK+pg7fkHVssOTldARXSIlfL5F4xk3aSCV6r1pY74hRcyTuG20aTIRW2mEiqjaFg/HvqAxMWeLg5tr9lP+BMrgIwt8tmLUJFEsQUaRyLGayVMuTu3szqOPpXotHA44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NCvuzoPk; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso705050766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 05:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725886478; x=1726491278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U7+Xpcjf7xyQnYCvMlua3NxoLEuktpSDyXy6KT9XfFE=;
        b=NCvuzoPkOmOFHadgPa8rpK9Q7O1vhCq8T4O4R8ZNEserij5/hoqRTKJGupnjWOCHur
         S02Kwb3iMyM385QOPPCQAxEo9A2PwL73TwdoEgYl8KsVqA5bUTUd8qhzHtIxeS6hwx5H
         XvQDSr6qEEb2U13r4q53y6bt6pFNAnM68E/XFHS7UT8AQIhbAiP9cZCWQZ5c1p44lo1L
         A/F+ZHtEP8i/55NiJZ0SqtjBSIEHLYdsvddjs7bok/07YWARCr67DZ+9xHGGfbglcvgz
         yrotxQtgH0fwrBQKMhLrXcgJLkidqmBm6wirogxKrHIxVH/8UhY9Br0HXuFwv00cLAUU
         NiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886478; x=1726491278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7+Xpcjf7xyQnYCvMlua3NxoLEuktpSDyXy6KT9XfFE=;
        b=Qq7gs1FbWTCSyWYuqw9a0AHbBmghy/vWDD8l1ulHSG32dDYO+3aeQF0QdNXxf+NW/S
         yUjEMU6V9yOd3JlDJHtPanNkpo1JtLh8u6wFXpQnwoiu+BdRaOa7G2rhCIRl6Id/SvZU
         IegaLOnwaFM7iNps8uB0YR1mCu+P+KUxOjLDmRGR5hIrb6OTx/Rs4D/Rd2ujb9lXy3jr
         uLuhr7CBBu1aFhmjAZwHCNJzthWz+8qh3OjThmxFVf82h67Kehk9wAi95YOOC6AjX0gc
         qDnZ9YMVGkHIXMwiUgaDYIATHEonMaFe4VwTnp5NJqZA641ybf+PDp9ZkVV4AGgAPvby
         qOCA==
X-Gm-Message-State: AOJu0YyEPwfWnhoJBvTZTzOJM0aYApAO4/E6yUl5yyPUC4W5xQhfrcec
	qKiNFL+ub8Aevo818kOFYGEc1jnb04r3+xuEz9CdYcs5tgNoQhKZWfrwHFqby7Y=
X-Google-Smtp-Source: AGHT+IEQWryyvTSWMxz1NM3hTRrLqBPB30mAQa/c8kl8d9EEpIhIUKwBA1gollP3v2LKLCA5lMvc9g==
X-Received: by 2002:a17:907:d2cc:b0:a7a:acae:340b with SMTP id a640c23a62f3a-a8a8644fc94mr1132333366b.31.1725886477752;
        Mon, 09 Sep 2024 05:54:37 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c61210sm338148466b.113.2024.09.09.05.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 05:54:37 -0700 (PDT)
Date: Mon, 9 Sep 2024 14:54:35 +0200
From: Petr Mladek <pmladek@suse.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 15/18] lib/test_scanf: Include <linux/prandom.h> instead
 of <linux/random.h>
Message-ID: <Zt7wC-FEM6ryVi8-@pathway.suse.cz>
References: <20240905122020.872466-1-ubizjak@gmail.com>
 <20240905122020.872466-16-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905122020.872466-16-ubizjak@gmail.com>

On Thu 2024-09-05 14:17:23, Uros Bizjak wrote:
> Usage of pseudo-random functions requires inclusion of
> <linux/prandom.h> header instead of <linux/random.h>.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Looks good to me:

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

