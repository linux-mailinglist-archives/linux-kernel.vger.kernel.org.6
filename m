Return-Path: <linux-kernel+bounces-382181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F79B0A75
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414722831D8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5E21FB89E;
	Fri, 25 Oct 2024 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUFEwHSd"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E521F754F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875580; cv=none; b=R+iCjSThz9Iui3zBXimUx6OH7m6ondOa5r1ZbXsl6V+PnPjV/XMRMiAWmHQ7Xbd8yt0pAa04kbr6cKQCYCHxzhWar9ViY8GihAtdGMiLRUW3K1/dX1CgNRKUz2PNg0oGE+IVSAGy/7njgYHZVpku55xrjw+ITf37Fybpr4zMLf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875580; c=relaxed/simple;
	bh=OVoTc0YV8T4o3On04xQYtTNGHm7Z0vcN9aBbhum2xac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDqn9lJBkt6hjip4akP9pDLIeT6EcwL6blPBA4YILNCbqirtjkVchyGhaV0Ytg/MZGKOco/pWkNXeDdDHcKCe0z2GoyFDTa6m9nwawEh8aPPiL+K2VOpzNJj20dLy0SJfTFloKJ9jRNo02Vpb3zfDgyKY6xSQf/qt7482HwJLCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUFEwHSd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so1581587f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729875577; x=1730480377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9B2cVTHJK0N8Rua3Nes4Pd7LPA0lRXUOHcZHyL1EAuU=;
        b=YUFEwHSdFiFugCXi6NYVQCiawcXHRarubkQrrxKQ1BSE8+bOhj1Cobu/Wg5J+v/fAA
         0OuKXoXALvpJifrUZF8qQIxOmUE9JZfAuDuXNLOAyRKsQbOUsHRebgSjrtRwrzU1u07D
         fqntPSOMtKr9hcAl/A7URGur9I9d6ekA+tt431evMC+PWF2Dgy/rYu+rt5gNiwT0ekwK
         x5GY5o223ZlLqLofl4gMYqPnazvVRKJyULMRqPkonrjjYFR+MdtDJ7elJShrHzvHH/z1
         5VbK3UOSAF8Ew0UZG+77BHkecSv3NZAhysHflXnJWONdx9MjA3s7XfnBbzqw/7JewkYv
         XOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729875577; x=1730480377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9B2cVTHJK0N8Rua3Nes4Pd7LPA0lRXUOHcZHyL1EAuU=;
        b=mXjfQMuyH986bbekAZappzeukmEQzDaQDBe0LBt5TPSfFQLAvueVRXyEHhfJLKBme0
         LeRHk7dkc9eFqEjA/vuLFlOudWxY/jNFovYYIlI+oIW10qY58UghQKK5y78zLQwf1m0m
         eWupES3e6Ccci7VkYA2kq/lHBctuPAcua5Cqhh9gFip4/A2QRnFMkgcThwW33WyAPstc
         unyPRCjocargafkP41KjguXIOjBiejU+4gsMatkuef0LwTngkWJpiOLOuMmsHgp2Pb9H
         +CtndsiXG6aZ+1RLceLu7amuQJfH1BqrTVaEMnkNOPEdPi4x5qosyVbdt1zIdA/BkVYt
         Uu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXImrgfWpv19pAlY0iZ7pvy9nD/HQ3f7Q6V+J/FkhCgksgmM7KYm58c3/DOdhlYPEmLWiF+9Rsi27p/FcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylhGB1MfFFClWoU/3ZTFSppvIyxuyAXAyvblT99DvyT9ZDzqg2
	gQeReA0US2HM8J+yXuMkwRPKWgtDgUxgqXPIMeEXnVihPi1kpKIU2j6cNU+VWOnU8vhMSXX8fyn
	ll5Q+mFQP/1kzutQwMFmzn/kmUu8=
X-Google-Smtp-Source: AGHT+IFAiS4fJ4bly9uLtEmKKdid+ZZVj2dnyAoKdGOFh2vB62Qli5eND3YFrvAL4sXerOTWFnytAdUMonV83uAoq6w=
X-Received: by 2002:adf:f650:0:b0:37d:4e9d:34d1 with SMTP id
 ffacd0b85a97d-380611eea37mr70919f8f.37.1729875577264; Fri, 25 Oct 2024
 09:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021195714.50473-1-niharchaithanya@gmail.com>
 <CA+fCnZf7sX2-H_jRMcJhiYxYZ=5f5oQ7iO__pQnjEXDLUS+fkg@mail.gmail.com> <f26691b2-fe26-4e13-a34f-c4a2a995f25f@gmail.com>
In-Reply-To: <f26691b2-fe26-4e13-a34f-c4a2a995f25f@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 25 Oct 2024 18:59:26 +0200
Message-ID: <CA+fCnZenG-jQqXigPDOrxrnfzXnuirLOigvCWOCoXu=5Wp12EA@mail.gmail.com>
Subject: Re: [PATCH v2] kasan:report: filter out kasan related stack entries
To: Nihar Chaithanya <niharchaithanya@gmail.com>
Cc: elver@google.com, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, skhan@linuxfoundation.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 4:48=E2=80=AFAM Nihar Chaithanya
<niharchaithanya@gmail.com> wrote:
>
> When I included ip-based skipping for filtering access stack trace the
> output was
> inconsistent where the Freed track was not fully printed and it also
> triggered
> the following warning a few times:
>
> [    6.467470][ T4653] Freed by task 511183648:
> [    6.467792][ T4653] ------------[ cut here ]------------
> [    6.468194][ T4653] pool index 100479 out of bounds (466) for stack
> id ffff8880
> [    6.468862][ T4653] WARNING: CPU: 1 PID: 4653 at lib/stackdepot.c:452
> depot_fetch_stack+0x86/0xb0
>
> This was not present when using pattern based skipping. Does modifying
> access
> stack trace when using sanitize_stack_entries() modify the free and
> alloc tracks
> as well? In that case shall we just use pattern based skipping.

To clarify once again: we only want the ip-based filtering for the
access stack trace (the one printed directly from print_report()). For
Allocated/Freed stack traces, we want to use the pattern-based
filtering.

