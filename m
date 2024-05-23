Return-Path: <linux-kernel+bounces-187633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8CB8CD59A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C151F223AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E483614B95D;
	Thu, 23 May 2024 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1TFSaaU"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A782E13BAF1
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474179; cv=none; b=PVO67gbT8pFtGITGJgFyUK+XjGXwFqYWMWmxJ5gxtgCIZop78qBblRfucZjvzKQovLdzU7vb2qZOPnPGu2it3EY7kIp6rHNvETOgmbVW0pVZh5RR5p/NVeqZU/wqDwRw1zU+ZUGdZE9aCC3Js87sMeiT1CMzPJotW31ldfg2vEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474179; c=relaxed/simple;
	bh=wqnOUnUOf0fPZLabeDBniNGjx8W2FMJzThyw1j+5B7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbTT79CobLNAc/WqhB4kNkfOziC3g676pSuTBRQS6h+D13RvHnU2BoDBWnG3oPCQZgBdVJegJouG1Xm2OdIm4io6QBSSea8rPomOKLVTWl6LGDlb6lIu2sQp4X/nVkv0TpS/b+EmHm3pnwcnjTvOJT0Va+XfrfmPYdd10d+VOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1TFSaaU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42011507a57so56686585e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716474176; x=1717078976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MTc+trNC04p2Tq6aVYf4Ac3pfBeHynrqpnO2Xxz5xys=;
        b=q1TFSaaUNT31COyE1+ebcI2FIFUku8GKvHNanJLe8YZpEBWbcBm+59ifec5/ldzpLi
         7sWeHUTLYQjauXiXfH+AO5l2uj8X2TZH+rwLQ2q0lYNAH7XfgAfDcKkaiSn6XNoS3AEr
         GPhWztp2lZqoqke03M/VaS8fdIe1mt4RMsr/0jD3vVxeEV+Tzln7dqD16d7ls/q5WhUO
         SU/KTOYoZCnasoNkAInpVueFMuKu8ExgU6ixAmg68D93qB3NIM+EIe25c33NEEh4/kqg
         m+rK1zIlG979R/us6R4sjiS1DgpTIFhS17Cya6mWfz7y+EiCFLkC8lN2+lxnK5MHWsev
         UJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716474176; x=1717078976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTc+trNC04p2Tq6aVYf4Ac3pfBeHynrqpnO2Xxz5xys=;
        b=ag3LOLBdUWwIPxeeSxRFUjpfqyMvprHMuHo1HiA+gMA5UoujyUMer1IVjjiAnbAdSp
         FXwm6GApkIfLVTzdNPWjRcX01yyvt/oEmGy15Z0FtnxeD2/ie6B/gVCKQVMvuYIL7BXo
         LaZikQ07pnFtFceSJ7knhZMQ0R0iSP1ppP9e8PExB1bVJtyHb91CSbusaI1MSJKEt6AA
         zgh8YDs0ZJomzs1Ni813cOYJXNyqyWbktJpFjivzwGaE0QjwUuS3sktuSIMVHBTT3Je4
         lbPI+EMWyOJtajtgWbmehy6rKfpnQs0hyVgb8wgw9t5wxDB+/GRAlyKcG9XlyxxofmuJ
         wAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDTQH5RQJTjLD0y18Es91NGA+2y9G9ztAXQAhl1WRAGy84RIfA5CbHy7G20kMHwGk4sRQpc66URPxK53v/uM8xPJeVeWwNhw55Huok
X-Gm-Message-State: AOJu0Yxw1fpBJ0sGcZXXheGT/thN9yLkqTcvCQBcI3BHr2IWsyzJokfV
	GhknWyOC+GunhR3/KqGTaQxLnQGHlBAf/HRro1zU81xeQXgA5kQ0wlDTWMJFvbg=
X-Google-Smtp-Source: AGHT+IFewh1SR//zlACHmRoQYyPTabBPg36F2XOjYcunPUbJ9/EFmdtw996X1q1Bu4U7naUkTaKZPw==
X-Received: by 2002:a05:600c:6a15:b0:420:1551:96a9 with SMTP id 5b1f17b1804b1-420fd37f192mr39985755e9.39.1716474175660;
        Thu, 23 May 2024 07:22:55 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100eeb962sm27050925e9.1.2024.05.23.07.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:22:55 -0700 (PDT)
Date: Thu, 23 May 2024 17:22:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Wardenjohn <zhangwarden@gmail.com>
Cc: jpoimboe@kernel.org, mbenes@suse.cz, jikos@kernel.org, pmladek@suse.com,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: introduce klp_func called interface
Message-ID: <18994387-2d2f-41e5-9ef6-6541dd0015d2@moroto.mountain>
References: <20240519074343.5833-1-zhangwarden@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519074343.5833-1-zhangwarden@gmail.com>

On Sun, May 19, 2024 at 03:43:43PM +0800, Wardenjohn wrote:
> Livepatch module usually used to modify kernel functions.
> If the patched function have bug, it may cause serious result
> such as kernel crash.
> 
> This commit introduce a read only interface of livepatch
> sysfs interface. If a livepatch function is called, this
> sysfs interface "called" of the patched function will
> set to be 1.
> 
> /sys/kernel/livepatch/<patch>/<object>/<function,sympos>/called
> 
> This value "called" is quite necessary for kernel stability assurance for livepatching
> module of a running system. Testing process is important before a livepatch module
> apply to a production system. With this interface, testing process can easily
> find out which function is successfully called. Any testing process can make sure they
> have successfully cover all the patched function that changed with the help of this interface.
> ---

Always run your patches through checkpatch.

So this patch is so that testers can see if a function has been called?
Can you not get the same information from gcov or ftrace?

There are style issues with the patch, but it's not so important until
the design is agreed on.

regards,
dan carpenter


