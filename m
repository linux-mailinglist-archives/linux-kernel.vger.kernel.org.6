Return-Path: <linux-kernel+bounces-383474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AF89B1C3D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 06:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1859E1C208CB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 05:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88146383B1;
	Sun, 27 Oct 2024 05:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwvXzpyR"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127944C76;
	Sun, 27 Oct 2024 05:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730007116; cv=none; b=ILngx2TER4qxrV8MhAIS4k+OSwD63YNEgJODb/PsVC3cq8lZKOaHf3NaWt6Xz5Mo4Q5XzGutYlSUJKqsrGgLMsXM0U/or45q79ihhXCLYM8IU+MLnBYoqeJq2btLgVlilDeYI2/Cun90jkRQddccYrsm7ZT2Cq73ln/wrFPCHW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730007116; c=relaxed/simple;
	bh=3sEEPUKtak+1qroOEce11kt9XYslJMJOCYdTtc5kEKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoZAox9ciqj4yH52YHvN7mtLrygYrUEBLxMbbTj5LeXROB+x94ivsLvBjb7txJRO/fIoqI1mF60sAs6UussXngO3pLI5oe+abcsdLNYJVmhXr/1SCl1AxGCPiWlsQnc+xxLLL6o3s1i6Urd+R8oye7iGWAeCveLMmf2NMG1CmKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwvXzpyR; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbe53a68b5so24356986d6.1;
        Sat, 26 Oct 2024 22:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730007113; x=1730611913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbeeXNHr+vhPzWEsEYv1uu6Nq6GjINj2/F0M6C/S/mk=;
        b=dwvXzpyR7/JhnXq4k8Fz5J5mCbepPTLOkWMZApxFNlukgIKsPedlLf9euPxVvWnMe5
         gwE3OWI89cdP9od169pI/GPpH/AphFdpTvjol473ctMGEyo18rABoYDiIW01jvIHj1/1
         ktzKNJ+GGqGOrG8KpShjm6G29iSnCGpNPgIORuTm8lpdpsls+DuT1bQBBPRxoMHfGI/m
         BVcJ5HTZ9KbpMPyIX7t4b4z/M//pmBIKTBeyqJYHFnU53J8rsjddpnqqjxq2auMwv4mq
         UOli6MlNUkhBAuFXnmpCmZvk9B8ZDwDILFs0nydLcQxXWXQlGNbQT7sE4EjgXrnc4BP2
         VYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730007113; x=1730611913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbeeXNHr+vhPzWEsEYv1uu6Nq6GjINj2/F0M6C/S/mk=;
        b=bytptYuyfeFqv4DPnc3cw795eE3wnQz7DoIGq9wD3zLydXDk5MhZuGsFph4+VDtyzJ
         CXaLIpVRwVUqFzH9Ev5sGelP9qvtETb96TaIs5wKOUJ1WKTbuQiqa1L+NhiJOmt0xLEK
         maadAwuQSbObDrYZEB2lo2oBY4dZFUXsyD7tMnl+xd7gZSEP0ohOma7+Bmf0iYnA+HPL
         20Xk0e0ZH+4lLv2G+VLEGEmg0rqNXZGFKlIrjnRBF4VTC1T4EEPmikCSNVVDVy8BbGUs
         a5MxhY8rGzycgg6EglXiWmqbJEIAryFmSKuKpjjwLt2WNtYhIgvyS2/Rc0NxVdJJYeAo
         iWAA==
X-Forwarded-Encrypted: i=1; AJvYcCU8337IRliEnJ3x6ZWq8pnyOpIxc/UjnAQlocDDbFR6UR/PzZlLyqc46Xsc0I0gUt66l9MegkwNKT3g@vger.kernel.org, AJvYcCWHWAV9SCuC78ILVfampK4ZNQWQT66+ddEM75Xrlsggu19vWyPZM6+gzDLbFFGJsn8QDUP+xOAovee28Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbkuTGI6+CuhM//iN7zMnPKBEio3vXO6FthYh/8irlkIJaDteu
	O7yX6RahRms9Zrqe5LVthrKvcvImLXZFvxMHkMAlRaXJ352kKnW2N09HE13v5M9WxzWt11dSLFt
	7rntkvwioGceTZsObB3CwxvMehnY=
X-Google-Smtp-Source: AGHT+IETbcPLglJuj4RWtzcTD531Q7t6lTfBIXEerufv3+DoIy0hscVg65OCJPnwZJvH57o9rGwkV3VilNQ76El8K5g=
X-Received: by 2002:a05:6214:4890:b0:6cc:22eb:4508 with SMTP id
 6a1803df08f44-6d18589b839mr76937336d6.47.1730007112668; Sat, 26 Oct 2024
 22:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026080535.444903-1-akinobu.mita@gmail.com> <baf87ae4-b9fe-4b6f-b4bb-16fb66492224@roeck-us.net>
In-Reply-To: <baf87ae4-b9fe-4b6f-b4bb-16fb66492224@roeck-us.net>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sun, 27 Oct 2024 14:31:41 +0900
Message-ID: <CAC5umyjs7ZB7VBUgTN2N_uOukEunko_ZqboAaoqsgcRr8O+txQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] hwmon: (pwm-fan) add option to leave fan on shutdown
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B410=E6=9C=8827=E6=97=A5(=E6=97=A5) 1:19 Guenter Roeck <linux@ro=
eck-us.net>:
>
> On 10/26/24 01:05, Akinobu Mita wrote:
> > I sent these patches a long time ago, but I didn't cc them to the DT li=
st,
> > so the DT bindings changes weren't reviewed.
> >
> > There have been a lot of changes to pwm-fan since then, and I've update=
d
> > the patch, so please review again.
> >
>
> What changed ? Where is the change log ?

Sorry, I forgot to write the changelog.

Changes in v2
Patch 1:
- use device_property_read_bool() instead of of_property_read_bool()
- skip calling pwn_fan_cleanup() when newly introduced property is set
  (Since pwm_fan_disable() call in the shutdown() method has been changed t=
o
  pwm_fan_cleanup() call since commit b99152d4f04b ("hwmon: (pwm-fan) Switc=
h
  regulator dynamically"), pwm_fan_disable() no longer exists.)

Patch 2:
- document the new property according to yaml format conversion

