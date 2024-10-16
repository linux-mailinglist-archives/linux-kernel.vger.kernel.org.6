Return-Path: <linux-kernel+bounces-367639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 765339A04C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2261C21A27
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDC62038A4;
	Wed, 16 Oct 2024 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q11d2sqi"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26C0202F63
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068835; cv=none; b=K5iksh8LF+/cu3HaIv9etkwKi59vRLGcPq9B0jgLzYZuRJtlx4/E0U3vDupokzI43dTYNSAb7UTKt+Au8rwnsLGZBvfeO44Yi73VDY9sIrQZkbsvL8KaT3Jf32t3KeM8byqWvHu1Nr8qMkmGrUfZp8telv1KsRm7pcUoqMr74Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068835; c=relaxed/simple;
	bh=KjVZzmWoOZi0AVt/iqayQl/WCQShRuWz/R9g7SY/Dbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5cltQPGQByG/yXJaA/kmD8T1ybEczZUQnAZ3tTKe/YJ5un9Nty2T6tXoekTGZZFtN7g/mBrwqhteohGEviu9xViurt9N34hI92U8ptDvxUvcD1BSdoUm888J++lkAgJvZ2grO74y/2gQzEJU8k5IxPdhFDIZKtAY+Wa+2H3z9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Q11d2sqi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso46037205ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729068832; x=1729673632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gir7xpD8ugj+DDX82DlQedD4jsgaIYC7WShYsyRR6aY=;
        b=Q11d2sqisuuhn0y5XTODlm/ZJgZXvCLVAjLA3K/5cfeT53P6Qgx7L47V9aBWkE/o4O
         8PYXxeQe8qpc1Q/F8NB+rg+uQis/eB+EMZ7X87azwyy1MY+9Ys1V//NwmOgoomDqpnx8
         5OGHnoWCoheqomXuhMX2YIwJ6QatqclUkB5OKDth5ROLAMlkJ3u1IshcRSjcaSh2/PA9
         N90tYcyVNKKAZD8W+5HVrPT99tWsvD82GJNzZoUPYyVugEt0LiNc93sSiY5w0f7X9y95
         8v0TFDS0a38l/Ong/OS7FoEZGA04DjZiz2AJoDa+/qet4R8Diiu7Ym2ZDpDHYLMpn2rJ
         yK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729068832; x=1729673632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gir7xpD8ugj+DDX82DlQedD4jsgaIYC7WShYsyRR6aY=;
        b=vTMtF1iqHsQS1vq0Z7lIVEe2MiosMhFBq0MGQ13I6lII9zjYo767dczEcmVcDkIXax
         zDjpkRl41k4/n7dyyIT1gbPRfSacM2+s3ql6dlcpPHFx0+kHd0eWvK9pNWuuom4PWIBL
         jB4n0Bu66WQXEpbh52ggJ78oqeoSo9aNuE4yxLG+3KWqgL0t11YW821Vj+/6jMOcCrXA
         s+UVqpVY1VTo2ghT+O1hSWICW71creimEnBMUwF8qKIBLZ1I7/kyRkgUsJhu4t+pGNSy
         cSp4Lc7Vt9vwNVa3/5nBkKvKGtV54hvWy7sxGwNxOUzivuKUbNVp8seExO5ANzJqtm/P
         Pb+A==
X-Forwarded-Encrypted: i=1; AJvYcCWOoebqrS4VRadYa9x/R7TxV4wxXgRi4fdUEcFm06E1+nTIt04Zzw+n9cH0ScxlKNknLjLIK54plZogRoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEBrDx/kn+nHVp2QuPO3ZiHGzRiLrYxfP0py6FJ0sxSCF/hZYB
	xOsfEBEuaBd07ovKrkQru96hkUEJ5LKEXKGuvjhgle/prV9SOclyDUQVFM6CvzE=
X-Google-Smtp-Source: AGHT+IEVMm7X0AVlDzVsyiRLmaVcCoisbwqSGsrNjL5NMGRC6KolcJe58ILg76KsUXeoN8sgY5EwKw==
X-Received: by 2002:a17:903:40c6:b0:20b:5351:f69a with SMTP id d9443c01a7336-20d27f3fae7mr43412215ad.58.1729068832048;
        Wed, 16 Oct 2024 01:53:52 -0700 (PDT)
Received: from GQ6QX3JCW2.bytedance.net ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f84e66sm24692955ad.18.2024.10.16.01.53.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Oct 2024 01:53:51 -0700 (PDT)
From: lizhe.67@bytedance.com
To: peterz@infradead.org
Cc: akpm@linux-foundation.org,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com,
	longman@redhat.com,
	mingo@redhat.com,
	will@kernel.org
Subject: Re: [RFC 0/2] rwsem: introduce upgrade_read interface
Date: Wed, 16 Oct 2024 16:53:45 +0800
Message-ID: <20241016085345.46956-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016080955.GR16066@noisy.programming.kicks-ass.net>
References: <20241016080955.GR16066@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Oct 2024 10:09:55 +0200, peterz@infradead.org wrote:

> On Wed, Oct 16, 2024 at 12:35:58PM +0800, lizhe.67@bytedance.com wrote:
> > From: Li Zhe <lizhe.67@bytedance.com>
> > 
> > In the current kernel rwsem implementation, there is an interface to
> > downgrade write lock to read lock, but there is no interface to upgrade
> > a read lock to write lock. This means that in order to acquire write
> > lock while holding read lock, we have to release the read lock first and
> > then acquire the write lock, which will introduce some troubles in
> > concurrent programming. This patch set provides the 'upgrade_read' interface
> > to solve this problem. This interface can change a read lock to a write
> > lock.
> 
> upgrade-read is fundamentally prone to deadlocks. Imagine two concurrent
> invocations, each waiting for all readers to go away before proceeding
> to upgrade to a writer.
>
> Any solution to fixing that will end up being semantically similar to
> dropping the read lock and acquiring a write lock -- there will not be a
> single continuous critical section.

According to the implementation of this patch, one of the invocation will
get '-EBUSY' in this case. If -EBUSY is obtained and the invocation thread
continues to retry instead of dropping the read lock and acquiring a write lock,
it may cause problems. Of course, this patchset only try it's best to achieve a
single continuous critical section as much as possible, and there is no guarantee.

> As such, this interface makes no sense.

This interface is just trying to reduce the overhead caused by the additional
checks, which is caused by non-continuous critical sections, as much as possible.
Rather than eliminating it in all scenarios. So would it be better to change the
error code to something else? So that the caller will not retry this interface?

