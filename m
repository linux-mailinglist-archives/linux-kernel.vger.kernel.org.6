Return-Path: <linux-kernel+bounces-577442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7796A71D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74AB2189D954
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02A5215F41;
	Wed, 26 Mar 2025 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qii2k0XZ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E262045B0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009944; cv=none; b=Nm+xeXaWv/0BT5UnsKUftg07XLFgl9OJM0/qMu2X/UR0qs5vfN1TyTRzu41kzU93LgryJqmDtZ/pnsEDf6OOnZUiiOR3tOWnq8DVnY7OnAoakFzFrKbltLr15Sk6AfoidHi0YshQZJgvkBVRtkOjGw3rdlxn4J3aTwzfkAqKDN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009944; c=relaxed/simple;
	bh=4aYu09xFX+L+1mcVNwZ+hreyYa0ujf5ZVNCAAM7dq2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhyjMPv3nMshUr7EeewJVVu2G3hmESSbjJx3Z//ewFe06qKk3U8ucdiyddMP9C5S805bkT8hmsx68WQMBsYRbggjKCUEXj4XYI1nYLHfob+XbGrLNTCXEfxTNb/4MnWSLxb/onL9R4BN/QDvG38DClqm/VW2QNrkWAfWrHiD6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qii2k0XZ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso2147007a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743009940; x=1743614740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tf/nVXRs8M37VNl8JutluOwbokflRbc83AMXv062mpA=;
        b=Qii2k0XZ6DJE8H0ipD7rn43RH8NWjCdWJmYYsXVkloGObsD2q1FG5JJIh6cpivdRf2
         TxuRa7n6WH3x1R1gj5BXOmk/IPGTy1OMM07/BOMB10wIFL+eYKOJhiyDNQVMu3h0TQci
         9m/41yvtrMeOSKjJ8tAwGTuMzrXmxBPr+3PBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743009940; x=1743614740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tf/nVXRs8M37VNl8JutluOwbokflRbc83AMXv062mpA=;
        b=udOeyDhpgtEeK9QZo+xF3eNGvPmIPEyMzOVL65XaIM1FPda5H1A2UAOqfBKuiioByr
         1B8ldG8t5R6NAeIMkkfrNbyJ3Plonp5rS/gdrrKmfefP7eBAxMf6+BYUTsMHmpIa1hSm
         V+XHMevdZmsJcB+SbvrlYEz50Iu6J7UhRTHhuskok/8iFj4ERELqZ1FYPUcI6p1oaYfa
         lxXM0mkzwWcmIGlOyygBvdO6W/0mLyurDXgN2/n9yn/+5maEqR9BOipRyuWviuPSUlTO
         DEN6VqQDc0WC4WWZdKyQsCPvpW7xG0lCg4YFn2a8dSVgq9aqN38QbKNmhxdBFLC1qEt+
         cXXg==
X-Forwarded-Encrypted: i=1; AJvYcCWAL6b9WLGHDIx0t1UAMWBeu9kbEm9LxGJEiOIoytvblWckF7Aw6+wFOGpWlDVao40ArVGAJtygkeejzUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqaf+0gZ/7M+sk1cR5K9JxxC/Irg+50XC5I/CCOVwwDEYz3VNI
	QGxYCEWI5KB07LMnE2kSIFIW5ooN0pIx0KzNjwNWfukEOlS6gJmt3RzJ8iPQIOtp4Y/zjQsE5Tl
	paO6tZQ==
X-Gm-Gg: ASbGncub+uxrrZtEDlKy2vLF0VGkT8virk5hd7jRFhPqSnvtLxKg3pdsLKiZ7KkQiiz
	UPp2GFvSidThsELUPVIGEz4C+0kZGfwLE36KnFtnwSXjYXP9HHqI/OVDo4fuwNJ9avliWERxBmv
	6u8Gkqor2qYl9IVJK4Sx+fHv1jRnCqoIfA2jZle6fx3ShXMAXKZYQNRIft2Fm333H2aWVGts9fN
	Qb1dFy5YHeOcgj/9YRJqMMPesso8VqdhYfUj9UKqt3gyRG23/vk9D7Sxa7Q4PUuKemSAAsML0lG
	MPT1TRDdJ23/msjgmJbvGfSQgmmbrgTCtXAR/xKTLaFpQ1ldj72PrwPojucCh0BCvLMfD51ZGpw
	e1oPD6vF/P2MdP419pQQ=
X-Google-Smtp-Source: AGHT+IFeT0baFOZtFVfa+lr7fh6xNofh0sWULAOz1ubfwO/qyKyznit4GS6Gb7V9js0oSJw1Hrw57g==
X-Received: by 2002:a05:6402:40d2:b0:5e0:6332:9af0 with SMTP id 4fb4d7f45d1cf-5ed43ba93dfmr4553587a12.14.1743009940027;
        Wed, 26 Mar 2025 10:25:40 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf893bfsm9745922a12.28.2025.03.26.10.25.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 10:25:39 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab771575040so236790866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:25:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlCdXBOhBF4LF5LwyOii+fpKYqjwzkQzTus7SBxT4Fd/UC4yKypsgqC1TKEpDlvZSERs9RsRscg6Ap1PY=@vger.kernel.org
X-Received: by 2002:a17:907:3f1f:b0:ac2:32a:ee2f with SMTP id
 a640c23a62f3a-ac6e0d34700mr405560666b.17.1743009938565; Wed, 26 Mar 2025
 10:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325195322.3243734-1-catalin.marinas@arm.com>
 <CAADWXX-0hMgpyeQw_7Ko14hNMciqSnKJAROEWS5vwAdMKUt_zw@mail.gmail.com>
 <Z-NHugcLdLqkEHFR@arm.com> <CAHk-=wg_HipugbtswxFnekQy2g_ksKKXj+yht8naj2FEMtRMgA@mail.gmail.com>
 <20250326124025.1966bf8a@gandalf.local.home> <CAHk-=whwmmU+hv1SyMoyr8yAGP2JiAAP+g5BZaMajzAukzrM9w@mail.gmail.com>
 <20250326131200.1c86c657@gandalf.local.home>
In-Reply-To: <20250326131200.1c86c657@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Mar 2025 10:25:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXEvC2r=Sa_tpYjd=g+AxZDxxjSdq1WADTvZYZ9oUi_g@mail.gmail.com>
X-Gm-Features: AQ5f1JrBx5kuViM5WHNXW8YzlTQ_bduJ7gLngRyjIWCWOOPEj676hv5PA0NpEzc
Message-ID: <CAHk-=wiXEvC2r=Sa_tpYjd=g+AxZDxxjSdq1WADTvZYZ9oUi_g@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 updates 6.15-rc1
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Konstantin Ryabitsev <mricon@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 10:11, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> So it definitely goes through kernel.org.
>
> But it has no DKIM headers.

Funky.

There's definitely something strange going on, because your *previous*
email to me did have the DKIM signature:

  Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF624C4CEE2...
  DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;[..]
  [...]
  Date: Wed, 26 Mar 2025 12:40:25 -0400
  Subject: Re: [GIT PULL] arm64 updates 6.15-rc1
  Message-ID: <20250326124025.1966bf8a@gandalf.local.home>

and gmail was explicitly happy with it:

  ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass [...]

but then this later one didn't:

  Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDA5C4CEE2...
  [...]
  Date: Wed, 26 Mar 2025 13:12:00 -0400
  Message-ID: <20250326131200.1c86c657@gandalf.local.home>

and for some reason gmail also didn't actually react to the lack of
DKIM on that second one and only talks about how spf was fine.

Konstantin? Can you tell what's going on?

               Linus

