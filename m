Return-Path: <linux-kernel+bounces-300067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD7795DE62
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522BA28302D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3345717838B;
	Sat, 24 Aug 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YPv9UcQN"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD86E15EFB9
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724509911; cv=none; b=uts33Jj/kHoOz5dGPEBa1FxlslLHbfQW08gvNJEaSydkjemfe21DT32+XpT/EzxVJnW0J9Ysaw9pFKtfyy5LfchpZBLAnMDKRrcSM0oOY5Xur4yBJ+3j6n+ddGsa7BE5KQgtqQfIMJnR7yS9t3uqAYA61sHmk2tL9fIGmmOquCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724509911; c=relaxed/simple;
	bh=s7+9Tif46h8xdWgv9tV4+W6VBTxepXWo871kPw4QGH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyS9ch6f86dq1qP4Ym8BWzRQ11ZOAi/B+YAQKyzAKDqebwP7Uz2ExJ8iJKgqIggEknnncvHRhxPb4TiRRx5NR6g/+/jmTFz9bCPqufUQf6tDhOEJtKS2d0s+4HoE7Qh5H2gAF8i2znnx5IqySamX08nxY48WBG9oK1M2fDo5aGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YPv9UcQN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53345604960so2995269e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 07:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724509907; x=1725114707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7+9Tif46h8xdWgv9tV4+W6VBTxepXWo871kPw4QGH8=;
        b=YPv9UcQNXGQo0RwhAlFgcEiCPkkgCK5t33PfjPEXEeARpLL2LcWW/8Fn/f910XXLLw
         npUSDEzDOf7WAH+JgaLbo43he2ydjnqNLK6yub198N4oQrYSJLf4IFNdkAypOGwsBIbf
         H/TGmZ1KoPD7LzzVII3K6OGgThKJZqBwugCNIermaXGbclQriShNxySuRHw1EUSADtBT
         bNTHTas8wZYDml9zXWZ+mTpZ9vk8qRajQdQvN+iDht9PDzwZiR5WkyOkJfEg9Wszyw8M
         f+uuxya4/YvIkns8z21BJAKl8Wkj/l/Sn6qu+d4rwrKDvjxvIrlWsvgGu8o5t2FLL02P
         +Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724509907; x=1725114707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7+9Tif46h8xdWgv9tV4+W6VBTxepXWo871kPw4QGH8=;
        b=O0D70W9g+at2h4DpU9bW9KNk+aDfIt8Wzv5RgR9UJUXjlCOvOa5khQedAJkYXUVe0M
         39FDwG/DZaYdoGq19WFDfYgjeqnJYawVR1eO9gCm0d1gTI920gVEJdTLvC6pWme7R+Pu
         v6mj1qjFqHwMTfFPhwJT6W61hIF2E5iehwvjdP4HKrmVxkdrhTa/KN4XbQtMtkgW2i7X
         wvWLWBIJ+Z3NlYEtk3iZqVvoowBniVPxeN/X9aBhbD7GFLrGDMprDq/U77XXoHd3WEti
         d5WWViBYMTKVojivtg83TadTXQtnRxHb85Mm5J3Q488tuhyNbqbMDGJ83FGBL07duzYL
         kO5g==
X-Forwarded-Encrypted: i=1; AJvYcCUJsfjmeSlibSicOwRumqkAfzQMSHAAYv+448LUrXIf9rIOM4XblRGJkAW/DjA2sxlv1j7gmg0lANG7EJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqurRasjEhN3zIYpBNqLIy6Ou9onCjIZVAay2jDYOl4k8uZxGI
	JW+Iv/SRd7xbHa8hJcz51j+v13HLJcASBmpjZ+oiKbzlWJK/umKNvx3Tk4buE0fNeEo7CwXiLMs
	91EwAqCN7omrK60O7K9iBZhsjWc+isrUYmwrXAA==
X-Google-Smtp-Source: AGHT+IH/SwAi8KLM0yeMY8CjaTvOZhn5MgmfhtRwVTj92jYxo65VGu6YYQ83n/Sa5TY17gIQdFKzZPUjfjwKlGMvpQs=
X-Received: by 2002:a05:6512:3ba3:b0:52c:e01f:3665 with SMTP id
 2adb3069b0e04-53438783dd9mr3785098e87.25.1724509906414; Sat, 24 Aug 2024
 07:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814030155.3876069-1-liaochen4@huawei.com>
In-Reply-To: <20240814030155.3876069-1-liaochen4@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 24 Aug 2024 16:31:35 +0200
Message-ID: <CACRpkdb1VxVv1Yngyi07=GmCLxiCeVZmqGvmcOrYOaLzW6CkqQ@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: pinctrl-zynq: fix module autoloading
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 5:09=E2=80=AFAM Liao Chen <liaochen4@huawei.com> wr=
ote:

> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
>
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Patch applied!

Yours,
Linus Walleij

