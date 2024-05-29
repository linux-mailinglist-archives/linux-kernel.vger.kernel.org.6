Return-Path: <linux-kernel+bounces-193599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F381F8D2E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10401F22A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89DD167DB6;
	Wed, 29 May 2024 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="edmE9hJ1"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C721915B0E5
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968380; cv=none; b=WOiG/tQPLdAqflf3/lEkU9MZj/N6O9el6m1SPjvEXVZaSeKqaCY11PPLPlI3y8+ZBB2zR4pJ0Tg83NmYbgDwU4m8e2LWtT5yaMzbVEMkEnwFRsq4aKgsGgnmC/FCc9huSHm7+J52esU0eSwyUWOUD/1UHW6kl/KajZzn//xysdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968380; c=relaxed/simple;
	bh=dIUHlREyxoPoZtdNGiAkNZfXXQqJR0RZChk34bQclZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLoxDdQo+PVEoiH309sT++KAW644XQuBmnhDcN/7PJQL/sj3iZnIKp+cRQWHBEe4O5BVVYKmKfYuyxVNRegb00WhOAi7RdsSLgCU9U+4tEfEgKhB22KhDbtwg/IbYQO8HhmXvBkAtNLtiBTGMtNP12A4/o8rFi/KC0SYZsKteJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=edmE9hJ1; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-df7713445d3so1956191276.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 00:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716968378; x=1717573178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIUHlREyxoPoZtdNGiAkNZfXXQqJR0RZChk34bQclZE=;
        b=edmE9hJ1j5+mySLhJntNbs4IX+8NziAioMWxCwM1mxPigix8ENHZchgHkcp7WzWcAD
         9Q38Ao7vJW2XH4NgYSu0ZxvHd3vQ81DARL+fEeeBvTINxmWBQ9MAwMBDR6JkqQDsNli4
         wLLCV8IplUr+GPVY374BWwlnhKo4bvRm+eeNziP7GEvF9wmjxD6d8QGwCvPYBRjvQQxF
         cW1ll22toGSLo6lHPNZBQMqXfRhspWW3bw8wZeaJ3kY0SyFLFojEG76dhm8z9vdBDjZA
         01ZlM1HjD2+XUdI54grIaStFqpGVGzBea/adw7BOnY/5pys2kjh+42rZUV2nW7/+PgPI
         6lEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716968378; x=1717573178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIUHlREyxoPoZtdNGiAkNZfXXQqJR0RZChk34bQclZE=;
        b=nqFoJ+hAEOa2xy5fm0E7HGl2W53pGDaYJQllF2w/JNguDJMWJLQV0PzYgj0gecvtqr
         B6uJ98O+i3WzsTqBH8YjjjFG7ezr3aYqOW11yu41KfzDA+vquR4abbgIOdujwV4gtfkW
         QCTw5oQAlHS4XLYGnfyPUFgJxbTMCvsquDJSdsBPI/eTxc2mRI8yJhCr+yF/bNL/mVZr
         o0cJWH1TFP8gRD47DogBxZhwmKQv0RMql8Uf0ZhbYiDd7Z5BwVUIcPlWbq2l/kU/pSGX
         +CEemuXhFQHmY6QvUUWXF/ajifR7BrJs6pTQr69yllen0ZxieXYmgOA+eN7r68YtAPBM
         qcVw==
X-Gm-Message-State: AOJu0Yw27Fi7pd/9JWfni7ZFkFyRSqxJ1nGdKAse4smomJEzoWXsBoLs
	rXJWK+N4gHSa2YECOuCTDiAh6CUvCpaSXfCYBdCXAYIByjUNXe/dETVQc4z8hVWan7J31AtKUpj
	fm/oTD/hRlphqX/bQdKfVRxwE4LPXW1A1wr1QqA==
X-Google-Smtp-Source: AGHT+IE6xngebiMvGgBIj3GUCutJXdhxJKc24OBvy1FUHn2jrOx8uxKTbDEhMD1r2R0oUMRWlUfpZGzGn6BiYuNSw2M=
X-Received: by 2002:a25:6809:0:b0:df4:d367:6bd6 with SMTP id
 3f1490d57ef6-df7721a7909mr15039871276.29.1716968377779; Wed, 29 May 2024
 00:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527121340.3931987-1-jens.wiklander@linaro.org> <20240527121340.3931987-3-jens.wiklander@linaro.org>
In-Reply-To: <20240527121340.3931987-3-jens.wiklander@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 May 2024 09:39:27 +0200
Message-ID: <CACRpkdbA-HF135xbY2RovOyvtSRyiJ8fQ9JG09Bf0vwna+tQ9Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] mmc: block: register RPMB partition with the RPMB subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Manuel Traut <manut@mecka.net>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	Alexander Usyskin <alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 2:14=E2=80=AFPM Jens Wiklander
<jens.wiklander@linaro.org> wrote:

> Register eMMC RPMB partition with the RPMB subsystem and provide
> an implementation for the RPMB access operations abstracting
> the actual multi step process.
>
> Add a callback to extract the needed device information at registration
> to avoid accessing the struct mmc_card at a later stage as we're not
> holding a reference counter for this struct.
>
> Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
> instead of in mmc_rpmb_chrdev_open(). This is needed by the
> route_frames() function pointer in struct rpmb_ops.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Tested-by: Manuel Traut <manut@mecka.net>

Very nice code!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

