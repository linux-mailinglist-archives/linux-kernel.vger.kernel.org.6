Return-Path: <linux-kernel+bounces-264469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AFD93E3AD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 08:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99ED0B21373
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 06:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E4D8F6C;
	Sun, 28 Jul 2024 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drDUwrk5"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AE36FBF;
	Sun, 28 Jul 2024 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722146675; cv=none; b=ph1rqRagYmq6CHDhH2UXY+aobzDi7KF3ik8FxAZHJzDb6mIOLqvSZbEEyCb7rEwFe4yvpudDlDsILIwvEgPwZ93//dYtmnYHTPWO4cL+COPzhABOPQgnbTQhDli56R+luJo8DQB+EgCkBDA60FNWKjcfdjZbeFBr+Pspj6E1MBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722146675; c=relaxed/simple;
	bh=4GWdobEyutHJZEq8zQCHLN3KSJ0t/3ASAbTPtWju6/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7Dv4vdt6R3UX/AI3Amvt7of0BLrAcunY/Sc2gKmUH6tfxieIL5MNvNJswq+T1QRcAPTnO9Xun8cWSOvi5WjoOlUpkquZ5fCW7ZRma3BU8DArzx/aNow1uXQNGcBXqJGZFWFNxnKzmIl5Vr6WEmQ+Utu6qNAJOInBWk5bwrl98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drDUwrk5; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5bd1b79cfso1438100eaf.2;
        Sat, 27 Jul 2024 23:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722146672; x=1722751472; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qozs986pYe80DxeGUOBNFbNUmy45JcIGCK1M5NpYoy8=;
        b=drDUwrk5o9wTSbugpwATn+i3ipol0sKBdJhK3c1WefYEQ+8Q2AIjdHDbJKS6zyFJws
         QOPj6j6trXDf3U99LBPajIWm5rM9mTLnqKHzFtPrZr5uB8u1vQsqcZKzaC89S3N/30T4
         kS5CSY7IGGpkKqM0AYVCvBQMvCR9ZXnBBGo4exDTvHKaxLWCmHrVnYhVSX2ukgiaHPRs
         XZM54YEwkOJZX3L8vW/CHwlaKHwW+TrR1lcD6U+zRt1ftZU4tSKlTFs9/7ckOvSXh/cz
         Gl/E3XKoBbpQQcmhE02ud3vaRnap41pHQJ4jKayB2EgpfxnHMATxMmD2LvDc/uShV+Xw
         z4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722146672; x=1722751472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qozs986pYe80DxeGUOBNFbNUmy45JcIGCK1M5NpYoy8=;
        b=JACRJHKtQR4ds1HYWKJ2rI1DDqkDdBHuApxtbTwzDFSB+ofHUPIr7X1ePJa6/2tDIh
         DeoGE3XxPdq/UE7vzC8p7rkpHNaRykvFjL6t9z0r+qpCC7121sjB4+hZns5sPefKdMEg
         7o018h/UEeRDD9EnuhZH9O5UaIcJfpP6J+bACEu+A+/RvdVlNkn284PJR3fpMw1OXPrt
         F+AesQBkCL+U8jASGvUETbU1RldoeFSd+ol8fAJpt7xnbAp7dz+dw9TocWylBuOTXlOZ
         75+8Ez2TA7Orim7jNu+6xpYfzckqByU/5tsHKyn1qJt77+2d6sqigpnWiUFbQoU1nySj
         mJqA==
X-Forwarded-Encrypted: i=1; AJvYcCUNnGh5GQ/7SBWmbsu3udH1bgsoKkIQNB7N+mg+clxFztq1giaH7w+xeN8vPw8iBqdNz6PD1YiXtH2aa6AgrnuPtf4BZ4jFUJdxOC9aIPzxxPbddKC0bfTaqLg5wL9fJkQWa8QYTEECmA==
X-Gm-Message-State: AOJu0YyGtmd/ZDMkhxrIQPZEWmIp1PuDRYx/1+ZnT2lAdw6fhbZwQHXf
	k4AUQlPPPXXBOsfhXb7cqg65B7YmQh62xzg1AjO1kLzTrMl2W/wejw70a6Y57Qp1X0IpNexzkeu
	QCNictP7kiUgMngsOo1Ad2mN/DBw=
X-Google-Smtp-Source: AGHT+IFUx0cj5stss3upvImOUQ3NbPuipyGA5McUfIrrMjRS6EZCNe5+Sj1wmVYTsz8K0LwOQKI88RKQsJ32OvkTHcY=
X-Received: by 2002:a05:6820:2229:b0:5ce:6671:de2f with SMTP id
 006d021491bc7-5d5d0d8d1bbmr4523858eaf.2.1722146672567; Sat, 27 Jul 2024
 23:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726110050.3664-1-linux.amoon@gmail.com> <af63314cbac4cae4ffc84606024f9795@manjaro.org>
In-Reply-To: <af63314cbac4cae4ffc84606024f9795@manjaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 28 Jul 2024 11:34:17 +0530
Message-ID: <CANAwSgRUeHm+LrCdgwjENB_wEPs9ftCm75Ezap=hUE5kCWRCnQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] arm64: dts: rockchip: Add missing pinctrl for
 PCIe30x4 node
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dragan,

On Sat, 27 Jul 2024 at 21:23, Dragan Simic <dsimic@manjaro.org> wrote:
>
> Hello Anand,
>
> On 2024-07-26 13:00, Anand Moon wrote:
> > Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
> > signals. Each component of PCIe communication have the following
> > control
> > signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to
> > generate
> > high-speed signals and communicate with other PCIe devices.
> > Used by root complex to endpoint depending on the power state.
> >
> > PERST is referred to as a fundamental reset. PERST should be held low
> > until all the power rails in the system and the reference clock are
> > stable.
> > A transition from low to high in this signal usually indicates the
> > beginning of link initialization.
> >
> > WAKE signal is an active-low signal that is used to return the PCIe
> > interface to an active state when in a low-power state.
> >
> > CLKREQ signal is also an active-low signal and is used to request the
> > reference clock.
> >
> > Rename node from 'pcie3' to 'pcie30x4' to align with schematic
> > nomenclature.
>
> I wonder why the three patches in this series cannot be squashed into
> a single patch, because they target the same thing for the same board
> dts file?  I don't think that having these three separate patches may
> help with possible regression tracking in the future, for example.
>

Ok, I will merge this in a single patch.

Thanks
-Anand

