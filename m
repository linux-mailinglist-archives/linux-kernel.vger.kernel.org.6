Return-Path: <linux-kernel+bounces-550252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36507A55D2B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C143B38AC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1086BB5B;
	Fri,  7 Mar 2025 01:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndvuv/39"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D51624EA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 01:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311420; cv=none; b=pgLCrey+zNB2974Lp9zdYxF5Vwt2tepiXm/8NE72C/MQYAlrP1EL9dWPGqKN3qcaQTEu0hr7F5pJN5bf7ey4x8loVq/wlGvqaKuiVfz/FBedUpDnqLJfn4uWDEidbL83jAB93y9mgX0l7BgLaxmW1rA8acS8hIvUgOpBHgQT2dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311420; c=relaxed/simple;
	bh=hynBK5ci0mmenefSpa3rf+UPEFKEMucX8dvETFHdGtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSMupWDVzvlXUR8HZIIS5QR63SgAcmZyy8BbCMHqg6kPtqTDouGl+OQZ9OefAyqT+QTcxq0Euasux2EuETVUmb0be454LgvMqg+/X2aiBua7TdKdnNzDvfHbOzKiImWqw/hwlqeQtOS6ojFBoQtpIV/qTL4mn4lB76VC/1szoRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndvuv/39; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff80290debso168165a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 17:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741311418; x=1741916218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTriowciTheXks21K11k33c3PkgL7Rz/DhFB55dadmc=;
        b=ndvuv/39WWqVZAG8Vg1CLV4OH16/y+MAsXFUjMNzqIX63KBdwQZ7D25zIMMsZbsDFw
         mvf0AAbXh/GDl7Utov9+daEOa3iFNKjdgdcwLf4FILG1rLXFCLI03V1I1HBO+I704VgS
         dUsbFayUrO8ALR5NfpvwWH+nkwE4wgK7Ag03Gs/n74a3APZVXTLk64KOeaHLktcaJRaI
         iTFS1x1lrq79coFYPdQwiaJzPswTf63Jrrkk346Z1etFnUwRXFSkJAeEfFxL48l7oGKz
         hSRtpjs7kOtAvapPArZll5T4EMPVJNdNn+xKMghJfpTBc4vEte8SSYF3k0KpEqA+yf7F
         vhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741311418; x=1741916218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTriowciTheXks21K11k33c3PkgL7Rz/DhFB55dadmc=;
        b=BJbHMH4H1dpcjVOeIDDQmh8oeVPiLNMNpqOI7LkG69Z1SN5IEMyeWaDgfly1FR+9ov
         8fpfMSFeUuUceaEIGQM/w5uMDNm3p4Mju3eap3rIXW5I2pzLiTtaKEW/wtACkAn9iwxs
         v9tdRiJEUykX8adxT+304LYEKVHXArnnm/0TLLigwWV5NbBV8lt+uh7NVEK9Ljb3MuwD
         h+tWQDnL3mKuDBFGCtzE2ZvzmocqV7lHgOgI6qwycG6iMVsJ2lAnlDQF4+3DqopqZ+qx
         JX8jw1YvsmGidjfmV2nzxlJdIAbQk8j/WpSesYT7i6lFum6oPnwoVvO+7I+H3eIE2Hc8
         5RSw==
X-Forwarded-Encrypted: i=1; AJvYcCWR8YcCl8uHN4IdFP8I+U6db1bzGNd7e9ZdgfFMtrjb2ECwN7GTcAUSAlhv5GzyoRC+cDEdkDsARkaScTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK6qtkg30uU1cFfqsg/jcbbZ/UYTodVuBlYrI9k96tFwB7j+UP
	ezPb5asP2iqZE2ZQWstky+GM5WdViLh/NekXbvfFQCRA6cj4lAgwEY193lpbnN9no1mIaMXyQ4u
	Vd73px6EFo6uRjqtHACDXMRnEJ2I=
X-Gm-Gg: ASbGncuQFa8CaZs2EtYeEYimnR2ZXohdgW6shL2go9UMjYUa0A8AJ5OJMqISzvmvki7
	00+4J7sRTrkL+9lkzLR0IaR63KDglHEDePyajAnzdXYSmMBciLD9w+rHiK/1gC0eFnpQFm62tQ7
	QJqbJcY9H1b8XBtuCiGreWsD5xGA==
X-Google-Smtp-Source: AGHT+IFDfqoK0c45wa683mLaBwbf1LPe7kKFeArIjt249Z6gX5cNqXAvG0FCrWjvLJ9XhVoyZ28PVRZzl088uXIRi14=
X-Received: by 2002:a17:90b:4c:b0:2ff:6a5f:9b39 with SMTP id
 98e67ed59e1d1-2ff7ce844b6mr2717613a91.18.1741311418271; Thu, 06 Mar 2025
 17:36:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211063028.382169-1-linchengming884@gmail.com>
 <20250211063028.382169-2-linchengming884@gmail.com> <e5458a0e-528f-44ec-a0f0-543472ad3b85@linaro.org>
 <bb9f8a80-4662-4ab1-b9ad-6899977c3827@linaro.org> <CAAyq3SamyhtCkd47939dKWCZN3ejaDvM6EJzwizWVqhNW=27bA@mail.gmail.com>
 <d674f1bc-b596-46d5-b56d-1e2fb509c684@linaro.org>
In-Reply-To: <d674f1bc-b596-46d5-b56d-1e2fb509c684@linaro.org>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Fri, 7 Mar 2025 09:32:10 +0800
X-Gm-Features: AQ5f1Jrxq-TXvrmL_cFEaNENEQcXUM3LYse8-YyMWE0akxocxyXKUPEQwjwkMIQ
Message-ID: <CAAyq3Sb3Qt-uhb+zvUpFWhv6gqq+umAYe3nhpiCDH=7=g8u78g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: macronix: Add post_sfdp fixups for
 Quad Input Page Program
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com, 
	richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, leoyu@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tudor,

Tudor Ambarus <tudor.ambarus@linaro.org> =E6=96=BC 2025=E5=B9=B43=E6=9C=886=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:42=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 3/6/25 11:39 AM, Cheng Ming Lin wrote:
> > Hi Tudor,
> >
> > Tudor Ambarus <tudor.ambarus@linaro.org> =E6=96=BC 2025=E5=B9=B43=E6=9C=
=886=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:01=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >>
> >>
> >>
> >> On 2/11/25 7:20 AM, Tudor Ambarus wrote:
> >>> On 2/11/25 6:30 AM, Cheng Ming Lin wrote:
> >>>>              .fixup_flags =3D SPI_NOR_4B_OPCODES,
> >>>> +            .fixups =3D &macronix_qpp4b_fixups,
> >>> For your next patch that'll drop the redundant flash info fields, you
> >>> can drop SPI_NOR_4B_OPCODES as well if these flashes define the 4bait
> >>> sfdp table.
> >>
> >> Any plan in doing this, please?
> >
> > Sorry for the late reply.
> >
> > This matter is currently in progress. Since collecting all the chips
> > will take some more time, the project has been delayed. Once I
> > have all the chips, I will start the verification process immediately.
> > Thanks for the reminder.
> >
>
> Thanks, Cheng. Switching them one by one is fine too.

Got it, no problem. I will start the verification with the
chips I have on hand.

Thanks,
Cheng Ming Lin

