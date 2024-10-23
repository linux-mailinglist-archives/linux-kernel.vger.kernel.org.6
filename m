Return-Path: <linux-kernel+bounces-377840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EDA9AC783
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3669E1C21798
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB41A01D8;
	Wed, 23 Oct 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hYg7mGst"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655421A01DD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678274; cv=none; b=TLS/F96mY06x+sIRnCreUQnBAEdSCDFDiDFx63oZAtSLyf42FkEiE8oS5Ru7pnDIdRtu/wsoc7tA0iY5tAxUYb3wszzBtiUJk95VXXfjOlfdnr/JZKQzmih9ufGXT5npQrFcHLjg5759x/iBMviBt4QzeLO+LeH0fao9QouftRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678274; c=relaxed/simple;
	bh=4xt+M1TKsijkRNzEk6gYKOj8U4y95Ey6HQdeI8L5ZHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1WP2L31D+4Wpgez+iAUSXVbRets+fUswevszttrbol7ZqMF1FoOFm1wuCfXQnNrHSTcP/OTkraPTlq+kYAzOMBC9qVp9jqUxV+LF8QtCA70cGB9iCpXu3zNQ9SqNZSkPsvw/a2wcSJPmWTyIneACi4odvXkUEFUmSA09TfsydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hYg7mGst; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so69818445e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729678271; x=1730283071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sKJHAMKDVpw9bzSHGhrHWmLUI3HVm1NWR3Nb/36MQk8=;
        b=hYg7mGstB5Y/NrjBs6BAxKmUuLgZ5SBIO51/zygKh3Aw2mTjuJyzHK2wC93O71KHwc
         bdEtOr7QYWJ/Mlj+UEQHF/HCnDhTpN7jwlbxOOHM260p0O45B0C8Iuhu2lP6RN67IjNQ
         7SUKdrXxI+CaV227aIHn908Tu/fOEsq/jTeNvrmZD7vXatQLTLv1lsUa6VFF8WsA23SD
         JqGOZcVZ7piavkTxcLK4u8Lx0WqE2QwNC4rvQY/CdiWp2DWfu8SONln1CsqVS4NZtWEG
         tbCw5dchhLSJdfDsBc4htzBFr1DlVf1DkyIrc64i5pYlViF8k5lEO6aGWdYns/XYBJVS
         iEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729678271; x=1730283071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKJHAMKDVpw9bzSHGhrHWmLUI3HVm1NWR3Nb/36MQk8=;
        b=G8Gu7ZAnbm+OZ7gGzWbCF6RKc+rVp1vy3Yt0zR97/jucmnmGnhstSsQtMrpL2ab3o/
         AuOHUq7ahChs+qIlQc5taPz+5SjwSTFNLyyzSma7Kd4gvost8q/qbuixB21NdDWxOD4i
         7PNwFM01CP/A8i2npL/09esisxzZFrcv3o+AkQW37Rs3A/9E1Vv2IbWERUqySyNKEIFY
         DHsY7/Sj6PVLeQGeTjnb/ljyKJic8qPxDUXXHKtA1RYfrEvngpQ0gc+6IR6hxn4mYgWl
         x+LwhIuM1JKCsja6SzBlr3Egn6nuA8dgV3iM8txYxjcVD0TVWGOzjhxz40BZZjBTUN+G
         K2fA==
X-Forwarded-Encrypted: i=1; AJvYcCU3PUe99f45Wu2zeqigExWa1iX2q/NOWHCCcmSo8nzvopiBKbxeCur1fqtHPaLPPc8CujajvuYYFbDydbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3a1kTEmEcNNI6mBmF4/vGm+pqDrPsIodVH350O3rFLFBBBsNw
	gLZkJ6M3tMAWonP/CNML/gsHz88m6sdSXFWV6/l2rj1qiLCZRjyh3B9ZxmN4qs0=
X-Google-Smtp-Source: AGHT+IHFt3z0BuJR9H33ESobunGlzidwzdTNhACnSItxcjBr7HhF+l51ueyKrHzwmqDOM5LvN2Hcxw==
X-Received: by 2002:a05:600c:1d9e:b0:431:52da:9d67 with SMTP id 5b1f17b1804b1-431841341d7mr19204965e9.3.1729678270707;
        Wed, 23 Oct 2024 03:11:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c3a707sm12019145e9.33.2024.10.23.03.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:11:10 -0700 (PDT)
Date: Wed, 23 Oct 2024 13:11:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <2b7d150d-a675-4a35-8f32-75d2da4b3302@stanley.mountain>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <20241022041243.7f2e53ad@rorschach.local.home>
 <ZxiN3aINYI4u8pRx@infradead.org>
 <20241023042004.405056f5@rorschach.local.home>
 <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
 <20241023051914.7f8cf758@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023051914.7f8cf758@rorschach.local.home>

On Wed, Oct 23, 2024 at 05:19:14AM -0400, Steven Rostedt wrote:
> But pushing to linux-next for a day or two, what does that give me?
> 

Two days probably gives you 80% of the testing that people do on linux-next.
I wouldn't run linux-next on real systems but it generally boots and runs LTP
okay these days.

regards,
dan carpenter

