Return-Path: <linux-kernel+bounces-281648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5B394D94A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 01:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326E61F228B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7BD16D4D6;
	Fri,  9 Aug 2024 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZ+71quX"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832DA12E7E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723247604; cv=none; b=RbfbNl5Jh+HD21a+tydEHVxScBxlE9kbVwrfkRTMKd5ku2wSQPansSQ91cDyfFGwqA3v8hbEsu71xO+hr9GPTcsgnfyQuEKH6BfRUuYqJeuFSW5oOztt9p84sFtwpNbkhxU06ed+VCZdnIP7mQt61kDd2SIGUzhnIw66NIrwJjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723247604; c=relaxed/simple;
	bh=SVsRI4FZnpWKAafD7zdNZOTprC5QK7spQWfc1pujgJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4uz0xCzKLbmTjeC3GgxXrd8e1wpuH4SS1xc4szADAuh7Z8WOSv5NcEIazRUbJ2UEsolVi1a5/u1qVnBYWmO1tVv9sXzNopCeBkOrT71LJAPHn7FHUG7+gfo9VbI8scNbjMnMbU9kwAaPJ+8RaF9ghYhcmFqaF3KoXV+heXPBUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZ+71quX; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-81f94ce2272so95934739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 16:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723247601; x=1723852401; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HXq30+qqrGod7UMvtMZ4HXDcZmyjb07duezfSROQDkY=;
        b=OZ+71quXJ9+MppH4Y08mxWiOrZmNA9Pmktey2t+rF91pz0p55Tp06IKjhvbEzhluMo
         aEL3WkPnPV1qz4EgGEyouVg7WZePafVdnEkCZ9cX8LN1kWoAshse43rxHk9fQ9xh9KKy
         PZrQrSyV+P5iH58CkITmJGU0tNsOUKhZiBghtBn+pyycVWLLmMMcipmh94AsFcA/Qk/G
         6ZgOQ/qk6uYbs/I07yOzcUOasYydzebJLfeTfT5779iOjceUdeKZfesRm4hkAOLCVtbx
         oPmo7XnnHXyXnCLiBD6N5QGoxekE8I9T4mBQN14Yrx737NxUtjZyH8RUGI9bo3N4+j9E
         X3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723247601; x=1723852401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXq30+qqrGod7UMvtMZ4HXDcZmyjb07duezfSROQDkY=;
        b=cvZyJ3qRL1BhVooaGyJoRi1PKUspQBn3hujDkUSpppILMIb5YbAT7epntLwpm3ehEU
         CWr5NQCNasRRkfRMzQrdUQOd2DXV7CbVxHW9iXKEPFKKV6BcguvFd+6QtgjsEBV/KRm1
         PCBuKW5gME/xJ+eO7F0loEI20CvXPiQeXRqd7z2HutiKXvZz2W0cKzFwKUvCq46PMGwa
         0ImhLqJD0Pw1Rmc9zhsgaODx0GLtMU8cI1cceMsOOKWAB3BA5ma6+qUxz79kdPipWCJU
         zIiddymgBzkj49EidSS9mfmXCNGE8hVQ+zeTvycS132xFDcrEEkv22xQ36wPFJXfsLLp
         4bsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXHgiecaazRy61ciloXcR2bob7WhOeSgZu4oLaFy6opIvQmdaZoL+fi80L6aX93alUv0kC44IdHwvzpq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwKvjp9nzDSzQq8pyNtx8soBmoB6nzFoQ2PvD1QrnbWrtJdOiz
	CW9InFJVBrRl43VdpKGgLx7UCtbRV9d8LFn3TrLhIRZ9CNGV1UybkRrd+bWqcf1swnpR+CHWLnb
	3aw==
X-Google-Smtp-Source: AGHT+IEt1122BVWzRU/Fdnx9ErHZzG/ziyc35/f/6K4zyR9rH9XW7MgNnZCs/mdNOK5r3s+QQAhjyA==
X-Received: by 2002:a05:6602:3d2:b0:7fa:56f0:ad87 with SMTP id ca18e2360f4ac-8225ee84692mr469625739f.10.1723247601487;
        Fri, 09 Aug 2024 16:53:21 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca7695b7f7sm236213173.80.2024.08.09.16.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:53:20 -0700 (PDT)
Date: Fri, 9 Aug 2024 16:53:15 -0700
From: Justin Stitt <justinstitt@google.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/string_helpers: rework overflow-dependent code
Message-ID: <dyigpya2tb7obniv3g2rzhtahvjhximzjlvoi42c45fqkb7hx5@tw3loxvglexa>
References: <20240808-b4-string_helpers_caa133-v1-1-686a455167c4@google.com>
 <CAHp75VfBjKLf3LqDXvAehW5sxGzYnU4sS3fr=JoaM-6p_gR34w@mail.gmail.com>
 <202408081609.D08D11C@keescook>
 <CAHp75Vd3wKyq2XE2UPoW_q3KjmncSeaEebL4ff5Gpx8Lz+dB9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd3wKyq2XE2UPoW_q3KjmncSeaEebL4ff5Gpx8Lz+dB9A@mail.gmail.com>

On Fri, Aug 09, 2024 at 02:07:57PM GMT, Andy Shevchenko wrote:
> On Fri, Aug 9, 2024 at 2:11 AM Kees Cook <kees@kernel.org> wrote:
> >
> > On Fri, Aug 09, 2024 at 01:07:21AM +0300, Andy Shevchenko wrote:
> > > On Fri, Aug 9, 2024 at 12:44 AM Justin Stitt <justinstitt@google.com> wrote:
> > > >
> > > > When @size is 0, the desired behavior is to allow unlimited bytes to be
> > > > parsed. Currently, this relies on some intentional arithmetic overflow
> > > > where --size gives us SIZE_MAX when size is 0.
> > > >
> > > > Explicitly spell out the desired behavior without relying on intentional
> > > > overflow/underflow.
> > >
> > > Hmm... but why? Overflow for the _unsigned_ types is okay. No?
> >
> > Yes, it's well defined, but in trying to find a place to start making a
> > meaningful impact on unexpected wrap-around, after discussions with
> > Linus and Peter Zijlstra, we're going taking a stab at defining size_t
> > as not expecting to wrap. Justin has been collecting false positive
> > fixes while working on the compiler side of this, and I had asked him to
> > send this one now since I think it additionally helps with readability.
> 
> Okay, but the patch has an off-by-one error (which has no impact on
> the behavior as it's close to unrealistic to have the SIZE_MAX array).
> I prefer that patch can be reconsidered to keep original behaviour,
> otherwise it might be not so clear why 0 is SIZE_MAX - 1 in _this_
> case.

Right, it is technically different but still functionally provides the
"unlimited" behavior.

But, we could  do this too:

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 69ba49b853c7..0f76b5288833 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -320,11 +320,13 @@ static bool unescape_special(char **src, char **dst)
 int string_unescape(char *src, char *dst, size_t size, unsigned int flags)
 {
 	char *out = dst;
+	bool unlimited = !size;
 
-	while (*src && --size) {
-		if (src[0] == '\\' && src[1] != '\0' && size > 1) {
+	while (*src && (unlimited || --size)) {
+		if (src[0] == '\\' && src[1] != '\0' &&
+		    (unlimited || size > 1)) {
 			src++;
-			size--;
+			size -= !unlimited;
 
 			if (flags & UNESCAPE_SPACE &&
 					unescape_space(&src, &out))



Really, I am fine with either.

Thanks
Justin

