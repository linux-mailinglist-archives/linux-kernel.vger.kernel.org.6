Return-Path: <linux-kernel+bounces-563674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5C2A6467E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959373AB5A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B338221F09;
	Mon, 17 Mar 2025 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="JRURzgKE"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF2B221726
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202178; cv=none; b=UwETjfpRXvJ+CNJvGU8xvTKyadz49lVpT/MF5cgymH8ZJ5bzENR54/pwnq0XtOIq1KguRHw18kQid5k/zCZqr3V6mn6u5XcnRM0g44QqHuoolN2uUjnMpr9SUh2Xlsa1+/b4WTYZI7la2UCFVAT9MQzRpkrpt7mNvQvKhGb5eCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202178; c=relaxed/simple;
	bh=1dWEllRi9cT3TdH3a5RD12xiyKLkPsnBpGAgW3m7QSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaF7Up4vHllzHyNUa/Vf8BuTkMrQuRh6RfucSHVUnccwzLZz5D7B/KCLXdXoLOthaNuDWCVB7WZidn/okmK4FXeSqLx7MFKzbTIBVP/XJg9vAiIOAqqFfmCmWTdpTbyeRtIbcLj/U1ox3jyvsZd33i0Jo4hv/FKYdepVjqFsyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=JRURzgKE; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f754678c29so45456457b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1742202174; x=1742806974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dWEllRi9cT3TdH3a5RD12xiyKLkPsnBpGAgW3m7QSU=;
        b=JRURzgKEM4/NrN7SoxKPBlD80hXT8o2Gx5xIJ7mhtgE67aTzbYbkNf4GZu5LkHDNNc
         JqAMqHUi98dfkwLASbOUOvSClCCJfnu7OtTN7PUfUyuvbnebxhMYffLxbUDad3C9EkMy
         u8t7p2UFUlH/m6ERw+nywS1otpYJliDNV5iKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742202174; x=1742806974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dWEllRi9cT3TdH3a5RD12xiyKLkPsnBpGAgW3m7QSU=;
        b=mSW8ivB37dRdMJmCVAvcZkBBsAFIRTOubad4tHOH6BpqhJlKixsP3F4v8TzdjUc67T
         MR3lQGy7awGhBWUKwKc8y2aASP/4Udwwzrkw3LoC0VbpH0UNTnOrkiC48eSZ9HRiKbDN
         9lkfaiMTmUAeYphecxgmCOX4rBz0EoOVdAjAWG0o+BdkQ8Da43qIUK3/fukA+gH4U82e
         iLRQyhKQOmJM4jJ109nvrSEFOFaUSfAtMRkEo0E1K9OBlPdZ/RSMnAsN1FhoKk+YmE6d
         WLvDMty+8d4qKuZMzxu8UtrxNgUqqgUhwXfG1glJkCcnZjgHCnGFZxwa1wqhFVoQ4qNO
         OdtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeQ73H+K5ggXmbYPxiAqoupKjvFvqtZ5Y0wX8uD/i7gR44X1vokCxG+QzD44wzWY9zzhpKqXlK3daVsdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDB1EOlYyLJsYF2AonfBdszSNyYycJRzM1QdjhJPspU52DJ5v1
	TdjeCVSoYvpjsZaeTZun1YLfDhp9NsIBVAessXtR14zldh6rfcFWvHla9t5M0vCTcejBVcmACDR
	sLNzpsNrD00rC2j0JZAG/n3FFdPKQHf3QlMZq
X-Gm-Gg: ASbGncu5nHYlS4v3DBQ/3TMPXCGDuocRIf/6Ef0qpWbd/DbE+6Plq7LPnb5nPrU4PSJ
	HpW0/0XrbRPVdrvvq0DP038B8zzRxOM+OC5ieKa6pFzZ6d0lD+XyekeEP3HLtdm2N9t99+sB4bY
	y+UOQPHlCLUz+nzhZS4TFiBSfA1FgASgSO6GkzWA==
X-Google-Smtp-Source: AGHT+IFxwLvIrrUJC3aUmydVs8gHzldE2CtZrPk3iBJuFIgcQ3Cb8CKXs59a+aYvfUL1UvqXTPtEmQm7tTPDDaq2sbo=
X-Received: by 2002:a05:690c:688b:b0:6f2:96e7:8afc with SMTP id
 00721157ae682-6ff45efbe96mr138552817b3.3.1742202174156; Mon, 17 Mar 2025
 02:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311085030.3593-2-s.seva@4sigma.it> <20250315183644.04fd688b@jic23-huawei>
In-Reply-To: <20250315183644.04fd688b@jic23-huawei>
From: Silvano Seva <s.seva@4sigma.it>
Date: Mon, 17 Mar 2025 10:02:43 +0100
X-Gm-Features: AQ5f1JrJh9Jvyh-BMOeiJ3cLGqoPL_06gDHiu-ccqIer3cUbdFvbbDv_Z2xw41E
Message-ID: <CALKJsrr2T1enr-uzB5s5ijN5=VOag4sP32vob0QCv=a-k2T4pg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_fifo
To: Jonathan Cameron <jic23@kernel.org>
Cc: a.greco@4sigma.it, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 7:36=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 11 Mar 2025 09:49:47 +0100
> Silvano Seva <s.seva@4sigma.it> wrote:
>
> > Prevent st_lsm6dsx_read_fifo from falling in an infinite loop in case
> > pattern_len is equal to zero and the device FIFO is not empty.
> >
> > Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
> > Signed-off-by: Silvano Seva <s.seva@4sigma.it>
> I think you could validly have kept Lorenzo's ack given this was
> just breaking the patch into two parts. I put it back and applied
> these with them marked for stable to the fixes-togreg branch of iio.git
>
Yes, sorry. I mistakenly dropped the "acked-by" when splitting the patch.

Thank you,
Silvano.

