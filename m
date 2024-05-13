Return-Path: <linux-kernel+bounces-177776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2568C4480
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDC6B20B47
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76F2154427;
	Mon, 13 May 2024 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOEtme0w"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C55695
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615131; cv=none; b=euU8/g8xOJZk6aJWC7u61vL8dIJ/xIWPKwJPCDe/U/f606mMbCWqQpkvVG8HAfoAIS3pW3PPsTAjcKVrpg98i45t+1OmnKLr9wLa7DmwJ6VdjBYQk89H+bg+Kx01vqEW49xt2SctRCno7ArVzmA8AfTGPfR1dXauxYHcQH5ChIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615131; c=relaxed/simple;
	bh=5S6kuG3VLf8S8sXUIaE2HzlJHcP1jTSqiOwWEckVbbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmitpHInnHN6CXb+rzRzXJqrJSmfgjdjGbVqQoGVBKYijXjuTo2jb4nKUHFTKF0QegEVOSCBYrqv9ub7FGvdtNg9R0CQPf5Dck+o2LQXrs9OtKFZSTGMy4u5TIbgw17PqNLCXSQMwCwude+I6lo7sLEfeql/yL+OyklCkw85dUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOEtme0w; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2df848f9325so57456251fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715615128; x=1716219928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDk9NS1x1gDHm5igG5CxTgjH+7qMZP0gDN2Ciqlm/w0=;
        b=iOEtme0w6MVNU/kn6VKPyxEwqbGngF/SokA/xHmHR/Qilz1Wmhx/nN1LawQmCEKVpw
         PVw4CNQM/+uYqrMVMGtzMx9FKV193wronYwrO8Sx7XDZ8YehuBWTPP8i5V6xPhEAjD2Z
         4Y8Pa02v+F+CrId6vq3Hv7Lc/R+w3n1mqal4eKpPJWF97MFmWRuv2oTl02Fz97ggBzpm
         lP3IBxZNyosQKwIdXg0wFTqwp5vIWmy/BLktBpERP5s0DLHs4S/uQ6Irnrnh+b1RQRth
         0+DvbKMLLGyNyScFrimIheMszUSmZs4+wBEsblgVnJOPhBGMdTCs9fuKue8YrWuZctE0
         6fGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715615128; x=1716219928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDk9NS1x1gDHm5igG5CxTgjH+7qMZP0gDN2Ciqlm/w0=;
        b=b3KnpOGl6Hv2chHvT1B4viTKkQwP9Q5lIBIVJworS1EJy1sfSBkiMePK/If8lUL6uR
         ng8uz4zVh0qw2kRuhWKWJljtND6O+XCm2qaDOCcf4Zr+z+m5K7vImwja+kCrZ5B9iZpZ
         ciZNJ43C/oBuEybF1ApFoyV3sJ+gPXDCR2RXwQdqkkZMMevw9gvs0beE3EuXjCkdTiYO
         I1DgIw1ytZoxJ6q2jKLZsLGsQO1hq+clcxG+NwxXCIiuwrdfgp5enEMMT4VdB1EmdCCw
         e+iMPqphShudXt2EA/qrekd5mDUd37DcHg9dyGlnuTzOrJx5Dyy+X+7W0HmnrESsgDe6
         l3jg==
X-Forwarded-Encrypted: i=1; AJvYcCVEWCEoRgsmhsGxNIHDfmUWk9iGHzvSPUiWWv5H0q/ay54RI/tkcDWth60XPTBQnC85KdJHtcpqJZEEgtLqxjl7M+TcEWxKwBIJvM4W
X-Gm-Message-State: AOJu0YxhOuB5Yf6LmsuGzu7/6UzFmZsZm432/JYg/GLNOjbrs/QdcqWN
	T3BgDvLVwz8/YGg6AwoYbyl4NBiMmrBmSn8X7yi1ahYu7KKOJPeoCFDqiHT+SxhPJSYlIdXJ0EW
	hqS8+mm126nVaS4dy4MPDguhjP6I=
X-Google-Smtp-Source: AGHT+IHQwnzhTPPIaUiSlkRTMgvdZKcG6Iqwi2h70ikl2XHsoI59tI3a5K7S+7FJ9UG5xTW/4UthZVCaFhkahT+oyFQ=
X-Received: by 2002:a2e:2203:0:b0:2e4:14a0:4d15 with SMTP id
 38308e7fff4ca-2e5204b1e41mr70681241fa.51.1715615127523; Mon, 13 May 2024
 08:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHx5RXBfazB62qpbGGK3_YjwCFbiJbEXrgo88V6qHFdTW1CdRQ@mail.gmail.com>
 <338daebd-b4af-4a0c-951a-ad7f86dc4646@gmail.com> <CAHx5RXAOKBGXRgC8pqEyY3MZGXxj0-vrwnqg_WZqKreYp18dAg@mail.gmail.com>
 <7efffaa0-6330-4b01-b3d2-63eb063cbbb0@gmail.com>
In-Reply-To: <7efffaa0-6330-4b01-b3d2-63eb063cbbb0@gmail.com>
From: Stephen Langstaff <stephenlangstaff1@gmail.com>
Date: Mon, 13 May 2024 16:45:16 +0100
Message-ID: <CAHx5RXD8qFmbEytrPcd40Pj0VRo7uOvZjucrMj6Xxqw73YyS1Q@mail.gmail.com>
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: andrew@lunn.ch, linux-kernel@vger.kernel.org, 
	"OlteanV@gmail.com" <OlteanV@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 4:40=E2=80=AFPM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
> The Makefile has this:
>
> obj-$(CONFIG_FIXED_PHY)         +=3D dsa_loop_bdinfo.o
>
> so it follows the value of CONFIG_FIXED_PHY, what is this configuration
> symbol is to in your kernel configuration?

CONFIG_FIXED_PHY=3Dy

