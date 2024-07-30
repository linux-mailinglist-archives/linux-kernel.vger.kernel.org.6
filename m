Return-Path: <linux-kernel+bounces-266850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 504D0940880
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056481F23D31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5538418F2C8;
	Tue, 30 Jul 2024 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP10ojf0"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C0C10E3;
	Tue, 30 Jul 2024 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321596; cv=none; b=GY97oBg881wG0yU3ZE2lPu68NGRRJYNE2MtmLTr9AID2Jiwq456rrRJgeoUD4NWdC7yfbxin4Mw37wRb5iVVulwn/o/BibsQm0oDueE9ZZacgg2kS1I+Uu/kLummKhubYStczh5K/FbAPUGxB3YD0kWrhG/YGvJ1xttcADEqzu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321596; c=relaxed/simple;
	bh=+xtUfjH7KBTL75kox6rhnJ5bWZr33hb+FK2ewG5rRcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0BwNwqC1AYV74xRUxxe4ZR4YSw7LsO/556Ood2t5E6yMOAb/VtmM/G8B0MbeXUH/Wrl7hjUHjJCNMpamUeniX2SXlOLTEFALwObirUbHPFWbRgpajF2NtfDCRC6zdPc+gPy+F6MDcpOTuBoczlh6x5hxp8OSDquoUkFk/DMdME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QP10ojf0; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-80a2939265cso156078139f.3;
        Mon, 29 Jul 2024 23:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722321594; x=1722926394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjnAIAiT/lsg9NJmkv883qSS5p8X2M+ZCJHCHeUKx4k=;
        b=QP10ojf0+Yj1jzmKZ9eymmuB9i5fhXam3EmYLlBSTTKosfucryyylm3vDmFcAHbGlM
         huv/Kqq+dPUno42pgzAySvAO+6VhR70GNKl5FI9BsRkJNRFnZSLD6SJSxY8jo1uMZdEH
         TBofwzLc/L35y2XpA4tpSn52NNuYW95txB/Ui8GFfe0WT19wQpMYVIHZ62wRSOhnFdSE
         16lY/78nkgDedgYWJpFzl/mqFhg8NcOL1Fmq9Phgo6y6u5Zsp35Y/CInXI+ckreAXC8K
         6q8MNxp98rC2nSSNPIOnuZGAqIOJchzCAyLHVkfvUued9/2Evf1p+zt5fKBgYO+aRDo9
         G55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722321594; x=1722926394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjnAIAiT/lsg9NJmkv883qSS5p8X2M+ZCJHCHeUKx4k=;
        b=FyCCKzS+mIWqsK5tA+8kRrgNW1fG6HN3NoT49kbgCMEakW0zBSr+iKG697bxPOt1DH
         1QfhtWFnqxYU1Cj4E9gxNpCyHp1u1JWpookWxQBZgsuOrNx9Rv/Iz5d/Vi33hSRf0K5T
         +oj2iLMaHOI9mbCLcx3rl3x/2KkA8wpdWvoxYKyawc8oHa53mq5NUwgSM1NOJoKEGGeH
         73a89za1kne2rZQsd6fROD+w+o5LFweXEpslc2LBqkNUO/OQ3Uwd36NnoTy3ufE8Vipp
         DUEE4iABaCA/xGA77ysfcIS59IQj/p66xzom+X4pB+i/wFBqjdY4ZcVIuFjIXItr5npJ
         xm7w==
X-Forwarded-Encrypted: i=1; AJvYcCVRZFgUApo/TcllJtV8bwlL9Att02gLVQyfqoz1JfPyE7mvbETdyr8nZPLYYo8ERD2DZ2oUnunk2XdENaiNST9/HpbWQZ6A5fviNgtQeDenByGIUQzybYL0/XARqCMwyqD3UwKE4Za/uJ0=
X-Gm-Message-State: AOJu0Yz03cZr3+zKETB8ON/qIgW0lDfM8CL/9P7pMSEQrmU43qt+Yp3R
	BSPRujLLVNg2/fBtIsI2azMzk7IWt2A8FWjuDaZddJuCC5BuperEIM5K2dhOLr1PZV3oODO7GgA
	XvYLvu7Z0JTAiR4zIauOh5D6Y/z4=
X-Google-Smtp-Source: AGHT+IFYxEb/vGr8cSYDE0FixzUoIYxeKUCmDQvP0QatjRnL53gTAC9rwsUtpA3Qy3vX1HloNIPuoFU4yVIxRVxJgoU=
X-Received: by 2002:a05:6602:2dd2:b0:7f9:59af:c26b with SMTP id
 ca18e2360f4ac-81f95c2ddf6mr1074320639f.17.1722321594178; Mon, 29 Jul 2024
 23:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727170604.9149-1-eugene.shalygin@gmail.com>
 <20240727170604.9149-2-eugene.shalygin@gmail.com> <8b2949b0-63e0-4250-a313-9664f714c4b5@roeck-us.net>
 <CAB95QATwU=P6m1vub18PcuWty1eKGkM5aGMfuuWZPD9LyAcd2g@mail.gmail.com> <6b0a00d8-6357-45d1-972c-0af438868991@roeck-us.net>
In-Reply-To: <6b0a00d8-6357-45d1-972c-0af438868991@roeck-us.net>
From: Eugene Shalygin <eugene.shalygin@gmail.com>
Date: Tue, 30 Jul 2024 08:39:43 +0200
Message-ID: <CAB95QAR_XDFm5iHObfHzFcAEfn=r=WQ7npe5+RfYPU6A09ziKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] hwmon: (asus-ec-sensors) remove VRM temp X570-E GAMING
To: Guenter Roeck <linux@roeck-us.net>
Cc: RobotRoss <true.robot.ross@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi G=C3=BCnter,

Thank you for all the clarifications! I learned the author's name and
submitted v3.

Cheers,
Eugene

On Mon, 29 Jul 2024 at 15:49, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/29/24 01:20, Eugene Shalygin wrote:
> > Hi Guenter,
> >
> > On Sun, 28 Jul 2024 at 00:09, Guenter Roeck <linux@roeck-us.net> wrote:
> >> "X570-E GAMING does not support the VRM temperature sensor."
> >>
> >> would have been good enough.
> >
> > I can easily change the commit message, of course,
> >
> >>> Signed-off-by: RobotRoss <true.robot.ross@gmail.com>
> >>
> >> Hmm, that very much looks like an alias.
> >
> > but what can I do about user email? I can ask them to provide their
> > real name, but they saw your email as well already...
> >
>
> Process explicitly says
>
> then you just add a line saying::
>
>          Signed-off-by: Random J Developer <random@developer.example.org>
>
> using a known identity (sorry, no anonymous contributions.)
>
> where an alias is clearly an anonymous contribution. You could author
> yourself and add a comment along the line of "originally from github user
> RobotRoss".
>
> Guenter
>

