Return-Path: <linux-kernel+bounces-243858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A422B929BD1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC041F215CC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 05:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D93E1171D;
	Mon,  8 Jul 2024 05:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uuxImaov"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E82566A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 05:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720418022; cv=none; b=QKIJ97HOrPbsWNZNS29JkHo3ILbqBJ/p2VYkaLIho79jUdLbCj+hjQ4IkUEkhxg23H924kMQcdUf5FbJyGoqLMeq7l0PES+fK+uAo3I6L0t25/zOzAJd6mejW9iwH/ckDmS2+7VOoUOZfFR3EP8AYxKjkZaZU/MAyJ0FheR1a+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720418022; c=relaxed/simple;
	bh=k3sZegvgCSRZDvxaCGbPMnrHk92nUiiu+U/vHSWHQ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIge9pHFzVt6PdUasLwZmzhmUZTpBlEglZJELZ3v4+jPpctkV0wg/QGr5kSzind1TrenBiDyw1h7jK0C6Xl4LEeDLI9R3HqAhYdSdzyI5TfTZL7KLU1dxQ7PejdrleRlHn/04G1URh3tecNkeJTl8waanRg8cH3SfHE02aYHXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uuxImaov; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70af4868d3dso2034944b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 22:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720418019; x=1721022819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7MnPLFqEr5wWUkJ5Avv6Q9E12ojEI+o0v8AA8IEQyjg=;
        b=uuxImaovyyAqyUjnvOv3biPnAlMXv0yydD26LUlIB90uDJsyZ0HOHAErWfHIAX6Tgk
         TeBBxazYai7oKN+OWl62aNBQaLLudjgEiIN4f89nMNsQj6+vJiuKJpZQMdHRy+RuoNzV
         dTQymJ5zdJCYdhQ5mGLvZE8+lE1J4ZR1j/QG3oEdVv+cqxwKDX4N2wto6fXwMY3qV+OL
         NaMBuIgydJo/049IgdyQktzHdN1EJvOZ+dWfJBseOaQfVrV2BjdzVORUfRIibSDxxMhk
         CI7B4t0gGqplawPDOWNKLf/A0vZOl8cB6xqJV9VyH90gxQgIwcyjOR2RAjP4J1SUu4tJ
         DVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720418019; x=1721022819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MnPLFqEr5wWUkJ5Avv6Q9E12ojEI+o0v8AA8IEQyjg=;
        b=OujbWoEBMYvv3HTRjnnHA7PwMD2HUJI2f8P7gQHPAttE3KN9uW0nuc3LP+A48wmUXA
         5ZiMhNIb8ZfWEKM6KDC2BXvkK7TqAmhjQwcdkCEUbRom6cMbvl2iFLegQoJ/IBTgBsd8
         U3gPGHU4G/s3PA8ltTqFfklliVgbIxdPUaSVGgUb12rmGqWnecseL4H7KuDX/uoNk0Gb
         TWEdPWhBGdAUIrPU1W6b1aE3PQTYSRX5eQWVsAjoZk788UAQ5Gma797i/qcoax4lL1og
         E3Il1IcYjG3owOSzcK0BwsaQpVNodH2pnWqMCURgfQiMnXCLy3/rsRN80pMgwCsTpwD+
         fVpA==
X-Forwarded-Encrypted: i=1; AJvYcCWoTdILfQMqn1DIBmmqkxGJb7EXKQX9oPLHi2dNTfRldXXbVtl4AgHb8p+leSpy4v2JfYgEUk2KoojLauafb3/15wuH3CGPy+ymOAwX
X-Gm-Message-State: AOJu0YxPxhDZEm7+Xe1zC+/EvAX1F/yNWuDc8GJDamJjp61HWBuxzs8r
	s3i4gFFjbgV5zgJadituoZB2xNOediUqK9nAR77gPgeeFLgVBMsi264fbL9a8yU=
X-Google-Smtp-Source: AGHT+IF1hOX8XoGx5HyaWGW+Cyy7qlkkVoVp1tuooj1gaUVsR6BxjALo8kufZT7NlabK0CHhfGpMTQ==
X-Received: by 2002:a05:6a20:3c87:b0:1c1:a257:50de with SMTP id adf61e73a8af0-1c1a2575f9fmr1302191637.29.1720418019366;
        Sun, 07 Jul 2024 22:53:39 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a951741sm7333159a91.15.2024.07.07.22.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 22:53:38 -0700 (PDT)
Date: Mon, 8 Jul 2024 11:23:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Conghui Chen <conghui.chen@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 58/60] i2c: virtio: reword according to newest
 specification
Message-ID: <20240708055336.5yquzurmoydscvqf@vireshk-i7>
References: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
 <20240706112116.24543-59-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706112116.24543-59-wsa+renesas@sang-engineering.com>

On 06-07-24, 13:20, Wolfram Sang wrote:
> Change the wording of this driver wrt. the newest I2C v7 and SMBus 3.2
> specifications and replace "master/slave" with more appropriate terms.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index c60ae531ba57..52ba1e0845ca 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -183,7 +183,7 @@ static u32 virtio_i2c_func(struct i2c_adapter *adap)
>  }
>  
>  static struct i2c_algorithm virtio_algorithm = {
> -	.master_xfer = virtio_i2c_xfer,
> +	.xfer = virtio_i2c_xfer,
>  	.functionality = virtio_i2c_func,
>  };

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

