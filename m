Return-Path: <linux-kernel+bounces-255421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE1C934089
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73AD1F24617
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2A6181BBF;
	Wed, 17 Jul 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQP7pP3O"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414EC181323
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234048; cv=none; b=Zy5P/leZv7uEORfQp0Jlbs9Pk9WtvHWH8xHj2yMxtgY147igaNIewxk1djnOM6Ow1YqZNWykgoDvN7W/xtbr+OB8XiFiH5TE43RPvkR7x4uRe0hNUwdMg2EgfDdLzlqQ2ZCtcaOagjpeoToR7VBses7jrT6stEr4FEGxy2TV/eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234048; c=relaxed/simple;
	bh=32qbVbdcIIo082PD1NEo17pI9Fe6+jCMt4sWhJ+oEKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhS55RddeoiyjPZYXj5hHpbqWnHQDUYrDqw2JcWged0Ah999fmryzk64AjgPMSFFbFTKxM3j95Fp7FO1rNY84dXbZfi3D7Muh/yj1B5e6SVZxYhAD3N2sbl841GfbOuHmWc3nMGmfkFh1S6Umh64NtXyr4uQB9I0F4ECTkIqSkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQP7pP3O; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ee92e3a4efso7113001fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721234045; x=1721838845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=32qbVbdcIIo082PD1NEo17pI9Fe6+jCMt4sWhJ+oEKQ=;
        b=FQP7pP3OcggaoG2xiUoGcFqJBz8a7b5m0aKCGwBIF0roXtiGnqcsryhbdlRB6NUE2V
         8wPfD4TncvSxyv7kgntewS5OFhUd0SiTTsw0s86oNcMXpae5NaJ5FYPFgMVxynNZEFLm
         MAM+iB9tZWNy7P17VuAi6kECyrb+KOCnDqbZDfx0NffOWMV7DKofG+P0+MFOoOhyrIXh
         dzEtZjYmbg9lXJQdJR6aA4QFYLLsJlzfeYGqBOwcVvWbol/RiXytzMthtRciF7L6W9IR
         SwMOresse0OYD/kZoE+2LnvrGyoagP8TtSqS2fai288d6t+JJ4y50YjlNhwRuhAlIU1M
         dlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721234045; x=1721838845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32qbVbdcIIo082PD1NEo17pI9Fe6+jCMt4sWhJ+oEKQ=;
        b=vLxiqDUTTQDczEcGBcDe7G62X8AS3fReAfjl3SjCtFVB47qQS5ZTEKOCWeoDwU9HDf
         FYWVrfkBVLgxv2L9vnPB6LfYkhBr+rOt1K6VXAltlminKlH7YuxB3SI2zUZIZACpxRIi
         RtYIeb4VaGusdwu9utyO6rbMBO+o/WTUq8mRY0LL3CZCEDiayVWkDmtoK6F3FTqWGmIf
         5TcfRO2udYYpKqX/Fg9kkr6xm8r84nMF8lHMhHcw3hnJFB7L46ftmw5H0JbHLExl05jK
         R5VwsJew6Yzcb7TNjj3kiaMdY5vcc6gu2GpKrxMBnvHDiVr3axMjdHZ9LXqie0s6htD7
         mFCw==
X-Forwarded-Encrypted: i=1; AJvYcCXbN/Xk/PCaXzObAlRb1bLRUyqEzlv4bvQ6nRU5f9jTApu5vNywVT8aE5XqLZcxO88oGDK1jaQdO20yZXgzC+xN1nXazHet4HatKsLt
X-Gm-Message-State: AOJu0YxZjwuHDseTiPsTdTOXgrnkhLFq5mMn/P452Byx0ERxRQJa8ryE
	78qs4tfYQZZRyUEO+aFqQ3F/JVZw2hkPNr81rjAKPzJeq5S+gzk6
X-Google-Smtp-Source: AGHT+IFHoEqW03F6S4z6swFivCqKl+77KnSoWGbGJ5TX/ZETCILoAnLRjscrZ9ghdPSFooND/k9L8g==
X-Received: by 2002:a2e:be24:0:b0:2ef:81:aa5 with SMTP id 38308e7fff4ca-2ef00810afdmr9009701fa.8.1721234045118;
        Wed, 17 Jul 2024 09:34:05 -0700 (PDT)
Received: from ed.ac.uk ([2001:630:3c1:90:1614:6de0:61c7:40b0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77a5804sm3671585e9.16.2024.07.17.09.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 09:34:04 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:34:03 +0100
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Bharata B Rao <bharata@amd.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, nikunj@amd.com,
	"Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, willy@infradead.org,
	yuzhao@google.com, kinseyho@google.com,
	Mel Gorman <mgorman@suse.de>, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
Message-ID: <Zpfye9DcmmB5JB38@ed.ac.uk>
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
 <3128c3c0-ede2-4930-a841-a1da56e797d7@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3128c3c0-ede2-4930-a841-a1da56e797d7@suse.cz>

On Wed, Jul 17, 2024 at 11:42:31AM +0200, Vlastimil Babka wrote:
> Seems to me it could be (except that ZONE_DMA corner case) a general
> scalability issue in that you tweak some part of the kernel and the
> contention moves elsewhere. At least in MM we have per-node locks so this
> means 256 CPUs per lock? It used to be that there were not that many
> (cores/threads) per a physical CPU and its NUMA node, so many cpus would
> mean also more NUMA nodes where the locks contention would distribute among
> them. I think you could try fakenuma to create these nodes artificially and
> see if it helps for the MM part. But if the contention moves to e.g. an
> inode lock, I'm not sure what to do about that then.

AMD EPYC BIOSes have an option called NPS (Nodes Per Socket) that can be
set to 1, 2, 4 or 8 and that divides the system up into the chosen number
of NUMA nodes.

Karim
PhD Student
Edinburgh University

