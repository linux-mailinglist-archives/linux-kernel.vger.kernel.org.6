Return-Path: <linux-kernel+bounces-175270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614FD8C1D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06623B22A78
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 04:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DA014C5A9;
	Fri, 10 May 2024 04:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuJ13vB4"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5AE14A098;
	Fri, 10 May 2024 04:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715313780; cv=none; b=Y4xtAYnSox1R1npq4TiCxrK4xGLPWBzAPJ3+0w9dAxQqSsvLohCQTUmiTNkdSS4mQ3B9LVkM0WZeYxtQh7A4LK40WdPXDT992liqbiwuHz25+L1fiHxtJmqHF+nPpEGeqsjCPiuQ2VUUFjpTP9JEGQPn4obcdcRJe+RYk3zhmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715313780; c=relaxed/simple;
	bh=jvSmy0FOqXnRlpmANSVHSxZbSvwbfOidyhPqHt9kz0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efuQ4ctE4ewoxZpq2uC6L0SgSCXCOzIevJ/uUSOjVyTAHerP8cuqZ8Sslfe9b2s03MjkhNyZMhyQsnFKG6/PzV9MYpDmDkdP6rcd6+Wp2Mh8KMGHYgJGte5qbQUOEeciCQSehrYVZnQHAnQRKbLACzCQP9Nn7aH7aUHEIhQpGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuJ13vB4; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36c5eedd124so6777535ab.2;
        Thu, 09 May 2024 21:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715313770; x=1715918570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEJsQFf2xgBkjpapTfqeer4vWYgNIVVXGtaAWZEXf5Q=;
        b=kuJ13vB4G2VWJVwmeubBZsY001g6m4EbbqZAmb7qKeKqRftjVE51Xvv1JZybsC905b
         O+ajYibx9y9bPrUOXWXsFBnDXLu8JIFn0POc3n7zp/KdKMGpdE0UZz/tNcytkMoOnxgg
         mZf10acfZnqvebk5F0GsTZA1Oh1OLx+Hv07t2PbvBOWpPMT6CCA4cH18zhrOki+6jLgw
         YcnBEFm1qn3/z4g4gMEmzvp/dRGpAfLi43CC0f62SbYcA3PgCgzRcPK9W1N1QmTTr/Uz
         1kNk5cuzTJ4/B4/XX9TmIGE5BrEo30piASJrO++6ahjYn5SbLiEvf1z7n34Qv6M2n8gT
         7/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715313770; x=1715918570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEJsQFf2xgBkjpapTfqeer4vWYgNIVVXGtaAWZEXf5Q=;
        b=FrejcXdxugf/02RyFF3sMn6nGs07+KYDE/jK49ofWD5m68nzBjz4JM+lFjJHKIO1WT
         Hav/PVSEmEE04nAa037DdHvosedO5Z4zIN4LNfcyrFovNCHPKFsr1C3EXXbSdOgpDGmX
         H9CIxDrO8mRZ630webACmLaTNMC3uj+9cWYY6MGRsWCdBu3G+oOKrN3jKfuE8evbGdW+
         aBu9YjtvZzInQ3qTRKTgtNLlexzEx6Mfg9dae7Dq0aXrHSgT6Qicaepi4FdsN+RgQS2+
         Hodzm1hgg4QhqBPKthM5S38H6ZW90wFxYe41eHIH7bYNBTxi0PKJncDFOQ7Bz329Ekmb
         xvlg==
X-Forwarded-Encrypted: i=1; AJvYcCVLlXG/rgPCGBglnZV7p7vpr36MJFJQZAA9wXhjkOOBcma8b6VQ4Ge90wKThEDO7Tu1ugzggb/+RnuFDMRcVsysFTDMMS7o75iBxtxvuLJlF39HjyGNKtE3JE6HIibdnsC+dTIDRhiXVCF0rp8UlcKBooUXWa+4dNjFvrFeLOCfNzx9AA==
X-Gm-Message-State: AOJu0YzI9o1NY6ec86X0kyfC3UWNTfu5QHXRMq/tVeet/R/ltRCW44fH
	BHsirDmgXznCOheGXQ7gcdqoQwv20s0i8R4wVj6x51Mwfwcu2bPOeYSdGcDM1yUg1vTfRlBpJ5j
	QEV9I4fXck4oDWhVnKPiTNM0aLek=
X-Google-Smtp-Source: AGHT+IF/DRHYkgq9YNV2uNigtRq8cxq3EAkCVJLj/pteVRJ9Grp/Sf/n2cJ8GF/Gh2HUaqN1IhBXSRvg/7uJWGVE1Uc=
X-Received: by 2002:a05:6e02:1909:b0:36c:f0b:4f55 with SMTP id
 e9e14a558f8ab-36cc14f7bcdmr18846195ab.26.1715313770452; Thu, 09 May 2024
 21:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715219038-32453-1-git-send-email-shengjiu.wang@nxp.com>
 <1715219038-32453-3-git-send-email-shengjiu.wang@nxp.com> <0d10a689504be61c50b186d89ddbf9d1.sboyd@kernel.org>
In-Reply-To: <0d10a689504be61c50b186d89ddbf9d1.sboyd@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 10 May 2024 12:02:39 +0800
Message-ID: <CAA+D8AP9uS1ePxSeSUPGCGe42U5sNguZYQS3d-9T305d2iVbhQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] clk: imx: clk-audiomix: Add reset controller
To: Stephen Boyd <sboyd@kernel.org>, p.zabel@pengutronix.de
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, conor+dt@kernel.org, 
	festevam@gmail.com, imx@lists.linux.dev, kernel@pengutronix.de, 
	krzk+dt@kernel.org, marex@denx.de, mturquette@baylibre.com, peng.fan@nxp.com, 
	robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 6:04=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Shengjiu Wang (2024-05-08 18:43:56)
> > Audiomix block control can be a reset controller for
> > Enhanced Audio Return Channel (EARC), which is one of
> > modules in this audiomix subsystem.
> >
> > The EARC PHY software reset and EARC controller software
> > reset need to be supported.
>
> Can you move this to drivers/reset and use auxiliary device APIs to do
> that? The idea would be to have reset maintainers review reset code.

Thanks for your comments.

This is a minor reset control only for XCVR devices, two reset bits
are accessed.

If we move to an auxiliary device,  we need to define a new header file
and a new driver, which will bring more code size and complexity.

So is it necessary to separate it to another auxiliary driver/device?

And add Philipp Zabel in loop for review.

Best Regards
Shengjiu Wang

