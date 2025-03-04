Return-Path: <linux-kernel+bounces-543296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F99A4D3F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BB01739AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FAA1F5616;
	Tue,  4 Mar 2025 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Et2Uc7rM"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC201EF390
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070227; cv=none; b=cHhIgQdNEcMYISi18LwMZeKgIeLr+1fSimYNY2tAbtOBERSdyEscebtGqYi494OST399qfl6A52LD88VeGBWLmhUaYSETw3rP/zJ2FjY3hN8750cfaZYbE0TM+D9m9TPbgxKomAmsh0y7kocWWnaO/CiacH6eck5oLIdgrfMcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070227; c=relaxed/simple;
	bh=UMt2ZIzD4i/3+qQhSPSHEop7znwVILAj++vRqySJMaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad7NVWo7sCUGDtIeXjwq4TU/IRWErgQhIPK6/Axtg1qmxMEhmMldB9qEEZrzuqYvtTKanp2yQNOUyyXCCt8K+w+NQ6zLD6VnAjk8/ztcKC6To7eDl2GflNPNydFDP/qu2R/MxylOKK6hWt5SifghZH7DhxxU3NKXgdsg8VZe3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Et2Uc7rM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf4802b242so553242066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 22:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741070221; x=1741675021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZODVp5qI7foXW09kyVwXfjrHAWYKs/CU5C/Z/8rz1U=;
        b=Et2Uc7rMNEMbeY3MTcVu7BHRt/ovc+d5j50nEgL0yK1mqGSxV4AuffIizoheIGDMTc
         iervZE0McyNANe/DwtbasuoVYIph7dOr4Q4Yol2AQy8b2wDcsN6i8op4n/kQmNRiT6sJ
         qNPta9N5X1I+RriSdEZHfWUjNsLQksZGG4ZCBPXxjXw1k8SCirrVdL/ZvZ8pMirLysr6
         2Bv1N36dJ+d/R4QpUMhuDrgWtAlOVp5O9CNheieT9oxcaulvslH5pCbeHxXvG8LX7Qq/
         9qpe61ip7Rg0Vg+G9ib0iis3K9VdYyXq8Zkvkq1dYqXjBZFb/lwnqXZU9PNGNzzv1wRn
         8Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741070221; x=1741675021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZODVp5qI7foXW09kyVwXfjrHAWYKs/CU5C/Z/8rz1U=;
        b=nEk8h5L2rlIJmf2nTVzJHX4GxzP0fyrffNmicvDC0tcCiSsd4H3tFgVqCMcGBh/+75
         DdEz7RjsHg+SYSREhl8tGwGM3hnv7QQkRUlfogLIQJTvS3yyozX/5MhqZFABA1jM6FQc
         j6qB3XsKCVY4Xj7843kwHFzuzbXYyyJ0lPZcqr3X82GmpltY76InNbh9VbB9RAbaa+VG
         PHJ7tQDxGJMyxSDSJWOR3OuSQ6ycch2fnpazsRb+yawtK/Qwwi6HAOmniTt7YtXQk/c8
         +fJa3f65ywgGVv3mS3mHZaiamu1BTVY0jSJvFBd76hTl4hAT2tz7R1YKcHChoG32duzE
         SQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk+RHMNIOKDNbMp6W8k/uixAb8Y2MPYvuAS774OI/EpJ4vut8FsvFsG6CT9EqTZgANErDYnU5sY23OKbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiBptp5ysqZDXg5DKIgxSdekbz9dyFcGiwEFUpySw//y7GnAGo
	ilMOZCw83HsSMIwCrAfr89RPLOKTQ33mihBTsjijLPX0z/QbhOHjJPrn4wKSLH0=
X-Gm-Gg: ASbGncs/PQ2U7JZAagWk8XJp8L77Ax0blnzS+RFt0xR97eIgLVBfIhwbTHlx//mGm74
	N7fgbZXKFUd/2Xu4uyYMgN4z59cX48apgePiFyOWhGHv+OgHR97o+PvFj2s46aURR/KC30szPIK
	GXIHH/j0bEMIrdb6Qhb24KvSyEGBUnTRjLcQnRk4nTiixEGnXO9sDPo0j7rsAl5l8If6ezYlq5I
	pRE9BCWCbqhEPowCHUQqiFEH0vSow+Fpsbj78FvKdAU5NJ8to8X/EOZwTMPyfblNKbqI9BSYN/O
	yanSXhhYrNwwbUhPKUWr5hm+NpAEsZfZqBumjV51qvcm2kPzww==
X-Google-Smtp-Source: AGHT+IE59zFK0k4FqZlCMkYs0jRqy9akgU6KdZPmbOJsPiyF1i1a53x6V4y4VmoHrSVjObFtMf/iuw==
X-Received: by 2002:a17:907:94cb:b0:ac1:ea29:4e74 with SMTP id a640c23a62f3a-ac1ea2951afmr373989566b.28.1741070220918;
        Mon, 03 Mar 2025 22:37:00 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf6f85ea15sm367116166b.111.2025.03.03.22.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:37:00 -0800 (PST)
Date: Tue, 4 Mar 2025 09:36:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: sunliming@linux.dev
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
	jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] iio: imu: adis: fix uninitialized symbol warning
Message-ID: <c5b70fd8-2d03-4179-a8b8-5ee827fff978@stanley.mountain>
References: <20250304060518.1834910-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304060518.1834910-1-sunliming@linux.dev>

On Tue, Mar 04, 2025 at 02:05:18PM +0800, sunliming@linux.dev wrote:
> From: sunliming <sunliming@kylinos.cn>
> 
> Fix below kernel warning:
> smatch warnings:
> drivers/iio/imu/adis.c:319 __adis_check_status() error: uninitialized symbol 'status_16'.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>

Huh...  Someone is using lei to get their email.  This patch is fine and
it's theoretically the correct thing to do.

How the zero-day bot warnings work is the they are first sent to my gmail
account and I look them over and either forward them or ignore them.  Here
is the code:

drivers/iio/imu/adis.c
   305  int __adis_check_status(struct adis *adis)
   306  {
   307          unsigned int status;
   308          int diag_stat_bits;
   309          u16 status_16;
   310          int ret;
   311          int i;
   312  
   313          if (adis->data->diag_stat_size) {
   314                  ret = adis->ops->read(adis, adis->data->diag_stat_reg, &status,
   315                                        adis->data->diag_stat_size);
   316          } else {
   317                  ret = __adis_read_reg_16(adis, adis->data->diag_stat_reg,
   318                                           &status_16);
   319                  status = status_16;
   320          }
   321          if (ret)
   322                  return ret;
   323  

So if __adis_read_reg_16() fails, then the next line is an uninitialized
read.  But then the if (ret) check means that it's fine at run-time.
It's a false positive.  The other thing to consider it the UBSan will
also detect the uninitialized read at runtime and splat.  That's still a
false positive but it's a headache.  But when I was looking at this, I
decided that __adis_read_reg_16() was unlikely to fail in real life so I
decided to ignore this warning.

Initializing the variable to zero doesn't change runtime for sane configs
because everyone automatically zeroes stack variables these days.  It
just silences the Smatch warning.  So I'm fine with this patch.

(This email is for information only in case you were wondering why the
bug report was formatted strangely etc).

regards,
dan carpenter


