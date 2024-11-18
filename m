Return-Path: <linux-kernel+bounces-413274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CDF9D16BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31549B2421E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006731BDABE;
	Mon, 18 Nov 2024 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AyZYzLNb"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A63C1AAE33
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949647; cv=none; b=kIiSIFK7ZV97b7/mY7gbqO1gz6Y3QCJbYpG78XS2TIybZOI2wQyfBFETC2jqhcHJiiQnbLdGNdrfW+iLoRWCe9x4SF3bUQatAOnI6O50p6MxZKYwBq4w0ZfWk04AK7LEsygYARfAc1IzA+7ir7eOv0HmFtWJMhg3J4eV0Ss/aZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949647; c=relaxed/simple;
	bh=axFC/LtX21GaYn4eHm2SY299Kzu3MmoEr507YWFN44E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WATuzMGb/7KD8/6sBYGKwTGW3x4KR22+6XvqpENGTC2I37qyyqLcMtm5bI6m3lDf90xfyq999EAWdYOU5qcqHVD092FCKrDWuT4Z5JfWUdf7yPsjGJPRndRLEnJ60JtZU8LqaUOmUbZ3efZiIRSpNM4M3wS7Z0APFBmVE8WDEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AyZYzLNb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9ed0ec0e92so332418666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731949643; x=1732554443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hQEIItX4A04+EjUo/O5m3npmYtu4tOlkSxU3N0Dm9+8=;
        b=AyZYzLNbO/A79xFEyiGQXILY+VEDbSehal9n95BPqtA7kMD+3A2knqyoEB6/4100Qo
         hwT899uzFTR1GCVbsCvmsrSm/DmUGha7FdUWsH7e+8vDv9yf/JFkzTnPFVAjuDUXvQVU
         znVAXgPjdPUkzM9h6b+FMvkGM2nIyLmIugYCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949643; x=1732554443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQEIItX4A04+EjUo/O5m3npmYtu4tOlkSxU3N0Dm9+8=;
        b=wUBt7mMFwGM5qujPq7E9OBeEFPw4tJXtSFyJ3RH4OWGiVnHMd29K6U6TC5DcYRnxv4
         l69Ebq4eABaQdfYSRwVuUkRtQ3JJzwhNzx9eHABjEPFedxzwA9jSC6nrbvPOYUmm+BNM
         tW5MMCNOcyX3jsvdEH7jWzGejdWeXCjff8qaHvKgeS9UTcIBGRPzZzVlByvpJ09urhaL
         ulVr3p56ML3fQQzf33jDW7wmVlaYd7PwQnIeNPXOEc2RdKkaLxLGKWGm9b/1FhPG9nfP
         V3jJmYxReqsmIXPAhWGQ4d92ToDP1eTpaOjDGnO+SgrpbxGSq28CqFKotZfWZMAMdick
         CeeA==
X-Forwarded-Encrypted: i=1; AJvYcCUtmHNVOUGrW6AbSWZOhLpqxuO2XGlXYWbPlpc66pwqYPJTtcSgL4F5AHWJW4JE5383ibOH1axjZeFpiVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM/lgpdX0iUpAKPRbazNl1XhtqPNOl67O4K0bnEH/FfpndptNg
	mxUQvynDl8buxZd7Uzilt1aPy07f6w/GYt8wtRbMFGLE7LyXJ7zS7NIYK0aNndqaDrBndB9keRn
	EW7kPnQ==
X-Google-Smtp-Source: AGHT+IFiS6NgO9DIUgrc4DQ62wxDwVdwwbSu30BjPRKr6nFiZkRpotzCXEuQODTa3NN4loFgiDZVaQ==
X-Received: by 2002:a17:907:c7da:b0:aa4:c721:fab3 with SMTP id a640c23a62f3a-aa4c721fcd7mr26030366b.41.1731949643222;
        Mon, 18 Nov 2024 09:07:23 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df5690csm560007166b.75.2024.11.18.09.07.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 09:07:22 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa1f73966a5so473423766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:07:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPvLOj2vfwP/kRw4jURqqVBaNd6FYsxklmVBPIPFFUuLlkFYQm/PqChXqayJhBhZ5e9dYgj+aoMKsq030=@vger.kernel.org
X-Received: by 2002:a17:906:c112:b0:aa4:7905:b823 with SMTP id
 a640c23a62f3a-aa48347cb36mr1143794366b.32.1731949642297; Mon, 18 Nov 2024
 09:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116061258.GA216473@lichtman.org> <20241116072804.GA3387508@ZenIV>
 <CAHk-=wiMEpPZYDeF5ak8FToB_fw7pfjKhuJAcjLpjqMfCvvB7g@mail.gmail.com> <8734jon4sl.fsf@prevas.dk>
In-Reply-To: <8734jon4sl.fsf@prevas.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Nov 2024 09:07:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wikCh5JSR7=2mH0_d9hdAEtcG=Xz7-Md7xzp1GLfJFFKQ@mail.gmail.com>
Message-ID: <CAHk-=wikCh5JSR7=2mH0_d9hdAEtcG=Xz7-Md7xzp1GLfJFFKQ@mail.gmail.com>
Subject: Re: [PATCH v2] exec: make printable macro more concise
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Nir Lichtman <nir@lichtman.org>, ebiederm@xmission.com, 
	kees@kernel.org, brauner@kernel.org, jack@suse.cz, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 03:45, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>
> Exactly. But you said otherwise two years ago:
> https://lore.kernel.org/lkml/3a2fa7c1-2e31-0479-761f-9c189f8ed8c3@rasmusvillemoes.dk/

I do tend to stand by the "anybody who uses ctype deserves to get what
they asked for" thing.

But yeah, I think the time has come to admit that Latin1 isn't what we
want. And I'm looking at some of the users we _do_ have, and (ignoring
tools/ and script/) the most common ones seem to be

     14 isascii
     32 isalpha
     46 isxdigit
     56 isprint
     59 isalnum
    158 isspace
    187 isdigit

and none of them would really care if we just limited it to ASCII
again. In fact, the isprint() ones would seem to generally be much
improved (looking at the ACPI uses).

I suspect we could make them be range-based instead of based on that
table lookup while at it.

So if somebody sends me a tested patch...

               Linus

