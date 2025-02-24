Return-Path: <linux-kernel+bounces-530229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C2BA430D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE72319C17BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D868A20B1F3;
	Mon, 24 Feb 2025 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h/+Rr2s7"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF59B101F2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439632; cv=none; b=oMXaNdmp5G0UGH4K7Z/vaZS476W5k6fq4GQVBtNMDdTWrQFbR67WQURKOuWI/qqlCM+G9uGvd0AiswufH2P/Pje4/Hq8+LTkN5AvMFr1kKF44JlGRawkylA+yilb96AQjSYKnytZAkF8LC82YdhA1Kxqzy0lCQd47Hd6cSt2PMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439632; c=relaxed/simple;
	bh=iroxDNFPNkTpLhvKi4DfL/KYjUD21VFFgmsM2gvE364=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHECJu+k9+ZqEt2Frhl37Q+SYtaZu4iryZQuKI9/QFQM+LGS+WC0gveAjl+nGE7+gbgJUYgEmOLl+EO778B+8cTPlLMgctwbbFlR013IbWVdQTlbj3Gvhlq6yCfvnE4715f0Kg9X63JIiuhLb2l6zoGIit14+iaE39tbziJDp0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h/+Rr2s7; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4bd3763900aso1336209137.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740439629; x=1741044429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuGzKCSQYyNZUYU6hCRZeweFzFEgPJQoQ9Vkmq2hXCQ=;
        b=h/+Rr2s7g7YF6i2kTCcaJ0QC3uytwb7YTK4HJVLjwD9GoZptGXbRepWGigCSJQf905
         QdfleWsfPhnQ5rH3da9b+KEgHMSchG/gpm/RqKg/BfOhcV35biybtSMo5ViJ49IuqiEY
         KE2kQS/7QMomwhCiXb4ool2INQ5/myNUfJnGyQfB2ON3v720OAP66pTYkgzmw4oZ1Sz2
         qwAFWKuBYOGwQnUp7rcre2DZtr6SSndAW6NA8yMFBn5m22Yoonb6m6EMS+gqD4T0RlRU
         trUNKHv6z3rX0CdhV456uTFEpcGodI9/VU+inuJJbMJRhBNC05CWNicgSOCMp9GwjPia
         VylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740439629; x=1741044429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuGzKCSQYyNZUYU6hCRZeweFzFEgPJQoQ9Vkmq2hXCQ=;
        b=TfQaDrfaw/It2tECgzLYNU9wV4baQtD30hU/dBH1LTSYKSpAyFZTbQXzzkhRhw++m3
         h8LPrnJV/cjZrCHfOYUbt4GyyYrC5q+DDE/36/TNP7cHmcMTMcrGySjLY9Py0r+377F0
         6sa/1G/jZuuMihu8/Bj6L12ykepfn3ysdeULRN7E18LJGMPRFq5K17PPhCbgPoW92j8t
         zCHoIoOrvPZO+0ZNMWD9feGAPphX+S5f/bYV2S9n0jqo+6VD8bD9lbju0XLQUy6XGBCt
         NRYZFgjhWs/L2wfIMjkLKefO1HTGh7vI757UR4KjrqMeOiqPQVbCZEagWDTQWvX1c8ue
         9LEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEM/VkmLzP7RoNWNxjOlcJvhtCbP0+/X67cLVFC9y0/J92wABLiOV59XjYfj4ksQZLqjqTC9lgQbGrPCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEdTgoe83iyXFzN93zxD+aPP6aLL1CF7Z8RsFFLN+bqVtkZUh
	y6oAOhhRKV+HgLcujU9/jswPmDhy3apt9wie+1FvSKrrcMj5A+cdljWPdBS+11GvkD90dUj4NV6
	OClEb7wWugw+ALxjzzgO9FgjnvprQ1HOLRdyKeEXaK4L/UTBxZg==
X-Gm-Gg: ASbGncvv1xH6ZeUDABS5L1k3VzUnOCtVQPAC5U8EMVP0ecGcWPrU48gYcx0dTpYL1yu
	RJey6XTFGkPteZSak7czcdMnfmmS+UZF60WCPNu0KoCjisc7ttRXrEAm6VwR+PUNXlBuQZpflgt
	/8IiUhn2H+lc+hjzr6sxNL9ibJy76WVzR4DWiSL1A=
X-Google-Smtp-Source: AGHT+IFe5RXwRFKY9KkPg7QhwK35KreXgcFhB+vQ5850rIH/knCMNJ4wDDUgBle8O/RjjdYF8KgAjLP509K8PN62lWw=
X-Received: by 2002:a05:6102:919:b0:4ba:974c:891e with SMTP id
 ada2fe7eead31-4bfc01d3495mr8009263137.17.1740439629304; Mon, 24 Feb 2025
 15:27:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217112756.1011333-1-masahiroy@kernel.org>
In-Reply-To: <20250217112756.1011333-1-masahiroy@kernel.org>
From: Todd Kjos <tkjos@google.com>
Date: Mon, 24 Feb 2025 15:26:56 -0800
X-Gm-Features: AQ5f1JofbDbS9waB_jAM5Sw7y4KKCnxqWRmovq6TnHHGtP8n7tFiqJFv2Py3Xb4
Message-ID: <CAHRSSExQf+FxRm61Pk9egJ73fz+1tp4nUFzANMujg3ban2REgw@mail.gmail.com>
Subject: Re: [PATCH] binder: remove unneeded <linux/export.h> inclusion from binder_internal.h
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 3:28=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> binder_internal.h is included only in the following two C files:
>
>   $ git grep binder_internal.h
>   drivers/android/binder.c:#include "binder_internal.h"
>   drivers/android/binderfs.c:#include "binder_internal.h"
>
> Neither of these files use the EXPORT_SYMBOL macro, so including
> <linux/export.h> is unnecessary.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>
>  drivers/android/binder_internal.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_i=
nternal.h
> index e4eb8357989c..6a66c9769c6c 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -3,7 +3,6 @@
>  #ifndef _LINUX_BINDER_INTERNAL_H
>  #define _LINUX_BINDER_INTERNAL_H
>
> -#include <linux/export.h>
>  #include <linux/fs.h>
>  #include <linux/list.h>
>  #include <linux/miscdevice.h>
> --
> 2.43.0
>

