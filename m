Return-Path: <linux-kernel+bounces-313169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA87D96A153
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79132876B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E5B16F8EF;
	Tue,  3 Sep 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NiU09j9+"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84302155742
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375313; cv=none; b=PixAsZQIqA8O+F+iXjDeLUGVqpBz3PQF54FlOJlReRNM5dLFtTnRvfw7jZjRN1HdPmeEGA+Oix0/xFdzAkYPMxo0EJoy183DlYwZeuvCALIDlS2nrgACGoNA6x0E5ImBxnhaAbl8RqBBilWm7qjWiGrVVkHvfHx323YulzBLngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375313; c=relaxed/simple;
	bh=/S0el8odGf3dWTBUBsazXa+FnmV+VPcwZpwe+4m0TuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKTHl3Zt5EXVUnEbRwk29RsBV/YR5DZJqdUSI71OAwlIm/doQlBgAfvav3Cdvob2QONU9Cw2BlXZ/0HcDb+BMu3fImNQE97I4oG45SCD7CeweyuSdggaFU8ARruFH23PXb3vUDgKdMVukPbfRTInNn6SmpCjWzWy8XPfUysxuXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NiU09j9+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86883231b4so647704166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 07:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1725375310; x=1725980110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/S0el8odGf3dWTBUBsazXa+FnmV+VPcwZpwe+4m0TuU=;
        b=NiU09j9+MCO1bekKwtwcHfUIgFVjKswR841QjCfqLQq6UlNxbnN2DK/vY3tWjykh1o
         aje7lAZZwmR+81vTIH9pHuGgbTn0PkscKray51oysyeGJd4jblEI3QXbb6Pw/O9JX/aw
         cY9JDZF1iBhWBAXyQb2cKnYx7BjBeuRagnMb6S396nIaTozMa9iDtr88iNm8wRFFJMP6
         1BOVXWtJxiJJH2wYLWsGKU1dmAgULLiZHg9Xk0F4Zi530+vwD+EXCqDOzWTJExLSl/Gb
         qKOREI4AKQEsAN+n90SVFad0JjCPJuMucqV14DERNZ/y39A/PsgPUF2toEBMJBDfi5kx
         nasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725375310; x=1725980110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S0el8odGf3dWTBUBsazXa+FnmV+VPcwZpwe+4m0TuU=;
        b=fR6mrBdemEFr6YIzr68N0edy4Ro8PPx/S6FMiCoPB0jTxt0EtxLOxaB3u5K1CFQ/ih
         GutuBq/Hpta5LQ9sUfTYI4A0967oQXslS/6nN4QOHoDF8EETB/yP06o3/r8uIW9fsOtP
         ZtmOBLndK1SsrxjDzyQd4JD0cV3zTXbSJLNPAvUWsCVqTTVkt+FVnfXufD5fN9W5yzHM
         /0uAj7AbPvcG3oDqn/edjHEGoxy4bkRoJ/jGXmwrE4OqvwICP2EJSSQhzANseU2Rtl2n
         jjoHktCJHT0xZXACbtyjPk0gpw/7dorX6D/lwXuKpaLOy0p+/H0U0u/NRYg3OLxgensk
         FDcg==
X-Forwarded-Encrypted: i=1; AJvYcCUCpahYjqH/H+ve0EOG7wq9gpD5Lip6jcU4E7ts+ijuTzWP/Qy7M89Cn1Z+YIV5m7p8Cgqi2S/Q10T2858=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3nZSerR8vGSLfCpjk2o5iPjBTYVxwfORgzQtKxyzP4g7JFRWK
	youeT+8lG53a7Gs9EdM9VEOCvAljw1dTw+/dILv1be6ZTgBkBsN6kxHt7eI6xz8=
X-Google-Smtp-Source: AGHT+IFNO2CexpzrY5N/V8RZAmfAMPJk2LFTKLsVObG8b67keQA7Tlhjb8AXpYmyaZYUO3laOiEt8Q==
X-Received: by 2002:a17:906:da86:b0:a86:722c:1460 with SMTP id a640c23a62f3a-a89d8782136mr778706166b.18.1725375309425;
        Tue, 03 Sep 2024 07:55:09 -0700 (PDT)
Received: from localhost (78-80-104-44.customers.tmcz.cz. [78.80.104.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196c88sm690447766b.102.2024.09.03.07.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:55:08 -0700 (PDT)
Date: Tue, 3 Sep 2024 16:55:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH 1/4] octeontx2-pf: Defines common API for HW
 resources configuration
Message-ID: <ZtcjS5_acSWt5YGg@nanopsycho.orion>
References: <20240903124048.14235-1-gakula@marvell.com>
 <20240903124048.14235-2-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903124048.14235-2-gakula@marvell.com>

Tue, Sep 03, 2024 at 02:40:45PM CEST, gakula@marvell.com wrote:
>Defines new API "otx2_init_rsrc" and moves the HW blocks

s/Defines/Define/ (in subject of the patch as well)
s/moves/move/

Otherwise that patch looks ok.


>NIX/NPA resources configuration code under this API. So, that
>it can be used by the RVU representor driver that has similar
>resources of RVU NIC.
>
>Signed-off-by: Geetha sowjanya <gakula@marvell.com>

