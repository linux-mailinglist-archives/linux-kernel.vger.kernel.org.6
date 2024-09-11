Return-Path: <linux-kernel+bounces-325566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B730C975B63
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C581C225F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0931BB695;
	Wed, 11 Sep 2024 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KqZxMWUR"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07031B9B45
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085477; cv=none; b=Q3oNeoXPD34Pv5Yyg+0ykk1yTDzx7Y0EmnCiymyNbyuM0dnmfdkJY9tGJa/IVWTFlGZ7iCpCV1ixGXbj5sxjKfVvyg8ygL05u2JKal226Rpp6GtZnwk0GITv6jxBNHgh9QmWLk2tKO7XEx1O4TXqJM87X2bbVxr6BagcpKuz+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085477; c=relaxed/simple;
	bh=Gfeo0pts1aKNrhuuvPiQZjscjhY8caWDURFJ6yrEmk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpTA2gQw6Kdfllrg2yf7IFblDm40k0sCE+MKuiQIoiIXGkvyilW265Mbw0mZkvzgh9K5TPpmt4SD2XXruh5DHeC6E/gF1pjbTzWagOLdQ/MKuPKl2exVdA00PpulDrT4YY4trFgWr1XB/VwalwdV/R+Rl39dx9bY2ibm4Fu+KhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KqZxMWUR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so30120366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726085474; x=1726690274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gfeo0pts1aKNrhuuvPiQZjscjhY8caWDURFJ6yrEmk0=;
        b=KqZxMWURz12DTuanXNAkhlaFENkt4el1ZbJMGCwTB6KKJx/EUsFphZp4jJl93YfRXn
         bJW5TjoIioeNCTZOgZoqhZoYDlINNF7aRC2C+pYOJeA9Ki6JZVsgFCkDIbBBAzHnGlGh
         Gs5BOrOzHOfAZ/zS7iHgmv06mGZDRSGKu/dJlgV5zxdJ4ocUJY+BKIPrcEt1GZ1OOjD8
         oIPXljeUkpItp45aFmdb5mBGLTgdWtyVEDB4d6R4JsOhLwsi0Azt+LtiowB3O0XQSKQn
         ws7lDEdJAaVOKbENPKw/Usxm8NtilvjvVhrL4ZLOTO2Yam5MInXR41s4f0jz23O8xfAb
         xz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085474; x=1726690274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gfeo0pts1aKNrhuuvPiQZjscjhY8caWDURFJ6yrEmk0=;
        b=qHGBTUbV7q6oeZgTLaryAF4PTIirvOthlVJ+LPkl6tBlqXEaSubZxX/Xv6FqI8sGDk
         IdrsiDFrJjcEiys6AS3/ttUbut1b6R/hnj+Cg3wAWulbRUhnRo73C/6zg6S4tmY2AMW3
         kKLWh7PEobP58/GeGlpb7XVUQAjqwyqyQbuZTsMpKwdzhlxGOX+ZRiynb5E6qcCLTiVg
         66OgxyyBmYZWmv9oVCQ9hFlZ3ANU61w/zXjlv8Vqi3H+LlFbJB8geDAdqeN4QoKfWNlt
         +ORFk2swgOKVLImnS810zRNGkQRNLtUnDDdWNAtfY24QFM+os4xigGsKx76HPbriEEgo
         Uj9A==
X-Forwarded-Encrypted: i=1; AJvYcCVOYaj0HhVQD4X555Qj7LHz0L16KSl0oX9/IhHeibxrVaYqoH70ogJdpXsMqJZ5+yex+mppM0/usc16wLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgpJVlsPD95oT2qXUaSlDBweuCbk+sQPdsuKfncyM9CxMgSfw
	5Gj9L0A+LOvvVO4hKqW0ir0XczQTa79cglrBqqR0e6RGMEyCmwElt9azh3kk01XwOLsW5TcDQSA
	zbqE2y0aXBC0mmwXfI00XRlCv2wyYygVU7mI=
X-Google-Smtp-Source: AGHT+IEIPUvxfxiC/iShx6EyMhl3F1u2Ko7IlvNDcawQ5GwM9Undm13TQ81z5iIhuD0VQFKe6gSCIeQbTrbZ4sveDIc=
X-Received: by 2002:a17:907:e620:b0:a8d:250a:52a8 with SMTP id
 a640c23a62f3a-a90294aac4dmr59191666b.3.1726085473510; Wed, 11 Sep 2024
 13:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-4-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-4-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:11:00 -0700
Message-ID: <CANDhNCr67G3NH-K5rEJiiDPZJhX6jCvjwchv==GhUaWWXpdTRQ@mail.gmail.com>
Subject: Re: [PATCH 04/21] ntp: Cleanup formatting of code
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:17=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> Code is partially formatted in a creative way which makes reading
> harder. Examples are function calls over several lines where the
> indentation does not start at the same height then the open bracket after
> the function name.
>
> Improve formatting but do not make a functional change.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

