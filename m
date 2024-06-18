Return-Path: <linux-kernel+bounces-219105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9346C90C9F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BB61C220E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FA915887C;
	Tue, 18 Jun 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ScEvaDqv"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28471586F7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708730; cv=none; b=Oj0pw52AnMmiTqI/Xw1+tk7Iqvd85J4BjvX/fBJO8M2n3ZuP9ez4du89YDd092U7ogvVJ8X/Vq2eqeCj99aHDlSbbAjsRUGhofZ4Cl7CbwPj/5wBl3L5sMEASzf93hlGGYR7xzrC0t4Nh3XLXHxxEjdv500F45ZwhF9JHScCsD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708730; c=relaxed/simple;
	bh=qQYAU6pzROoBuuHRkqrRKpetO1lSkUzkb0VMCTaossc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSwPX2FU+pZyLpk83JrlPUCi0kuh5KSrv6qm2Njp2MCn1xlZ7yrjEHmXFJBa78/WVu5JwTa0H++9kE+xXd1ttBpMKzZ8KY2Xc/p5+b7bDpzIDllKLHvmLA1rhforc5Qa1WjEj+M/D2xGkDhfc04Q8pqByx9pjiHfo5JsFWmwkcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=ScEvaDqv; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52c85a7f834so6808640e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1718708727; x=1719313527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQYAU6pzROoBuuHRkqrRKpetO1lSkUzkb0VMCTaossc=;
        b=ScEvaDqv1yivkTXgchmNJzkAAKEc6IBRtJyP9mOp8b4A/xZ6fwK6FJBssh7QFrtNxA
         Qsd4DVKkdsgD6bWMwGQXZp2wgLHHT1j9BJgFpvlnZBf8LVB1lViGfmYyZQPf8PQltkdX
         oJaGQ1h0ekK7g49ZfT5OsEbO/mRxpYBXVRLXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718708727; x=1719313527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQYAU6pzROoBuuHRkqrRKpetO1lSkUzkb0VMCTaossc=;
        b=MB0oX7JSCQfN545L7oPwFdIJyhykllzegLe4bVDD7sUNk7KTeAfTPhSrourdN32mcD
         Cc+rlJPWJxCuH7LZ8a61wTVrJJ+QCOgX4N+ig47iW4PGMRRbyGiVchQJyyBDq+hBUfSL
         KlJsiajyRLu5rGdIlcr6yUHXhZoOoXJJ7SmOgwwgaobvo5P3Xjp7THEZj+yvNZ+3sIPi
         0XOAMwuTUYrSwgprH6RdTn+fh4jEmdHJ0jbAfgfKkYnlLFPdjRKXDJOaDGdbzK2Ov0Py
         qrief9hR+EVFkmppivxVvrdK3y3ejzbEb/Mx++XvrfdmfhgxNlq3rbk8gANII3V16UHe
         X8ew==
X-Forwarded-Encrypted: i=1; AJvYcCVjkBPhzP1pphEZfhEBXhFcOaAouwhccHJs+m+aw7FlpVP/z26JdEEBpR8kth/QXvg3nO8KlYiNT6Cz6f4+JISFp9jWctKGu23/GS75
X-Gm-Message-State: AOJu0YzV117yLISMxejzs0fpVAde77eKLNTPdss7mB/4DC9MT/sFANu2
	rBBwEZqtwwvU9Tu19xl6PUuUOXpDjKB2nF+Omn299nhPsNIxZ2qm74yLmwybqcE=
X-Google-Smtp-Source: AGHT+IFNlsfM3APxVmAxEWghwl5cNejfef9/uKTOCWJh/jMtDLGzSKZtnGgEwqQDQ/JYkfU811H5yw==
X-Received: by 2002:a19:8c5a:0:b0:52c:88d6:891d with SMTP id 2adb3069b0e04-52ca6e5637emr7505157e87.9.1718708726703;
        Tue, 18 Jun 2024 04:05:26 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca28722f9sm1481146e87.167.2024.06.18.04.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:05:26 -0700 (PDT)
Message-ID: <63f0a3a4-f1ea-4b85-afde-d7b82bb95ade@rasmusvillemoes.dk>
Date: Tue, 18 Jun 2024 13:05:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: imx: ensure RTS signal is not left active after
 shutdown
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20240524121246.1896651-1-linux@rasmusvillemoes.dk>
Content-Language: en-US, da
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20240524121246.1896651-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/05/2024 14.12, Rasmus Villemoes wrote:
> If a process is killed while writing to a /dev/ttymxc* device in RS485
> mode, we observe that the RTS signal is left high, thus making it
> impossible for other devices to transmit anything.

Ping. Any comments on this? I'm of course open to discussing other ways
of fixing this, but I'd really like a fix to land in 6.11.

It reproduces completely reliably for me, and I assume it affects any
board with this IP, not just imx8mp.

Rasmus


