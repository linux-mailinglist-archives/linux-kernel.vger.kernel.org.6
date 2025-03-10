Return-Path: <linux-kernel+bounces-553794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7623BA58EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398D13A5BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574E92248BB;
	Mon, 10 Mar 2025 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSYgwJ+J"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B6A224257
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597404; cv=none; b=PLAXgFINtEwP8YWZvapdl4gU1fsqlRa7qGjMknD8xL2CklrLDZJHy5+CJzSJ1t+uc5Mv5A8Hj6tGuhA/FCiuaKnPz7uvJhOCwezP4ObSTGczVpLxXwoNvqzueY7cmKoKLjKz1oJOoBd4eip6N29DNqcB1CqmNM8fdz/ROBc8078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597404; c=relaxed/simple;
	bh=dB7cfRMG6eYt3IOz3D75C3q+wK/A1eRQjvKm0OIGCOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekiccWw1Ngkrewo1PzqmGAE7JmTrpxrn20U8sEIoQFdNfIf79b6sNh48mievisn/SGt7dz71bU4iVmJL/f7Hw3c+gw1iowPzJaAAzkaYzgLGIVO07s5plHDz+3K6m4vXO65dAhipxRCiIskdgWMEsMhAyqo2uO+l20uVJ8x0CPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YSYgwJ+J; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22409077c06so50788775ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741597402; x=1742202202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8spwRf4xO/w3sEDDedsRANeKdgJJ1ne9O5afi/pXFgY=;
        b=YSYgwJ+J0dnNKxozaNlFUb0Ijc5dD5Wwyaj8Ke8Lnufda+x5cezgL2TT2Rv+yVm9+t
         VZNvkLPNrIfBkH9/QbsDcCwRwHvCG5B3h7wmX0mWru+9rxUB3rKX4DiG7tgDoyECZjY7
         n6mhMPMiETtUFqmm6bgxJLSwkpldiLojPlRuWlMSNs88YahUb2asVK+pEYLxANn1MR7/
         r1G7ALlyfbp8AemWXsFZebvXID/SyJcg4Xl0fO4DxEpcZjxO8ShSuel5fKvzkYg4jXbs
         GxCwnPXyhQqbnxRan4hyjq08xzHSSZev+8QXCIfe6N7Hzv1Ctrax7NUB5AGDtYE5d81a
         +2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741597402; x=1742202202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8spwRf4xO/w3sEDDedsRANeKdgJJ1ne9O5afi/pXFgY=;
        b=DYuv4Gq/9eqD2UXRoDXB6boloutr6ahQN7exT0t2XYHNy1fIvdr0vW/MMebosJXepa
         m4LllmTHD/MT9XLOnEwo0VUwx007LRMgrSJiwVXsHsjRFm2ewNilPP8yIODF1lgQhkvr
         B5n4tVEIQB7x9Di0l18dUc1dhmw4JYIqpZ/lNMMX0PEva0ZGyNZvETWpjmrbT0UDChXL
         LL0DtSep6MNAFSYlE3+sW2e7T3YbQ5tp8z7efpg8rBOAjAW7V7t03vVvqG35aGnXsdvp
         fCuG/Q/Gv8RPKBGqeqcZRv+TVuP0/E7chv9Qli6SkmZkNWkBGkuZg7sGzsMSxhbxxN1H
         a3qw==
X-Forwarded-Encrypted: i=1; AJvYcCV27COn5FzTv1dvhOTlxaRM65RznIIafxUGrhsXCQtImETKSgN5q+QeO2tK8pkFx6aBW4lAjkxzoAH1k3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/iqeBWW+BrZ0iyq+1Qeo9eKH+JPEhKjKGNNgB9I35ppuwZlu
	IGuVTNKdkKK2MlW46Drsvuf8vI4fS+Si76TnXPcO17djeXAuevRG0kRZPGBGPXvD7LVSYwmzNNX
	Z
X-Gm-Gg: ASbGncvG4fZV3p3uR0xwi1RUBpwgFcJD4lKRRdTKcT8khKGqY0UYuT2lu3odS1Db0IE
	yppKQ0eNoD1gCOoBKwC9jMg+EbqwxkJwwsR16099uOKbmpBhmzRPhF9qWJE5BvQTw92/WIPvKju
	HtlVgVnlm7XoPqbpNVg7z6wonS6EyLT5BE+r5UHPfutmz6qJx5ARPPkeIeoPBsqD+04zw6crSHS
	P6qKMmcwlGq+qdMGnlRyj6ldpQtKFeCP7ZPl193KSAl2W149un96pEVlo7DwzzlRGV+FdvFFffq
	QS5BbBOG0mSuSHgCHBxRQIqvUU6NtiYlLjRMl+YCM8wTxQ==
X-Google-Smtp-Source: AGHT+IG20Shii+wpINoEOGggIX/8XSh/36qhwdvrIDba/9dPKlSDd7dBJSgNS0S211wuxpSKZka4uQ==
X-Received: by 2002:a17:902:dac7:b0:223:f7ec:f834 with SMTP id d9443c01a7336-22428a9fedemr222858015ad.31.1741597402490;
        Mon, 10 Mar 2025 02:03:22 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e8518sm72631645ad.66.2025.03.10.02.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:03:21 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:33:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akira Yokosawa <akiyks@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
Message-ID: <20250310090319.olwxrcqczwjla2jm@vireshk-i7>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
 <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
 <Z8snakYmzhaavkKN@thinkpad>
 <20250310061540.zpfyisvchyua2cuv@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310061540.zpfyisvchyua2cuv@vireshk-i7>

On 10-03-25, 11:45, Viresh Kumar wrote:
> On 07-03-25, 12:05, Yury Norov wrote:
> > >  /**
> > > - * cpumask_weight - Count of bits in *srcp
> > > + * cpumask_weight - Count of bits in *@srcp
> > >   * @srcp: the cpumask to count bits (< nr_cpu_ids) in.
> > 
> > Here nr_cpu_ids is also a variable. Why you don't prefix it with @?

Hmm, I thought @ is applied only to function arguments. Not sure what
should be done with nr_cpu_ids.

Akira ?

-- 
viresh

