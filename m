Return-Path: <linux-kernel+bounces-343985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1000A98A22D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CD21F23BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE55C18E04D;
	Mon, 30 Sep 2024 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Q8FJhEbu"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F70618EFC8
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698696; cv=none; b=QM5dbz/lqP2jfWQ1OVjMLIUI7i6PoAQJ9hR4OkiA8+wkSgts/gRYyXzEmZrVuZNsaRlhbQ/kf/jmRAOVszOrCKnim+WFoWh6f45TrxP529GYFaYKSAW0HTiNhpJhqhCtdrlOSyyi5SDlFAYpKfyjHkiIJ+itcSr13d0Xqg4y5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698696; c=relaxed/simple;
	bh=KTXMcpHo0ujn+1qzOikfJeq5oh2VmZ9aQImk5g9SPos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s1bTnnFs4WYgAO3JKXhusL0wizcx3PVixC/OWfX3hoUWgnKFd0f0TW/gyrf+mv+Pqvvyx45mOlcv9skkB3pONYbram17POwMsV6SPCkjjkKMKftWQOD5twrbOrb/kwobbLqTePwZo+hIIqQr9fVwJX/ZMJkIlDhUM230AIioN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=Q8FJhEbu; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5398cc2fcb7so1844727e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1727698693; x=1728303493; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KTXMcpHo0ujn+1qzOikfJeq5oh2VmZ9aQImk5g9SPos=;
        b=Q8FJhEbuoDYLP1LGVpiK5M/DowN1VzIrD3pvTVl+8CMdz75rwxh8gjV0RVhhO1cjf2
         FVToFLK3Tk2y7GYxBQyRt+nP7OLAdgtQ29ZArVwxfplqemLM5qHdY+qtALwgyOL0nG4x
         JXMz40pFKMLaJPlTA/srfwn7K1APYMsrwK55A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727698693; x=1728303493;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTXMcpHo0ujn+1qzOikfJeq5oh2VmZ9aQImk5g9SPos=;
        b=MRs5pBpQQX0lEbtnhVCYK6zGPmVO+TklAUkEf/SBVaFA/w0yEujPml2wxZ8rJq+0R3
         hzPr3SBI7H6RORpGpfZeXzyxkM9Igjxw+EoeWfTIeTOVHk8aIbwOtZv8Nbu7qPzUcY2d
         Cx7hVhXaaQDxRq8B2B2Umdu7lyL97rzjRnyOOzbFuqtHeg9Fksdz+IktISbCpkFGLZtf
         fjbL7SOfsIjcK1nwYIBRsy7StzzVl6nuX/qD2hO8DoBQu9hZWzoKsig1kkgfL+7nvWRu
         s95vEFKfKiDbe7Tp/sZWDCMwcy6lovem9uA0hkNImRrQ9ug8zxHEMddf0NirxZDfXT1g
         lv+A==
X-Forwarded-Encrypted: i=1; AJvYcCVrWM7WGKkBS9bZ/MI3joUBLqHTxIV9BytUw8kVhmPQkHZP2MxYDhXm3CLMNRfT5rQ/P8RT4lK0dWlFsq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfHgtjiytYXlenIy/j+sSgKrzqjlktqVyvJTdXXGofn0VT74xX
	PdoJMOtvlhHB7hDl9tMCo9BThZBZk8xz2xAlbCybLoB2QzFp4DL3N9mlqQ3mX0Q=
X-Google-Smtp-Source: AGHT+IH7tKd8Kb5wNmGZw9WYzRhvagjLvmoYCWVGjpPsq6iIXxlWsAAxIloMmOf4F6bN1LUzJ1JJ1g==
X-Received: by 2002:a05:6512:eaa:b0:52c:df51:20bc with SMTP id 2adb3069b0e04-5389fc3ae14mr6437800e87.16.1727698692426;
        Mon, 30 Sep 2024 05:18:12 -0700 (PDT)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5389fd5396esm1225851e87.2.2024.09.30.05.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:18:11 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,  Jonathan Corbet <corbet@lwn.net>,  Ulf
 Hansson <ulf.hansson@linaro.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Kees Cook <kees@kernel.org>,  Andy Shevchenko
 <andy@kernel.org>,  Daniel Golle <daniel@makrotopia.org>,  INAGAKI Hiroshi
 <musashino.open@gmail.com>,  Christian Brauner <brauner@kernel.org>,  Al
 Viro <viro@zeniv.linux.org.uk>,  Li Lingfeng <lilingfeng3@huawei.com>,
  Ming Lei <ming.lei@redhat.com>,  Christian Heusel <christian@heusel.eu>,
  linux-block@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mmc@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-hardening@vger.kernel.org,  Miquel
 Raynal <miquel.raynal@bootlin.com>,  Lorenzo Bianconi
 <lorenzo@kernel.org>,  upstream@airoha.com
Subject: Re: [PATCH v4 5/5] dt-bindings: mmc: Document support for partition
 table in mmc-card
In-Reply-To: <20240930113045.28616-6-ansuelsmth@gmail.com> (Christian
	Marangi's message of "Mon, 30 Sep 2024 13:30:12 +0200")
References: <20240930113045.28616-1-ansuelsmth@gmail.com>
	<20240930113045.28616-6-ansuelsmth@gmail.com>
Date: Mon, 30 Sep 2024 14:18:14 +0200
Message-ID: <87y139jpx5.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Marangi <ansuelsmth@gmail.com> writes:

> Document support for defining a partition table in the mmc-card node.
>
> This is needed if the eMMC doesn't have a partition table written and
> the bootloader of the device load data by using absolute offset of the
> block device. This is common on embedded device that have eMMC installed
> to save space and have non removable block devices.
>
> If an OF partition table is detected, any partition table written in the
> eMMC will be ignored and won't be parsed.
>
> eMMC provide a generic disk for user data and if supported (JEDEC 4.4+)
> also provide two additional disk ("boot0" and "boot1") for special usage
> of boot operation where normally is stored the bootloader or boot info.
>

This looks quite useful.

Could this be extended to also be applicable to the four "general
purpose" hardware partitions, i.e. what is exposed as /dev/mmcblkXgpY ?
These would often also contain some fundamental boot data at various
offsets but also, as for the boot partitions, often without a regular
partition table.

The eMMC spec consistently refers to the boot partitions as "boot
partition 1" and "boot partition 2"; the boot0/boot1 naming is kind of a
linux'ism. Similarly, the general purpose partitions are _almost_
exclusively referred to as 1 through 4, except (at least in my copy),
the heading for 7.4.89 says GP_SIZE_MULT_GP0 - GP_SIZE_MULT_GP3, but
then goes on to describe GP_SIZE_MULT_1_y through GP_SIZE_MULT_4_y. So I
wonder if on the binding level one should use partitions-{boot1,boot2}
and, if implemented, partitions-{gp1,gp2,gp3,gp4} ?

Rasmus

