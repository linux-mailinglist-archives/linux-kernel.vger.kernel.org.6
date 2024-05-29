Return-Path: <linux-kernel+bounces-193469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582FD8D2CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33811F271F6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE6C15D5AB;
	Wed, 29 May 2024 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="xA1ZhFVx"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB5F16E866
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960993; cv=none; b=lX9EYBAJWz/C9TL4S+q+i16fPNUDGqXkBQLoU8xontrQ3IBX6vyJJiGCzgZdpwwpFLs42XIdu+EqQ6QcCcDJq7xD9z8dJpm5MDpXZ6IeEXUToP5tj1l3tbemG/tRy5wPcL3Fv6U+cJnke7+B2rBz4w7/I4WBd+3euKM69uqqfBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960993; c=relaxed/simple;
	bh=VUHfqIpMLEJ72GmREl9aWEN3lHURkr2tcN/5lyxXj3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6lMDbIOF51HvOdXKbMroCGBp6lrspJ4RvGBJvTjNSbwmlUdlE83UrWixHfVkAONI8gjk14AWcVB3YAd/1oK4VfyOKLuh/nyIW1Kn4Brsq7+sHK0fFW1rK5F1djKS+yVFFQOYADz8W2/g/hDlh/qSgaF7k6OILoD4GQbM0MWa+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=xA1ZhFVx; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48b9c1ba14aso198956137.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1716960989; x=1717565789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=59clAH+TNnE9vZy/uwPV+00ESbhoosRii3QZ8IXAsEg=;
        b=xA1ZhFVxXD3v2hKmQa0qmB7+F/fvTd3z8N4n9ikE6vuaWcLTXd8Cl3Yw/lYi6QhGyh
         o1s4Y2I5L2coCtbWVS/PhAfLIiK6Nw5mYp8ny/aRtplQsHA4p0H5YQ7rB0QU2DM6b3At
         5/3WlhizTtUq4bRwoBp4slpjw4JVKWPZy8YOGPSxM0Oif2AI150rZhh/Svt3+opyGYDo
         iyqq5IraWqhMEoj4zMdYLEhkHZI3CsA1eDfFxVVaLi25V4iBvGfkrQrfcUHFquxiDBid
         CsqEQTZQq9kiw0QFsGram2TW9CRmhnbTEiV5BtGHHjXt85KbLEqjU5Eo4ZCJiK3VjrKF
         tGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716960989; x=1717565789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59clAH+TNnE9vZy/uwPV+00ESbhoosRii3QZ8IXAsEg=;
        b=FFm/BpbY7DkDo/LRgIcMblsPJoSwbPdirXLFrkn7q2NuJBitoO9jlkXFovZ0zRtDAg
         Sh0O4Pw3avgYkVCEUZsrf+DmNnRXtelsOJ6cH8z0/OarZFp03hdHvP1sY6tkp9nbGaiK
         I1GY+ZjTkMcnOzQL0YkN4XolipT7c6Z/xLvOZTDU6PD2kVl6CD5VxL8bXIJzfXZB2P1B
         rvllEsqWyT4DfoPmBM2K60iI080aYuPA0GuGKsvQ17oVYxNR8fvRhaUvAUi66sJeVie/
         dDxHHohCC682o9+KkkyJqPUgGBZ95F0TWJzeovloxwpAKjd8VnASHJzRZgXSKOQsHLkW
         mzgQ==
X-Gm-Message-State: AOJu0Yx4kT1rZ3FRxhk0/J730wKT+q5Lfsh45BfE3gef9zdvz4o6nu/s
	D25ehrFfLa8keiavSfMnd1maJANYMNgTDUGFZ/YQnX84GnrooWw0pnx8x51r4fI=
X-Google-Smtp-Source: AGHT+IHi50YnmP4eqwBGVkxawc7m2GRD+0vuBM3Zf7HgW/Qb5VxPMg8AAhRusXsXfa+eQRRLQTyW1w==
X-Received: by 2002:a67:f65a:0:b0:48a:3f49:7ccd with SMTP id ada2fe7eead31-48a3f497d0bmr12405967137.15.1716960989540;
        Tue, 28 May 2024 22:36:29 -0700 (PDT)
Received: from [192.168.0.50] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb16b7a06sm50380661cf.8.2024.05.28.22.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 22:36:29 -0700 (PDT)
Message-ID: <d7412ef9-8e25-4f55-aac9-8ec479fb6775@draconx.ca>
Date: Wed, 29 May 2024 01:36:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: kbd busted in linux 6.10-rc1 (regression)
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Alexey Gladkov <legion@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <ad4e561c-1d49-4f25-882c-7a36c6b1b5c0@draconx.ca>
 <20240529052543.GL2118490@ZenIV>
From: Nick Bowler <nbowler@draconx.ca>
In-Reply-To: <20240529052543.GL2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-29 01:25, Al Viro wrote:
> On Wed, May 29, 2024 at 12:45:56AM -0400, Nick Bowler quoted:
> 
>>        All other headers use _IOC() macros to describe ioctls for a long time
>>        now. This header is stuck in the last century.
>>    
>>        Simply use the _IO() macro. No other changes.
> 
> ... are needed, since _IO() is arch-dependent; this is quite enough to fuck
> alpha and sparc over.  _IO(x,y) is (1<<29) + 256*x + y there; both ports
> got started with compat userland support, so _IO...() family there is
> modelled after OSF/1 and Solaris resp.
>
> kbd ioctls predate all of that.
> 
> Please, revert 8c467f330059 - commit in question breaks userland on alpha
> and on sparc for no reason whatsoever.  Might be worth adding a comment
> to those definitions at some point, but that can go on top of revert.

FWIW I see exactly the same problem with 6.10-rc1 on powerpc too.

> Folks, 0xXYZW is *not* an uncool way to spell _IO(0xXY,0xZW) - if there's
> any chance that those definitions are seen on all architectures, they
> should be left alone.

Thanks,
  Nick

