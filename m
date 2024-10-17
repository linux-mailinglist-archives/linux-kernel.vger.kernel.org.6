Return-Path: <linux-kernel+bounces-370457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5237D9A2CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE94B1F232B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D226219C86;
	Thu, 17 Oct 2024 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeVZttDc"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1BD20100C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191537; cv=none; b=aBfep2xxOMAcuApP5/XUpf4ArxflIBEtOvcSM6FjcwHNLiEY6Bmx1kTIphffmeMdMXr6Fp05Jwn79ytO4QakwYMlE/+77tc2l6hG50+qo2Lf5MU3jfIIV7Y73/tCij7dy6x16FVJ3nu7IOdnfMK68gpcYRJ4LAkesAjtNNo3TXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191537; c=relaxed/simple;
	bh=SNtE+TAjJ2JdWb/jlOvN0PEbD8g1WcfFzQ7DNQOC190=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qiv5w4Z2wI3P0SILgfD2oqvh99lxc5ZXA6MpjSoBu+abzjWmB2JQs+4Hd/x9IsnDyMMUDANoKB11G5Z1NPMA2AEM7hrE5HX0MlFXY99HAN7N/JX4wQaiU1avhEgCExbZmmK6vL7DAF64vZ7LEl7oGI38UdX42N7u4/imWDPKEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jeVZttDc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so1003282f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729191530; x=1729796330; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0jNM0fKmT2OwKByfCojWNdXKNxzOOYUDB2waNLdpO7Q=;
        b=jeVZttDcGNMaav9+aq8MTooYWFrpcTyXDzZyXU0UeYBWaXLBTlhZ48qVcG4b3u8iGX
         tNaVrmtb/uVFTvo2KfSjaGGTViHGjzN6sAFwkezCpWg7o1D8kLg09e+g5tJG1q1DaovM
         7E224UWP9fTVzNZcWdhczjMJ0vBtx9BI4pIMWx4ySb1oCWMMLQo3J90dXs7dbWUGeZZZ
         lR0MihyBQdN8Zg8Msjg6ne5LI3+E2CBi+xLcoueRY74h/QKh+bzv5lx8j8JAtixCBQ5u
         qUwc3MmTY8eKMcG5LpxdD0ZcucP0WYrDUYi25WwmstFhH5/CFhuiZgzdIan/ggcli82P
         a4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191530; x=1729796330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jNM0fKmT2OwKByfCojWNdXKNxzOOYUDB2waNLdpO7Q=;
        b=AmuIGDKJ446SyLStqTAGqrywwaEIt22s30PUKb+lQyErtba93qG2gbiSioGGAlkRuq
         jzHexNU4BQU8w6FlEXA2nRMe+wO3LZGbZ7hC8tyjmbLoBCdQwPMBCCUbSr3y7VxSK09g
         Q97BxtLa7W7oKf3vDMxghMoS49KcB9sJ9TZi+4pydKG7FVHI/aAQ7n+f/BYYNckKKxuw
         d5BiX9EUepg+lIIgKELb19xBY11dzB2o1f+W5L+OZ+R+H5UWKskCboEILS4r7Zj6DC8J
         XU9ZIFQ7+eOS9QnpasL7E4RhfLi0Tui902qpyaoQwc+qqxDerjtgdF8x5/WhAp59sAhB
         ztaw==
X-Forwarded-Encrypted: i=1; AJvYcCXDQjqWloRqOdC3US4aGirRwc8hq8c132zT07yW8g5g5gr+MzMv92aqRFGI/AbVFOJ5qQxHOOND8yKK/a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy43tHydLpH6KV0g9HKuIH2+T1SvPeK1yG0rUTlKPkEF//ZhxvA
	TXovXaW09HPWWGPOrEedEOz361n+vXL+w9c+DKf5zPeUp+MAja9rVUC3bID4aiI=
X-Google-Smtp-Source: AGHT+IF9kUUjfTLr6yM602q+fe8hCO6wIbB+sJWSe0YZkcfYdPlioijykg/CoyWhRs0AzdbysOwD0g==
X-Received: by 2002:a5d:5192:0:b0:37d:5496:290c with SMTP id ffacd0b85a97d-37d86bb6740mr5003470f8f.7.1729191529891;
        Thu, 17 Oct 2024 11:58:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4d6586sm3037384a12.7.2024.10.17.11.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 11:58:49 -0700 (PDT)
Date: Thu, 17 Oct 2024 21:58:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: Shuah Khan <skhan@linuxfoundation.org>, dpenkler@gmail.com,
	gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: other staging/gpib bugs completed
Message-ID: <c5cdbc20-5d45-4054-99fc-062608168e1a@stanley.mountain>
References: <912561b9-e446-42e8-8922-9e8952355c79@stanley.mountain>
 <CAEO-vhF0NWB4J+WFu_c7Nn9tu_kYzAvNeFgLrLKc_Lk5DD51hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEO-vhF0NWB4J+WFu_c7Nn9tu_kYzAvNeFgLrLKc_Lk5DD51hQ@mail.gmail.com>

On Thu, Oct 17, 2024 at 03:29:21AM -0600, Everest K.C. wrote:
> On Wed, Oct 16, 2024 at 8:20 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > Keep up the good work, Everest.  Here are some other bugs you could fix if you
> > want.
> Thank you for all your feedback and help. I am learning a lot :)
> I will look into these and try my best to fix them and send patches.

Feel free to ask questions if there are any warning messages you don't
understand.  :)

You also don't have to do fix any of these, of course.  But I didn't want you to
run out of bugs.

regards,
dan carpenter


