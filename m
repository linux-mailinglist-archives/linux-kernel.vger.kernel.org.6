Return-Path: <linux-kernel+bounces-193413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 972428D2B86
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1CF1F23548
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 03:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F8E15B12D;
	Wed, 29 May 2024 03:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFeS94uX"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72453273DC
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716953736; cv=none; b=KF7MFFH4go6i+Ny9WIkDWRCWTm8pOrNUg+hqpa2Va643N4xCCR7t+nhKQ6TPyHboOWv+WxuwJZJFeL/K61GEck6PVYLw5C28L/zEAyIwLkfp4WDX7xB5/xO44bu+2lE2ZaDCPydk6oE8LdHz27Twa0TKDEFYYZEuZRogO5Duy0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716953736; c=relaxed/simple;
	bh=S4mxqrubtaGOq4O26C1qf8r1Ub+kzSVpFmXbeQjRhjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2r1fmY3Ew/07BTUL28ptubO/7TWvuwED/BKNBVYbMLaVKy1ObLhe9zzP68Ptf5WzV19EHgDMRyPyd+YT8JYHGizREFGKOBuAs8E39BnNl8kLmJwEa+nnVlP7KoHyJNNcu80M20wKXwl7Nk8cU5sdaqt7cyBuALprZhn0wKUoDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFeS94uX; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-24e64ca31dfso663829fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716953734; x=1717558534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcGgl0SXVpIqyoxoh79lT3Pq6551Z8JXvrLPNT45iLU=;
        b=WFeS94uXDg8xbEWUn+Rce1nVGr7hD+U5GMANpeGJxUjTuTOGpmN+ByM1mDo6FGlA18
         jywALmYcZN4RF4KIEnoNruY9Pu18EmC5zkYY2NBybOr7Mv3oJsZxFfJ1v3z9Lj5JHAf5
         J+T7UwIxdiw6kj9zXrr7c1wvhMdu/wpmqHZnqgMLrV+spbgGRbIrLtb3esmSqax2P+ZU
         4OuoArAE9X4Cmqx8p6UrJxc/WM8JV+ir1dUIOOi3LiVZgenNrFsi2wM3QiRVktGTftau
         rt+92iKxMhdaGHu243MvuOQ3XUBDd5xaURZQGwRkeh4LOZPFaM/9ar+k2/VsgVYX+MnF
         bJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716953734; x=1717558534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcGgl0SXVpIqyoxoh79lT3Pq6551Z8JXvrLPNT45iLU=;
        b=f62MXyQMB4vxvE0cwrVT+iTgSazmckSQflXPpjOYjhHWrBcKkLXpZni3DwsIftZWdi
         9PlmqLZ6WfHNkQRZn7XPaeGvja3LUhXG+fI/xQxGzzPNqQIPByaAx0CCeGi0FmMJn4Mr
         zxO6UN3g86UJUdf453DdkaQWgbFdWr+7v32Bv+9gbOKelBYX4QnUos63GzCMxrXelc4S
         ib6wbYgqcKvV1IgKyPYm2Eldi0LjI5RLY0fctygiWMdjqQZILRFFkswrAitLsrygKEbG
         3AhxfX+xcM2VE/qORLFp7mZfzHiY57FPF9LvCiRiYwbElpH+tC8lWg4f7TelSAxcTAao
         NvBQ==
X-Gm-Message-State: AOJu0YzWMJZxYog2pWpG9nU8emMo685xALga8tv5TLzBaI5TO/pRRBob
	TGrRHp+snT6WGLYfZ21YTuENX0vXTX0JCUEht/+gR7U1DBJ6umYS
X-Google-Smtp-Source: AGHT+IEMeEsXE9j72q9zDbE3gsRd/yUDcgLUVY8IEbz/CCazBQTHtpAxSbadTKCJoWH4iqmrS4BVfA==
X-Received: by 2002:a05:6870:d608:b0:24f:cddc:ccfe with SMTP id 586e51a60fabf-24fcddcdee4mr11298769fac.0.1716953734345;
        Tue, 28 May 2024 20:35:34 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-24fe0a85880sm2040128fac.4.2024.05.28.20.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 20:35:33 -0700 (PDT)
Message-ID: <f480f2a4-2958-4b08-ae32-ce307c3c63aa@gmail.com>
Date: Tue, 28 May 2024 22:35:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] driver core: shut down devices asynchronously
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Tanjore Suresh <tansuresh@google.com>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
 <20240516154920.221445-4-stuart.w.hayes@gmail.com>
 <20240528063109.GA29965@lst.de>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20240528063109.GA29965@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/28/2024 1:31 AM, Christoph Hellwig wrote:
> On Thu, May 16, 2024 at 10:49:19AM -0500, Stuart Hayes wrote:
>> Add /sys/kernel/async_shutdown to allow user control of this feature:
>>
>>    safe: shut down all devices synchronously, unless driver prefers async
>> 	shutdown (driver opt-in) (default)
>>    on:	shut down all devices asynchronously, unless disabled by the driver
>> 	(driver opt-out)
>>    off:	shut down all devices synchronously
> 
> The on option seems very odd.  IMHO safe is the only really sensible
> option, and maybe we have to support off as a bandaid due to userspace
> behavior dependent on synchronous shutdown, but I'd rather try even
> without that first.
> 

I added the option because of comments from Greg K-H on the v4 submission
of this patch--see

https://lore.kernel.org/lkml/2023102151-rejoicing-studio-6126@gregkh/T/#m5d0459480bc0fda4563040cab2036839bcbb79a8).

I thought it would be nice to have the option for testing, even if it gets
removed later, but I'll certainly remove it now if necessary.

