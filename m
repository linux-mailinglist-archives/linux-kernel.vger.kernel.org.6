Return-Path: <linux-kernel+bounces-186889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE5D8CCA6A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BFA1F21EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988521C3E;
	Thu, 23 May 2024 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8k4/FYS"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A42BA34
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716428754; cv=none; b=QNgG0knRM4zbc+SKt/r+1zR4MDshU2DSTlSy6MuvGYmQtNeAWkEHodxgPGPZuJuIYBqV3N813d3sVlKdLx4+eYSqx5SlqfnzWw5jUCuyvLeCuORy8XcTzBq95PjcH7KVjn6/05KlxdTpq0YCXLD83C2CprzafudSt12lnt8sKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716428754; c=relaxed/simple;
	bh=jxZtMhUdnJx/zGHULiYyTgOvORYAT1DV7mt/OghoYso=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jn94NJWHF/OarS80Qy/BPk1K0Qkp1oAavUXVs4af1e08TTJ9G29n2cNlFaT6tHoiP2q3oJ7S9A8BQnzvdjeb6PnM4J3UzYKI/vrZBTIYPSvr0eKZI+wmD38syXa9M9dzLFytgfgDsI1uX616sFfVoQSUpSm9I2fxFrd2S/M6YbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8k4/FYS; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7e1de4c052aso104702639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716428753; x=1717033553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o8roWRztlDKuXSQ8oPu1ka3tEPYb3RZ6tO+a/lEDnXs=;
        b=O8k4/FYSeUVPmhTwo4K1K6dqKXOZuX2HL1F8lxXeIQb6UY7bWJoJdCsHBtJ3wmNihW
         UX2reDMPrSpDj9JrxVyDBMPM1ronlCrEslGiPBX79Wga1mwl0aoFCG60pP+Qf0Knp29t
         GJsb1EoLzoblL6eMrN05WSMGZRFQnRTGWKx2Yi94KUKx2eJdNXHH9tItcFwqX3hEUpOd
         cgXNEZtABuWT7RI84WghQvWJnhQfeuOvMpuWayZoKKgHtmncX4z0EPAgUBhD4kVK+gAs
         FO2SXa8+pP0Teju/vP91/giiykSJ8JA1CYxp4VSOmVGg0V74LRUdHzp6v9Co12Xh2iMu
         fqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716428753; x=1717033553;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8roWRztlDKuXSQ8oPu1ka3tEPYb3RZ6tO+a/lEDnXs=;
        b=eqgITa3IWPvDtmfjrmrXwXOItFpB3JJoV4quGup2y82Ud6qg5LNQ32Btz1jK4UjWUo
         8FYerax5xxhCEHQ2ezS87PnidECFZvFCnW8RAMW/g4DlI7QPMKE2v0PU1qiSnViDzDdi
         9M+D+OCoDLU024Ma+CDWP1si7R9chcfiFmcpzJwIH6IvKaZzN5kxC7ORjRvVuCkoj0m6
         bIBDwbfDlg3Ymjevjgmu1Uf76heqh3qugxtJvd5vBubQJXESbBRlPdMnGaw7ASNFVb1f
         cjM4BC5mRBTMnM4MSjXNaAnnzFc6BG4TKDG3ASzbqCUdL08w/FyrM9KBfvv8gkOQdPDw
         StGw==
X-Gm-Message-State: AOJu0YwiQ96RrCi6yhoTKFQchs6rovFRSSGEYRJqcTtGJqT/0H4Fvs9y
	tghyaID/dbfdPJUNjWZGiGGoBZLEuAXN0wrD8LhCe2ZSwUnZ6lBvxkJE9OFgnY/1iHtn6rmBEmR
	G8g==
X-Google-Smtp-Source: AGHT+IF2M/RdROKrFMn0Ni+VNZLbZYQgcq3MkRUDJmjq4f4HXYllx5BlSggggmRK17vJjne16BJWG8S045M=
X-Received: from avagin.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:b84])
 (user=avagin job=sendgmr) by 2002:a05:6602:3408:b0:7de:e10d:34e9 with SMTP id
 ca18e2360f4ac-7e3a0ca1247mr15866039f.4.1716428752856; Wed, 22 May 2024
 18:45:52 -0700 (PDT)
Date: Thu, 23 May 2024 01:45:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523014540.372255-1-avagin@google.com>
Subject: [PATCH 0/3 v2] seccomp: improve handling of SECCOMP_IOCTL_NOTIF_RECV
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	Andrei Vagin <avagin@google.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

This patch set addresses two problems with the SECCOMP_IOCTL_NOTIF_RECV
ioctl:
* it doesn't return when the seccomp filter becomes unused (all tasks
  have exited).
* EPOLLHUP is triggered not when a task exits, but rather when its zombie
  is collected.

v2: - Remove unnecessary checks of PF_EXITING.
    - Take siglock with disabling irqs.
    Thanks to Oleg for the review and the help with the first version.

Andrei Vagin (3):
  seccomp: interrupt SECCOMP_IOCTL_NOTIF_RECV when all users have exited
  seccomp: release task filters when the task exits
  selftests/seccomp: add test for NOTIF_RECV and unused filters

 kernel/exit.c                                 |  3 +-
 kernel/seccomp.c                              | 38 ++++++++++---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 54 +++++++++++++++++++
 3 files changed, 88 insertions(+), 7 deletions(-)

Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Tycho Andersen <tandersen@netflix.com>


-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


