Return-Path: <linux-kernel+bounces-564197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D402A6501B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1575618956B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01623230995;
	Mon, 17 Mar 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzlXMkOa"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BAC29D19;
	Mon, 17 Mar 2025 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216421; cv=none; b=gW99roOH3JCZ71udVCKz8P1YeHmB9QtxyWoyZh+6XtA3o7ab4HKKe8v656Icyi5kjAAN4mTwjgi9bazOaDbysctMESA0onBZtALIjXHzHUMBe3NHryQftdqVyHPgLZi4P1MwRiogaXPQiAL+CG+iLygMwqt+ElZPcsQo4V2EhMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216421; c=relaxed/simple;
	bh=bIubJEwAWGYDMO/DSvL87cdFtXZDcF5zY0t0lC/0u/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z40j/mlUg4b5BkTdSgBK1PA//QmNEyNko7NRXX1i4Ts1NCCCZS+uyw7V90pDQjPakwVcBfvOUxa9/NTg57jNrz+V2fWiwiHCix45qvAuTOMtQYI4ajGpG5+huI4paFXix7SjzS7ySFDMStZlIKm4xRPSn0GIHeQEPaygX+ur2iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzlXMkOa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac298c8fa50so824713566b.1;
        Mon, 17 Mar 2025 06:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742216418; x=1742821218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIubJEwAWGYDMO/DSvL87cdFtXZDcF5zY0t0lC/0u/o=;
        b=QzlXMkOaI+YA/S0xSOYZhTHKWxRnA75AvreDQHCPQblBpyRBEWCoNmmDku/uz1OFKu
         3bom/tf6aDjeJBqb7M6/8owZnaoGfJdr96oktkpGE6Bq3kFr0kIvDB3IpEFHNMn47bQj
         +9lvE9ZnxiS92WKhiPVROxlc4ijipHZJZJT/+QJ6hB94Oc1asD/BvFAtIP8Vw+16iVhE
         C6NotuI+Fh2EfP+Rf0LygmzPBr5FxGBehsT+irBs2u7ysvp2eeuHu6OHUv7+dJROKo+r
         9bPPRmAq8mKZF/4cZTWfFpvaXF77jO7Xoqw/LLPPhwHZxNqt3YbTvLf0yzhxqROuchIm
         eLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742216418; x=1742821218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIubJEwAWGYDMO/DSvL87cdFtXZDcF5zY0t0lC/0u/o=;
        b=prTuYi4xJvH3pNMemzMhZaKL+h9ooFTPs2VxHBq7+jIurT5v0Iz4Vll9q+v+830dme
         mvz8718/rVvkYfciWaZL9mAWdOfeBFcqrgMuDlRdAuX/aBMgx9z3OcRd+IZtI+tfQrcN
         XMW6MB9xjh7LPUTHFMAR07wTyrmlLX4qgAyUtSKTQwnvh51GOkx+dKXr6xhC7riXlfw2
         AXMbfy5hj/eT/lFXdYgEkqKA6wfLddmRlCQdJz2cVenA+F4ChabDHFs1Ca0ECrS7OaLr
         9BFJxwZXqNnl5dnLodRtm+necE4GCgAa3rciMYflJjH3Uphw4h6xGV57LyZ+x4BEZVti
         nEPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/os2fJ7WAp4nnoNtR3hmJFPsyBGX0v4e2Eg2HQHk4FKiiVzr+5lV0CJJqHrHQ91Ifo2UyofTmJEmuFmtW@vger.kernel.org, AJvYcCXQBl2eUaeGXORX276y9E/u7mt44vCn6cxIA0QunO0pGGZy4SATJ+so1gPCsoO2y1y9kaUXXgVSzng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+CuWtLMgCXNp3F9mh9yf8D7G96zvcjJr5kWr/Eg2B3Gv8q2Q
	O7QMwyQQqlzYpgj6Qvzsd6IaaSzmy7Tubxc6IFHBM/0TUs+OhtPbcfpEwJaj4amRurIuZwx3dX8
	bxLctlJRiXrzeXSi5ElphvBaLY8k=
X-Gm-Gg: ASbGncsv6qfRR/aCJTgwCRcxVendjY3smP+nZRNJbAddIh4vRQrxKNz5w1f2WFS36o0
	6KHWmA8VZwTv8OtdMfwlsyu9l31IkL3ffczBHd9wjPqphPLmPJ3WDO9CScNan5PnQbZ5E8es6/6
	SimVRQkrs7/+rLO60YKhlFb6+canJHiSJ2DQ3O
X-Google-Smtp-Source: AGHT+IEUR1Y37l1FwAWvThJlHPQmxIymqVtj2Uln20rLTns8WdNrirlScgCLZlwk1y7sZsv2fziokMs0lERkuQLbL9c=
X-Received: by 2002:a17:906:7308:b0:ac2:e059:dc03 with SMTP id
 a640c23a62f3a-ac3303f75d1mr1235173766b.38.1742216417651; Mon, 17 Mar 2025
 06:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f11afa64-1629-4005-8cb4-723d9b6ce6cb@hust.edu.cn>
 <20250317103147313V7IEKc3g37STl_idkF_ZB@zte.com.cn> <CAD-N9QXEam8v6amrfswCDFfmEkb6npDLxHRaT2dYAVEV0T4i8Q@mail.gmail.com>
In-Reply-To: <CAD-N9QXEam8v6amrfswCDFfmEkb6npDLxHRaT2dYAVEV0T4i8Q@mail.gmail.com>
From: Alex Shi <seakeel@gmail.com>
Date: Mon, 17 Mar 2025 20:59:41 +0800
X-Gm-Features: AQ5f1Jr3gw9oMbv5_hTh0-Z8hTWCsezwnxtbPy9op3MvI5szk_NRovfaYL0ANHg
Message-ID: <CAJy-AmnA8tSR7QmMjQEWHWHWX=rni79T-MY5SA-4iCd3cnh=gA@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: fix spelling mistake
To: Dongliang Mu <mudongliangabcd@gmail.com>
Cc: jiang.peng9@zte.com.cn, dzm91@hust.edu.cn, alexs@kernel.org, 
	corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I should given a bit more time for review next time. :/

Anyway thank for all of you!


Dongliang Mu <mudongliangabcd@gmail.com> =E4=BA=8E2025=E5=B9=B43=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=B8=80 10:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Mar 17, 2025 at 10:32=E2=80=AFAM <jiang.peng9@zte.com.cn> wrote:
> >
> > > One suggestion: the original English(Documentation/mm/balance.rst)
> > > version also has this typo. Submit a v2 patch to fix both?
> >
> > Documentation/mm/balance.rst was already modified by Suchit 4 days ago.=
 Therefore, it might not contain the typo anymore.
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git=
/commit/Documentation/mm/balance.rst?id=3Df5d10c46872ca9a6d716854354c11f2f3=
2fce0e8
>
> LGTM. And your patch is merged into Alex's tree. Congrats!
>
> Dongliang Mu
>
> >

