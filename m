Return-Path: <linux-kernel+bounces-439488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BBC9EAFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606E31883672
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F2B2080C2;
	Tue, 10 Dec 2024 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lsOB2y1T"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE578F5B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830315; cv=none; b=uswVQ+GO+l7mY3iJwVAPkPdDZ1uA0XI7HU0U5KijN5dK1sz2ILxLn1Hqq3sraCDafN1urWmqpFS1ae1vdrOqIGsFiwV9+Bjdpklx1F9Ohx5zTAyRU/wF1Qi5S3nPQkeONnMTlrnvrdcJ7QTiIe0DmuzhEFsErfk4CwGYF882uTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830315; c=relaxed/simple;
	bh=Wpq4SWTCBSxCubFG0AHsxbsq8KbPdMnNvpXnEnMKLF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI8rbHiS2DDew/bMaOhuzMR675nHNLdcBseaKUkF3jRTS/fC/1Ni09+qZL86Vlo0nzalM55ngqMPFJUJNP0CwRUqDERAyw6ToRlUdptcHGHTb5VQROOuTHC2hHXMZIjYnDUUgqx7N4T6yoEM+CPGcL7INd8v9HHI7xfs6AcYYGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lsOB2y1T; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso2998902a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 03:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733830313; x=1734435113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xe0hrdR1mVuvMlq1+HiXs95+fQTwjJmtP3zj+Ge2Oe0=;
        b=lsOB2y1TlqCougU6KjxuMSU1turiGs4lflzR2vqr6YvDQyWT4YMa7t7gxvLSy/nCs+
         WXL5LmjUwgciu/J2dHcccDPaglUWxoivZamIkKq8+VG1suAdG+nd60UrtHRi4y3ggyMc
         irOHdbe8dQuXm2doUYsCYGOVpXXrn6Wus3WVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830313; x=1734435113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe0hrdR1mVuvMlq1+HiXs95+fQTwjJmtP3zj+Ge2Oe0=;
        b=WpfcT1JLxr+0/CeJ9UUsVoLP5BMRGgwiQ549hNfADpJSiAwcLDowawNZE5mEXXm62O
         5JPXsCklWdKWM9EZUU2a21O5llNqxchMiXx9nk4A/ZL13qbqHIv6AAsXz4ZeRbMwb/pG
         KIdKREzXTEuZ/ZZB9+pSas3iceInGehnVv4EQcm79taligO9QKWB7le8e+hKs8AyiTC5
         Q/Uadein/KDgr4W4DMybv9brtRwBCc+vNpa0Pci8bN/yhsWayPUGtCY3NACrHa080qSm
         eeUNvatfRhAs1cALpIfV1r/V207SaXWsv9xj2U2MsGpbR+cjdxUAAMR8In3WFYQgdGhX
         erCA==
X-Forwarded-Encrypted: i=1; AJvYcCXPMmA7+ywL8vsi6mWjRHuw22qjkvl8lQQII9AuIh1EYj0kWvB5RJxg3V8umHdKErZA4d8Leb/DlTdrxkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjNH7xE2fy3TQWgCS5cnCZMsWiqH2fPVgFcDLme5h94UYQvxg4
	Mh8Yr1Zut175tCw9GDtw6+DNOhBlItHQ2Fr+nikSOzAQ8vlPZshfjnkMMr+zpQ==
X-Gm-Gg: ASbGncu4WpE0SR7y0tLzlq6Edy2/AREYtrGCrg2szLKaeDFhb3H4eT/AMUllMsV0Om8
	5jMJ+TVeAAen4ViceCbwoM2MAL8lxxWdfQ91tW1LCjSTz+KSotWHMusU7/zRrVzdefpSXJkGKtA
	hetBkQCR4JoEYXybaVqIznNYb8Z+MSqLNlsYATck+zoXSeKj7EtJLtGNwp0o1Wlj4NG0YVr+tM8
	1Z+hHzGRLKFLfhBJmHYb4AWnEu2MFCrAgvD0CJBSw6bpSljkZQd9Dv48g==
X-Google-Smtp-Source: AGHT+IGNMDz5WB8++vuRhe5zz4rZ9gkDYi5TB1OMtbAhyoWqSujUC3yOWvpIGUAiDArSOxGBMSLWsw==
X-Received: by 2002:a05:6a20:734e:b0:1e0:bb0d:b1f4 with SMTP id adf61e73a8af0-1e1870b9378mr25585001637.11.1733830313342;
        Tue, 10 Dec 2024 03:31:53 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e4c2defasm4514089b3a.120.2024.12.10.03.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 03:31:53 -0800 (PST)
Date: Tue, 10 Dec 2024 20:31:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 5/6] zram: factor out ZRAM_HUGE write
Message-ID: <20241210113148.GO16709@google.com>
References: <20241210105420.1888790-1-senozhatsky@chromium.org>
 <20241210105420.1888790-6-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210105420.1888790-6-senozhatsky@chromium.org>

On (24/12/10 19:53), Sergey Senozhatsky wrote:
> @@ -1673,13 +1723,16 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  		return ret;
>  	}
>  
> -	if (comp_len >= huge_class_size)
> -		comp_len = PAGE_SIZE;
> -
>  	if (last_comp_len && (last_comp_len != comp_len)) {
>  		zs_free(zram->mem_pool, handle);
>  		handle = -ENOMEM;
>  	}

Andrew, JFI, this requires [1] fixup to be applied.

[1] https://lore.kernel.org/mm-commits/20241210093835.GN16709@google.com/

