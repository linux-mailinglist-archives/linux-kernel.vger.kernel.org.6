Return-Path: <linux-kernel+bounces-572524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D87A6CB19
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BCA8A4524
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1BF21C9FE;
	Sat, 22 Mar 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hzj7A0ol"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE21C84B6
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742655301; cv=none; b=HXjoKM7PGniQurtI4UJNn8CJGH+XrqjzKZxNSaLh5NZaWCGnxFya6R88QH3WUlEiRI3SQp9yJIRcLii0lsVLuxbv6ZWn+LBIrMLdRh0qNtJDHttdzEpt9qbUsPz/aokjZOT534aTtWAYdVBIse3dbWeEmDdC9uKqeoIDPOB29p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742655301; c=relaxed/simple;
	bh=BwrWfrlKH9V5dEXgKEnM79/SUo4/kUvCZIBuFhDDsQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWhB2CDGHmYk0VGx6VgDOR3RPIbymA/3+tn04CihRmON/AlQRr68L3s/9/UbrUNhmlSxeP5RFle8Ai9d934L1C/xTPUL8XlfTKZEh0PfrK/X0P6dKuWQ7tlEIrPk3SUsmXOE7DMrnGa8X1dEXkNXC8K74v+zzdgFBYYsTyGTmqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hzj7A0ol; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so17638985e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742655298; x=1743260098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVsv+7+7z707eTgNMAV7D+lcTv5OJ3d2IoxGrmJvKw0=;
        b=Hzj7A0olfl4AMIzWH4jMxTTYfQmfJEStmE3nSlt0WwLxZ9lT4DqUx0AsJgdRp2Meia
         ddnYroSAhlpimeDzyQjhZWdwrS4iZnYo3AEY/6SO9ACWsaqtuyvdRYJHCPMJEId38f/o
         vxKb+UoBSfEaPY4M2pxhVZFmD0ZNZUHQTvKJTYu75u0uBmy2f0ZbhkMJkEjvzpz/Ro7K
         RR98OXppn9/7BdNj5aRPRY2joYd75ZMKSoXTTk219VH0+WQUFqSH89PRfHI1fR9HN5do
         2QtVrPY0NLQgwkCexZjLcw2RLyQFwZ85AGO/rozSvV3XPq1Ahe1B6KSSQYkYNcz9EEQ3
         TSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742655298; x=1743260098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVsv+7+7z707eTgNMAV7D+lcTv5OJ3d2IoxGrmJvKw0=;
        b=TtMfaYyLQ9BJk9YIR6ktbmWuwAEHzEpAUYDzx7/tfdPdTi5vjuwGeXPnpo+sSMhCCv
         NrDMbINVxcNmtbPKmM9cMiX2kXnzO/TJ/ndPxZDULx7fj3a7KUngC257rLYF0+7GHNwb
         sYe1rOeWj8KnFpsE0IrBV78haN+MLONea5s3IQqT8o7mVWUfUvxxSw2yrU8noGRa2P9k
         L78HSDwPsL0u/bKYTLYsaVSzO2wlWLvVMaKSdXojxzJzBasET1g1E13IVfAmAmTfJ2hk
         /GKDE0sv6pCEPDQ4w5V1WYI0wfWkhnPB6pBGsucly+lT7KwZamrpepiZllAWJflGkALj
         5iYA==
X-Forwarded-Encrypted: i=1; AJvYcCXEkQqaZxTyOK1uat6qncox76Tv/J4xZ1Kmpo6aVKQp5XHxgtHmUK48FbncYjim/xNCZHv3vlP4ImgmO5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwRRUG5yoKphipkmMqdHDS5BM444sQ5rrpHdde3LJp5f15XlUn
	XvyBuBLvibzU+p7esNC+FC8S99Ps2OYAnbCHuFJCjU+FFmi63QcxnPePXuDJGUjxp9xAasj0HYT
	A2Fq4H+MdZXUzbyG12bAo42LsZaA=
X-Gm-Gg: ASbGnctL04slxXIS4rUpt7nchUCCKg96BgM8lJgKIyBWd0GM9khX1wTFZQQbGTQnKiS
	b6zYUCEzgLLVHfQl51cTEhMur0CIn6OAbNUv1nu30XjE8MzJj9yBDxOM15NEiTcb0Yc3mMHxiNi
	0oJ3/1oTDV+I2HI98L40oyA/9NhXc4u2laPb/xzUQ=
X-Google-Smtp-Source: AGHT+IHOTXz6vU2UJzXZ1h1hF0qjSMg+BhN4y1f0FSW0ekLWWxEwX3enrSuwJUq000bqT2KVcv8R9mh2dJxA71DufVg=
X-Received: by 2002:a05:600c:ac6:b0:439:91c7:895a with SMTP id
 5b1f17b1804b1-43d49172281mr97741715e9.7.1742655298050; Sat, 22 Mar 2025
 07:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z97Bl9RyFRGZUXNM@HP-650> <alpine.DEB.2.22.394.2503221510230.12345@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2503221510230.12345@hadrien>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Sat, 22 Mar 2025 15:54:46 +0100
X-Gm-Features: AQ5f1JqAXalsgn30MCSXP4SELVQNOiGgBWkb-rypE_PW3Skgrm8Qwl5TBxRuuKM
Message-ID: <CADYq+fboc+_cncOdrBh-2sDNSz9YAFvTqREmV+mmKOHy5QV5gA@mail.gmail.com>
Subject: Re: [PATCH] staging: bcm2835-camera: Modify function call formatting
To: Julia Lawall <julia.lawall@inria.fr>
Cc: outreachy@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 3:11=E2=80=AFPM Julia Lawall <julia.lawall@inria.fr=
> wrote:
>
>
>
> On Sat, 22 Mar 2025, Abraham Samuel Adekunle wrote:
>
> > The line is a function call which ends with an opening parenthesis
> > thereby not adhering to the Linux kernel coding style.
> >
> > Modify the function call to include parameters on the same line as
> > the opening parenthesis to improve readability and consistency while
> > adhering to Linux coding styles.
> >
> > Reported by checkpatch:
> >
> > CHECK: Lines should not end with '('
>
> Please check the get_maintainer script (see tutorial).  It looks like
> there are some other people who should receive patches on this driver.
>
> julia
>
Thank you very much for your review.

Please just to be sure, do I include the emails of the people I
initially sent the patch to or
I should only send the patch again to the other people I did not
include initially?

Adekunle.

