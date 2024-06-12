Return-Path: <linux-kernel+bounces-211254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FEE904F22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815331F2678D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474A516D9DB;
	Wed, 12 Jun 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yr0/iviL"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C509A34
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184193; cv=none; b=ui5aj21J8doYbmnFMq+O1df9dZb/lQGTOKhqIll63EiAuK6o7/0KV2FPtO4L+X0jj5hyGc41S9pqJBEk9i9Ovf4vD0wpoA3cnvjUxRS6BscV6XO3i75YMgG+YA6m4MtstuwGqrJJJxNFLPRa+QWlmokHO7MP1yDf5n+2DyKf5ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184193; c=relaxed/simple;
	bh=L6aQlkYdf1XjFaD3aaJ4kmtrRKD/GnbI/GjZRBMbZjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOJkphCLRF8uICcWiV8HRQxgbZan8bb2nyTSGwZ01B9dCQ0WvtxNpktkE+DBpUY2sCU4vgRe0cRxVcai7+xJNZzeWbrWoSHCYQTdYJxpqHGT6CmapS5Q9uxjhPKKi1Mve+zgliGzHhcTzvF8vHX0uBSZA7XO/9JCaTG58SsX6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yr0/iviL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35f1c209893so4121742f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718184190; x=1718788990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=px3FWD61KwYUoVLXs51y4wh/lB5F1voz4oJ3Gukra6M=;
        b=yr0/iviLd0x+N6izlpoVwFHchZVFq0+B/C4HXaQcEE9/WbMxy9Wjm21AtJpmPeLL5d
         aO5VI1CC6NBddliXGJS+J2uZjOGlV7ad3uSMWNYb+Fyk8INe0Gw7fbfRqjCZTyl7lOMc
         k23dAlQk+wIyN57fIHhkxtULBXIVVXCCjqIf0kv5SF33rv7nsyjDYr8l44xaHmJMh9/v
         xFm2QtSj8xCGVkTgM2mJhoqj0KlzYfRyf9/locAICanKC8TQPmG1+o8jR+rMF/o+fNiH
         WkrnX8bQkrhPdnawTqnBuMEQTYk/Xy3mMfJy7RRN2z5BU4euqLec+NwN4rBccdkoj+ob
         aPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718184190; x=1718788990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=px3FWD61KwYUoVLXs51y4wh/lB5F1voz4oJ3Gukra6M=;
        b=VnPlT8WES6W5HPMnLfB6CjOKSR+MCPX3+F3W0vYBMwzn5aN34cWht1cjoBczVOpdcx
         3wVHe9Gb2s0yafi0SISR9cawSoN4CfjDMEpxWB1PkqIXW/gXEYf4FtmGd4hs/YOm6dq2
         83qIGpiPJlhHbcQwOjnL1uRKuBaXp7Rb1iA/Ay4W2/YWZNY3IZSZDUU7g2LaQQaIVlfn
         QfawAFxGmYiJRJTK/SyH8ATYTsUnLPMdvufXfZvPLygdKqC6xVQ+dUGO+ujwvKsgCnZw
         Wp4qxyl/eiK/NxVQ1Qdr/wJbsIX4kvpLCtg3hBSWRGU7y6HEmKta24Q2OWbQx3TQdyYv
         ZzeA==
X-Forwarded-Encrypted: i=1; AJvYcCUaZBbQUeKehpnodsw63iePF5zjKVnI8AEQnkpGEOkbO+ZOVnHlHIWFrbRN5xuO5tb9y/vVbMZV8pKaJq/CMaLIyR+dt22gJNiw0t9Z
X-Gm-Message-State: AOJu0YzozU49vpzpl/+N54yP/gjf0vvn3qcf5Ublc2NekLaDF+4zeXvq
	AnYSb5rPMcEk9z33WD6rmqGE98rrLol0PqqT4hHlJwNdmYrPSf2/2iijZ6d93IE=
X-Google-Smtp-Source: AGHT+IFOMCjOwX/KFQg+pTTAbiYMRIrI6LiOBW6EbiPB1eB/0gA7Kzf223cvhK/M1n6QlFI50LRw1w==
X-Received: by 2002:a5d:4f8f:0:b0:35f:1cec:3cf with SMTP id ffacd0b85a97d-35fe89395bcmr1062754f8f.65.1718184190317;
        Wed, 12 Jun 2024 02:23:10 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2598ac1esm7109636f8f.93.2024.06.12.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 02:23:09 -0700 (PDT)
Date: Wed, 12 Jun 2024 12:23:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rtc: cmos: Fix return value of nvmem callbacks
Message-ID: <f2156a50-0ee0-479d-8d60-3255f3619ae5@moroto.mountain>
References: <20240612083635.1253039-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612083635.1253039-1-joychakr@google.com>

On Wed, Jun 12, 2024 at 08:36:35AM +0000, Joy Chakraborty wrote:
> Read/write callbacks registered with nvmem core expect 0 to be returned
> on success and a negative value to be returned on failure.
> 
> cmos_nvram_read()/cmos_nvram_write() currently return the number of
> bytes read or written, fix to return 0 on success and -EIO incase number
> of bytes requested was not read or written.
> 
> Fixes: 8b5b7958fd1c ("rtc: cmos: use generic nvmem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

After we fix all the these, can we add a warning once message to detect
when people introduce new bugs?  It could either go into
__nvmem_reg_read/write() or bin_attr_nvmem_read/write().  I think
bin_attr_nvmem_read() is the only caller where the buggy functions work
but that's the caller that most people use I guess.

regards,
dan carpenter


