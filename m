Return-Path: <linux-kernel+bounces-410882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A449CF135
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEBB8B28D22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8221D47AD;
	Fri, 15 Nov 2024 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8XkM5qv"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC416F282
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684261; cv=none; b=JAGUyQyqRMK4TlaN5HAHczixixVhuIMqeMKZ2ATrE1e4RsHcNTTsuq6Y/v0/yCDV7hm0qQpjV+qhQNcvfu8PJu8RjrvHqznfU/RyGsMGQTC9Ygbb9ZtoFUF7OWbVG+VhfALv8avTBCt+3KJCp2SWEsbTeg5RyJWc0PIgHZloCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684261; c=relaxed/simple;
	bh=6CbonmGIEt1LytS/5LcyBBLPi6YyB8nOYoG0UOl1eSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=i35KbERSVfNAgmUQf2lQ6nfbbDbTlPaJGySoJOaDJ2H6N7iyAcfyeanQBoE93g1vB1BCVSkbWZr78NwtIPfxILtnAnbQcVh/spvjr/8rriaj7soHPnhQgpBcJLe5AdxbGkG55L6KKpCQkJbZL5gNzQZRdpxAxQ0HbiYbr09xoPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8XkM5qv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cf6f5d4939so8396a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731684258; x=1732289058; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CbonmGIEt1LytS/5LcyBBLPi6YyB8nOYoG0UOl1eSo=;
        b=o8XkM5qvbh075Uxc2K2mtMtNsVyw7BiPNlOuqhrVio2ScvdzsW/b0MBXbzmk5ALw1N
         jOndOlkPX626cmSWkbKGw6aTSseYiNtqd4agM1VYHlbmPCbfIJyhpQ/SmOaWuKPuBLNM
         o0DaLznaak8QvQI8JJr4kmYegsFr03hyGgUHl1+0TgyTbA4q00EcMrN/0zwkFY0otmX9
         xrBhoFT/mi/XmyIYQZ3Hwd6OxsG3cbatESd41UWirqw668WToqlSEOuhJY90vAoXxnK5
         F8hMef3+7fAWHVzIW+bxwcWeFfO/pOy81najLVPM4Oa4xoMPIrQh1hR8qvldRMUpJOZB
         mTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684258; x=1732289058;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CbonmGIEt1LytS/5LcyBBLPi6YyB8nOYoG0UOl1eSo=;
        b=gpAoW8sHe4RRVyzdgLPxm27/0jvoa0IUrFrj9J8fUr5ogybi2nVZoAAb89BxEZQpTf
         09i6b0srmGa+rF30MXbs0SpFVIipwM1dC7Qn6EYTazuUb6Q2jsAdHsnmv9XmdiZxnxLz
         dwQrc2pvn2RyQRoVeD7W2nxDYNX+8xTy4E0N1xSUCU1Qgt3IzykWQhrU7iON+VyhOSfq
         D3UaOKI42xCghwFDQ4lGdvY8NtHWkVNquLW29rjurHcCk6+2e5h3Nyy8e78zMLRtsE9a
         Jxdw71JXkyxjbIZ2X7G2vRsn0Nr3o5BdCdhQ0EjpFod0eP76myU+OWdxv6W3soGdhMvn
         tA/A==
X-Forwarded-Encrypted: i=1; AJvYcCVABaESuqWIcb5+ckLNWbCZdIfCp22qrmUG6mCtWszicPVy2LsNcesnltgLzX2iidLZOtxGVZ4dSDO8R9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXQRhJQ8PRfxrIefiYxqLBL8kLLNhawe1INdPMJwZZl+fEhREx
	osW+fOx30awh/V9ew3bTkpEaeHoj5P+iY6SUvWWLXWx/XxO1ZAHubHAh7TrWJZcO2hOSUIyJu8m
	PghwFru13Nz5qlH2UYvdZuntiuhx7u33Ywq3O
X-Gm-Gg: ASbGncvLBIdb8qle2a6amu0nnjihq+dk3998bCp5WyqJ8qNHVpMGaPFIR0rAoXXk2C6
	mClIieJwPysan5ep4CHgVVy0WkV2vVsY=
X-Google-Smtp-Source: AGHT+IE0eFPESw33JfWkreHkpBmuXVgMQWpYruE4CtoQxvuEgukCXd5q+5EAuID/wRomZNlf7jXpJVGQwrxqMyn7stw=
X-Received: by 2002:a50:8e51:0:b0:5cf:968d:f807 with SMTP id
 4fb4d7f45d1cf-5cfa069dcddmr30a12.6.1731684257447; Fri, 15 Nov 2024 07:24:17
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115044303.50877-1-brendanhiggins@google.com> <ZzcPJ9sweqxLZOGf@ninjato>
In-Reply-To: <ZzcPJ9sweqxLZOGf@ninjato>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 15 Nov 2024 10:24:05 -0500
Message-ID: <CAFd5g47+y0JH4StoKRTwJTQ2TsUCqmjdxqg=3cxY64Kous73=w@mail.gmail.com>
Subject: Re: [RFC v1] MAINTAINERS: transfer i2c-aspeed maintainership from
 Brendan to Ryan
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Brendan Higgins <brendanhiggins@google.com>, tommy_huang@aspeedtech.com, 
	benh@kernel.crashing.org, joel@jms.id.au, andi.shyti@kernel.org, 
	andrew@codeconstruct.com.au, wsa@kernel.org, ryan_chen@aspeedtech.com, 
	linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	BMC-SW@aspeedtech.com, brendan.higgins@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 4:06=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Fri, Nov 15, 2024 at 04:43:03AM +0000, Brendan Higgins wrote:
> > Remove Brendan Higgins <brendanhiggins@google.com> from i2c-aspeed entr=
y
> > and replace with Ryan Chen <ryan_chen@aspeedtech.com>.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> > I am leaving Google and am going through and cleaning up my @google.com
>
> Thanks for your work on this driver.
>
> > address in the relevant places. I was just going to remove myself from
> > the ASPEED I2C DRIVER since I haven't been paying attention to it, but
> > then I saw Ryan is adding a file for the I2C functions on 2600, which
> > made my think: Should I replace myself with Ryan as the maintainer?
> >
> > I see that I am the only person actually listed as the maintainer at th=
e
> > moment, and I don't want to leave this in an unmaintained state. What
> > does everyone think? Are we cool with Ryan as the new maintainer?
>
> I am fine, depends on Ryan as far as I am concerned.

One thing I forgot to note in my previous email: today - Friday,
November 15th is my last day at Google, so after today I won't have
access to this account. If future replies or patch updates are needed,
they will come from my brendan.higgins@linux.dev account.

