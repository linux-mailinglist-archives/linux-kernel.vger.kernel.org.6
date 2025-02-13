Return-Path: <linux-kernel+bounces-512976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB9BA33FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A55D3AA8A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DCF23F43A;
	Thu, 13 Feb 2025 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NOlZSPUz"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B123F430
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452254; cv=none; b=Jfrgp221eX2/Jl2sIJ/A20jLNW4yM8FU5frJt+7yC4B/SwgkZ3bnca1NvUJNFnGrAKfV8cYhsa7hXEPmkdo4C/ijpxGhnfBTSNi81+qCA/r49pXWyy4yFUA+fA9Geh/DiCczZO7/nVWHaP7/CZkOgvSPd0u9fOmdilckzbmEy7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452254; c=relaxed/simple;
	bh=qMMjTpyfYyNonkX2A1Aa7fVFvWhTsO0Ng8lzu7ZL8r4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=isftbU6ploz/uU8VxXBgC2ZsdYe85yagT0BfOpFrpT1qJ3+DywVov7LMsq3BJD/3w9Fcds8/1Vk0tQta5kvAl5LBcOVcFYvzcEwY/SKqRb2DSEQHJP9Ap2ckKheMErlFf+WSvujF7oc4NPENYE6fhQmFfjLyVbmAa89he8RJSrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NOlZSPUz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso5236475e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739452251; x=1740057051; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ClMOmTx9jS+uiaY2+KqmPclmIJuMGjlpVByF59oqFKE=;
        b=NOlZSPUzcZ51t8QUUAJTi7ieFpGPO0MFDfaNqnfPWo3TqXpSXQLPegDKSiDHIvewbp
         ab9dPCYFPWsp/mzmaeXYJt7E+l2acLZN0KbIgqce6LKlXPjLPsww9StCJxp2dOjOQtWH
         cGovNp1vvDyVzTFnGTozFG7M3fvfjjdIQvb2+88kdlCPUgNY1lyR/oNvrzAlRY3Gg8/q
         FXplAoo4ppgSJF6x/kTv9XxL3DbbsQkFF9SXK1ilpHnejDxM8sqvyG6JYRtjRs7b+UK/
         NLg8rgYHNycH2AhqnhbYFjDeLZa8+kPk5d5aFtSMVcDEI+aCItwJbg6UfBS+OrACYCEz
         z20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739452251; x=1740057051;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ClMOmTx9jS+uiaY2+KqmPclmIJuMGjlpVByF59oqFKE=;
        b=frc4CLClvRqLAr5I/RvbgQF46O/3ZLLsP9D5b0HUZZzhFzV87vWmMS9Wdn+r4MJBQ/
         lhGspiQU4zON+lvFedWZ57qui6UxlIDFRezb8RMvMvbXlazB2vMb6PltrbXy40v+Qd6Y
         osozuC8IgHKdGSm4vCXYgBBXdAX+nQgS0LW0RTe1uCD2qjx6EFzhZeg2YYe+Qmm6dCXO
         wRA+PNZ1cUwxZ25VsRhj4XcBBTi0o3DxBhv31IV9DXz2c3uPSTAe9/y2tXqvkT3Fozbs
         pILsQVm9vFYKatj5cyg8n3ojRsoH4KiQqM+y8bpKjhPQ73h7PVGgaQbpvtIGOve7EZ1e
         meWw==
X-Forwarded-Encrypted: i=1; AJvYcCUQfBAhTw4EvCuHMBgdAPYsunFOmhZ3TjQL6G6EIaHsDB82Mrtc1TxPo52OY/qirQ/eMUN/CLNyIdT/kcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiGMwnOTknJZYsst3W0BpoX1IuIsfFJ7jMjrrZCCphl4OWFZBY
	P/nULYzFJGnBr6iQMrmgHtmJ8s1a5NFB+vmQhu2jagDzkiGs3s/S6sLxrFmb4/g=
X-Gm-Gg: ASbGnctDprmqHCpp90J1ScfgR1Gy6+KSQAFgY6POVUtq2Qni80B0V3P21H15Tlz7dD1
	YIURAkjNxNKRVzFSEmJrGvHZcXWCtZO/4pe0mNBjxx5s7z69vvIwFK9nKWYp9ddxZKz0GQXEk0j
	w2nO7gslXMvfCH8YrQpbqzdFvxSS88uMDmylOxhDuYRguqSvtkYQUtI37AjcDPsNfEPuB6GkjQo
	ZFaNCwSG5QVJBY6s6bx8u+TelSLJuZabLXh40HaJvW8sEQvh5xnTQWaHMKsd251IM6/N4wN5y8m
	dhU7AhEsMW378OD7GAQ=
X-Google-Smtp-Source: AGHT+IHyBYF0/4Gdr3ZUYIjivzFP/lqbVMmvKn9sUMf9411Sd9hB+Kyd7Ye15ESQaYuZJjC4IcO6qw==
X-Received: by 2002:a05:600c:4812:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-43960cb35dbmr29034975e9.0.1739452250944;
        Thu, 13 Feb 2025 05:10:50 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b8471sm49019895e9.37.2025.02.13.05.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 05:10:50 -0800 (PST)
Message-ID: <e5855e6d868b60277c24df01b2f27d8736301932.camel@linaro.org>
Subject: Re: [PATCH] usb: typec: tcpm/tcpci_maxim: better interrupt name
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Will
 McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-usb@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 13 Feb 2025 13:10:49 +0000
In-Reply-To: <2025021323-opponent-strategic-a27f@gregkh>
References: <20250213-max33359-irq-name-v1-1-1900da7a1e79@linaro.org>
	 <2025021302-malformed-captivity-e862@gregkh>
	 <58af4b607adbe74725d4869f8f5a09cd5d3be2d3.camel@linaro.org>
	 <2025021323-opponent-strategic-a27f@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks Greg,

On Thu, 2025-02-13 at 12:56 +0100, Greg Kroah-Hartman wrote:
> At a quick glance, tcpci_register_port() is called earlier in the
> function, but when you error out here you did not call
> tcpci_unregister_port().=C2=A0 What else needs to also be unwound?

This driver manages everything using devres, including calling of
tcpci_unregister_port() via devres:

        ret =3D devm_add_action_or_reset(&client->dev,
				       max_tcpci_unregister_tcpci_port,
				       chip->tcpci);

is done just after tcpci_register_port(). As far as I can see nothing
needs to be unwound explicitly.

Cheers,
Andre'


