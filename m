Return-Path: <linux-kernel+bounces-170220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F328BD3A9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD9E28399F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A11215746B;
	Mon,  6 May 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fwdua1rm"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0C15531D
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015392; cv=none; b=suRkhMCJeMXJ/C4axCGi4L2HNxttN3cFmALU9uEOVibZ6lEwi2R1GuM25Tts0ghmO8jHfK2TsPEZwAjh9cvIcAI70j2ox45T0B8HakpAPR0uDNWSIqbllJztO1JA9LM7n3HVSGO64QjufnbwRNsejh4Yh3mDhnPWg8AzufUXvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015392; c=relaxed/simple;
	bh=FPfkrT81hp7EWZ9SSFPVunnBkdnOppvnIkzF9q8A2r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeBdH+xaEaiJX/2BQINb/+GxlZnqZjYeVSBsOZIniBQ3KbBXhsIo7riC5oPcubjQlPEPkQTPGUuVjTOyk5moSCKAyzKWSpFfOup597BlXNB8jMT71pCsgtwNJ6tjjqQSGKZJkCPRcJz6wImeV/x64ecXaek/AaQouu7RdmGcWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fwdua1rm; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-61c4ebd0c99so1416581a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715015391; x=1715620191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mdReYnfYpXbw8UTYqzLrE/VJPRPi8vsKw/zSYHi1u0E=;
        b=Fwdua1rmaLUImbBBUgR98s4EdO2BoaTy9MKMceN3cIznO5s/C9Ozhrelnj5nUWxqGC
         +5vzSCi5VjfFbb1/csMH4PaAh81XmEltUkYHrisq8ido1XFgLYrPQil548qlGbzCwhcX
         oSUlnoj9p+UUA0M214EfiT8OnQY8dOGw7YBas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715015391; x=1715620191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdReYnfYpXbw8UTYqzLrE/VJPRPi8vsKw/zSYHi1u0E=;
        b=EQhPSnibiEBvuBFrfkKZTpcLaq8KlpEbxVBYh8urSA7E9rioC8mYhNYg8ERTPdtgFL
         gcCpkxzHS+OPcExaX4arn0Le12u9dAWg7uE7oycUy0FsGBPsIwFM84PvzaDWlsl40RfT
         qArw4vYixVZhozQ9ele/6Z8+ii4Y3iVqJs2rGrZw2hFCKYKrQyMyclkGcy+zulMAKX5q
         jFNdz1WJEQLPyxImoJVTShrhLLY3ZoDupWt7hhGBPMitgK5KsFS3FEPbp1jQbBTPh09K
         /gAaFNme7TCVkhs3/9frrbbdhvdoKeVL3loAdXouV7OVmKic+SeYqaBAgsvYlqE41Pim
         s07w==
X-Forwarded-Encrypted: i=1; AJvYcCVUyRz9ozUgCNtk/y6dzr4L+Z9ddGhBBtpnKo9ggMowl1yg6t/2X+8twt9iR89p45UiEspkuG93mCLXF6H6jekdzABmUCzumDcVtYAp
X-Gm-Message-State: AOJu0YwWXopjnpzO74UL1SIu05fim7KwHDaASKzwp6GM2+77zVjkvjhs
	e7yFOcLLnq8EdhG91Yzd0q3WEYKe7N6buFZJP+DLrXsDHLUkG+C4RYf0roe5KQ==
X-Google-Smtp-Source: AGHT+IGxUieIOzFQ0Mko83hxGUk+gEzoGxA/1Ap+Bl/r+WCemjUK5IeIzFbSjiBsICA7ksrrUH4MtQ==
X-Received: by 2002:a17:90a:d496:b0:2b4:3679:183e with SMTP id s22-20020a17090ad49600b002b43679183emr10938107pju.21.1715015390728;
        Mon, 06 May 2024 10:09:50 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090add8900b002b269962606sm8407951pjv.30.2024.05.06.10.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 10:09:50 -0700 (PDT)
Date: Mon, 6 May 2024 10:09:49 -0700
From: Kees Cook <keescook@chromium.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Mark Brown <broonie@kernel.org>, linux-mm@kvack.org,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/exec: build with -fPIE instead of -pie, to
 make clang happy
Message-ID: <202405061007.F1A46E89@keescook>
References: <20240504022301.35250-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504022301.35250-1-jhubbard@nvidia.com>

On Fri, May 03, 2024 at 07:23:01PM -0700, John Hubbard wrote:
> clang doesn't deal well with "-pie -static": it warns that -pie is an
> unused option here. Changing to "-fPIE -static" solves this problem for
> clang, while keeping the gcc results identical.
> 
> The problem is visible when building via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> Again: gcc 13 produces identical binaries for all of these programs,
> both before and after this commit (using "-pie"), and after (using
> "-fPIE").
> 
> Also, the runtime results are the same for both clang and gcc builds.

Thanks for this! It got solved differently here:
https://lkml.kernel.org/r/20240416152831.3199999-1-usama.anjum@collabora.com

Does that work for you as well?

-Kees

-- 
Kees Cook

