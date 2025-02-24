Return-Path: <linux-kernel+bounces-529113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EF1A41FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002131894ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D7A23BCEE;
	Mon, 24 Feb 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lCe63Zwr"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437B2571CF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402229; cv=none; b=qwvqosqa/uQZBKVO9ItNtHQ3jRy37qfhSfVtvli3HOzpRI2LBrB3AwIsOtkfCb2lmYbQeEHD4Phzg8VWH1sun+G0k9EeMGJ3bj4q7z2j/SCABLM48Nn8EShrrxJGbTbCm4HQwuE7YBBArchgtvnC7/nDYtyKle29nZFVyZfOiYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402229; c=relaxed/simple;
	bh=qlFqtV1owUvfI5AF9z1lusywS8vD/gGpoFaBVAsQwjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hH5+tSgYeqFMYkey+e9EL2xPKSYqYvi/9Xo8ZoG8cHT0CEq4S0NdKj3u9RQKKgeMQ9YCP4Zxw9wQUOlt5pcQ10RCbkUdn+RunR0iVoXjsqsHnmBlAvmO26+kryAtJhfXvNNjzuZyOWPzXX+oqPNcY3dCHlrOoRZixFuAwtEaEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lCe63Zwr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so38352945e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740402225; x=1741007025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QeA0rVRWP3AOYIIlnfHopPlLG74GJ9BReqcR5DIAZMo=;
        b=lCe63Zwrz6I4iwHN0fQy5Jg70u+ubZS/91e/91TI724GLz/pTpeSSDnLon2lzj8f57
         SA93dgePOU2hs6B6c15MOIzLk8VmF0Hh8A9jNfn36A3CTcDIzyzLmi+r1judXyiC5Ty5
         m42295Zd1Z+ngWFiKR3rqMLpk8I7cL3HdJV9MrnI0r/wgQ3NZ0reqBUD28IcxgYMK+IY
         4a3UQuKgZcyDQv/O/7YapZJWu4UlcUfdbdphRUkF9NjKeMS27OxijOPksh6NjszRbr6b
         cTiZ1pVxSFo6Oj7NnDJCgENZ3uTPQlnC93vaFlwmURSaF4NKAVYUBTmaCgfScFwkNrva
         RGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402225; x=1741007025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeA0rVRWP3AOYIIlnfHopPlLG74GJ9BReqcR5DIAZMo=;
        b=Pestx+nYjcU+IhU5BGvZ+XTr06uxy47P+bpyrd56Q1B5H7bLaLgQsBayG8KhML4eLh
         IGB31jSyZb2nIjvo4I+O9vLAI1BRRQ7XO7Q94EE1LOsFq5vBhMB27M6GYEhe/zoL4WhZ
         m3HDUlab28/EQr1G+tFrWguwEq2inUjoeWVjyH8d6lV95wZQ8DOS5ki4sj1LlUDkvAd3
         Db+AyquOk5qrVLr/lneaWhVg3xy7gu7pgJ1VKExEm/WHWNdqmzPfdJyEMvyz6q1UpSZm
         EymSM1B9alqyQfHubol3mTyjGgSz/hUS7K1pJkvnCrcy/BrXDswx3JIS/ZuM+oo4Pz6s
         7B2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqhWvhR5VF0dE0UWFu2CrBJ50Y4QDL/RXO/UZUea1WXvGlYZNxmw3nRkcaz6ECGjqRWOySaqDjbyVVbys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuBYrZ7ODWOP5/Cb+cJM8MEwh8A91mDgZGeYvWtaXRuNe6ebKh
	ipk5PyRCb1e+6QtiCruKoshDehfK5+lddcAfkvk/kZEwBbE6aq4uruHAuQumKxg=
X-Gm-Gg: ASbGncvXx/cYI9PVJ0rgivj1Xo4HSBVZurYu6mCCvG0+iQHvCeTwW6wHZDXmKrNQ8K2
	vUiYsu6wrxC0UZPLnHfgbg5YiwannAaIkjTIkAaenfAK7f+pe7IBAdcA4sxO0PG8KTGBHxl7R32
	sqLEC9OEsWFlcT9HyZIHLmJiBTFjC90xYRRk22Ud4zctB+MhcwAZEG6705Pk9+MBkZkxIUY2+CI
	sjBjrFcK7nw+vLonCpfrIWgZhZs9LFcWbhjsbvJjQfG4VPhT6ERTuV/vLAVuc9gA+g3WbJ++pZE
	6tQmgmPUgweIS2ENxEbT8G1+MMX9C9tCi3hyK30o62pHlgB4cP8s
X-Google-Smtp-Source: AGHT+IGyB/Rgw0TqA7SsSI5QTcM2agQmllOnJHqgIfcTjpAlHrZGdn38+03L9In2Tf+ef6DQcvVmpA==
X-Received: by 2002:a05:600c:1552:b0:439:8185:4ad4 with SMTP id 5b1f17b1804b1-439ae22124emr98618985e9.27.1740402224568;
        Mon, 24 Feb 2025 05:03:44 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([208.127.45.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399c4df982sm135831435e9.1.2025.02.24.05.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:03:43 -0800 (PST)
Date: Mon, 24 Feb 2025 14:03:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org, 
	Konrad Knitter <konrad.knitter@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	linux-kernel@vger.kernel.org, ITP Upstream <nxne.cnse.osdt.itp.upstreaming@intel.com>, 
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [RFC net-next v2 1/2] devlink: add whole device devlink instance
Message-ID: <wf5ugq4h4lv2uic3622xurjbfwf534gj2jx6jbhaxoncingb3z@ceo4xkikjbdn>
References: <20250219164410.35665-1-przemyslaw.kitszel@intel.com>
 <20250219164410.35665-2-przemyslaw.kitszel@intel.com>
 <20250220174512.578eebe8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220174512.578eebe8@kernel.org>

Fri, Feb 21, 2025 at 02:45:12AM +0100, kuba@kernel.org wrote:
>On Wed, 19 Feb 2025 17:32:54 +0100 Przemek Kitszel wrote:
>> Add a support for whole device devlink instance. Intented as a entity
>> over all PF devices on given physical device.
>> 
>> In case of ice driver we have multiple PF devices (with their devlink
>> dev representation), that have separate drivers loaded. However those
>> still do share lots of resources due to being the on same HW. Examples
>> include PTP clock and RSS LUT. Historically such stuff was assigned to
>> PF0, but that was both not clear and not working well. Now such stuff
>> is moved to be covered into struct ice_adapter, there is just one instance
>> of such per HW.
>> 
>> This patch adds a devlink instance that corresponds to that ice_adapter,
>> to allow arbitrage over resources (as RSS LUT) via it (further in the
>> series (RFC NOTE: stripped out so far)).
>> 
>> Thanks to Wojciech Drewek for very nice naming of the devlink instance:
>> PF0:		pci/0000:00:18.0
>> whole-dev:	pci/0000:00:18
>> But I made this a param for now (driver is free to pass just "whole-dev").
>
>Which only works nicely if you're talking about functions not full
>separate links :) When I was thinking about it a while back my
>intuition was that we should have a single instance, just accessible
>under multiple names. But I'm not married to that direction if there
>are problems with it.

I kind of agree. Like multiple channels to one entity, each labeled by a
different name (handle in devlink case).

>
>> $ devlink dev # (Interesting part of output only)
>> pci/0000:af:00:
>>   nested_devlink:
>>     pci/0000:af:00.0
>>     pci/0000:af:00.1
>>     pci/0000:af:00.2
>>     pci/0000:af:00.3
>>     pci/0000:af:00.4
>>     pci/0000:af:00.5
>>     pci/0000:af:00.6
>>     pci/0000:af:00.7
>
>Could you go into more details on what stays on the "nested" instances
>and what moves to the "whole-dev"? Jiri recently pointed out to y'all
>cases where stuff that should be a port attribute was an instance
>attribute.

