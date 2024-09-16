Return-Path: <linux-kernel+bounces-330709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B5097A314
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7443D1C21AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE18714A60C;
	Mon, 16 Sep 2024 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JkHk4k8Z"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D41494B5
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494590; cv=none; b=PcwczyehhPyZ3qKjgh8dalydb9OZHjdCXvNw3K1Lo/9mJIEHWbxiZHaQFR0qE3///9VkLCQ3LOKd79hRIKASFsbhpJWad0/mGOAYRdjtb8se0l4Ae6JgY/OfiVr5dcNkZ/P+rKomBy3KCQx6z6dTa+xIA8DULw04+vik2mxZsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494590; c=relaxed/simple;
	bh=mTYLlhgJFyLCJFiquQhXbDJFC9KNkU16Jqo0fhCn7Mk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aDCgt34Ur2KSg7VnYvBsjZPxdf1H/TGxGY54iAfBVFGHdbK1FgUUNtlv8uy9tvLX8sYNXNC6RXRghCQLPLUX8W39pWfwCxB4CNoCa11DH++EE5usXvnpVzuCBsgA1icFlQnKuRlL0J26Bf3sKY79CRAUBM6KBx4rL+9lRdovCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JkHk4k8Z; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374ca65cafdso2207630f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726494586; x=1727099386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhrGkzepf/7gkzfLnNo1SUYJoz3hCDltEutlMFgBtEY=;
        b=JkHk4k8Z5Kwht73EaZOwmRiD4q1lZhFTaon+lgrc+irA92oS2AgclFY7TQIrBMqivh
         DRQKLSxmJ+FmX0x66KmjZ+VPfVPaSAlYxzk1KlQgXEj4+W/zyPGiHXnwRl6t4OtA0Bke
         LzBiTGELaUB2Ujmuf4dPg0K/v3+RyidiuXry9qQwvWWkZ4PRB8f5zZTaNWPSJX9x4117
         xTS6L23anWzNZmpDb5D4yaTU5jzdW5AZLrKdOYs4Sxi3cynnpkrWzKZWcqjLCc8lSiaW
         34tmv8y1FG/CsP3wOwU/bMyOJ7a/mKPcjzTxBzDB19IzwNcWySFtptsJ4eI/QHJ4O691
         TMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726494586; x=1727099386;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhrGkzepf/7gkzfLnNo1SUYJoz3hCDltEutlMFgBtEY=;
        b=Cc4E7e9+MqjwSwrko/yicfmFTUNwmRvqGZEfwNdtQ6PljOikWtid6Kv2S1QaJWSVD/
         j06ScrECPE8G5kXjeVr174kc1PXuQ8q5VYpSgUF5OHidl0siHHz/noosbtv+wtbUI6k1
         fd37tfq7gs+nkqXvjI8qw4Nkd1+nT4I2y11srZvU4iIy7dgsPnRZEVM4BcdKWqh+aTN1
         ApzuVeEneUTdXl8grbZ/AtJfNyvKf2p1QP2GeQVnqfpg9gNZ4nn65vEu+HsmAgb6R2GD
         Hm4wPUGlkGowyL0Nuwi9Lq3dPOK5dUKNf4IGCdTm7fhAOEBuRxLuisjhKrEinbsYjAQz
         8jTw==
X-Forwarded-Encrypted: i=1; AJvYcCUqbhE5q9kxmoeraFZIqBEl2JI81aaV2nLCdXxlG+RS3UoFob5DKtD0cYVeJxeLyO++BWOwASYFO9Kw8Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdB5fPWsZn3NjZmcM8mYKLvg36TojpqKJNu7YJSQhHaE7T0mlB
	l0Pvzct1NHPMLkVCij1lccoPOKAIQApqlE3ZjlJ3C8oaUcMRw2dPqo0NIZxK/N+fJfWMrQFmN2X
	u4s/WGSAB
X-Google-Smtp-Source: AGHT+IEFd+n3pMJxR417Q9zcx0oWXZFwDVePmgPghEM7qSB/XlIsd7vjIXUULvkasjnBv/6HrG/WoQ==
X-Received: by 2002:adf:ea46:0:b0:374:c712:507a with SMTP id ffacd0b85a97d-378d61f125fmr5809960f8f.32.1726494585856;
        Mon, 16 Sep 2024 06:49:45 -0700 (PDT)
Received: from [127.0.0.1] ([194.2.69.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e85ccsm7266248f8f.42.2024.09.16.06.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 06:49:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: io-uring <io-uring@vger.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20240916111150.1266191-1-felix.moessbauer@siemens.com>
References: <20240916111150.1266191-1-felix.moessbauer@siemens.com>
Subject: Re: [PATCH v3 1/1] io_uring/sqpoll: do not put cpumask on stack
Message-Id: <172649458122.10114.15596316527978537875.b4-ty@kernel.dk>
Date: Mon, 16 Sep 2024 07:49:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 16 Sep 2024 13:11:50 +0200, Felix Moessbauer wrote:
> Putting the cpumask on the stack is deprecated for a long time (since
> 2d3854a37e8), as these can be big. Given that, change the on-stack
> allocation of allowed_mask to be dynamically allocated.
> 
> 

Applied, thanks!

[1/1] io_uring/sqpoll: do not put cpumask on stack
      commit: 7f44beadcc11adb98220556d2ddbe9c97aa6d42d

Best regards,
-- 
Jens Axboe




