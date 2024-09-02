Return-Path: <linux-kernel+bounces-311374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DEF96884D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D721C227E1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F35205E31;
	Mon,  2 Sep 2024 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OPoqgt2U"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE4205E23
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282137; cv=none; b=nld5jklnQ8/2lnjbblgVCobyjT0lO4QMHg0HAz7f5FxqkrrzH6TDrfwR0C7XcaxP4UkV/4G9hPtC0Apyrex1adLNfzIGUkf4ehlqGiamTVjACmdqOumrUADpORgtexHdVFSd+SQH3f6NQQksuv305lWWuUoQy1D7eRiOoOkKQjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282137; c=relaxed/simple;
	bh=GCCz/+hgN4bFM6qcWCJa9mTTDF1JriNper6mrbNBu/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIOhG28xiO1z+g+neitefKLaeQ3XqKI7BP7eC5LsoSYaTaM3hzeN8LfHL7CqX0hKINg2sch89zz2juQKlZaN5OmP+VRpRZmHGE0ol0QbaP2CrI2+Ndi1MAbfDRd5QHCNwQYn8qgQXg5T6H2v9PfE1TfucKAeXgFNV9WhkwURO5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OPoqgt2U; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53349ee42a9so5623127e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725282133; x=1725886933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3C/PjLZSrrEOmnpe9Vyo2eMd8wib1QehUQG237JMjPw=;
        b=OPoqgt2UXN4eGivudj1Ad9Ut3h9JMnsyElJTiCs7+J/+N4JthHdcrvROQT6rznu78b
         CP36ifHRMzho6oLoMafFIHQD3ASOJGio4T1RKqm/4Xcb/YWxF9ZQNOl3Wsdgjmlpe8S+
         JHJNRJNmKsXaBt0cVi1gxu9pNr8Y2tQCRvbxFbBvDVMqEjVNU32hkHjaiM4cfh2O6e1v
         jrn6MfPHU5KRmup3eyNzC8RTWigm+XmMQv4oIZl4MaozZkkUtm+Kux6sdwY/+dOxVHh5
         1U/LwTzFn8Gd2EXXIeo5N6PVTxnsCWNKbq6uZQanLRLDH6d25K2VablVE46h+RK/Epot
         XSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282133; x=1725886933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3C/PjLZSrrEOmnpe9Vyo2eMd8wib1QehUQG237JMjPw=;
        b=HK8voFMiz8Gj0WCzG8HnnCQUP3j+r8gJTuqSNoxletSXx96D7gpXSqjz9y9IfEV11E
         Vyvbo3IPjK8B1YkN+hU07QjxNnWaIflYQQrmsDF5dYv/eo70CdRh4po/BgxrWus8rb8O
         WcPAsS7Cc9BArW8Wa7f++W1F2rB1hIopcjPINZXfxntKa5HlXYb3+9jABXGqYKt1gEKo
         PTSszkkdTEKFu1oXoahEH51EMloLbqUwAmjkDZBoy6rkkMQsg7gqt+ZkvYe3p+Iu5Y4x
         lQog4NwQVUViEpL6Fayve30c4CHjqVTRa9Al/D5hVCe8m0RbOguemXoib/AYh7ZykOlh
         /1Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWI33sRQotn8ClJjpqgNOMMcWXDmX/fEd1xq/UYrlrfEL9rpXEA+6DpNUkvqijBkSqDzBKMlwoJ2YDitVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdGqRVfPHxmFmAW/000esOW4PGMfLb0qr3KNs6H/S3c/vNhrig
	9DJgWTdM7tD9XWz7T1JwU91zUKcEaAN1S+NICJ3BDIMl+5yBgW58ihI8gtXZn4yhTov/s7mOqAE
	rTvAeICxbrtfOsrHXzxUANTyf9gH62ZMneUbIUA==
X-Google-Smtp-Source: AGHT+IGkPP32QmOnnqN/wO4JYMvkwbJgK1HcfkWTHSHNsP+HKLmR+8IHSLf8TCFMGLJVOqvkDQ3sdIsar5MOj3baL10=
X-Received: by 2002:a05:6512:1329:b0:533:4817:7280 with SMTP id
 2adb3069b0e04-53546b5a5f5mr8227258e87.35.1725282132925; Mon, 02 Sep 2024
 06:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902115848.904227-1-liaochen4@huawei.com> <172528209370.32205.2474872138444087655.b4-ty@linaro.org>
In-Reply-To: <172528209370.32205.2474872138444087655.b4-ty@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 15:02:01 +0200
Message-ID: <CAMRc=Mca=p0Agz5d8iHJbxZaTfjoXC_qkjPF=xHPO8-o6N7DOQ@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: modepin: Enable module autoloading
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Liao Chen <liaochen4@huawei.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linus.walleij@linaro.org, 
	michal.simek@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:01=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
>
> On Mon, 02 Sep 2024 11:58:48 +0000, Liao Chen wrote:
> > Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded base=
d
> > on the alias from of_device_id table.
> >
> >
>
> Applied, thanks!
>
> [1/1] gpio: modepin: Enable module autoloading
>       commit: a5135526426df5319d5f4bcd15ae57c45a97714b
>
> Best regards,
> --
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I also added the Fixes tag.

Bart

