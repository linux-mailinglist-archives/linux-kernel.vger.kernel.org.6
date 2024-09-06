Return-Path: <linux-kernel+bounces-319201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B510496F938
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36351B24AE4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAF51D3649;
	Fri,  6 Sep 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=man7-org.20230601.gappssmtp.com header.i=@man7-org.20230601.gappssmtp.com header.b="B4yhKO0t"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1641D363A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639798; cv=none; b=qcEccvimigpZw19CoO7aYpMtG8pCcM74xYiD/f0Cl6aCotWUb6wCu66Me8o0OiTwDk8RjsHe8TWa4cyrXCEBOkHPplqE+1mVg/2LBTU1M/DAc4qYawWX7mXuhcWJ/rWs74MqboP+TtIRbjj4DTw+TEJr5EMsRQVyOacCOm+w45k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639798; c=relaxed/simple;
	bh=ERdRlKgkpaIMChPgsNZ0f1Aza0GjAPUeC2wrAfIUB10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKRzk8z2hQQ+CnPwuYrxAyELOJsGHUTzdUzwpP8hJIh3uc+mm8idDTP3kP4YzuagBDEOqCSbqxOI1MG1yhNyW1XT+/u7Xo/smvIx6xtsyuayTvmBsQ8ZT3H5STnDwZM7h2KEGXz1useQ/DhswhJAKrR7/ajmWcfN2Eff6yCIP6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=man7.org; spf=pass smtp.mailfrom=man7.org; dkim=pass (2048-bit key) header.d=man7-org.20230601.gappssmtp.com header.i=@man7-org.20230601.gappssmtp.com header.b=B4yhKO0t; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=man7.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=man7.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so2901956a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=man7-org.20230601.gappssmtp.com; s=20230601; t=1725639795; x=1726244595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LR1Y++LtSLH9utjcbc7rfksp9MwCdXSrnvTIYYJVrbo=;
        b=B4yhKO0tS5MXSUZaDZl4FGLSupIBHQ7r5ddXhdrkHsb3/YXUbMEUK6UljsRVqlczMn
         runcTz/7heV/7gRHBM1u5Qar2HZvhYCMa5flzGUG+OkGHEKRpWhcOg0ehQgIEzpnm9OP
         3m2y+sgXVDjMZ3pjhTKcxrTUyfe0VK0bnX9bQhwqBYxS6yxoFa24jJaT5IRfrbX3HX1D
         YXe5u4d7hWRC2ZofJJZsQUdj9n3ErSH8FQzmEP8yH+lInk+12lOO5QlFMXFvDLn2h/gB
         /aWw/0uDcUqlMSk2oLvSjCjeBUUl6VG/++tavWl08CZFpyi7/n+AzqvQoRTvW0i+wLOL
         9Zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725639795; x=1726244595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LR1Y++LtSLH9utjcbc7rfksp9MwCdXSrnvTIYYJVrbo=;
        b=Oz/Lqw/cqTwhwHbUMrJtHxvS9SfZjmXenXH5N9qTyPLC9vIrMob5ROM2h80sWwckki
         IYWP4cFP/u45bQapWl/KnKU4DFS3srn3bE3RqPcT39NXaxKWvP9dwDTcXQT2YoQxHhWt
         2suQz/osIqcjtrw70JhtvQ6NXHHSi1KTUGLhuvcJpdq18bZXRpfsIAqeKZOhpLZBFUEy
         1Qf4Jj+dGhh2de3TKYBhEC7fXp2ew9n/7LN9gMdDr3A3i8s26bkEvFN6sMVJP1SjNxL0
         cyKhFoKg+SMOaymtjyvxUWXa3etRYANpvybuBj0fpCUmWEOskxWljfV5Ps8ONE3ZemLg
         vhdg==
X-Forwarded-Encrypted: i=1; AJvYcCUYkN+k7dtUXYYBd1PVapsA64W7nagjutLHlhGSx+OXqXmCeaUU9u3pSd/D9knc8LJ3cv5Kx5lku+nLdBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZHVCPVPDs8NZLkvojgeSNWhCFvx/wMz5UIJzcvd3DpEB0dQby
	m/X/MY6zGsv2AZprfUFbVQbuYlKxauBg8Nf+nesAhrMe1KuwZybmVzvsmIVhqgGYBpa6qWJkXuE
	CcmJgMGw3yMAvWW1QOR4384xRNR9CgMDY383MBQ==
X-Google-Smtp-Source: AGHT+IF3bB89HLJaFoJZMB92aAMJyYADcrtbI2kmgfd+HZk8fsHhriK4v4yfNtP2XWiq4jixI279EXIvCPtWvRdU3IE=
X-Received: by 2002:a05:6402:5409:b0:5c3:3f6a:9767 with SMTP id
 4fb4d7f45d1cf-5c3dc7904d8mr2272292a12.9.1725639794847; Fri, 06 Sep 2024
 09:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d7tq6a7febsoru3wjium4ekttuw2ouocv6jstdkthnacmzr6x@f2zfbe5hs7h5>
In-Reply-To: <4d7tq6a7febsoru3wjium4ekttuw2ouocv6jstdkthnacmzr6x@f2zfbe5hs7h5>
From: "Michael Kerrisk (man7.org)" <mtk@man7.org>
Date: Fri, 6 Sep 2024 18:22:49 +0200
Message-ID: <CAFs=pgZeJhbDJ-RPgQ1HsdH+ccYHP-ZAd_waFyUrpN49NkS11w@mail.gmail.com>
Subject: Re: Linux man-pages project maintenance
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org, 
	libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"

Hello Alex

On Fri, 6 Sept 2024 at 15:02, Alejandro Colomar <alx@kernel.org> wrote:
>
> Hi all,
>
> As you know, I've been maintaining the Linux man-pages project for the
> last 4 years as a voluntary.  I've been doing it in my free time, and no
> company has sponsored that work at all.  At the moment, I cannot sustain
> this work economically any more, and will temporarily and indefinitely
> stop working on this project.  If any company has interests in the
> future of the project, I'd welcome an offer to sponsor my work here; if
> so, please let me know.

Ouch! I guess first of all I just want to say thanks for all the
high-quality work that you have put into the project. It's been
tremendous!

And then: thanks for keeping the project alive! When a series of
personal events led to me more or less burning out on the project, it
would have crashed if you hadn't already arrived.

It is of course nonsense that for most of its life, the maintenance of
the project has not got some sort of funding. (For a bit more than 6
months, my work on the project was funded from a pot contributed to by
a few companies, but that money dried up in the 2008 GFC.) I hope that
someone(s) comes through on funding, but I'm not holding my breath:
most everyone agrees that documentation is a great thing (a "time
multiplier"), but it's often the last thing on which money is spent.

Cheers,

Michael


--
Michael Kerrisk, man7.org Training and Consulting
mtk@man7.org, http://man7.org/training/
"The Linux Programming Interface" -- http://man7.org/tlpi/

