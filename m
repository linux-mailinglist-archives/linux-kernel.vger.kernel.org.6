Return-Path: <linux-kernel+bounces-560695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C452EA6085C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2285D3BD8D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6156114658D;
	Fri, 14 Mar 2025 05:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=one-eyed-alien.net header.i=@one-eyed-alien.net header.b="lKa9qq8s"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB5142624
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741930684; cv=none; b=qjl2LcYfS0ZYud6ennsCxIx5TsLaHAQUpNoRXLAj/6RKUxPBq5pj9JAeCgsZhrO2QMNdHVUSlY/NO1Rr5mwFEqwFzAcTfx9SPGd+2pBc3/0N0RyQvTjriDED4A5kKd1aE5H3JWn9RTA/9cobSRA2faaQIDvSZ/03n0w+2m/R8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741930684; c=relaxed/simple;
	bh=ITOM/p6bRhx2xML4qWv+gWjXj/DXsfIAYjtEmJN9yJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuWduxjbbuHH1lp6ubKsj86jnaJZMjonDKcrjfZOQnCaKHiyU0SF86Gt9hQmX7R3Uw9zj20A9KWTDGlFVn5tcIqEQLbmrEIoRJxkdB2LwQT1PsBlKPBNfjPYjMF2qYKu3NZRKYIB4UkeNEOhL66IcbdIVYDEAm+C7hpIqu5IWAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=one-eyed-alien.net; spf=pass smtp.mailfrom=one-eyed-alien.net; dkim=pass (1024-bit key) header.d=one-eyed-alien.net header.i=@one-eyed-alien.net header.b=lKa9qq8s; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=one-eyed-alien.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=one-eyed-alien.net
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so11355565e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=one-eyed-alien.net; s=google; t=1741930681; x=1742535481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMdQC/9roImk0s7GMGocgKU0Ea/u69+eAi5KKCuOS4g=;
        b=lKa9qq8sVXBNkdVk/oTnlid1r6MzI+QGdvlwNO49/r+Wlsn2603DQQVcPF4pwKLKnA
         k3s9llr8g2HavSqLMRAcYqqbzuz9PH8QqxE1USHVmwNsRgy/v0MoAfEITLXskESS37Yk
         Yg0eHOnOuGMavb7pKNrW7+jhSrH/Zqj+7TtZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741930681; x=1742535481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMdQC/9roImk0s7GMGocgKU0Ea/u69+eAi5KKCuOS4g=;
        b=mnvzWamAVX+X8QFt6Lyn40WiY/kYgBSHXKrzkvR3zN6mq4rlo4voQWTdRoBYkdtDNw
         w1Hwd5NEL2QYIFMjaFT7Baq2i2tejI1EzoytWL8hZVduKbqqJORtzcVhx5qsYDeqZnE5
         CaHp43U7aNqhrtj9uhyHafh7+6dCTu1GX228iX9GUdOnqLh6MXRA07dm6BzJr0Ivhqqa
         8iCMIjeRP/s4Th3TpiVFChMSmxdkYjsmhkPNUxjp9wlMuDpvLXP4LIDx6/Sfc3ufN/Oa
         VCfWRZ7nd5NT3SNLoD8HyIXulg7+d98r+pYD8Hf7tEkbJXzMDMc3QBRQBKUi13MyxEp4
         yHOg==
X-Forwarded-Encrypted: i=1; AJvYcCWeFEGsdYFVzuPDcxX97Z1HF1UC7r/0+qu9BGkZS/lVmBMVgCXWxzcw1tQQGA5ZmlOgdPpavK8X2268mrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGmdhMkUdG7SKeRgyZYB0tAUTJAaBE10IOjxpDvDAfhtF+Kcpj
	xGAxlKKlgqxzZzgN79920qEfnK40rhtAHcNcZmdK/J3i4OQjcKcC8+iew8xWwULXCAzj6v7FiaF
	6Ovpn/g+bVPAVC7Q2HY8Lcb0Iv/4f/rANk1bzhA==
X-Gm-Gg: ASbGncsC4nu+CxapJ92wUD1OcFLrgvvlobWNNUHgUnzzWc6lazDF7g7u7o8WN8FNfFV
	1om+f2JCn6a0IiP4v+gvfdmIiCCfKCLubexOTIfWtGmCItVXqcw8GkOsHNrJtkWBXNi8bFkgzXb
	JKGcgwJznybmv9Gi5k3tLAVVrKNmUgxiLs25Vgfa5oyLPKdb5jneHob8S6VJtj
X-Google-Smtp-Source: AGHT+IEs3u8e0SIawkS0/fJFih2WrZJWPfOVEeJPqBtFWEdhJy97lW0NcxNn7WmOkK58p0NvgKwBMcEW53Jtx0NOt5c=
X-Received: by 2002:a05:600c:458e:b0:43b:d1ad:9241 with SMTP id
 5b1f17b1804b1-43d1ec7264bmr12970265e9.9.1741930681134; Thu, 13 Mar 2025
 22:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311084111.322351-1-daixin_tkzc@163.com> <2b6c4aa7.b165.1958f6b7a3a.Coremail.daixin_tkzc@163.com>
 <814316b6-013b-4735-995d-b6c0c616c71b@rowland.harvard.edu> <1681f087.2727.195927b7ccb.Coremail.daixin_tkzc@163.com>
In-Reply-To: <1681f087.2727.195927b7ccb.Coremail.daixin_tkzc@163.com>
From: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Date: Thu, 13 Mar 2025 22:37:50 -0700
X-Gm-Features: AQ5f1JqK7mfkFRnnHhbib_ouPOR3RruHwBQMl_f6l0-0E-jlRPVLn-J2Iu35hI8
Message-ID: <CAA6KcBAU75TS348_NNLudMv=Ub=h_K2x9CC3=RfLtRvxKiq5Dw@mail.gmail.com>
Subject: Re: [usb-storage] Re:Re:[PATCH] usb: storage: Fix `us->iobuf` size
 for BOT transmission to prevent memory overflow
To: daixin_tkzc <daixin_tkzc@163.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 7:28=E2=80=AFPM daixin_tkzc <daixin_tkzc@163.com> w=
rote:
>
> When the urb complete (babble error occurs), the sg_complete function of =
urb(s) will notify the mass storage driver that the data phase of the BOT t=
ransfer is over. The rest is done by the mass storage driver, such us:

You appear very focused on a specific sequence of events which causes
the babble error, but we are telling you that you are looking in the
wrong place.

If the DWC_otc driver does, in fact, handle packet babble properly,
then it will never overflow the buffer.

For example, forget the specifics of usb-storage.  Consider a BULK IN
request to an arbitrary device with an URB that provides an iobuf of
only 32 bytes, but the device sends 512 bytes -- the reason the device
sends too much data is not important; this is a babble condition.  The
controller and controller driver is *required* NOT to overflow the
32-byte buffer.  The remaining bytes received by the host are required
to be discarded.

Thus, even when a usb-storage device gets "out of sync" (i.e. is
sending data instead of a CSW), a buffer overflow is NOT POSSIBLE if
the controller is functioning properly.  If the controller writes data
beyond the end of the buffer, then that is an error of the controller
and/or controller driver software.  The design of the Linux USB stack
places this requirement on the controllers.

Matt

