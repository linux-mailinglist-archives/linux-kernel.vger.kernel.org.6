Return-Path: <linux-kernel+bounces-272254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D2B945952
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A41B20CDE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB181BF334;
	Fri,  2 Aug 2024 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IxOO8Z4Q"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E6482CA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585323; cv=none; b=Qq3VE6/64osfULTzVvW7fDUHlxbk7HESK9s8poqQCDG3jfuDVvvB2fajkk9wGcW1Fs+h2JbzlQLR+0z/oX3RIn+JcDN7zKGILa38mubxytCwRDiGtQSUbltq4ZUVbdeBjJvVWuoMxvxrNW2k2L1Dw5/D2KO1taoU0cq1kfcLKHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585323; c=relaxed/simple;
	bh=ak90xTxW3rcMGT4O7TI4TzJ7snsWSbksjAWYiJ9KkOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/nD9VcZFtJflmdhbz+5sj8OuSsMtSiWh3Dgu8FaFnobiy5usigANAqiIPaG/WkMfMwPFXPZ6019iMkaHTkFOrTbsWR8fQ029qf0MiRIsljMirWafsBm0kCjdeoo1HUI76qEQKqmqP7E2DoMWRZkUwC5N1O7+K75fbIH+QjlUAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IxOO8Z4Q; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so47404a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 00:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722585320; x=1723190120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ak90xTxW3rcMGT4O7TI4TzJ7snsWSbksjAWYiJ9KkOk=;
        b=IxOO8Z4QN7j6f930eC7rpOTxLDaqkdVAKGkbNMGmDTdwCBviQO4h2yo/5b94jMdSEz
         fs2fVZ2kHhmKub5KhXgFtrw3TtoR/YVxMTrt0iBY3TFkmFzFoKxYR6oVJBgGBsAtqqq/
         /1L0ba9BeC3SJ+nyFZg2THJzGJ8PWjBKspDq+Ig0zRbihFnQPIG1qNd8z9CxSqcrl5n6
         c0Vy1Fg0TSEIqUpGQ5b8dr+IfOWGCQ3eQOtP+V3vxqEg2nbkYUC1fAOK+GSaY/s0B11c
         8SkUVIboTGltSXoCP29A/3ZL+CpaL1UxalXiqSUrrxvN2aDYQX86D0TvUycH1spMAfcJ
         E4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585320; x=1723190120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ak90xTxW3rcMGT4O7TI4TzJ7snsWSbksjAWYiJ9KkOk=;
        b=a0y1JOxe227cVsMpKT8okV5M3Kv/SgIbGtQGneTYX70xaMDZV4xvKogmxu5D7TIbrb
         uBs4gesFng0ZJ1oX0ntpJdKvyp1bQttYR/kR8JWzPB8XH9qllaEZ6qcRC2np8UltmT6z
         IyS1Vq48w5cDzz6Sp/PDmfrqry6OyHHP5XUOck9VvX7Vv07kxy+FJozposRh+Kqzp6eg
         v4gIAVYOm31qFMqKBLMGvJQP2mGepJO0IUuDClwbL9PUxUxDPeqDNY408Z+766loARrv
         yp1KNe2/+3uWrPpKvDm73hddL2vBDFiCkgHqbUEds2/b2GY7/IapiUTX5jYeppEfDVaS
         fimg==
X-Forwarded-Encrypted: i=1; AJvYcCUgNvz8VUJBaahCagOvoByBmPOvSO3Fe5JxUI/FHmWte7ZFA6JUTlX3GEmGKO+ev0MlExEEPXoQyHorjHiX9yjBpWrJBGJ/E0RORZxn
X-Gm-Message-State: AOJu0YzL6FiTtVFAsUXrE6gnnCSgte+97m93VNsI51tPUPFTeZzIvnj1
	yuKs4120/6Us/NVASQP5g1va+xhQQFsBIPRbVnbhkfdS2O/BKTUYoobiUSBJb/LJVq5usO93tvU
	sFa8mzBIQG9oJX9yDB3BYQG0M5U4Ma7ZUPXPi
X-Google-Smtp-Source: AGHT+IEGTXiHBDLKYnZL05d2aE7knTVbal5f5V1FrC96v7hLWqCF0MxevZVGa4yTDO6PcXVZPZ7GWMxPH/x+DmFJ8pg=
X-Received: by 2002:a05:6402:51cf:b0:5a7:7f0f:b70b with SMTP id
 4fb4d7f45d1cf-5b86752ec46mr107321a12.0.1722585320222; Fri, 02 Aug 2024
 00:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726122814.729082-1-kyletso@google.com>
In-Reply-To: <20240726122814.729082-1-kyletso@google.com>
From: Kyle Tso <kyletso@google.com>
Date: Fri, 2 Aug 2024 15:55:03 +0800
Message-ID: <CAGZ6i=165A5k59MKqZxH4DvB8XNsZJ+26_0SuMZ+hidam2qRLA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: Runtime get and put usb power_supply handle
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, raychi@google.com
Cc: badhri@google.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	royluo@google.com, bvanassche@acm.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 8:28=E2=80=AFPM Kyle Tso <kyletso@google.com> wrote=
:
>
> It is possible that the usb power_supply is registered after the probe
> of dwc3. In this case, trying to get the usb power_supply during the
> probe will fail and there is no chance to try again. Also the usb
> power_supply might be unregistered at anytime so that the handle of it
> in dwc3 would become invalid. To fix this, get the handle right before
> calling to power_supply functions and put it afterward.
>
> Fixes: 6f0764b5adea ("usb: dwc3: add a power supply for current control")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
> v1 -> v2:
> - move power_supply_put out of interrupt context
>

Hi maintainers,

It seems that there are some problems in version 2. I will send out
version 3 later.

Kyle

