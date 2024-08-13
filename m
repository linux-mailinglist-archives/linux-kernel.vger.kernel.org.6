Return-Path: <linux-kernel+bounces-284672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AFC9503E7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E136F2832E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEF21991A4;
	Tue, 13 Aug 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QON+yy9e"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078861990C7
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549207; cv=none; b=EYcEQSsACbc7pbsUYC7X3lMf192tPsrlVQKvYqxF+PcQWBnlCuaq6xEmVzeT9q8hLiWKtBgYg8Apm320C9uZLYhNefK2jJoXH7OzBX75O0NUugYk99XHRMLg1FeLI/qenIR08BIA5B5+IVHJoSIvkn8XnsSRle2AKJWGa5rygIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549207; c=relaxed/simple;
	bh=MBj/IPaPFxPxj6fGkyjj4CXV6ibq84TQK25CrkFxYGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZFgclYJTTQl26OX1d6RjYIOLcEZihhbdFXaVQuU0TH+XsiYxlQQsMHD+mFt1UtKKDq2DjcOXoV9Qt4wHct5t4XrN5NuhI+IfqLU7U8GIge9ZR5kYDbw4nn1vR6Qd2T+sjqKVcBzBMYwf+1bA2ti5AIkZQh0/iqNl2aKOYG15SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QON+yy9e; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4929992a5e2so1451825137.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 04:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723549205; x=1724154005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n3iM3JlQoj/JH14LpprHDFDJxwBHakdfeCSkNH9T7Is=;
        b=QON+yy9eiDSdZPPU7aQArQYPXJt2coBmv0VhQpiT9RuX3lyDNoCTaFo9kgKZZG9JE1
         Q2TQrHOatuV0upLFpOCg1XqIvH7m/I6b/cXyIXDqQBAnFhTJxAPyjiZXayWEuhHMT3ww
         JDK2U83p4iDbp5J0mdLpx4Uo4b9c3QsOuh2dMmOFN7kgqe9VqKv1fVkhsT4kDhz0hUL1
         LaCNobzyWeK9FVN8j4AawarFXvICF0tAwOhCIXkUwU+pEoUCUA3J7Qu+Y2VXtoKcWzd+
         PI4DOKlYhJb1AdXr+KlkWQb9xFrZPPJxNsXJED0+u08t3tTvsam6shVGqFkIhtp+DyUv
         Fqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723549205; x=1724154005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3iM3JlQoj/JH14LpprHDFDJxwBHakdfeCSkNH9T7Is=;
        b=hr5GHsO6sqQE7Uf46i79ShWSZQr6nuPf3HFfEi3pybaaY4yevx9RbW0QSdj9+s/M8W
         zLAybG3sDPQ9380YgdubyKZGXnSzrLVurvKuZBWOeQ2D3TFj348WeAc1owXUaNZ+7lbn
         3rhmm77PA3tEaTSsuytU8V2BPwfXh7fp3ptefGKLsAe2hmCgkg3AqpFKs7T2Q8feDEq+
         M6/KmHJY9cCNXeBNFfE95hOgoIpgADdweyd8fMfIRcXpexJ+v3hTZTp7RNDHy+hwXP7L
         SeAZguQrp3CI8IrYY+cCjaVv2s/x/m0lVw+0Oi7Ahb7RlYZIACu0U4+xFOT/TVMt6FgT
         VUhw==
X-Gm-Message-State: AOJu0YxHNMcZxkABa/zjpNEVcbAJbLJ9bwWF53rad7Op2B0rJmoiMrI3
	xgYUMqK6I++3OwXMWtMgIgf1BiQVQSB8S90+4CFMvTUh3w0ItqtECVU9GWbC0US16nQNPPsu+ph
	yvnnDNpTPv+RjUfKeqgyAZLl0q19V4Zy0FQJVwQ==
X-Google-Smtp-Source: AGHT+IH/Ayw4yCzrsfeWtAnc+zMsCpOBkgCk6tCYIHz/eJrBynFShqqkfWUhr9H375g92b5UR5Oi8tTUQgRk6kB2SqA=
X-Received: by 2002:a67:af11:0:b0:493:31f9:d14a with SMTP id
 ada2fe7eead31-49743b39179mr3031746137.27.1723549204826; Tue, 13 Aug 2024
 04:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812133127.865879-1-jens.wiklander@linaro.org> <20240812133127.865879-4-jens.wiklander@linaro.org>
In-Reply-To: <20240812133127.865879-4-jens.wiklander@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 13 Aug 2024 17:09:53 +0530
Message-ID: <CAFA6WYNwsgLD4bYRbPPG4MqshP8cmvZ5YdvgnX6Zsoeez8b-bw@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] tee: add tee_device_set_dev_groups()
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Manuel Traut <manut@mecka.net>, Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jens,

On Mon, 12 Aug 2024 at 19:01, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Add tee_device_set_dev_groups() to TEE drivers to supply driver specific
> attribute groups. The class specific attributes are from now on added
> via the tee_class, which currently only consist of implementation_id.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/misc/rpmb-core.c | 155 +++++++++++++++++++--------------------

These changes don't seem to belong to this patch but rather patch #1.

>  drivers/tee/tee_core.c   |  19 +++--

>  include/linux/rpmb.h     |  53 +++++--------

Ditto here.

-Sumit

