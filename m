Return-Path: <linux-kernel+bounces-246507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A96392C2DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC0EB23893
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E41494C8;
	Tue,  9 Jul 2024 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jtMkjYf7"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7C317B03A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547547; cv=none; b=B8OftvXAyxEIt8IHz0ANKi89p6MLpArLXhK1R9Py4F09QIuyPkQ4Y95ff/u0I3xHbKbj/x6h9D66PaYfuTeV6U5pIHflTMJlZbe/0bMl9gupQR8RlAeaU1zP0qhKPb2ByXljtO3431bUtoDAzSIUrwbUB2MTWuwJ9ReIzMrTo7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547547; c=relaxed/simple;
	bh=B2ybeoGe/mdMT8ELtzXBtaeU6uv0Kbth2KRn9eiD6Ks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UiGm/MEKwSQ9D+nEHlYL+3byDJepuTGkOWWfjHfFukmfcIdRSM5RoL3ioCKazg9pkVD52IeMi5R0PcTlxE+AXjZweS8hTWo9KWwau9UptV7pCMqoKGdUb+nASeUU7M5bdUAPEkPrALYsqkxrceMjRkEHKg23TTmBBp4G6hadB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jtMkjYf7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee94169e66so4864521fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720547542; x=1721152342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4EOuy7NJXdErPjBoDexTRUjt+r44vQQLOT5S4Zc36k=;
        b=jtMkjYf7eVPIyQnA6Jd5Znga0NN3xkFLiuFyKOdkP0Pja+gHNPCVPdshqT01cQjg1O
         x+bv6Ojff/j6LE2Bt2GwISAN+PdfTs5D4O0sYRzm2wQsLsNxjGgNUs6EdtT1qr7O+cgr
         I4NO0Jwom6ID4lC1ioOF+HGXz8x2vDgzBRPp6xbQ/2CbMzvl6i4R+v5KCQzU4Ua1QGKt
         UT9YHZA3qyLqgdsUlaY92tbWEUqdTJGIE8Xy9MzOnXT/eolY9N98TRuKHvX9p5KBkHRx
         MsNYucH4Mmlaej0cOm84a9VHT951cJStHuB/qEEiB6pYk+owiqhnxLKknC4NLxhP/1va
         NUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720547542; x=1721152342;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4EOuy7NJXdErPjBoDexTRUjt+r44vQQLOT5S4Zc36k=;
        b=diENztfu292WMRR771S8046Emu4KtSi3YJ/xKx1jpLXX55CJ0yxntHyY5+9BUuUdX9
         bmdGj++UFM8adop4+g4vDwmaaEVdgs9JCqPQMMaJAAq8grjmcddBZ7gzHDVNrNFMmGto
         /fWMKC3PBjPazdwaJCuqG0TeLYLauhxLYVJi9sbixw98MpQ70T/Tpls0liku8jXK6DLo
         GH3A5ZX+KlOvrq+EJ6DjUPbMgpC1Xs5aJ6vB/X4BJ68DA5z7TgFoRp5Fo/fZqv76WN3c
         Cq6IQ9q4GL2HTbjilPzNMDP5OljxgGUyM+ddKu2nLFl/7x8mRcdkgM5u6/a9AYcy6Hj1
         Uhlg==
X-Gm-Message-State: AOJu0YzOtCMWwBpjwCAnvsqXA5kL69LmLXDOEo7aoMNuTEpXm9Cx9ZHr
	2G4hXkTstnfKKha89/0zeWDcxATZE9xvkSiqF7f805zUzHmVww+wwWkn+E4MD3wMPj35zoZKv/p
	rnd7OIDdO
X-Google-Smtp-Source: AGHT+IHRjslBxiqyy0G3zZrlaEYF5Q+TIgFQwRt2w+/GueaRGC3kTXkbxEmvDPFr3e86fDi9Pu5PbQ==
X-Received: by 2002:a05:651c:198b:b0:2ee:8ccc:f113 with SMTP id 38308e7fff4ca-2eeb30b86a9mr21999341fa.1.1720547542378;
        Tue, 09 Jul 2024 10:52:22 -0700 (PDT)
Received: from [127.0.0.1] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eeb33fd1casm2454311fa.26.2024.07.09.10.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:52:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-block@vger.kernel.org
In-Reply-To: <e3d454173ffad30726c9351810d3aa7b75122711.1720462252.git.christophe.jaillet@wanadoo.fr>
References: <e3d454173ffad30726c9351810d3aa7b75122711.1720462252.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] block/rnbd: Constify struct kobj_type
Message-Id: <172054754133.374919.11899102978335897724.b4-ty@kernel.dk>
Date: Tue, 09 Jul 2024 11:52:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Mon, 08 Jul 2024 20:11:30 +0200, Christophe JAILLET wrote:
> 'struct kobj_type' is not modified in this driver. It is only used with
> kobject_init_and_add() which takes a "const struct kobj_type *" parameter.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    4082	    792	      8	   4882	   1312	drivers/block/rnbd/rnbd-srv-sysfs.o
> 
> [...]

Applied, thanks!

[1/1] block/rnbd: Constify struct kobj_type
      commit: e4eaca5e30c55c83c547974188afc2b2d02d4f0c

Best regards,
-- 
Jens Axboe




