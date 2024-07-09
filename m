Return-Path: <linux-kernel+bounces-245017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E94C92AD0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E4E1F222C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4604829CEA;
	Tue,  9 Jul 2024 00:21:18 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816F286A8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 00:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720484477; cv=none; b=I00hXFFy261/jSD7RQvGDg7QwC+Bi12+zdKlzWcTxYE8HAlZEvDEVkXBs62ivJIQqDAmhQuumL/afysIaGLPbSbOeXay3pasvTDckSGoN5DP4VuTmpBAd5Wph5HGkpzRtm404VPZ+IEfduyWDKjQ20cJ6uF1WGkyFjVqysFtco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720484477; c=relaxed/simple;
	bh=de1avitQBiu1Fy1ZdwBYZlwPKhu/bH+ZiSpazxU48yY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q02eSg8dz2QwvpfAlImqBO8lrsYviwkoqxSi8GKaEYsBXPPuzUa9ial4ZBPBAgotUKnRyQwwmuVoK2H8TVZ5BYmlEaQDPU8WCAYJtbA88jRggDkpxbLNo7MF+lXUMGXx2ixXGbiEF647ndkdOIyyzREInkZ4iMjvzaWCmDy66RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fa9ecfb321so26693255ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 17:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720484475; x=1721089275;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrbRzW7TmvE/emyggKx8DBxtpeVLv4H61DaYvPd4Jec=;
        b=sRFaEBdUUcKnQqdYeptmDIVpbItB3At+YzZwDNwwuDG1M86DRqaLyHT7Pr/Xlkt2Ny
         RHzHyBUQIAg5grmrNqBoAj7/7okr3v8+G8gYCQNAtW5bwSdCpVGVQ0EW6mdUkv7Mt/g/
         IHBbhhVTBO0XzqkZcogfG3rk/gMQV6J9hYWgYHsOTl/RPqrg8vHEnw2r3xyiSo7PGpZV
         OucZbu0jmMKKTVNf/0ddnMC4w8ukUfxlal/W6PHJllvf2ZaIesTndOZ6DCRLFW35MS/L
         zfLfzw0WrPmY+Ghb3wAfDnfm3WboA1N/Gyn31s4D5B/y1lCHgp5PUQwCfbtC5UJVyPkg
         GW3w==
X-Forwarded-Encrypted: i=1; AJvYcCU0txmnMSU7hQMi1NV6V88eekfNN9NEGfvGt+LtEdHRDkWvAucA8AFo3DCXGSiUlyyzDsrMJcsH771gGcc8sZsRxkhLA9Gk1UbX7b24
X-Gm-Message-State: AOJu0YyZ7q649d8JRQJETiwKX2LvzuNKOJZ8Q1YsEh7UAh3MhGACW6OJ
	iXit7VlJBbKqNvpj5nTtwvTo6tU9Zv2Eejb4cypKKpnVeLgRpul8oTKjRu0mUYY=
X-Google-Smtp-Source: AGHT+IFppyFwTeQ3Z2Thxvru++KEqbVGYMZHsFalxNlJLyydnbWVl4ppQ4d3ZcJeQ7Zn8jsELviLTw==
X-Received: by 2002:a17:902:f644:b0:1f4:620b:6a27 with SMTP id d9443c01a7336-1fbb6d25158mr8435815ad.13.1720484475579;
        Mon, 08 Jul 2024 17:21:15 -0700 (PDT)
Received: from localhost (97-126-77-189.tukw.qwest.net. [97.126.77.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6acfa67sm4227455ad.266.2024.07.08.17.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 17:21:15 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson
 <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: ti: align panel timings node name with dtschema
In-Reply-To: <b1f07743-a2a7-4984-b168-0f08e87ce0ec@linaro.org>
References: <20240509104813.216655-1-krzysztof.kozlowski@linaro.org>
 <171940115812.32431.4234002524799635130.b4-ty@linaro.org>
 <CAMRc=Mc8ET2GneRT_PoGvffe+c5u13zAYsRr3u5P+aRzQv4CAQ@mail.gmail.com>
 <b1f07743-a2a7-4984-b168-0f08e87ce0ec@linaro.org>
Date: Mon, 08 Jul 2024 17:21:14 -0700
Message-ID: <7hsewj76v9.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 26/06/2024 13:47, Bartosz Golaszewski wrote:
>> On Wed, Jun 26, 2024 at 1:26=E2=80=AFPM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>>
>>> On Thu, 09 May 2024 12:48:13 +0200, Krzysztof Kozlowski wrote:
>>>> DT schema expects panel timings node to follow certain pattern,
>>>> dtbs_check warnings:
>>>>
>>>>   am335x-pdu001.dtb: display-timings: '240x320p16' does not match any =
of the regexes: '^timing', 'pinctrl-[0-9]+'
>>>>
>>>> Linux drivers do not care about node name, so this should not have
>>>> effect on Linux.
>>>>
>>>> [...]
>>>
>>> 1.5 months on the lists, but maybe I combined too many separate TI main=
tainers,
>>> so no one feels responsible... then I guess I will take it.
>>>
>>=20
>> Yeah next time you should probably at least split omap and davinci
>> bits into separate patches. Otherwise I think Tony thought I'd pick it
>> up and vice versa.
>
> I guess after you acked it, Tony would pick it up.
>
> Anyway, please let me know if I should drop the patch / resend / split et=
c.

There's a bit of a handover transition as I take over from Tony on the
omap stuff.  Sorry for the lag, but thanks for picking this up.

Kevin

