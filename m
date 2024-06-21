Return-Path: <linux-kernel+bounces-225254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD4B912E25
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F40A1C2107F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A3C17B512;
	Fri, 21 Jun 2024 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jzaRl8Wr"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD2715F336
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718999685; cv=none; b=n+AdN3ywkeCq+nfpmlVtf4jgkiZGn3SeC+RDX3Evawwp5KyDEyX5YCdZznqef9Bgsx0gVUh/X0hfsGMy/MpgQRMX/v232MbIjs84d00Od1P5dy4/LMR37yJYKdS2rJEdM0V7ndzYPZscnbqJXloNt0TnPfzM11NDIpU8GHEmAD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718999685; c=relaxed/simple;
	bh=D3ymLZciavul1Y12MVNcx4+feyXXYgMZz6/03/D75sE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IN0r4yUdt6gSuFaHjCHLrCGmu4GozoTq41XtBf4b7oM1fLatfGJ5uE2trk2gjYImR43QDAge78gv/40r0l0ygy4cGURVSRI7dlx/88G+hFiJ6r/HLIlmkK5XNcHbKSwgbH2JHAFW2QFD54xuFXo2cHZwJMPLtcUiyp2onPMF4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jzaRl8Wr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6ef46d25efso279251366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1718999680; x=1719604480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=33jEI5/feKxqme62YiuJFqZt4cfWs+d7SXX2h8CWrRk=;
        b=jzaRl8Wrd7mvryJbCn5CX40Pe8/BJSiffXlFf/g7a5vo6zGimnPkCFrVbzWbiI/E7a
         YlUxJANtONOZOzf3/CQ1jqKezaLfzNJQ7DVYxj1TdLEFFYrHUg/fdzPCg2kkuIwGRHm2
         HkgvHeAi9eNeL8mNml+8m/Tn4n5PankPDw+CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718999680; x=1719604480;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=33jEI5/feKxqme62YiuJFqZt4cfWs+d7SXX2h8CWrRk=;
        b=fz+FEXKOG6r7CTwSRn/rPlqt4WVDoWgdFwQeLWLuJl3KMxkmxY6edISi//G1eimQey
         90ipRHd7GvjTlahluB7PF/M6KAKZA7lANzZD+9VBQ4PdgP5SpNWrS2/79LnZ6Ws80iIL
         HSt8t7Ztc7YRh334ETkz427YcD3420taZhoCFE2Z7Ar66OyeRdSLS05+7RMEqL9Fgl62
         noatac2LvnS/39uUtg5B0t20V2QKc2JGov/pC5aULVV9c64LuurXGnycFCrW2kiX8sFB
         74ihSW6Nc38xjgZWU1qaEeMYmYTyIibnd4fVG7FNQjeTQLHIrRFBwxjJsnvl+LoyDjLt
         OlCA==
X-Gm-Message-State: AOJu0YxCR/v4z+t6Hk6pqCpWblaAgezuwr49KuS/bo1CyHTTBPjwdk94
	kAECfV3ViYTPN+VuPr600BXFYUnvyv/6fRSEt15P61wCMWUr263rz1pL3Xs/TbeHJG1qmF0GhkG
	7WYg6NMCh5YOWMTitbFQwBGcd0GAYH4Ddcqzv1w==
X-Google-Smtp-Source: AGHT+IHMPxRSpeWfFETILoj83QSpeXgYk8tMPeCiUlyNTt4XtvfyTrE0PqN0dcALyeXIod8bt3F7q/kAGJ/d13yodi8=
X-Received: by 2002:a17:906:7148:b0:a6f:6292:2425 with SMTP id
 a640c23a62f3a-a6fab648959mr496741166b.38.1718999679727; Fri, 21 Jun 2024
 12:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 21 Jun 2024 21:54:28 +0200
Message-ID: <CAJfpegvm9M9Kzmtd=X66YijMOoJpKX62vuL4maD+7xBJ0-n5Zw@mail.gmail.com>
Subject: [GIT PULL] overlayfs fixes for 6.10-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
tags/ovl-fixes-6.10-rc5

Fix two bugs, one originating in this cycle and one from 6.6.

Thanks,
Miklos

---
Miklos Szeredi (2):
      ovl: fix copy-up in tmpfile
      ovl: fix encoding fid for lower only root

---
 fs/overlayfs/dir.c    | 8 ++++----
 fs/overlayfs/export.c | 6 +++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

