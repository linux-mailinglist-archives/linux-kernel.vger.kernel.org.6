Return-Path: <linux-kernel+bounces-417794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C229D5929
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1E21F22E43
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 05:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39B315A85B;
	Fri, 22 Nov 2024 05:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQHADYrV"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D48230987
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732254288; cv=none; b=Zc5E02OojMELNKyOaj2jGr0AhpKB1JACNyb+5Q1Sl6XPstGpWJfT83kZ0IV18dLsoJ1WrQLByGFfZYr47gdACIbPx5nsoDKwA3flsio6ZiW+TVklNiaCifmP7kAE3LJZprtavj+zngzmhaEdMd62bF/3W6+ChueWe1gCyn1tpBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732254288; c=relaxed/simple;
	bh=Gub5T2Df8Jz73HK7wvhBgYTBp/GDEpEZ06A04qe1jqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUd0uUqp2mChl92xt5YAiipwusxIZpD3QhNJgRSLNqt2gBfK9JA/q2tn9pIhTQgqPAj6zsv1Ppj5NHEwZebkvxoKNu3k+BPA3IUv8TwPWpTus09fbGMCD/d4VS0nSGBgmylGmTAAR24KOeHsURj2nVkTP5Yijz+WjI6+Ia7EVy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQHADYrV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso1223796a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732254286; x=1732859086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gub5T2Df8Jz73HK7wvhBgYTBp/GDEpEZ06A04qe1jqg=;
        b=TQHADYrV0e/uQVx7kf9WyPxvI6dNcKkCBpn9jAjzpc/vnSLMIWcbk82P1do83pSbjK
         QauiAEYGjPZ7AQmSryzI7jnZ9e+Uaa0jdCx0QQyy6AxcRJSIYJ8qbtWO4DYu+1pOYrVO
         e4S4tzLiWAq86E3M0FJhWut4xBu0uXrCXB+J6p1jr0mcJN8OF21MpE4MG/kNh/98bE4r
         jubS1PlWzwZHMMJW3mveo4sQP0aZqAoA+h9Y+DQZHNNsn+XI4QY8K5nGnoM133RHoSok
         Bf0msPZNdaXDJmRvHbNI1ZT4SfdYv7gldSMPmMzUcZQQVb93aoxzuljeYwf51zJubagO
         XyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732254286; x=1732859086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gub5T2Df8Jz73HK7wvhBgYTBp/GDEpEZ06A04qe1jqg=;
        b=U5MyPhalmznS1BuvQW6mRR+lTaV0DTdwgSz3+f5b1zOp2fL88BmPXaklttj3gSdBG1
         8fu7JAHNyQtCMgAPwDOvcvi/aTjm5E28QqtgGVEQkufH68cOihFi4sGBjAy/MqAg65qI
         zpjSw1iDsoKwy0p6JKgW70tczFwFS7/mCvZWbR5u/Nk0EOLOaSBcIM0tcsFXWyq/nF0u
         nl8JKVSobsP2AuLTdfWWZVgeyM5OMOjgqwZKG5mnZ954DhZ48jEcSJrjmeNgf6FgrWDI
         dcIc9szUC7a2pVunMofvTFhp7afZjth8Vyb1EXCn3JvPY0HkecVLgWvNnqLOi7pmMFQd
         Sc4g==
X-Forwarded-Encrypted: i=1; AJvYcCW4keXLztCANBAazFb1CbBf6ihySI6jP+Sujw0KlradNQYKBq8X/Nd/ObD/y9Tt76YhqTAq++2FGcMlPkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp6XMxQ/2ROjrWaZYGwHbg+LnfKPpay7HALFff6+cVhobSBJNj
	5WX8IZ3Zw4p/sbsvPVguaF24Zq7Xo7YH55s83Iq94OwlwNCC3AG4W4etGlBEAdpmiXQdKY04SyR
	P8OFw3yhaj/mCdhAlVosBMMC5RAU=
X-Gm-Gg: ASbGncuuCvm6Yl1Yxno5gGaoiIjM0494Jamtq1Ewn7d4urIMY+3k/pHuyqL4tqTDg2k
	JsAocxkGmaRB++630s7XrJmtuM3wAP20=
X-Google-Smtp-Source: AGHT+IEi3BM1B7tXNp8c3gLvKjDnthIxWhH9+DjzuchJxWnz7JATjUyFqjUmeNr8DreiO/n+QR7VjOlV8fejYPo8B/8=
X-Received: by 2002:a17:90b:1b49:b0:2eb:140d:f6c5 with SMTP id
 98e67ed59e1d1-2eb140dfdfcmr1588370a91.4.1732254286078; Thu, 21 Nov 2024
 21:44:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114023528.181583-1-linchengming884@gmail.com>
 <20241114023528.181583-3-linchengming884@gmail.com> <87serozv8y.fsf@bootlin.com>
In-Reply-To: <87serozv8y.fsf@bootlin.com>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Fri, 22 Nov 2024 13:42:24 +0800
Message-ID: <CAAyq3SZTiOabjw1E61nu2AX+zJgWxvgijrgamH9ESEPekZ+43w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mtd: spi-nand: macronix: Add support for read retry
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B411=E6=9C=
=8818=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:33=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On 14/11/2024 at 10:35:28 +08, Cheng Ming Lin <linchengming884@gmail.com>=
 wrote:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > Add function for supporting read retry:
>
> Add read retry support.
>
> > - Set feature on Special Read for Data Recovery register.
>
> I am sorry this sentence is unclear. Plus there is only a single '-'
> which is strange for a list.
>

Sorry about this. I'll revise it to make the change log clearer.

> >
> > The Special Read for Data Recovery operation is enabled by
> > Set Feature function.
> >
> > There are 6 modes for the user to recover the lost data.
> >
> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

