Return-Path: <linux-kernel+bounces-259774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEEE939CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114C31F22386
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5A71370;
	Tue, 23 Jul 2024 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zFBJIfdw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yedtE57u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC614B082
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721724695; cv=none; b=JeMb9wkKY14XvhYMM8C436UjM04W854ZXM46LGASpEzwXHN0yV5TXo/F/5mcxcFKNNietwCnKXnMFkaJdGI8oluKbsv3SO40Hro/t3D9UH+IVRTGQRlsNpkF9roeU0DbYfnZXM4gScuVVGBOBVx9x8/yWIY1rC+d9Fyxq+BVqtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721724695; c=relaxed/simple;
	bh=R5nbUBAam24lL9Hj9Ug9koQfHaxTKJowl3H2R3jP2jA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q/6UlWULdQVAIgxJT8s3wJ6chn2bSg5UyttQkvdFR5iqXgdYX7wQPNbK57C+Gg7jzxfKruxg7JC/Wb7qblkfB9HXCliw44grSXMpCRzXTUp3w3W7oNzq3QDZboYy5Rg6nzbC8/64t9ibB976oEeZqkzHIXK5qYilmS5aKNJMzvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zFBJIfdw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yedtE57u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721724692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhYKCSmmg5VBsMZtToJS8gM39su8qOABRac7d8uBmPI=;
	b=zFBJIfdw94b2fgBBlZIJV6XcWoUpg6lVkT7RUaei5FSQ7DtAsVGo8xPIQLOBdELAxa5my8
	LAvcITPWb13wBq2MjQQyFCh4dufGP7/S3Teav5HxAcrqvv+vMmz7SDQhfSWYkwcppCJy0x
	3Ra+gu/DbsvV45LyPvuR/Oki6y93mEP12KwusfPrtBEaqg6Yr0uH8+0vrtqaiBPnKWOAiC
	IypVf+IP5HD942fWHzyuC/z4nCbPfv4h9e0D9N+cxQiZNbs+pW2Q6/o/iFrL3X5gBx6LAg
	ARyuf15DB9omR9iGDCssqCCUbLts0NylVihJqZWADkpBy6XQH6dHq4OEuLVhnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721724692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhYKCSmmg5VBsMZtToJS8gM39su8qOABRac7d8uBmPI=;
	b=yedtE57uWkDQJj8718dvtow18T1EjQ6tV+AgO+YfLChwBMNDvXwfopNswMJPUAN6dWWvWD
	CVm0YG17Xv8du4Aw==
To: kernel test robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 11/19] printk: nbcon: Rely on kthreads for
 normal operation
In-Reply-To: <202407231117.SngBfEcI-lkp@intel.com>
References: <20240722171939.3349410-12-john.ogness@linutronix.de>
 <202407231117.SngBfEcI-lkp@intel.com>
Date: Tue, 23 Jul 2024 10:57:32 +0206
Message-ID: <877cdcbiej.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-23, kernel test robot <lkp@intel.com> wrote:
>    kernel/printk/printk.c: In function 'resume_console':
>>> kernel/printk/printk.c:2706:3: error: implicit declaration of function 'nbcon_wake_kthreads'; did you mean 'irq_wake_thread'? [-Werror=implicit-function-declaration]
>     2706 |   nbcon_wake_kthreads();
>          |   ^~~~~~~~~~~~~~~~~~~
>          |   irq_wake_thread
>    cc1: some warnings being treated as errors

Thanks lkp.

For v4 I will fix this and also rename nbcon_wake_kthreads() to
nbcon_kthreads_wake() so that it matches the naming scheme:

nbcon_kthread_wake()
legacy_kthread_wake()

John Ogness

