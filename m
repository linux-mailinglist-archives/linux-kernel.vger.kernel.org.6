Return-Path: <linux-kernel+bounces-341915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE01988840
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09151C20A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512301C1738;
	Fri, 27 Sep 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6JaPc32"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F4B1C0DFA
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450807; cv=none; b=mZcaKmWnKs0caPt/sJHoTqCJ37jojUJMe5Gr13iaEGjLz+HUQGSV1HhXOrEsl/ZkSiVAPOd6oie+kSwMsN1j2FVpVztWOcPRC2TmQqeIRiGWTviNrHhszQmjZn3bBxMQgKGY97HeYXxZBhtzTqru6Ll6M0VKFY8/l/AgQuO9m8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450807; c=relaxed/simple;
	bh=Vdfhnsi3EotHXVW995ft11x8B3qGPa7cvav7Yi70Zhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlsXIgI4RyYfNkzWLXgHp+NQlTpDjYjixS16h4cpxDf8Rnp2HAjVtl57yGAs940PnfNVuATbwbnos3Sh9gydXBcYDwpXvBQrRhjBFhr8qH2u1WobiKKvLgSaep/IWZNcotJcqyH7PeWKS96SC2ayJNk/gtdRApBLq65gi1NCTGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b6JaPc32; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so20918145e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727450804; x=1728055604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/nNMy1Jele6OQzwkGo6J+HA5rYJclMwLaw2lNZiPamE=;
        b=b6JaPc32Fzd/HT/cIdoAMFIokeAeNjLucz0MtGa4Mfe4yUOlM7XQ5YN4+2Ribvd0DB
         WmLFno4Z6UFsouI9WOJMSJkHSMXOEEXBMgmQ3wNDOf1oZmPFzH33fpUK1L1MJY33zR7X
         Hg3+j3uIgzdlbpmhCgnVaK1WvHNjPz3DXcEXqsSM+ZiHwTRdZoHB/2S1jpUkqKS4ibW1
         x68ysED0aDcZD7Kuo44w03Fxi2goJnGbQrOnbCy9qj4MO/xnR2qqTZ0JBeSb2nkFaca4
         CcXHCJhXjDWmpALmAC5roGYSFGLHjXUIQbJ5JE/5L361Lv7+Hpi4y8XI3Y/Mgu0Q2nIK
         rrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727450804; x=1728055604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nNMy1Jele6OQzwkGo6J+HA5rYJclMwLaw2lNZiPamE=;
        b=uNIVjH8UNYfZ/XaRAyc7/GoZ05DkNVOyWuzkcuk+DqL77eLs3GQYdOhP8jCtXqcVmE
         EYmAfEwkFfln4N2MLOfmYxVm+uM73dgLCqMbXZPLdoTCtlyowO//Qtiy60pdhKrSWyLK
         JbCcWLb2XkDEYEyQHj6t+hNjYPkGx0Ea4XRe/83jgH+U4C9duZCjYIZLj6IFt+9fUaJh
         qnZgnih555VMS1dDuSelz0DZRlnQA0wdRNyC3cHK3OtsUkMWE0Jer2cuVLv9+ttNt8bb
         KZCLkRsH/ANuMZycGFIwiL2wgi4oAxQaTEFfH6uHQvNZkqWKKsI0np0nhw+YIU49/grh
         eMrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtLF5zkHAYqXxp2orVk8XRA5MBvPDXGzLWHtjv/TKUFwMlGeOTCUL+FMCpp4MVfIN4MlHNYDpuQ+KOErI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXud7jKRw1OG6g+yOZATI9fMFCCLanIolkqG2i179f029+Abek
	SsahFYkR8yNIV/0wtes7KycGrB4FaQsZrwYPSqH7sfJ2+e4+TkOGqe7dnY5qPn0=
X-Google-Smtp-Source: AGHT+IGBH2Kg/YpCT/R723MZc+TGVSxQKlIeip9U0L75aWbuvjywKgl5Tnj1OrlrAkjg/xIv+vWNzA==
X-Received: by 2002:a05:600c:4e08:b0:42c:bad0:6c1c with SMTP id 5b1f17b1804b1-42f5844b3b4mr29417935e9.18.1727450804379;
        Fri, 27 Sep 2024 08:26:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57debf07sm29600285e9.22.2024.09.27.08.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 08:26:43 -0700 (PDT)
Date: Fri, 27 Sep 2024 18:26:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xingquan Liu <b1n@b1n.io>
Cc: Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Fix unnecessary parentheses warnings
Message-ID: <9bf11c06-85c7-4ef0-ba26-e4780a28f23c@stanley.mountain>
References: <20240927151637.82772-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927151637.82772-1-b1n@b1n.io>

On Fri, Sep 27, 2024 at 11:16:36PM +0800, Xingquan Liu wrote:
> Fix all unnecessary parentheses warnings in checkpath.
> 
> Signed-off-by: Xingquan Liu <b1n@b1n.io>
> ---
> I ran clang-format additionally because I noticed the Linux community
> recommends submitting code formatting patches along with other patches.

Probably avoid running clang-format.  If we wanted to do that, we could have
done it already.

> 
> I'm not sure if there are any issues with this.

This patch does way too many things at once.  This is a long way away from being
something we would even look at.

regards,
dan carpenter


