Return-Path: <linux-kernel+bounces-532872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5D5A4533E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42093A74C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FEA21CC67;
	Wed, 26 Feb 2025 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmeAmpTM"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26E21CA1C;
	Wed, 26 Feb 2025 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537787; cv=none; b=b6IVoHB51PgMZ6Lp5Z/hLFWlNUWPCHRa9y2DWIvDcz0DF1Q/oXDgj4YH0np0OXjSDQZInIEF0xuXAZ3bLjWnH9izWhu9jKnD/yqThkKhxDu7ZVzYQtBBS//kjxuoIynG9YzOrptgni1nGwOKRW4qr1U1WZDJn97Sn1Uu8YFwvSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537787; c=relaxed/simple;
	bh=toH3LLJ4yEUPEFJJkeDUNtt+w5hsIt5RNXu0wUSkCEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSCGyPBn0+8RiJequW8y5j7bvK4gcLGPGxluGB3yCor3JLYPavTzdtNGpDGGwMHaPME/0Ppg70U9uOu1KGykU8fYFha3QcK7iEzS9UX+Q4bq6CkdDVoqerzsMqPRRJ0aevqUmcdkEw2YVehWhj7X9YsqXHwzwh/nGcOCovSoqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmeAmpTM; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4be66ac7685so1895313137.2;
        Tue, 25 Feb 2025 18:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740537785; x=1741142585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toH3LLJ4yEUPEFJJkeDUNtt+w5hsIt5RNXu0wUSkCEg=;
        b=BmeAmpTMbD4wyQnj3LnPHijGiewuS4PZ5GK0Wo1v3BBZzjrsRQ6+pz6NB2Ym1hGWuy
         AhCluRPDk9/oR7P903ScMy3LAa6Lo0yLXT9VpqCxoK+k4adIh+r3dj4uZIDD+I+r9K8B
         1OdQMcxSMgRYS/W4lw2rTl3tprg9MCvOXnuHQwjw4uqYPDKvvNoANj8WEYp7A0sAUyZ9
         ihXek8wmnS83zb2pjWFVEWq23dvCodnvFknDankTukLyhB6d9u+dSd3DzD5dVVgtF4sZ
         YRb81rhCupmyBOwhS8PeqEeKPWMWoz3xFY3PD3eyq3OpnHs5lMtzB1EMRWK3/v6Sr37e
         p0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740537785; x=1741142585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toH3LLJ4yEUPEFJJkeDUNtt+w5hsIt5RNXu0wUSkCEg=;
        b=U3vtpcw/GgSdTx1PRAwMQl+Fp4rUKIIgjxCB6ismd1fi45RVJR+WdxiFwbc5koZ7+K
         4fSlTgt5EomrOBjwIYLGGAUgqx1V0p9CC2ElpNDUN0gwVCqLcVGovbsV27oJnSyM6tDc
         DxIfD9+tQcJyT5XnSfgwlCKJ8zUIvoXI5JP2X1NeM4sqccvdFoMLLvQuV152LQUoQbAX
         XeIAmlus187QGjNRKpcIVWLI4MiAhicwWN+2LQ4E4FhwZaa+YKZrH/zzQB7dROUIPPIc
         H+yHdx/zmZ+85kB5IEIrm7grElUkzVovn2N/jWtzTw72TLpguuj1czoW9PFFdx+/3TtF
         oWgg==
X-Forwarded-Encrypted: i=1; AJvYcCUr3zwb2Usd3Y/iMu9W86KkqQOZ0qWrHGDkKNKmNXiDj/ukCKBEUSCVhKU+fb91LdN8AfqUGSSTc92cu07JLiM=@vger.kernel.org, AJvYcCW23c+pAJNI1lME+ItgDAobI5/CmZcFAowA5kzrX/vFmcIhcGhSioc5d/sv+6BH2PSrzLdz3DoEnVQP2Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1fnJft203mv4r5UBgwSfpPqliAXWVwdAFsKrC6W6NgTQzNah
	v68z+RyVTSwKtkn/eIRoMLWwKofcp6nkvtMsw8tW1U1uplafLbi35sSAs83S7tWJcqGuvfw2ojI
	yr8MD94O1GLH5EvLYlssYeu9SjzM=
X-Gm-Gg: ASbGnct43+Y1wx2fZLnEjH40YSMXaAH+c9miCeWoLWi+zOvM4DsxGbRWrLABm3f3xXm
	rBOndMp/gStO0iO9cg0Q4/s0eAm9m7MMpSdNIcEjBCRZX1cxp3+ZszgW9S3rpqnmIKFRwLJBqs2
	oFTxvaEhIV6hfqDbhORXtsrUSN83CWRAfxJ+5pfnJd
X-Google-Smtp-Source: AGHT+IFyTwJlrcVaI9Xt7UsNlvVNkw+pfbUmTO93JXE/w2WRLS6A9yWh/tpYZMvkzO//S3frbcvZZAjWp8KTSUoz2Yg=
X-Received: by 2002:a05:6102:304a:b0:4bb:edc9:f94b with SMTP id
 ada2fe7eead31-4c00acf5903mr3329725137.5.1740537785120; Tue, 25 Feb 2025
 18:43:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025021954-flaccid-pucker-f7d9@gregkh> <20250221051909.37478-1-felipe.contreras@gmail.com>
 <Z7gQ3kSeCf7gY1i9@Mac.home> <CAMP44s1Ai5qMU4yV+Rwz4cY869ZA=cxBcTf2wuaUY1oyLKUNCg@mail.gmail.com>
 <Z7zYdEM5TkT2LNN1@boqun-archlinux>
In-Reply-To: <Z7zYdEM5TkT2LNN1@boqun-archlinux>
From: Felipe Contreras <felipe.contreras@gmail.com>
Date: Tue, 25 Feb 2025 20:42:53 -0600
X-Gm-Features: AQ5f1JpIvNFnhj4Gl3DBpIQBv48BIC95sgeBSdxDcuyCbpdR3DNiyGlnB3PQEpM
Message-ID: <CAMP44s3W1XUBma0AvTd5qeNaqZoScNd97m_aQUK=GqYYeMs-ag@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, airlied@gmail.com, hch@infradead.org, 
	hpa@zytor.com, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 2:37=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Thu, Feb 20, 2025 at 11:59:10PM -0600, Felipe Contreras wrote:
> > Boqun Feng wrote:
> > >
> > > On Thu, Feb 20, 2025 at 11:19:09PM -0600, Felipe Contreras wrote:
> > > > Greg KH wrote:
> > > > > But for new code / drivers, writing them in rust where these type=
s of
> > > > > bugs just can't happen (or happen much much less) is a win for al=
l of
> > > > > us, why wouldn't we do this?
> > > >
> > > > *If* they can be written in Rust in the first place. You are skippi=
ng that
> > > > very important precondition.
> > >
> > > Hmm.. there are multiple old/new drivers (not a complete list) alread=
y
> > > in Rust:
> >
> > That is a black swan fallacy. Just because you've seen 4 white swans
> > that doesn't mean all swans are white.
> >
> > > , so is there still a question that drivers can be written in Rust?
> >
> > I didn't say no driver can be written Rust, I questioned whether *all*
> > drivers can be written in Rust.
> >
>
> Huh? Your previous reply is:
>
> "*If* they can be written in Rust in the first place. You are skipping
> that very important precondition."
>
> how does that imply you questioned whether *all* drivers can be written
> in Rust.
>
> Care to explain your logic?

People should really stop thinking in black-and-white terms.

If I say I'm not convinced the coin landed heads does that mean I'm
convinced the coin landed tails? No. If I say I'm not convinced god
exists does that mean I'm convinced god doesn't exist? No.

Being skeptical of a claim is not the same thing as believing it's false.

One can hope all drivers can be written in Rust while at the same time
being skeptical that that is necessarily the case.

--=20
Felipe Contreras

