Return-Path: <linux-kernel+bounces-312722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 445C2969A52
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D6F1F24097
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD531B9850;
	Tue,  3 Sep 2024 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Tzkqhswi"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63B11AD254
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359910; cv=none; b=B4MTTCPFb9gNXRNVFE5GsOGbuUgQfAXn4gvysbwjvbwquHnE9w6XWscvmXtAemA+jVSXW6l5XOyGeyAcpny0wHXXBVXsIbUelMl+oeMfOD8oADvtCsDs9RKNixzP4V8T3eCD1DWs35Y2JnEWLSVZK7eQZIoowXIERGYsmW6Y1Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359910; c=relaxed/simple;
	bh=IpGzSwq01bG+uYW7sy64WUAjjUCeEmCuQYp+d2Un/3g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mQCe4cgI7w0WmXxDHjWdqhICWzJ51H8XuSRrne5CqlxBBcqXgutT+0d+Qd/Q97aF3ec7ZAp77yV9KLpfoIIusc3gHN26rZ2AeLq0eOpok8E20+YW7POmVwLfk2xJN1Zd9INv6+8y9po2q+CDkcL22PNiyQZk1ecASTTPfhSJbGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Tzkqhswi; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so1679945a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 03:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1725359905; x=1725964705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x6Q3eYsITfxnypFGe3Fw8XAGNfc1A4gIAvgZwhL1hhM=;
        b=TzkqhswiJyPfyWbn17cwB069DGFnsjSBtKg8sadpF9TKTq6Ckj9poG6UTDt3+j0j8p
         MduwXVv4ChD6/QgIYaZLPuxLmR2qSA4YiwrXWMB7iss7D6Xv9DHXi6moZJbokt6CDvtv
         wk8C0xNM3U5qMX7Aw6gqAkkKizYwfhJ7VO7fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725359905; x=1725964705;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6Q3eYsITfxnypFGe3Fw8XAGNfc1A4gIAvgZwhL1hhM=;
        b=qHLEHkU8WJ/MLnNkoFOaPBRnh2jo2FFJq8ouVSKwH1Jfep6HDDJWR7UuB/LtWjUX/G
         yTIUZ21RJNGif8rib/O2ulpuHEdAGpryZtoOdF2S8kR1FvGQX0+yHbsrhKC/GgLWV6nV
         l/oES/WynvqdJEnDmIB54hIp3L4lYeZnd4UOvnURl6nRiOGyhAEmhvgnJV/j5APfljzC
         1PpesAICWTJFyXxya7q5TnNiJuvTafU9mYcSuURAJ8pNPWNkK3jvKmbed9fV0UIy+nt5
         bdRATTAJZtCHwUMRYyEd/ZDe61bfNm/SQD0mWB6Ad76VxMlb4beB8cEwr1cUpc3hBxO4
         IIpQ==
X-Gm-Message-State: AOJu0YzZx0JGHMnlVkvSISp+69NPcx9fFNfY4fnyibcqRFcNW+7do06F
	OihY6uUYd2+tSebvzQ5PF+w8GEkIFGjr7p8EL4blXqyUZ7mMNvFeuU52iAyKIBBzYNntSECbMHC
	hjofLJZ/0NlaL+oq8DG6kJR7Ub6PKzfhjxJIKP4Q2b3meZ/nl
X-Google-Smtp-Source: AGHT+IFyKzm67wu/yuibz5w2254/bwCWTDvbeXT90It4zB3i/dkPa2pncQBbDsLbh40dWyLfuTt29muGncb2pj61WDo=
X-Received: by 2002:a17:907:3e0f:b0:a7a:a5ae:11b7 with SMTP id
 a640c23a62f3a-a89faf995b5mr469332766b.49.1725359904279; Tue, 03 Sep 2024
 03:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 3 Sep 2024 12:38:12 +0200
Message-ID: <CAJfpeguT0XBxBCzBrJqS1LLCLmEahVT3FF0NZ1nkAKMRKWpyfw@mail.gmail.com>
Subject: [GIT PULL] fuse fixes for 6.11-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-fixes-6.11-rc7

- Fix EIO if splice and page stealing are enabled on the fuse device

- Disable problematic combination of passthrough and writeback-cache

- Other bug fixes found by code review

Thanks,
Miklos

---
Bernd Schubert (1):
      fuse: disable the combination of passthrough and writeback cache

Jann Horn (1):
      fuse: use unsigned type for getxattr/listxattr size truncation

Joanne Koong (2):
      fuse: check aborted connection before adding requests to pending
list for resending
      fuse: update stats for pages in dropped aux writeback list

Miklos Szeredi (1):
      fuse: clear PG_uptodate when using a stolen page

yangyun (1):
      fuse: fix memory leak in fuse_create_open

---
 fs/fuse/dev.c   | 14 ++++++++++----
 fs/fuse/dir.c   |  2 +-
 fs/fuse/file.c  |  8 +++++++-
 fs/fuse/inode.c |  7 ++++++-
 fs/fuse/xattr.c |  4 ++--
 5 files changed, 26 insertions(+), 9 deletions(-)

