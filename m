Return-Path: <linux-kernel+bounces-220571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE9E90E3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB6C1C22C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF2C6F307;
	Wed, 19 Jun 2024 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrAPNacN"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BB56F305
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718779896; cv=none; b=U4xVV6C7kV3MPDNWlJsxAuRbejSKPx1fkNsnTnKLIGho5bLr8D38gL9toGUXXCtZ7EAZ7WQ0RpccnuSiDBL9VG35124o0K+QEHlUdHL3ee4XM1pG7Btw9CH0gWh8YeEkpjwXMMedsQPKlDzdpvr651iWKGB8BJLkRmUX4F6P4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718779896; c=relaxed/simple;
	bh=mBhUIrkfuJqS1cLHqmXkbO4tms9VwSebRQxKtyn8ci8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMXRznC+MhRGujifHJ4q18+fEd4gtD+7Gi/6DbkMoJILKgtLOvfcYqv5ARgnRRdnE2/bbsmDOn1lc5amsHIadCBupZKSKovQJHAPw8I2jwDiawGu3qBiivgRSIMGzx7u24tiEBYJWOnSie8NZeGhpiNVsu+aAy3Fqxh8ay2ok24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FrAPNacN; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6316253dc52so48694047b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718779894; x=1719384694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BPD4FH5Z6XYJ4s0wVL640UeHtQp1qf7sTtTQ8uN0s7Y=;
        b=FrAPNacNPu8KseIOGCP4MBqr8W6BK2C0FIU3M0ZeA5pH5ptifmxl6Kj50/Rb+vu1Ij
         KSAX1P6nxCNyqOKlzOruAG+x5M86X8R2GFOEwrOSKXXXfLYfFqUcHkZY0NK6DgTcSDeJ
         kLiBB0PyKzhLby1MAAsQhQaP9E/qIJg6PNGMz2diKgcvP1eP4lcR0KfM7+GEtA30GQc1
         AgnUYD17/O55O1Ackw0vR+J5G7hEwDMOMdxCCdMBbf3HHfDyZPSBjT0TnDOZG5DNpb2L
         G24ucZ8cnaWiZah57NKdjVWe6M4MZwAAkivE8SAwTbFj0Yb5xDBk4jOPYH8TV2O6hHsp
         tRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718779894; x=1719384694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPD4FH5Z6XYJ4s0wVL640UeHtQp1qf7sTtTQ8uN0s7Y=;
        b=jIuqcfGKkaw+cwoQT8lLeOIzPGd2TX+uOvjN4NFIqfhx6K+sQJvHI6dshKbpFzUhwY
         p3C1YepC+fy5x9jqL12ftXk4Fs6BTdU9AWYz/6AEfjQCBUXcF02XhCSVOCgDBAtrj7YE
         fgSFTmBMQBOQZtkWpnWnDr3cu/A0HrG79AKuNnMrQKeLDaNrJ1IIM4WpSJqL5DSiO7HI
         /K2NbmzIV2IPm99gquQTlvVwAQVORtdRiqVv9T21XRJh5M1H0guYpcl1KkRHbheXvoQr
         EuYy7VBJgEZQzthqYLUHUnqhr40slAqCdR1W3hiJ5cEfHc79WCONAAVqrOzpi1ux23o/
         ZsFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw9t0o0GqoShjsVpLmTq0mPgsErjXJxV15BgyVkSquVN07UhC16QDcnnUOLVD54hm3BbcuYlwc5QjHGrgiS/Y2mtnfjOVQqOy3TJge
X-Gm-Message-State: AOJu0YwcGK8d1gkbA8ZqCaxdAmsZ8d/okyLjf/aRDuSETR8skI+fCd2O
	kWnTWslndNAy5kpTzBoKC5ZAMu08Mkz7NOhoaqQaxYgTIwpa6sI3A8n2Upc7/VRG77uNd1Fz3Zz
	N1rRV+HgnVwjnEJa7SddcjKMEnpNmwcm43mdyrg==
X-Google-Smtp-Source: AGHT+IH2XcE/dBnfT1RjnglTzPe2luoK+sxDcwp43Ihj/fpPq/iIsZC1LxBJiupwY0hsNWfYczw8I/tF38tYTVAvwO8=
X-Received: by 2002:a0d:e810:0:b0:632:5b24:c0c with SMTP id
 00721157ae682-63a8dc08affmr17737217b3.5.1718779893073; Tue, 18 Jun 2024
 23:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612064731.25651-1-quic_ekangupt@quicinc.com>
 <zbpia232dh4ojfsvhcqxrp6cwfygaalu5cycdrs47pqmnrisvk@dq24nww26gkm> <00b2c65e-c00e-48bf-b118-4785d216cd19@quicinc.com>
In-Reply-To: <00b2c65e-c00e-48bf-b118-4785d216cd19@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 19 Jun 2024 09:51:21 +0300
Message-ID: <CAA8EJprOf9vvdBcdX=Xem3UMFo2pmh37ooreqRX0Bzvadv_yTQ@mail.gmail.com>
Subject: Re: [PATCH v1] misc: fastrpc: Move fastrpc driver to misc/fastrpc/
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, srinivas.kandagatla@linaro.org, 
	linux-arm-msm@vger.kernel.org, gregkh@linuxfoundation.org, 
	quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 09:45, Ekansh Gupta <quic_ekangupt@quicinc.com> wrote:
>
>
>
> On 6/12/2024 11:58 PM, Dmitry Baryshkov wrote:
> > On Wed, Jun 12, 2024 at 12:17:28PM +0530, Ekansh Gupta wrote:
> >> Move fastrpc.c from misc/ to misc/fastrpc/. New C files are planned
> >> to be added for PD notifications and other missing features. Adding
> >> and maintaining new files from within fastrpc directory would be easy.
> >>
> >> Example of feature that is being planned to be introduced in a new C
> >> file:
> >> https://lore.kernel.org/all/20240606165939.12950-6-quic_ekangupt@quicinc.com/
> >>
> >> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> >> ---
> >>  MAINTAINERS                          |  2 +-
> >>  drivers/misc/Kconfig                 | 13 +------------
> >>  drivers/misc/Makefile                |  2 +-
> >>  drivers/misc/fastrpc/Kconfig         | 16 ++++++++++++++++
> >>  drivers/misc/fastrpc/Makefile        |  2 ++
> >>  drivers/misc/{ => fastrpc}/fastrpc.c |  0
> >>  6 files changed, 21 insertions(+), 14 deletions(-)
> >>  create mode 100644 drivers/misc/fastrpc/Kconfig
> >>  create mode 100644 drivers/misc/fastrpc/Makefile
> >>  rename drivers/misc/{ => fastrpc}/fastrpc.c (100%)
> > Please consider whether it makes sense to move to drivers/accel instead
> > (and possibly writing a better Kconfig entry, specifying that the driver
> > is to be used to offload execution to the DSP).
> Planning to keep the driver to misc/ only as part of this patch. Moving to accel/ might
> introduce some conventions to be followed which might require significant changes
> in driver.

To me this sounds like "we are trying to avoid following the
conventions by hiding in the shadows".

>
> I'll write more meaningful Kconfig entry in next spin.
>

-- 
With best wishes
Dmitry

