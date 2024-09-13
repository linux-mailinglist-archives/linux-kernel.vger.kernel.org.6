Return-Path: <linux-kernel+bounces-328247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA11978107
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E1B28771F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05B1DB547;
	Fri, 13 Sep 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MI1bXRtG"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8141DB538
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233676; cv=none; b=IkAJahfAgXyEJGvqi48XyQnL4IfxbP4xgCdtiRUqaf5wU3nWH5Bb3Lx87ivwEtnrwelid2FqAGQ3jW/tTf2N8XQThDH7rR0MOAoWJx3TTtAkpS7ZeYvKz6yYPMwA8UYa8Ft4ZwftlT1Q1fS792yo1OZwYToBbBlnrh6vzjfCcdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233676; c=relaxed/simple;
	bh=D0f1PuT9jXBwBOm3nTsBr0JjPgQVpuzPalotUDBLBts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGkrgen8H32Tkjz3/3oHahNBeJCreNClaGPflNvaVEZB5rZv4YDKxtGPzkapikKSte0PregHKRErrbj2n57dqXsUC65n5UmOTv4m+6cZ4TImurhGPqpPHL7W8Eg4jYIK4UPHoMTnqY+v54IBgH41QXWuEKAetKj+6/e8xs7jahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MI1bXRtG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8a7903cb7dso53073766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726233670; x=1726838470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XhdGDbYhYo4L16IpPIGGru0i2V684mpbk3Fjn0fs3A4=;
        b=MI1bXRtGN+e041M+4T5p37hH3SfQSgFeuyOFtKgjjbvFEucv1HTiFjZgdP83w1lzDF
         ZYJ3cmqCVvFwcJQGpPwCP+BvRxG5/2uxQk02i+itqm88LjduYKDQ/B3kfxC803fA6Zxg
         C4XyNng9syJcSkAnydG+p/eko7Yl1Lk/9WeAjTbccoNqMsBVxqFoe9P3rC56jtG1sT8t
         AvBYWEhYR55X0intkYJHjzk3xg6PYWlpiuAJM/ZK6q21PHnx0gFFM34naXTmmtrNliG2
         +9MW11u28bXVENFQ+ROfDighjJLu/xZyHShSL/4ebYmQpwMW099yXvu/c2+Z64FP993L
         DNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726233670; x=1726838470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhdGDbYhYo4L16IpPIGGru0i2V684mpbk3Fjn0fs3A4=;
        b=JVpvBTSAAI+CvLzVa57FfAr6l4H7nOhYpr6vU9211PbPhhTcKR7Ofps4XDEgKA9tW9
         HGrmLOwCZMXByC/caZskjx30ZVvKprJLsk77pCwodZjXZ3qcb+NTcq6yMUl16zWKLHhU
         NFGvc25f5Dda/HmghwOBedCZBoXnr8jsOacVS5k/Q/KyxVW9B+LlmzFkP5be6twAACqR
         3wzHKxgdpPAgggk5Fs5BhQK/EH81LayvEgMPGWUX1zA0dp9uoQJ6/4liiFZaXPA7rteF
         xTnVb6glc18YsK4FHhpyz/cqZELy8TmJj36GlCRlsLFemJkZ6xVYqvXLqia7is4RroYk
         pc2g==
X-Forwarded-Encrypted: i=1; AJvYcCXbUiFTC+NwOEz0xr4oqZSs2g94FibrLMdi+tIAMc3CSTbiyOCy2soqPJgDPPSS9tZSYfwpJyGbT3g05XU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2HwHCCLOlssat8kQi76OwpvkfLMkJRAwm4POVDYDzK2qD7mID
	Igssux5yRGAlbxz0ZSaBZWRGUtYNoOnK5uL103EQ4LREvThX5irYqGSg4Ic/c+A=
X-Google-Smtp-Source: AGHT+IHcJ56NtIk9V3Z+A3QtoEu3bfPgHzOA+efDcloNtpUGHKdEpTOJ3QrRsGllAAeULwcGZII6kA==
X-Received: by 2002:a05:6402:2687:b0:5c4:2448:87e9 with SMTP id 4fb4d7f45d1cf-5c424488a68mr872652a12.0.1726233669912;
        Fri, 13 Sep 2024 06:21:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76efbsm7653417a12.67.2024.09.13.06.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:21:09 -0700 (PDT)
Date: Fri, 13 Sep 2024 16:21:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: ematsumiya@suse.de, sfrench@samba.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] smb: client: compress: fix an "illegal accesses" issue
Message-ID: <63aacc6d-8e3c-476d-938f-cce25d74a6b5@stanley.mountain>
References: <20240913032750.175840-1-qianqiang.liu@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913032750.175840-1-qianqiang.liu@163.com>

On Fri, Sep 13, 2024 at 11:27:51AM +0800, Qianqiang Liu wrote:
> Using uninitialized value "bkt" when calling "kfree"
> 
> Fixes: 13b68d44990d9 ("smb: client: compress: LZ77 code improvements cleanup")
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>

Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

I was reviewing this static checker warning.  I also have an unpublished warning
which complains about collect_sample().

fs/smb/client/compress.c:207 collect_sample() warn: should we be adding 'len' of the min_t value?

It's a bit weird to sample data from each page.  Could we add some comments at
the top of the function explaining what the function does.

/*
 * This reads a 2k sample from the start of each page to see the data is already
 * compressed or whether we can compress it further.
 */

regards,
dan carpenter


