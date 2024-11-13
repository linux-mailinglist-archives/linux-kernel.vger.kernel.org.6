Return-Path: <linux-kernel+bounces-407643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4623C9C707B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73842282228
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C211F583A;
	Wed, 13 Nov 2024 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvNNgqQA"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D51EF081
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504223; cv=none; b=NJ6JL7lrSF/MOrgBPzbVqKMEqQh/RiVv1gCssm5duejc7PB60+1uii9cjDV4Acuk2CKEgLq6qN9SqkSZmXOCgavRbxIODfMV7sevNFln8BBBcXupYK5+JQRriYKpMTBhS3dU8/vuDbKvhLpPwcGFvQ9NwqAjnwRu9SVwJGs/D64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504223; c=relaxed/simple;
	bh=WuUoL/3Od4PAfLx0IEVL7oxlLvlZraYaALoxt1cPU/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YES9mJDYAxcyVLCs84sY1xMjYvdW69lEsQXPYpB++R0By7eMBu1mGndL4wFJ/RpUyD9NvBOs8l066BN4BWZIRTIC92F1vXHUtY9en8e6mK3Hq3z9+1uFNAUh0PvqQCmq14SaKoDkuqHjk474lrwUAMJidrJfr9YsdT5Gw2Mzijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TvNNgqQA; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so59774641fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731504220; x=1732109020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuUoL/3Od4PAfLx0IEVL7oxlLvlZraYaALoxt1cPU/4=;
        b=TvNNgqQAom4J+vPDsca//Bm+fkLGbkZ3xHJjdOE/KlnpCRdO1GTpMnzfqCzIBEuQRK
         JrdzHjlTbPNBg2IeIZYjt7+Unz0hlAkmWavW3pjVOYup5mnM+YH0OLKBckorMM9HGBMZ
         S18uhbAes37NS+GAX2CkKRqMvXCAYlzVIIr6gfPfcvJKbkCOZfShVJLucHHD5s0RrYz4
         nQutorefTqs4TqaVkfZ4+Mcv1eqEMhKkOuAB3PzmwZDHH1YLyapZVoc16NVZqSXdINkU
         Y4jZ1ohmmNAk66wRwz4sx71ZBXFdYb4YazMD6tSjF1+HeVHTiC9esLIDhn1abBMn26AW
         jHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731504220; x=1732109020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuUoL/3Od4PAfLx0IEVL7oxlLvlZraYaALoxt1cPU/4=;
        b=UsyQK+1GEuWEWq1VQ8ti6pKkefNg+BFgBLunJxj7E5LJiDX84kN+7Yh2o00V16nBAZ
         JNVnh0YGy4uUy76AcSNVt8ysIBY4I4TV7PJ1ntSdrSbJP3m/kN9ioWj2/xGDwc9edOp0
         VxhnNwrihkBtoe9rr6vmtrBmiHqdHJ9QE8bdlvN/OaRHQGfsZJG5Zedb47w9VYiWWUAm
         ntw+2J2g/9vc64JwJjfyLaabmpti+XaaTRAGgCwgcyak4WvwdzRRJZHW7YplpQn0Q8Qw
         cK02uPBVVssevGiDzDxY4xBOriKzB42GCsh07rsCjjDu3BootPwMvnFzBxPLtdtuENgi
         H+lw==
X-Forwarded-Encrypted: i=1; AJvYcCV1P3/SpsZm1foIPx1V4ZQbWKisRgEyyc1pQ9YAH+OzGD+NTzsUtWF8cIvehwENGzynY+oGuTtqCgtMnpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypOQ3wyDGRT3dSWTmR12TBfLyCza88gj0OtwJir598ELVS0Vqg
	xX5HPfCcp/jdyPqY/8K1IxyVUpCG6gP3GdhDsABgBquEfzIK1zezYtpq2oW2FP5E5m8gU+BRDR2
	em/aVek9RZoWIlA4J4ysVPTGsLJYTHxW5L8jV0w==
X-Google-Smtp-Source: AGHT+IHPQaK5Q2KrP40p6fsjtBW+uQBglC9BCYxI3zoro/0CrtBDXagUb0BV8QyEJHptozHMaCqcNJb9txvKEMn8wa4=
X-Received: by 2002:a2e:a552:0:b0:2fb:3bc0:9c7c with SMTP id
 38308e7fff4ca-2ff202e135amr113365511fa.25.1731504220103; Wed, 13 Nov 2024
 05:23:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111023412.3466161-1-ye.zhang@rock-chips.com> <20241111023412.3466161-2-ye.zhang@rock-chips.com>
In-Reply-To: <20241111023412.3466161-2-ye.zhang@rock-chips.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Nov 2024 14:23:29 +0100
Message-ID: <CACRpkdaswgKiFXQMHgAW=eXCw=BG3+2oQTwq4PaAf7--vUiKiw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] gpio: rockchip: explan the format of the GPIO
 version ID
To: Ye Zhang <ye.zhang@rock-chips.com>
Cc: brgl@bgdev.pl, heiko@sntech.de, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, tao.huang@rock-chips.com, 
	finley.xiao@rock-chips.com, tim.chen@rock-chips.com, 
	elaine.zhang@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 3:34=E2=80=AFAM Ye Zhang <ye.zhang@rock-chips.com> =
wrote:

> Remove redundant comments and provide a detailed explanation of the
> GPIO version ID.
>
> Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

