Return-Path: <linux-kernel+bounces-216932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC1390A8BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01992811F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD156190661;
	Mon, 17 Jun 2024 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/3fepbZ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F099171B0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718614096; cv=none; b=cido+lOPBYbdL/W2OQTieh6KYSt5I6QvfhGjMaSH67yVwAusRMyNca8WZSRqlF36HbFzNe7B4S34jLdLEErtSzgZER9UiIrh6SlegcgQsvBfNL4bDL+b8YADZMNgt8Zm7hxT0NaZRBdJczgvzHjn9yd7wG6DSAbVYfkLgi8VmZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718614096; c=relaxed/simple;
	bh=2kM/oHxrBScBuC7PXXmXDeLBNjTC/Qxpp/mhHadLs20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWygLwDz4evQNTvu4Fe9bnCBzJpy+6OwUewqcGLR4nSvMkAv3vy4wM0776NR/1eQo9l3XwI3m/g7fbnEQ0bmdPM4CcAcujpmzEhiNqXiFFqNkuAv5JKy6YrnE6QAmA9tADBhMzCtE+16EOoISHb8nCZphXc7b8lzZ8EpIbUeyAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M/3fepbZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52c85a7f834so5326421e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718614093; x=1719218893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgNy9aSeOjtMvdyT2zIBjwfBSokXxGif772o4A37SX8=;
        b=M/3fepbZr7BzTtn0VmT54aEdY/22PexeLFOZkIdqLJ4un6jVMjOHZGky5v5Rcgb5GY
         LgbtTUIMLEbS6rCoRq2niWAxBj4NxCt4jkJyopnvLrFSHgQzcn1dy4QGWjQkqvXqxpdW
         l9sxl8JSdaDbUCaL6O2kqnzVXEbk4K4QnVhTRG18FLqtcANTLRrwcZni7ubjVeXgaSsa
         SCor4erZtwJrip1Qwuzs5/DdzWON62G/O3dpkll4tRWVRCDXAMFnxkvaY9NW9VmFKyKn
         82iFvkFsLaZR9V/ZRYotAO3Y/WqS69hj/BlvUvhccXPZcW9v3tmZzPYhWXuKvTXySooV
         txnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718614093; x=1719218893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgNy9aSeOjtMvdyT2zIBjwfBSokXxGif772o4A37SX8=;
        b=OhgsFFj+aF13jib6nKrePrW01ZOTdE17Epy68iCGdEiTfp4VK0l2RAApv6Sdcw7y6c
         BX6YQfj8fCo3e6qjV2/UrRGtDhgW6YkYwd4zNQqmyOnXIp5wHLtI3/+s00Y8oMLOF7Md
         hEEpTU9Hugbqq+cN94jgzrrFpvfpkIFdS1k5H49PQDP8Fd5+TLu0zNsVqfLJEXAN2M+B
         +VdG8q0zced77zekZN40JRyUHV70D9o41g9AEBLsDlhZv5Az+Mdg6XwmdQvfxNFP47EP
         NNS6mzhOPf4Sx4EsyzYH/HqKAvXzJG8nNxQMm0I5A2fiUR6+Z7VKztuWXBBwJZTmGdH2
         SbpA==
X-Forwarded-Encrypted: i=1; AJvYcCV5SLZwMBGWawgBEdvFl7z2rh78iOMHNL82svsErTyoW5VbdLn7jbTSkrh2dpGHJ+luDngiVv6wo8aE/cnIqcq2EdkPE/lb1bnpRVHJ
X-Gm-Message-State: AOJu0YyZTve+l3FgzJUTJQ7Xha/LFOKTcx6Q4z/CygOYXVjR80eh41W7
	QBcRIN1wzIWsqOBT6LpEFJl8aWkPBBnuZE7wkNMsuEYS5vF/AKw1BERU5YNkhZbsUlnUa8TGHL3
	fEeQuvV7juUnpKzyB3ti7j6pqNIMmXgW1xbgDWQ==
X-Google-Smtp-Source: AGHT+IHbOKQhcmgxz7j/vSxObsm+6bA1uZav4s2Z4EB/68U7Rs3mQDLz30rV9Ja8l7chB7w8ej9DjSMq6TxD8gV+Sik=
X-Received: by 2002:ac2:5e22:0:b0:52c:9725:b32b with SMTP id
 2adb3069b0e04-52ca6e6572amr5414563e87.17.1718614092791; Mon, 17 Jun 2024
 01:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610223550.2449230-1-sean.anderson@linux.dev>
In-Reply-To: <20240610223550.2449230-1-sean.anderson@linux.dev>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Jun 2024 10:48:01 +0200
Message-ID: <CACRpkdakB0vekDYaWYacfvo9DaGzJfXAqT97aG=x2g4eku2CbA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] pinctrl: zynqmp: Support muxing individual pins
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Michal Simek <michal.simek@amd.com>, linux-gpio@vger.kernel.org, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Krishna Potthuri <sai.krishna.potthuri@amd.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 12:37=E2=80=AFAM Sean Anderson <sean.anderson@linux=
.dev> wrote:

> This series adds support for muxing individual pins, instead of
> requiring groups to be muxed together. See [1] for additional
> discussion.
>
> [1] https://lore.kernel.org/linux-arm-kernel/5bb0dc7e-4c89-4f3d-abc6-41ae=
9ded5ae9@linux.dev/
>
> Changes in v3:
> - Express groups/pins exclusivity using oneOf
> - Fix zynqmp_pinmux_set_mux and zynqmp_pinconf_group_set not handling
>   "pin" groups (thanks Sai Krishna).

OK Xilinx are happy, I'm OK with it.

Patches applied!

Yours,
Linus Walleij

