Return-Path: <linux-kernel+bounces-510840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BB0A322B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA533A6B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD87D205E15;
	Wed, 12 Feb 2025 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zOD+Ake8"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82701E282D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353643; cv=none; b=kjMlp1zqfwfE+eooXcvHU5Gh4Zev5xObQ1NP43YNvSctxhCqE0E1++kdlUS6n1VW1H4mTVNmZuTRSx9Wdqe6Rv8kTGFPpi3/ra3blU437x5YnTCI03IFnyCZY3H0Bg0A3Di6Q+7Pxy515uaIspobEf62hDJDKmJbh45VMC2c4t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353643; c=relaxed/simple;
	bh=TKqcICL6TXKPxSRegpy9J7XyX60nER860Jd1kslHKlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyomYi9fyhLoaOHvbeY/i/Zaabd30OuE/RMFd8S8Rs6M109tUtVqIDzqeCQ9lx6Zm6DCt+fQme5249zxVUz99qneTP0t6QA6ZVjOH4niS/bGGMUpFLtycIlxEfq3kPzML/8+PExQD+y+W/7S9+GqlpkGlPnZRRx6jBM2X825iZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zOD+Ake8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so996959966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739353640; x=1739958440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKqcICL6TXKPxSRegpy9J7XyX60nER860Jd1kslHKlk=;
        b=zOD+Ake8DyXjX6p5UpYt0dkTWSVP3hII4Pb9TTAmi7P/ajGoE4D/QRXJGStq9zuwAK
         HpJkdDOGnMbcMTGhjKbkKkAIhUq8e4qYeYJiE1u5IE2xT3HqRlJopjmz+dZZ4fjJO9LH
         bPHYWpCDdOAM/tjO0y+YCTAVi22GmUBBtPN7+oS4WzxmAckeGO8ph9yfQLE+VWbAhw7a
         2LTnj7H4ZimyzY+zbL7Pto4STZt2bMxo7JDT2gO8hMDz+owHV2GymQqjmEZfe2Wz88gC
         qd9Kel9Izes7JmuxIXoUAg07SgUvo3JQo7OIHIi+XnkNPnEybnNB3FZ10DLMUU3hPIsZ
         xm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739353640; x=1739958440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKqcICL6TXKPxSRegpy9J7XyX60nER860Jd1kslHKlk=;
        b=HWWNwNxJFVrOhYXl+lrlJFaoU738cfDxtweb6NSWfXuaSLreJ2prNe5BQfME0kyaip
         +Os1elcam0cgaH1od0EwH6rhfGobJUSCRKmP0+to8vPlwLCfHrm9qXuaugZ50iR+uWFk
         MOCfwUmkrCedcCk1FJXzZVvqXFauRN9ByQ+OoMRErUZ0cceVo5lryoOpBq7u+dZanRRS
         e3ErbGRkqXaMRGlf/UtgYkiNXnJ4X8g1w1URupWf1ex20KrS8PNdTy5tolbLiAkbcewC
         igWTErF5jnA59vn5POV0vZBo405V2wMXmJ1BMhjllzEMrEdlKELB865Xxu7DkXQLB8ta
         IEWw==
X-Forwarded-Encrypted: i=1; AJvYcCXz3vA/azxSSXU2s7kWBWxcT8Yha1hsSmMC/inQ3z/pTEcqfp1S1U14KkGtSpOpyWRd7JOMKOT6zWm+W+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/C/bFtVUWzuzcTOrlAQZ9mEQ+QN9sILXuZrFv5yBTgGewSNrZ
	SNxKd90dU5BYBTlnRzfQwf6RVna+oRo5ecNXSB/76nAMAk0K+3qm/mjIKmHnaNuLBQImkdiIght
	2BTrmwYk2k/MYB1UOUMMB3s5WVClzaY7PBc6s
X-Gm-Gg: ASbGncu6Qh1/uKBlFWJrgDQMZnSU1j0n4S//1fq181PoR9ind0AZuURYjlhDklQ9++0
	AQJQIIYBWAWCyvOyjg7a9WdqSEo7mtza4tfro+tBnJCsagQnvpX1UHZ6EPYcZ7U4bAo6ht6d5it
	N3sTELb0nnXEcYn5dx55wQkWk/IE09JQ==
X-Google-Smtp-Source: AGHT+IGQtYtV8hB9z4cqfu+GD6xWt9yKHzH3Tmh6TBoqYNAt+cogJqa1226aKLwvMy8OQDTzT4ej9do/nT4u8m18J2A=
X-Received: by 2002:a17:907:3f8d:b0:ab7:dc1d:7d7d with SMTP id
 a640c23a62f3a-ab7f33c578dmr199546266b.25.1739353639819; Wed, 12 Feb 2025
 01:47:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SY8P300MB04210D3E18CFEA27AE9E9338A1FC2@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY8P300MB04210D3E18CFEA27AE9E9338A1FC2@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Feb 2025 10:47:08 +0100
X-Gm-Features: AWEUYZmVcw8L3xAI6H_huoGpEXCmHBOAY8OxIyVRj6KAvbkKDGsIbSCp832MFn8
Message-ID: <CANn89iKxw4=29p_Ys3H0=mDQFOfZYbqxaTuLsRYK2X2tJCuwHQ@mail.gmail.com>
Subject: Re: BUG: corrupted list in neigh_destroy [with reproducer]
To: YAN KANG <kangyan91@outlook.com>
Cc: Joel Granados <joel.granados@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	"j.granados@samsung.com" <j.granados@samsung.com>, "linux@weissschuh.net" <linux@weissschuh.net>, 
	"judyhsiao@chromium.org" <judyhsiao@chromium.org>, "James.Z.Li@dell.com" <James.Z.Li@dell.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 10:18=E2=80=AFAM YAN KANG <kangyan91@outlook.com> w=
rote:
>
> Hi:
>
> I found a kernel bug titiled "BUG: corrupted list in neigh_destroy " whil=
e using modified syzkaller fuzzing tool. I Itested it on the latest Linux u=
pstream version (6.13.0-rc7), and it was able to be triggered. I found earl=
y report has no repro. I have a reproducer that can stable trigger this bug=
 .
>
> early report: https://lore.kernel.org/netdev/20241007202240.bsqczev75yzdg=
n3g@joelS2.panther.com/
>
> The bug info is:
>
> kernel revision: v6.13-rc7
> OOPS message: BUG: corrupted list in neigh_destroy
> reproducer:YES
> subsystem: NETWORKING

FYI, there are already many public reports using bcachefs to trigger
'bugs' in networking or other layers.

Do not send other reports, or make sure your repro is _only_ using
networking stuff.

