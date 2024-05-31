Return-Path: <linux-kernel+bounces-197396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FE28D6A07
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C691F2678F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA4E17E443;
	Fri, 31 May 2024 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrJhPj6Y"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998F17D890
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184620; cv=none; b=eT1k854WHrR6o7SPZ8CBelfJMpMbOcgGzNDrQPk8sxEqm/xV9P2rjw8KqXh7B6uA9jrG/sXjvLZ0DLhvXcOeo7tq9PEoNjf/n62fIbQMYA8vdNix/9Nc/oO/WrFvJGr0vHDLoJQZS6/Zxm+RYroGq0kHpAIGMe9poeXK+WE8y0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184620; c=relaxed/simple;
	bh=4tvjmu36F6bVNll87Rdec66D3Daq61/yZgAKaXG9tA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJQME5BNel4fzQSegaE/DaERvGgQ2cTIh0Fkg0XnxV1LF7TF/HEXaAgyjHikcqG9mHrFTJRsktIv6Px49TheBI4J+LO0pIezS+RekrJ7Y7kKSIooBb8HeoSvY6C5e+kGIlb2phmrP/+Xv5OqFyHGMWXNETqM5bdeeNldc1UF2fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qrJhPj6Y; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b27afe214so2075944e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717184617; x=1717789417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zpEOVVkN3svgvLJ0MSvleVz0zBxYmtfdpebZBpC6rKo=;
        b=qrJhPj6Y0J1Bp/a3KHTPqHe4Ki3QnE1TD+9YoIlSnJNmFbJ+BjmAGoCJ5I8yYrqPtW
         tA0XCPwHrqw3Rc0W5roDyRm4RE5gngHnuEl3n19sLjzpU77ZpKKi8uTpr6w1xGzHOSQQ
         ZS0D1SC8C1aF9fE+fnhVdRMWpvTJKABbdA+A9nID5T20tLwVOUjF+RhpaPWKM9jP5HtI
         dKiXGX/R30S5JksJ0p6rk3/Kf/8cPmw0FIjNSK/Dr0BeTC9PyLRc6PYv38V9kNU5DtVZ
         DxiP3UrGyYQ0xb/uroEZ8JQLwRHrmXBjTkqEXskEt+JqFx/gYJGbO/TAJ5OaJRHTzJDr
         adkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717184617; x=1717789417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpEOVVkN3svgvLJ0MSvleVz0zBxYmtfdpebZBpC6rKo=;
        b=Gb6nPGIYbJrK89qys3gNtHIhMVtF7aHowkdyUGgeThCaK4TgaTEk3iI1xARknuEW87
         tMlOhuZ494CjCMi0hh7gPpMKHrdBlp/gFO+UH3Juj51opfp2Lg5/Jvt8wG6ZF4eP8ylS
         ABFQ508QY4Uk0Xpb/FcVTxd/74DmqAyOkNUVd6ZHEG+nBlMrKk3jMZP38nBwK4DVnX4L
         UeXsSF+ktpZ+vcl0vS+irwf9lnoyqCGP54f31yteV6jg6xqr4GVl9MdnMtnt8YlvEdJJ
         iXX9kjfg994Wu4HPhC8MFowm03jQ9HShVsAS02WWbUEm1xrxCowqhLYeZ9dTsHnw0tj4
         zwmA==
X-Forwarded-Encrypted: i=1; AJvYcCXC4FQUq2feo9QyTi/AmtwMVN6ZqVzYHOf+uo0GNFetAQRozZ8f/kgNltlW00T0v3fULv23WH2b4X8nHBx8zxtFflgKj5eKs6HHVnqq
X-Gm-Message-State: AOJu0Yz49uCg0JgD9lJBbmVuAaiy9AFXiLDozLyC15p3upOePak9rHp8
	IvF46Z/2Kp2sCkYD0GIBZ/kxAoiM9IcxMi5u0l9GgXmk5UqU7CiwzPEMdHZiiLw=
X-Google-Smtp-Source: AGHT+IHTgcrjUunFR0ynx7TMorgozqy6t9LcOd6tSOk8IoMTI8CWw0qRJ4Kk+E9LurNmgIN2XPwxdQ==
X-Received: by 2002:a19:f519:0:b0:51f:a4e0:8b4a with SMTP id 2adb3069b0e04-52b7fa347b1mr1639739e87.21.1717184616749;
        Fri, 31 May 2024 12:43:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d76217sm418812e87.121.2024.05.31.12.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 12:43:35 -0700 (PDT)
Date: Fri, 31 May 2024 22:43:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	pmalani@chromium.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, 
	hdegoede@redhat.com, neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v5 4/4] usb: typec: ucsi: Always set number of alternate
 modes
Message-ID: <6lvxjiaxlulwknxo36x5ll7ueneqvu7paiz64vjmzk6v3cbq5d@5s7dkyowtabu>
References: <20240510201244.2968152-1-jthies@google.com>
 <20240510201244.2968152-5-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510201244.2968152-5-jthies@google.com>

On Fri, May 10, 2024 at 08:12:44PM +0000, Jameson Thies wrote:
> Providing the number of known alternate modes allows user space to
> determine when device registration has completed. Always register a
> number of known alternate modes for the partner and cable plug, even
> when the number of supported alternate modes is 0.
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

