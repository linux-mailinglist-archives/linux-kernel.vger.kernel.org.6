Return-Path: <linux-kernel+bounces-343793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66230989F86
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2DEFB250CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB538189B98;
	Mon, 30 Sep 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcXRJzPq"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9021C17C9AC
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692622; cv=none; b=RWvUimRa3OPg/6ZuK4q06PBtedhwsa5jQa8mXqhry835eXslJNp96xoWZb3fWkGxvijl1PqbfZzFvXDcaPK8vRhk2/KVE0885Ygt4TLA3Z0wjd1g8vdg19DJHiGOOdY9PEhnWZ0+T+Yu89KMYz1HYqLFO5a/e842RUGa01n6gDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692622; c=relaxed/simple;
	bh=VGRUhIz4Vn1P2La+6gVKCXPca/yCRduCeFQ5hZhM0SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a05cdqzjoREFhl0COUxCK87guGonolb6G8m530K6HR3BuGn2Oyves8mcNRWNdXcsy9wf+OMcw9uRmDJWZYHZzg+l7pacvaI4N6/Z4yWkXHAcOPi8MgTJKuKWSaZVr1FTPIW/2E6w+qJgR3doeOGVP+POdI8PP1kW8S34lSd4tAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DcXRJzPq; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d4093722bso645017166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 03:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727692619; x=1728297419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMdMSE9py3RjyD6QCh1eR0VuWp5bQ3RLbcnII21K+jM=;
        b=DcXRJzPqhXzXMzO7iKfCyTwPxpfo5JFaWANfJIe2ANGUAnUKewf8tCNa2ej3rieLFv
         l1L7DzWbUSfoGCorWoK5K5K2nr7OivrKYncTYxVWzuB6J3sGqR1rL0WhkfI3MnBwBJdi
         1N974zioBFgOUPqdTLSHIMI8fDz6DHQxJuRyxRt4dP3FrdKFM2xyuflTxQ6zrDm5IN/O
         vKUpKXjVA8FD3dUXaG23Ger1e9ejvbBBRzu/bNsZgHN+Z1n4T5hmVX/e58mqMQa1u2/1
         /PdnuzCR1BvEENZJ13FfcnAuEIx+fohobQpWEYUum79QtfWcSxZSf5+S7lmivZ3l0NOk
         FpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727692619; x=1728297419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMdMSE9py3RjyD6QCh1eR0VuWp5bQ3RLbcnII21K+jM=;
        b=Q1AV72Pagi6lUbLCbX8J2/R3Pud2IBlNkeTewR47gG7W2XayLg4SNrN+unaPijpahk
         cgAQZcNgRPZJbCXQK2rWgVgUUCabCeuwJ52mHuUkoom6/qsHtd+xNIbcS4J98h6DtFKx
         0TiC4FwDNF7/nHfJNAOKyXPtr/5uv53AguRPWwDPdH62rmw9bFBxsfx9i9/CQ4z7HEVH
         VcUn7a3lX2NasDqDnFSN6GRE4UFl4REUbkWZ7C1WuaAILKQblmda5I0AinFxRpBjRsjN
         4gI7safKdUrV5raRsxUQo8zksO1RuPKRXWc985R0m1ASCdMjBMvb4PUNQVvS0o9onibq
         p9sA==
X-Forwarded-Encrypted: i=1; AJvYcCUNLyPgHbXsAmy1o2QJ4g9QvIlff1K4WFZ+eJQTbGEle0/qhb2raJJ1HIwPciArZPG9bWJtPTwx9RAqC2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1n++sTJCENW+h0r7QuPrWkAjJ3GdWUxXor+PrClz1nbjajmb3
	X3k7DLDcq+v76VVwq7PE8D3mjkPbNh91ZKiCb6bF1CyBqwUusu76e5jFKHMka4MaDt4igDXjwuj
	m
X-Google-Smtp-Source: AGHT+IHQ1cmTo4UbLbfQql8P7BUCjSn6i5rykafHKyXfrRh0KuZAMOMWuZyLvKaN1xkt7Fee6L9LCQ==
X-Received: by 2002:a17:907:781:b0:a86:894e:cd09 with SMTP id a640c23a62f3a-a93c48e80c8mr1302865466b.9.1727692618860;
        Mon, 30 Sep 2024 03:36:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2777bc4sm522635966b.14.2024.09.30.03.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:36:58 -0700 (PDT)
Date: Mon, 30 Sep 2024 13:36:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: dtwlin@gmail.com, johan@kernel.org, elder@kernel.org,
	gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] staging: Fix atomicity violation in get_serial_info()
Message-ID: <bddd479b-8fa3-4e39-8ca5-f7f133a8b298@stanley.mountain>
References: <20240930101403.24131-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930101403.24131-1-chenqiuji666@gmail.com>

On Mon, Sep 30, 2024 at 06:14:03PM +0800, Qiu-ji Chen wrote:
> Atomicity violation occurs during consecutive reads of the members of 
> gb_tty. Consider a scenario where, because the consecutive reads of gb_tty
> members are not protected by a lock, the value of gb_tty may still be 
> changing during the read process. 
> 
> gb_tty->port.close_delay and gb_tty->port.closing_wait are updated
> together, such as in the set_serial_info() function. If during the
> read process, gb_tty->port.close_delay and gb_tty->port.closing_wait
> are still being updated, it is possible that gb_tty->port.close_delay
> is updated while gb_tty->port.closing_wait is not. In this case,
> the code first reads gb_tty->port.close_delay and then
> gb_tty->port.closing_wait. A new gb_tty->port.close_delay and an
> old gb_tty->port.closing_wait could be read. Such values, whether
> before or after the update, should not coexist as they represent an
> intermediate state.
> 
> This could result in a mismatch of the values read for gb_tty->minor, 
> gb_tty->port.close_delay, and gb_tty->port.closing_wait, which in turn 
> could cause ss->close_delay and ss->closing_wait to be mismatched.
> 
> To address this issue, we have enclosed all sequential read operations of 
> the gb_tty variable within a lock. This ensures that the value of gb_tty 
> remains unchanged throughout the process, guaranteeing its validity.
> 
> This possible bug is found by an experimental static analysis tool
> developed by our team. This tool analyzes the locking APIs
> to extract function pairs that can be concurrently executed, and then
> analyzes the instructions in the paired functions to identify possible
> concurrency bugs including data races and atomicity violations.
> 

Ideally a commit message should say what the bug looks like to the user.
Obviously when you're doing static analysis and not using the code, it's more
difficult to tell the impact.

I would say that this commit message is confusing and makes it seem like a
bigger deal than it is.  The "ss" struct is information that we're going to send
to the user.  It's not used again in the kernel.

Could you re-write the commit message to say something like, "Our static checker
found a bug where set serial takes a mutex and get serial doesn't.  Fortunately,
the impact of this is relatively minor.  It doesn't cause a crash or anything.
If the user races set serial and get serial there is a chance that the get
serial information will be garbage."

regards,
dan carpenter



