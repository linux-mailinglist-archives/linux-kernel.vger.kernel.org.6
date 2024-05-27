Return-Path: <linux-kernel+bounces-190682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 033F08D0155
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6001F21171
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C015ECFA;
	Mon, 27 May 2024 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrCDus8Z"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313F115E5D4
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816277; cv=none; b=rq0hK6aYPD3ayKJejrmZGEKUrqtc8756WZ7wIl8YiejbvpiJ6bYl5ix1RXByb3SHietQXasMik6mo2PwPAo7kTMmYBcrvZxy/VOY+YrU4ccMn54vj8j6Mc/YbbTlwLrv+QYFFyqMiTowTZy2kWNEKQDq42OVpGxwM05eaEqmXGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816277; c=relaxed/simple;
	bh=x2Jdhib82/V0ui7pyN+wwszx3YvL4n5ycnmq96SX0Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgsOe9u82Lx3PxAEcD6E/JsgzyX6RVMeTTN5ZvQFh7gVRZPyhcaElh0pubd2Xsr+7y90D4BxrwUBIF0ctaIN2r39qKl8iQEtnhbUrCr3OxYnwMmLky6WxaNCcf63Yeui+H6AoSDdTZvSl/ATnvWQGgr5nNbkhjlI07YJCFF73uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UrCDus8Z; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-df7722171bcso3336315276.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716816275; x=1717421075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2Jdhib82/V0ui7pyN+wwszx3YvL4n5ycnmq96SX0Xo=;
        b=UrCDus8ZduIUi57WyKVGJIRBSQ+nOujC9AXXlHvD0bBawFX2nDOBO0EYl/UrELL4Qu
         ygRnk+/2PdBIiAADvrrPX8nO6sQDmFz2DyNutXxbAevsl3PFX39JttfOD5yHgEicEOnd
         Xlz9022931xtbiouaIFwjiq1BDYWolEQta5eGLYrGq4l6EYg5L3+CpsYPWEHlh6Hj1WC
         /jHFhRDJ9vKd3RoKugFrZg2mWW9jaGPlGsK2xj+1mR03xPFb08d+ZS9HvSRsbuKiTwJ7
         Agx2kNmVIc2kPwFz50cPEa2QhmcPNQyqs+WSkbOrnEz+Lq8mZwSTaWfeOSakoUUGmo/a
         2ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816275; x=1717421075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2Jdhib82/V0ui7pyN+wwszx3YvL4n5ycnmq96SX0Xo=;
        b=gwtWspIQ7LRVac48UWCgs0yQXyFmpxyPdBm09TIg2wuh49om4/jIdfM61kh8lrDgml
         oQkDxFTaTQBTdHgAgQHqhG43xJNUmP/QshpSioOJnbx543pVsHeWmB3l1K1uI6iiRakd
         zKFUcWfVzG+b688FphFlo3bwrdCSzb7zOsAzYZorrggy9/1E83LVy7UXG/w1J75B4HcI
         WBeujNjWET/yfnRwlkj+lOMDxoPfXcotapQXhMtd4nV6iqHiwE3cJdd9r+rDcukp6/pC
         E8770QQmxkRnJtYEIk9qygtiRnpdsESskTfhdCmoUVhOwdFQASh8uutjpoL36MiDPNNV
         cktA==
X-Gm-Message-State: AOJu0YyPqZv4XKWQZ1dSLSbfaGRyps9PIZcVmP8H6UUtsQh2ZPmkrntV
	buEbd5WDYJiGc3/B1qVLIDrhFDoyo9RruBMuptpkmu6Eu2dOFWkzj+SJ6TrMo9pU65kuh/wH2K8
	y/uVPQqtEg6rTloXVqydsJt0IL9Rlr9f4fUq9c9EoXlAmpAlONUhYMvlB
X-Google-Smtp-Source: AGHT+IEdLze78+MZu9bjE16B2ILsnt+Ms7aaLj3Nyp5Wva1nZuGSiSA8SXKzRZ1s0C37uj+2XYBWjcfwVXOGdq4p2Zc=
X-Received: by 2002:a05:6902:c0d:b0:df4:8ab4:d8bf with SMTP id
 3f1490d57ef6-df7721a50b6mr10242365276.33.1716816274828; Mon, 27 May 2024
 06:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508184905.2102633-1-andriy.shevchenko@linux.intel.com> <20240508184905.2102633-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240508184905.2102633-4-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 15:24:24 +0200
Message-ID: <CACRpkdZvbC9WH0bqU_VGL4uxOVb6vopqeGgvZsOrPQnTHmOBqg@mail.gmail.com>
Subject: Re: [PATCH v1 03/10] eeprom: digsy_mtc: Convert to use GPIO descriptors
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 8:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> This converts the driver to use GPIO descriptors exclusively
> to retrieve GPIO lines. Drop the old GPIO handling in favor of
> the core managing it exclusively.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

