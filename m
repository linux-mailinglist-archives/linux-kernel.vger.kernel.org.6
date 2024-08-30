Return-Path: <linux-kernel+bounces-309019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29332966543
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E41B1F24F96
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5E71B3F0A;
	Fri, 30 Aug 2024 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VSO3OcBh"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F23419ABB7
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031350; cv=none; b=gWG3gBEw9cDFp00mAQxd3pomNwh0PhJnlMZNl3H+7594FqNM4JispEvnp/gTCSQcE5rx/5Yf5g2SCVh5lH0kGwdr/aOkikcpbmcyLGiEXQqG0fO4r7Hfil5RQcqAuzK2KquzP8PcrKCtQ/UB5luy43apXVGR7Q+wytiq5k3HRws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031350; c=relaxed/simple;
	bh=H4RYLvcr39BN0rzwnNHM3KFnAYMZpv20paMKOn8qAv4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=ovdGv8a5/8DZv5Ccj63R4pqkTpW3pHB5XFsXcIZxSUSUOATPph0XWhkhvWyzHQp23mZL+s6jZWXqJ04UgbM7OCIm3tj9KNb31PppYjnJUavHbpWTQup4rYmY6BZqO6KcW5499ByA7mtwAhfp1eWBHEhJlrbziW0pqvlCO+bHEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VSO3OcBh; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a8160a7239so42168785a.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725031347; x=1725636147; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYVTJeRzzAJP9TM8I5ujnHMS7FA/up2ERsbsPl7BVDg=;
        b=VSO3OcBhe3LcOp2sPZDJmVA3FdGZ9erZboHwLWnR/8GKdQXHYqadoQBaxR4DTd6pKy
         x9xy7U0RuROQfdGMo48oux1adONmPQTvmkp/KFf9Rvio78SrxDUkQclTlV745eGJmncx
         /vnfBoHaWiwZXDitTDs5hYD+uSvxHYu6RcgrRQqOVgsYOsy3lEzO2MaOoLs5XcxRU16a
         n3kgDuV8/Z8QPPxdLiGhqr2AtIvK/eFl588iRWI3yKYLbp3eLaJad0XssZjeTZfJBjQC
         cuUxzFJkUYV2CcxGIcMSI0E0GaeLsbOaV1b7pfRauf/BKUztrWtTir72S6u0boExKtsF
         sZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725031347; x=1725636147;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYVTJeRzzAJP9TM8I5ujnHMS7FA/up2ERsbsPl7BVDg=;
        b=KN34WLzWFUKl45En6Gebv2Np69Quj0pzl8BynM/u8JNrfUMOjheVLGUuBPu7m1r/+P
         wwbJVbFrVt3huyG8dvEzq8Q9vXUbNQaZMrDR8fDKO/YTKMYenYJulRXh/IG2F6/xyZbx
         uHcZvYkhUHzZvtW2VRK+h0YRPXgHN6S8Ym/qe6D827m8EzJpuUYUJoFfMLz3hwXcGAFB
         kPq5Z8EZYD0chjXzDThuqhraKdzARv4fRd0KUcJXi/pfqDMIemDx70kAWAatU7TuuKKZ
         FkxfnhyvtqlwelGdyC9+4gBCpEG7fOWfT420EBXShAhETcFlzLOeGUlxDIzSdEj7oeHs
         8ZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2vc8qdDx1lmjUaSN/AP8I5OQ92LoAWNhPhh1t0VCb/CmB/vvXWNmET4r9pctaTeLVJ771NhoJqHihlPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1UchozVBDKjGO6NAihJS57kpxJyN2ZQva4Q0zJBn0CM4I30Ni
	sTR8nAFWRmiWYS41+JnouRnOyC4DiHIhKRFgxw0s+fq5EaaqDO3YioZU3YjWGwmbEDti5/C/Zgw
	=
X-Google-Smtp-Source: AGHT+IH1VT5+1RZLWoTApOI6xYRPV2CewJSrq6PlNvChkaFBl6YHH4QQn1Nd5pdyQo1ugjODpSbEPA==
X-Received: by 2002:a05:620a:44c8:b0:7a1:d6e4:d83a with SMTP id af79cd13be357-7a8042b9fc7mr786119885a.69.1725031347425;
        Fri, 30 Aug 2024 08:22:27 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c49bf0sm150656585a.54.2024.08.30.08.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:22:27 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:22:26 -0400
Message-ID: <44172f0b7c57b1423cccfbbdf7b6518c@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240830
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

One small patch to correct a NFS permissions problem with SELinux and
Smack, see the commit description for more information.  Please merge
for an upcoming v6.11-rcX release.

-Paul

--
The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240830

for you to fetch changes up to 76a0e79bc84f466999fa501fce5bf7a07641b8a7:

  selinux,smack: don't bypass permissions check in inode_setsecctx hook
    (2024-08-28 19:12:44 -0400)

----------------------------------------------------------------
lsm/stable-6.11 PR 20240830
----------------------------------------------------------------

Scott Mayhew (1):
      selinux,smack: don't bypass permissions check in inode_setsecctx
         hook

 security/selinux/hooks.c   |    4 ++--
 security/smack/smack_lsm.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--
paul-moore.com

