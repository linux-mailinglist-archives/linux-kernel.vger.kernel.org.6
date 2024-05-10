Return-Path: <linux-kernel+bounces-175473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554DF8C2027
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CFC2819CF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E512A15FA87;
	Fri, 10 May 2024 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="S7dhuv4a"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02831A2C0F
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715331793; cv=none; b=knghYaHxQVnGo3isDQOwBC61sBTBYjfZpWQd+j77p2m41jtHVxkjt4FPRbIDXFcJz4YmCjEoGJ2DPFCyQQAk5QKRlugnh3RglzxTbPhj0KKd74kKQaK64XgpWx41UFyFeCulhroNw6QBQLs04e13JT4id8bmQpMYgGLdhDWmicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715331793; c=relaxed/simple;
	bh=k1gtokQ4byZJTsBGp5EqYH6DueuKF5nY32DWjEDtT/I=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdzBYwetgOOdBMWVwDzKjgWIh+RMVK48EAwwm7Ziq/mMM69v5lStmVhANGyyHZp+JWlkn/xyjBPZTuwEUNxPQj394Zuq6sHyeKzz0Y30bgWuGYTmg3+CiolS7CGwYOmjNYgpBnUCzM0W6R7bASqr5BPdBSieFQCrfxLQoGXtlB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=S7dhuv4a; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2CC3C411F4
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715331784;
	bh=EZg3bZExhlWVK50gpSicBrX5JPsAAk8r1XrLNevR8+8=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=S7dhuv4aoJrL+kHYd2Qz6GL07TB7xMUu9J/swadqSReH+qjCIyb7ottpNHmjJqkp2
	 ZjPQrniXiCf8dJ6Prd7AwP/OgHUi9zhMj1CDzd1qimXnNzGES9w95kaEE17Om8uJfq
	 +VoT12p80mVgu2Y4rQJnPYQ8MXbdnTwq0aKxJglc660W/Qcqfk9DbC4xoQhtCkw7aS
	 09RtI3KvyoRVXvXVGtWz0+s+fcUZyEZkh/ujKmoVGrVY+SIKqxKc2vC/S7v2yjo1lU
	 65fnHTMp1bSustmQpCkoJNiPvR9+6t1gavzJ0QnRl4HuBcv4JrifaMLPH7X29Vbw0w
	 qxl18Co0imKGg==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43de409b742so20170781cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 02:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715331780; x=1715936580;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZg3bZExhlWVK50gpSicBrX5JPsAAk8r1XrLNevR8+8=;
        b=Ih7o27HZUK5iHJTdGzjFipW+xsCd1/VaHzAyJhz26DpiJPJGmqCEOWp8rsOXLNYtmQ
         /CfCCPS+LB2iZXzjnpLHleMrz7XQdnQoN37MAAGmEpwhmdCKYEtZ6psRX8sCFdU7WsvF
         UYkk/jpIXt0mRvSxmItrVaXfREJPymFgv9QLXqll84M4NeKd8qj8iq0OEH9dhcsxx0D9
         8c0ngSIAF9XPwbpocLlQE3ZOIoU5n+/kQA5O4DONYEJU1+uv/wER1NR3dkBFgSOrRPoE
         ZOZBf99wmrG/U7B2nhqo8TgO+vAO7gJfqStbV6H8EWxEb5hYVvwK0GtEyJPl8QzK29B4
         TJKg==
X-Forwarded-Encrypted: i=1; AJvYcCUSWObtvEHHbtZJItplA0uine9fnpe5r04aUtrzhtU2wN8slGp395vE10WdMHeqbrwKtVxBOMM9rnVbvTdVZ9TvNQKCn2tPiYfWpN22
X-Gm-Message-State: AOJu0Yxkr3p2jI1FmY6J0qscN0BAhFVxfqZhK2027vZfTp5II8i/JLEV
	jdymLPvzuvXusOn/74I7egTOpvgliJnakYZwz968wr3iSMR7v10EIYz0xoSj3jFmyBkjsIkpdTc
	jgQGdneIvZDHOzE+phEtzMxsnhcu3tZ2bgCy6nxlhae7L0ZKhoVsoVz2dgHmX1RCGJXvOpUM4Zl
	y/15BSSSR01aoe9EdTne5QmEkB9iZlluhPS2vb84nM49M6otP2rWRb
X-Received: by 2002:ac8:570a:0:b0:43a:fc66:35d8 with SMTP id d75a77b69052e-43dfdb06fccmr22804971cf.7.1715331779848;
        Fri, 10 May 2024 02:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm3BolVFsu22mYiTmhPkAgiTCxY6SWjICQtL4EpS7KCkeY9VWrwi7XisKP2lAOKpom9apfc0uDgJLCEOJTYis=
X-Received: by 2002:ac8:570a:0:b0:43a:fc66:35d8 with SMTP id
 d75a77b69052e-43dfdb06fccmr22804731cf.7.1715331779539; Fri, 10 May 2024
 02:02:59 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 May 2024 04:02:59 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <87wmo2nmee.fsf@linux-m68k.org>
References: <20240508111604.887466-1-emil.renner.berthing@canonical.com> <87wmo2nmee.fsf@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 10 May 2024 04:02:58 -0500
Message-ID: <CAJM55Z-F6N6ua5LoqyMFogDtLp=FaRPoDv4osXFDMjR1b8r9nw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] riscv: dts: starfive: Enable Bluetooth on JH7100 boards
To: Andreas Schwab <schwab@linux-m68k.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"

Andreas Schwab wrote:
> On Mai 08 2024, Emil Renner Berthing wrote:
>
> > This series enables the in-kernel Bluetooth driver to work with the
> > Broadcom Wifi/Bluetooth module on the BeagleV Starlight and StarFive
> > VisionFive V1 boards.
>
> That does not work for me:
>
> [  +0.369276] Bluetooth: hci0: command 0x1001 tx timeout
> [  +0.025545] Bluetooth: hci0: BCM: Reading local version info failed (-110)

Hi Andreas,

You don't include any information useful for debugging this, but if it get's
far enough to load the firmware could you at least make sure you run the
version below, so that's at least the same.

https://github.com/esmil/linux/blob/visionfive/firmware/brcm/BCM43430A1.hcd

/Emil

