Return-Path: <linux-kernel+bounces-181229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6678C7937
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAC81C21C59
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436B114D2BD;
	Thu, 16 May 2024 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSJihCiy"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A614B978
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872841; cv=none; b=Bqdk2QBM9wSZRvJnvyrU30I+s69RQDdpZNmVhhCBZAYTvvx3Ne0nrUedA9GWN0873BtAJwaQ4AgAM9bI2pIlD7fks5eAknspf2Re6rv4/+p/GbVfTz5ltoic6oRAGTwmAVoOtQSUp1rxYGNWJZeEdT/TTnjUfJe9rKQ7PhOA1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872841; c=relaxed/simple;
	bh=OrCRas2hNJaNPQ35bTqgoMcTF8XIvoPlwmK4bk8Nlew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhbINBHL6KHG3B0gLfab2mtmh2Lg1/wZbV1/YTeAzwNiXS9yCUgLqdr/HQwNTfxrB75f7eP+r7lovq5EZfsU7eftvH1N1tx+iR1uNr7HdXwOAl4wRpQ4h8i6uL0fUKdGuV/r+sNHeaTbnBov1fD/mVfLDlA30uezkYZyN+zSClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSJihCiy; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c9995562fcso183442b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715872839; x=1716477639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXJ7XR1WdxF2Wo/8p4xyU1APfl6J/Kw30C3weMxzlPI=;
        b=RSJihCiybQyTvAkFO7OGq0NvabXmp7sVVnFYC0jFzzXf0wlK4r3mLap9smCAjbDQu2
         vu264gVgp3wgoEi2lalq+MuKRljwLLVt09krUF7wvqMPGSGwtgDK7vP9S3Ki1N1CEfeW
         64xV5FnjCYzVFyo6i+aYW9ynWVwoDnudOYVT1lPcguhibkTPjA4Ua/YieWS7mh69RA0K
         c2jdbhBnJm9LfSnNcohOY2pEflSpBx81+Ar4MTsP7IPCR/XqrnhwY8Xa6ZTwBEY16/DG
         gsLFcD3ahRrnIIoq5lwZlAZpcpGvztKzhEk8DveDt4UgRnXp8oVz2m1dLGw2uWASfwac
         rvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872839; x=1716477639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXJ7XR1WdxF2Wo/8p4xyU1APfl6J/Kw30C3weMxzlPI=;
        b=wO7eMw7nX/qsqZT7ngRE9qlIc9RLflf7A9Bz8xdZQ/Lc9XI396j4vtiA1JwHV+Cbpy
         VNXi5QJeZ/lcVFMKUOEp5xv9ojyy1bsVAZw+r2GAoc3zrW3EgayvaWjDUslK/Uheflrb
         ECs25+mXhygVj6nrbU70hBRpWIWfdAFhWV+nOzE53IGQGPqqe39VcxUDq99kJI40xJXl
         cGzwjPnruyIi/s8wmDXwcCXl8Y1qUGt9WSD22DGDZ8wjaow+grm1Ou/ek+ZlDBjAht2A
         POEO8nVztcrjST1Y8I8A0CU5ikHZuduSMZaOeN29RHjE/yz0NU68wilKqfEHLvBXf42l
         52QQ==
X-Gm-Message-State: AOJu0Yz6yxAeJkmSnDE84zZOTnV+dnSLkxXHqWc1agTZIqci0euElU//
	bgHVuUN/leq7aCOOmInVLkFaQWk99gMl+E8dKeVeSXDmTBaVAuhlOs774J8EoIGTdB2FICBDhzq
	aKOTDfxLYX1HaCoOhJ35oiXuZPFLvAQ==
X-Google-Smtp-Source: AGHT+IGyJC5AcCK5WQiHwTGi65KujR1xLgGkxjvhHmX85VosWDr+NS+LCw0ZYlL+aI4oVtpXUnFBES+nWnLwrEqBbao=
X-Received: by 2002:a05:6808:60a:b0:3c9:6c1e:262f with SMTP id
 5614622812f47-3c99706cafemr18023700b6e.33.1715872839221; Thu, 16 May 2024
 08:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516141418.25345-1-jim.cromie@gmail.com> <4a77b3a77db293acba504914af220d8b8d644616.camel@perches.com>
In-Reply-To: <4a77b3a77db293acba504914af220d8b8d644616.camel@perches.com>
From: jim.cromie@gmail.com
Date: Thu, 16 May 2024 09:20:12 -0600
Message-ID: <CAJfuBxxEgCT+4SVAxoWb1xvAqhgij489=z+FH9iuXwYksm-RWA@mail.gmail.com>
Subject: Re: [PATCH 1/1] checkpatch: allow multi-statement declarative macros.
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, akpm@linuxfoundation.org, 
	Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 8:43=E2=80=AFAM Joe Perches <joe@perches.com> wrote=
:
>
> On Thu, 2024-05-16 at 08:14 -0600, Jim Cromie wrote:
> > Declarative macros, which declare/define storage (at either file or
> > function scope), cannot be wrapped in do-while statements.  So
> > checkpatch advice is incorrect here.
> >
> > The code has an $exceptions regex which allows multiple statements
> > based on the macro name, etc; /DECLARE_PER_CPU|DEFINE_PER_CPU/ are
> > currently accepted, widen those to accept /DECLARE|DEFINE/.
>
> It seems this exempts too large a number of these macros
>
> $ git grep -P '^\s*\#\s*define\s+\w*(?:DECLARE|DEFINE)\w*'|wc -l
> 5075
>

wow, thats more than Id have thought.

> How about somehow limiting these exemptions more strictly?

agreed.  I'll just add my 1 exceptional macro name.
resending shortly.

