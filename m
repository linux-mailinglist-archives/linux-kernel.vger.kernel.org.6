Return-Path: <linux-kernel+bounces-350224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C37949901B7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D1D1F22939
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B552A15B0EC;
	Fri,  4 Oct 2024 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXxNVbiV"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A197D13B5B7;
	Fri,  4 Oct 2024 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728039445; cv=none; b=CIh7TN6IhUkzWnWD/GTxxXCD8TR5XknOMHun4HXg9jrA55skGaCiZkmPjk7KaXZckPeHNwACZT+vaeAahyuXJ+Gr2zxe6Mj66C5KfQNYORvdxtzMayheQFeHrN1WDjvrU5GA3ajt/OhV/vnqI0+QT4MUd/GaRHqdWhiHn6MeREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728039445; c=relaxed/simple;
	bh=v7Vv7GA+VqMX6iSrPiE74byWiyNiCNo3GfLjUO8Psts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=l8v+GTGx0g+EQGxDZqPfYnJfo0aZJK7YbkkfE4616DoqiAvYrD52oayN4Ax2oFsRrU7OBqCaafPFAsH9IENBLy2a9IpC7Y4B/cLPpCys0OwHwDI6T5mO6wxS+qPqErPuJNUkcA0ZyMwt0oGtAixTEAlzdRJgtp4OXn1CSUp+hmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXxNVbiV; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so2096163e87.1;
        Fri, 04 Oct 2024 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728039442; x=1728644242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7Vv7GA+VqMX6iSrPiE74byWiyNiCNo3GfLjUO8Psts=;
        b=HXxNVbiVSX3x5eauDnuV1eweE96g4FhjYD9MfXq0vjEbhWqMk3V5JT7GSUgiFLueBm
         FNSCRxeYgue+NHR5yvNh9Qf3IbjfcFBfaFTFgiqDjAqjMDXzffMylfJSLLw/sdgf0QRh
         wRXnGfHxQVLiW+FeS5VhBFLPQuxynlbaQfh/m1lxg10HZGsLCBD7PLkNZ4YfSh0I0WcV
         YKLJdZWJgp9xnjx9Nd5Cc+G7teB43aBM4wcDvYVcruWJ/bnhAGooaxNKmNY19eGyaoRF
         W8L0u8xf52pAvR9lPGCKkYQc5I+q0HLBWlrele7i4vEpmP0CSpm2c5WZRQcIFJuUT1VS
         Cwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728039442; x=1728644242;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7Vv7GA+VqMX6iSrPiE74byWiyNiCNo3GfLjUO8Psts=;
        b=vuOpM+pJrL7hJ5Bpw7TNGUJZCg7JG7VYBn2gX6LFCItX61HtJSOTbMkj0ZnTJisvBw
         BsWye2mVObe8+8bSzkDcNbZs95WnllT5tph0wA+hW9y4lj4JNUK0gsdwfQNEJOJnzhSJ
         ah2P7FqQdrfWqnqA7PYSgitQYXn31hRnxWE3WPaiyLxDfp+mbnLjsvMs7K14Lpb1RwfF
         1UmZJJ/MPkwpvvbKzF7jZIBqBC3KA0iy4pQhgIGkv3SCOwxbnEH+xdKZpJrXQ4JWp2uU
         DXn4vCYd2dNTddKXjX+pg2+kZQ99IksvOjP20yFHP/Mk8Y1Tm5yidk4UPchPnOAs+dDT
         HldA==
X-Forwarded-Encrypted: i=1; AJvYcCV2eOCx+SUMmjE9ZznOWm3oeKasPRGXWrgy1UOW5YiOTz9pYHpDhVHDnMFy7qOZeJn09wLjEMJz0TWW@vger.kernel.org, AJvYcCVK9L3i/vh5pPKMY3zs4wKCvwLaRuXiWWihYrxR7ih4OMYsiueg5JjSeYCk6M+DPpKKyl2FEjlmaJ1eoDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtgGciso0VVUZe1k9+Z+BXYy+mDNo1qN+gjCADw+uk2RdyI3GS
	gWvvu/YsKCPdJdPRKrU2qn+mgBWyQWeQpMVtmlshCL0AVNB5Y90F
X-Google-Smtp-Source: AGHT+IF1ryAV96Yu5IKqvIzK5MqWdCDLIetIQCfucm6oLdmraibMZrQwp4bxulv7kjK2QZqx8/S2uw==
X-Received: by 2002:a05:6512:ba2:b0:536:9f02:17b4 with SMTP id 2adb3069b0e04-539ab9cf41bmr1417313e87.40.1728039441397;
        Fri, 04 Oct 2024 03:57:21 -0700 (PDT)
Received: from foxbook (bfk18.neoplus.adsl.tpnet.pl. [83.28.48.18])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a8e4e8dasm354920e87.28.2024.10.04.03.57.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Oct 2024 03:57:20 -0700 (PDT)
Date: Fri, 4 Oct 2024 12:57:16 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: olivierdautricourt@gmail.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com
Subject: Re: [PATCH] usb: xhci: xhci_setup_port_arrays: early -ENODEV if
 maxports is 0.
Message-ID: <20241004125716.75c857ae@foxbook>
In-Reply-To: <20240930052336.80589-1-olivierdautricourt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

> If the controller reports HCSPARAMS1.maxports==0 then we can skip the
> whole function: it would fail later after doing a bunch of unnecessary
> stuff. It can occur on a buggy hardware (the value is driven by external
> signals).

This function runs once during HC initialization, so what's the benefit
of bypassing it? Does it take unusually long time? Does it panic?

It seems to alreday be written to handle such abnormal cases gracefully.

Regards,
Michal

