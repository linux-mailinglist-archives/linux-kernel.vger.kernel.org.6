Return-Path: <linux-kernel+bounces-358643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E829F9981ED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0821C26827
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65A21922DD;
	Thu, 10 Oct 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="03liSOGK"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B06187859
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551882; cv=none; b=nf0Fi7fD0ehNKKkf1hYQBofZSV39mgqwu517TK5viNIJt4HxbRl0ggpxYBmgFrJ8LEUmAfQldLAE3V6qqv1qFOeTI3wIbi7roUYwvwOAeW/HTpF8o/A+M7YBqRiTj0ofbEjEZV/rcirJnP9ub+DhfY9JFVKdbufSw8uBE0zPniU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551882; c=relaxed/simple;
	bh=NVSbmsWx7xz/p+40eg/i9YMaHztUF6uhj9pq2GSem7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsZmRFKm/8yv6LAIR4SIng5ZXaiB5YgLwjDtIChd5KWn7SZNJ1Ww3mGyn5ruMeBboPnxMcDQVeziC6CizACMXvacB/LofRbm4MCgpWVMq3460eUYvgqQQjk325O8y78aNhB05nG/yLdDAeJFGL6S/q7V73/0NC+r6PvEAxxs2ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=03liSOGK; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53995380bb3so843633e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728551879; x=1729156679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TloAXr6ohwkHOrisaNc4fV7tBhJ6Xy/e65Bk48a+znU=;
        b=03liSOGKF1AiifLB8v2Apc46KPIqfCC5U8fRlcWMpInmBIy3mu8WQH3nTv6J2wIFtb
         54f+hnLyc4LJFGa5ScD9yD7Op/QsTOs8X7W4UbGFydL5QJDALyqWnUgaA3RRzR+7U7+c
         bshFflKGfnOjKKoGFk3UB9pvorrhwNBkpHN7UhZE5rpHc60IEHU7EIIAL4l60Wb0mXB0
         CTO+ynpgDMPJTYzPMmQLLhK82AXlKXxopuztwJS5rZu5Ml7ETXwsvEL2JhHDBPOViqNB
         o+tJqCgEoN5AAFdkEkc88n9p2OOVHc02v6nzOyYV7AhcMidRrn7Vg+1rt+8HJI9cVHPQ
         nE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728551879; x=1729156679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TloAXr6ohwkHOrisaNc4fV7tBhJ6Xy/e65Bk48a+znU=;
        b=GuJkNeyklFIzJKbenLW+0J9L7aAUBqqqQEUo0DRgwM6HhxTNXTfVTwXTuIaTD3bRct
         KIQudL8XMUaD6dj4DgZCWV0Jq4RvzLJaZm3wsp8OQ/YoAVAolTVB9Aqa6gUYZDbqyrQj
         ByZLdzZNJQYeLxwUoC1DPDDLGLavNC3cEmNvqSmZ/UG0e5YsNZ7Kue5ypEyb/qKe9YlE
         06nzSeGUHK0urDtX0dzO0yfb/aDsapjNzyLcfE3FwPdhSROqIx6xVDRqoWC+d+gI8ZmN
         lJ01QciDtHwFt6XPs6RdNEWfwqTUESPFOOWAGfk8xGvLOXnEpllMMjGdXkboHhRC9lXv
         sNuA==
X-Forwarded-Encrypted: i=1; AJvYcCXvJuRgJED122BDJ2V47S9b/n2j1uH47Kne07yG1NK6fVmdqSYJ2v+QUHkJtZE5g0oaLtXr4d1VNo73nZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvLXaoB1MHoDqIHfU68V2tbH/lcPL0BkUWDvkR4y5vSsojewGy
	I/1Ti3rNlWoYNEDXkeYDKDDkn+8mFIKyljKQNf/KCWgrh67nayJ0Ew6PC+duGFUqhB/CG/EP6AI
	R5D0qgCSjxeYDZKQ28TIVQktuINvTwzMFvdJGtg==
X-Google-Smtp-Source: AGHT+IGmRHUqc/wPgl/Otvcregw9W/T94yFSy+0AsOPWO9C3jEmSjCkcHHKltHvdVtILUATJjNaCxth6HP5SC20LlmM=
X-Received: by 2002:a05:6512:2822:b0:52f:413:7e8c with SMTP id
 2adb3069b0e04-539c48989f7mr2988093e87.14.1728551878979; Thu, 10 Oct 2024
 02:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003084342.27501-1-brgl@bgdev.pl>
In-Reply-To: <20241003084342.27501-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 10 Oct 2024 11:17:47 +0200
Message-ID: <CAMRc=MeUW3jsOPTxxu38+w_ps2FQFYR-PmgGY=V+vjnqNs0RYw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: take the rescan lock when adding devices during
 host probe
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 10:43=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Since adding the PCI power control code, we may end up with a race
> between the pwrctl platform device rescanning the bus and the host
> controller probe function. The latter needs to take the rescan lock when
> adding devices or we may end up in an undefined state having two
> incompletely added devices and hit the following crash when trying to
> remove the device over sysfs:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
00000000000
> Internal error: Oops: 0000000096000004 [#1] SMP
> Call trace:
>   __pi_strlen+0x14/0x150
>   kernfs_find_ns+0x80/0x13c
>   kernfs_remove_by_name_ns+0x54/0xf0
>   sysfs_remove_bin_file+0x24/0x34
>   pci_remove_resource_files+0x3c/0x84
>   pci_remove_sysfs_dev_files+0x28/0x38
>   pci_stop_bus_device+0x8c/0xd8
>   pci_stop_bus_device+0x40/0xd8
>   pci_stop_and_remove_bus_device_locked+0x28/0x48
>   remove_store+0x70/0xb0
>   dev_attr_store+0x20/0x38
>   sysfs_kf_write+0x58/0x78
>   kernfs_fop_write_iter+0xe8/0x184
>   vfs_write+0x2dc/0x308
>   ksys_write+0x7c/0xec
>
> Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> Tested-by: Konrad Dybcio <konradybcio@kernel.org>
> Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

It's been a week, so gentle ping - can this be picked up into v6.12?

Thanks,
Bartosz

