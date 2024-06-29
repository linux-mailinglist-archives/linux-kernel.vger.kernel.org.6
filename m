Return-Path: <linux-kernel+bounces-234784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAB891CAEA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5FB1F23031
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1621EEFC;
	Sat, 29 Jun 2024 04:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="tNxx3uaY"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146FB46BF
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719634176; cv=none; b=ivmJ7JhJPMZXbqqIdXDzT+S05lSlzcnKCoSW60+t1INLN8DF6wriwHNBukU9eAp1YmSou66X1IRehgmIs1vGMES1zaLAH85JGlDvJXjeSGdHb8JWSykLdRXcax2NP5x5tHH2uQZJ8v/2E75+dZTas7VROShbqAscz5fyCi4W4DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719634176; c=relaxed/simple;
	bh=4OXrOqVZrGvVz94JQfdHCueae5egX1aL+2B2zn/orf4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iVAonxcZCsZ7aDtKkUp1o6hfyGF/xpF+VZ2NIW5xYdwalxeaKlv02pHjseTuFTAdm35FbY7oRn/oNBsTTliJLCgFdNDunMtxOZDwzGgqTiHWpvkqef+dWOXO2CwcZCw/wXIK8Zf+E+7m1uUl2aTpKx1IokEPRCSmUsb6c3Nu/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=tNxx3uaY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70aaab1cb72so50619b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719634174; x=1720238974; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OXrOqVZrGvVz94JQfdHCueae5egX1aL+2B2zn/orf4=;
        b=tNxx3uaY3PXtkez22V+YVABN8ezeKk78tNOZbjob+87xCF7+UqN4z6+jeGFARhV912
         E/vEI6bmHxTibHT8X56bBX+uqSuHR3TZHAq6Rkj0snhd42cLzDl16VL9a2SoseaQ6/tf
         wWnmX80LfAfSedF7wQVRBWWAaRqSM5yEdLERykMJk1aXTZXXb4YCKnltB4sbtn54qa3n
         W2qjqjNZmWT2YIsXpLOnkKG1QvT8JLCpWFKDs0xXQ+DpsjWlIHoPgzKu01WXbzIsF6X0
         9WTprCGlCKtCjqu7VEFziEiAkuJeZtVbYqrKf3rtySTiqf6ClV0p1Vk0AJ/iPPnON1Ch
         0plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719634174; x=1720238974;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OXrOqVZrGvVz94JQfdHCueae5egX1aL+2B2zn/orf4=;
        b=tess08xJzi02m+5xnbqw35jyHyCbp146E3LJH0bD7DzNYULeQ2eWzvZ5zy9shpIc3n
         1ihQRdNKPp8qvJ6q9/bZAwBzAdPWgZQtsuLUaPLYV1niBxF/Dnb4nBod49lZSfAt156v
         WM/RZcRwY93/c4yKJLcY0kvTlW6V1bv+XcuxiIAbRHjS2N1hwKnwV+nDHUR2RhL9htPS
         2AB/va/4qiweEbJ8mCiiH0dHYG7SbFQxccczG3YVYxt+4knSTd76s76bAm6+G9Yy70i/
         tS8kps0pKODgT9jm88U3xMSlDRpM9vqMZa+cf8G9r+kocsPzqDRh8uhDG6nXaC/nODgp
         umkg==
X-Forwarded-Encrypted: i=1; AJvYcCX5hXsAwJ5tieiBxDI3jcJe1HaAsNltvZdKZi1KnejTR2qBAKeAo3dm3VA1PhJiJh7bFUeQBeuTB9EU9jp+2nODQKFVeN251ZawAaMu
X-Gm-Message-State: AOJu0YzwUGYsDHDq6tJQijBxXh6lgCz5HiIFGhTpGagnOQ3/1pq6RJY3
	qde1q0GhwQf6DFBYUQ1oSr2ZQz0v6WxFrGqfSf3P9UJiODjuldDA8/x3c+9r0Zw=
X-Google-Smtp-Source: AGHT+IEM6YblCoAYp7Y4Fh1s2M340/lkPtcPusKM4ctqmd+2C1Pim+LjM/g/1VAiD8fWLdC7x6iKTg==
X-Received: by 2002:a05:6a00:1881:b0:704:2563:5079 with SMTP id d2e1a72fcca58-70aaaeec928mr202271b3a.27.1719634174205;
        Fri, 28 Jun 2024 21:09:34 -0700 (PDT)
Received: from smtpclient.apple ([2604:3d08:8e80:cf0:c875:3a7f:341d:5a70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080205c688sm2411391b3a.5.2024.06.28.21.09.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 21:09:33 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] ARM, sched/topology: Check return value of kcalloc()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <Zn8xae/b6lNaWcKq@shell.armlinux.org.uk>
Date: Fri, 28 Jun 2024 21:09:22 -0700
Cc: mingo@kernel.org,
 sshegde@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9BB5B7C2-C35C-4F5C-9DC2-AD015288A992@toblux.com>
References: <20240628194350.542376-2-thorsten.blum@toblux.com>
 <Zn8xae/b6lNaWcKq@shell.armlinux.org.uk>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
X-Mailer: Apple Mail (2.3774.600.62)

On 28. Jun 2024, at 14:55, Russell King (Oracle) <linux@armlinux.org.uk> =
wrote:
> On Fri, Jun 28, 2024 at 09:43:51PM +0200, Thorsten Blum wrote:
>> Check the return value of kcalloc() and return early if memory
>> allocation fails.
>=20
> If we fail this allocation even with your fix, how likely is it that =
the
> system will boot and manage to run userspace?

I thought about panicking, but wasn't sure if it's justified.

But since it would just crash anyway when accessing a NULL pointer
later on, it's probably best to panic() if the memory allocation fails.

I'll submit a v2 shortly.

Thanks,
Thorsten=

