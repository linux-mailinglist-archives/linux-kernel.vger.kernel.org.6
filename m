Return-Path: <linux-kernel+bounces-307555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26529964F01
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A9D2820B7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506FE1B8E93;
	Thu, 29 Aug 2024 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gmqA0UN9"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9871B6527
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960101; cv=none; b=ZGB2q9HBVIVwj8aI86eyfJgpHVWe1KfUk7FH4FzULJqchy7UiuiofIQVY9sPhEZ4yc6QG9KYHlJa0r9Z0oGjf0w+V7LPtm8r0GQgjA+wyuj1emBzTnrMmcPMNKzWfYkSpUlmsfke8/z2jFRvVjf+6yVsyLdIzUrkI2O1nmPYcIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960101; c=relaxed/simple;
	bh=RIc3uiEi5hFUHQ+W+Ywrw8vY95ZuV8nWSKks7hk1ptA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si5Jg9yQ/i8K2NpspoOvuHdM4kSsAWVTXuf2GAWnJzZGiSUv1X0KaC9kLSkrePBEgjq376a+4N7s+S2OeWkF6QwmSh9COB81B3l18EWd7uGGqmq1ym3fpm+hVldcozgGQa+duI/330ip+/9DWwlu2fyWEHnHB25IB00CQeAEMXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gmqA0UN9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4280bca3960so9102765e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724960098; x=1725564898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ul9VUTXGL81P74c3MJMKeDU2A/cBzh0fq7mXGOHoEnI=;
        b=gmqA0UN9zkLhmy9+B6w9Y8hmJKzsvE7NPr2250rs0l1X7qZy+fo1lerYFj9blaWaUM
         dVLQu/WGOFsLyFEw0bS1u1pejSe+Bjorlni07abG4Psv2HAHgKpDx0utW+az1B7cOaWx
         8z2NBJgjpBSW4QAgZ7wnD/nn7q/LelOeb4sodFxVWbmXkagWO+jA4R39MiUXy8KEkBix
         HTu9tZURUEdav0A9ebkP4kJuw9K8c+ILmisI2PVFxY8rN4yjKS9fJAdY7VrcRUrzPSUY
         AUQxn/5CLUC/z+0YPcwmL0kglxL7MTcuqIz54sTYNtBa/oYB+RuKfR1IsLDPFmZpunRM
         fHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724960098; x=1725564898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul9VUTXGL81P74c3MJMKeDU2A/cBzh0fq7mXGOHoEnI=;
        b=ObdRDnihH60m1APagiQANAs1SAGbnnVl7+Edctx4kCtU6+qmUASJy9/554hjtwVmZn
         upDkL+wCiHNNjxUp5QUcBMS4Q5SPtY47tP8xwV6SuXtH6x9qTf7SRqegExQGPkkp7+al
         I2BME2eulY/PlBm4zGjOV7mL22fecnwJMKMMeHuuqCpL4qmpAAuS8y0tHbuKq1UDNb3G
         yRohFvwjkX8TKECy+yAlHK4rdVowPKlqTv0HHJODCPmoxiguOjsh9lnV36nxPZQqFnkN
         sq0kO8TE+J1q+TiLKiM2I23yUDb9AsRccmlZQo2vjLxyOhQzYi4GJ9sBuQQpaOcymw+W
         YuVw==
X-Forwarded-Encrypted: i=1; AJvYcCWSmo3iS5Uv7y/1Oqx6Nkax7Gv2Swc6uvN5TdN2feM76fnUwft75369t4nRuGKxEGDCmnxWRa9DatQaz9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoTvm29DeObkss9ABqM2J2qssGrwcxG4ilrU8xWRGq92o0O7Kr
	cWq9X0n+TUoyK27e1YROillN7PNeRzF1r2D1JAiqyiQ3nhHgaFwHTqkGR0L57pY=
X-Google-Smtp-Source: AGHT+IFLxHgN97pV0OZjL8rF5iTzoHIZcryvQw+TfQUbmMgFaxMAn0TsMg6LRyCZTDhCZXw9gtnqlQ==
X-Received: by 2002:a05:6000:144a:b0:371:8af5:473d with SMTP id ffacd0b85a97d-3749b52ebc1mr3061727f8f.12.1724960098181;
        Thu, 29 Aug 2024 12:34:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef7e933sm2136404f8f.87.2024.08.29.12.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:34:57 -0700 (PDT)
Date: Thu, 29 Aug 2024 22:34:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Manisha Singh <masingh.linux@gmail.com>,
	florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8712: Fix style issues in rtl871x_io.c
Message-ID: <497fbcd8-2984-4be5-b877-1dec6a8d7bba@stanley.mountain>
References: <20240828204552.26790-2-masingh.linux@gmail.com>
 <607b86cd-d89a-4072-af36-ce2ce5c1f7fe@gmail.com>
 <daecc634-4faf-4dcb-b03b-f57f24673a88@stanley.mountain>
 <01183b3b-b8af-4451-8b52-e7acd0b4a9a5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01183b3b-b8af-4451-8b52-e7acd0b4a9a5@gmail.com>

No no.  The v3 is also fine.  Let's not stress too much about minor things.

regards,
dan carpenter


