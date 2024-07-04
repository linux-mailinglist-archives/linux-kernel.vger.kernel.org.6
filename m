Return-Path: <linux-kernel+bounces-240819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5A9927333
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE371C24211
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7878748F;
	Thu,  4 Jul 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H5ky8x62"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22771AB51C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720085950; cv=none; b=bRFnGQs2DCDLn+TC12joZngjIA4WjIlgufwRzn2JWSwN4gXd5Oxlz3bbWl7dBibV7aRdEE4xJyoUswDdQgfpXZDMtplpEMUBKm9DX042+k2C75GcoSLJJIthpQ68lLHPxNeYaLtWkjCYaH4APo9RkCUWPfhHO0y9Dobh7is1ElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720085950; c=relaxed/simple;
	bh=Ys2s6wfPKTdNY6st1Y3BR4Waa735ufPB0CWHvUkIhOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M17VWV5iBHpWstMvkd49VT+cY2dqyPm1ojTQL+vLJcpe7QyDcJDCDPvB7ZIGWewj4D3IVR8pWvBnw/Kh2fOH+m1Iy4Dol3Ej8b2ldg1vJ07nG9YFZWqRgvMHEt0aMapXuMt2m/H01jhwhoLjndPR0E+Dx/J0SwZdDuEcB1jzqT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H5ky8x62; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-71871d5e087so265771a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 02:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720085948; x=1720690748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ys2s6wfPKTdNY6st1Y3BR4Waa735ufPB0CWHvUkIhOc=;
        b=H5ky8x62uOfZP27NKJ+GSjCaqr4WU2MrZG2Z8swDrw5xAIDMW8h0gRtuZLAkDnXzVu
         3CqOY5MmljnRimy+6FsEDRpyRCmFe0KCmzbJ4yEb1+5HvFk46jw+Fn0nA/byTb+xISNT
         ncT+oOs3XLSzZvrfvhDIpC5dNHyLeWTcOp3is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720085948; x=1720690748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ys2s6wfPKTdNY6st1Y3BR4Waa735ufPB0CWHvUkIhOc=;
        b=sERUWtSrmeB/9JBiI1/qnMfO7Km6uc/Pg41aXzLypt87du2jWyOMR9RM+qLFmISFL+
         PiY5WQkZZarynT22e+Yln+RPkW79CG7R30mnUfW34GBT5avX2NCUMeKOsEaS3xjyBFY3
         ZkIckKJBr7622a9wvSJA+kGisD586rXOWfGMPoRFwvBa6UX+5JjEmutgTjPZgQSk5yEY
         1odl/9AoVIud6Hx7NYbLMGITLiOdRqhWdRPXXGmbn8toUAzQdhdWG8OGES3tR2zs6LNG
         WXgTv6cYLB7ALXXCV70z18j3FgRU7+6MZCodVu9Cpk+YRdJct9IpL0gQqO052xAc6aDX
         z4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMcsUAbrzMV6eMsBOYe2nObYJgygghPn6JAp/6VDTiWHCGHcRBSCssnpZKNjJiHxy2RRUs3YJ1bT2RtuQjkMNzmI78pV46ia2LhYBe
X-Gm-Message-State: AOJu0YyDPLsdjYug/LMhe2z8mNexWMAk/7Ky+UPUrJH3ZZcygDn1pR1a
	gBSNLNFcems38y16ZzeCkqBtSmyYqtkDQHxQSJQpRp1jf1Q53GfJwOXxKRsF6g==
X-Google-Smtp-Source: AGHT+IHFV8ODDEu8wWKjCCRauRPD0y8C2a9w//eCdb5ZIFlSE8Kk9VDC/aqHLbkN7rsLC2/o2VT4pQ==
X-Received: by 2002:a05:6a20:6a0d:b0:1c0:bdf5:2a2a with SMTP id adf61e73a8af0-1c0cc73ea39mr1127241637.24.1720085948067;
        Thu, 04 Jul 2024 02:39:08 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3db1:715f:c72d:16f7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa321cesm1033744a91.56.2024.07.04.02.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 02:39:07 -0700 (PDT)
Date: Thu, 4 Jul 2024 18:39:03 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH v2 0/3] zram: Replace bit spinlocks with a spinlock_t.
Message-ID: <20240704093903.GC3232210@google.com>
References: <20240620153556.777272-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620153556.777272-1-bigeasy@linutronix.de>

On (24/06/20 17:28), Sebastian Andrzej Siewior wrote:
> this is follow up to the previous posting, making the lock
> unconditionally. The original problem with bit spinlock is that it
> disabled preemption and the following operations (within the atomic
> section) perform operations that may sleep on PREEMPT_RT. Mike expressed
> that he would like to keep using zram on PREEMPT_RT.

Sorry for the delay.

I guess this works for me, FWIW:
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Minchan, any objections?

