Return-Path: <linux-kernel+bounces-255799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 656A793455F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A94282CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7161C2D;
	Thu, 18 Jul 2024 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F1Vm3PAv"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB06CEA4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262309; cv=none; b=m46gDr/wrE3+lWGEwynHEwhQgMpMNpBTfgyI8jwyA1m1uUt3Qq6wx999GHGsSl7sfomS+FHrWCHXnyZTyVl2UwRHqDElrynNUBGz+2YqYUbRYR/JdCLSj9vhMyPI6Kw0PEodoKsrLnOm5begCKM2yXakN8ghjFxA69Z6iJRIxzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262309; c=relaxed/simple;
	bh=IJxNKounMxqXQ/v/BKFsifWplKcA9iwtXjgiC1PRubs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=f9jRW1G9tyG5MaQi7zVfuXyNBq2yPFX/mDUEw3aNJpfHoijnGG1ZDHoXmcS8gz+cRecadzrBeR160JMNuS/EEL/PuetoboJw5PcG1Mi2MSIinVR2ck4JzN3FYBl9v4v45mJ/Rw3Td7WB/JDOoNYqow+yO7oGOFHGMam++fKOcL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F1Vm3PAv; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ee4e26790so334088e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721262302; x=1721867102; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uWt5MRgiFwtJHB8UyQZuipfHU1hROtorTGuhqMlfhd8=;
        b=F1Vm3PAvafk7jJ+cH2kXVM3XWZJZttNxPswDPndRLEIMnIC3V38Sqb+RKNRZvwjSh9
         wxRdiLyX38fzEJ/MzALlZiHL8iKBMi9MPL1pXbdOwmo9Z791JbD8qk8/T/+0qdjQggON
         7lzp+o50EGX2e8MDr2j/4ObQ+o8LpvEVelS3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262302; x=1721867102;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWt5MRgiFwtJHB8UyQZuipfHU1hROtorTGuhqMlfhd8=;
        b=uIDPDDDW7rn+3sBBBCeu1cjwiUEFyHYW/noPUxwozJ8eDgDBUCAvFuEQ5dJNOYgUJg
         fi9gFLsyD2Mnu/l/Hc5MY+OrGKgHwIcF/lR5uNUQr66NeYt4DC5NZin/Lkd8k3x32nV7
         QeaX5gXn9k0DfRGqpG1AxRPqg0v4isOCeh/ICiZntu3nYvEJaQr9rZ7YkcfOuTvDPRB5
         9nUTOvH0qQZe9h7iqsYILZ7E0Z6mBLuS8LlvlrkZ9rZrDL3vSmYyollj1rOF1V8L3kU+
         +3zfuo2phG2/VyP9NZDKSuGSwGdZh4aqQ6ve5LyPVORSt5Uvq+ZzOL9Bz/OruEjG0+hX
         TpCA==
X-Forwarded-Encrypted: i=1; AJvYcCXNEISAG6sj6yqtdDmeokVVS0IMbe1+UDkvut3JICsl9FQzBqzK60hpUvcKbT3a7iYjWZd8abUUQQ1ZoFs3FWKxqYsY6FIXkcfnbvxb
X-Gm-Message-State: AOJu0YxPRntdq5wFc3o2AFt+eShASYK5oZN7FtrA6Dlso2OVc4l75hyu
	ZlXx4U045EOh2spkA9byvLRp+sGRH5FSfcnCb/rTT0lTFN8DYIrH+rzvSnkaspGUUf6MThOOl44
	lR5WyIw==
X-Google-Smtp-Source: AGHT+IGgxJNPdoWWpdOSn9wuD1KHxRY1lq2kliQXEEezRRFfZtESpVU5nZS+e2rKCNVkbSYQDQJYCA==
X-Received: by 2002:a05:6512:3e24:b0:52c:8944:2427 with SMTP id 2adb3069b0e04-52ee53d688dmr2282647e87.31.1721262301680;
        Wed, 17 Jul 2024 17:25:01 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed2539634sm1602126e87.289.2024.07.17.17.25.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 17:25:00 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eee298bd2eso3385891fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:25:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXjQblZ9Zlk3V/yD9nd3kZS9HRwj/pnxX9rhvw5+8KxvXJX7KGSNe6U2kBHTrjC3Vl+wvTLZJjvoOnqsjxDDz7Px1qKKDM7MDNrpja
X-Received: by 2002:a2e:9d0a:0:b0:2eb:e365:f191 with SMTP id
 38308e7fff4ca-2ef05c6e43bmr5642541fa.15.1721262300266; Wed, 17 Jul 2024
 17:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZpY3X1tggZC3s_1X@shikoro> <CAHk-=wigtUnqv+RXkLZ2TwqV35YQeGrYsMnrowpnmQNN6wyhCg@mail.gmail.com>
In-Reply-To: <CAHk-=wigtUnqv+RXkLZ2TwqV35YQeGrYsMnrowpnmQNN6wyhCg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2024 17:24:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wir5OYeNSytz+EocQnQxoFX0LY962R6FDj9cAHBiXFe5Q@mail.gmail.com>
Message-ID: <CAHk-=wir5OYeNSytz+EocQnQxoFX0LY962R6FDj9cAHBiXFe5Q@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c-for-6.11-rc1
To: Wolfram Sang <wsa@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 17:22, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I have looked up said explanations, but next time I need to go look
> for explanations I'm just going to ignore the pull request as clearly
> just not worth bothering with.

Actually, I looked more, and that's just part of it.

There are other merges in there too, and this just pisses me off.

If you can't be bothered to then write a summary for what the
different merges do, I can't be bothered to pull it all.

                Linus

