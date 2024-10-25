Return-Path: <linux-kernel+bounces-381211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E8A9AFBFD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D252C28500F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51141D14E3;
	Fri, 25 Oct 2024 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="u5wdzNpC"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840F1C7B75
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843492; cv=none; b=qKktxuMknvnpx4NzltO2XLEmzGAOhzTrRG70kpUKTu2nxicPqFPj58sRfxy1EMG0JG3bHDTghfStZHrneSOA2RrLnVv/F/BH1rgltnNeES7ROQQ5sn+2utt6ixk1pXrg+8yMExR1LRob3cHYVRPu1o9+8GwQObSEISRK57GkC4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843492; c=relaxed/simple;
	bh=LG27d/Q+yaHGWPjf2V5sya6Fe2YC42WZL5WrAo3sYzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNinc6uSf6fCJ2Ij88Axn4fOrkGYZAmjrGKWG5rNp3aHAbOFLGzHqGjTlpsrZpzCVhURBKDwMmQ8KIeyPj7mTSC0HbHnGa3f0n5SU+SmIh/WCJxWgoQ7pTSHCgWLz8/KsWX8t0dJUmxRXWRy0tvc3KDkRECvytK9rkzvkQTUa+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=u5wdzNpC; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f72c913aso2284488e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729843489; x=1730448289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LG27d/Q+yaHGWPjf2V5sya6Fe2YC42WZL5WrAo3sYzw=;
        b=u5wdzNpC6sFSsSqJ6U7oFv9JrL4MWmHo7xxjknEMthUTAb8gYI6ZVWsEnBFYENPB4J
         Sp/giUW9N2Bqj0Mxrcnv19JSagNa7o9nJD+0EU5J2Sj5O7QlUBdksfLFL1gGvenCywLC
         5QLPD1cX7OaQWtPb6hRDdbxWJMk5c9pCFEDaNM3aSnw9qD2AgluaZEMkA+IxKHG4ykTZ
         6kxCfjYTYoekKabI9lAenIF6SSqQ/LVMPjVzLR4JmuqsLoD7FwSDdWNc9Knh+3Stq1dj
         ZqJ+Boe05X4FURUTaL3qHZRT9ukuGxk6SzOPJ2lSr6usKSJVQy6Ng7IJq/q6woh8Uq2o
         mrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843489; x=1730448289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LG27d/Q+yaHGWPjf2V5sya6Fe2YC42WZL5WrAo3sYzw=;
        b=c2XZtCErxqFa3u8/ys8mBD9F6UqPzqWIIhj7XpYf/9dRdh98batWnrU+COhKrO1jeT
         kMEUKWSjTtQ+H11GqWenJ/nQ/9lMaRF6mLoDFRv8eyQEDtcI2NvRWFIMY/TGeA5OFp4j
         GR0WZu/kWggaa+4W2pY9YtZL56nL1NvtleE1aBbZ5NCIecIuiEzHjh+J2TOSuwDHI+S/
         IgmidU+gEjUbxdoHcC/MCG9YMgwNTlTw/sZeN3DcGZpTrH+iW6GkvbSpH5A367FArqSk
         ITZmK8hxNnzkVoyHMIuqPGdjsnsz6FnLOCa2h0s0JWiMJvB0ohavRU6esv37wdH9hJAp
         rR6w==
X-Forwarded-Encrypted: i=1; AJvYcCXFMLzpaxMiWeL/y1ceDyFHqpzJZmjTMCcZtl+R46KSg6Um+rZyLu6m+lW+EY1MHqQ2qFMcqjlW6everX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfhRMwEtZJOvKaIYBxMQqMqZPFBIdK1SxH2JIQ3/Uon9Uhf0XZ
	mej4IQVVY8sOT6uKtCE8WE/IYuGh34awqXHa6TeSy70Q2gLyME+zA7JQ4RLsqE/p5fvqE6OHPW4
	5fyUWW5pF7rGQTIiVd4hKvnHmBVvF4uzzB0Q+MD5Q1iraRCZB
X-Google-Smtp-Source: AGHT+IEAdmGToJtfPEIP9Z9qjfoac4exMG44N9ap94ZRpqSgEEayDPPOyfI6x6+N6f+f12j0SBz2mkUqGZBDIwXyAY0=
X-Received: by 2002:a05:6512:3f1d:b0:539:f7ba:c982 with SMTP id
 2adb3069b0e04-53b23e0d752mr3031299e87.33.1729843488663; Fri, 25 Oct 2024
 01:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008160947.81045-1-brgl@bgdev.pl> <55ecee09-196a-4c7a-b7cf-61c19737735b@linaro.org>
In-Reply-To: <55ecee09-196a-4c7a-b7cf-61c19737735b@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 25 Oct 2024 10:04:37 +0200
Message-ID: <CAMRc=MeTgFaySBFya2e=CYnrXL6R7s9D1DRq+RxKcsf56xMc+g@mail.gmail.com>
Subject: Re: [PATCH] i2c: qup: use generic device property accessors
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, neil.armstrong@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 2:05=E2=80=AFPM <neil.armstrong@linaro.org> wrote:
>
> On 08/10/2024 18:09, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > There's no reason for this driver to use OF-specific property helpers.
> > Drop the last one in favor of the generic variant and no longer include
> > of.h.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> LGTM
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Andi, can you pick this up, please?

Bart

