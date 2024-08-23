Return-Path: <linux-kernel+bounces-299272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B595D231
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E6B1C226B7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1982118F2F2;
	Fri, 23 Aug 2024 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULK5zsyi"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E9418E346
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428592; cv=none; b=hWo13atPB92xaN9knsvA4SnCzhQhpFen8tt/qoL+a2n8G8fAxDRfOTAPOjaDsizg5YLpdgZtxlp9JmdFNo5DXhVTYREDzqbu8rPEkH3wF37yBoAr0UdGhPkLruwzAJR9yAsiFWhjSScbhxjeTYoYzaqe8n8W9ijVBBNjCY2Sue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428592; c=relaxed/simple;
	bh=HGqhcQes5Ttfrfat5u189/JTp3kgH468GuYjDVQlEsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYkkH4yHh8pHxp18b8lMAD5Kfp4bAidxhIHnY1cFtJiiWzTMq6UaVf8p0eMd2Yh4bwyC5vfzhYbnrpabDzw8OB3dWSvOiad5ziiQ4HY9qviauP6lm+Z5pBr8xWcDh2tIZMtYQqvfaeI0AOCwRp5A2JtC/ingvLRQTzxCqK/JynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ULK5zsyi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53346132365so2566287e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724428588; x=1725033388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGqhcQes5Ttfrfat5u189/JTp3kgH468GuYjDVQlEsE=;
        b=ULK5zsyi7EshijB5bsVouhIqAj9xq7elWP6IrA0bo0GcHf8Hbk5w4RvLDLHTZ+Jucu
         tST58t2QXF7zmT+yfrnHIyMxYVR6Bj4XGelQuFHnBsegZJCsUpVmVCkskM7NfBwesC0y
         g1jgTNwR7poxDu67BrnrakEORpE58f0ycdIebMYu5hrBGkYOELij2jRSNpcpamdj9PdU
         com+ea+t5KopRsbTF+jn9f801/+tZMr8RFDCLOBNROq/igkjMLX8xsLYHja9dl/521dX
         UZaWNXBl/JRLcNMnmJcmXT2NDygAr9rGNmHz583sZ+Jq30AcwqLXkS7JwwQDt5vE6fuO
         ISTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428588; x=1725033388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGqhcQes5Ttfrfat5u189/JTp3kgH468GuYjDVQlEsE=;
        b=Iyn9vRWLTWl77rtaaJHdA1/vgFELivRh4ZDC6QTvhHFdwMnV/aHmyA/9tAJWhG1rTi
         5MlRE2RcbNPKfeccbs/sER9xOHpQgPkbHDcMV+uFU8e/LqMWcn2gF9Ba0BUrU13zR+Ej
         DgJCRxLzToKDVbe7S5alWe0QlftlHWRitgvE3rjp9qvCn9pFvTUs/wlpxA3Mu6Zsg5Hz
         II5PciiwWtQ81YX698m+ZnQkh8j1ect/ushg5KKFRyxNnLs9Y+J5C6/Qsaa156QLaHIB
         BKaF78xehkzFQhOMJq16QZghz4cHKus1tvvnwjojh/eLuviPVumlY3iir63Sq9cZfsfw
         5P/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWc8/A51q1rh2B/nQ8LUv5JAM4FUq05Wy7g+7z9v25VlLoqzJIr7/lqdf4huQTn3jSO30OnC4mSo6wmoks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGnYTEKrpgNGL355M/MjnQeIwwjbttkv2A9aszJHw//9DjCtf4
	6Bd2xwihLRNnDj+JoSTqBDLuXDTUWBD0J7EsoMuj9DHA+HRI/69gMmR62mUJJDMZjwRy1XsxTJX
	PO+FAytycTYB84b053THJtVhakKn5Vc7MdyzmHA==
X-Google-Smtp-Source: AGHT+IF+VJqrZG6jMDTEJ3q6NJ/NApbAQdSMXyFziZqx6qMBZdyXh5nvJ/NMn+LngJ0u+dNzIY1IbzFCNGCR5eMpqEM=
X-Received: by 2002:a05:6512:239e:b0:52f:d15f:d46b with SMTP id
 2adb3069b0e04-5343877a8f0mr2130796e87.14.1724428587991; Fri, 23 Aug 2024
 08:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620090028.729373-1-ruanjinjie@huawei.com>
 <79a3de7c-21da-12ce-8372-9c9029c237ac@huawei.com> <Zqn0wL5iScf455O5@shell.armlinux.org.uk>
 <034499ea-2cd6-8775-ee94-771cbecd4cdb@huawei.com>
In-Reply-To: <034499ea-2cd6-8775-ee94-771cbecd4cdb@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 17:56:16 +0200
Message-ID: <CACRpkdYfn6Wxo6N4hNRoMVSQXnsSVAjZXRfYzZtbRuzZyKvhkQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: support PREEMPT_DYNAMIC
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, arnd@arndb.de, afd@ti.com, 
	akpm@linux-foundation.org, eric.devolder@oracle.com, robh@kernel.org, 
	vincent.whitchurch@axis.com, bhe@redhat.com, nico@fluxnic.net, 
	ardb@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 12:03=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com=
> wrote:

> By the way, currently, most architectures have simplified assembly code
> and implemented its most functions in C functions. Does arm32 have this
> plan?

I would turn it around, since I saw that Huawei contributed generic entry
code for Aarch64, do you folks have a plan to also do patches for ARM32?

I have many ARM32 systems and I am happy to help out with reviewing
and testing if you do.

Alternatively I might be able to have a look at it, because the entry code
is right in my work area all the time.

Yours,
Linus Walleij

