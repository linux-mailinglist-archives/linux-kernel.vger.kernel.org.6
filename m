Return-Path: <linux-kernel+bounces-543442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FCFA4D59B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CFE173261
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68251F8BDD;
	Tue,  4 Mar 2025 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPSb3OYt"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6581EDA0B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075286; cv=none; b=bNEPDG8zJj3i9JjcEwwFMawrZXaK8+gEin1TvlVKjkQsyndNJW+51Cf4W1bXJIF21xaW93aZ/Rbswlk7fGEpf+tI3U+XGbC9GGHQKgxtjEjQb7uL0nbI1+CbJQjykJmLULJE3WOgFYGuZ/HA3zd3bcxQewnsPXv4Ymm22aVdJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075286; c=relaxed/simple;
	bh=yM6piAILnQk9xGq2GxzFHXReJiLNyLpTJqnfUjNN9hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCmV3Dn7DoSRAsv3wNOeVczVrSz3xVS94lr8a3WUWC80wI5bfgLIWI9Yv45ok/9zn+EH8zRpxqZEmLmPklgXEZOxHAYO/W7hHQoU8g/pyBqqu4zsKSMBeMX57xJILumZWlVlGuucO4bM6tMAu2tJ1kydlAukJgUX8oGpTWaEKNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DPSb3OYt; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6efe4e3d698so47524497b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741075283; x=1741680083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM6piAILnQk9xGq2GxzFHXReJiLNyLpTJqnfUjNN9hk=;
        b=DPSb3OYtRAl9eJzUnDMymVpwekzT1bupKpE5lmtkv5Tk0bYTR75QwDtv4m0WJ0cQp1
         kXDLEnVrv8qle3rCgGK2GvD3+TgqX60D8iaYc6dgbMHKLvj3V5S6Zas8sm+0XbXFsHgp
         elMMgp57dpEPFjFrl7ky4G7jTQDLEANihg6IxRNkqohBl9ZbdYKy2qnPcf0IXpE42uwS
         4b9n58WjZJtkXp9RHE1QBPAorVei4m/VJp41rJ20EzXruBtPtMeX8suL4v5uJM1mz/3j
         CkBX7EU8vmnCceQAZm9jn8361NEcb+qm1psezma4hShPmoZt7VfenWXJGr75zgU+meR7
         q1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075283; x=1741680083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yM6piAILnQk9xGq2GxzFHXReJiLNyLpTJqnfUjNN9hk=;
        b=DA7Sxx5baqOW5dcZzKNkOcM2Acx4ADuiE9FR/0iFWlh2qvfxjz9/PCWRRoEBbkOiPN
         vA9fNwbrwIL+M3m3K3jaVSyMCVO5n4i2bkSZ8AEfKnVsl5x6YzjIjBCjuD4Svhnvlx6f
         igChA6zOzRAjqlYzm7l08V0E4VyxZ+2u31NtxTWbezzgKp1hnZPdG4lYz1wVd1WXZ6GM
         1JnKo4yp6EDjRFEUaD7XGUAI5Lo9KKb1WfUf1ifVlGFwCpcPOYouK4apolfzRNE3kZ5I
         Uubs7cMoVccaj+aikNovZTTqPOKTlX1aZuiFxTpQl5q5JxXEY5BSUzhiR5uve7m+dFK4
         1l4g==
X-Forwarded-Encrypted: i=1; AJvYcCXGSBTXil2mMxZCHNagv6sjXd35BZiPwmykHSBQ3XI/bHX627pgDK17uu13O8MOdnY8sEz3vsdpTE17o1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRzY9nOtNYiLf8uSpAexaPBuOWa2GyxGQbBQWVvTeyKEIxd3/B
	pjjBv4fQmVXvGsnK9V9BgfdJ92M3+wYGIf4aLJXp3H5pAWUVengvfF9mTRGUOtwceMy+a640aJk
	NokIhw4r+AiD6HCTiMj/trNpOTqWx7JkjB8EADA==
X-Gm-Gg: ASbGncv/p5KiRYR5hQB4FCvlrP3uqBM+j0hRRTA+Iu+jyiPIEdStdO5Ai7jYzu7QI0M
	ZnJu9wizZcwHCaplDTXdn3tzHkvPV6Rtgkio3XTxZsqplSiWnPN/i3ONH5prckJBDqd8e1+2QvL
	wr65OqOU0TxudWNR4SgyrM4Sfbdw==
X-Google-Smtp-Source: AGHT+IGAv1QI6NxLx4aSutmM2eABQddCgvk11+0H2Td2ZN4KP/uMxodKgMJh5YrQ4faawCMRD4vowNlT+PD+ek3jkU4=
X-Received: by 2002:a05:690c:b8e:b0:6f9:41e3:ea4b with SMTP id
 00721157ae682-6fd4a059726mr195363417b3.9.1741075283608; Tue, 04 Mar 2025
 00:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-max77759-mfd-v3-0-0c3627d42526@linaro.org> <20250228-max77759-mfd-v3-5-0c3627d42526@linaro.org>
In-Reply-To: <20250228-max77759-mfd-v3-5-0c3627d42526@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 09:01:06 +0100
X-Gm-Features: AQ5f1Jr4hfcQtwg_ZcA-Ydn_kIMJZb-DCuZHup-eBLnhS1CYHvK_yjDzqNv-Zg8
Message-ID: <CACRpkdYYpT1ut0EeP03p-UK4NZfYGb_ykc2CE4yo7jx+sF+Xig@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] gpio: max77759: add Maxim MAX77759 gpio driver
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 3:25=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:

> The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
> includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
> Port Controller (TCPC), NVMEM, and a GPIO expander.
>
> This driver supports the GPIO functions using the platform device
> registered by the core MFD driver.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

