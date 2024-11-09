Return-Path: <linux-kernel+bounces-402986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7C19C2F47
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 20:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4E01C20BB7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ADD19FA92;
	Sat,  9 Nov 2024 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl2/KYos"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25D1E4BE;
	Sat,  9 Nov 2024 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731179944; cv=none; b=mE6KPOKnIeAFYa+OhNDJXB3vhPtV/oApZUbmERerI9MAydyO1+bA/NSmtbtmem1JEePhekvGCc0irYeE3d+ILAfhZdPYpTrrrN2netdq6MCu0sChrL3Bye85ixzIUvWPNajl51cK/P457iuio5w7XV3MODbMjHZeZ34tVP2SHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731179944; c=relaxed/simple;
	bh=YbRmA8WVWQGzejmSZvTvAXTKgDsJffsaP827z1XCqu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pweo3GHbQkD4jWzP9Bi75/r/PAB4pE0wCQ8EfHCL0Cb1Ab3nJJI6fNf3cQretNMUcISaQ5ocGW79HUV17M6JQ+KPWK/sDmsW3q0x5j6tilKekhYyhW0sPtJdThg70yIDcXoJsCWuJ2G/TIlwLpQ4OML75SWPPmiZS1D8IkTi3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fl2/KYos; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e8607c2aso3783323e87.3;
        Sat, 09 Nov 2024 11:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731179941; x=1731784741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbRmA8WVWQGzejmSZvTvAXTKgDsJffsaP827z1XCqu4=;
        b=Fl2/KYosAM7rvxM3kogVWB+Zmnl5uPySWE7+5rIqsc3+KJGn9ISvjcKWiimrFYSglG
         QaxtEn4hs4kAWLOq6Hk57HpQY3e5Qa4tTWYE3jid+n4ynwpJDiEDo8yJU4QEztmtHkxa
         n6W7HPiMUehR5AM6HFgpIGuoM65XOfeNbUIxqwb3gs8tZYBqSRg//aNy1O/F2BFsRYve
         TlQ5OeE1cUn57gsWzd3j7eO/W6xyB7nWT/MnyMhQqXI981FNe89ltqc92eCB4nNLVqgy
         Cxuo9Xr1Nq7CtbjS6TdReTokzku2Ysz22S2wur8fGFLkTrO9VtLn7aLXjBRr8ri5qeU+
         2afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731179941; x=1731784741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbRmA8WVWQGzejmSZvTvAXTKgDsJffsaP827z1XCqu4=;
        b=u+WM5bDqmXvb7IMavhoCcQUsUHPWmhgzPVreYC+5Zqz/F3zXiKSQ5NmDCfpHcHswmB
         +g6VKVZWcNmriR088tjLBzH44FgJcvOdJmKPG+TG+KMRVoqhb40OqUklq5sz/atFBDbd
         WvGeLK6SMWK2oVf0DsU7N4AguffVFpen4BfrGDjoZuIRtrckUEikVDUyrST991T9gbMP
         0tnzsJGvAyvUxiBuxv/jdztzgTaKtuSEL9R4wVaO4KIl9M4TXwMb7so5oPX3T1AHfSHo
         PZnMuDZoTN42LtmBbglgcDBZz7K1+8dB2vnOgyepSQ+P8kq/0P06TmkUjf327uY5mcLp
         kgog==
X-Forwarded-Encrypted: i=1; AJvYcCUFgRSd0qK+gUm9Qxfiu/n2VNturOvI8D37lUgIfAaaLO9FaP/zROFTcmnPU9+3m6m9nantVXAtpeasCjIK@vger.kernel.org, AJvYcCVYChxNUitqLCYY4kJLm7/wxkGntmZU8wu40BdCY3suV/Dv21IZvA03BaMivdi7M71kgjYxkuMJMTWbVyU=@vger.kernel.org, AJvYcCWK4HYSzmSwTZpksi0yPSZGW5Q6VAb0iTSX7R3tx5vjaojSMtohslxITfYWck77prOUStV2LxippXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBxy5IiwCIj48xiF6qFgnGKxYYbBLhA08IVsQ0sXp9sz+PfPMz
	R9FMC6kUZ/2VLBtzlANNkNS4LvLJ3Vo9h0UEmOny79o5ihf+1MAwOQ436tapW6veAkV3Tg1gsIm
	/ynrZCK3eftu+7fnC1FLq2JoPmrf0F+4oq1M=
X-Google-Smtp-Source: AGHT+IGatpVSYXkBi9BEH9qmFT6KSODhk/syTDyQfdH1zQpeBKTO15p26ly1y1BEeuem6eScuw7T+4/thdmEBfiRrIk=
X-Received: by 2002:a05:651c:b0f:b0:2fb:61d9:d72b with SMTP id
 38308e7fff4ca-2ff20152500mr30059151fa.1.1731179940880; Sat, 09 Nov 2024
 11:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108192413.10751-1-yesanishhere@gmail.com> <Zy7YDKamcrkSg197@archie.me>
In-Reply-To: <Zy7YDKamcrkSg197@archie.me>
From: anish kumar <yesanishhere@gmail.com>
Date: Sat, 9 Nov 2024 11:18:49 -0800
Message-ID: <CABCoZhCYVsrTsv+=fM_i_0hz9Gy5zA6imL1-AQaJcOZYzgeB+Q@mail.gmail.com>
Subject: Re: [PATCH V2] ALSA: machine: update documentation
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 7:33=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
>
> On Fri, Nov 08, 2024 at 11:24:13AM -0800, anish kumar wrote:
> > +Clocking Controls
> > +=E2=80=94----------------
>
> I see in my htmldocs build output that above section heading is still
> normal paragraph instead...

Uploaded a new version to take care of this and the warning.
>
> --
> An old man doll... just what I always wanted! - Clara

