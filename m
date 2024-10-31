Return-Path: <linux-kernel+bounces-391094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C422D9B82AA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B65282ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB8B1C9DFB;
	Thu, 31 Oct 2024 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hRI1Ybr1"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4861C1AB3
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730399747; cv=none; b=B+h9cYDfWEPGWzrXuuoJctYsf5Pvr9XAYo5jn8L3lcWh17IXr2OCSESdbxldXf4KWjxJE8bwhzOAEMV2v+aWYq/q7O9Mre8q44f/xN9/TzrVVhSZ4l7O4gScpmwpWSV9c8ySrRkQBV+0nrCjNk1J+tT8pWn3wwbmEa9bp7+orlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730399747; c=relaxed/simple;
	bh=jg7VAD2aVLnFNu6KLQ/pbomFTgwL24uoZAQdht5T+Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPBCqt+zipgTymQ8P+5gcaDyB3Z5BBKlvAEF+2jBj6hqImNlm39qVYvFCttsX5KTecUQ9tPNp09l8N38Q7/zLZM1WTn8+SW86tdXQ5gfPk6fSfIgmg4A7PIYdDDoULb7P4N3+ThAooMXCOvt6cBKvFvjFRG4zBsrFcuu0gQPNPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hRI1Ybr1; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso904277a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730399744; x=1731004544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=clclPZtCVo76nq6JvC8BRNLzx95l3mSozKtIXOlYhOw=;
        b=hRI1Ybr1SQd1XwWQnuCqPcvvdwYkGa5W5E4hINhWiYG6jGj3lGpq5i6Invjb2J8XKq
         wSzbsT7r99lCZ0iYJw/bp034ERDFF5orKc0xiIuq4fLy8KS0ChwqgSDOEA5FJfybJAoq
         0sLW3bO75cVJ3U0KMhe+lz2oY4cewfBGxxagY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730399744; x=1731004544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clclPZtCVo76nq6JvC8BRNLzx95l3mSozKtIXOlYhOw=;
        b=N7W81yC7i1Oj4Pvuohv2DlM9Se0/A5lvsSx8IrY9bPJyc2QtBzUd84wI9lMoO5oMRm
         VgafHqyuAdZmg4MFt3HyLTCUwbWBkbYN3pwVrkSQNQcRC5HhaxZmESgEMnrC9rlFB9R+
         jFC+3h+P9sKOVd2BZuyUbMzU276riOxlXpf0xp21e6xkzl7oS1FninuJlya/i/VWhftz
         ilYktW6wkBoMS/gjd5DLeFKJZyL6C/70yJvm8H3cI+MX5DyyKUPKSnOnYp2fzkngFA72
         jjMVXLByeOL5T/XV0eXK03o+GxEO3qLE6FsAsB9T5Fm2/ZlYcT0egFYViS4vWEkGZ4VR
         w48A==
X-Forwarded-Encrypted: i=1; AJvYcCUNHSNjqUagrMcxXAFv0uuol8bCKdmX6aWfP5Zylky4NVDS9PI8B2R4VBGEBqogGkLyLY8rrk3qdq/bD48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSTA4DQ2lOQ8R40BcU43kJiVQE5vLEFGZP4jL826GPta+Wglq
	9XWYs5NivV2J3CuFnNx5sUkXY1QA86psm0OQ8s6jvMN3wdHt6RNh9JLkExHPJGfPYUW4dIDjYEg
	7e69k1kMSdL6yOEAa1+XdVq7wcfufy4A4Cwxz
X-Google-Smtp-Source: AGHT+IHW3PtgJ+3707l1WWNfcjCY4eO8OMoynAIZzOQokfTKBfjzi20ckAen6vyMcZjlYruukCT5PSDTi39c9efruUM=
X-Received: by 2002:a17:90b:3b8f:b0:2e2:878a:fc6 with SMTP id
 98e67ed59e1d1-2e94c23101dmr1451727a91.18.1730399744517; Thu, 31 Oct 2024
 11:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030213400.802264-1-mmayer@broadcom.com> <20241030213400.802264-3-mmayer@broadcom.com>
 <c6b02317-e65f-444a-906d-e56f33dac9f4@broadcom.com>
In-Reply-To: <c6b02317-e65f-444a-906d-e56f33dac9f4@broadcom.com>
From: Markus Mayer <mmayer@broadcom.com>
Date: Thu, 31 Oct 2024 11:35:32 -0700
Message-ID: <CAGt4E5uqpv-gzRa4B5av_-f3n9rsuwVKs3H9T8ndH1JSXLsoXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] hwrng: bcm74110 - Add Broadcom BCM74110 RNG driver
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Aurelien Jarno <aurelien@aurel32.net>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Golle <daniel@makrotopia.org>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Device Tree Mailing List <devicetree@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 14:41, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 10/30/24 14:33, Markus Mayer wrote:
> > Add a driver for the random number generator present on the Broadcom
> > BCM74110 SoC.
> >
> > Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> > ---
> >   drivers/char/hw_random/Kconfig        |  14 +++
> >   drivers/char/hw_random/Makefile       |   1 +
> >   drivers/char/hw_random/bcm74110-rng.c | 125 ++++++++++++++++++++++++++
> >   3 files changed, 140 insertions(+)
> >   create mode 100644 drivers/char/hw_random/bcm74110-rng.c
> >
> > diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> > index b51d9e243f35..90ae35aeb23a 100644
> > --- a/drivers/char/hw_random/Kconfig
> > +++ b/drivers/char/hw_random/Kconfig
> > @@ -99,6 +99,20 @@ config HW_RANDOM_BCM2835
> >
> >         If unsure, say Y.
> >
> > +config HW_RANDOM_BCM74110
> > +     tristate "Broadcom BCM74110 Random Number Generator support"
> > +     depends on ARCH_BCM2835 || ARCH_BCM_NSP || ARCH_BCM_5301X || \
> > +                ARCH_BCMBCA || BCM63XX || ARCH_BRCMSTB || COMPILE_TEST
>
> AFAICT this driver is only present on STB chips so limiting to
> ARCH_BRCMSTB || COMPILE_TEST should suffice for now.

This is now fixed in my tree. I will resend in a few days.

Regards,
-Markus

