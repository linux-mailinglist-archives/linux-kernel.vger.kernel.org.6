Return-Path: <linux-kernel+bounces-369525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D3E9A1E65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6883D28A01B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18331D95B4;
	Thu, 17 Oct 2024 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="tfpmL3yo"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6711D90BD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157377; cv=none; b=HsmGLVw4oDrB3xMV/zvn+TPrzSfa6vdon0ujgeasYUi2qfTQy+EjnLe9VX5IuyAZqG4JNoT9yOd5dNkUPyEYJ66IrhNIZr26scSZ0FB6WCPJXspUa8cKlwaVEgkqtglDIxbhir8kVtTiRcUt4z3MqI+45Oyszw7cTj3P9ybsqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157377; c=relaxed/simple;
	bh=2BwbOLLmrev0DEkdKU/J1Uf9cnFyU/EArcl5PfVyQqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddWtExtjvKVEEAY/T83HT7pUZTWMeHss5a4Z/hGkl0jJROlRN/6lCKJDdjrKHq7QB94RMF9ovS8ITyaO4A1b/kVUpJRNVkkqlWoToqmk1C7w1zdTs6curO1kAcGaVJTk9uFwfaksdF/QLAQkZTLrYmM5RuLruOEk8HEmkBq9bpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=tfpmL3yo; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so860463a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729157372; x=1729762172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qKzlhjU/lCm02BVIQEq56igyc/HvbAaIKSc/+Cfz6E=;
        b=tfpmL3yoixcoPvpu/JzjeKniapRJ8stRc5C/eTCZsKK02LNrPzksComFvuVtcpClUY
         FoXvKGj23JnH+171AIEZwS4VqA/8A57XPTyeHlHQ2eaOL2rl2DjuJjD/aQ0EhJU38O2m
         brOS7dFfnNR9VxIg1vw013RmdVOJIoIZs4580mOguLUFwNiljQpvaJuLndnJzkTfl79X
         ky8XG9+brEMbfs+Fcg2lBv94ALUS/FM5M8Y/ih9Dwq4/7XqSSqLZfHDc5LPFLqfEqlI9
         jFhik2ekR6Frz7NkOiSno184OzpO9vRGQIDCcb0jzd95CzqBPu4oMsHX/FLdz9hQYpxX
         F4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729157372; x=1729762172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qKzlhjU/lCm02BVIQEq56igyc/HvbAaIKSc/+Cfz6E=;
        b=cq3VWADi5eulOebvsk8q2KaNVty5dUrzsODZhA4pdHmsn64gCCES//OOz0qLne7EZu
         UVYFi+vw2cBorKzVBaz5ar11/0SVVkKF8xVbKs7ANSjb79QedQobfJIldn/qVZ//m9tt
         TZmcoJ8cPiHsJ10tx0VuqltFKh1v76CXG25FDTizCF5T8QbvFUtaijO66FhzifOvEujx
         wKbvoah0BWYSnJw7Z/ie8i7k9x7LFgpjHUcGiIVUQI8X5m/mHPl9MZtVvdyDPOAQ6JBo
         iepluhmDavB65CtC8MJIkZBJrePxTxN87LeAxtqF1oBUZzEzdFKtGD+abvPUwCD5/aqK
         Vl9g==
X-Forwarded-Encrypted: i=1; AJvYcCVktJFqsjJJVIagyEa6Xj60hv8thXbrVt3QPwc/rKv86rpmW6DuQ/wLZ51xMRTLc5EtVqXYoxrdugAqQXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCg5+unrgW6I/dAQfMIaSj9V80U+itKcMlBO6YluAUQv6Ym984
	KVVLgp+xNnpX1thS9VuFiuHyY0rJR1WVnLhq52Dmvi7k9tqZ6ZDO0FwoRRv+87M/LdLUd6Axt4i
	oMq84geTTkKS/RakGerG2ATXAWhEkBvIASr242bNXTL6UfyaQ5ifHmU9E
X-Google-Smtp-Source: AGHT+IHQuIrk6tkwFaRZW8HCE+De7KpmbbPUN1UvWoHF8GYLJXLjUh6P69bytRBvqyiyWXA8doMSnNZ99QI2wlrM+x4=
X-Received: by 2002:a05:6402:321c:b0:5c9:9bed:a5cd with SMTP id
 4fb4d7f45d1cf-5c99beda6d4mr3438038a12.34.1729157372138; Thu, 17 Oct 2024
 02:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <912561b9-e446-42e8-8922-9e8952355c79@stanley.mountain>
In-Reply-To: <912561b9-e446-42e8-8922-9e8952355c79@stanley.mountain>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Thu, 17 Oct 2024 03:29:21 -0600
Message-ID: <CAEO-vhF0NWB4J+WFu_c7Nn9tu_kYzAvNeFgLrLKc_Lk5DD51hQ@mail.gmail.com>
Subject: Re: other staging/gpib bugs completed
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, dpenkler@gmail.com, 
	gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 8:20=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Keep up the good work, Everest.  Here are some other bugs you could fix i=
f you
> want.
Thank you for all your feedback and help. I am learning a lot :)
I will look into these and try my best to fix them and send patches.
> drivers/staging/gpib/agilent_82357a/agilent_82357a.c:1381 agilent_82357a_=
attach() warn: inconsistent returns '&agilent_82357a_hotplug_lock'.
> drivers/staging/gpib/common/gpib_os.c:889 board_type_ioctl() warn: maybe =
return -EFAULT instead of the bytes remaining?
> drivers/staging/gpib/common/iblib.c:242 ibonline() warn: assigning IS_ERR=
()
> drivers/staging/gpib/common/iblib.c:505 ibsad() warn: AAA no lower bound =
on 'addr' rl=3D's32min-30'
> drivers/staging/gpib/eastwood/fluke_gpib.c:592 fluke_dma_read() error: NU=
LL dereference inside function 'dma_unmap_single_attrs((0), bus_address, le=
ngth, 2, 0)()'. '0' '(0)' 17 9
> drivers/staging/gpib/eastwood/fluke_gpib.c:592 fluke_dma_read() error: NU=
LL dereference inside function (pos=3D17)
> drivers/staging/gpib/eastwood/fluke_gpib.c:949 fluke_init() warn: was hex=
adecimal intended '10'
> (perhaps intentional?  Just leave it if so.)
> drivers/staging/gpib/ni_usb/ni_usb_gpib.c:837 ni_usb_write() warn: incons=
istent returns '&ni_priv->addressed_transfer_lock'.
> drivers/staging/gpib/ni_usb/ni_usb_gpib.c:1103 ni_usb_request_system_cont=
rol() error: uninitialized symbol 'ibsta'.
> (this last bug is tricky to spot.)
>
> regards,
> dan carpenter
>
>
Thanks,
Everest K.C.

