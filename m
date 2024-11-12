Return-Path: <linux-kernel+bounces-405417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 534C89C510D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1995928332B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B0120B808;
	Tue, 12 Nov 2024 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki2FqrLN"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D456620A5FF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401080; cv=none; b=UIdc4vjURpsh9hH4Zd1LkSYUk4IMSZEo0WBXbtrrN77ssc/5uFuGRcQAjlFeSpiRngHAxkf3W92F9hUso8J7bxt3G16GKPhSWPdFO7noKNEdOaYQ4htSgqZA4mYs6zdEat1oHN3kmxwwKlOKpXAx22k5RbqXRzrVBuU/73U0n+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401080; c=relaxed/simple;
	bh=FuhTB6qEHWc8MPyK18v5GEAhVDTPzYtEPyrMtVBqwtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6BHMrKfj8IdhYypXV9L1T/syC2/1kU64OPnmF9fYl2tpH66qmRz+68Z4d4FibVYQMqQDFo2XfvCTTSsu3kCYM95/E2iEErnpg2JKPHKA4YPxovtUV9HdzoZz7Z4dh4VjtcA6waDzPmTYBfUm6gK5Vdydv0077YZeIsNkJjxzN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki2FqrLN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso3916651a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731401078; x=1732005878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD4NIRuOoXRobK8tLpSsUdKa4VS1TCAcZTdPI0rPzvM=;
        b=ki2FqrLNEXkS1PUpuk0hY6eeQvKOTbbvO+VaZNE46nkUW0dK0mtjG5glIohnOUM/5x
         v6Kz6arm9ZMlTqIsVgTgGr9XmTpIA4yBZ/htzYebUsVQHoV7TLsfz+tu0P4eFCWI/RTK
         W1Hvzkw3AbkUvw+6AhwMJ/8DZsrovknopSpLdYfT5u9A89R6CX/74s8VtO8tBaZwGl8J
         wzhtA02C2I4tSUJzpUY8WorifgPk47j2IUUKma2Iewb8QhJ0JD3qXGmmXcKxcfpqPEIn
         C895vLfc1YkLSC+Qjbmts/K+pJm17W8/oeJNHMltXAV8nDuAnfBcelvFgt3YopoMzrsN
         1OQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731401078; x=1732005878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oD4NIRuOoXRobK8tLpSsUdKa4VS1TCAcZTdPI0rPzvM=;
        b=dsn9p3Ok2ozpBI3kmJNm3EOfvhc5MOO6VsMV0wkFzOk/oIkTK2E+NrVVKw1TngBYZq
         GALMLuQ0vHuYO4jufs99x+j55Gndd5CVFKWVUTTO0clyI7cw+2/+Rxqh625D/t3I1qZX
         he8wW+Vsl94NGM9hFMDkv91m9LFtOfUW2myOD45S5dyKatEFUgWA6tEynKJHNwohzOXi
         UUZe7X870HJAmgCIZ0jG1fAmjudITs2NgwiJSOL77mCUxLSowGMCobDaUqMaT4e2K/L0
         MOam0gBuWcl5TwZPdbnOVGlhOF7MZMP9o5u7tfy2qhmvYTpJfof4fQwewyCX7oZlbZeQ
         X10A==
X-Forwarded-Encrypted: i=1; AJvYcCXy3z9nyVifYPPzhaMVeuMHHHY+JUCAI5vSVfiWjNZLCQigWZUh3Ej+6DI1yV/Iyn7yHym7R1NREa0Lon8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/NXJJLfF3HdnAPEyihc2FgF0MACPhenTGkp1XhbCtFXgUhRt
	ZGiBasyDADx4zd5e9LulBS/ha5YpC6Tipq3fXGqyd5JMMtZGLgQRK+5Zd5XgDsJ7t3X0g70MEB6
	EBn5jkctSsEYumbmgTSlPmcqtNHY=
X-Google-Smtp-Source: AGHT+IGsff7MKvhLoRG2gVSj8fo7XNYdpobns2uwXFgoCm4PNAZd80nuMUrpdvdlq7MmwiENpeH/P66waFagEQjNc5w=
X-Received: by 2002:a17:90b:4d0d:b0:2e2:8bce:3d02 with SMTP id
 98e67ed59e1d1-2e9b177bacemr20975458a91.30.1731401078025; Tue, 12 Nov 2024
 00:44:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112075242.174010-1-linchengming884@gmail.com> <173140050742.5304.12768268448288985195.b4-ty@linaro.org>
In-Reply-To: <173140050742.5304.12768268448288985195.b4-ty@linaro.org>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Tue, 12 Nov 2024 16:43:48 +0800
Message-ID: <CAAyq3Sb05UjF2E86B_R_9q8Xmtjqx1TovhkPWRiHRq_O5yj4UA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] mtd: spi-nor: core: replace dummy buswidth from
 addr to data
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com, 
	richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, leoyu@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tudor,

Tudor Ambarus <tudor.ambarus@linaro.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=88=
12=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:36=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Tue, 12 Nov 2024 15:52:41 +0800, Cheng Ming Lin wrote:
> > Set the dummy buswidth to match the data buswidth.
> >
> > v2:
> > * Add fixes tag and cc to stable.
> >
> > Cheng Ming Lin (1):
> >   mtd: spi-nor: core: replace dummy buswidth from addr to data
> >
> > [...]
>
> You had some warnings which I fixed while applying:

I apologize for overlooking that, and thank you very much for your help.

> WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<ti=
tle line>")' - ie: 'Fixes: 0e30f47232ab ("mtd: spi-nor: add support for DTR=
 protocol")'
> #19:
> Fixes: 0e30f47232ab5 ("mtd: spi-nor: add support for DTR protocol")
>
> WARNING: Non-standard signature: 'Reviewd-by:' - perhaps 'Reviewed-by:'?
> #21:
> Reviewd-by: Pratyush Yadav <pratyush@kernel.org>
>
> Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
> spi-nor/next branch. Thanks!
>
> [1/1] mtd: spi-nor: core: replace dummy buswidth from addr to data
>       https://git.kernel.org/mtd/c/98d1fb94ce75
>
> Cheers,
> --
> Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks,
Cheng Ming Lin

