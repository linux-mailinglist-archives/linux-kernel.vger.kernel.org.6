Return-Path: <linux-kernel+bounces-356134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F8C995CE6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD5A0B24307
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65931CD2C;
	Wed,  9 Oct 2024 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QTuyBnxW"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3A1CD2B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728436828; cv=none; b=Ey7HjysnDu8jigEo5zbM1p2sLqjojQwQAiM4g4kWoJbozWM0cBEmSS9bDO/hpSBII2nMoIHStE0v2i5tO7+vk9qd/QGtLRjSy/7TpfsV/xXEtra58Cb8dc/wzVpII0sdR/fWBYnKyxlIoFjbmZvSv/FOIjqEE2+aD6yNfxOMZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728436828; c=relaxed/simple;
	bh=Z2NUcPEZ288HQL9CQxr60hI0pX8djpaVkIarBYGmKzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctN8NS7flitwPyiYxMegn8mZprnsKTO/cp+pnhA/HMj4U4rr9iKVR9pIVDI5ZKGQ2C8/wei6cZ4nNY5EF90YzoU0VVTBwVJ7WEg0JCw355SludRxAE7icj7LvrivXqkRkbdI1qcI07eWzCBT6mSxbbYLMaiKu+7+JCROtI6DVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QTuyBnxW; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99415adecaso63780266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 18:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728436825; x=1729041625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2NUcPEZ288HQL9CQxr60hI0pX8djpaVkIarBYGmKzM=;
        b=QTuyBnxWBB8vodIRhZeZ5lZ4an9X2ksp6GcgLKniuUQRNoUNAksM07tQv8Ou7gPq/1
         J8UoO/mjL9dOzDjo8vV5/MHKIRpHrkgA0sukfqczBEwbWVDKXS56RSJ1BLmZMCjiwmeQ
         Kjdv/Gea59tUrhxOExfVgkD/Zsm6Gj51PyYI8Yxkifcis5xWCsZqJprk36PVQjA4+tlL
         s09GQs32uGQWoybnk56OkLeYHkYniRU7mJzu78CjdBKb65P8jxRQhpVYb5qAR7pLwLsV
         QFl0zrktss9uZ6Ro2TfDTpeadIOplzYc7/Js8R8RJJ/A3th+r3DpImPHloXI3pLcK9QG
         NJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728436825; x=1729041625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2NUcPEZ288HQL9CQxr60hI0pX8djpaVkIarBYGmKzM=;
        b=GBTE4RX70M/CC+JPuPHOSqAIH7UphXjCmQYSTtWBnOmjd9L9f5FXJ1XkXhDDZPJZG9
         kfAXkxr5pwoYec5yJ8FajMrAgiDyHcGSEExb7XDDHrcTC8nuVhObUJ07FgQZLSQe2NV4
         FQ+O434O+I4TOdsQY34zSl2Mo4X2CMv70o1UiDw0dIpHCMUfSjdHaWXxACxCcrKacb4m
         RmZQyjM/uLFv8awqqHI9djmJL6pBNEWXK57IFAgfKIIADCQ/TBqLCLpK26iU6gkbv0Sw
         +mHxxv5mJaHLu/Rhz9bNd2MjImUKc+lkaxCNdBjQCPD76/sQVjANU/vneAuBET5rj2o8
         XXCg==
X-Forwarded-Encrypted: i=1; AJvYcCVBxndIrAdYAruT/iz1mJ3Q1JpyLZvtMdiclHT8qP0fWJfSlF7e0A1oy2b7bnPI7NBiAj4nF5PzZEAvdoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzALWeml/vBlECuwgD5BtvLabJqetA92GQfs7bMQwnZfl2rg91
	dRmAyNLdwuRNWTyBuZgfi3fvt4ja+6ARdg9r3b/nn0/7ZzV0bU8GxJzK3NqUh8QgnzOrsS5F9hx
	vfcE3jWxrfaSON1bhhaUeyxw1+dBfSbcnf84=
X-Google-Smtp-Source: AGHT+IGD1MS2bx75JHyXKYje5CXuLrQHDtUmQ+lMSLTGgaTwRkisEm4qeVc4bZgDUTc9M5bUyk7NBpi04MxZEEwfGOE=
X-Received: by 2002:a17:906:f582:b0:a77:ca3b:996c with SMTP id
 a640c23a62f3a-a998b26373dmr90397866b.16.1728436824699; Tue, 08 Oct 2024
 18:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009003032.254348-1-linux@treblig.org>
In-Reply-To: <20241009003032.254348-1-linux@treblig.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 8 Oct 2024 18:20:12 -0700
Message-ID: <CANDhNCr=+x3fJo1dhyWnSGGLtexXLcTuHj8OEPqbj_TcDWdEPA@mail.gmail.com>
Subject: Re: [PATCH] clocksource: Remove unused clocksource_change_rating
To: linux@treblig.org
Cc: tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 5:30=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> clocksource_change_rating() has been unused since 2017's commit
> 63ed4e0c67df ("Drivers: hv: vmbus: Consolidate all Hyper-V specific clock=
source code")
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Thanks for submitting this cleanup!

Untested, but
Acked-by: John Stultz <jstultz@google.com>

thanks
-john

