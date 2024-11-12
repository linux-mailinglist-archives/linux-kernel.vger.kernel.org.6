Return-Path: <linux-kernel+bounces-406515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27DF9C6046
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68505283F39
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F5D1CFEB8;
	Tue, 12 Nov 2024 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdaroC8Q"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB24C215C68
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435733; cv=none; b=UndTV7OHwhehTcyBq5YNnyGXfU7dhO2WikKB2sJUUgjWjl9dy8yTbgbLuA5+ccpJMhhxB+e2hkPW2FWB33xe71NnqdaccAExyL5OAI8pRQ9wngYv7fMelbDKSD+yR8XTFKPrsQybXqYo74c84PPry7kIEPMhRyL/Ipa33xIAFEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435733; c=relaxed/simple;
	bh=0kqB7wh0qZCmy5RkK8FrNaWAcNJ+DzxqPtW9Qea4PQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQAV/WC9hDaCwuHY2Obt5oDqoEoR4awLZsNvCHjS33z6TgYfGlzjcZGFpVnoNoKOQZQmDC7IlqLNGwrhYbHIoRcCCNyW2rVBpvdpA9dCL0YXbb6uE5IALlfOa1bP86/YPvao54ij2PtYnTYBiAI5nofat/4bgpZ6JJDpG74Prjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdaroC8Q; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-aa1e51ce601so148950166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731435729; x=1732040529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kqB7wh0qZCmy5RkK8FrNaWAcNJ+DzxqPtW9Qea4PQQ=;
        b=NdaroC8QloQllscJcNuY7/jSUIWBbNBSabLUvLD1lFSMLzHRaUYvv83fhakLOb4O6N
         HEPmrMfX4YDSLfzYOkrYBCHArT9D/pzTRBVsK1xcSn38nkqfWEgqaUjMsECazEBE7t+L
         j75zsOXRhuH4uIfxNWc9pape451IUXBaDExU6j7cb/UuMSqLf9kf9qBuUPIzcPtBqzmX
         pRNOjEHISN+QeIpxo9awpJIr4/H5qRwELmSYZRL3hm1L0v0OVLsjzuyG2s9sMxrP/FTG
         LagDyfy2bdM8WugG0U1zp2NqVV2HlBK8crUMuW8HKn0PpXb0t8GjGgjkeFOaVGXPqe3X
         mGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731435729; x=1732040529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kqB7wh0qZCmy5RkK8FrNaWAcNJ+DzxqPtW9Qea4PQQ=;
        b=BrNRXFjyA8Qe+mC2XdstJcHfnrhVf4gOs7UZrsTBxP4YG+CAxymM/34i9pmG1xBl7E
         Vsrq/W8jnYYx32ogVHyujSsgVPb9AXQlI2v+/R/c/FGQV2vGlHEWHWP0GXFP3AOOyLGa
         KRdFvb0o4mtyHzDAVe3jBWGOLX7v0/EMNQa1NCt9eB/Sv677OO9g56hPCBI73yJDPYMw
         XWVjthdz15DJZrwESRdUxPNvR2bOyfk1unzn3Fqq9XN2ArEWVLTintcXsfDhDUkP8rDz
         f7c4TT3FhHtO9DuxNAhLdrXe2JEqAktarcN/HEXTl+BTs+7aXEAYOCAQr5r8wJXEEEQL
         13fg==
X-Forwarded-Encrypted: i=1; AJvYcCVe2kJQkXiYpPPJke3CcxgXF8IFI507Phs3W3Y9OD58l79JQ33BkrZq3GMS05NCq5lJJ12XLlajedN19zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuCXF8PfBX0+AwdxUHbGCe66uxxmNWsj8o20qdq7ZHU4SJ70VC
	Oir8XIlPQgqxUrtQCVz6rgxTReCzEyEkRlso5mQD1Cq9YZ8vcsv5LIyrzRtiE09YfxwT7ZTAXkT
	N3qXpyB4cC32e36IquGgmhggRon2ZrorHnWr1Uw==
X-Google-Smtp-Source: AGHT+IFopeyjGv+2IcaDu/O9c406pUCR34qegYphrOsLMDpGo3pZJSsDhkl22PD4xCJ/njRvaU7GTkZY9bsNIdI8ZxI=
X-Received: by 2002:a17:907:3e8d:b0:a99:4c68:a03c with SMTP id
 a640c23a62f3a-a9eefeeccd6mr1665213766b.22.1731435728842; Tue, 12 Nov 2024
 10:22:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112163041.40083-1-chenqiuji666@gmail.com> <2024111214-casing-gong-5c78@gregkh>
In-Reply-To: <2024111214-casing-gong-5c78@gregkh>
From: Qiu-ji Chen <chenqiuji666@gmail.com>
Date: Wed, 13 Nov 2024 02:21:57 +0800
Message-ID: <CANgpojUSQzmcKcJxQo4WkWF8A_vFVwRrG2x=n0Q7cJuA3ZKgGQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Fix concurrency issue in match driver interface.
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Greg

The driver_override is updated by driver_set_override(), a function
provided by the driver core. In driver_set_override(), the
driver_override is updated while holding the device_lock. Therefore,
locking is required when calling match to prevent the driver_override
from being modified within driver_set_override().

It=E2=80=99s fine to add locks in these two functions. The second half of
__driver_attach already performs lock and unlock operations, and the
device_driver_attach function in bind_store also has lock and unlock
operations. So, when calling the bind_store function and
__driver_attach, these are environments without locks, where adding
locks is appropriate.

In the current core code, among the three calls to
driver_match_device, two are not locked and one is locked. Therefore,
adding locks in the lower-level driver would conflict with the already
locked path in the upper-level function, causing a potential deadlock.
Thus, locking cannot be added in the lower-level driver. In the call
chain from __device_attach to __device_attach_driver to
driver_match_device, the call to __device_attach_driver is already
protected by a lock, so the call to driver_match_device in this chain
is locked. If we add locks in the lower-level driver, it could lead to
a deadlock due to the upper-level lock.

Changing the string checking process to a driver core function doesn't
help, because this checking function needs to hold the device_lock to
prevent updates by the driver_set_override() function, and it would
still be called in the implementation of the match interface.
Essentially, it would still involve adding a lock at the lower level.
As mentioned earlier, there is already a locked path for the match
interface at the upper level, which could lead to a deadlock. From our
perspective, it seems impossible to modify this locked path at the
upper level to be lock-free, so we did not choose the solution of
adding a lock at the lower-level driver.

Therefore, we recommend adding locks to all three calls to
driver_match_device in the upper-level code to ensure consistency and
prevent modifications to the driver_override field during the
driver_set_override function call, fixing the data race issue. Based
on your feedback, we have updated the description in v2. Thank you for
your discussion.

Regards,
Qiu-ji Chen

