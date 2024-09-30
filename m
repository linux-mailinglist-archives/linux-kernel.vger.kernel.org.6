Return-Path: <linux-kernel+bounces-344462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DA698AA00
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3103C1C22BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6771D194C86;
	Mon, 30 Sep 2024 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBaQ7OLf"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7302319342A;
	Mon, 30 Sep 2024 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714422; cv=none; b=b19K9B3Qny3bAbKqvA2l9fv/NCH08nemOpvrsI4j2+jQ7g+X+ITf7gNrGWD9z3bux+i00GUdW/eIP4CnrQqv6mUYmIylqxEfwDCeqOKo2atkc+G8jFVReZMRZZHLXnhMX4MukNFK3DPFd4pWcQjwAC+GhE36fFEBhmMmFXZZuOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714422; c=relaxed/simple;
	bh=UrGwORns5gnnZyGdSAE8132QzXkk3dNjhnwiGggVhaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIUcQxscvGfo1lX0ye98FLh6rAHdCP2xoiiZQfzM5kPgNJbWUtSzoDisO2+B7yrC3tp62BWoMc2+kM7v9U2ucw4MrUk+VPWkPYEATSK/XPHWwLt/g/Fj2BoOEDC3ACzmvvc8oouf3OcqMZd47ZhEf/N9ggcPvssp6e9KSJUlaYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBaQ7OLf; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45812fdcd0aso49606091cf.0;
        Mon, 30 Sep 2024 09:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727714420; x=1728319220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0zvel2rpoubHEtpZkC+XLFVe/88duPLHw+2mKVnKTJ4=;
        b=IBaQ7OLfwO0zuagKdkWneXo8yZP0JoE/+zLTiq+c2xJv+/z5AeEEQ3jS7i7PM3XFEa
         vFbjuT129zogrZL3GTk+5wZiAOXzP02TM3Tcsqdc5eKJlktFqQvp/HmPzykbdTNETz4f
         jN1kLoy4wLIvzbTZ4EZKCBkNeOiSN4iAobFvnb8ds9jbqPzyasT20ITYcHXjwFeUR0Y4
         9VTH7sJy2ODEdWbrRKXa8fJRcNnKuvyCUA/si8t9Antw4H4YVGqTQJgtWjnsvkZn02OF
         HWytkqnwLlpJACcKpNjJrTzja6xLrnJfi6qDLhkbBytdCbq8KEFo9s6HxtQYmMP99OLj
         xEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714420; x=1728319220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zvel2rpoubHEtpZkC+XLFVe/88duPLHw+2mKVnKTJ4=;
        b=q+V/g8d6QIg4CV2tnUf4svlDsCmO9dUC/nQNLSgOMbHJyqstCDR1lZSre6rTKlZVia
         /9DKAZg8tu1p+gAx6lSZIeIq2UDPQHV2Sfn1cYO81HROdL6BfXqyoe4N+wnlID3H49Mi
         fQHid8uogtEV+vWPlYfErM7GaQYXBSGAkXJrbmPQaokmrkPBFNaKDdte46GJxoYON8ot
         83Cx5GVIBv2VylqQHZDV69+VhDzTplJ+hdMdhj6HTI3RCpJCB3rHoBCyKGGNkDt3JKfX
         Xl3Fl4tKGKxIHaBxNmIP6dO/zqHJ1kXyHopMqejFztTzCi+c0j1fdnTcOaN0ZlR8YT6v
         WEJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR6kv7aYG07RB+CkadeAKtKYOscseLl8PQQSgJJ4P9HV0mdkJRZOyfYCZlovVCDTZp3uvIx67wd9PSkuA=@vger.kernel.org, AJvYcCW/HZ4Yqq/8eJJw2glvxogXxoYn8ogpNZqM361tDQUqzmg0y9VTZ2UuV4rlSrFP/eFFWXWOUSDFa+Wk/pT6Zjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVtue5dqBed8icn+6gZ4rfj5o5KSE4CXmv/5rX13QMVFoM9FAz
	AA5nmQE2THYeGHqrytqgG53slNmqDMHr8Cu2xBHT36ql8VUzKvBnbvHqeXe8knKsP5GTizV/PHY
	CYBCX34RKtz6NmbjRgVC1ysxKLhM=
X-Google-Smtp-Source: AGHT+IGQMbM++h3zu8cTyJPCZMsG3ZLxFf5wA0K+gkQjoDy9G3EMSlf2EtoNnBC+E0VJJ6gB/kMWAEIylXV+dt0EHts=
X-Received: by 2002:a05:622a:1908:b0:458:29ea:b3ba with SMTP id
 d75a77b69052e-45d73a862c0mr3393351cf.15.1727714420269; Mon, 30 Sep 2024
 09:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930144328.51098-1-trintaeoitogc@gmail.com>
 <20240930144328.51098-2-trintaeoitogc@gmail.com> <2024093044-violator-voice-8d97@gregkh>
 <CAM_RzfbJ5qsHKfNxV1EzhYEDdCmXP0THH=g1MX1yHiRP=9tYFA@mail.gmail.com> <2024093007-safari-lego-45ab@gregkh>
In-Reply-To: <2024093007-safari-lego-45ab@gregkh>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Mon, 30 Sep 2024 13:39:44 -0300
Message-ID: <CAM_RzfakS8=Qr=vThJcW-eX8izBs5Xdjo+p8=Ji7Nf=_ozv0Aw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] rust: device: rename "Device::from_raw()"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org, 
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Was it in the 0/1 email?  I didn't see it there either.
>
> And for patches where there is only one commit, you almost never need a
> 0/1 email, just put the needed information in the single patch you send
> out.
>
> thanks,
>
> greg k-h

The 0/1 email is for explanation the motivations, attach a link for
discussion or issue and too for explain how to test this.

But if you think that is not necessary, I can send a v4 without 0/1

