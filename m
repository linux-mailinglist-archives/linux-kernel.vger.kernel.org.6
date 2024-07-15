Return-Path: <linux-kernel+bounces-252975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AC3931ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E5FCB2175C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C3D130484;
	Mon, 15 Jul 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BZpg8Bln"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAEF6E61B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071258; cv=none; b=VR3KKFJjgLN9TMAJWhdIqDYRJ30s3KJoeE0yXS2VOxIfK7imcrT9Nx1OdkGrEwwWxTwqZ9+s/dw8aTmXVzCuC/v9qSi98jAaVRy8tqqJctmKjA3y2dV+8Xlr/1FuDt244TWLsVJ8rauwvxFNKD0D7azRxx5qCSjM+J5LUQ1T6bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071258; c=relaxed/simple;
	bh=5T+mAL2CEJGy9l4QE+/1oYzq1KiIG3eYZWzE0hbHous=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WF27kXTlkS0DbV6sROYIwOlbNSHLLNCFwnbd+SuKZVc70c5whRXc/iF/HqOEXAvX3hEDFjpQN12iUE8Ap+M7F5fco/LBzF2EGAB5GLRZT5LSyZuQ4jlEFye3nNnygDgUVDopzyADKPqFl8wSveZsXcpX0zBDcfRbo5Yr4001JIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BZpg8Bln; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77dc08db60so549279166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721071255; x=1721676055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kZSj+N1deCV/lRMl+PDJPmtWfHIJ1IZbqZ6+B38RC/M=;
        b=BZpg8Blnnf7c0j2Qwst8sJaRYM/npDGFMuwAdl/XRuu8YI1BLGm5re8jS6GKjAEGqY
         eBpwoGPAGiFLWYk2MICY00jh35fg7sxT7PttND9UnF2pXq3wAIocNi49Vgcf7NM+/Dwi
         zeUdefFgsZDLqt7azHNzBhA/akrgMDa766uVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071255; x=1721676055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZSj+N1deCV/lRMl+PDJPmtWfHIJ1IZbqZ6+B38RC/M=;
        b=Q5OMkInOaT1mnHA5qFP8sMO1NTjxP6J5Nog7Z9ZQKxa+UAtYXATUyX6OG9krvdJCOM
         HGkZwLCJIWQBGcJ5JMgVYCLHJtBJ2qe4DCSmtFbNnIoBLwS0jTjcvwhxRcmo7co3MU1M
         SpzDXntHTR79b8GdGktzJ3wK5pcoPmb1STg6uy5bnybwR9PQGPNKhvIuYvJAplcejCH3
         +eg2NFk5cB3jHVkqDXy4mHBuC76iEuRV7rZx4oElLxBiYzTBO+2SYh7AvODQFIeyoTk7
         vND50a+x0lTm5FrUm6i8Lm++NQRn9R2Zi+dnWK8YWo+Bma7sEkyqxz4yzwmC0V3P3lVN
         yohQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD+xl9VJewFeS48zgIoG9prBmGYuNWb8picX2GZAWVQOhyYnPHGeUA+PkP4iStlE+X/VhDgkewVilf8dOru1HiOMTQR9/x+zUqHCvL
X-Gm-Message-State: AOJu0Yx6ahCnysxWE172N/A1EfRcN4UhpjZ3d2h8niGn/gG08G4n82mw
	32VulwI24reO0dj+W27Kmyl6KejgNTCoby126E6PFUK2+Rlp/6gYMMx6SaYRaWBBWeUTtpPEui5
	QGj8/xg==
X-Google-Smtp-Source: AGHT+IEkrrsCr6FW551DkdFKpKvchpmqV1dIEwZweg/nr9es++GSLwBlA/mLdbPnUrBg9U+CXtasgg==
X-Received: by 2002:a17:906:7b4a:b0:a77:e1fb:7df4 with SMTP id a640c23a62f3a-a79e6935894mr54562566b.13.1721071254714;
        Mon, 15 Jul 2024 12:20:54 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc822b51sm233981566b.225.2024.07.15.12.20.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 12:20:54 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so5957176a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:20:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXumQlYkXLGKQu1Lb3G6FYDL5j8ToFJA/Pnnbl2MSdF19fO3HXyQFW3sL85D+YzejYdjfVd9cJ4S0w8+Zm5RA3MTldtP1LVVF2zM3C3
X-Received: by 2002:a05:6402:2786:b0:58b:2d93:ad83 with SMTP id
 4fb4d7f45d1cf-59e978120a7mr595277a12.21.1721071253731; Mon, 15 Jul 2024
 12:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712-vfs-procfs-ce7e6c7cf26b@brauner>
In-Reply-To: <20240712-vfs-procfs-ce7e6c7cf26b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Jul 2024 12:20:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGWLChxYmUA5HrT5aopZrB7_2VTa0NLZcxORgkUe5tEQ@mail.gmail.com>
Message-ID: <CAHk-=wiGWLChxYmUA5HrT5aopZrB7_2VTa0NLZcxORgkUe5tEQ@mail.gmail.com>
Subject: Re: [GIT PULL for v6.11] vfs procfs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 06:59, Christian Brauner <brauner@kernel.org> wrote:
>
> The level of fine-grained management isn't my favorite as it requires
> distributions to have some level of knowledge around the implications of
> FOLL_FORCE and /proc/<pid>/mem access in general.

Ugh.

I pulled this, and looked at it, and then I decided I can't live with
something this ugly.

First off, there is ABSOLUTELY no reason for any of this to be using
static keys, which makes an already ugly patch even uglier. None of
this is magically so performance-critical that we'd need static keys
for this kind of thing

Secondly, this is absolutely the wrong kind of nairy rat's nest of
strange conditionals made worse by pointlessly adding kernel command
line options for it.

Now, the FOLL_FORCE is unquestionably problematic. But this horror
isn't making it better - it's just obfuscating a bad situation and
making it worse.

By all means just add one single kernel config option to say "no
FOLL_FORCE in /proc/pid/mem". Or require it to *actually* be traced,
or something like that.

But not this horror.

             Linus

