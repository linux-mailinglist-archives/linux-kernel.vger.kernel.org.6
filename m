Return-Path: <linux-kernel+bounces-557790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D918A5DDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAC6189EDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1649D4A01;
	Wed, 12 Mar 2025 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cW5znQm+"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45DA33EA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785510; cv=none; b=THHGM/ElVXsu7W4ZLmu1KKzcXxrPop/dfz6BF6S5e+IRl7GUR2zGA7Vv1FBvTaQp9L+YmDB9sWaORstBOH3yKJhkCXxqbMr+6aNLER2QGFEulwnRax+QMe/NFIJpV+BKPbVpwe2XE178062AhejbHKdBciITUZgNPcBd7tdVSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785510; c=relaxed/simple;
	bh=O06P188+t5IkMOcphaknKbtZTwStMyYbeSy3ILdznBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/TY3cd9aEvY/oQ+5j4DMf8bG+unzH+0HXBtMnld9j6LxxzFbzUVZsX4AQVF/LzxcCp+/s4485h8fdgrMom9WxufhWHiIJSGQbmyYcv6Upsjskv/+3nP6hhv/WCVivbFptE4xilg4fSGQhi89Y6Vvw+CALCxMxXmrFeWT4Jj8Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cW5znQm+; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f77b9e0a34so56494467b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741785508; x=1742390308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O06P188+t5IkMOcphaknKbtZTwStMyYbeSy3ILdznBw=;
        b=cW5znQm+YxZyBL0gizrTuUF7/JJWjsLGDEk+z/sV+cjcSGsUCu8y/P2ZUjtL+Dn+9v
         kZaEGRg+7q8kh6gssOPWckEfU6p0QQ2BECfUL0BANWwotvHE5nLPRKj8uJmH4oL94gO1
         Q4d02SZrn3bpjd1rEOGRW9+u9slnGvIJrgxYNf7MzDNVo1BmFZI/uqls+OMg08dg+uh0
         a38xa3eJ1Ce14K0G0i8K+telHcyS+KfLV778SzDMVeG2BklzKh+iXEaKCqTj7GvGv+HO
         c6k+gg60Dstgt8D17722d1ERF/C7FWZa/NHd8To2yxIpgoIzqeY2A7Df1HusIB474MOc
         QrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741785508; x=1742390308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O06P188+t5IkMOcphaknKbtZTwStMyYbeSy3ILdznBw=;
        b=RGDfdJbCYR5s55SCtpWUz/Pm8RgrRIXPwHzg/J462SKXQtPEcm9Yle9aUkPlXOh5PM
         Hl5J3GMAdTAmbXwrE8WnNez4C6JV5R0qrlSemRNyK/9gAS/tyLYPxGWCF7eVimJ4eAK0
         ynD7AD/gxc9XsxhOA6z4pTsG3BbTdNe1I07mnLe3MbRQ0c8enHS04meYvyHtJ5U5kCje
         RCtL4PNuksbqDlFWMkCO64vpQqutSt8rnLFWZMMVcvjnw41PVKmAU+xBJpRL9siNY6/G
         JwSA3QG3udsASiLBA7WEFb5kZwfmarrPZFxd0djO7KiWSCDhnF7kJhmPXP1YwH03OdOt
         qHLg==
X-Forwarded-Encrypted: i=1; AJvYcCV19oGWTBeHq6XB6DlKN1CXmTlK4ytLQMHm6U9ZcG9apVBO5NwgacYAGFu/uis/yaChGbblmR1+UXP/hTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzztjfzQiZraGnzB7i9GnnXdBlp2inQkre4najaxRjQ21UIS7KU
	Es0RQbk5frn0/ajptAOA8LWNgA1xBuVeUQki3uY/msS5JhIC1Ul0mwopoUYFg01TyRf4z0NZtSo
	pG+SMuxTBhZ/bgAz312KWdGjQlhK7saNyW4MmEw==
X-Gm-Gg: ASbGncuF0kw22HAyXG7KTpq4CZt6dyXIp54xn8F1rZagZzMNq1e8FxX861jeDOxkb5k
	7aiSapxOKbkp7CzFZi86ndfJ/sMwESgwnQwBZtkWKy0uW75kZkQmCF29PyPdjot2+gJbGcBh+sg
	DDBDSVug8ac6Lvba0sifdLToJdx+4=
X-Google-Smtp-Source: AGHT+IGyzl7GwHaLZh3ygs+nju2rxMd7dGI+ZgAL00mTmKBqCqVGTlKAadXsmQ+m/M2fSAfYzFe/Q76nG6skzC09EPE=
X-Received: by 2002:a05:690c:6c02:b0:6e9:e097:718c with SMTP id
 00721157ae682-6febf2a450bmr305445347b3.6.1741785507753; Wed, 12 Mar 2025
 06:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206220940.10553-1-kamal.dasu@broadcom.com>
 <CAPDyKFq1ZbP4c9ECfM1SY+MEopf+dC19w9PkqXaUjevf=bPjcw@mail.gmail.com>
 <115a59e1-75b2-4d09-bbf9-50dfcd2b62dd@broadcom.com> <PH7PR16MB61967C18645C64E582B222B6E5FD2@PH7PR16MB6196.namprd16.prod.outlook.com>
 <d51a9d7a-b942-4c3b-93d2-65b1bb04c8da@broadcom.com>
In-Reply-To: <d51a9d7a-b942-4c3b-93d2-65b1bb04c8da@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 14:17:52 +0100
X-Gm-Features: AQ5f1JqTx3pgXMeqFgFpSDIaSNIKY2an6JSCt033D3YeuQR5aENCOVJYaG8WOzA
Message-ID: <CAPDyKFrCjo8gGnxmXWP6V39N+b1o62VQH9zwMUNb2_+D3-qrdw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] mmc: sdhci-brcmstb: Add rpmb sharing support
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Avri Altman <Avri.Altman@sandisk.com>, Kamal Dasu <kamal.dasu@broadcom.com>, 
	Jens Wiklander <jens.wiklander@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, 
	"bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 18:01, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 2/11/25 00:13, Avri Altman wrote:
> >>>> This patch set adds support for Broadcom TZOS to read and write to
> >>>> RPMB partition using synchronized access to the controller hardware.
> > Practically it establishes a communication channel between the trust zone and the host controller regardless of the rpmb protocol.
> > Or did I get it wrong?
>
> Rather than communication channel, I would describe it as an arbitration
> scheme between N participants, with guaranteed forward progress and
> fairness between all participants.

A scheduler in the MMC controller HW?

Nevertheless, it means bypassing the I/O scheduler in Linux and the
mmc block layer, kind of breaking "fairness" from Linux point of view.

>
> The interest here is for one of those participants to own the eMMC
> controller for a certain amount of time and indicate when it is done
> with it. This is not specific to eMMC as this could scale to virtually
> any piece of HW that is driven by transactions from a CPU, but the main
> application is for allowing the Trusted OS to own the eMMC controller
> for a short period of time in order to do its RPMB access, and then give
> it back in the same state it found it to the next participant.

Honestly, I think this is a really terrible idea, sorry.

Data and communication with an eMMC needs to be synchronized and
managed by a single owner. Having multiple clients with their own
channel to the eMMC sounds prone to problems. Is each client going to
have its own mmc protocol stack, dealing with eMMC initialization,
data-synchronization and power-management, etc?

As I said, we now have the RPMB subsystem for in-kernel access. Please
use it instead.

Kind regards
Uffe

