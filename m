Return-Path: <linux-kernel+bounces-380412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8198A9AEE15
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35E21C20B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858EA73446;
	Thu, 24 Oct 2024 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IilLz9qe"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524C11FAEEB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790980; cv=none; b=O3av4BJ+yyOX8j0nj6nfERKJmcMLMIiaV2xs2USeo1zG+UHvSu1iS+cgCR4ORdMSqXBBSW0iLBWYJs+G3n1txrRRnlgAOgpQ2PgDSv2kZdylZMAr/cmestct+OV1eBu0P7aRsUgaIou90PPoluFK1/kmbGL0Gl9vKo/L+VLEsvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790980; c=relaxed/simple;
	bh=r+V3PDXCnVyOx6pH7r2zTPAXQhdpHz0gUzjVzrgQp5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmCrhvk11vnqOnpVP67NTIVRZjnN2F6gzGfPLV0NAKrMbDujAF2p1mgFIAKQ3UHkuH8AK4EEp+TM/t/NL3o5gzs3wMRgYTyQ29q/b26XwHCkGeEy8IccuZOJ/S4YmIJbpEuMPgPOtDgdvSkm6GoOQgCoerjrC2SsRtUxchAZygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IilLz9qe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c78a10eb3so1189105ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790977; x=1730395777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+V3PDXCnVyOx6pH7r2zTPAXQhdpHz0gUzjVzrgQp5g=;
        b=IilLz9qem8vxGuMf/T2618COoK/JU33+5pdfNd1bDfZYfkv1fpwp5SWJXiJsLMYY1l
         49nvS5wS9XK6NKix6b068e/s5IXBgH8lS1b+wmYTn1NH6X0bmUgLYgQTeTUWqnlH/nff
         LpVvdgzo/pIf8ZA7aPTZcYBIjv1pVf5T5gQgIy0nVzWB36F6CIJ3EO1PPbr+hRpPtU7S
         B0sFH0O4FXVgFt9VMmMCkBxWFlkiBhKfHxIGLMcbyLsffRgMlvgNSXD8yhZlhcFY1Jk+
         0zQM0bqDNkbRLSW9Pu6Lar/DYr3qDaYZ5V8Qasb8ZMWHRqDCjc/n/0ROZfiM+LrQAgIb
         5+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790977; x=1730395777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+V3PDXCnVyOx6pH7r2zTPAXQhdpHz0gUzjVzrgQp5g=;
        b=o/+MGYDbe/6mK/bIEOueZS0jzJcxsC3D2Le9MKVESng62KRr1Tufuz4xEFksQjCIrh
         oDzwGODC7ftnPEi4iSzzQeAB0ZzAF34ZyWq7eTes5xdMo5E+tXnL1EmiaNAZD1EtzFJV
         B9ZtTbie/4wlAA9rqluoBvZGi/qCWSf2KV/+dUytEFpiS9L4ep9UgogZdzO3dmd4YZhZ
         W5/vGoF+kaz/lDwPAtdkD8jlplp+KVeAMQLYbp3fX7bdVUoVGq5rUDh7hJ2YYOK+GCV5
         E6RE0v02KTUSObjOy1gOO8upOsuCkp/I2AxaiFqHf8UnCwUEO4OdggXN1YpG+VNYeF/W
         74Iw==
X-Gm-Message-State: AOJu0Yzzot0nIVhfSFsD2+vLswzDeZCZbDKINnbo/Z8nIPt2yyPsGyS9
	yIs30GL9dq+TOixZd7maqrP4lqqHz67L2V2+L0HbrGoSiSzKXw8Hk8oecB2THd+4qi32ujPx+kp
	eV81spDtEC3XzD+xawCxfvFJdLcI=
X-Google-Smtp-Source: AGHT+IGFqydonnJN1dFhjLyOgcCQ10rz+ybTc0dyLM8rqI8dx1b3m2FbGe50yMXgx22sxdIcW+JhD2Duk7oMvpnu7lk=
X-Received: by 2002:a17:902:d488:b0:20b:642c:222b with SMTP id
 d9443c01a7336-20fab2f482bmr37424255ad.15.1729790977419; Thu, 24 Oct 2024
 10:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024032637.34286-1-quake.wang@gmail.com> <CALtW_ajR0hGz9aYdPgqW+TsZJw3QVYvPeA93fEGHKXAdk9RKYQ@mail.gmail.com>
 <CAJkr5LNm=fm1rzOv9z3V6c0N=6QM3ngmYGHjniAvJAY__n5KYQ@mail.gmail.com>
In-Reply-To: <CAJkr5LNm=fm1rzOv9z3V6c0N=6QM3ngmYGHjniAvJAY__n5KYQ@mail.gmail.com>
From: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>
Date: Thu, 24 Oct 2024 19:29:26 +0200
Message-ID: <CALtW_ajJ5yzB+E98ugL4xxX9F=QuDiyBzWN4f-1DtpyVjgkk0A@mail.gmail.com>
Subject: Re: [PATCH] Remove Huawei
To: Quake Wang <quake.wang@gmail.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oh how cute, you copy pasted Linus blatant display of arrogance, good job.
Let me guess what comes next: "50 cent army", right?

On Thu, 24 Oct 2024 at 07:11, Quake Wang <quake.wang@gmail.com> wrote:
>
> If you haven't heard of huawei sanctions yet, you should try to read the =
news some day. And by "news", I don't mean China state-sponsored spam.
>
>
>
> On Thu, Oct 24, 2024 at 12:38=E2=80=AFPM Dragan Milivojevi=C4=87 <d.miliv=
ojevic@gmail.com> wrote:
>>
>> The "compliance" purge continues.
>> BTW strange how those "freedom countries" do not sanction Israel.
>>
>> PS
>> For those who are going to complain that this mailing list should be
>> free of politics,
>> I agree, please direct your complaints to those making "freedom
>> countries" remarks.
>>
>> On Thu, 24 Oct 2024 at 05:26, quake <quake.wang@gmail.com> wrote:
>> >

