Return-Path: <linux-kernel+bounces-369926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A15F9A248D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCB43B25CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C591DE3DD;
	Thu, 17 Oct 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNxmPSh5"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06621DDA39
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174186; cv=none; b=Gj6fPEUd9w1ULL+EsSJrVnzC8bIS/29R2gmUDwDVWaBDjzkJD2HwyTmdUAGMFFt4T/ZHDfJB1fKxLV0IVZpVarpHUHpHURxLiDpMZuIV9XHIBclOuPUSfMzf9HfgyOv3HjO+Smbv02AHHWmNk2OEVB/CME4IlLtBHLYjbF4PQc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174186; c=relaxed/simple;
	bh=7+PJu3CzAiCJGM4dvafBRZsl6X2t0uA6nw3HPI+thj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0AIyjEQySFhLhqSQUhuKRCnl004w+lbHU4A+EHPBGI0YVUcflGl10YcZiKkhHBxOsvCxPZlkfWCNRskq3l1TOwIG1rLpl0geFaFwysDff+JrX16sm604nJOinhLiemZNJQG+G9WiT0tit/8sqBmdZbPf/LLt7Ul/+qAolmM/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNxmPSh5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ca388d242so7444465ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729174181; x=1729778981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o72ASwfn6BtFeGUUeIO83CX7jBztvJWMfDGgQemDWKE=;
        b=fNxmPSh5ufcTfhz2ldCtFl2iNQCXCci639hWPQDQBl8kWE5rpDN0aes24lftZOOn3y
         HwkwXCkBqw3h5KvlNWtj/dS7FoISKiItcnmXID/c8F/y+dr+/Un4adBA6pbNdXvrz2+8
         G7Ol0t29kw/u20cD19k93v8fmWTHTt5l7d5e1P7DNahNdmqNvsWeMZrzJW6Q1ypy1OCZ
         MKi4vL7SIARe3N9JRJMU//f9C1RAx2mC4JtPrjtzYznTPbTbSkhBSqTWl7cyR6X0hwEz
         EXWCqpmTPt4jzA0nLamSKDDz4fID6goIGaCIXHFE0YAQD2GBqY/jfBq5x3aErwddXyUN
         YTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729174181; x=1729778981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o72ASwfn6BtFeGUUeIO83CX7jBztvJWMfDGgQemDWKE=;
        b=Fs8dpRv1fo+bRXPD6ZbbMGWSgObwDGzBtss5WNWt3hTtoThi6x1bw5YisK3hbE76jX
         RdfjQ+EgQtVyy4hFgSsTJ2Ywrm6D79ME4mEJV9mALu8v2iZgp5XCRJ6pfMF9O3ZSSR0q
         iDnAkyvXBNc67UestnxurzL5UjlGHTrR/tJXWw0DUbdQiKwyOjVq0zbuYrqEyYljL6I+
         Nzftoaj0OsCD5ltZxSaMKLL+RRxIJya9U/kJP6UiS3KzTbn+RGbijZkJfypGYH5vtl2k
         gFm7jQtCyZ/Vb8h2elSOIxYr/I6JpA8zKPenSw2cfOcSn5rfzR5yM/Upho/orl5iXr0C
         pEGA==
X-Forwarded-Encrypted: i=1; AJvYcCVwwGIZcFlBzFIO1smtcbB/Si6nw73yVoyuGRgTo4rXcbiXduoBQib+mK0Ubl7l+GrzBMxHHjTv7Wss/BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDI8HJCf+RqeNSp6yixX1zfHQtSJphXs+0Zx95Lz7U4867llPX
	kvrZ2ct9bNliJosv95BGf9nk2k7cO5bm4gyNkC4K5mzI9JU23cFX
X-Google-Smtp-Source: AGHT+IGmArPw8Jx26L8GBLpBtSEkHX3v8BSvL/Iv112qKVTdI/DNhhS5VBCiSHYaCt2Fg4y5MbKaJw==
X-Received: by 2002:a17:902:e84b:b0:20b:6f04:486a with SMTP id d9443c01a7336-20cbb1b931fmr290470195ad.35.1729174181113;
        Thu, 17 Oct 2024 07:09:41 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804c066sm44328945ad.224.2024.10.17.07.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 07:09:40 -0700 (PDT)
Date: Thu, 17 Oct 2024 07:09:38 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] posix-clock: Fix missing put_clock_desc()
Message-ID: <ZxEaov693FMReLxh@hoboy.vegasvil.org>
References: <20241017133249.3496025-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017133249.3496025-1-ruanjinjie@huawei.com>

On Thu, Oct 17, 2024 at 09:32:49PM +0800, Jinjie Ruan wrote:
> After get_clock_desc(), it should call put_clock_desc()
> if timespec64_valid_strict() check fails, put it ahead to avoid this.
> 
> Fixes: d8794ac20a29 ("posix-clock: Fix missing timespec64 check in pc_clock_settime()")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Nice catch!

Acked-by: Richard Cochran <richardcochran@gmail.com>

