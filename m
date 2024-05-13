Return-Path: <linux-kernel+bounces-177927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D418C4653
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798E61F24D56
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7247D2263A;
	Mon, 13 May 2024 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlIQJb11"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C548224CC
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622034; cv=none; b=pAVT9+1aVuu2I17i7sbowhpcKBZzvWyGlCYUXxWDPH274s2H45USAmO+6O4EG9aKhNfJKZcr4rn25w/7neKlkuKXkri2vZ5t1Ih9wrEH/cCkkvZKl4eirAteKDzafoV22aW9iKiHwlqBIFv1mO5Ao4tJrs92CkOGVI77Ol1Gk+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622034; c=relaxed/simple;
	bh=t5SpwHTjyFiHLCIZdQyU0B+XcxTvQrO08SXfGI600DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDoPZqjXC1t8nE4ITr3ydVvJvnqiEymxW1/JghcJ060q7/aHo/a6L6x83bEojCznGUVxvDEJH97QSnebc7SYTFbHEAG99KjjuIqvb/N1YRAriynoyH4bBmWGLpG7BUOeAzRztbqRs2EQccGHPvd2ol5mG/2TVPUiS04dQy72zIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlIQJb11; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51fb14816f6so5968631e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715622031; x=1716226831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24+tcaOUdABW+nIu4gSBjGBZOzZFGwP/RR0C3nr9PDs=;
        b=KlIQJb11EM++tyEgfg0AXADEnaboBBKjf7XogWJXpAMZscfOXpGdq50BvIvGbO+Fjx
         FTqGVUCv0MwlNgHIC4RXWx4mnFMKc6uy2nP4mnVGzfCkXgeJnDiGcaGQ8RYVQ5DJ/j+D
         mSAMuaEXLZF5zuzQjxWr7qFTktJBFgIW0gtFgF4HRE26NfhUqraFedNJwZGc+lmLy94Q
         fpjkYbAAW7GsdED0D6UCzsOv2tCa5E9gxe7U1ItIAVYAqfxbUVwE7aop6PoSV3ywjehK
         exCCmaghHFCPwocJQEjYPtKSgPSGtj1+IHs1YrlS91OrqEyszrsxs00O8wQRMEtrpOW0
         /ygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715622031; x=1716226831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24+tcaOUdABW+nIu4gSBjGBZOzZFGwP/RR0C3nr9PDs=;
        b=Cwq5/+e930rqDn6s3M6O1tx1Tltj+BIrBWXSpbSSVaucvGNld0Z7ZhvSE1ZWmgu+TE
         3gT4bhXkduP7aCs21iYaASADF3eL75QCRNgeac4j/0jj9wqGIaGUv8QUQroIISCsXGD7
         L7AF2Oj8c9VyrCn0+zXjGm9D9SKlp838O8KZmLz38FidB8HVwz8mHLyDnDUG62+aG7rg
         QsBIqPK9/IaYbas3CNRg+tcIkt8iqVSD6LMG59ivaHVwr+HbsZeI7g+61I6etzRvO/vA
         2FI47p3Vrsrx51D44ms7/bd3ysdI1vn4gGsSYQnsTNeEkKJv30NcGex7xU4ao7FCQ/5N
         iCNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwEEgtu6wBywedknO0STvIEZd2qJWiAaulxaVtZSitcvnc4tuDF7CFumvF5WxHCC6p6tA+H5R7Bx7gz281wYxQbTlHu1G21oauvvu3
X-Gm-Message-State: AOJu0YzNvViVti03pZC9hcBv9F06IL+/Tt2xg4xm1k90ziLntvAbw3j2
	IqFS1qNiOAKghO8Jku4R2AIAXnmtOR7qCatAtyL1bufkD36NfOsq/b32kfplcsF2lL6WVzL5A3+
	wffNgNDxlIA8qfiqK14jojKg2yeo=
X-Google-Smtp-Source: AGHT+IHC0KZ5j0ymUWuKV5sJjg+pdAqwWkahWyvfPoDuWJyTmcZeUSOgpVUC0Abl/XwLPL4Au4KaiAJXgT5PjEl4TFY=
X-Received: by 2002:a05:6512:52a:b0:51f:13e8:3729 with SMTP id
 2adb3069b0e04-5220fc78605mr6304140e87.20.1715622031102; Mon, 13 May 2024
 10:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHx5RXBfazB62qpbGGK3_YjwCFbiJbEXrgo88V6qHFdTW1CdRQ@mail.gmail.com>
 <338daebd-b4af-4a0c-951a-ad7f86dc4646@gmail.com> <CAHx5RXAOKBGXRgC8pqEyY3MZGXxj0-vrwnqg_WZqKreYp18dAg@mail.gmail.com>
 <7efffaa0-6330-4b01-b3d2-63eb063cbbb0@gmail.com> <CAHx5RXD8qFmbEytrPcd40Pj0VRo7uOvZjucrMj6Xxqw73YyS1Q@mail.gmail.com>
 <212a9464-d52b-4730-95b9-5a0aebd38c91@gmail.com> <CAHx5RXCWW5M-eW5v65bAkQWZemsU2NTvDv3jA9_XKz=+YP56Qg@mail.gmail.com>
 <688e54ec-3b29-4e3b-a2c3-f2c83b9c97b7@lunn.ch>
In-Reply-To: <688e54ec-3b29-4e3b-a2c3-f2c83b9c97b7@lunn.ch>
From: Stephen Langstaff <stephenlangstaff1@gmail.com>
Date: Mon, 13 May 2024 18:40:19 +0100
Message-ID: <CAHx5RXBFdzsgKXR94gdZd2b=uz8PJDg4OjLPJxKtsdhcjJq3Qw@mail.gmail.com>
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, 
	"OlteanV@gmail.com" <OlteanV@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 5:54=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> As Florian pointed out, dsa_loop_bdinfo.o should be built into your
> kernel. When you insmod dsa_loop.ko, it should match the data in
> dsa_loop_bdinfo to the dsa_loop driver an instantiate an instance of
> it. Do you see that happening?

Well, if I fiddle with the Makefiles to get dsa_loop_bdinfo built as a
module (as opposed to not building at all) then I see the following
behaviour:

root@machine:~/dsa_test# ls
dsa_loop.ko  dsa_loop_bdinfo.ko
root@machine:~/dsa_test# modprobe dsa_core
root@machine:~/dsa_test# insmod dsa_loop_bdinfo.ko
root@machine:~/dsa_test# insmod dsa_loop.ko
root@machine:~/dsa_test# lsmod
Module                  Size  Used by
dsa_loop               16384  0
dsa_loop_bdinfo        16384  0
dsa_core              118784  1 dsa_loop
..

..and I see no new interfaces reported by ifconfig -a
[just the existing eth0, eth1 and lo0 interfaces]

I will revert my changes to the Makefiles and confirm that
dsa_loop_bdinfo.o does not get built into the kernel - that's an
overnight build for me so bye for now!

