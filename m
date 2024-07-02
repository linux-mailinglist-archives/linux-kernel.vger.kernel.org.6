Return-Path: <linux-kernel+bounces-238258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DBB92478B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A742281DB2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307521CB335;
	Tue,  2 Jul 2024 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYCT38O4"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEAE1BD00A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946200; cv=none; b=lHk/U0pGd29yhJulgXBry1Ppfvgx86sp7fjKj6hMmhcbA/lxHz4F13fSAO01ZE6zUas/pmOTWxG7NVRbnDqghI7eAVnB7czN/RcOUF+QDB85XrZi0mW6s4nAAIFYD0RR06XBbAwq9rrQskbO+6FFP4QsMJkApKex4qNkFGyNklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946200; c=relaxed/simple;
	bh=wBCH0RGXQscHQNhVbPuJToAcNW1ub3XjfpU3YyPq5Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ar/9OMnFSeIEptFpHN/9vkO7MAc72gWyErFmOJTi7pFBfEsb76bTrMFCc5d4PvqwNyOQ5C0kkAbJkA86WxWi0nbUtWXLsUUMHioxlPkWWo5iuWdxetSIfUySxFHumRWrhxSR6n6y1oqSXsSVFZkEKWpnPp+RkpGLxzS+8BPLeHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYCT38O4; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58c92e77ac7so1757a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719946197; x=1720550997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBCH0RGXQscHQNhVbPuJToAcNW1ub3XjfpU3YyPq5Pg=;
        b=pYCT38O4BWrPsDNAJuC8oCfG1wPjSDFz/t+1NIR1LZAfM/o6d62IrI1ABe/5NJggci
         b1LlyRfoRIIqkwVQh65Iexis2zIQ4ZIPesXtN5e69aHaSvDTppSV1xlB1ybet4Kmf9Zg
         uRPvxHmij9YQuqMtnOlds6PMsrESLjrvDMVfbsVcTP+r3wAotj15Zd88rtV1Ndd0/EgB
         /iWh7fvblF7ViZtt7UV4WyAo6UhuXhxDy40wUbnfNOETfPZkk5wlEQJqCgZ94XEAOs6h
         5sXANOZozoUZfp9yhYnGv2m6UjM2HORXncFze21QO3DDdA7NqE+jvEmu9fOut9E1/Bx9
         sQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719946197; x=1720550997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBCH0RGXQscHQNhVbPuJToAcNW1ub3XjfpU3YyPq5Pg=;
        b=TmYsAYCYK+685y7E8UgZn4dFtSdCOzvwPNEi2TSmb+65U1x0q5/0HK0fcPa+z1e9bk
         zuGFfwdwuEAy5uAK4s+zCVHlgpm/48CwxFzi2dsOeZ+qzt9tqJ3DA7rbuxs0ViiEFeb7
         ciIbYSEDRN2KtDDUXyj9tZ5pezktI7B8PAivWPYIZxn+TFMneAnOjHKDXTvasVX+eAwE
         0ot8MM0sTVg4lqwYrHnUI3fPnEXdbi5/ggck2Yz/Sx9Ka569BDugndK6YK1QOQGUmN3Z
         ovDaFFpYYA4UqtU+H+t35CUrEeGyITUaQkTAddpdH3Mdja8uEIt1MjBYrW/trdWKgbBM
         ETjg==
X-Forwarded-Encrypted: i=1; AJvYcCXJWvj6E92KClCXsnttGa0vf9ImzSRmm/3GDK7cv/vhL04SBJroes7KyR1JyX/yk+t9pcmzM7s/5jNzUE7KqaSyxL6ZEsrnJPmhIoAM
X-Gm-Message-State: AOJu0Yz4o0pIf775aibYwTyS0pi14KgBJkZJUmdGNX9sVHcoREm27RbB
	saMQZxCvvqQMAk2T0u2xRTwK+vnf+ZmqTQFJtbxoHOjHkUDmAsZMlvKAYke3J3+cXy/ZAkQHZZc
	B32JiQGv4PdEYtGBvYVsfaN8335Q6dc0Wu9De
X-Google-Smtp-Source: AGHT+IEXouaVIvQZ1bo2Efta4GbpBxhXnzrZmhgd0nFm/uUDODI5B9UrHV01kVC3BKPp2wNuFauI52mbQ00Tz1Bob00=
X-Received: by 2002:a50:9e2c:0:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-58c9891046cmr17632a12.7.1719946197278; Tue, 02 Jul 2024
 11:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614233105.265009-1-jhubbard@nvidia.com> <20240614233105.265009-2-jhubbard@nvidia.com>
 <CAG4es9WQOOga8Oh9BOjr_JXy5gcUzVN0iTtfjN_HVdRj7_G7iQ@mail.gmail.com> <b4720a40-6e74-4b1d-93ca-a3444e400a1a@nvidia.com>
In-Reply-To: <b4720a40-6e74-4b1d-93ca-a3444e400a1a@nvidia.com>
From: Edward Liaw <edliaw@google.com>
Date: Tue, 2 Jul 2024 11:49:31 -0700
Message-ID: <CAG4es9V4EiVBi08X7xNrEpCd5eUum1-5DrYV7+52BB=OP_4DKA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] selftests/vDSO: fix clang build errors and warnings
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Andy Lutomirski <luto@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Valentin Obst <kernel@valentinobst.de>, 
	linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	llvm@lists.linux.dev, Carlos Llamas <cmllamas@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 11:26=E2=80=AFAM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> On 7/2/24 11:12 AM, Edward Liaw wrote:
> > On Fri, Jun 14, 2024 at 4:31=E2=80=AFPM John Hubbard <jhubbard@nvidia.c=
om> wrote:
> ...
> > Hi John,
> > Could you try re-submitting this series with the RESEND prefix?
> >
> > Thanks,
> > Edward
>
> Sure. Is that the key, for kselftests? Because I've got 5+ small
> patchsets that are languishing there, and I'm at a loss for how to even
> get a response, much less get something merged.

I don't really know, but it was suggested to me that it can help to
point out that the patch might have been missed before.

>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>

