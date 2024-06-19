Return-Path: <linux-kernel+bounces-221662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3667590F6F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3EAEB2206E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F700158DA9;
	Wed, 19 Jun 2024 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nInh2kjm"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78A155759
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825358; cv=none; b=fPPOukP7t8nUHB5t1MQ/DO6163rahXj6dBFQpY0iiEPc3nyQ68AXpWIs+H/Dd7MpAa7m+RFVJEq8llrZHcImrWgvoPKbAkI+KC9JfpMtUsl1JPLMmM1RNgbyJ8gvENgbbzXL3i1BpfiE9Wf8trDb44vcLXN3YDEiqf96WrhIO4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825358; c=relaxed/simple;
	bh=1SXc52g+zhJGJZ9WknweUhXNqTt2ao1lVhNUkIST54M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VP716pN249gzP2PRC4Oot3cSQgCzWVq7BJkhu6HmvcSglqhclE9judJWyI7Mue5Pwjsg47NaqDUhVRueegID6mSXqGmVJTVgUIZSlgfvmJPJso9RWWc5zi/yu0JNHR5GFv2pfxDIi3fJLqmtPH1RG5PW4N3uvImOHpbt8BtaiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nInh2kjm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52c32d934c2so141276e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718825355; x=1719430155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sizxqf/p+Ad13rP5NaIetozu8E9y9ijMGImLu6tat1A=;
        b=nInh2kjmRTpQcmXG/2/AHC8Lw3rX9hLk09yUGGxYXQtUu33hawYcjWNZVaNN2jSLIm
         k+1A1LbI4d4MNJXxfO6SZW31L/jDaqbeGOcqaD3gZIKQqTUWbVHrQHoj5VUty4ExFrmr
         0U7Uv4yIcVSZSq6DCDslTNncg6R/wOlafSVip0tsBX+EX3sa67j7qsRfUZmLNQoIk3WM
         RTdS5JlMulpQC5uZeBy/3mOwbW7jR6pGON4ruVruYB9G8xKyOZQGSzRtM3MzCMjaSbyH
         UZmXO+A3immYXXBguan/0s5l2o0aaDrTHt8yIwJGLhuvk9WJc/X7wUGZv02adtIcLZcp
         xsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718825355; x=1719430155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sizxqf/p+Ad13rP5NaIetozu8E9y9ijMGImLu6tat1A=;
        b=J2YRgGW1vFFYIZlFzr82q/vgAQQIiVIdPiWWQNZcjGRi4KMxIz45Hnun7++OwtdiVW
         NJHzwzCsfKjQVG9Wd6EsALv8P0jQclcdgNvjrFfJJ/huue/Ms1CKWPEn7rjFvWtMtUYD
         WQJ05UTJses2kfyjDdgGCIu8Pbr1l8kGLJVAlhtYqfgo7a7rKSwGP3R4CQ09PO1m9zUv
         WGbdlijikYbi0BQ/b2EfNs4eGsQLNKch+/2qQY//xzzs5cCTQvrClyPrgWpKuQ+lZ98z
         RKt1+7xWeNWsTTsmv2nFYW+2+11SKh6PD+tkKk/hjUOuFy83d9KxzL72K7b75rI9HY9p
         einw==
X-Forwarded-Encrypted: i=1; AJvYcCVJUrMqJYi2Ph9wB+rPit5B9QPSsMIFN/jn6gn7TI12sHasZdLegAJex7sFbNIXlNGanciXVrQkAlt/5AA1890JAmXBZ2es62+RBldW
X-Gm-Message-State: AOJu0Yz8ieSWFFwHoTkT42Gh6c0RsLwDbCfgjbxZS+DG983C1NilQDSH
	EcupPv4LT7t5lq3sj0IHgfmH1fgvNFVXsW8gGvSQBoy3eyRqNp/Bv7xEstkuOf7jHI476iM6yGw
	bia3xOtvFJFm2VgvDULawy0AnvvB+vsydEssG2w==
X-Google-Smtp-Source: AGHT+IH/SFsikh0a7Jr/pP4kVDIchxhejysWu07Ul9ypfLKXOG9XTdZtFR6KlZwkn8zT1K3TP7nGNZxnhwc9pC67zws=
X-Received: by 2002:ac2:4c06:0:b0:529:b5ea:fda5 with SMTP id
 2adb3069b0e04-52ccaa5459fmr1881427e87.53.1718825355350; Wed, 19 Jun 2024
 12:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619184550.34524-1-brgl@bgdev.pl> <20240619184550.34524-2-brgl@bgdev.pl>
 <bedd74cb-ee1e-4f8d-86ee-021e5964f6e5@lunn.ch>
In-Reply-To: <bedd74cb-ee1e-4f8d-86ee-021e5964f6e5@lunn.ch>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Jun 2024 21:29:03 +0200
Message-ID: <CAMRc=MeCcrvid=+KG-6Pe5_-u21PBJDdNCChVrib8zT+FUfPJw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] net: phy: add support for overclocked SGMII
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vinod Koul <vkoul@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 9:09=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Jun 19, 2024 at 08:45:42PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The Aquantia AQR115C PHY supports the Overlocked SGMII mode. In order t=
o
> > support it in the driver, extend the PHY core with the new mode bits an=
d
> > pieces.
>
> Here we go again....
>

Admittedly I don't post to net very often and I assume there's a story
to this comment? Care to elaborate?

Bart

> Is this 2500BaseX but without inband signalling, since SGMII inband
> signalling makes no sense at 2.5G?
>
>         Andrew

