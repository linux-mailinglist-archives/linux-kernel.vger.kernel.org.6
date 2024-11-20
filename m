Return-Path: <linux-kernel+bounces-415769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE0C9D3B21
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAAAB23B39
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A578A1A264C;
	Wed, 20 Nov 2024 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QevkqON+"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBEB1DFEF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107203; cv=none; b=STBVlTDeG1Qu7vRb8TJ8eXbXwdQU7HCvCzfyj4YKbV6cjWYix4CZBrQmjhD0L9wIOc8QYettLu9Mbs6SljusuTYQ/4fUqkToSO4HRITmVQD7Mo9c18EFOVaMgYBEOyI+0j1Nr/6JR8l/v+Bb4xnTk9cFJrVE+QdsErocGe6pJSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107203; c=relaxed/simple;
	bh=F9Te5iApYViZNQN8tuE4vMqrU4G8ZAPqsO9ECiKR9UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEY9x2rcKrPa3C0xrEj6MkUMPl3j6DZyz6vRbBR9GRC74n+fMd0vbxtFtk/FL2e9JZcLRTGevO/9MGwvfEQkNwNT4pVTIAln/4rV1zBMFG4tKxRNwyzwOMFgOlCsDiEjAJaqOvfLatfL9Vrf51yTvTTsWvmUZVDEHV6PsW9SCdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QevkqON+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7edb6879196so1509804a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 04:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732107201; x=1732712001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9Te5iApYViZNQN8tuE4vMqrU4G8ZAPqsO9ECiKR9UY=;
        b=QevkqON+Z+Cz/S+l0v0oWChtpgbw7hyjFKYpybXfXLTJaiT+aBvfYXQyLFcWbVMRcM
         9jiNANWQmj/a5k7Twc5/bjbt8vCHnEusvROiG/SC3Hvty0ri4wT5gI2PeaDchOXp0ICP
         adwmjI+lHRd//q9FyqjqcYzSUQmk+3qgAIKQnpUicwJ1H5mgANh+3ZF9I/UWC26dAkhi
         c9mRvGC/ZIjx3AdRQiN8C8afEeS56iEy5OdLOW5wHj+aiED4KDwp4Bf9UgImlD9v8sW7
         fe33OaxkOYReV1Yq9Ke0Ha2Cq8/96KHgi1Cc36rPt5iY6wOblJQTcr+qcHovCooLnb0j
         5Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732107201; x=1732712001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9Te5iApYViZNQN8tuE4vMqrU4G8ZAPqsO9ECiKR9UY=;
        b=uTaba35XvW5WLNjh+sGQlv5tGlILVOZgBVWKl/fv/gAUiSH0AQzZpge8hZv84D121+
         ZA4+8A8SVJlAWpFqpk7Ji+0r3U2iVZa4sTf6jd3HRtoEH7dz1xLS2ctg/zphf0Dw33XH
         dMTQZndjW+jRxiTgnmU73ZnR2YOXQgiRhnVKzc3H5TLWpwsI1Hi1Yv3ci5FarBT/mBIT
         sr9CeI46nRY/62IMULyT5g8Hxotvh8O72dhb6HV3NSIPm0zfnM2GsJoKZv9BAoy/+Y0f
         3Cjv/t4qAoyOsN4dkklwr/+1PGy5d7heNYeUP0GnKKwfcD0ecHweLI2M30NfuUn8V3iW
         i0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhAZGAGoczf6mNh6CP6QAeKV8Fh0uNvPfya6eB/+qgWbhGcdnA53kgAHmlscln6V+8GaOwqde0+oaNLjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMauCT/UF9A4FKwNIFLalXmNQzpxaNGmNNhusveexc8LWB6f7R
	c1wyI80/HARqJUDtBMW0e+wEF3WJ3+BZDUToacWKZHoFNwmXjuSd/FtEZIk/6RQLS4qm3kMVhWp
	nW+P3dxrLddBQgJkjNI6bo8l88vA=
X-Google-Smtp-Source: AGHT+IGxlGScflFEWFxue57cGWUuUpK2jC1OSldqUdJhvVk7aH6ReiDCAInDNJesatOicuMeItMPKhqf5Q5NN3nIgDE=
X-Received: by 2002:a05:6a21:9989:b0:1db:ef2f:d6f0 with SMTP id
 adf61e73a8af0-1ddaebcdec3mr3819288637.19.1732107201131; Wed, 20 Nov 2024
 04:53:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-fix-dereference-null-x86-sev-v2-1-7e637851dfe2@gmail.com>
 <20241119210336.GEZzz9KMiZwf6R9hwd@fat_crate.local>
In-Reply-To: <20241119210336.GEZzz9KMiZwf6R9hwd@fat_crate.local>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Wed, 20 Nov 2024 18:23:09 +0530
Message-ID: <CAE8VWiKQ4fdeBeoWbGf55QXaqHrEdSCxo5qTJ=S2vKVd5W1scw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/sev: Fix dereference NULL return value
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 2:33=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Wed, Nov 20, 2024 at 02:21:13AM +0530, Shresth Prasad wrote:
> > Prevent a NULL pointer dereference in snp_kexec_finish() by checking th=
e
> > value returned by lookup_address() call.
>
> Can this really happen?

lookup_address() does return NULL in some paths so I do assume that it
can happen, unless there's a logical reason why it can't (please let me kno=
w if
that's the case). I've also seen it be checked this way in a couple
other places.

>
> > This issue was reported by Coverity scan:
> > https://scan7.scan.coverity.com/#/project-view/52279/11354?selectedIssu=
e=3D1601527
>
> I can't open this page - all coverity folks: you either describe what the
> issue is or don't bother sending patches.

I'm not sure why you can't open the page but would it help if I was more
descriptive in the commit message?

>
> > Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on=
 kexec")
>
> So I'd hope if you report a bug against some patch, the least you could d=
o is
> CC its author...

Really sorry about that, I completely overlooked it. I'll CC them
when I resend the patch.

Best Regards,
Shresth

