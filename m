Return-Path: <linux-kernel+bounces-198621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E06868D7B3A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4409F1F21A75
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DB323765;
	Mon,  3 Jun 2024 06:02:09 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA22182DA;
	Mon,  3 Jun 2024 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717394529; cv=none; b=otzap2WHVyXI44B5HZn26Qswbug5myPlGvoABhMY5HdgGsC9v0UGS1ECHdVo2tn4tOBukjlVhd4SlS7xIQosKxeb7DauL7H7UktGfRCshal2cD1Gq8X1wKKdwselt+Ye55OXWj9zTfvt2pYOXstQgOtunmeiUVH33XX+bYT51hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717394529; c=relaxed/simple;
	bh=PEAmHbpOHPfMuZlCU0nyxthw2AStx1/xTylZxwzdzQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkLCMJCiW/ZmZfPBKsijpbIGKu/wRcZdJ5NZWlvo+Y0sdnOxyPFWkyAcSP/WQaLhJ87oOlE3/jL5CHmwNWh+fkwTeqxTFFLT+DbNLEPp875RlSk4FA+CBKW0T2TuJjhZeSv8xi+bGjg+IFAlP9Yu/6yY4iitdU1IcMSpJbN4/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e73359b979so36030101fa.1;
        Sun, 02 Jun 2024 23:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717394525; x=1717999325;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NCsNeE14+9JLhxr6HvIVPI5xFevp5Z9uFKhwhyxPvA=;
        b=R4h9tD4uXQ7s4ZmPoCPhEq3e4mPDKAwucgSxJW1gml8r0IPbyKMeMQj0wh5L2PkYY5
         Mzpno4xgQf5h8Psyr2OVm9qaL96wnI29M/8FM1IoJufPhtpujSktvu/a76A9H583l4Gq
         bh7GrTEZDWQGnTVTOjdZV588iuCF62o2VuMubVgrT3FCMeES5zer+b0YatyL+6sHq9R7
         v7wYwZAH1OEl7ch8CmWTO7VRSV2s9dAhZ8pPBflArPCFdzPbYApcBXwaW6FZFqsaktLG
         FNfy+ek10/fwQ1BxWTgyaW+kDbXe6AoA+6Oq2c5+EAyufqB7DBIMdBkJ8wJHNq9pJ1Q4
         01Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUDB55od9K901R/0dUVOKq2I2s7rNujOH56bz3lh08TCQMH76u8DWMxIOg8nCnMMKWzErGbAuxX6WSQbMY1FeQ9Sxo7vL1l7xGqrOQzCPL1f6OT+WhaNLxG7aG/M/4elu+3IBkXRT1FWrU=
X-Gm-Message-State: AOJu0Yx9tEOjKs/VC2YAGnxWk1HU73thD/mXTBJpGr6yYwTw3wu3m2ib
	rFTInwXeKJapKUTCKKpo4w5MRLX4T6U+iSiAHtlohIKUvLOTN/Bz
X-Google-Smtp-Source: AGHT+IFVbn+o5Tp+hjxFoNv5STgCojkMUkna79HmwgJWaxVIj7ojCem34kiP+Lmn7bgotRHGeCkkyg==
X-Received: by 2002:a05:6512:15a:b0:51f:5d0a:d71a with SMTP id 2adb3069b0e04-52b895580b8mr4550885e87.10.1717394525164;
        Sun, 02 Jun 2024 23:02:05 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68cca704cfsm248835766b.169.2024.06.02.23.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 23:02:04 -0700 (PDT)
Message-ID: <e0492052-46ff-40e4-96e0-aecb88b68f0f@kernel.org>
Date: Mon, 3 Jun 2024 08:02:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] alpha: drop pre-EV56 support
To: Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Marc Zyngier <maz@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <20240503081125.67990-1-arnd@kernel.org>
 <20240503081125.67990-15-arnd@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240503081125.67990-15-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Cc Greg for awareness too.

On 03. 05. 24, 10:11, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All EV4 machines are already gone, and the remaining EV5 based machines
> all support the slightly more modern EV56 generation as well.
> Debian only supports EV56 and later.
> 
> Drop both of these and build kernels optimized for EV56 and higher
> when the "generic" options is selected, tuning for an out-of-order
> EV6 pipeline, same as Debian userspace.
> 
> Since this was the only supported architecture without 8-bit and
> 16-bit stores, common kernel code no longer has to worry about
> aligning struct members, and existing workarounds from the block
> and tty layers can be removed.

Yes!

For TTY pieces below:
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 2b2e6f0a54d6..2372f9357240 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -145,15 +145,12 @@ struct tty_operations;
>    * @count: count of open processes, reaching zero cancels all the work for
>    *	   this tty and drops a @kref too (but does not free this tty)
>    * @winsize: size of the terminal "window" (cf. @winsize_mutex)
> - * @flow: flow settings grouped together, see also @flow.unused
> + * @flow: flow settings grouped together
>    * @flow.lock: lock for @flow members
>    * @flow.stopped: tty stopped/started by stop_tty()/start_tty()
>    * @flow.tco_stopped: tty stopped/started by %TCOOFF/%TCOON ioctls (it has
>    *		      precedence over @flow.stopped)
> - * @flow.unused: alignment for Alpha, so that no members other than @flow.* are
> - *		 modified by the same 64b word store. The @flow's __aligned is
> - *		 there for the very same reason.
> - * @ctrl: control settings grouped together, see also @ctrl.unused
> + * @ctrl: control settings grouped together
>    * @ctrl.lock: lock for @ctrl members
>    * @ctrl.pgrp: process group of this tty (setpgrp(2))
>    * @ctrl.session: session of this tty (setsid(2)). Writes are protected by both
> @@ -161,7 +158,6 @@ struct tty_operations;
>    *		  them.
>    * @ctrl.pktstatus: packet mode status (bitwise OR of %TIOCPKT_ constants)
>    * @ctrl.packet: packet mode enabled
> - * @ctrl.unused: alignment for Alpha, see @flow.unused for explanation
>    * @hw_stopped: not controlled by the tty layer, under @driver's control for CTS
>    *		handling
>    * @receive_room: bytes permitted to feed to @ldisc without any being lost
> @@ -216,8 +212,7 @@ struct tty_struct {
>   		spinlock_t lock;
>   		bool stopped;
>   		bool tco_stopped;
> -		unsigned long unused[0];
> -	} __aligned(sizeof(unsigned long)) flow;
> +	} flow;
>   
>   	struct {
>   		struct pid *pgrp;
> @@ -225,8 +220,7 @@ struct tty_struct {
>   		spinlock_t lock;
>   		unsigned char pktstatus;
>   		bool packet;
> -		unsigned long unused[0];
> -	} __aligned(sizeof(unsigned long)) ctrl;
> +	} ctrl;
>   
>   	bool hw_stopped;
>   	bool closing;

-- 
js
suse labs


