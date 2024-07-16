Return-Path: <linux-kernel+bounces-253735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E82932615
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A19284174
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6B21990DE;
	Tue, 16 Jul 2024 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSweZPeK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536EB1CA9F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721131305; cv=none; b=B2Kpp6eeQvm2O4DuFaROIzruGmMmTd3ol8pWVBkWkLG5Moi+iHVw5MlUEiXOUJ3vMklauZAw78ygmdSm3aSxuPVUjpzv4HgG0XExCKgZhjA+OKxtHfbtgmOVKi4iiKzOdAhqhHHFaz+70/qMBAnlm88HSz2P+MRZUdCXS4cZHKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721131305; c=relaxed/simple;
	bh=yF/VNxt1FJ1J8kZ8uWR0zCePG4D5vCSp1wx/QoH+zTE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=H25Jijm7c0Q9JXKkMlnTMfqHndDP0kmuW8RzLzquXF/tQ0Lr5AD0TsZcvlki5siKyGB61jQi1IysLcLcVm2fxRxrDLO2HSuolCqCNmlFU7kB+KdkdHAiZWXBIaSJa4utZ5zH4ayieF6Kn9ug1oZl2sBLQNMpwXi/i6SXQHbje/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSweZPeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D996DC4AF0D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721131304;
	bh=yF/VNxt1FJ1J8kZ8uWR0zCePG4D5vCSp1wx/QoH+zTE=;
	h=From:Date:Subject:To:Cc:From;
	b=lSweZPeKLfBxKQNYOSxXZcT+YxY2lG5Gc6Dw0NgaRF+z8HH90spsmePJphvbkBNX8
	 C0uk4o/0WZV4EPb9U4yAzQ6ISZ8q/9CU10t3YJwpAdU3snB0DpNVFVPkvOJ2zgVjre
	 7zjuj3E9X62NQd27tlXV/zvkh7DYWQCe+zSnBadF7nKEryaHpEX7mDIec1m4Z+F/vx
	 DdZm9CentZkPUrgpIf3IZJanfwHfLzNWGRDlUXHpkkc8RM/Cq/vn5kptLkutzc9Lwq
	 o5EWRjbptwf331IoAKU5QwKtpLptI7qXJH83S04zOgB8KATQoLz+nhglfhROjhSQaq
	 HrWdJJiJNFgog==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5c46c8b0defso2905868eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:01:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YwOb2U0fegXIyahNCP2VuOxUEE+z91zx5UsV570jqwZ+576/6f/
	bnaOaHtjHf9Df1wkxSz+1Jt0adWJXkAuKLEK+WDyPx3yK+J3eWZI/iqdsZdx+oUxiafLDxBZsbO
	OC8innGny8uzJZA5408J7b2TLg0M=
X-Google-Smtp-Source: AGHT+IEoPlk65Wr9YfqoTl1UD5/IsvHHFudkACBlXuObdwvON6VKgPpCTqantpEVwj4FZWKwPDOvdNC/INj2Cha5+bw=
X-Received: by 2002:a05:6820:198a:b0:5c2:1bdc:669c with SMTP id
 006d021491bc7-5d289eacbbcmr2336235eaf.6.1721131304217; Tue, 16 Jul 2024
 05:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 16 Jul 2024 21:01:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_M5+ZHh9aWowoOcOLtwbOpX4TtUa7ea4VcEtKTq1nmNA@mail.gmail.com>
Message-ID: <CAKYAXd_M5+ZHh9aWowoOcOLtwbOpX4TtUa7ea4VcEtKTq1nmNA@mail.gmail.com>
Subject: [GIT PULL] exfat update for 6.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	"Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This is exfat update pull request for v6.11-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit 0c3836482481200ead7b416ca80c68a29cfdaabd:

  Linux 6.10 (2024-07-14 15:43:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.11-rc1

for you to fetch changes up to 89fc548767a2155231128cb98726d6d2ea1256c9:

  exfat: fix potential deadlock on __exfat_get_dentry_set (2024-07-15
21:44:28 +0900)

----------------------------------------------------------------
Description for this pull request:
- Fix deadlock issue reported by syzbot.
- Handle idmapped mounts.

----------------------------------------------------------------
Michael Jeanson (1):
      exfat: handle idmapped mounts

Sungjong Seo (1):
      exfat: fix potential deadlock on __exfat_get_dentry_set

 fs/exfat/dir.c   |  2 +-
 fs/exfat/file.c  | 22 +++++++++++++---------
 fs/exfat/super.c |  2 +-
 3 files changed, 15 insertions(+), 11 deletions(-)

