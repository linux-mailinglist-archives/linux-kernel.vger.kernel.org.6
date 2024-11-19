Return-Path: <linux-kernel+bounces-414046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 599D89D225C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED49B20F04
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97D19C54F;
	Tue, 19 Nov 2024 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c76MvF2g"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A5913FD83
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732008066; cv=none; b=bImtNacAul3tRtFpgKd1d523xDKwdG2iGow5j7qiCs+yeLYlG7b0uEPH7bW3JHQ9qc8KTiStAXmxOKGGgjJENzmB1Ayn9R2YtwIue66NJyIDocFjha10wU2zcRHmC29NCqUd4a5Cvb6Ow3PXtTgXjT3b3lKhsrNrq2S92Nl5ofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732008066; c=relaxed/simple;
	bh=CzgZPQkB6V+q59YG1e8JnaleyQ8d5xZWpjBkzQl5m1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK2B6FHtWUuFn32rOBPqLP1+vP6IYxibsRSHrNFumjQvbioSFkDdsY5ISAG7oVycrV14TeKv9sg+aVmMfkBQdCXADwLTAcox1oc/58yJ7v0PPORuEKd4yImyTcBV+Q/CCtgAZIHIDy7ze+R2wPL6amV6EXs7tdCZF2dKkx0m0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c76MvF2g; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso569286b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732008064; x=1732612864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HNjfiBdLKPlGRw2iGcWxAqDoQ+YX9jcbPGBmsbo8owg=;
        b=c76MvF2gKRAMHfgKC5W4KuU6fQU/sXK4fk98vCPkzBW8qyW+9U8Kbl2zOwr2mko8bv
         wOPBm1jBzO8kUSEZcGaQ9GUlJYVgGH7FmXmPYcmg1jb3bfGQGyvKKgeljTJjGPwgJB+l
         d3PmJMpbCBqoO1aF+UioHTPzFKCau9ng/e44U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732008064; x=1732612864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNjfiBdLKPlGRw2iGcWxAqDoQ+YX9jcbPGBmsbo8owg=;
        b=R+/+vZCbzfKShDJJ04amTDv3B8vAv/zR5kRfHmsrYC3l4YrCidYAVON3LMD/81S9F6
         dlnUyHzVjdAAuDX4pHcARns2p0TM6ICivLvFKtsiNXmR6dJCSz4wCkDmKK3Eu+HoQ+Kn
         3rIRviCmwD6WozhWSiUrlCDsnqLni8no8xkZ5uv1FZrb1VGEcxuULDRVfO06RhcTiGsD
         48W7E7dK8Nj4ZsqBBgeKg2H5VofodfCOHPdFXtwOuTMwJux4aeV59BsFWxHZqqegE99I
         +rHIS+CzkSA6pEqCfMAqUNy+nnnvDTE/N91yPiBVS8LsTW1Kp9OOyp986shfV5p+YiCY
         kYdw==
X-Forwarded-Encrypted: i=1; AJvYcCXkEECOfx1oaJLhrtrOtIPE+33VeyFTB/OrxzDX2bmwFd0WHd/LJ2aa6SK0B1YC0T32yOQ/us7VvOuYM/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxArsVciybykpHOml2bZbDiDOoSPUIjqmn2/RKJxkD549jLpEXC
	bbK9cfjjE6MH/Y8w3jeEc2iJFAkXLLEVZlM5eg6LnOUAR8ZiVRBbJgq6TJOH2/X3SDXkYFjor+E
	=
X-Google-Smtp-Source: AGHT+IGluIr3+H3FE5AnVN8K7Vdc1zZ7vQIg4AV14EH7qMyFXvnEmozz6o7awjN6RK51MPWRD5GHVA==
X-Received: by 2002:a05:6a00:1790:b0:724:590d:e320 with SMTP id d2e1a72fcca58-72476b96351mr17810526b3a.7.1732008064029;
        Tue, 19 Nov 2024 01:21:04 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:5534:f54c:1465:9438])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e1324sm7575559b3a.133.2024.11.19.01.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 01:21:03 -0800 (PST)
Date: Tue, 19 Nov 2024 18:20:59 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv1 0/8] zram: introduce multi-handle entries
Message-ID: <20241119092059.GC2668855@google.com>
References: <20241119072057.3440039-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119072057.3440039-1-senozhatsky@chromium.org>

On (24/11/19 16:20), Sergey Senozhatsky wrote:
> 	ZRAM_HUGE objects are incompressible and each takes a whole
> physical page on the zsmalloc side.  zsmalloc pool, naturally, has
> some internal memory fragmentation (within size-classes), so what
> we can do for ZRAM_HUGE objects is to split them into several
> smaller objects (2 at this point) and store those parts individually
> in regular size-classes (hence multi-handle entries). This, basically,
> lets us to use already allocated (but unused) zspages memory for
> ZRAM_HUGE objects, instead of unconditional allocation of 0-order
> page for each ZRAM_HUGE object.

Forgot to mention, this is still just "RFC".

