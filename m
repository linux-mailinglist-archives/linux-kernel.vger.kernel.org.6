Return-Path: <linux-kernel+bounces-403778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B71A9C3ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3ACE282D57
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAD716EBED;
	Mon, 11 Nov 2024 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f4jB+kAF"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B43149C4A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316715; cv=none; b=rVuGPTmTh20U1wnmF4SAUTSP/GUrnYz0UNNCwt/P8ndPyYbIXMNTDnA2OdHcdPefzEOKp51dFybRUWCbrW3x4qT5RVf31GUh/YgdSVWH50T1NDR5TKlEfBKQ+r0zr6lw9XjkePTkNyipOzo0AICtXzRNtk6CyXMUuJLYWqhMP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316715; c=relaxed/simple;
	bh=Tu87kNvAvBhncgUgSOfQbsabqiO5OQaqqDg932fYl9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nd3Yie8j3aGe7TUU5YwzxAeUEmTY6z6mj49LUo4MmLcRuUV9hVrUMUFauBLVlY5f4M8j7j93D2eBfxWTsBq0jr7LWVR0wVSJchkMaPacKXDnajWeLhP/KSm4bRLDC/s4asKm7jv3no3PAlZKqZY//00JIJcq8kX9kYqAkLZZm4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f4jB+kAF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a4031f69fso723967366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731316712; x=1731921512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tu87kNvAvBhncgUgSOfQbsabqiO5OQaqqDg932fYl9o=;
        b=f4jB+kAFKy8DsO0qrOxUrcdU9hyMEwANRGTvvAu3C+N+7aHeVR2qOlqYhmhqEXhYVc
         KLYHG4+O51WjIclYJj+jD3BzMvGcseevmYRZ1C/XV92evSsA+mCHtGlSliz8/0LQHqnz
         w/9SGhGtGXzqeCK8+Hqj7WVCrQ2lh6XIcvlSynzAatHju685s5A7I7yTd+/X1LJRwnXL
         6UalEejSV7C8g4SpE9jl4bWgj2pEt/QcYQFWNaUN8DIW28H3r4PpPHyh4lOkpo8ESKBx
         x38j2gnq3GUtNp23ZHDFKSi5hEBtAKZ7Rkdh+lNmWDzj7b5GOn1CHraR+EDDaqFq88ZM
         YF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731316712; x=1731921512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu87kNvAvBhncgUgSOfQbsabqiO5OQaqqDg932fYl9o=;
        b=WndvLB265zudaeHOU2BhV9mp9QnwoqopiiyR0Ujn0SDCuP453VonaYX8PnKfy0gPTs
         sLKKJjjJPH8FVVNM964XqLcOQqf0UvDLYUY2M3pYWcXyMeEKigSx91reTMS+Gb/biZWj
         yU2QpXlI15oJiZSsviloig97XhSEEapqX3Sk8UTffDfbVaPtURvFv+dLtbwttB7/64Qv
         ucN7j8KUjDdJcf+ngyhVUD5pt0OFCmD0KQjbt0CgrcfjLcoQ22yZVi6pjDlJWorcMxvH
         nVyi8s1Vb/7IAiHmfQa27WiD8Co+p45fQ0GIDW51EQIhtHDtqMYd5gTNxiPPtZg+xXmF
         twEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsv52UgD2PqmUppWaYBJ0FtSEv6Y9bhOONsa9q/CkurChTbh3LrnuCW72bDpvVSm7tKG9VMLBAr6/TqNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmyX3gaNLpXTqxnHxG0FoPl/4g3zOjK1/quxDyVOCHLXbYQEJd
	yOABOmGzgHke2YybSJ+O6jEzfL9hFw2Me+KDL7jzekcIddW3Q1/0rzFre1eRGGE=
X-Google-Smtp-Source: AGHT+IG+xD3+4ORvqKbrrrbRirOgg5kTjxXGDgrBaLKaxvXuLm2vzeV+m9yfvKzCFTcnCurByccg5g==
X-Received: by 2002:a17:907:3e1d:b0:a9a:bbcc:508c with SMTP id a640c23a62f3a-a9eefebc52cmr1213666366b.2.1731316710816;
        Mon, 11 Nov 2024 01:18:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a4f6sm566759866b.57.2024.11.11.01.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:18:30 -0800 (PST)
Date: Mon, 11 Nov 2024 12:18:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: zhangheng <zhangheng@kylinos.cn>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] staging: octeon: Use DEV_STAT_INC()
Message-ID: <b53b825f-ab1b-4d1f-8547-00d8fa461ffe@stanley.mountain>
References: <20241109091909.4038571-1-zhangheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109091909.4038571-1-zhangheng@kylinos.cn>

On Sat, Nov 09, 2024 at 05:19:09PM +0800, zhangheng wrote:
> syzbot/KCSAN reported that races happen when multiple CPUs updating
> dev->stats.tx_error concurrently. Adopt SMP safe DEV_STATS_INC() to
> update the dev->stats fields.
> ---

We need a Reported-by and a link to the bug report.

And also a Signed-off-by.

regards,
dan carpenter



