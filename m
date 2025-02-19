Return-Path: <linux-kernel+bounces-522241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C806A3C7B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094BD1884D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852B920E32F;
	Wed, 19 Feb 2025 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H6Bktc0G"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2E1D47B5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990147; cv=none; b=DMs3KieCvoX0Fc3tH6DN5kgDG54DChHCRUylnLBzLzaAP63Gr/g3os6FfFxNJ6o//eo3YYiESWdk9SOGwCZT0QI4LrMcrYDRb+QkFJplgK5HHjRfalypEcRGUzxXzfM+g2Z2XPHxytS2R/rtUJNieSh/6aV0x2LjnHd/LjgWnmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990147; c=relaxed/simple;
	bh=lC04pkibMSnB+nQ7QRyWb5nDximsbQ0hDi5hUooIyRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnzzKYxqbWgGoZmYyB0IFHqE5uleZHVa+y1xJOJdtdPZql+UWtAojdFonP1DQKgzjpkWFnE4vk0Ddp1mIPkdHfn8W+OwZbzfsLyWodhMCHyoC4rL3tDTwG0IoKM3GC4EVtrgdZ+acuVa5CUlCo+P2d5nV4xTEPP61vUgPwGa8Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H6Bktc0G; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-219f6ca9a81so11515ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739990145; x=1740594945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+itER1h14EX5rQVkBvQ5Ol7VJuRnv/3xk34hJH8B0eE=;
        b=H6Bktc0GibkVAWQpyysC0nan6AA80IJoImEVJMoQmlJGNfI1djiQKD3uyA3FKmrGto
         iPApSHUAGd8+qOyPByIoIh1wuBL731u1pkMjKCo1NRLBuFHnFuq8sb0iF1qoEAG9XB/H
         dHJCxTxnCxwLjkSUiPo0Ypv+RdnohQecPcV/ILzHt+4VSYSt/QLo0+MCMPrEzKSR2Koa
         lOc94wzon1E1MgU/G+opfL/M6+SPLQPXmcoQRppu1SZa4ZyaF6jwy6T+oEsTmKHAFUeK
         ojr3q3fPTdX3kWzaUEzWI9FV2KaDZ8TlunXH537QiyfOleTx3ndnyHxWQy+JCiiLasv/
         izpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739990145; x=1740594945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+itER1h14EX5rQVkBvQ5Ol7VJuRnv/3xk34hJH8B0eE=;
        b=epywsp8feMS87keUA8uoH180gxLGNSVdS64WgkOEIYVT+yiTGU/CysQMwefEJ01z88
         9direuQnbL6EZN37aC+lbLD9u7mzU5bcluJil0++h8W3PBCsqW9PGzYe+ynYLzfj43s1
         Fbbyq5xaNRicPMjsykYUxj7/MKkyNGuu/6V4YtUIbPZs9lFxrQKgqlPFewgJ2IUmTjLG
         jQPgy3YCvxMxTjf9NZo+JMFXOrUJxSieM8M/vlV4VX4Qb98c1GIfEZr8mapdCCGJ6uce
         1MaSwrN2gzw5QREacq3GjDhfbepPigWAX1ctcctxI/KFoT7TWBbnasJ5SUrkigFJ15PN
         WR5A==
X-Forwarded-Encrypted: i=1; AJvYcCUedaj4h2HoRbTrnJuckpk1R0iMr75eQftvpucaT/kay2tnimLYUjce1AMfqnh9l3xSrh3iijr5q34ODzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw99qsl6bR0sXFxkZ4owWevyz54CuNnc80B2EeVlA7sdqkE0p63
	pr6XQXL/zee2P4s25HgUhq7RQVHo5wLF3fRqllbwfWymRNg8VmJICRAA7wLYXA==
X-Gm-Gg: ASbGncveHoNtmnnpJTOLAYU5irohYgVkxa085PAQijdJZATjUOzNT1cykvqbsRey6QN
	5NNH2pk5TGYOJqIkhV/pZVyf9CBhd+0ab2JfkDG/id3KnqhLmkmSVUasNL1vP0HndyMys+789yX
	37p/lmYWZIkPXRbPWwSPSlKnTazeU3PUgQf2YZtXgSCuB0jFFfF83R4G9oe4hLuM53hTln+EXhH
	6HhI3NsyTH1ziVNO2yQMxttLwv2AEmRtT2Z5FNostXvsg60L2cXRgLD9081lzWKq+ufFCnK9h39
	PcwN5p2I+g5Oz5bxkhPIMXbofMFrosE+KB1BijMxS3rnh2oHwtsyvQ==
X-Google-Smtp-Source: AGHT+IHAULCNkvzKZQBb/FReH9CykVEx+mAi17NEzYX7dKsPqX5HhXoQBs+TgGZyrNUOEtDTCkJWkg==
X-Received: by 2002:a17:902:ccc8:b0:21f:16af:188c with SMTP id d9443c01a7336-22175af9931mr3117655ad.23.1739990144506;
        Wed, 19 Feb 2025 10:35:44 -0800 (PST)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adec4756d0csm5861792a12.55.2025.02.19.10.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:35:43 -0800 (PST)
Date: Wed, 19 Feb 2025 18:35:37 +0000
From: Carlos Llamas <cmllamas@google.com>
To: syzbot <syzbot+799a2d4576c454ac2693@syzkaller.appspotmail.com>,
	surenb@google.com
Cc: arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	maco@android.com, surenb@google.com,
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Subject: Re: [syzbot] [kernel?] possible deadlock in binder_alloc_free_page
Message-ID: <Z7YkXTtINfuKY4F2@google.com>
References: <6782483e.050a0220.216c54.001d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6782483e.050a0220.216c54.001d.GAE@google.com>

On Sat, Jan 11, 2025 at 02:30:22AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7b4b9bf203da Add linux-next specific files for 20250107
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17d02dc4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=63fa2c9d5e12faef
> dashboard link: https://syzkaller.appspot.com/bug?extid=799a2d4576c454ac2693
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10302dc4580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c179cc0c7a3c/disk-7b4b9bf2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fdea80f2ec16/vmlinux-7b4b9bf2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a277fcaff608/bzImage-7b4b9bf2.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+799a2d4576c454ac2693@syzkaller.appspotmail.com

Hey Suren, just FYI. I bisected this to commit e8f32ff00a66 ("mm:
replace vm_lock and detached flag with a reference count"), which was an
older version (v7) of your patchset. However, I've tested the same on
the newer linux-next tip with your v10 and it no longer reproduces the
problem.

Nothing else for me to do here.

Regards,
Carlos Llamas

