Return-Path: <linux-kernel+bounces-383454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085869B1BED
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 04:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98402822A3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 03:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D6E17C8B;
	Sun, 27 Oct 2024 03:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEOZqZcf"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1789F2F30
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 03:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729999663; cv=none; b=LDSULMx6dytQOSPMG7iCgs1Gh9TL2NNmS16KFVgeZZdFuZHDaiqK5T8eZx5ujbRlrOCXN32QDZZJ5bU+Zekj1Jkpctc0s19hbO6/GnSs7WAtOymwV3Bwi2IMamGIJnLw29L8CxvFAQZUZ2J8G5hc2VUHugwolN9PRDxYhXL85QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729999663; c=relaxed/simple;
	bh=Qg8+zPkCaq/N8QN9qMyXVxuP33OTIrgsDqQXpTBzMrc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WR+zuNNWV3OqtzLGn84q4+QNYFIQ9kMGuVfaG/L3K7O0FUQMyA7GXtU7TsizzUpiR4ZLreBGvbmSxD6ugEX3yRzfdKqVVl9UrIPzpsFzyXZ2W5XvM+zSZly7ZUdh1lyDIae7qqpMKpRQRN+GvdwExrgYixAT7pot/0sy7+6gWkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEOZqZcf; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2b9480617so2555341a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 20:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729999661; x=1730604461; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qg8+zPkCaq/N8QN9qMyXVxuP33OTIrgsDqQXpTBzMrc=;
        b=hEOZqZcfiOUTjHQGuzz0WvGk7JgU3k9D0+6zmCH9wQUzhJ/1LT5EDs/crae/2Cil5y
         3Uuuk+6BG7SC77BMKRfLnjsidEQB/IdWLz52piqRSNiTNo4nAb4qCTLcp5maefuOjrXz
         FcPVZPCpBXnaLEGsppYYRU5hjNekTS4IvXuUAxm8ethguY396IbJ9hTQx0kHOHNmZpmP
         lQ9kfTxRtvyEc8McTQvbBV3/rXXKICD/PjgcMfuWoY7ga5EWiLCzVvi/EczdYY7HR55p
         f2dh63NKyGxG8UjQVXpgBLp71XTMMcAkS9QjEO/lqAtAjsxRS+US3ZSX1ZvXFMCQ4JM3
         pMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729999661; x=1730604461;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qg8+zPkCaq/N8QN9qMyXVxuP33OTIrgsDqQXpTBzMrc=;
        b=SRo3IV1g+0t+aqy63t3m3D3nhtWRW4dyIabFxEs7o7o3LskfEQrQzQJlwUiLEsMoM0
         90CMB2YvrY63b3jsH5q/ycNQmxVLcJxY8H6S42EOBWiQmXHLs+CypoHYcRJ7FpO8eL6O
         RvtZRu25QlOPiQC+x5Isb8V0V/VC0l/H/DqlGOv7/wX0bws6erFoEgMIsZtwLzZAwrDY
         VdnmIl6IQHvek4I0BiMeNTtbiGRyjbHUHVBcKZ6Pr+pQMBCCRVtU8MOipYBZ1p2BakoQ
         v1WHZRBU8QAUAws/wpK5GnGmMgLip1Uz3V+AU5FigAfz1QPhKctFm6RG8RiYebew75BV
         QLvA==
X-Gm-Message-State: AOJu0YwLZ4SH1V1gJzevCrdPZTML8OTTZWAafQLNZ5R48xXBxPwEDDfQ
	UcZffdTdHAVcIPcWaa4+7Z4ZyTMbwXJfBh5RxoPHGpwMcea8Qi166oZuSA==
X-Google-Smtp-Source: AGHT+IHY5lO6lhNn5FlPXPQVPMyct/F2dblaEOcr362/rm3JviqjNzoSH0wrNCrHhn5YHEC/G0TjgA==
X-Received: by 2002:a17:90b:1041:b0:2e2:cf6d:33fd with SMTP id 98e67ed59e1d1-2e8f11a9721mr5751467a91.31.1729999661235;
        Sat, 26 Oct 2024 20:27:41 -0700 (PDT)
Received: from smtpclient.apple (c-76-132-43-215.hsd1.ca.comcast.net. [76.132.43.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3572d5asm4217697a91.17.2024.10.26.20.27.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Oct 2024 20:27:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.10\))
Subject: Re: Stop spreading propaganda
From: Matthew Lindner <mattlindn@gmail.com>
In-Reply-To: <CALtW_ahL2fWAy3haCe+fnNcPHzq+4w7YXt2vaQVzmCe6Uis+Rg@mail.gmail.com>
Date: Sat, 26 Oct 2024 20:27:39 -0700
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DC4A33E-8163-4045-8945-3B8DAC2E33D5@gmail.com>
References: <0522F9B1-376D-4956-874E-A0D919E0EE81@gmail.com>
 <CALtW_ahL2fWAy3haCe+fnNcPHzq+4w7YXt2vaQVzmCe6Uis+Rg@mail.gmail.com>
To: =?utf-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.10)



> On Oct 26, 2024, at 8:21 PM, Dragan Milivojevi=C4=87 =
<d.milivojevic@gmail.com> wrote:
>=20
> On Fri, 25 Oct 2024 at 09:58, Matthew Lindner <mattlindn@gmail.com> =
wrote:
>>> BTW can I be racist towards Germans and Croats since their ancestors =
exterminated my kin in their death camps?
>>=20
>> Russia is exterminating Ukrainians TODAY. Fuck off.
>=20
> They are exterminating Ukrainian soldiers but that is beside the =
point.
>=20
> The issue here is: are you allowed to be a racist, as Linus is towards =
Russians,
> because you hold historical grievances. Ukraine has nothing to do with =
it.

No they are killing Ukrainian citizens, en masse. The issue here has =
nothing to do with racism, except maybe your own toward both the Finnish =
and the Ukrainians. Linus is rightfully pissed off at Russia for their =
_uninterrupted_ behavior from pre-Soviet Union through the Soviet period =
all the way into the modern day. Russia has never learned. Perhaps they =
need to lose a major war and get balkanized themselves before they =
finally learn that lesson.=

