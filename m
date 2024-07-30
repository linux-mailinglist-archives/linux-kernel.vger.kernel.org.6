Return-Path: <linux-kernel+bounces-267351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B57B6941092
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10081C2292C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF7819DFBB;
	Tue, 30 Jul 2024 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xB+/yIJs"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224518FC82
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339343; cv=none; b=jk78876lLIbj4HPcMmNvLKS8XAtuBdRBeVO97WyV7RMRsqJS6Z+W58BoVoZf8044Pn82k59Ag92LgzerxizN1Yiizfc6Rf+VUauhkIXksRuFavyGn17sFdSWRRJqCzvDublKVA5dEonQWtW2glGrtbCMaD8QaZGKn1H2Jpiau/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339343; c=relaxed/simple;
	bh=SzNw+nJT8xnyHFJk4AFqUzJHF3dVziOgXld+vZg41KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sw48KPLGeg86t7L6+DfTs5FbDU9A/mhL61zGHuqasbQnCg9L2Tb8fIbcKsWZdvI8voaz80KC5pl4oR3EjjILwEX6lB47R+RKB0uvAZxIVfGS8ifY53pJRyjA6EjH+Fe+LQEuoimiYIiuNXCd01MXYM/ouQuS237kVbzd+hQKEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xB+/yIJs; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f035ae1083so59166021fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722339340; x=1722944140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACWV171VokTXiOyHIrE7ejnV5EZjVW2CRSKDS5Os8P8=;
        b=xB+/yIJsqrDs29zeI1EFrc2n1qgUgpcHe8QvSWRjrEjH8AMZjbSQe9+ZLNEw2UH4AD
         g5L8QRFk6Uv2yffl6KGY50sRszczpZfRbT1OVNtpaZnpZCYGPGwfY+i72oYRtSccQIiW
         YVS6JkxpUnhk/iNx+lTdU02CVV3ykOWYeCy/pqH5aLZbdldGgyG8M437oa2sR9/cMrf7
         i/5GtDH2/zeCmn8CilpHcNVYE3QbY4D0Gzgdf7Av+b1G0Sm4B3E9Og9PYg6Xf90DIB/W
         59ddBMQTzpqa/tVxQrBFc38eztC33abCkANIgYyvHdEytkUbMblR/nxMHYGyrr4vE8sv
         qpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722339340; x=1722944140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACWV171VokTXiOyHIrE7ejnV5EZjVW2CRSKDS5Os8P8=;
        b=q9kwAqvzeHUB1s67bZ8UvqWGRGZCYEh4PydXV2FbE4LBwg8Ii9ptKYcaXBsMhK7lHX
         sAicpvq1+5gpetKLM43F8twtCmH2YX7wu0DSTAdKzF6SPpM97ljYFsJKxz29iY6sR172
         yAdJJvgPte5emQQkdIBBzr8B9Kau99nZ7G0LQYn9YFJxIEYgUd3xtEC5RwdBvohsQIwa
         RZY+Kxbnt/r7Njuc2gZOzhZyiHLqlcBvo3VngeCrIt/9DBwXT6iXQPPPR58it541zlTZ
         FhIA5O/zrasRcWbuBlvYVr1tV24z3batavGz0uJO7zMRzt6c2L9zvHY3G8JpuPd5i+ui
         s/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWseawXa4YrTXbyjjg50BRzR9x83unbs/kBzDwSg9p+C8Hwdq7UGhjD8tUjoUvrQQDbwn8RlS1Hkf7jna9N3S8XVB+LQsQbbBOal50P
X-Gm-Message-State: AOJu0YyGbBBnzD6fMw266fQM/1IsXtHXwK9TYF5NR/D6CWHq3SnYavG6
	JZjnJvadrsj4GA2G/jjZiW/2U6FCGwbyYEebVCur/zj4WMpz9kBT08+w3sQe70RYBNqc5oPfcA5
	SQtIVNoK7WHvQ+QmkqBbI09sKutxN9PMYxF4D4g==
X-Google-Smtp-Source: AGHT+IEdPXeLx5lLnsguxewxdMk+52p9t22OEqveNu0n933FvEZ3rr94X4Jj0LIrany5Lo1tS7gOYw/F7T/7oGv7pRI=
X-Received: by 2002:a2e:730b:0:b0:2ef:2ed2:25b1 with SMTP id
 38308e7fff4ca-2f12ee192bfmr71795571fa.20.1722339340222; Tue, 30 Jul 2024
 04:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729095542.21097-1-johan+linaro@kernel.org>
 <CAMRc=McuqEv1Sk9O6kn4aHo9wOfzskZS0z2QxzNM=q2N8XZ3zw@mail.gmail.com>
 <Zqduv66H2OczRgaH@hovoldconsulting.com> <CAMRc=MfEkPcKUNb7HbiNrqv+7q1n0wRD9sKQ8WrydoR4grao2A@mail.gmail.com>
 <ZqeP7CqEoC5iWAdL@hovoldconsulting.com>
In-Reply-To: <ZqeP7CqEoC5iWAdL@hovoldconsulting.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 30 Jul 2024 13:35:28 +0200
Message-ID: <CAMRc=MecyZU6DBWjg7vtohhxtVoaOR6jCRHdEiAKinqvmEtDyQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "firmware: qcom: qseecom: convert to using the TZ allocator"
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Amirreza Zarrabi <quic_azarrabi@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:49=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Jul 29, 2024 at 02:35:39PM +0200, Bartosz Golaszewski wrote:
> > > > On Mon, Jul 29, 2024 at 11:58=E2=80=AFAM Johan Hovold <johan+linaro=
@kernel.org> wrote:
> > > > >
> > > > > This reverts commit 6612103ec35af6058bb85ab24dae28e119b3c055.
> > > > >
> > > > > Using the "TZ allocator" for qcseecom breaks efivars on machines =
like
> > > > > the Lenovo ThinkPad X13s and x1e80100 CRD:
> > > > >
> > > > >         qcom_scm firmware:scm: qseecom: scm call failed with erro=
r -22
>
> > How do you reproduce this on x1e?
>
> Just boot 6.11-rc1 and you should see the above error (and there are no
> variables under /sys/firmware/efi/efivars/).
>
> Johan

I'm trying to figure out what the difference is with and without
tzmem. Surprisingly the physical address passed down to the SCM call
is actually the same in both cases.

I figured that maybe using different struct device for the underlying
dma_alloc_coherent() would be the culprit but I checked and no.

I'm still on it.

Bart

