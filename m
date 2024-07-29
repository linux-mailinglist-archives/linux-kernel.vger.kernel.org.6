Return-Path: <linux-kernel+bounces-264978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B76B793EAC9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE3A1C20EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAE53A1BF;
	Mon, 29 Jul 2024 01:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvGT6/50"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9346BF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218004; cv=none; b=Y3f18i6jrpnhQVRQXhDhobELgIRteoahrrS/LVr0QCg77h80WMHv6zZHOSNJckkckJl7elSo5k+zMz2xHgE3/D1RjU7VPJvdokzMvc7V78i14a0ryHLpmv6RmR1fhUsyZsUJFzOjlFdeJWUQIK4CP7pZTFT+pS31i8o34Mq8i14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218004; c=relaxed/simple;
	bh=hi1EN0X37kob/v/A6DmhKZTPV2Kq3jfSjZCfuRoc7t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unhYDmceAh9Xdf8Wi7Y0X1F/wYqMzMHUO1nKB8VK9gloKoJClEPwOqgOU0a5B8GHcxW8vA2WDB0kQ2oCVOzjNbCRaD2tjcXPNgM9DPHmBvL/DiJBjB4eGssnXa+7KJCzeuZLmVjroV57941dC8upZt5w8d9VHuySk/iT4E78QIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvGT6/50; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5af51684d52so2563282a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722218001; x=1722822801; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2n9buprHoC7QHFoZKWAK4xrI6ZiU6TB0vpdxJIhazlY=;
        b=bvGT6/50QwqU7h9WQF06nFezpMWjldwMzpNHvM8avQCq9g5gr/wjBXtXYTuPGJnzvv
         Xm7VKCuoPKpeIhBSJR7RyK/uEfmp8cIXMOzaFOW/F1pZIcj5s4j2l3HmuW9LytNlCYT2
         rE/Ub6NrvwYYxZTP5NAKtQAEJ/BczqQmXlo1KpIf6Xonh94J+Sq8gh4yDbUCkXv564jX
         DzpNh9dDlldy5i6Bzh0CYl55RFGeA2a5VuvXdI6qmAq5CXYCIcjDbTHFLdnI3m5P+3uH
         vYfKaWezllvdzjGC6ER8NA28pmzDGlSoD/hose0MzplwjmdrVWWGXoynFtZaloLDLHmn
         D8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722218001; x=1722822801;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2n9buprHoC7QHFoZKWAK4xrI6ZiU6TB0vpdxJIhazlY=;
        b=bTswmLaUn5EXXcuRbgyRfBHFBWLv582aDhnG60fTMxFpheWKeA55cS/asD/hH02EDH
         jvCQO89vqORb3ynK841nh0f2p/PkhFdqfMEoNwQ+8u5+aaTmMAVpGn3muZlSVPCcPQzW
         506oFYz44EuTx7c3KuaCMzZUpd5mRuv2F7NXWmE0djjbxaeNzfMl8x/DV8e8XzPC2ST4
         ex6jWlwpOTSywTZqkViXes6/sFCoIUCE3GWJFvFp0yY6MKdTzq7L7eHYTvzerbhb7J06
         tXmkp0kaYmDnEg0+g3TcMQOSjmxZeMzwqCt76rDl5eaPL4qhX+6VZFDeJkGz4Np78d0I
         8Ymw==
X-Forwarded-Encrypted: i=1; AJvYcCUgcsVS7Opc3cqZfdlXJjmCYYPIUpjT62KnSbryi/wuxo+1cMAMfCFSYku8iJ0iEsbBrBo1NZSkS217gnH2WkhTlNwghT6zT2N95qon
X-Gm-Message-State: AOJu0YyXCqPLPj7yWHEoUf/+Ai4Lt3Tfo/fms+2gbJh3lXaO5RCiiP7q
	W7GbT4aUosBkhuYffMD5nDQFpnvyDgoDJglkw6sbVJ1yQIBV2wK/Rxdhfw==
X-Google-Smtp-Source: AGHT+IF/zwMx1mqXoDUrzjboRV4MQE2Mp84/SVZQypiJjlH+qVjxhT9K9qjkRwG/L2Xd4dQWON6H2g==
X-Received: by 2002:a50:8e03:0:b0:5a2:94ef:5573 with SMTP id 4fb4d7f45d1cf-5b0226bac5cmr3142953a12.37.1722218001505;
        Sun, 28 Jul 2024 18:53:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6377d005sm5023158a12.38.2024.07.28.18.53.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Jul 2024 18:53:21 -0700 (PDT)
Date: Mon, 29 Jul 2024 01:53:20 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] radix tree test suite: include kconfig.h with
 incomplete path
Message-ID: <20240729015320.p6ef54kdcgnrgkyh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240712074151.27009-1-richard.weiyang@gmail.com>
 <20240716021543.ghzeiq5yqtov43lk@master>
 <ZpXbalVnI9FzHMHx@casper.infradead.org>
 <20240716075609.rlw523szys2jztpy@master>
 <xhshclihkl6d6bbh2f67yuo6qalwekc3qgf4hzvcibri74rh2q@a5qnddnskdm3>
 <20240717003432.xbb3zs3iednce6vf@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717003432.xbb3zs3iednce6vf@master>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Jul 17, 2024 at 12:34:32AM +0000, Wei Yang wrote:
>On Tue, Jul 16, 2024 at 11:54:47AM -0400, Liam R. Howlett wrote:
>>* Wei Yang <richard.weiyang@gmail.com> [240716 03:56]:
>>> On Tue, Jul 16, 2024 at 03:31:06AM +0100, Matthew Wilcox wrote:
>>> >On Tue, Jul 16, 2024 at 02:15:43AM +0000, Wei Yang wrote:
>>> >> If you think my understanding is correct, I would send a v2 with proper
>>> >> changelog to describe it.
>>> >
>>> >It seems like you're trying to change something that isn't broken.
>>> 
>>> Currently we don't find the problem because these two kconfig.h is similar.
>>> The only difference is the one in tools/ doesn't include "generated/autoconf.h".
>>
>>We need that include.
>>
>
>I see your point, but I find current code has a chance not does do this.
>
>>> 
>>> And in related files, like include/linux/xarray.h, includes the correct
>>> kconfig.h.
>>> 
>>> It is not broken, but doesn't mean it is correct, IMO.
>>
>>This is really annoying because it works today and your change was
>>correct enough to look right, but it doesn't include the
>>generated/autoconf.h  - so it's not right.  It took a lot of time to
>>figure out that it isn't right.
>>
>
>I am not sure you have read my second mail.
>
>Here is what I find.
>
>I add a warning in tools/include/linux/kconfig.h.
>
>diff --git a/tools/include/linux/kconfig.h b/tools/include/linux/kconfig.h
>index 13b86bd3b746..12d3ed5f16b2 100644
>--- a/tools/include/linux/kconfig.h
>+++ b/tools/include/linux/kconfig.h
>@@ -2,6 +2,8 @@
> #ifndef _TOOLS_LINUX_KCONFIG_H
> #define _TOOLS_LINUX_KCONFIG_H
> 
>+#warning include local kconfig.h
>+
>
>Then I run the command:
>
>$make maple.o
>cc -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o maple.o maple.c
>In file included from ./linux/kernel.h:14,
>                 from ../../include/linux/list.h:7,
>                 from ./linux/../../../../include/linux/radix-tree.h:13,
>                 from ./linux/radix-tree.h:5,
>                 from test.h:4,
>                 from maple.c:11:
>./linux/../../../include/linux/kconfig.h:5:2: warning: #warning include local kconfig.h [-Wcpp]
>    5 | #warning include local kconfig.h
>      |  ^~~~~~~
>
>This means current code may include tools/include/linux/kconfig.h, which doesn't
>include generated/autoconf.h.
>

Liam,

Do you think what I found is real?

Look forward your insight.

>After I change to <linux/kconfig.h> in kernel.h, the warning message is gone.
>
>Current behavior is not what you expected, right? We have a chance to include
>the kconfig.h which doesn't include generated/autoconf.h. 
>
>Hope not waste your time.
>
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me

