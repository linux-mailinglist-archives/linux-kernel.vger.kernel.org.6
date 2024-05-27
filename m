Return-Path: <linux-kernel+bounces-190669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6EC8D0127
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0374B26ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1F15E5CF;
	Mon, 27 May 2024 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tyPfJ8mH"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DB215DBC1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815921; cv=none; b=uHXgLpqiTDhNbXa0I79bY7+/zQBaG8u8Yvhd3adpAxdSQgOC8KHyrATLBkLhpFoxbKd4j0PW5Ia8qnBmXFjo5M7adx56sWIQolT7Tn3qc1QEM1hBbgK10bZb4CPP8xxJKzMNtIHptfLgJBnxAKbWUIE/TwRVXRxf9NWgwHh8XkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815921; c=relaxed/simple;
	bh=HHPtZewEdArswaj9i7nFE9lFFfBh+aXtFZT3WxjsDNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVwklssI3kKFZ/H9eiT55uqSAhvFKodo7gtH8bSsGuFoOsVyFvnbT1lZDK80q1oNrMiDeNA0ItALgSaagWgbIZDqU3DXl2WAKDjQBmhxPel2VCiQaLxat0xKeML+9uhI0I8XDW8LIrOkzPO8mO7ZNAf1EYYMbtLWc0tErJD3D08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tyPfJ8mH; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-df771bddc0dso3165384276.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716815919; x=1717420719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHPtZewEdArswaj9i7nFE9lFFfBh+aXtFZT3WxjsDNE=;
        b=tyPfJ8mHUUolwLE4p8wFCRTN5seiD+QfuBxWSEqffSbmJXpA1AlvlyXe6mezOVnD9i
         LDPzsMc9ldRUXSWwshyI8kT61A4n33U8yFDbyAsifS62M95cyiKv9pUlScC891GuZqKX
         sYysuD1J5eXYkOQ6Ax4PLY/jNl5U4t9yPyPmjm6dcTrS21p7f+Da9aVwhLPhvZO9zjUz
         EZSEeGltXt1DA8/qj0+e4f4wtOwCisHxO53rpy78QF3ztY4DuXb/KE6VDbicgIyQaDum
         pyvHMpKT6ykyn3wQmsgP3IWH8UXosqepQpr0X1lzu5bcwJfLwZGZC2GZ9rqf38FqjpVY
         JmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716815919; x=1717420719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHPtZewEdArswaj9i7nFE9lFFfBh+aXtFZT3WxjsDNE=;
        b=SprJYKc8SdxxHtRrMtzL+5QbeosOzXw9Vt2FTnwF59CShxi5ZhLl8fYsIeZvF2u94i
         ZmLIkhLT05vSDb3B874qae3u51lGreFCoJUi0SUou/0g7rAihnvOKambitfgV5sg6u+Z
         qO9tsBPYSvVg5IN+8Vcu5OAZenUXZ/ACYzQuSQiqdkm5xV6JBM4d/VdB3WXxLdLKD6MH
         rp/MNiX/jyU8qLMq+1ua+TDFblabUFlppmYWP06XiTNlZteVQ7ywTbi5ia2AadZx5ws6
         JdWxU7ncYGRHIqcfvRXPSuxq+PXieCdiR65VQSzPcpxHH5BeRTd8Q6OMIlFg/z0oWR4d
         JxLA==
X-Forwarded-Encrypted: i=1; AJvYcCUauKUsnkQLaxbWr579JIBnt/B+ZBYUFREX4pH7ObpeaCirTAGB7/++YBVzvI2Sk/ku3pCT1nfiOjVcQ30yhhJzXCv3JqfuAWtWDykB
X-Gm-Message-State: AOJu0YyrSNXhS6b6KOkCgno7TbLNaldGsAN82gQN9YzEn+bEoPCLHmCK
	ifmAStUPJiaA0m6Kf2231yQijhRsAvAHD0QZeWSI4mU3PBxMhs6EV/Z3aYwZzEs5pPb6Cf1tkNj
	LcQWuUlmn9QaQfUJ4jArNAFtr5PrJpXnxabFdFQ==
X-Google-Smtp-Source: AGHT+IEWBm9xDu/Cz3b9NCuTVLp6qM1g8Y7CxSoghLcfStpWinN4h04/tXY/Cqdm0kMUWihSrCsNEnUUmBfStRasc5M=
X-Received: by 2002:a25:ac14:0:b0:dee:61ce:3b62 with SMTP id
 3f1490d57ef6-df7722327damr9321143276.53.1716815918928; Mon, 27 May 2024
 06:18:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508150406.1378672-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240508150406.1378672-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 15:18:28 +0200
Message-ID: <CACRpkdZsLYPEBL-Lk25r3WU-b-7x+qT+ELQ+ZHbUu40_zSkqOQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usb: fotg210: Use *-y instead of *-objs in Makefile
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 5:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> *-objs suffix is reserved rather for (user-space) host programs while
> usually *-y suffix is used for kernel drivers (although *-objs works
> for that purpose for now).
>
> Let's correct the old usages of *-objs in Makefiles.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I haven't examined the claim in detail but I trust you so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

