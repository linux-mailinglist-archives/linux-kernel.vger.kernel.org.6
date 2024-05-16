Return-Path: <linux-kernel+bounces-181609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC54C8C7E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 00:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D3EAB21BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3116639AF2;
	Thu, 16 May 2024 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oKOTPOm0"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8CF19E
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715898606; cv=none; b=OCMccY0jW8mdfu3m4qAXVfB3jPHeZE/hk+fi5E1PLSdHkpLOG9xZNuiDEO1zWlqLD+HGCT2yI5P1QiAfWlF3Oy69lD8NMVkwZCbRn6kqci6FcW//rcClAR0nl3y0tBdUG7TekD+EBwjQ3XbQfrq+GDCTdGmHhB943ymUa4cmEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715898606; c=relaxed/simple;
	bh=bxJEArpiEg25RQVYJ7nQ2XjgM8pmuWp4LpMZBqOClSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEmBAW/G3iH1XuAaDt1N1DqvGeyDmxrpHoLUTdkHPM1lSK9rp2NZuvtQLZO+kXchTcyLCynsvEDZZgfBNe99KUZ/Qf99RnHmSAneFLi2iGVz4BzngYMUyKjCSLTLQyPQJ0nR0iAqMjjO+btTeOytSoJFGH+qeASBc7a+ju4XvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oKOTPOm0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e651a9f3ffso218055ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715898604; x=1716503404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hxv5sqy4ckTc1L4pK/+kikfrwo0o601loVWwBqZZcRA=;
        b=oKOTPOm0cF6YZHXG39HygnpLjkLYCHKVRctrkfe0HOzqj6cq1poZt+Y2szOiA/TOfd
         p9JgjJyVXHGh8r/+ySsSlaFLaIhgHw0cNdtmDItEF1LfTqvXm1/s0poxHG22CRNwXNym
         fjFcRjZGAMSFh09qIxwPkI8VwCRbKLo9BJTH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715898604; x=1716503404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxv5sqy4ckTc1L4pK/+kikfrwo0o601loVWwBqZZcRA=;
        b=qgsdYSXWRPl2+UWwFwwr1YKvvJ88pC77YYXw1cIo3+1IIFJ5RmgwE1+OJpKB0DJL9R
         ZQ7S44m87o8F0S3DJhUrQxT4c/ZDwLE/pRJPsvA0n89kkpNAeniX/Z2gCi3R4OJ0s75R
         M0MghiQyS7Cab2IVTEUT64Y5Tel+Uy86t/5BJkFQ7dViS5jYTQVTrxS6PUT8V9CCkCTF
         S7C4zKM6DS2X4A3wOLWB2RN83gLsn3OnkLn2LNeuMwadKoj1pbWL4/Qzh14JEE7VoZAl
         8l7FpR7tdWs37anOj67IXX8cLRavN/XxJzBV/1OiqewZ7Df1mGDJb93a/XotUSlYAtel
         jQaA==
X-Forwarded-Encrypted: i=1; AJvYcCVLegmsgdrtQPBwKnDJ5RS3Ave25sAFGR3NtjfG4fYHLhfIVRV1ObfGNQp6w9yN/LZT+efsh6JFzfxsjXI/9tfvogL1ftmhpH879ELI
X-Gm-Message-State: AOJu0YxbC2GFQ48+lqOUsCyHAxIrshaL1JSRpqsLYM1i44gcslpoezd/
	p1nsmFW7tCceF6JE4jKNFNwGhJTapQQ2DsvkTBE8e5tbSn9fdLEgEhbGkp8Y1w==
X-Google-Smtp-Source: AGHT+IFjAjuJ64KMGDPWNwFpNItuwLnAZXU5qrJU+caeXV3r2Su1wQ35UrWZx4wDd/Noatyf85y8Lw==
X-Received: by 2002:a17:902:dacf:b0:1ec:c9e0:c749 with SMTP id d9443c01a7336-1ef440505a0mr240359545ad.48.1715898604590;
        Thu, 16 May 2024 15:30:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c1394b8sm144923735ad.271.2024.05.16.15.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 15:30:01 -0700 (PDT)
Date: Thu, 16 May 2024 15:29:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>, Edward Liaw <edliaw@google.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest: Desecalate reporting of missing _GNU_SOURCE
Message-ID: <202405161529.1D2B5F3CCF@keescook>
References: <20240516-kselftest-mitigate-gnu-source-v1-1-a0e814ff2874@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516-kselftest-mitigate-gnu-source-v1-1-a0e814ff2874@kernel.org>

On Thu, May 16, 2024 at 04:28:48PM +0100, Mark Brown wrote:
> Commit daef47b89efd0b7 ("selftests: Compile kselftest headers with
> -D_GNU_SOURCE") adds a static_assert() which means that things which
> would be warnings about undeclared functions get escalated into build
> failures.  While we do actually want _GNU_SOURCE to be defined for users
> of kselftest_harness we haven't actually done that yet and this is
> causing widespread build breaks which were previously warnings about
> uses of asprintf() without prototypes, including causing other test
> programs in the same directory to fail to build.
> 
> Since the build failures that are introduced cause additional issues due
> to make stopping builds early replace the static_assert() with a
> missing without making the error more severe than it already was.  This
> will be moot once the issue is fixed properly but reduces the disruption
> while that happens.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

