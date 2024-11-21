Return-Path: <linux-kernel+bounces-416949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2100F9D4CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BE2282A97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273301D4325;
	Thu, 21 Nov 2024 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0srzGz/"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB661369AA;
	Thu, 21 Nov 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732191990; cv=none; b=FmNAReHPpCdeOk0e58FcpJD1NU0ISHQ7VuMmRS75OL1Quy/+sASrBPuMwD/lglt9B/uNcINp3LnHpWdpmORQq2SI/kfJWgDxVX2hwGoABQZT+BCzWn/TVl37UhGz2Jb7/AQnriH7fdYtbDV3GJCc/2sTibM/PGP51gUeKWr0VbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732191990; c=relaxed/simple;
	bh=ulZTmxWVcjigR+qYZlOAySxZoDa70B4N5XreFIS+shA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kQK+vbUggA1CIx/EpAhZt5E9QOzrVYI7o+k24IfswQdj6d6+KH9q6s0IYd3vGsWBgq5u9S2XPhotsmdc26ys27iE7k2kSlXQiBNfG828A4Ei1VGRjoUITRuvvAszqByXLn/GAUgTXtCVlxCsSIFYyQRFOgbAg574eWARCwCqntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0srzGz/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cfadf851e2so1119356a12.2;
        Thu, 21 Nov 2024 04:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732191987; x=1732796787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ulZTmxWVcjigR+qYZlOAySxZoDa70B4N5XreFIS+shA=;
        b=R0srzGz/lYNJdpAq6kWY0f49xFiKRc/YJ4d3oDAB4ivIZqKQA9+Ofy8aj/1P+wlQ5K
         1I6t4wq9FyvtGh3tqOhEOzoFnsmgZ4sp9WvV9dRPLEoex15sZ3jlZ0q/+hoyerJn36AV
         dO/FyAFyrCgGYLo6xqlnxiHk4LyXH9zr6M3x/dQplR9QywMp1MmrVRDBKDJD4yxpa9k5
         y+CotiCQMJ+QY6hWnX8cQkPkgB/RG3kay5BtqtBwilUMRMIToqrfj1UyoNZc8r7EJQTk
         byRtmo5P+MSB4q+ApH/5nhh99ajH7BDVUAbuOxtRCvib3fL6Cwwy7dQ9PjpvxW21tufo
         76Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732191987; x=1732796787;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulZTmxWVcjigR+qYZlOAySxZoDa70B4N5XreFIS+shA=;
        b=Wh45jLLjMjZ9SPv6TbW9FL81xf0j8LwhlmkW5E68bqL3Lv2Pf40Ks/dfoIGHCexNYN
         Ys6Xj+i54RcEV2HncbojCvXKQjSVnCX9g5R3THwJIoVuQTpa+YK1Zqi5K9IDy3V/jGe5
         ZEcq2zrZ6jznFL69ZD16nmkroa1kl/ibrHKb0cRkjNlOdWWTZyRgYUKFd4fb6Y0+VrUN
         yg3jjStD+SjBd2luQZERK1Hgeq1sKiueelx6bvNTpb5EsB8cAVJNBnAQSoUn2QbQO8Tt
         UUBoGs6fT6XvqThQSYf1Ea02HTfIxGv28JGFEOM0ycCySc6qXcxu4lUl4JBBcdWY9nBI
         YNuw==
X-Forwarded-Encrypted: i=1; AJvYcCUU6QXF4lCu4ZSyzwRUenyCfjOPTxmioH6hn9EpHEGLmlWDnyW4u4MIm+cD2L+ockUKcDHDPg+nkgwM6xJo@vger.kernel.org, AJvYcCUddMuiFiAwp0xsRE58BbFRLpDYycU3wd4/VKahpuN6NXQSu8qAjLzLbzVH7aOrfpBuT5MX8cQozfvW@vger.kernel.org, AJvYcCWvTelfxF2oOrxPq5fSDUAeIgVp1Y7/0VFGPll63KTKn/F289Gu0SJA3TRceZscLFR9rbsiCyBAXDXb2SHn@vger.kernel.org
X-Gm-Message-State: AOJu0Ywczf6uo2VUkfCe60JlqAskHHnFBCKOEb6FAwQUsIjJa+zQieck
	yMIUPv5DsfFyBAhybDTZCm+ALCWHlU+LZ3ydw8neg2nE6OGwmROY
X-Google-Smtp-Source: AGHT+IFrlPjgnhHtms+P1z4/+5K49v6csfvM/F8Ofr1mnfFQczpBUaHxpJlITkS/2QI8N6xNFRSu+A==
X-Received: by 2002:a05:6402:430b:b0:5cf:e13b:eed1 with SMTP id 4fb4d7f45d1cf-5cff4afe13emr5108404a12.7.1732191987077;
        Thu, 21 Nov 2024 04:26:27 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff44ef803sm1889137a12.28.2024.11.21.04.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 04:26:26 -0800 (PST)
Date: Thu, 21 Nov 2024 13:26:24 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: wenhua.lin@unisoc.com
Cc: Zhaochen.Su@unisoc.com, Zhirong.Qiu@unisoc.com,
	baolin.wang@linux.alibaba.com, brgl@bgdev.pl, cixi.geng@linux.dev,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, orsonzhai@gmail.com, robh@kernel.org,
	wenhua.lin1994@gmail.com, xiongpeng.wu@unisoc.com,
	zhang.lyra@gmail.com
Subject: Re: [PATCH 2/2] dt-bindings: serial: Add a new compatible string for
 ums9632
Message-ID: <Zz8m8PqHX_7VzgoP@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113110516.2166328-3-Wenhua.Lin@unisoc.com>

Correct me if I'm wrong, but this patch seems incorrect to me.
The 1st patch suggets that the sc9632-uart is incompatible with sc9836-uart,
but here you make it fallback to it anyway.

Also, both of the patches seem to have made it to linux-next without the
reviews/Acks from maintainers. Maybe Greg was a bit too fast here :)

Regards,
Stanislav

