Return-Path: <linux-kernel+bounces-186774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791A68CC8F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96551C2105A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9321146D57;
	Wed, 22 May 2024 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vo1S0kIo"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7C7EF0C
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716416350; cv=none; b=O9natis0FS5g8I4Nf2YZrKfxTB6T+3A3p+lX/iaadzqWORdhTYPDozB0QPVEqJkjKlokCJZ1sh4tj4FP/bpPrNtMl1/4q0fPY4/5DXPFFAExt8joZJU+YRUmnwWc2cEZQdCUbBlkD5/7VnAm7QFMUMG9sW1FUDibqKQGZ4bcpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716416350; c=relaxed/simple;
	bh=swwro8lOZgvb3QDkxq4qjw5SkDE6YkcxR3UDNunhgjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b84Dbghi8mCGfN8w2XrsvsjKPLIjYCYaMSyYhtvI01InX/spW2XhvyibcBdrIdNSAzjtEKXMx2quwKUvKAD830PrAoqIl/FgGFu778n3jdFr/jmjvD97NJLM6kLpMrumf5uHRT1IWGapYUS7WcoEPxObgXO/9yHSca4NcsH7x4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vo1S0kIo; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso1985a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716416346; x=1717021146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhrevzC6PfRPXcTVZKdgRT8gCvrtytd4Oo1yvznuYr8=;
        b=vo1S0kIocnO+7JNu2yVpq6kFxVrRiUgn60vLk4EGZ7KsoUK7deRm7/CovIesjdW7Ig
         LjIxAotbJmbn0rbsJgF5cTBJekhsl2CMkXFGa2iTW/RTqlb6UEcW6eJ55ITAADKNcNzq
         c1T4Nvp65Po7+ddgPNbZARXgxT1Bm76xPKBSnusfhwz6ajMpw9zt8sBm6IWdkxILjvyu
         D3RBYgWDvMft7QQh8JZf7o9o2LP2xrlClLKpHMjKbbwONyvqtVVkdUeCL4cT9IUfrGVd
         gLMAeXMbcsNMWyn+B/gp2sbLwMnz2Gz5v+rbh62ubpxbo65BSSrhUwfXW291QQSfiadr
         OJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716416346; x=1717021146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhrevzC6PfRPXcTVZKdgRT8gCvrtytd4Oo1yvznuYr8=;
        b=sT6sRCZnwqxRvMfoi/zlX+k+lszWyldk3HoPzoju0ra+6Ux9zV7dRP5VX8uNxzZvUt
         hc/ATNcCnn6Pg7FSi1dMLBzJxHbvTWp2mAwAJqdAiql295ktQveLdb2gEFcqxj/YMJx9
         xW56eRz+IJ30Gb98LeAPpXacwy+eT8sihZZ0+QsIskBw2RIeoqVhYv2tMMBbSza3ztgl
         ecq08CdbU2p70my68bDwOTFdVO2+dU6KI+1TFvKf/XTAD7sV236M9a5MWsPsVvvr5TOh
         U35kLJwLWbVF8/DR3xEJom9dk3g4quYMDReMKvsIcWrOTqrHNHj6vWIb6E6GpGVE8Zah
         6WVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4KILZ6h3P/sqwSi9CZjE47iRTof7Ml5nCRIxGEKNsK12gVaksyb7T972mWwZwNMgQ6mw9HfrDvIRt3aelHqLKWEM9l0ki1XIAAzB9
X-Gm-Message-State: AOJu0YwDIajok5R0dRlCYV+wAVeLBKx9siYolo4xu+qv/gi51///EHhY
	m8T6AzM2jV4GNdTzGH0HEe4eIfciUnpHafk2U34vShOs8THnu0GS43OyPRXRgaysw3qEombffD7
	djJRd8eh7vGewaNBx5/wgjPxCPdJizvA8M7wh
X-Google-Smtp-Source: AGHT+IF62mCggB+fp0Hi8G7QtAYVSXNBfMqCEAUF0DXMxHEcTp4ynDaEWTuM179DypO8UKzQBxEYxqqj04GQD38VKbA=
X-Received: by 2002:a05:6402:3551:b0:572:e6fb:ab07 with SMTP id
 4fb4d7f45d1cf-57845a7c1b2mr12747a12.7.1716416346140; Wed, 22 May 2024
 15:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
In-Reply-To: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
From: Guenter Roeck <groeck@google.com>
Date: Wed, 22 May 2024 15:18:52 -0700
Message-ID: <CABXOdTdPM7b5uYGnQ3KbN+9AzKb=D1Pq-TZcftO1_z3efXjg9Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: If memdump doesn't work, re-enable IBS
To: Douglas Anderson <dianders@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Stephen Boyd <swboyd@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Johan Hovold <johan+linaro@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Sai Teja Aluvala <quic_saluvala@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 5:03=E2=80=AFPM Douglas Anderson <dianders@chromium=
org> wrote:
>
> On systems in the field, we are seeing this sometimes in the kernel logs:
>   Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-95
>
> This means that _something_ decided that it wanted to get a memdump
> but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).
>
> The cleanup code in qca_controller_memdump() when we get back an error
> from hci_devcd_init() undoes most things but forgets to clear
> QCA_IBS_DISABLED. One side effect of this is that, during the next
> suspend, qca_suspend() will always get a timeout.
>
> Let's fix it so that we clear the bit.
>
> Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> I'm nowhere near an expert on this code so please give extra eyes on
> this patch. I also have no idea how to reproduce the problem nor even
> how to trigger a memdump to test it. I'd love any advice that folks
> could give. ;-)
>
>  drivers/bluetooth/hci_qca.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 0c9c9ee56592..1ef12f5a115d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1090,6 +1090,7 @@ static void qca_controller_memdump(struct work_stru=
ct *work)
>                                 qca->memdump_state =3D QCA_MEMDUMP_COLLEC=
TED;
>                                 cancel_delayed_work(&qca->ctrl_memdump_ti=
meout);
>                                 clear_bit(QCA_MEMDUMP_COLLECTION, &qca->f=
lags);
> +                               clear_bit(QCA_IBS_DISABLED, &qca->flags);
>                                 mutex_unlock(&qca->hci_memdump_lock);
>                                 return;
>                         }
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

