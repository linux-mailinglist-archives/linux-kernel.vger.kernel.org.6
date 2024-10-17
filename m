Return-Path: <linux-kernel+bounces-369667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A8E9A20BB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9FE1C222CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A01DBB2C;
	Thu, 17 Oct 2024 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2cztVCj"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47981DBB0C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163537; cv=none; b=cSyusf4SPP2BFK4gAyyZJAaWIJzSs9RfTj0ch5A+bAy16AMmziPrNojjCEr0OlsT8Y9+qoVJxUiOj0/tav3egRvo3Cf0YbbAzMSN3BF5WslzOzx3WHrntWqTYK0WlAG/IfgZLAGehl4SGWmXgB9s/AU5+pvRFXs4NZmaWWB/p/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163537; c=relaxed/simple;
	bh=zKdUS339pHOOXA+tBvmsS8ugcMtfQs7dgxpIpkGWeuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFa1ifJKj2NdQLwZjQPN3hTm616hcBsxJT9zLBk1adpL7jnF4iQey2lGwkO/RnP0jNic3YZXdIdXBbgFsOkEXzFMxqlnugC8wuv/TOTPcpjT01ji/5xmbqFZbEPyza7+oLBkqozihF/eGfEAs2Bam6oMQi9L/P2kB5fcogPRJiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2cztVCj; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c948c41edeso1024285a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 04:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729163533; x=1729768333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2f/5CdwlqDZzfToSurNpkysibov1LhVKsU7xXN+KuE=;
        b=R2cztVCj1M6HojvKnwyaZlGoo9cKNQqLg5oZ0K+jMEVLfCsTvkBdPNfpgH51ueDJLY
         ZEAjVGmApowhU5KZfBbjU9RcmQR4+/1gFYYsSAGKQwEKH8O0ZE30Vzr/2HjOzbZy9+Tj
         +tatnt9BPuB+zCDY6fD1fZx3fZ89NvSIPRCrNUL6huSacVwf6EMEYvEpg17Ecpuqp5zK
         d9kgC3n+D2yHGo3UUoz+XrU9w4OVO3Pu4ZWi5Dca+C21jYT9bgBO0o2GGM3ZbCBSzpBl
         lc//pbNVDV3txOqz4v2D7qo23rLWUCL7MCWXN6ECHsFIn05ix/8CHBGsAnF9OEjHp7cW
         e59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729163533; x=1729768333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2f/5CdwlqDZzfToSurNpkysibov1LhVKsU7xXN+KuE=;
        b=JNCM8avxKYfReprCEofUfdn3bOy/oVPaeDR2A+f23xYyx/3TXevBq00TRXs48ZErmk
         xZK7A8ArG93bCo6/aWYas/fr+x6TsVY/TqbEsla0S4Wi2mCHRdeL42NYSpFeJIY9v7uh
         UWZMOf6Qy7ploYmm5xd2AYu8YheYg5/pC6pzVKaJHw61m7imXX1BcUykkj0P7dYYcDwZ
         GNJtEica+WMNrDdCjM6ky18p0v1YL4PuPp9eQpJRZQp/gUk6KAohhyswR6IHIaiTXQIP
         Anr38IrTOb4oPAUqLlsSoh10d1HovAnkqGCAKsH8fjH7dmPwuFxY/s0YKPL5bItOgaZ0
         ITpg==
X-Gm-Message-State: AOJu0Ywo6XKGkBAFVRhwRVMb4Jkiw/PWbVm8ANQWUMXDzq5sDqdRmwbN
	Iunw8+tEXSztqb2IAd3GTnkcAJRTTKiJeBaH/VC1ezorZVz6PSWeTau2R0UdANBC6W0/oPnJOo2
	uIoZ6T7OFtO4eE8y4VdoS+P93rchZMC7v
X-Google-Smtp-Source: AGHT+IHSlLqfHkfXjcrCrqw6HVJJpqqJW1sN04velCYQ/+/CcptzRhKhS5HTJ56w/NaVMDxgvs11CXhycPsWrCOogtU=
X-Received: by 2002:a05:6402:42c9:b0:5c9:6bd9:68db with SMTP id
 4fb4d7f45d1cf-5c96bd96bd1mr12186832a12.3.1729163532841; Thu, 17 Oct 2024
 04:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024101416-scouring-upbeat-b658@gregkh> <20241015070226.15790-1-vimal.agrawal@sophos.com>
 <92435cd4-c0e1-4d05-8ecf-52dd9249adf4@quicinc.com>
In-Reply-To: <92435cd4-c0e1-4d05-8ecf-52dd9249adf4@quicinc.com>
From: Vimal Agrawal <avimalin@gmail.com>
Date: Thu, 17 Oct 2024 16:42:01 +0530
Message-ID: <CALkUMdS3wEuSi5SGqsRKt3nSb4mHue1bJTJm8=QL3OLYU2GWig@mail.gmail.com>
Subject: Re: [PATCH v2] misc: misc_minor_alloc to use ida for all dynamic/misc
 dynamic minors
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, 
	vimal.agrawal@sophos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

Thanks. I will be adding MODULE_DESCRIPTION in the next version of the
patch. Will be splitting kunit changes from this patch in two patch
series.

Vimal

On Wed, Oct 16, 2024 at 3:48=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> On 10/15/24 00:02, Vimal Agrawal wrote:
> ...
> > +static struct kunit_suite test_suite =3D {
> > +     .name =3D "misc_minor_test",
> > +     .test_cases =3D test_cases,
> > +};
> > +kunit_test_suite(test_suite);
> > +
> > +MODULE_LICENSE("GPL");
>
> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
> description is missing"), a module without a MODULE_DESCRIPTION() will
> result in a warning when built with make W=3D1. Recently, multiple
> developers have been eradicating these warnings treewide, and very few
> (if any) are left, so please don't introduce a new one :)
>
> Please add the missing MODULE_DESCRIPTION()
>
> /jeff

