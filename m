Return-Path: <linux-kernel+bounces-243815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8768A929B00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 05:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0001F2114C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 03:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF41748A;
	Mon,  8 Jul 2024 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W1Ni2oe1"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E2E3D69
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720407817; cv=none; b=p+gl6AB1TLUjkuVm41p+o47pFz0XbpNEES5kGuzny7A8Q53iFEpK7lGTNRMm3f5QssDwWQzh0+VEhSa+oMyJSd95GzENsmsujmyPTnmGvSXE0693ERjxkx6EAaxoeDPx7B1oqFXfIz3NzSYI6ZFWKqiF2NzTTCv2/ju0FL0Cb64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720407817; c=relaxed/simple;
	bh=aHIrpcLG9ZGSgOStVeCA6IlxQzwGrCJ/ze2oZFMAcwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZxbf9NUuZzF3T3OJKai/gfGilr/fLX1dlgq3IRuHUlLhiNvHJsbYVr/NVC/BVOjl1hTGqD28rKe1siPwWN6DrDguvBJHOBvcjg+auVwhG+kiPQtqTY5yuT9Q6dTSQrdPn40BRXC0AfeXQ63qz7r2nHQOLVeEtFf7LQzOWGcG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W1Ni2oe1; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7036e383089so214047a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 20:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720407815; x=1721012615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nyybtaZVEV2Z5gr/Xj5boxxbelx9NExLhjriH8Vzh8o=;
        b=W1Ni2oe1VUI5IBB5YL/M5xlF7SALeQHBUsxk07jHQ/0oMU+krcT79PJfenuw+sfgwe
         Imrz8HSpNG3x3MeZTy1qe9BwN40zPWy0l2mR9C6fBoXmKA+9i+/4f0CellhtgEZYyyyi
         BcpqoklQtBPCOUR2tPGcypnvr9Pk6XqUKgSyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720407815; x=1721012615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyybtaZVEV2Z5gr/Xj5boxxbelx9NExLhjriH8Vzh8o=;
        b=IabfKwkZ4ev8FR59MAamP/zhpgjHS+b4vkawAEbAZLXw2cbsgJ6ivzSPwxOQ8wC+BT
         p4tSAc1yiGJVT11xXoDcUL67q1W/7UtnBKmzRSi3m4fMd49DCd83y6ZFoVIuzg0+0fMP
         aZqakcpK9fdpeJZEQ1R4cZqpNBUs96m0oTQYavUyJezVMMJ2J8ce+k0CNmBg7J8Oq/7K
         Ujb7laBFOMvRqi5S6+Bei0K21gv3QaLUunWhrPqTZXwWU5LLPtnJOLRnTWRpsnyvm4Gz
         Ec5Nb0cI7BdogirpWQa8iaLpUHT2UqRaEm7Mu4ECgD859O4aUoYaJypVl98Rnqfo9N17
         j3ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVq0fYfud3+UEpX9bOcqpOa6Xz9nOM7mOFqiNG9ZyT6aY3PoxoV7oO30O1qouUdGPb+pkzEaF5UceMmG4kiNT9S5pbdxiUU/k5bp3zX
X-Gm-Message-State: AOJu0YzPEb/3lSeZ70GGLC17UhKS/arSHX1aIOIldKjDi5VPMb7JjVfh
	rxJqpXR6Hpn6sZw99x3PXb+ToGNbbbkcuV5L/Yeq9whIvGVSj1B97ChLnbKFuQ==
X-Google-Smtp-Source: AGHT+IHkEqHP1B60srwbfsajdtk+7QXJojhM6E/s4AcD68sCwHx0psDiOmN7r1Vd47jUyzvqlJcdpw==
X-Received: by 2002:a05:6830:1d7:b0:703:651b:382f with SMTP id 46e09a7af769-703651b3c18mr4473264a34.3.1720407814861;
        Sun, 07 Jul 2024 20:03:34 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:eda0:6e46:c522:d0b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b28c63ad5sm1794184b3a.27.2024.07.07.20.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 20:03:34 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:03:30 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH v2 1/3] zram: Replace bit spinlocks with a spinlock_t.
Message-ID: <20240708030330.GA797471@google.com>
References: <20240620153556.777272-1-bigeasy@linutronix.de>
 <20240620153556.777272-2-bigeasy@linutronix.de>
 <27fb4f62-d656-449c-9f3c-5d0b61a88cca@intel.com>
 <20240704121908.GjH4p40u@linutronix.de>
 <801cac51-1bd3-4f79-8474-251a7a81ca08@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <801cac51-1bd3-4f79-8474-251a7a81ca08@intel.com>

On (24/07/05 14:02), Alexander Lobakin wrote:
> > On 2024-07-04 13:38:04 [+0200], Alexander Lobakin wrote:
[..]
> >>> +static void zram_meta_init_table_locks(struct zram *zram, size_t num_pages)
> >>> +{
> >>> +	size_t index;
> >>> +
> >>> +	for (index = 0; index < num_pages; index++)
> >>
> >> Maybe declare @index right here?
> > 
> > But why? Declarations at the top followed by code. 
> 
> I meant
> 
> 	for (size_t index = 0; index < num_pages; index++)
> 
> It's allowed and even recommended for a couple years already.

I wonder since when?  Do gcc 5.1 and clang 13.0.1 support this?

