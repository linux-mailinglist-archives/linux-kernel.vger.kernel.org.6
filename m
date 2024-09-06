Return-Path: <linux-kernel+bounces-319382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2463996FBD4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C671F22A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E651CCEEE;
	Fri,  6 Sep 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W9zgvFIx"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38F1B85D5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649769; cv=none; b=DFh3WJinqGnIzjO00XWHxyF9/0AGSrMg5fpup/+ic3zMRvAySk5erMizjIZtacg1TfzKsMMVRICQ2dVnXUea7rPe8+x/6j3nuiqoCpW8z1LIhBXztViqrRwgCQtiUAppVIYS3yAElB5ypm91XwFJVId2nJ2EFA7xI03tpiLiMYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649769; c=relaxed/simple;
	bh=ZpmtWpVPp9dq2GktVV3nSj2glwoIu8inEvgWSWb/2Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4VPicurs5wtrDpFEon8vAx6wzkbVKiDzix/peaXtkPh0y4gM7Um3+4GqaXDkmWFfG4wouUPy6E4pUBgyn2BxtzK3fHAfTrJnpaBkAEoNtZb9HyR0JZHKSiSo+RaPEFdHmFeNt3VIuisqc4O4vPrJZj56ZkXRx+9Kp5p22Q38b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W9zgvFIx; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f75aa08a96so424601fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 12:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725649764; x=1726254564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/6eWdVYl1QcRCqz5qn6kJLzZqqJmdUdPUGOlottBiTY=;
        b=W9zgvFIx4Emmp4mj1jgcaAfZ7ZTNMVumV8pPx+julHsy+7M9wFL+kk2Fcs4lv8ipG3
         dX9CYbIq5a5iE0UPApaOTOVCZmcf7NelrHY1hAt5L1HBMBT9Ru7zBDNJigX6sKG4rJiQ
         CVokaMP/tw4LAMotLzCum8/dHtMOLcBHa6+94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725649764; x=1726254564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6eWdVYl1QcRCqz5qn6kJLzZqqJmdUdPUGOlottBiTY=;
        b=mR2Sx3+UVwqINgZnAVc0DbZkRXfAlxeayvx06RIcvbGE7ahPvHh8ctR3kou20MtJC2
         2JTAXmi+jghEq24aORx7HfTK9KHld3WT5qSpZa57/hZ1o96Mqy8TynRmXfln5jVMyTl8
         PkGlA0Jlmr+RQAu1fHoQek/OUAOyr74ZlV2mO+p1W8R9qP3j9Uh+rKtfAJRuCoQz5zDU
         Z+EsTI2OBLs7fMvoJpbeLesNgJ3i9DzO1fUQvnaGpflnXvdMh4nGIT8Ygg9tjVf2JWkO
         uxz2XA26cyS29BrRDpecv7PgW2zwNzLevYPg26f0ULi/WMVEaJKkncxGM22Y/yWQWWB8
         JeOg==
X-Forwarded-Encrypted: i=1; AJvYcCX0RA9peI4HIQGtoV52/VphreIGQFTF2+Jtq8U7z3kq5YM8ZoDSg4DDDMvGZ0i0LrxPpAhOptMjUFAcfRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcYtb9XC5ijJO6b5jy5FRxg8JmUPz6LfcHeCHzc7epucSZXPB+
	OH5u7+WoYexxgaA3sdOLJivCBseUwpu+XuEREs+Bd2S/EI4AeCJ0xW0jHtiswq3m6CmocxGfapG
	23HQ=
X-Google-Smtp-Source: AGHT+IGYRQsbnX6m5NhZCX8aBwspm2ppCdQj664T67Pj7zBJmpcXH6ki6JnnwBhWDzIi+xAQh1hsng==
X-Received: by 2002:a2e:f09:0:b0:2f3:f7cf:2f01 with SMTP id 38308e7fff4ca-2f751f853b0mr19228001fa.41.1725649764147;
        Fri, 06 Sep 2024 12:09:24 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f750e200edsm3076561fa.71.2024.09.06.12.09.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 12:09:21 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f409c87b07so29981391fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 12:09:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVgnkLZPKwYOl4kntoRGzCYgbohf98mGGiPEJw+xOCmAwqH9I8HJEqwKYit5wVRAX7fIvmaR6cFS4Zgr0=@vger.kernel.org
X-Received: by 2002:a2e:711:0:b0:2f6:2858:a0b4 with SMTP id
 38308e7fff4ca-2f751ee78d9mr21645981fa.19.1725649761251; Fri, 06 Sep 2024
 12:09:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905212741.143626-1-romank@linux.microsoft.com>
 <20240905212741.143626-2-romank@linux.microsoft.com> <20240906112345.GA17874@redhat.com>
In-Reply-To: <20240906112345.GA17874@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Sep 2024 12:09:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtMKmoC__NJ5T18TaRCqXL-3VFc6uADJv_MzgR1ZWPJQ@mail.gmail.com>
Message-ID: <CAHk-=wjtMKmoC__NJ5T18TaRCqXL-3VFc6uADJv_MzgR1ZWPJQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc FS
To: Oleg Nesterov <oleg@redhat.com>
Cc: Roman Kisel <romank@linux.microsoft.com>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com, 
	sunilmut@microsoft.com, vdso@hexbites.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 04:24, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Add cc's. Perhaps someone else can ack/nack the intent...
>
> This (trivial) patch is obviously buggy, but fixable. I won't argue
> if it can help userspace.

I think the "what's the point for user space" is the much more important thing.

Honestly, acting differently when traced sounds like a truly
fundamentally HORRIBLE model for anything at all - much less debugging
- and I think it should not be helped in any way unless you have some
really really strong arguments for it.

Can you figure it out as-is? Sure. But that's still not a reason to
make bad behavior _easier_.

               Linus

