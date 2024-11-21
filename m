Return-Path: <linux-kernel+bounces-416507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA059D4606
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB82828229B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268A75588B;
	Thu, 21 Nov 2024 03:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8bG26Zb"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5911304BA;
	Thu, 21 Nov 2024 03:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732158312; cv=none; b=aJCa6pNTlU+oW8W8tgjyx5blXQfCj8fU8iEg2XsveEleXiarPF6h9weCNGvpk/AwP2YzzjLIufmPNgEmfuoyXcXiYn0yrzf9Kd3upUOLn8dHFXG7XowaLEDJ7KCIWGx0uu++WlwZccqi5QcWfNcXtKlPLoEwH/8gFPg/9U1iDZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732158312; c=relaxed/simple;
	bh=eh4WTmd0o6LgTFMaumz2O+q4ERF9Zp6mWfZv3252EI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJpwkuu8CkqWOKRVecgtKSIgohGN3Byh140UnpzCHSijAN6pgjKteJUQfMOBkzFsHremtvMhomQLPWBdBgRkCdNRFkAf45AWLkh6wOmR7SwswozLznbRdO0GPJwH1l7xM1nitnAMLgOaRmff48nWqO5ZuH2jWw+aPiUJLzB2yZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8bG26Zb; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-718119fc061so183906a34.2;
        Wed, 20 Nov 2024 19:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732158309; x=1732763109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eh4WTmd0o6LgTFMaumz2O+q4ERF9Zp6mWfZv3252EI0=;
        b=k8bG26ZbWVUXZtndLUVUaCxwr3NhtMe9Mj9EJjbu2OlpaPzJ5AWZEIFdI7ZibKA8Jl
         7fYBrKolMFp1+7kP5f5yhbacAAzrosUieNHe8sq62qHue9r4ckvZFHHXcjY1aaaLp5Fs
         sATXSnr2dB8+fk+JslYGfliDL5XGHfiniiQSTUawKGODdTsGhqn7X1C2+7rrEUVgnJPG
         GWOgxzGgdBdrJK7U/YFtxcwSfQia8WJFv1bNcJW25jOlM57pDk3x7aMhrE9sQWjv2ssT
         siKMW14RzThw3Ir6LHZQbURdDlwHeO4LrTcm8WToGQ4K22bsnGHLa3O++L1uG29KQSwb
         VAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732158309; x=1732763109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eh4WTmd0o6LgTFMaumz2O+q4ERF9Zp6mWfZv3252EI0=;
        b=Ls9SHlCKfHZUvHN6FBcf/nXomRR3V4sStoM2HVx0Pc/0qrwjpV4xlyAjSlU4TzUge3
         98CYhrAuAbQp5wHzJ62IkrLQ0ZwZy60gYTCxRfFlcW67vbZf178ZL/dSXVb2MZ6PPN+F
         g3SGi6U6nKEvr8WGhrobtBrycrGOBKhOgEfrc4xIx5PZrTr068hRu3HpWX1T8ycovlpE
         gnV27qfUIcHlIdl3VP/MMjqxA0jphIuotMc7ENE0FlRD57ya2aXw+8c6KtP0Y0FZum28
         4uYj0OL3duWF5vWRUskK49hbOj7TrvhnDTFC4Tal8AJUPBKBWHBePRg66Pc67aBvBldE
         N6dg==
X-Forwarded-Encrypted: i=1; AJvYcCWStzWgDWS8RXLecj4915CFL+0jiQqJv2aeevTJqSu+HPNS4wwq8Z/nFH4AwgD6tCHsgj7QDAogP6lJJXCX@vger.kernel.org, AJvYcCXo+ntH3fR8zakEDNXORbgww2jJ53aADLOexMx9YNbrEI4XipeYkdYRennzooiZxK97opJXa2wMUGoT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0Isq1VZIika3pI6pQpNdI6rWqHYtFek1OnluqfnXCwLXBWwX
	XNEL+t6xLaLvQRpQ/l99o5sl042T9iz9nG2riudmoH70GpqYKEzj+7MZhpcddLDGdeAyRT94pc0
	F2gW7DNt6Mj6X3WFR/odwXf/xMYrdOSdI3t4=
X-Google-Smtp-Source: AGHT+IHC0Hi4TRbTyqSMAzvY2xpZmEGaBrgPJ662mMXVe94zOXUnU55gFSpTgnNBYDwawIZOimVu9l6FSf/bNM9wSvM=
X-Received: by 2002:a05:6830:6d84:b0:718:9c7c:2b33 with SMTP id
 46e09a7af769-71ab319bee3mr5549036a34.23.1732158309131; Wed, 20 Nov 2024
 19:05:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zz3SnIiW_iu10rrs@standask-GA-A55M-S2HP> <a31e5b41-d495-4b5e-996d-1cb0a1f6929f@linux.alibaba.com>
 <afffd5e3-19e9-49a6-8854-039be1128922@kernel.org>
In-Reply-To: <afffd5e3-19e9-49a6-8854-039be1128922@kernel.org>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 21 Nov 2024 11:04:33 +0800
Message-ID: <CAAfSe-uHuoBBKkSU-pDaNVYNCrfgqjh07gX7jS6uvO3AQF7b-g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sprd: Remove unused and undocumented
 "constant_charge_voltage_max_microvolt" property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Stanislav Jakubek <stano.jakubek@gmail.com>, robh@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
	orsonzhai@gmail.com, Cixi Geng <cixi.geng@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Wed, 20 Nov 2024 at 22:25, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 20/11/2024 13:27, Baolin Wang wrote:
> >
> >
> > On 2024/11/20 20:14, Stanislav Jakubek wrote:
> >> Hi Rob,
> >>
> >> constant-charge-voltage-max-microvolt is a valid property, which I assume
> >> was the original intention here. I've already submitted a patch changing this
> >> to the documented property:
> >>
> >> https://lore.kernel.org/lkml/aa557091d9494fdaa3eda75803f9ea97014c8832.1730918663.git.stano.jakubek@gmail.com/
> >>
> >> Baolin also reviewed that patch... make of that what you will.
> >
> > Ah, yes. Sorry I forgot your patch. Thanks for reminding.
>
> No one picked them up... I kept Stanislav's patches in my incoming/inbox
> folder for quite long time, because I pick up some random fixes here and
> there, but then forgot them and did not apply for v6.13-rc1. So they
> missed v6.13-rc1.
>
> I am not the maintainer of that platform, so I don't care about it
> really, but I care about contributors work not being lost/ignored.
>
> What is the plan with these and all other Spreadtrum patches? Are they
> going to be applied by you or other Spreadtrum maintainers? Do you need
> any help from us? Or maybe some clarifications of the process?

Yes we need your help!

The Spreadtrum DTS patches had been being maintained through my tree.
I'm not suitable to do this any more due to some changes (I've moved
myself to the reviewer entry of sprd).

After discussion with other sprd maintainers, we still want the
Spreadtrum patches to go through your tree if you agree.

Thanks for all the help,
Chunyan

>
> Best regards,
> Krzysztof

