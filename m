Return-Path: <linux-kernel+bounces-269780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F119436CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B47F284B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54B1607A4;
	Wed, 31 Jul 2024 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1GQM9Z6"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372E515FA6D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455982; cv=none; b=idPg2Xbx5NGUm+cgnXsAHFscavmdLxPSEAiEMvA6ZDqfce3yVA+3ogKEiWNmHkcgiLqZcKBYSVYqdTin27lE0jWCCvcHxK4PO0sKzFc801jG4sBELdVC9QkeVyfjGLHbs1QtLnMVCqX+vGiDABmg/XAJnF6PjU8KKAEw0GGar3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455982; c=relaxed/simple;
	bh=dWIe+SVflan2SsTYfU+ly+kEamX7THOV6NbrTrZgYsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJwavrJ2omtyA3CKDYqfQt0vc/Uf/sbFwF3YyqArXZzgMw3n3RflOaQXq2/AmQ83EO7zPEcyJ79EVbM4UbLOff8HdiQ17p/X5CqLS3oj2HvQ7yMNEGRgD4KyOE7y69+lDG5WouzWJtSWNGy6Y77D0IIJZMWT4yroLL7hL1Cw/vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T1GQM9Z6; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f01613acbso1490482e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722455978; x=1723060778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWIe+SVflan2SsTYfU+ly+kEamX7THOV6NbrTrZgYsg=;
        b=T1GQM9Z6q6l5wLlt0eypCHG9rt9+uo6yhpPFTymlrz/3RwsH4oSdrRhFyKPxErLpr/
         MPbcoVkQNieAAVhcDHFWCtUt8tZeMrEY9BO61z149A0P095bTAid2KG6nzA1zwWl3Abr
         RVX2nNsej4PJPXaZ35+TdUqpAbfOxnVS+FiswMwU7F8GBI+pWQRXDO0hFBymML7Xxf6O
         NW7GRvivSvhMHRTpOuz2JCNE5FN1BizavbvfAY7ETSq4WM2sXinoyZ3h6kGQr3n+8bkl
         GkxhOnNz41rEXhf7mwgKazEZHKxDDJj8epjbkF0+bJvEB1roF/uZ8ElPeh78E9bF7CeV
         ykpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722455978; x=1723060778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWIe+SVflan2SsTYfU+ly+kEamX7THOV6NbrTrZgYsg=;
        b=VSIUf5Ih1GEQxVNMT1rLLvOFHvuTSKlmk81DLXOacTjm7qT7Uk4Ry9CPZxkvtsReYn
         PdpOnXgc6ejUH8OoJS7aoDdAvuXHy+M7eoFWEXyv4dRO97j4Dejwloan1zjE1Vxt8Jlb
         Bp5b4u1YbvqMgXlWz0F0Hq+GZfPi6x19oA1XwsV9txkShTCoWjS+pppHh4aVrMewKOYw
         7nSMmIu40kfnCznY0fzTWBgqtawhdtdJP5+kxRCmjXj9gn2u5bswHvb9sW0WEdlpOe1A
         FyyxzCjQzr+3nbgOndh9kMjSmk0EBPqycpGvwv0rGnW48gnTkJMx6gdoukyQJyWOuNch
         WBcw==
X-Forwarded-Encrypted: i=1; AJvYcCUQuU9MlSMidzJgB8l8DnFCMQZgSqRPuLyjRb80+VB61KT2QO+rp2jghefTxxSGiFHvjX7doqXhJQk9i44+ibZu3NbF+LhDZK1alljV
X-Gm-Message-State: AOJu0YzQA0C8V4JB6qBYrwVm5WmZ1V0Dmf6QdJswGDe8VUW8NIt4N/Ek
	xCqcWHW3mfhZmEDx2abAssYVLL4qfWaAHkgIAIxO5MzxcXFSFoeheDmq27Evwjff0zGBuPEbzkx
	z/nrGVZj9RA95Hni1qqPCjALFq0pw2WMERv3pDAkIoUW3eYHr
X-Google-Smtp-Source: AGHT+IErH91gsiP0jknUbGQePRQcEui321R89TogJGgXf/NOgJfDu4BwCrxCl329HVydBTJibEm0OrBmEJW8f+7EJ0w=
X-Received: by 2002:a05:6512:ac8:b0:52f:260:c459 with SMTP id
 2adb3069b0e04-530b5f2f6aemr57773e87.22.1722455978122; Wed, 31 Jul 2024
 12:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731191312.1710417-4-robh@kernel.org>
In-Reply-To: <20240731191312.1710417-4-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jul 2024 21:59:26 +0200
Message-ID: <CACRpkdZ2wft1MU37fZQWKRh2jmz2HWiCLyx+ihvawWgkvORE_A@mail.gmail.com>
Subject: Re: [PATCH] clk: Use of_property_present()
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 9:13=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> Use of_property_present() to test for property presence rather than
> of_(find|get)_property(). This is part of a larger effort to remove
> callers of of_find_property() and similar functions.
> of_(find|get)_property() leak the DT struct property and data pointers
> which is a problem for dynamically allocated nodes which may be freed.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

