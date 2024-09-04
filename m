Return-Path: <linux-kernel+bounces-314941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A30996BB38
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC96285ADC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DA01CC145;
	Wed,  4 Sep 2024 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RWRQVciS"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3451D0DC5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450520; cv=none; b=uHxLNK4AA6dINGKuspbm8e54k2uZxdeXH1MxU32DaBvXZVcjtft/4t2V2y+jzu8ZisJrdApye9dDkl2piBJcbCcAQPUrTaabodl3UhAUAQXatlaWMec4mZuxPcHJ5xScl7in5C+SN10X5ONbsZo8/QLQi3QUmkOdIUebwOYIpJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450520; c=relaxed/simple;
	bh=9grxJBulqA4M7mTry0HLRVP5zF0PSNYxyQ99ICIse5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAIOAcKF6aREmj7r+4vgE6/ADuLl3RuD+vQgAd8aNS2GdEzg1+uuOGodGxqd/hlP7yp2RcHaHaty7bAS2WJh3mCF007kiSYBlgzwGR0lWnIBDaHvUDIbQTnrK4E3vmERFDsYoa2aXnptOE8ABnkBC+RE+AnS5OYnLij32qks9zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RWRQVciS; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f3f163e379so18312501fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 04:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725450517; x=1726055317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7c+oJIY6rjOiXmpMYXeuDRnxHvChpBfHfXKg9Xvladg=;
        b=RWRQVciSMykfeypt0UcljqVDSyQsPyDPi2vjphZINHqUmq2sW5GpPCeJUHzibmuL6A
         mo6hE55jY8b138Yoa5n6Hc/QXYCMHvrwQxJPfg565XJ4WMCqSKa6cKsh/fCVPqT4RxZo
         Tp6N5J2SHAF+G0YEon2kCf1fFf4N3E4usFW9+VA08QrWFyk+E1fnmxDJiZtlcpZSoMbK
         26M5f+FxJ+VJjfS0MMV165MUbFal+bYaFX0f1v/FvqvtzIaTrbxoYu0zrDYLMubvbGJ0
         LV7fS4zNqg8E1rGtA3bQb2VQD8Cm7jxs2U5WhN9DWWWRoLbh7BCvEldaRfSkD9l935wu
         zSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725450517; x=1726055317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c+oJIY6rjOiXmpMYXeuDRnxHvChpBfHfXKg9Xvladg=;
        b=B7z5S7UmZCy31KQ/aaakScQwAUkyDuaJiuknmK8fO2MBNKgHbUrPybpMIEgRF2Vm/Z
         NAduK7rElOAyRaJYaGVQB1tBYvdrvmz0bPSlC+/8k7mip6VaZWLMkdrcI6H3w5p5IhVc
         daJ+Ir19kgGCqJWaTnBtXLAfo03AtVKHNTtsmr2LohuMTcUfinLiUxncVwNMkV9Kq7xv
         PSXjkZgCchl9LGEwAbMgq15lOWU3lXvODcxmb0pGofVscgPk0uJkaxM4Zqgw8bGhqx6p
         JZaOeYJzK6A0ihFgh+ieJg0yJMpiPe72lHCWWYwi+WCuPbGjTwGfI8XIYYwaU1DrEY3v
         0kYA==
X-Gm-Message-State: AOJu0Yxin9vtFoNoZ19gC5N0u/yBEAFu8bq1hGp8AK8FMlDJxa4t2h6M
	+bXjpWBXCdjC8GVdGeHGarxoiHMqPoZi8mqRoJcmzuzk5Hrxrf68ZVuc+waJ/XE=
X-Google-Smtp-Source: AGHT+IGWQuArwLoBWGS3FkJMZjNYcq/QeFma7aPLpSFDWBKQmp/WL+6f16yVurrf2i0A8WqhB+DPoQ==
X-Received: by 2002:a2e:f19:0:b0:2f3:cd65:cf65 with SMTP id 38308e7fff4ca-2f6107080ccmr150312881fa.28.1725450516688;
        Wed, 04 Sep 2024 04:48:36 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891dc6a1sm810537966b.175.2024.09.04.04.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 04:48:36 -0700 (PDT)
Date: Wed, 4 Sep 2024 13:48:34 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Livepatching <live-patching@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] Documentation: livepatch: Correct release locks antonym
Message-ID: <ZthJEsogeqfVj8jg@pathway.suse.cz>
References: <20240903024753.104609-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903024753.104609-1-bagasdotme@gmail.com>

On Tue 2024-09-03 09:47:53, Bagas Sanjaya wrote:
> "get" doesn't properly fit as an antonym for "release" in the context
> of locking. Correct it with "acquire".
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

The patch is trivial. I have have committed it into livepatching.git,
branch for-6.12/trivial.

Best Regards,
Petr

