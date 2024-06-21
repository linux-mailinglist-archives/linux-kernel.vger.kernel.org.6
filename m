Return-Path: <linux-kernel+bounces-225253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696D4912E21
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4111B22E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0FF17BB31;
	Fri, 21 Jun 2024 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WzWdq4KX"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5252417BB06
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718999553; cv=none; b=IOpkTkrEvQvnpLXggMXaLIaYECaZ5bThxNo2jAfdd+UJeowog7es2MF6Tlh8kb+r2R50pgg9i06Vcxanck21hz+gpEEsnsm7gnHjMU4Q/r4CuPIOFuIYfk0oIRJyeM74Moz+geVmbBmq/yvZHA4xNOHe7zT2aTaFtEZmBwZMb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718999553; c=relaxed/simple;
	bh=jMKGPY/7u8TnNMIfIPhSGai4Rza/s0QV24uQBC0AouE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trUeI377poYknBKS2PXaThlvJViC80ZNGN27jEthMHuc/+YRi/Vs5KYi+vBW3gu6y33NyKdY/LZw0BJR9oLsHUZ21w/lPN6ApwniMFerYCBFY1bXe7i1acMBYQYdzb9F4eXzXitWpGEn225ChHYMLc6GqLW2wk2eEyeqqeyJ8Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WzWdq4KX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79bc769b014so155150085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718999550; x=1719604350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMKGPY/7u8TnNMIfIPhSGai4Rza/s0QV24uQBC0AouE=;
        b=WzWdq4KX0+sibrKQkTCA8/NuTTHci2EEOx5uAH4cMxDcK9UyxLEA1EJY+gvTi9ItdZ
         8suK3NsJ/9L0mHqGsFIDU5QS6HmIbbK7wW3MWMgnW1Lvb73CIrtaO5HsvdB9uRAzJp3+
         Gbao/eVTc++ZbDSxoTA9eHCzNOitZUIcK6OXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718999550; x=1719604350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMKGPY/7u8TnNMIfIPhSGai4Rza/s0QV24uQBC0AouE=;
        b=xNBnoJReyBtr7yejqAhbZ57p/xVkDi5wTHvb1qpkG0N1G8gcTuplJ0oaU1mI7EgMdW
         DLduefsREf4dQ4lg078biZ7g8KAdZzOfavXi27oW35KGvq3ePiFqVfImENA8+/yaMFhi
         4swUwycEy5OduTMXKaLrcuchm5nXkEy9CspF/rr/Ca3uyppzflizUALKoEr2cHIiQKBt
         3S38IvpQVM9dyB8Bj6pRUgT+H78SazIj/EjDO95gRli1vD1H8pbF1CvGLYjaus7BUM1W
         2GItEwNkHjTw7H9xDeGy8bH5PQqe/6wc59UDPCFSIKxNVeblHZxXVUGwIK6GPwTAa4c9
         Drtg==
X-Forwarded-Encrypted: i=1; AJvYcCX3RnkXIVVhqRWHRZ0F0PH6sSpMjbaObH2IE2o5w4IIBtjKk4xJHhCDI2xYNUwO2FVOUudhB2B1yS3OfyrfNQkBJHWokcrLq4uDh+y9
X-Gm-Message-State: AOJu0YySS8IdtILBZJv4u4OfKFDZ0gODVLMdBcv4muOf4PB198iIaLKa
	GJkH4j4GKcZg43Uyd4l4HOjeB0Mvm5JKo6/7zVyeqYzqFDaFjMtB0swm/ccpBJMvbdlF5Wy4Uno
	=
X-Google-Smtp-Source: AGHT+IGHAw3GBnJugSXlUNkTTcByHLxuMlkOvz6bke2hqRYOAWGJ9JY80qn4iStXc6dOjjvuAQNz3A==
X-Received: by 2002:a05:620a:31a6:b0:79b:d9b2:d34a with SMTP id af79cd13be357-79bd9b2d44emr128069385a.23.1718999550178;
        Fri, 21 Jun 2024 12:52:30 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8c3775sm111795585a.59.2024.06.21.12.52.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 12:52:29 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-443580f290dso455441cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:52:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlFOwuvZ9RXCBGOy8gRzLl4QCyPh5QMkd+wNdz/0Vr+RCYDT1OCmJm1ATjTqtltul5rie59CvW3t7hwIC+FaunjnAr+0Cs/FwAcgRh
X-Received: by 2002:a05:622a:1a01:b0:444:92a6:188a with SMTP id
 d75a77b69052e-444ce2be63dmr297041cf.9.1718999548030; Fri, 21 Jun 2024
 12:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618003546.4144638-1-dianders@chromium.org>
 <20240617173426.13.I572fb3cf62fae1e728dd154081101ae264dc3670@changeid>
 <20240618155938.GG11330@aspen.lan> <CAD=FV=VTegKBcHY9pgfFUs7T1Ug5r1yg+CxLE6sBhBBt4csfkw@mail.gmail.com>
 <20240621154349.GE285771@aspen.lan>
In-Reply-To: <20240621154349.GE285771@aspen.lan>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 21 Jun 2024 12:52:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UHh1L13GDSQrSQMJOwwkcFku5X9zCuKt0aZw3Qq9a+VQ@mail.gmail.com>
Message-ID: <CAD=FV=UHh1L13GDSQrSQMJOwwkcFku5X9zCuKt0aZw3Qq9a+VQ@mail.gmail.com>
Subject: Re: [PATCH 13/13] kdb: Add mdi, mdiW / mdiWcN commands to show
 iomapped memory
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Jason Wessel <jason.wessel@windriver.com>, 
	Thorsten Blum <thorsten.blum@toblux.com>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 21, 2024 at 8:43=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> For example I have long wanted to be able to let
> the user see /proc/interrupts before the usespace comes up but the spin
> locks get in the way.

BTW the "gdb" scripts are supposed to handle this with
"lx-interruptlist", though when I try it right now it doesn't seem to
work.

...actually, there's also a script "lx-iomem" which sounds great but
only has the physical addresses. :(

-Doug

