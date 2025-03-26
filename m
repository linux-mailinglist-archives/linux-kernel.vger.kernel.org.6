Return-Path: <linux-kernel+bounces-577450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CF2A71D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F3E3BE9D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CD122333D;
	Wed, 26 Mar 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVuAxYUT"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4E221F3F;
	Wed, 26 Mar 2025 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010226; cv=none; b=PYoeuJkIdX1ArcdKy9h5q065GsC4Pb4EQcZ+MjBzU+Qi3yr9csrJxDlWD3/Z132qGPsvJJLuCHjHhKT8OgSMY1w4KF63Xc33mgz5R5G9OhHzFzups1F8v3GKGbSKsO2loUrfiiN79aMU1UGSft3UbSvxTKGoPolg8V8MDaxpahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010226; c=relaxed/simple;
	bh=EcRjcPdjQo+dXhkK+2xFpOJclgoN/w3gG0lUETPUZ4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvsvW1G4DR3jZS6NGhlcMLF1qz9QcVZM3GkOZsmGw7FvVh6LdI6EgSXCAZfWjUUabbMy+x5LPHuE0bPGCM/nXWV2iPNYO8P+tYDpqAjyiWd9KlbHBWcB+MSbr6U3TPpbGEiGZKmVN1Zf2N9ZNpiwa8hJBj8e5YtNFkDnjP60eb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVuAxYUT; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so1445301fa.1;
        Wed, 26 Mar 2025 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743010222; x=1743615022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+m5cMXrL7l3BZmYA8CsBjKQ4RsS0WZv62aTDbJ7lIbE=;
        b=bVuAxYUTVk/ei4X7tnMtPSuCLHK9xEbsHp09TUcqTtMY/Nxkyq8xCaZTo8rpjQZslL
         rKlER8Mt5Qz8F5gvsKSPSi7dMeAcbfMteMnqL6Ji4tdi0eestDBgCOWFzRwsWVj3/8hB
         f9jfdXC0D8pUagKxU7CSNbe+gKoIo70+CDH9FMv6un6014PQGFoBcSqPzFX4pXR/fnoS
         YoMMgeDjVhdVyxFA/Y75JE1anINomP8pxLiKy6SmGy7t/579nrW2x7G8aQ/Udo0uUeZC
         YIkPL/nueBILZWlG42qCVIULx9U2uIvpcGVkz0Eg+ctx4RlD1hA1lEyqe2SaOgeMHn7o
         hVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010222; x=1743615022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+m5cMXrL7l3BZmYA8CsBjKQ4RsS0WZv62aTDbJ7lIbE=;
        b=Q0ICz0+UPFx7MOiBsuQsGQyE3ptEdXcAqkY/eD2BJ+jhIpO6ObSh2m7ckHt/wQ4TYB
         ZG636ZawWLdtlGy9n88x5y/LB5CM+G0FPRO19l4XWfqYbfj5DfAMSFMZ5oXcWzk4tsuw
         QsNxG+nr+lFrRgRB77UurC+H/iLYaFUmPPAcPGZpht4Yo1emc51zhg8e5UMYouf+/TpF
         drJjS1GZnxZ2ilwr1YhClyJejAnrtP461V1KPDKWMI0RigbJiuTLGBozWuGpy3T5SdBt
         eZocWJw0netWCmLho/0xdr1NC10CvQlx/huqIsKcJyUxsR3OKD0p7qnoDuVh70zqio6O
         p89w==
X-Forwarded-Encrypted: i=1; AJvYcCV3+2sBRWnYV7vmgt9ABYJ1aV4vy+AoC+yBepMxay3wou/79pKasPjt2L+GehHM9TCKpe3VC2w7M48EfPzs@vger.kernel.org, AJvYcCWqCRN6md5h3+5Mj0/C/Go6m5rPN5mHDzEAKzcZIx4NuCC5WPrmHej4zCZhqxJVPHuZQXn5bTJNgcYD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2LKl4OC34/M/H6MT2UE3YR+sDyTPH+CmJ1Oq/1g2OUSVuQs26
	OAX7vfU82pWa0h6LG7zoE41TVmKSpHHhrMICRRdzM3DTrietrdtns2cxZnh+mVHPnfZ+/0Xqby2
	wZSXPdZZLTQBCeTfqdP4uZWRMjOc=
X-Gm-Gg: ASbGncuevp9CKwASRCm0V5fLptUfioM4B2r3JyfN0lArZPLqZ9+y2YXqtPqDC7dg38I
	CPPclp4M29zJi/dHKYU7qdE8k8nmZyRurM4tZT+I2fzCYfCeuGGcnHFLvHtpz7nRrr7SarYG/q5
	wl3y8L9GxIXqKM5B8QqlWFKV3aCaaY2652iXEQgYuYPX1L2M+9Apd/AiQ4Lg==
X-Google-Smtp-Source: AGHT+IFy2oXpfQsiF/oSEf5SjJCCftSfisaTTfsTTh4qm/bY/smmWHm2+udblmVc5o4LoStMvdhkOA9tNuVutP50xYE=
X-Received: by 2002:a05:651c:150a:b0:30b:ca48:1089 with SMTP id
 38308e7fff4ca-30dc5e07537mr2635921fa.2.1743010222196; Wed, 26 Mar 2025
 10:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326140930.2587775-1-lukma@denx.de> <20250326171838.2689448-1-lukma@denx.de>
In-Reply-To: <20250326171838.2689448-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 26 Mar 2025 14:30:10 -0300
X-Gm-Features: AQ5f1Jpt1Dn4lMf2SnJ4fyd2lcMXZdwu8Wc9IPPregswk-zkab1VQhDlRvlKyys
Message-ID: <CAOMZO5BTEPL8qP7wP_AopYttWSFtu0Mw17zO1HaXv3abUZZeHw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: trivial-devices: Document SPI measurement
 on LWE boards
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Noah Wang <noahwang.wang@outlook.com>, Michal Simek <michal.simek@amd.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naresh Solanki <naresh.solanki@9elements.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi  Lukasz,

On Wed, Mar 26, 2025 at 2:19=E2=80=AFPM Lukasz Majewski <lukma@denx.de> wro=
te:
>
> The measurement device on Liebherr's (LWE) boards is used to monitor
> the overall state of the device. It does have SPI interface to
> communicate with Linux host via spidev driver. Document the SPI DT
> binding as trivial SPI device.

Can't you use lwn,bk4-spi instead?

Please check:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/misc/lwn,bk4-spi.yaml?h=3Dv6.14

