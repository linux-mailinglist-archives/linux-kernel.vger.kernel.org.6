Return-Path: <linux-kernel+bounces-300331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB6895E276
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 09:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF0D1C21393
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B5648CCC;
	Sun, 25 Aug 2024 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XdFRlqEV"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9B12A1D6
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724571483; cv=none; b=ntXyBr+GjWkrsVvfJlAtKHwybdYK1BM4dJyv0U2AxDzV4AAWiaCtm7S+sazRNcFnChvy7w90eDkiVw5m49lcuAlEm2fpPDAIM1p5HK5mpPqimuQRUd3w+mibMpW3LdX8vrtl4oT7VgF7Bw/xUw9QH5fPoDM6sRbvhk+Yapuf77M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724571483; c=relaxed/simple;
	bh=i8WLKy0kzl3QBJsz+vOUwl4AsgA4hLoGEadHRQP3BtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IRedfTsZBEdEg3je9r1iUMR7JZjhug8eCGNQyaTKEmLY9wcWSuRGlpI1SiVoXX/UJc58SMSNGdHKe7SKMHMSztAW4iiFpZvjVRwWR3jYJJ3P6J9N9XQI9a06nV8IYCtd8kTye3ifutz+E+F13Kr97PnpzQTEj1VuAVRnkycjdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XdFRlqEV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3719f0758c6so1913031f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724571480; x=1725176280; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXm58TCs+2qNiNfDJ8ymrl4Uf/SCXS8WPeafSKvrsYI=;
        b=XdFRlqEVRlaugSDWoDjCR1YBAhWu6PiPIA5jGRN17i4sdL0fReC2LWPRqfYqRXd7KM
         yE0ufllu/r6lfwo1/8Pu99YScmRILIR58J/yWX8Kxya6zOHoe0RA0v+xcVeJOnVH+zO7
         lejd7DC2HlS64xpdqeI6k5fKYJP4fIy8ww/8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724571480; x=1725176280;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXm58TCs+2qNiNfDJ8ymrl4Uf/SCXS8WPeafSKvrsYI=;
        b=HrzSLDGpwVrGcq4URFR0pzSrxyeW0ayYgduQK8OQrMBFHZHXEKZQlsEQ4ZHjsAVN2b
         FYs4eJ4KQ26usBkR7xMwcUgB64R1UQksOSE1pmuqnyAY5zjXIUKDcZSCnuJTLW+U4ic2
         0e5SsjYiLHcdpjkZoj81dIfknK+OOQruSa1phgYdLCkKBaYvnJ9IpoYDOcgO0zSyEpbq
         k32fe8hOnL1Q67OhI1CjfmlIsOX8s1xfOFm9RVzQC8YXjqvQTK+59oynXt57AmAHo132
         AFK9ebbzXR0AHKNCpkndc+yB/agJCEDVCBB1pBuAFu38RiEdfCqlIKpjxMlZ/ZFaUk/y
         VIeg==
X-Gm-Message-State: AOJu0YzCRBY+Bva+LrmrKigbcz2L8AJxHtlX6HmNmkzlwFXol5JQTaNd
	piYACWu8qhNwXQIS53sKp3BJVv8FXgnFBjD6qzRt6/A21z0HsdPMsIZMw0bXavaBeELZppWsdQE
	DBVkWYw==
X-Google-Smtp-Source: AGHT+IHpkp8Z8kThAytUzPI4VbkzBOYkjBj+ho1hD1KqJirlcpDTw6eroPbP3Iposfy3OqhMrGlUzg==
X-Received: by 2002:adf:ef06:0:b0:36b:bcef:b39f with SMTP id ffacd0b85a97d-373118ea0c6mr4319519f8f.56.1724571479417;
        Sun, 25 Aug 2024 00:37:59 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ca46esm4140375a12.27.2024.08.25.00.37.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 00:37:58 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so4069541a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 00:37:58 -0700 (PDT)
X-Received: by 2002:a05:6402:380e:b0:5a3:5218:5d80 with SMTP id
 4fb4d7f45d1cf-5c0891748a3mr4025469a12.21.1724571478242; Sun, 25 Aug 2024
 00:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh599movdAyCHfVmYakq8rqKQD9wCvUAgBqbF3znEu_2g@mail.gmail.com>
In-Reply-To: <CAHk-=wh599movdAyCHfVmYakq8rqKQD9wCvUAgBqbF3znEu_2g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 Aug 2024 19:37:41 +1200
X-Gmail-Original-Message-ID: <CAHk-=whsqTTsiZ=XmecYwQqqya2C4ufysiDj2bOPhvke4mR2mg@mail.gmail.com>
Message-ID: <CAHk-=whsqTTsiZ=XmecYwQqqya2C4ufysiDj2bOPhvke4mR2mg@mail.gmail.com>
Subject: Re: Linux 6.11-rc5
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Aug 2024 at 19:27, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I delayed things to the point where it was at least Sunday back home,
> even if not even remotely afternoon. [..]

Oh, and I forgot to mention that there's something special about this
Sunday: today, Aug 25th, is the 33th anniversary of the original
public mention of Linux (although not using that name):

 "I'm doing a (free) operating system (just a hobby, won't be big and
  professional like gnu) for 386(486) AT clones.  This has been brewing
  since april, and is starting to get ready. [..]"

and while 33 years may not sound like a particularly round number, the
"brewing since April" means that it was actually 33 and 1/3 years ago
that it all started.

A third of a century. And it *still* isn't ready. I really need to get
my sh*t together..

           Linus

