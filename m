Return-Path: <linux-kernel+bounces-526648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2554BA40187
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6454D19C2184
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E5B1FBCBA;
	Fri, 21 Feb 2025 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g6F30OrX"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF81D5CCD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171690; cv=none; b=QW00bkI1HBI19mIPWvAlQ9D8oWnVxSXdIGVRs0jEHiQqMLILsNeRczoyU7XM0T3FFyuT2PAsbsJnIk5VaVbkh/kpTq7YYFxtvZMwTXCQXmZf2c7hVNHVFD92FUXC+dYKIgn9c/tEqdHsBeyRh7yd5z+Wq80SV5g6K+9XO+cz7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171690; c=relaxed/simple;
	bh=XSFShCnYMYY10Y7vBSTg39s9BZz7eybJ3/fTVBo6DPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okysU1tHZ3aAMCEj+SgJQdkZgryyTovZXLO1T+/UQYNpk4SIIE6YeGfqdU5g61kGu7KBY1/OXmWqLQxWDVtNMFgzoiodgOnrLlaafn2xjGTHZD4tOoYR4mxKu4ytstVfbPGZ4UNYZYssRt9MbuIAUkJwwHwf/vSeBgKLXWrb08c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g6F30OrX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso4603781a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740171688; x=1740776488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KB7zOw8AFw5HwaiJLyXfCqtg75nhb187Vb/57RmyT1g=;
        b=g6F30OrX2My7q862pf1rMMT++XYRh3CBipaEnPT6HEW3y/xiX8tvgDMLx1l4gOxm4Z
         jt7P0tkJ5qyfdAG9xl8u14Lv4wp3KeHYXjROfYa/3PEPukKX96ZgmE8II0pn3yec7QL1
         Tz0Khp0lkYs8tEnHZul8DBFf7+rXTWvbbSOq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740171688; x=1740776488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KB7zOw8AFw5HwaiJLyXfCqtg75nhb187Vb/57RmyT1g=;
        b=USIm6BgGVPp0AbT3FTE9MqLl/oYgaovKi1KIi/CsuOMKIJU5eJwzPmeOlNAOoIMsbl
         hRxv/JEGuNkUVK4+KBnor/8kkxyqAPdq3ZO9/G0NpR63CzJWeA4DMQzSRuQPjWxRLVTn
         ok4ZuyhXsVV2aG4zLRXCv7KvIvkUfRXv2oaFYYeaYeGukqy0wx7iNdzyZthhsquDtSUV
         7NsQpKzFLYIkOcCITZn+db9rkFTQJ3qR+QCAY1wiRUUyoFDmSkISRTdrdiLTNoUZJgM/
         ocsxfNFm1lUkUOUGoASXGhgUnxnpagOKSMCSD+XeZiIyn98L54sKOB4klwlok+Pkd3SV
         4hmw==
X-Forwarded-Encrypted: i=1; AJvYcCVl6H18vsmU4BIeVbNd6XnzNNZkFWS2V7u6V6b4Jal1wsXnXv1JsFvFSVI9tuIlph5UmAOj8itJbrHnAOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc44XLeAzvEQok/5GHiCcpXMFEELRhdXGhUSi7SNcYrc7uqwtP
	xKKdTprdBncW+aKPYnv1SoE4zTDhSh6bGUuaH0uWnNjyon2l1C3ISvYndjIxgyRdZyxI3OhvMek
	=
X-Gm-Gg: ASbGncticPR/oe5tNhKGdsR0Md4XsD9WLcTkiRGFmc6Jyo5992gNz3AtmSUla9SkcBU
	PXwwuXeR3uMFhC9Fv7ixZkTcWjiqNJuCz+BKR6heE/17ZEz6Tt8OZHh44RINHvp3q2ErhyGkaRH
	PhVonGfKy0XhFrWDI/6Cw802QprcOzNo0fhWQBsUsB/Wqs2sp1taS8riAzIkeRm8RMA1Ppgj6Dl
	ctYJn2JQsnQVxy0bZ2uAfVgfX0Jeigw0Kh0tIG2veJqvVcQe3/OF9lcoSXfo3uwm+pdEBeceSIx
	7Y2yEo8mmqOyzGVeFxAmy+P0MKuJ
X-Google-Smtp-Source: AGHT+IEs01Hx2KIewi9vZQYw0yu8X2kEXs1yphv1va/bFuzNYCs+BRNeDhKdyaUblwTlOF6avYXpxA==
X-Received: by 2002:a17:90b:3883:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-2fccc0f838amr13550504a91.3.1740171687113;
        Fri, 21 Feb 2025 13:01:27 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb05f2basm1833275a91.21.2025.02.21.13.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 13:01:26 -0800 (PST)
Date: Sat, 22 Feb 2025 06:01:20 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 11/17] zsmalloc: make zspage lock preemptible
Message-ID: <20250221-095831-265429292-neomutt-senozhatsky@chromium.org>
References: <20250221093832.1949691-1-senozhatsky@chromium.org>
 <20250221093832.1949691-12-senozhatsky@chromium.org>
 <Z7jYiuRlC7_8_wzD@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7jYiuRlC7_8_wzD@google.com>

On (25/02/21 19:48), Yosry Ahmed wrote:
[..]
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +#define zsl_dep_map(zsl) (&(zsl)->dep_map)
> > +#else
> > +#define zsl_dep_map(zsl) NULL
> > +#endif
> > +
> > +static void zspage_lock_init(struct zspage *zspage)
> > +{
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +	lockdep_init_map(&zspage->zsl.dep_map, "zspage->lock",
> > +			 &zspage->pool->lock_class, 0);
> 
> Can't we remove this #ifdef as well by adding a similar macro? (e.g.
> zsl_lock_class())

I thought about it but then was not sure if having a macro
that we use in two place is worth it, but I guess we can.
Let me send a v8.

