Return-Path: <linux-kernel+bounces-250253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D15292F5B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC25A283653
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E755E13D601;
	Fri, 12 Jul 2024 06:52:36 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E639B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767156; cv=none; b=rYyKPOJA1EmBaSwSom/tw11HpugmAWd+ABNjhvQRnZ5fi0wm8Rdy9/S4OjR6sXgZ1xBj39e3BLaazbM3yIwmzSATwGE5YDXEbtrmaUVKuiat1kjp1ff3LaJcgmgDHEi3V4D85BmkX2Xc383LT9HHyOszwq94e/oKul7TS3ZVbXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767156; c=relaxed/simple;
	bh=tltDuQ2ShByAENMk6rjExtHL4TK/R64PxaGm5KZyskY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3MOpIomBnta/o566VX7CKWwmwqo5phtHUQmWEtkV8RTEsRJLTvgSK4m4cSS0BgNCdHuRw1d8tCT/vdiPGJmGD2pVT92idNcaT64kQXyiu+FbQ5d4W8A6g43zB3zXpIAK1ziYCdfOLV0u+HTSJW8b35ZLilPM25RPMLo79DhaoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8036ce660e5so63960339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 23:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720767154; x=1721371954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tltDuQ2ShByAENMk6rjExtHL4TK/R64PxaGm5KZyskY=;
        b=DJyE1kKztKi3Yhlc6fUopKHebps6tcDbdTpzs9xdjDPCCM2a2KnFuqZ980rlx5Uvaf
         vs1x+ikZrCbcJ0krwj7+recGH1v9WytRHxm6OaESkMzWFEOEjEol5AC6lyCQtPql9Sr6
         xAYwAHwCRsCBJUnf+OMvRU56o8MfvPTKDRqLyrGu6tjexHvZQT3+ye6jmLSuzHasdNZG
         XH6LMYTgo/ZQ6Ic9V+GRfGPSheemxMyQzmd1d6TOxQZNXjgMsN5fetcnP7XKVocwSPlI
         rDGg6B0oJwq7cwjwU8eHA5CmWXU5voPgPqAzdnjyix8iEVkmmqruWZeUbCjtJ7Qx6VZX
         qETA==
X-Forwarded-Encrypted: i=1; AJvYcCXEu+wsPhlEStexr44r6mLvJwVPMrDSzx7qD+d2azx1tkd5B5s/VDbH6Mv+Fitm0+PncgR5QbHTj9lg0Nyo14gr/Anf1jT3vXBFYssW
X-Gm-Message-State: AOJu0YzthJS3tGFOkwm55uGuskM4msMWeLRtVcgF7uOGuLjjF0LdI7M6
	DQadJogiUFFs4b721uYlwEmmW/Vi4h9GEGfil1dxQnk2PdEHUtrjWjO8kshF
X-Google-Smtp-Source: AGHT+IEjNFWsW6cunXCdfbNrFPJUQsVwGCjEHyxEOj50AuQ4lT5pqGZJkgNwKwSqWeeLzr4qJk0MvA==
X-Received: by 2002:a5e:8603:0:b0:806:1b47:64ec with SMTP id ca18e2360f4ac-8061b476a84mr659694739f.16.1720767153842;
        Thu, 11 Jul 2024 23:52:33 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffe8e3849csm229126039f.1.2024.07.11.23.52.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 23:52:33 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-38c616bfb47so6704745ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 23:52:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX28uojaEKWN2Rl/XjYd9mw0Dkk/RAHmS+/SztHwgYhH2JHa4OsgIaX381FdUHp9OrwJbqKcpIn1b2At9Hphkgd2WJ03e6Pca316mpK
X-Received: by 2002:a92:cd84:0:b0:380:f340:ad66 with SMTP id
 e9e14a558f8ab-38a5a079924mr126659235ab.26.1720767152691; Thu, 11 Jul 2024
 23:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712032140.4012667-1-lsahn@wewakecorp.com> <ZpCqkPIOCsnmf5lF@google.com>
In-Reply-To: <ZpCqkPIOCsnmf5lF@google.com>
From: Leesoo Ahn <lsahn@ooseel.net>
Date: Fri, 12 Jul 2024 15:52:32 +0900
X-Gmail-Original-Message-ID: <CANTT7qi_qZfFH+T1z22GMQ-LmG1vHG1adzD=hxXiXyKT4kkhOQ@mail.gmail.com>
Message-ID: <CANTT7qi_qZfFH+T1z22GMQ-LmG1vHG1adzD=hxXiXyKT4kkhOQ@mail.gmail.com>
Subject: Re: [PATCH] android: binder: print error message on failure of
 creating proc file
To: Carlos Llamas <cmllamas@google.com>
Cc: Leesoo Ahn <lsahn@wewakecorp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 7=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 1:01, C=
arlos Llamas <cmllamas@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Jul 12, 2024 at 12:21:40PM +0900, Leesoo Ahn wrote:
> > It better prints out an error message to give more information if
> > calling debugfs_create_file() is failure and the return value has an
> > error code.
> >
> > Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> > ---
>
> What are you trying to fix? My understanding is that users of the
> debugfs API can safely ignore any errors and move on. IMO it doesn't
> make sense to add this without a real reason.

What I was trying to say, users would predict that a file under
debugfs will be created while they are opening a binder device. But if
it failed for some reason without any debug message, they would get
confused that the file doesn't exist and have no clue what happened
without a message.

BR,
Leesoo

(send this again by missing CCs)

