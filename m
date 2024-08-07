Return-Path: <linux-kernel+bounces-278537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C278294B191
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D058B21C5B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548071465A1;
	Wed,  7 Aug 2024 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NOIQmJhT"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D555145FFC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063503; cv=none; b=tFCZl0PY0e6uAQTbRe/Dj6G8AgxNRISRqL2sjIZ5H+xuvupBgcV3gy6RNOdLsXX84DgyYZdvSGy5G3pBagULjlrp77qTonSoqMvUVVvCrj1Paq662rQ3aukxbbuYUxhsst0L3C20mF/a9tDnDDWOIhzFI9o/es6aZIRVOC+TQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063503; c=relaxed/simple;
	bh=YwNOeimuQygHwGIXTa+IFsqyFBwhuCHCPuxytF/mHxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhMYJidlFgAjaL25rix2X/4DrdlkFmawa/ctSaS76zALXFH90+AX+Q27VjG87LvmSim5FL3Fqyaoth+jz94BjWPfVuUzMhiBnNIam80HSQ6yGXxNFDnPaWTmm9bW/on+xf1KGL3B2Pq2ZLiQu3uXorWUbVss9QG3+ehVD965JK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NOIQmJhT; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e05e4c3228bso242175276.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723063501; x=1723668301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcY9eiaBaY4AdoPWRJIk5UHCYBB3sGnhDI05fPPrY5Y=;
        b=NOIQmJhTkyya319rGmKFUMDqwBqxpbQCOmw9hqDJ28xwt5pxIotzpLDiWy0c863O+R
         /3PkdLv42NMYidI7wpFy8McpksWeN0jbB6kBKFKKsmAoPworh1L+QxLP5ehAVAAQThPb
         zm0InNarDtH4mwixA0J2+XaBQ3XxRgJKpqrKKCHEaI8r79HpKjZ+cNUh54uxWnVq0cz8
         8cRNdpDOt43CmAGP55xH98l41vYT8YkccfuQOIrlp7PPPUM8+ArGct7eeL6FY65b9BFv
         5kzLVVaAhcSvmXEq6LSVoM4nCNuvs5Zk5hUjc+d6SBSCbj/BC+Nq25jOrjP9XfVSa4rx
         M6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723063501; x=1723668301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcY9eiaBaY4AdoPWRJIk5UHCYBB3sGnhDI05fPPrY5Y=;
        b=DF/KgIEme93S5aPRxAGpPnb5sWRmpm+uCA0x2JP9+hcm/DpbJJVJGgikzqIYhU+KDg
         hsBG5yQI374uASXaIOvX+4kp0vlQXhNfthO43NNcGyKNuV/oPZvlPQfhhyBiC2YYqKpQ
         cjZHeSijMnPaeTHNAZo8Orf3hmDSGzslVQxsLVohVeLYlwgwJs5vYdgHcB44GzX4/4dj
         S7uffwpb46jZv0jUbcHi6pM+8ymptvWq0GxID1JaY5rtquh8AQ8qKIAaRzicCwWHYGyw
         cco9rE2doZ0HHrhfI9uXFj6aXcccxvY1yl1+SL0LrKuFREUE/jyjApClA0x92RZ/ZqHk
         ErLw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ9L6Zo2nBNNs+pqcPM/nDce23U6iXIVUX3y1xdQAHsV38RYGpNbP1oXnQXqNNjcCbH6YdZZQmxtteEsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2O2d1pWT5bSMaydlTxAlxrCvbzrTmIPU9auqxaz8FvZnkCvyg
	wCNWLkeO8yg+0Fty/kpEP34mlp0r84hD2v88ySWwM1hHGcmNMyMSXj/yyI3D4L8ZoMaAvQQ2s3e
	vSvq9NCILiwe1de5KIscL3efspZ+ksgWPw36g
X-Google-Smtp-Source: AGHT+IF9ul+AujwcVzk7ZEi9D/dHO2M2G5UrJp/TQmezAzTGRmux37dNQ9PQ2tfFlwipp+N+CJlqVjFMXMlH18+IPrk=
X-Received: by 2002:a05:6902:2605:b0:e0b:c94f:3040 with SMTP id
 3f1490d57ef6-e0bde2f1ac9mr23003030276.27.1723063500958; Wed, 07 Aug 2024
 13:45:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org> <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
 <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
 <20240806022002.GA1570554@thelio-3990X> <CAHC9VhTZPsgO=h-zutQ9_LuaAVKZDdE2SwECHt01QSkgB_qexQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTZPsgO=h-zutQ9_LuaAVKZDdE2SwECHt01QSkgB_qexQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Aug 2024 16:44:50 -0400
Message-ID: <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: KP Singh <kpsingh@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 5:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Mon, Aug 5, 2024 at 10:20=E2=80=AFPM Nathan Chancellor <nathan@kernel.=
org> wrote:

...

> > For what it's worth, I have not noticed any issues in my -next testing
> > with this patch applied but I only build architectures that build with
> > LLVM due to the nature of my work. If exposure to more architectures is
> > desirable, perhaps Guenter Roeck would not mind testing it with his
> > matrix?
>
> Thanks Nathan.
>
> I think the additional testing would be great, KP can you please work
> with Guenter to set this up?

Is that something you can do KP?  I'm asking because I'm looking at
merging some other patches into lsm/dev and I need to make a decision
about the static call patches (hold off on merging the other patches
until the static call testing is complete, or yank the static call
patches until testing is complete and then re-merge).  Understanding
your ability to do the additional testing, and a rough idea of how
long it is going to take would be helpful here.

--=20
paul-moore.com

