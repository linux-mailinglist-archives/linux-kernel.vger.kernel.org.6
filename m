Return-Path: <linux-kernel+bounces-299268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9099095D22A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2AF1F2239E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BCB189539;
	Fri, 23 Aug 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqX6yoUw"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C034189508
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428546; cv=none; b=TVGTykdbNvJyKIh4m6OvLFO7FSvEQxnrI2QPGDhkbPvHAXf7Pywr2c+Ls5lJ8NjPSKm5tkVPPQwQxUNpxH8R9NdKBjcrofhxJAPt/BQ2joKKlmdD2MCqUfU68axga0F2P6YFQeC4lypfG0xd/VKTPnlnFfIOAzpV+A7CWpc35JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428546; c=relaxed/simple;
	bh=mu9H6lFg5kSLpcW0JJ1yi8A4QV1QzxP2BNLbW5zzpXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGcU4298/LWyX4dlrTZTfyxUZdDDR97Y4LLIpEayoXeisz2vJGzW1yFyyTHxgPTR9/B3lNpApkoTTcWgr5PqpXOLqhMw56o6rC/CgGRy14SCyFIXJqNimdH1eSpMpTd1A4w66OyZQOVDQ5EJrzMAhS53C0hMRpAL5NarKQvWmow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqX6yoUw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71446fefddfso626642b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724428544; x=1725033344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qER1aWY5bAgfL7d8/uethiPioGS2qLcpayOX/OKDd2M=;
        b=TqX6yoUw6QzXsmQKMlbBBx8FT5CnDnkMZCNc5qipBjt4cAll7K+8UgREJFRF1DZylU
         HEJj0uivVE8iav6B55POaAEeLFbnVOJjROwliwSNEyjG7hWa6JUeBqmBOz9maVPzmIHp
         tfKMcNwX3BnikjEEIA1kcfWIRI9Cl3Z/cVa5CUl8tXaez4BN5M0G3mqeh/xy1GVwjn9w
         IRgX3MEFxLjL2Y7A5rjxyl4XJK3wnRPhdG/lEDCjwzRdivNe6sVzHicjW4Gz04YZmiQj
         XBaSPhQR0bJjZ7Qfot0ObNNvdbFRjSTdgDVV2NYB5scmbare8kbSkpMswguPNC/XC8Fu
         AF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428544; x=1725033344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qER1aWY5bAgfL7d8/uethiPioGS2qLcpayOX/OKDd2M=;
        b=S0xAkR03AibjUc9+7NAE58JzAKhxKFyQiZTpdktrD5G/I5fF0WazRe2cghT13Xp2Nc
         CuMpfBwl7heE25YTGfz+Dvg97D0GgcHQjcuw1XNJnyu4arLEhQe2sNf+Ti2cwQjaVWMo
         phLGcj7cHIpJSLxzdeZ/mmoZKbZHrAqEPUoPWv5dJtOuNa+ijkczr64BCnCtZagrFVe2
         mbnVFVl1mG1t/2fnw8IV+zk/H/0AyDOewEmDUlTqSmWCx9pUFgmq3qn/Bub+EcmlOSrd
         60iHJdBHR9hgs6rFWYoRId1dj9SITVCBQ6IwhehABZ0hLzc2PeADgOkndFH9a2KUQBim
         cryQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTF1FnkQup39oKJ5BD8/PMF2Ns0TWqQXW2oU+6Vf9Iw7qFDIO0O1M/VDJ0953r1VfogFX6a5LBUfTVxgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeKdpBqsC1lu/T3Z8DORTyq7h0+TFqxF69utMieNkLp7lWFaf3
	gWHjkz+DRI3WUrxQNbpha+w1EVY2t4KqeIecLiTnKWx+z/3DxljT
X-Google-Smtp-Source: AGHT+IHx96bwumLbEVpMgdoa036N2YCuhms1Mq8ox5zeYxUZ0fB3HEtbDUD7hL3d00rM8UAjIA0YsQ==
X-Received: by 2002:a05:6a00:2e29:b0:70d:1b17:3c5e with SMTP id d2e1a72fcca58-71445758d3cmr2878752b3a.6.1724428544087;
        Fri, 23 Aug 2024 08:55:44 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:75c:5a5a:d7dc:18f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ebc6sm3204601b3a.38.2024.08.23.08.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:55:43 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:55:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2] driver core: Explicitly initialize struct member
 @data.have_async in __device_attach()
Message-ID: <Zsiw_cUgoXEcY7io@google.com>
References: <20240823-fix_have_async-v2-1-ed1039527365@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-fix_have_async-v2-1-ed1039527365@quicinc.com>

On Fri, Aug 23, 2024 at 08:00:14PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> __device_attach() relies on compiler to implicitly initialize struct
> member @data.have_async to avoid the member is used before initialization
> but readers may not understand that, solved by explicitly initializing
> @data.have_async as well as existing @data.want_async.

I do not believe this is needed. We require kernel developers be
familiar with the language of choice for the kernel.

We have a ton of partial or empty structure initializers in the kernel.
If we count only empty non-static ones I see:

dtor@dtor-ws:~/kernel/work $ git grep '= \?{ \?};' | grep -v static | wc -l
5707

Rough count of partial initializers is (might be over eager and some
of them could be full ones, on the other hand it does not count
initializers that span multiple lines and start with opening brace
only):

dtor@dtor-ws:~/kernel/work $ git grep '= \?{ \..* };' | grep -v static | wc -l
1150

Are you planning to go through all of them and add complete
initializers? And keep adjusting them when structures will get extended?
For what gain?

There was no readers confusion, you wrote a tool for C static analysis
that did not follow C standard and gave you a false warning. Please fix
your tool instead.

> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v2:
> - Remove both fix and stable tag
> - Correct both title and commit messages
> - Link to v1: https://lore.kernel.org/r/20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com
> ---
>  drivers/base/dd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9b745ba54de1..b0c44b0846aa 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1021,6 +1021,7 @@ static int __device_attach(struct device *dev, bool allow_async)
>  			.dev = dev,
>  			.check_async = allow_async,
>  			.want_async = false,
> +			.have_async = false,
>  		};
>  
>  		if (dev->parent)
> 
> ---
> base-commit: 87ee9981d1f86ee9b1623a46c7f9e4ac24461fe4
> change-id: 20240823-fix_have_async-3a135618d91b
> 
> Best regards,
> -- 
> Zijun Hu <quic_zijuhu@quicinc.com>
> 

Thanks.

-- 
Dmitry

