Return-Path: <linux-kernel+bounces-379058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 268419AD91B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60061F21D85
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD00208D7;
	Thu, 24 Oct 2024 01:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7zrD/KB"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C34D8AD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729732193; cv=none; b=pqErmyJDJFsLValMPd0v62Lak5n9ApnmxeoIBi1+GQ6Uwl8nlGfIzM/YGpOSEQy9HnM5Yq26gfu78MSIugFwxKJAw10xRmthJGVkOGv2x2NpvaFwKB8ZbByMI6XYv1HIMSQ5odZQWjN3wfv+6U+oihRpx45KOu6z0D/EDjvwVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729732193; c=relaxed/simple;
	bh=Wg9Wp5kk0vEFCDe4okqM3rWzYPqqTfbIGApRoVaMR14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSakhJMOXTAWwYO5MsOA9nXinhjkpbmMYt92eAbQFjD0CSAhe2aE2/EOq9Uvg3WkIX1NV1WOk00Cfd8yMwwr2/FFjTKq9FcA7zMnEtpQxCYw3sS2ph4PIJ/vZKPFGf2MD2ulLZ3Om6LN4vaKFxhy8hW2RsrG0KXMRZBjAK5QGeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7zrD/KB; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so3205941fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729732189; x=1730336989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbcd5uRapQhQxq5MJJTWR2sL5XsG0N0yna5jn5lare0=;
        b=c7zrD/KBGBVYRnCwuLP375zoEo79amBQD2rvVForRbpygfQMZ27bu6Zqum1UPsc6iL
         TbbTuLkF0101pL1sKzsp1V4ENyC7W4WTli2M2g4UoQm/PnyZApcVftY6NGKbF31UTeug
         xrzX01BxW2dkq6EY+b9sS58el99b6x3yftuOsjBN7ZqsS3c/8WPXbKpBgIxMwz8QpXY4
         rwBxzxh9fg7gkAGThIPlLl7pH8cxYdmDTHjWt+nb3+79zHENDirXbvAKkYHO3kb31X10
         NJ//BYZSvt2UjDjBkoxruIeEZsTt8DKt2uHWyG/D265zKux36eMG+JLKcO6iVlZOczrz
         DwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729732189; x=1730336989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbcd5uRapQhQxq5MJJTWR2sL5XsG0N0yna5jn5lare0=;
        b=pj50RE4Z6oLrjzrRA5SJE3887NrkSBlDmoa+/UENRP4otHk4DW0zozvoB/eoomz8+X
         /EnW/eDL+6rqxygyWzxCz4gU4jTcMixdJnoMtVeyLbIcKqe/18ZWxd7J4pzlW00wNhS/
         oCp9C5MuDSNSCX/aJW7peYUTgokQvzoCr+262AR2UjuLTybfAG1+3+qaS5ZkDJbpP4PM
         6bsb3kM4qFd2SCijUrE5XcBUYYt8uFQdFcIT07ajdsHtCi1y9zFLpBAT4PMdKsX1+0sa
         5abtwSQtRX5LzOskCq64uUe0DiSzDEfGrmnLcEDOuqTwEmp+OrAq2PE41WC0/H0EW2cZ
         ctQw==
X-Forwarded-Encrypted: i=1; AJvYcCUSp818fJK+LrrEyVFEc4aVMtwouwOMPkzhPmJFPO1pFecTZJad0A0GSj9av1E/MDhiYxa5DFDTLEAJy5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6cR9wTNq+xHqcXDG3tM70lZVfB1eErmD4HmUg7RTB9vVy0I/b
	8XzRiCu3jx4R62In2/oNdOZdMmVvddAi33qbIO2n8YooV2QkBq3Q7HFJZ6PHOwF9jtMV7oVJg++
	qLvk9haY4kHYm2tlaNgTGWQ0dx3M=
X-Google-Smtp-Source: AGHT+IF2Ax60z242ilbI2EuA61CSMux8GznaUwVN4gBzSDilDhsogRyUKPdE6YgVBW9AvJpAlEtab7CwKd3munRiSXs=
X-Received: by 2002:a05:6512:23a9:b0:539:e6fc:4170 with SMTP id
 2adb3069b0e04-53b1a33ca83mr2476739e87.32.1729732189049; Wed, 23 Oct 2024
 18:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023-imx-ele-ocotp-fixes-v1-0-4adc00ce288f@pengutronix.de>
In-Reply-To: <20241023-imx-ele-ocotp-fixes-v1-0-4adc00ce288f@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 23 Oct 2024 22:09:37 -0300
Message-ID: <CAOMZO5Ar0Pa6RpjmXkX4cd4oao3ggbs4a+OsSp==PGO1CV_-RQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] nvmem: imx-ocotp-ele: fix reading from ELE OCOTP
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sascha,

On Wed, Oct 23, 2024 at 5:12=E2=80=AFAM Sascha Hauer <s.hauer@pengutronix.d=
e> wrote:
>
> Commits b2ab0edaf484 ("arm64: dts: imx93: add nvmem property for fec1")
> and 0d4fbaffbdca ("arm64: dts: imx93: add nvmem property for eqos")
> introduced NVMEM cell bindings for reading MAC addresses from the ELE
> OCOTP. This doesn't work as expected due to bugs in the driver:
>
> - imx_ocotp_reg_read() interprets the incoming offset as 32bit word
>   offset, but it really is in bytes which means the driver reads bogus
>   values whenever the offset is non zero
> - imx_ocotp_reg_read() reads wrong results when the offset is not 32bit
>   word aligned
> - MAC addresses are stored in reverse byte order in the ELE OCOTP, we
>   have to swap the order before passing them to the upper layer
>
> This likely went through unnoticed because the bootloader normally adds
> the MAC addresses to the ethernet nodes and in this case they are
> preferred over the NVMEM addresses.
>
> This series fixes these issues.

Patches 2, 3, and 4 should have a Fixes tag and Cc: stable.

Thanks

