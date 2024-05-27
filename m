Return-Path: <linux-kernel+bounces-190403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782718CFDDE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC9A2842B1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C4A13AA5A;
	Mon, 27 May 2024 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nIAFvG6n"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC15ADF60
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804430; cv=none; b=KJhty2epqxlKSYNpm94j94SJSnhDI7eylVDywVW/+/NNPcDnhTkQS3+HSjeI/YHQ+wu5qsAZiDUXddQPeQ9Jt8lofV3A+BuxHte1I55TwW4WYDuqt/eYkWsN+/JxmIt2+mz8nRb3BkurYPnFXRjafMg8TdFIBnyTkbsfAU6Ra8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804430; c=relaxed/simple;
	bh=lhGSLA+6Fd+lkf7hFK9IB1TG8eIIis9jKYhy9eOwP2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dx2eLZTsoGq3JDk83y3VEjUiLSvnZpqi4Sf7j0YCgkTqcWmp/pKp/e0mbax98+NnIreRA3X34N/UVAyR/heMqGSP9bNGEVyp2AbVGVUgPuBwpcA6o3NrFl2C0uj4yz/Q2SUA4l4mfx+nfExNyDxaOU00wLwDCXMjCPh3+yKlEw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nIAFvG6n; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5788eaf5366so1841196a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 03:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716804427; x=1717409227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JbPDN1bud0jCQR0vRfMQ4CNUPwHYHGmVY5chaq0K9V0=;
        b=nIAFvG6n3Xi3QOQ4GvkFymxNUObn297f+RX1WHMZpn0A/WDuMQKooPSP5kdvAnQhHp
         IrA95Y0md9ZDfk76PL2tGvNwMGQv8/QepCiRI2lGM7ZVjajVeRvnSaztnveR1DRhgIGA
         vjPzGDpZFwFsNYCCYtztJxvLImAwjYf+7Xq/tB9+lZ2pR2Y36VXX5EtBGWNrmyKv82kL
         KCd8BdlCJJODHKGgqj04RjaZ+yNnwwUrFFJbdKlejxg3QisKkHGEyn530dNfd/aZz+yF
         KT7BRNLocbk43cbtyewv6ur8P55mdkg/F4emh+gaWMr4IEr/s1lYq0Zv5Te+kC9uJeL0
         lctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716804427; x=1717409227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbPDN1bud0jCQR0vRfMQ4CNUPwHYHGmVY5chaq0K9V0=;
        b=rfVFyxomOu84qVttekGSMEewvJdDen/z4iEKZTmvRP8yL1P2Z2ai+fRWgcEl45QmuQ
         pBgifipqjbZBROspXvCUQ+ds+LrCwFR1D85yrq8zBSjz75FXT9SggCk7eR+SUIhSPWv6
         3HVSM98cF3nVO8PlLJP2o/C5zcZAtWIcNiqAIj6ebwidvN7gUxYFZfPgW3Apg5tjb4mJ
         TbRnFysmHwQgWk/x+nfvvOUfynykv+8NVC8AunD7GhwHa+BMg+gCkEfOr22sJNAD18Os
         0fws9EC0OckQWlX2kMU8hJYgE3drz03k67Wpyw/v1AWDiNnflP8KlrJo4j5Ia3NSxogU
         ocRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw0raY5BUo6l74MBai1/YRiob+2jXWp9XtdsTV9iZEKZOboYbHsFE78ShmgNHj7en+o52YRujn7iyIlONVHq3Mlgj1nviSVAq5eojm
X-Gm-Message-State: AOJu0Ywf2gNFOTewVPs33fB4pTjne+Ewu4DHSy2XjG8EGpqoDV+YgBOA
	49OhtzDgXFdor3txWwz5KclfRHZs3J32TzpGa+mMY7VABEZwcp3nMmvKX3qJNAs=
X-Google-Smtp-Source: AGHT+IHmKdFKS+UH05kV/Ub9d8YRErAmwvuWURmcX2+a+Wh+DzcLct8J/iJmx6FJlI5QlYuLMmZ62A==
X-Received: by 2002:a50:cc85:0:b0:578:3336:92a with SMTP id 4fb4d7f45d1cf-578517a5268mr5768669a12.0.1716804426876;
        Mon, 27 May 2024 03:07:06 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d018ef3fsm1649365a12.13.2024.05.27.03.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 03:07:06 -0700 (PDT)
Date: Mon, 27 May 2024 13:07:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michael Straube <straube.linux@gmail.com>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	namcao@linutronix.de, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] staging: rtl8192e: some refactoring
Message-ID: <efe21ff3-313f-44cf-b1c5-361b48393fda@moroto.mountain>
References: <20240527094527.2046-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527094527.2046-1-straube.linux@gmail.com>

On Mon, May 27, 2024 at 11:45:25AM +0200, Michael Straube wrote:
> This series refactors two for loops in _rtl92e_dm_rx_path_sel_byrssi()
> to reduce indentation and improve readability.
> 
> Compile-tested only, due to lack of hardware.
> 
> v1 -> v2
> - Removed patch 3/3
> - Added Nam Cao's reviewed-by tags from v1

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


