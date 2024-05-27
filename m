Return-Path: <linux-kernel+bounces-190655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4006B8D00FC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2ACDB25A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402DC15ECCE;
	Mon, 27 May 2024 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2YZ7CVI"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA013AD12
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815017; cv=none; b=Bk1GLGSs9GSt05IBrkME+1AG5gYxbcFl8PrslsIyVdbZ9BXlyVWxtZRSRddc3nLIYkYUblWQNUYA0RMPuVkks9lc1N2VKndTZFh0c658FuQjqnYdMhR3XWRf53HBtns5vvr0kyoYoM+5DbFxAd0D8kFhKlIwQNEOFqnMBk9J7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815017; c=relaxed/simple;
	bh=TwC/mWGGelUVj2IZBB4ZxhrhwD2UtTfj/7J6OUG103A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWXfTKifVHIQQdWXDBqfYL0n2ofbz4ehLSoEM8GE6dzzYkGtWhXfbaX60ORU8eWavfehhTpDqXt8iWRMLOq0QVQYmy9yu/GfseEtFnj+rr6bMybO/Aih1y81F2ObPwBIwaAWUXW6XXjs5vUtGDENeV39S3CAh8Io83v2Sm6u1mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D2YZ7CVI; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-df4e5b89e49so5159648276.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716815015; x=1717419815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwC/mWGGelUVj2IZBB4ZxhrhwD2UtTfj/7J6OUG103A=;
        b=D2YZ7CVIaM5oyC5GvJvVkvff//Jaadx30lfbVQ4+dXBDC4JUwhWuAqG/q8mHaIaVXr
         mJ/T7lwPhYYc912NDwJaQnGlQtBofjWGRckXVeiZY3i3Upm5nzry1NI1TnxUt404DdgP
         3AYYZyOR932hX0dc0gwVkRtgWxIK/lJIzbLugZ7t/F6mIoDTba44O7L9c2F1cXN9QlEK
         5/rdSHxCZ1KIMjt29t7Us6rqqIvxxdvfJMPcjThskd0Bzzld1sGiAkA4H7Io6q77PHXd
         IOcxkHEgnDWKa29rlYhNXWbFwGiuAeevxKdEsIGS+gGjKJzgLVljlMMGWW1G/HwIhJqj
         xj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716815015; x=1717419815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwC/mWGGelUVj2IZBB4ZxhrhwD2UtTfj/7J6OUG103A=;
        b=wXQ8A5DxcdprriMxZWhhGHRc0/MZZIEYYDZqOuPjlA2VTE8WY7BazQexY8Xz8lXmhI
         84VmjKOoOzilsxB1fHoJKr9fMndh7LII7WAUj3FlNtwrCYOeOmPVt0d8/tVQeXeVBxCH
         mOMdj1WV+yWDSvOy3dpTLsNqRhvrj+C0U63PCUspov5NlDWHkYsRiNKJvoH2kWKuopjO
         i93eiO+89rHuZt5wZ+DQjrZKQJUsdlxPV6B0tLHGe56QdUYkOEmaqP6KZeqPe8FkPCji
         ZbJElYxb6Xva5QiGPVOp46alfFr9cHMJ8KyJkqVCS/M72iG3zKhix/DXgr00QJnV9AMP
         y1+A==
X-Gm-Message-State: AOJu0YzXHUEjNVgcuaaDy+23z9wad+M9nJc3evN/pCrOSQw6Jqhk3wUS
	GUTggH4Hnd0J32EOeWuLEufLxO2Hju3qSpVM8D6IiXImd9RCZHxzygH9Uw5waZe3CGl6hnG9alu
	zBJBxBq9IRJqcNAQww+9+c6AQvlh0SEuySh2t7Q==
X-Google-Smtp-Source: AGHT+IHIsrakM5b1wIQXZN9hArCsbTx3Tj7r+QeYSsIea9WdaoW79HgQqvQV15H3NmildP73cyMeyxNflTzbrC3rPGA=
X-Received: by 2002:a25:ae21:0:b0:df7:6580:73b9 with SMTP id
 3f1490d57ef6-df772265550mr11246024276.63.1716815015034; Mon, 27 May 2024
 06:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508104848.846580-1-andriy.shevchenko@linux.intel.com> <20240508104848.846580-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240508104848.846580-2-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 15:03:24 +0200
Message-ID: <CACRpkdbcpVj1A_BXFtsPMmu+jwYmbUZi-5fFkUprTT2=Z92=3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mfd: lm3533: Hide legacy platform data in the driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 12:48=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> First of all, there is no user for the platform data in the kernel.
> Second, it needs a lot of updates to follow the modern standards
> of the kernel, including proper Device Tree bindings and device
> property handling.
>
> For now, just hide the legacy platform data in the driver's code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

