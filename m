Return-Path: <linux-kernel+bounces-365082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B66699DD48
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD881C2151D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA9A17335C;
	Tue, 15 Oct 2024 04:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="OQqs7p2u"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15700442F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728967960; cv=none; b=RRi+oJcyVmXOQS8MheQGtzfT6no6/Xl1hLtML4ov1R7IbW9Yq1zxbkOoJaEsa7HDxOL6wnUQu409YNZB+u5sAaZY5DqJY4U5IZMiZKjjfxE38/37E/yC3KCA17M5fcpcaUS5RP88tuFqunJktY1X8tPNiOFHOC+liGQOLJVDEnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728967960; c=relaxed/simple;
	bh=RPykLgYMdLDxPzBE22J0+SM2QnMSSPWqRX74HBp54NI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXTp5norlj2EIDaVzN3CyBnMvOL23tMHfNm1+KYPXZG0xuG7U9UA3Wq/yW6v42k0aiorVa/6FCG+OJhbBx2IP3w1UekFahjgvPxLfwnYKD/xDStUNufUypx+n/Bghx+88dGGdUetCKc5VUyF1s+fcLxaJvs1/1z4WTNJDHc02PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=OQqs7p2u; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso7485136a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1728967956; x=1729572756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tWqqKxhh0W/7ivNqGTlKJCb3/UvZfM/VJDc1l0Xb14=;
        b=OQqs7p2uTdQ/utQkYhiIbxreYb2A3+8/6w6S5NCQl4WF4vc/wOS4CCyu9T7PqLzQeB
         c/lPtxllcUb0STZr5AuZJB008Msrs+eUBlyIcyIw7Y+4H7TUnLnoUik7DnvpOjYKgL5i
         9UnNCVep+GxANE0TKG0QBtddxaEoIdr3XVdWbGJQcnfNnmFDtQ+CaC/j9331eHtsTgOA
         efYo2NiIUq0Qn6ww0sBC2f9d51dbYgMNw8roonZDugalyN+H1QqeeqS31H9yQ7jJz8dl
         l7PWYZ3H+38LZBvxnOhdKM2C7uQOYyiIO5cBsvNBKs/W+Eg57bbPdKjYrrt33XI6Ea2n
         PUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728967956; x=1729572756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tWqqKxhh0W/7ivNqGTlKJCb3/UvZfM/VJDc1l0Xb14=;
        b=P7OzMfeqzX/p5qTPNkm3M+L7zJlIRpKefHRHNf/XG6UR2pLRB47hbT2KGFY+ZZ/dhr
         sYj5vJaeAyWBBpqWMPAw+LsO+mPHxcD4jD4oDjlvCLiJSNA6d10JLaW1tAbIsaXq97nA
         8Bz/ZhZhwteoTODp70aAOy8LneBpiG3acgpVX1lGvvisCqgVD0GuPQO0bw8eIQa17XeK
         Qi1hEmtBLo59lCZxLyq0bmD+/bLMuA9xPkegXzopppo4Ckl1ZtEV7pJ46IEpn0tNc38M
         WY7rEqlmmN6kHWNwt/yeq84EzoPZLFJsaZmQ1mjNck89r0oKx2h0aR9ZzcvNA5Bvyc8X
         PGtA==
X-Forwarded-Encrypted: i=1; AJvYcCUUlcSqHgV/+1mBPtj22DvGoMJ27mkJ11JOHAkIYsHUahlVNRAQ2/kqoh8bD+3LBagXk1sEtoSqLAf/UKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhhZUfoQfo1QDc3B09vgAI34/t9mFrUJZRkMuepMvkvrydbXTk
	rjmz2uii8AYlnXwDQgx+yKEnUtEUDaTkeHKZDO62Db9IECxvGWSeNVjrPO58qoZmaYT6Q499+5i
	WBIzJ8ooFxT3yvpWKZXzQqgi5cTtfLyoR/TZFIQ==
X-Google-Smtp-Source: AGHT+IEU/y1a6FgQfI8YjfSVfdTShpUrSSTkz/b0IuV43k0+CLIh2c64950510hjkg2XerOUrGRbQTlqPjI3HimJE0Y=
X-Received: by 2002:a05:6402:5c9:b0:5c8:a0fd:63d6 with SMTP id
 4fb4d7f45d1cf-5c948d24835mr10997520a12.20.1728967956209; Mon, 14 Oct 2024
 21:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014163001.4537-1-everestkc@everestkc.com.np> <31a73bb7-47ec-496c-8a65-02e331051e0e@linuxfoundation.org>
In-Reply-To: <31a73bb7-47ec-496c-8a65-02e331051e0e@linuxfoundation.org>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Mon, 14 Oct 2024 22:52:23 -0600
Message-ID: <CAEO-vhEg_whKPkWmym99+a1Lx2kU5CcBCYrz6unKANbCbV9dHg@mail.gmail.com>
Subject: Re: [PATCH][next] Bluetooth: btintel_pcie: Remove structually deadcode
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:02=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 10/14/24 10:30, Everest K.C. wrote:
> > The switch case statement has a default branch. Thus, the return
> > statement at the end of the function can never be reached.
> > Fixing it by removing the return statement at the end of the
>
> Change "Fixing" to "Fix it"
Will fix it in V2.
> > function.
> >
> > This issue was reported by Coverity Scan.
> > https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssu=
e=3D1600709
>
> Please include the output from the scan. People can't see this report
> without logging in.
The issue is no longer visible in Coverity. Though the code is still
the same. The issue hasn't
been fixed. Should I remove the link too ?
> >
> > Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between dr=
iver and firmware")
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > ---
> >   drivers/bluetooth/btintel_pcie.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btint=
el_pcie.c
> > index e4ae8c898dfd..660496e55276 100644
> > --- a/drivers/bluetooth/btintel_pcie.c
> > +++ b/drivers/bluetooth/btintel_pcie.c
> > @@ -391,7 +391,6 @@ static inline char *btintel_pcie_alivectxt_state2st=
r(u32 alive_intr_ctxt)
> >       default:
> >               return "unknown";
> >       }
> > -     return "null";
>
> What happens when you build your patch with -Werror?
> Do you see any build errors?
I compiled the intel bluetooth module without error. Will mention that
in V2 patch too.
> >   }
> >
> >   /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
>
> thanks,
> -- Shuah

