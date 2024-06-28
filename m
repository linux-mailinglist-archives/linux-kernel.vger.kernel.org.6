Return-Path: <linux-kernel+bounces-234488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7021291C74B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2797A288026
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9C77114;
	Fri, 28 Jun 2024 20:24:07 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CA66F2E9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606247; cv=none; b=eBXesw/52jEmxICb1nQmdWda7+dLH/1MndOpQQgqEJ3QqH1RbdcT9mrkuNk6jowOqu3Cf+1X0QHT40C1Zn4ZsaCl7TVN4v4FRfeDYtUwYYUByHTtvFbOd+gcRVgqDqiVNWLLj0xxsnigbEng8kyx0Pz6YLv3AHv2tT3XIZo5JFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606247; c=relaxed/simple;
	bh=LrU/vFZBwQrEY3O4d/bDlnG+nvye4/jK5v7HbWF0d/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YSc3He3/qBjPFa+C9SEcYeOapsUzf+vMXAvHnKGtekMCHKGlYpYOWrt0QvZejcr5RmThcisPqX+d6Qxi92DSvL9wNKkwlLH1L/g1xVqO+camN+eHUec6o6/O6ajMSM/UjeloYPIrSWLYZoZ4vPS0JrIE/EHZi3R8BW9BPONjDiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9a78c6c5dso7185465ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719606245; x=1720211045;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrU/vFZBwQrEY3O4d/bDlnG+nvye4/jK5v7HbWF0d/A=;
        b=Dwx2iPQK/Uq6LkDmfxzmxCD4tiALIjTFKzEwDcHA84fVPMNp3rviy/ZA0FHsg49EQU
         8d4/1Iu+h+RZ4meEfPFdFnPOk8yg5iIl0tDh/zW22oHoSDbL4Nc++e87ryawjMOu0Lzo
         ZDpRYVcumyuNzVMPRgaxCJQdNpHvS3i+pjaawgsjzl3QmWJwnV2Ura6uBHe+8alPBOmG
         yInN7vIxf2Zn21PBsxX42gYmeHper/tQEc26s3x1L0pbdJafkYWIpJuUV4fAXb4uGeX6
         MqREWv0skToAKxWVUWz+4s0sIC5jDbNGhmJjoI7k93EfIZkSfhfPj+A1BdBEl8aLFoFr
         P5+A==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/UsHswFK+HDLiJlPmEL/YjL2hwSZOglmTa+C/oNb0A3ZzAPQizgCnrkTZYnC9FgmUgiWnWJUXv/NKwgmenlp7EZtK0Cfyb4w6cL4
X-Gm-Message-State: AOJu0YxAyqYBVNGKz8rVwiYbO/QwdjQEgcJfrS2LYNxE1n7WavoDuFBQ
	MLF+NrYMO/B8SjbiInDrRVbbK9VthwWHv2e/5H/WNwr65r9XrW00Ux0CiiJEfYYFLqIVJ8H8A/E
	Y
X-Google-Smtp-Source: AGHT+IGsgsVYu6rWLpCbmby0pBi1fFO3CA/5IHmqHnu0PlXeWkGkqHi0uDn6hd57XrYtAzALVB/XDA==
X-Received: by 2002:a17:902:e548:b0:1f7:1aff:679e with SMTP id d9443c01a7336-1fa23f49b40mr164375045ad.66.1719606245335;
        Fri, 28 Jun 2024 13:24:05 -0700 (PDT)
Received: from localhost (97-126-77-189.tukw.qwest.net. [97.126.77.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535b5fsm19527145ad.174.2024.06.28.13.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 13:24:04 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Robert Nelson
 <robertcnelson@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Roger Quadros
 <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, kernel test robot <lkp@intel.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ARM: dts: omap am5729-beagleboneai: drop unneeded
 ti,enable-id-detection
In-Reply-To: <2c71aa2e-2039-4941-b8ed-e7b9dd3d6d3a@linaro.org>
References: <20240615174904.39012-1-krzysztof.kozlowski@linaro.org>
 <dcd6afee-b17d-4633-af7a-4a5dbf68be94@linaro.org>
 <CAOCHtYh8YucHNwV6+S-3vfHvygs=5_UGVwPt6R+i+qBTc3eOTA@mail.gmail.com>
 <2c71aa2e-2039-4941-b8ed-e7b9dd3d6d3a@linaro.org>
Date: Fri, 28 Jun 2024 13:24:04 -0700
Message-ID: <7hcyo0eryz.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 26/06/2024 18:48, Robert Nelson wrote:
>> On Wed, Jun 26, 2024 at 6:34=E2=80=AFAM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 15/06/2024 19:49, Krzysztof Kozlowski wrote:
>>>> There is a ti,enable-id-detection property in the Extcon Palmas
>>>> (extcon-palmas), but not in the Extcon USB GPIO binding and driver.
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202406152004.F2fNnorG-lk=
p@intel.com/
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> Tony,
>>>
>>> Do you still pick up patches for OMAP? Any comments on this?
>>=20
>> Krzysztof,
>>=20
>> It looks like Tony didn't send his final MAINTAINERS update:
>>=20
>> https://lore.kernel.org/linux-arm-kernel/20240419055249.GE5156@atomide.c=
om/T/
>
> Oh, thanks for letting me know.
>
>>=20
>> @Andrew F. Davis
>> and @Roger Quadros have you guys set up a git tree for omap patches?
>
> I will pick up this patch to my DTS cleanups/fixes, but let me know if
> anyone prefers to take it instead.

As discussed with Tony, I will be starting to manage patches for these
platforms next month, but I'm happy for you to take this.

A bit late, since I see you already applied it, but FWIW:

Acked-by: Kevin Hilman <khilman@baylibre.com>

Thank you for picking this up.

Kevin




