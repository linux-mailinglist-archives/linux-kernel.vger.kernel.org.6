Return-Path: <linux-kernel+bounces-401847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA94F9C201B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCAC1C2183B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8490F1F5854;
	Fri,  8 Nov 2024 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bKnoG/0+"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89F1F4FB9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078709; cv=none; b=OEltMEe3frtH+D7XAhsCLB+a6JtqNp5mxse/ZpBSRHGwZOIQUK03nkRyQFwysCmVnwvgAmVlBYkRhDBCWLIEutD7XFVfdnAHazyE1ODea3ZHtLeLMbGBx3Z/FEbsFJ/iH+S3RRrddO64kQDZ2Y4mkNx54dJlFh8Y92iCHbAsIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078709; c=relaxed/simple;
	bh=7AbutvFdmgvjtotNL0xr9HRKPZ3PcvOcSlbj0hwvXMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJMcBHV5ioSfrERVeG7lyvKwvSNzW/zCEyX+0nWYn1e2RsTO2tWTddIsGNxnyGtY+J9AOEDAxzE52ZtF73hE5Xdzg6B5DhD8R2KpHQoo8nZLOrdJJVYl1NVtp2BPFLG28N448qPXEW498yyjUXF4HwDkTKOP8oa5CJ9H7yiUFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bKnoG/0+; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so2886516e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 07:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731078705; x=1731683505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AbutvFdmgvjtotNL0xr9HRKPZ3PcvOcSlbj0hwvXMI=;
        b=bKnoG/0+aarS9H4jOxRQDzKVK0A2JtgdqfOPhGlYK6VlSjdRv+DalLZi/BFFW7urW0
         kxZkrYCy8oVhnvllbTmG2xZ2d3VfFAkc5x+oO0nrGgTtITOX7jaXixeyoSitutCHLOm9
         yiHLQ5rICroz4O2IECtSFVvTsYdXhlgwLY5OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731078705; x=1731683505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AbutvFdmgvjtotNL0xr9HRKPZ3PcvOcSlbj0hwvXMI=;
        b=fKNkWCI+c1DZlxL0BaHYQ1H5kb+lvPkS9xVhG2KGMtY/yjCRhfSbx2whH4Btpw6HV9
         0k+l4M35ZV5wpb5tbzqLv7dM4aT4T04KiQHcEAN2qJZg/HiL4aXwkouhO+8X2wrmE3bB
         ZzGqhc4/P8wSitpsuHncM3aZjMCC5tfbZlZLH8VhQLyqeMVbfCFd1FTJaV1Dnjf3oMUy
         qaQcAvWWtI0HbRRM40QTk8LZz08cvgYJCVJxUDWCdcaZdYFNyLrZ5Xu8pDiVvjwj6O3h
         VA38Eu3RQ3WMF1n2jyVxr6CIviM6Put1UqzEkPOFZ2UY2CPe6/fMvgLnWJ9uBtPdhrEJ
         Wi5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUy+SLqSzOgLcHZAWGZaZWNnvaA8IY5fvGOftEw896wPMLq+9Bvfz/ozvrpKWTkGFjXVw2uDr+fSgV4iNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuruCEBlhBT2e+UxPN8FqWFV6cbEVgjiptca7A7CkKvaUn4JJF
	AUpqMEhpD+jVX6Tvt2U1N+FJinQXAPewPlTUXHeUMXHJjIQtilu5zY5ISXDKqhLqT/ZakRbROAu
	a9Q==
X-Google-Smtp-Source: AGHT+IG0eJIn7OLLTvMYCUMZwSpCSsPKBP604iw5Ca8IA+PJAmQkBrU6IkudZlP/jsC5H5C/Ljh+mQ==
X-Received: by 2002:a05:651c:2111:b0:2f7:4d86:5dcf with SMTP id 38308e7fff4ca-2ff2025fc24mr18747611fa.35.1731078704775;
        Fri, 08 Nov 2024 07:11:44 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17991a25sm6839431fa.79.2024.11.08.07.11.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 07:11:44 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e13375d3so2713251e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 07:11:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTXk7R7/c/NH73bd0dJbA439+tetSqYNnxr1dBZg/jsaFBay/1XePQ1kMjMcvFH5aJYISsqu8p3cCQwSM=@vger.kernel.org
X-Received: by 2002:a2e:9a16:0:b0:2fb:3881:35d8 with SMTP id
 38308e7fff4ca-2ff201513dbmr19941421fa.14.1731078703279; Fri, 08 Nov 2024
 07:11:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108120311.87795-1-charles.goodix@gmail.com>
In-Reply-To: <20241108120311.87795-1-charles.goodix@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 8 Nov 2024 07:11:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WNcdbdn4tzNyVWaZugma3RdqmvTPa2NsTyuhH4yA3Raw@mail.gmail.com>
Message-ID: <CAD=FV=WNcdbdn4tzNyVWaZugma3RdqmvTPa2NsTyuhH4yA3Raw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] dt-bindings: input: Goodix GT7986U SPI HID Touchscreen
To: Charles Wang <charles.goodix@gmail.com>
Cc: krzk@kernel.org, hbarnor@chromium.org, conor.dooley@microchip.com, 
	dmitry.torokhov@gmail.com, jikos@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 8, 2024 at 4:03=E2=80=AFAM Charles Wang <charles.goodix@gmail.c=
om> wrote:
>
> The Goodix GT7986U touch controller report touch data according to the
> HID protocol through the SPI bus. However, it is incompatible with
> Microsoft's HID-over-SPI protocol.
>
> The patchset introduces the following two changes:
> 1) Add goodix,gt7986u-spifw.yaml.
> 2) Drop the 'goodix,hid-report-addr' property.
>
> Signed-off-by: Charles Wang <charles.goodix@gmail.com>
> ---
> Changes in v3:
> - Split the commit into two patches.

LOL, this isn't what I meant. You should have one patch adding the
proper bindings, but you need a second patch to _the "driver_. Right
now the driver (AKA the file "drivers/hid/hid-goodix-spi.c" in Linux)
is still looking for "goodix,hid-report-addr". The driver needs to be
updated and that was what I was saying should be patch #2. You'll also
need to fix the driver to update the compatible string it's looking
for.

-Doug

