Return-Path: <linux-kernel+bounces-253826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAD4932787
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2431C20C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F070A19AD80;
	Tue, 16 Jul 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="J4bYUr+1"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054919AD61
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136656; cv=none; b=W55a7uXJM6JQiD5ucbNmHJZOVfxVvBpBC5TIs4cy3GxAqIJZldI1CzZIIVhGIrQd+K3IFPaZxIkA1MUR5X6+Wu5LbRdUwSjbOz8nqjXSpKfNqL3OwI9y1aWh5MeS34/5YPwIeX12d9tv8mm9WrHpvw/xJ/9CuQOoNmXkqNzx67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136656; c=relaxed/simple;
	bh=/crOubLp6udsD5zhjxldO7SEGmeDTBHhP0I0MWVD0zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1yGTe0JB+VXTBc4UCAxmsN4VaIC41B9ekciI950/IE2pJBry5g6mu3N/qFHKkAn8Bu91cTM6DGTWfSyZUloMc5D2B5DN5JAxDPTtT90lOcHLSTzZtXM+ArQ9xEcWHIXrs245IY4Gb3t9RVyfAL688C+tTZ5pcv6mUHVwJVOBC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=J4bYUr+1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-427b4c621b9so11800105e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721136653; x=1721741453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YcLBf72AGLqz53r/avJkjakt+ekctAYLnsPdlsvC3fU=;
        b=J4bYUr+1BxhyHy0eNkp45q7NPqrSR7+vN5BVLQaELtLwzjqCJOHff3CirIQthb9tH2
         kZufv242PKtOKWEQJkK/X3RA3lBtNiL+izW3frsueQF5nFif7pPlNmuncIKTnsIXWZ20
         aYObeQg48aTVZT/P8xdVNP1kJlfTM/vXbVuMhRf75IscZ56FjEZQkghDm8ORRcwfiCd/
         MoPYgtGYOCmI2Ezh4z0gzKjWr+rvEgsjxGIkdBGGkp1rrTiccDrpB5uQRNkGgn0ZSPXF
         /iuR4ihzvvFGw1BkmaKT4ROYpWAvLua9c2ZdwPDc/+YK5ULRNXjKjSiU8fCmYukJl7xB
         UPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136653; x=1721741453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcLBf72AGLqz53r/avJkjakt+ekctAYLnsPdlsvC3fU=;
        b=X6tUULmLNhGZx+DTgPfEZ37ZUObtDs2Rtal/uPTTuTR/8X7VTHyXwwQgOkkcWpvhYi
         xp06GLRTd2en3G/0UJOpJaZqQKoxD4iH0w/fg1rOsXHNmlQDnZZ6/W8IwiQp/WRhPUns
         V10rOtvCBx9DCNBKBZnuK/fZPsYszW/IRnG4pp2c0Lud1G3eWZRNxIUSMVRHv0ysHjVC
         iPyKzeBnwTuQyFP+f7m53ohktpsea44J3lwhqeC+uqPWB1hFhQwBR88DVbPInTSBGJly
         OsBW110NqzgAAjznZDHHELRYq3otyO5LUhfB/t/NLfc2NfbK+i7I9Xdhl0f2ffCqUqfC
         dueg==
X-Forwarded-Encrypted: i=1; AJvYcCVsEpA+InRWw/qSonqRuKjymJUUD/gpT7xGi5bLRJMJi/A9srgYhbLAtVp+/hfX42ElCv79rgrKVmeqD8p2r4mscssySDLEr2ujF4YM
X-Gm-Message-State: AOJu0Yznj+rBBFlXEWsKmqRVxNe0XkLStgOH6f+3AQX63BC6dGjlxqES
	MUCbFtzMnmnsOWhccq+cnfBp/3aiAPHryuixI9NxwX0JtrQfN8rl2k012tc8Y1HaE+aixtuN4lI
	jW0I=
X-Google-Smtp-Source: AGHT+IFKdR1AsGx4POLKWxsTeU6zlw8fAns+4xpz4w4ZoyIBkhXGrK+6JHZOeNFPpEg5EVVeMjtCnQ==
X-Received: by 2002:a05:600c:524f:b0:426:5269:9838 with SMTP id 5b1f17b1804b1-427ba654c24mr15602675e9.4.1721136652680;
        Tue, 16 Jul 2024 06:30:52 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f23981fsm164204555e9.4.2024.07.16.06.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:30:52 -0700 (PDT)
Date: Tue, 16 Jul 2024 15:30:48 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Chen Ni <nichen@iscas.ac.cn>, roopa@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bridge: remove unnecessary cast from netdev_priv()
Message-ID: <ZpZ2CA5h8hsCu4Id@nanopsycho.orion>
References: <20240715024457.3743560-1-nichen@iscas.ac.cn>
 <7476d4f9-3a45-4586-99c5-9e878d4e02ac@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7476d4f9-3a45-4586-99c5-9e878d4e02ac@blackwall.org>

Mon, Jul 15, 2024 at 10:04:26AM CEST, razor@blackwall.org wrote:
>On 15/07/2024 05:44, Chen Ni wrote:
>> Remove unnecessary cast of void * returned by netdev_priv().
>> 
>> Fixes: 928990631327 ("net: bridge: add notifications for the bridge dev on vlan change")
>> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
>> ---
>>  net/bridge/br_netlink.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
>This is not a fix, the code isn't broken and it doesn't violate
>anything.

Yeah, it's cosmetics, send it to net-next without "Fixes" tag.

>
>Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
>
>

