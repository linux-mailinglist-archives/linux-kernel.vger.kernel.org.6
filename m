Return-Path: <linux-kernel+bounces-190690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7789B8D016B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0D92B23327
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D115ECF0;
	Mon, 27 May 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y7JKitKF"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFFE15ECE7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816408; cv=none; b=XUxPYU7gE0dQSBxkmxr0soen4zAs9RPR8ehsXi2klxaheIP23AGDQ3Mpd32Jb3xsggQPz7nOJHnYyy/1f5pTXF2H2cJoeAUl9PerRf79lG53Qe0BrueueL+mwaZktSNTxJ+ilzf39nGSWDl8RFoa+Z4d1GGRSG+cdeoC/GxDiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816408; c=relaxed/simple;
	bh=GflM09Ty5ySMzHW0VQRjEjWl/D2bFn8865uwf7NdYgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1lgynBFRu8kCEKYI9pFpgnYh8hlFITEaPovPMfambduRsQRPOKW0TO11fk5HhkeVlYGq8ejlJcV47/aoRT8qQ9g3lwkxDwvxDk3cheBgv051S2SA0d2dMjdKZ7bSYSHgRSgLmB6oyfZP6vP2T0ntrruMLySKJ4bW9PPUPClgAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y7JKitKF; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-627eb38eb1bso46429147b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716816406; x=1717421206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GflM09Ty5ySMzHW0VQRjEjWl/D2bFn8865uwf7NdYgk=;
        b=y7JKitKFoNlLazLZQPCVhxVab3Ms0OENbwVfGrpqhKRAoEOk1FFHa0AHdXwWnaUCTr
         Ox/HiUrV1VHysZ9D5kPOcskxtNIHIIAO4l1IrodVzKLabakGX1LYW16C0T4P7YEFVr5Q
         wgwydTSQ37wxE8nceFFSb5ZEdor5oy7oG9AwaRwp7Poei4pfTZ7zI1sUaejHHGfP4yvK
         ACJPIhQf4jL5pUWiC8rqxdgypfR+6YEw34omEzXd95HSFImUyvT7mggVuiUy+yxV/SIH
         fcehDDg16Ufb02OK4WBT7NvWgH3OCArI0kWwMUbCyXt/wxvKxGNOPKuH19vR7XuojguJ
         ocaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816406; x=1717421206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GflM09Ty5ySMzHW0VQRjEjWl/D2bFn8865uwf7NdYgk=;
        b=dZmUt7yvmG0qnDWkzb2Sf543+vs5pyXxLD1zmqDxV0sV56bh+q9D4WHh/YWODPNSek
         0votwDveqOotH62NXU3APp3SWPol75ni68G2pkB6ahLAQgM589ht+VCYtaYag0N1/QZy
         4eBiE6wlnUM/umLdlLhtsaTQ49o/ufp0Ej1PoQ2iDbKjKISNZyTRVv47hejdZgwlHE7n
         xSzlhJAK06COkIJGSEjWzOim4WD5XCjMoekz7mQTzyk+9WGOoYO3ivSaORv1VwCnT3C8
         A22xDHqjgMV72WQePM8C3YkD0zz3XFwT8UFABXUDVaJQG10nwHnow+p+ttsCI3gQSdNG
         cfHQ==
X-Gm-Message-State: AOJu0YzIg5k/30UA9i1DSeYEWyaS+5dyysZ2iDk/m5b5Ni0cX4jKScn8
	Txh6OW5EqSS+hXReHsjxA45UVPXSv7p4CwtTMqcNscoNjKndkYemNbSBTTq0JDTLxvyDujUo4Lf
	Vz6PHn7E1+Fjv0Jeuz1Z8uIWmSOZmPPbg1RjeQA==
X-Google-Smtp-Source: AGHT+IFms/63o/+DjGOy6TdOl2Qg7o+dhIUuGvOiygQyFhIiJFBNF6uGUKDoct1n887bPn4ofe6AmkyPJHaQ+G4Nv9c=
X-Received: by 2002:a25:ad96:0:b0:df4:dd95:cc87 with SMTP id
 3f1490d57ef6-df77215545emr8661187276.10.1716816405947; Mon, 27 May 2024
 06:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508184905.2102633-1-andriy.shevchenko@linux.intel.com> <20240508184905.2102633-8-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240508184905.2102633-8-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 15:26:35 +0200
Message-ID: <CACRpkda1MGG4oSBkBbcT2qHLrOPKOJHs_E6OSO=4=xAGmKjm4Q@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] misc: eeprom_93xx46: Convert to use kstrtox()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 8:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> sscanf() is a heavy one and moreover requires additional boundary checks.
> Convert driver to use kstrtobool() in eeprom_93xx46_store_erase().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

