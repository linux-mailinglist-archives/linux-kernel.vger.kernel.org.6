Return-Path: <linux-kernel+bounces-555471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CFFA5B81B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 05:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FAF16F12A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1748A1EB1AB;
	Tue, 11 Mar 2025 04:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4G1JNYe"
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6401DFE22
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741668819; cv=none; b=vGSrmrjnZXrxfTTEkLwtJawtfVU6O+mlRXuR1N2nudVGil1pD11gaXuJfbPU/Py5LcR/8mAwStw1Cvg89Z99PtIrP5DpEbHHMJQgEpVerQ2qQjUEBTa4nZ6PR0RaZ0ifYMtHcLoUkXwrmqLkhygZu9VaFmqXL+wSvSKe6jzlcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741668819; c=relaxed/simple;
	bh=F4Pn3prE+LzJRXUHDA3yWp/qWfnzalylulgHNsIxBoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdGMNgdzR0z22ZMmgb7UvSjbC6jU7O6eh3D4RcpbrDULmeFhlY/QnZzOfRHS5aFnzcxy0C2MGavxHLZl7+J8yMZWr4KR5FM1XhKo3KN5DzA8iH9czcUfUAUMG3s1QtCsZmJ5uFs2P0s46jQOY65EuPupIpePK9Zba4MulSrUybE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4G1JNYe; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e6182c6d52aso3388691276.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741668817; x=1742273617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmBsW2LQO96yaKlFJ8JYrd8fwGXH5n21hBjb5LNwr+A=;
        b=U4G1JNYe0kbHfvIf87mJijJeDwRSC3Nv7O0Qr0/aIK9nC3C5iwF0PQgXfsvJiELxQn
         qQ9KmXPgbBt6/WclE8tPa1KAB4ne79dVZ/wtuef4h/JautMib7HqaPNmXDs7WPjwQt+s
         PkpnFTbKdPdKlE9YgEdlq7gOSG+2NT/QWYOhCR4kOW8GAhsz4tvWz3alDHRFbB7SoxCE
         aLRwh+ps5Wykg6GjeoVwXcL8r+xdjQqv5kKsEUagnWdMrAPTGv+jdEd4yg7DzyyeWvOE
         LdN6iv1wwaOULw094xlZ6hP5E2HfdJDivYlGudraN8V+UEo7oE2xYOIXDuompfMW44ky
         Ychg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741668817; x=1742273617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmBsW2LQO96yaKlFJ8JYrd8fwGXH5n21hBjb5LNwr+A=;
        b=sAcPTwRvC3i13sOrpmWcitLdw9f35/rETWcALfkrFObE+oq80MLVSITPZMuRKEGihI
         hKbsmOehXPlGVtAfO3qcAbzYuoHiDs4sTp1cx4qIkzA7eAuhycECCMIuqVT+92pEP92r
         xT7EctglPzSldIVHZOGtnFCXcg47rLtouvlLjcf/uQzCNmLfCjaeKNdtzGpkcz6a5xbP
         ZrcI1xMg7mogc6hZJfCazrBCTRegQ0BL25AZ9tlkDeiUBC/Io+3idie3JfxMV5knPGtr
         OJ6f7ue6aRE9A3Wf9xEW0HLbiQ7UiqGNLtcN2hxaOGojd1667qgmoH8xa9Fn2s8Q02Zk
         9NFg==
X-Gm-Message-State: AOJu0YwrApxMJP3rORiXDTaMtD4lPPJY2AbrMgTDrEw6j5BhkV/abDpU
	zhulUvXSeHkaKnCL7eElA1fhzoRQiRjMvsGCaIIGJX/XsGZZVOJZ/7I3e6l8HOB4RRy/l1g8p9y
	zSl1t0hXcD0nvIF+qBokI7Pc4/diNtoUpdZwfSA==
X-Gm-Gg: ASbGncv+axkY5PgzRGah63jSEH3cCJVYr7JcWXanLmGV7K+2Gm/qTJe2SBJKap4nO9i
	+/AHQxRvREqY2BCqIkpxICbhoZtTLfLDipQcf+ZgkuG/QCjo4MYeltGTCeVbfMAkKW/3XyMS7vD
	iXhzDfEsOFsSxgnqSa6O3j4e+tJ13Wnl5nC+DJHleZNm8xZpQrCRUtG8sfFh6S
X-Google-Smtp-Source: AGHT+IFCSAvszIgyLNiQKSiEDrtSV7FtuUZkwCGYScHKRx84nAtmY9t2U++i5ZDIGdQMHHvcNSEUEPb8hOUiUAHHty4=
X-Received: by 2002:a05:6902:470a:b0:e63:58bb:aeee with SMTP id
 3f1490d57ef6-e63b4e4f2e9mr2719564276.0.1741668816906; Mon, 10 Mar 2025
 21:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFf+5zj=KmBG0Avqy6cq9qtpGKR3HnYNc6rK6y8B_78Ajt4RhQ@mail.gmail.com>
 <20250311003554.GN2023217@ZenIV> <CAFf+5zjGKMSCYNZvOzaCNRFKHjWe2a6TKmmKqg7Fe-TLQW07yA@mail.gmail.com>
 <20250311044231.GO2023217@ZenIV>
In-Reply-To: <20250311044231.GO2023217@ZenIV>
From: Amit <amitchoudhary0523@gmail.com>
Date: Tue, 11 Mar 2025 10:23:26 +0530
X-Gm-Features: AQ5f1JpWab85CA6bagW9eVCG1qQXCkBzLOCfOpEubpP2MegsJ3QAcdMObxHAUE0
Message-ID: <CAFf+5zjA8aXGi=6_L9T_uP_2nG9ced80KLeMXtbB1UC4y+4ijA@mail.gmail.com>
Subject: Re: Catching use-after-free easily in linux kernel.
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Mar 2025 at 10:12, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Mar 11, 2025 at 08:46:36AM +0530, Amit wrote:
> > On Tue, Mar 11, 2025, 6:05=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
> >
> > > On Mon, Mar 10, 2025 at 01:24:54PM +0530, Amit wrote:
> > > > Hi,
> > > >
> > > > We can catch use-after-free easily if we do the following:
> > > >
> > > > kfree(x);
> > > > (x) =3D NULL;
> > > >
> > > > Now, if someone uses 'x' again then the kernel will crash and we wi=
ll
> > > know where
> > > > the use-after-free is happening and then we can fix it.
> > >
> > > That assumes that no pointer is ever stored in more than one place.
> > > Which is very clearly false.
> > >
> >
> >
> > I will do some experiments and then I will reply if I find something.
> >
> > I will introduce a global macro and then change all kfree() to this mac=
ro
> > name using cscope probably.
> >
> > Then I will compile the kernel and run the new kernel and see if some c=
rash
> > is happening or not.
>
> What would that test, exactly?  And why would that be any more useful tha=
n
> adding global variables named wank and magic and replacing every kfree(p)=
 with
> ((magic =3D wank++),kfree(p))?  That also would not introduce any crashes=
...

If I don't find any kernel crashes then it's fine. But I will do the
experiment to check whether I am right or wrong. Theoretical
discussion about whether the kernel will crash or not in my experiment
won't be much useful probably.

----

