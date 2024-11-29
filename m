Return-Path: <linux-kernel+bounces-425924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FAE9DEC9C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CBA1281BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A36B1A3056;
	Fri, 29 Nov 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GvKlQkzj"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A661214F126
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732910656; cv=none; b=gU0+opIh2ZnP1OwZwpYGiNFAbl1sl3kE5I5GCvN6waK6Iux08ZBDbuVKl2o4nmkMaVpaUOLDbL4lFdcKp6LJBupwSlTTyjY0soIkC5e8vjcNpl+IHDUcClRd3ylHAJe6DNQkxIB1qdc3iHHyi7fMzwlIWOvYk239cyiPhd0awxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732910656; c=relaxed/simple;
	bh=YiQQdrsvZ8u+vT+N22MshcrR+ZiBD082KKR1pcVh4bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNV0wuASy6sqXLGohgxNOGoRVCS1lh6qv1I91NtClwUeClZ1qswmvHikUyG2Py7XRGcTSdE3XUcMlxPQ/iWzXs+xjh2nFAGgIjs2EmOARpcB3TDiQkx3EoM1NWWxH90FK0leTs5Hon0kUlGoofeIhskUEW6nqBWG4MagLD5DMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GvKlQkzj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa52a5641f8so295055766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 12:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732910653; x=1733515453; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lcmuu2jINkD9ZCRt5AtefT90arhaSrjY047NfXERnfU=;
        b=GvKlQkzjBbf5iF9JQarjac//cW9jzhrB48GfSo2z1HjlRXR9A1c0SSoltQRcNjamDm
         kHOy+arxQUxFyZ1nx1Fvs69wpShR3+JOa+4Xth08t0uFRorIlEUEakKx63xcMTvVhD13
         h1QKpSXUDtAAwULpTUFO0EbqXOkiYjyGPR+yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732910653; x=1733515453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lcmuu2jINkD9ZCRt5AtefT90arhaSrjY047NfXERnfU=;
        b=i5GDhlHulZxPNKHFFIaX1d84rZDMBwYhF6b8UNBHHaqjHZwQxhNBuzBO5XZzEOY+q3
         QO8aEdqDyP0MnlHx9n9MYUqroxCxbnpMHeJmABbTCaiON3xBotbGRz4muuXK+FdqS2qb
         OZNzZ0lVvegb/D01ceu5846d9tfBv3khN7rBihqj27a2ESGTbnZBJsLrWUIyncVTNW09
         FNwU9CJZmz+6RyjQjdEGxkcXmbcxHfWo2OOx5mjM9DghjSu8mrrx8uSGphqSEy4Lrfq1
         gNFkkxzEdP/0NGtK0Pxe3GQ3ErpeHRjhC1prKdPR4X661mp9BXbXUR7peX9lTFPecQFv
         0JHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8LcQnZIQPTg6GRBEqT/zmVyJzZ1l26lMNDsrO3e9PoqwE+4+rZX3ZeMVeKTEdYkLeT7KDx37FtQGpyHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztKBM+NJZYtfe5vzL4ypNkkZxLWun/vksscHM3tIX0/aOwM0Ad
	3QiI4dGEDsuA2hnz+fEITj7HhL0qLm0tr+aMvULRgjaXbmYvPPlls5UzMZRzP1GIJwPGG5lZBlP
	yr1Nvwg==
X-Gm-Gg: ASbGnctIxfvyTY0m6DgoSYMiavJQIgkyFj0WE4iqMzjSaMC5X9RuZCg2tGSAK0nO2hr
	WU0G9pP/d1oTSEWc55dPKIWNc3y4biR/QSJMKTLdsJUsV14S2dJIJP/6jCf2AIYkp6CWqnqitzm
	CkyxF5peFj+Wx7kPP5UjcuDtJqDa60b9gq6uniHmEgprmz2Y9RbfG0fJVJToZr56/nBBUr7gYlo
	ph45e12G2URlEIecBK+ZNcd5UOHxrWyscl1fpY0Ryjp/qoaf4OxIzKjT2Vf90Kmtc2Yr58mt6rO
	8RZ1TIXDYM1z6iCarqQCXth6
X-Google-Smtp-Source: AGHT+IFOihJT4vSwDHQGLwNagj9wVTVEtgET2rTsZ2Z+cJXdJ8of1SfMBdwPFqUBIf6Ve1N3IGCHgA==
X-Received: by 2002:a17:906:3ca2:b0:aa5:427e:6c76 with SMTP id a640c23a62f3a-aa580b2f6b3mr976023766b.0.1732910652355;
        Fri, 29 Nov 2024 12:04:12 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a848sm206310466b.150.2024.11.29.12.04.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 12:04:11 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa52a5641f8so295047466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 12:04:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWt6OUjhFQetgL1totjIjpF172mBnPRP0mFdtqp3L/JjWB3y7nFNRx3I4eX0ID7mnzCsaba0V0p73gYrew=@vger.kernel.org
X-Received: by 2002:a17:906:2189:b0:a9a:3705:9ad9 with SMTP id
 a640c23a62f3a-aa5810719d7mr905194566b.50.1732910650277; Fri, 29 Nov 2024
 12:04:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0lG-CIjqvSvKWK4@kroah.com>
In-Reply-To: <Z0lG-CIjqvSvKWK4@kroah.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Nov 2024 12:03:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjRj_PdQ63rnO0ikN9b1wqTCC2JHdVdmtDQgayeXe_==Q@mail.gmail.com>
Message-ID: <CAHk-=wjRj_PdQ63rnO0ikN9b1wqTCC2JHdVdmtDQgayeXe_==Q@mail.gmail.com>
Subject: Re: [GIT PULL] Char/Misc/IIO driver changes for 6.13-rc1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rust-for-linux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 20:45, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Note, there is a semi-hairy rust merge conflict when pulling this.

LOL. That was literally just one side changing "core::ffi" to
"kernel:ffi" next to some other unrelated changes. Not a big deal,
even for a rust-newbie like me.

           Linus

