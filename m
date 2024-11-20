Return-Path: <linux-kernel+bounces-415153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5CF9D3216
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72CC5B23C93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B080249F9;
	Wed, 20 Nov 2024 02:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NQe6d/JZ"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247703D76
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732068747; cv=none; b=mBAXAIzpAgJLlYWSi4Lh5jYrJ9A+1eY843yskAMNZR2KS+GHtAYjQEo0BVV/cC9vtkFQpjjD77j1RZYESrcyMYUeV/DLLCkKU1JQiSCcdqJkHaJjlL34mPHpLULPkyiFXtCx/7Cu47j/1sSuEspYEuJqHVyD/E8AhbjZfeLVJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732068747; c=relaxed/simple;
	bh=VXDCKncXl8a+GAqohOd37DFimyWx+9tlk7nh6totTXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=muvmymeYBiN1U7gg4HWqsOZ6p3WkBsAALuoCgbRa6jlBSsoyzwMFqSLeeNl1cDvAZm4NuNzEYRQDxAo6iMj7jyfAJadDz3fLImZXaFXqyHRvYoRfCwPlnsMRtywYGdEr0cNfjKw6Vhn/ACkN2YmKSpsGfnhu6v2hAdYGKna7okw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NQe6d/JZ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C38713F0DE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732068735;
	bh=yM4xnBGDwE+Cit1Pwb2pk+7IvC63ckGEytC7d+3QOY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=NQe6d/JZKOy0dgDGgmYpkvwU05Ydh+uN24hzv2nIQGiSV4X0cZvrTGJPruaolKhnv
	 9rCFWSyUQD242WGqqnpzFtFjgGTbhHZMsf+vZa2ryW7shLsnZwHvf8znpDgGRUpuWr
	 PdBd4QVf2+pvfE7xhkNdVdly8rfx2umdWu6WBlZr/4Yzw8J4WLbFoDMjRPx8ld7YQp
	 F2sDik1pxOXh39AoPduV+yeohtYU8gJSbK0Q34/zBpm9HSeRj6INyhMD0IzNoOWCD0
	 XFWyb5QhTg3wUtJWTKzHXFs4z2g3WomEMmpFLot019rrw1aAxI3Ng4tsmf5SXM3Zlh
	 bLKHg3YDMjSig==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7f72112de23so3224763a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732068734; x=1732673534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yM4xnBGDwE+Cit1Pwb2pk+7IvC63ckGEytC7d+3QOY4=;
        b=vXemULbacsp5rnqxbDtTF5Ha9FptTzzEPifmxnjHHof+8pa3unJW1vFhjXx7PkcGBM
         4f7h6Mvw/R1UiEoOzBnucfcJYwIiEQMADdt32o3pUL6h08QPxiUpJZN6hR48b5ep6dZe
         4S7s3Jk7a8caUsg1GxvKG17pNY9b8qt+iLZ+NWVWZNCPZzEre4u1SnYv8Mr3l4xZdztL
         8XmQsAkgli2D2qdfNIzwn12+LdAB+NypHx56lMhgfBNtkvZiq2qUo2lvnZqVNFdG6uCQ
         7I3UiKq4ktQbag/04txVSw3BbJlOP3ssfp+SnPPl02I3eRd+z36QBqZP974pQVo2I+wL
         +WFw==
X-Gm-Message-State: AOJu0Yyf9BXyjnTY6KAFmKSdxwDNlCYX6VbHmWXQstvlKB+vfjzOz+eS
	LRwTKu64Y7R8SLT72GRxYfzScAwYCKm9SuxejGjHYAJKEKsi5VnNy0kO4s7t018gQGFPo1iY3Q+
	iaTFvA6vx5/coa/r70ByueZESUidF9fwXCILu/TyH+ZFMpiAkxa7MTBsKKLC7LEi2sUdC/eRI8y
	UA4A==
X-Received: by 2002:a17:902:ec8c:b0:211:f8c8:372c with SMTP id d9443c01a7336-2126c12e547mr9545075ad.21.1732068734335;
        Tue, 19 Nov 2024 18:12:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBHJph6EyboWtyJmgnLpsZhot2uEZ1t3rZu08e1Zb6yovJAUXVWm2nJ20NG5FMbdSAf8Kr6Q==
X-Received: by 2002:a17:902:ec8c:b0:211:f8c8:372c with SMTP id d9443c01a7336-2126c12e547mr9544125ad.21.1732068732775;
        Tue, 19 Nov 2024 18:12:12 -0800 (PST)
Received: from zoe.. ([2001:f74:8f00:c00:6aff::1003])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2126f2c5ba0sm1371875ad.47.2024.11.19.18.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 18:12:12 -0800 (PST)
From: Masahiro Yamada <masahiro.yamada@canonical.com>
To: kernel-team@lists.ubuntu.com
Cc: linux-kernel@vger.kernel.org
Subject: [Plucky/Unstable PATCH 0/2] Avoid arch-dependent source package (step 1)
Date: Wed, 20 Nov 2024 11:11:00 +0900
Message-ID: <20241120021205.1590999-1-masahiro.yamada@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Ubuntu kernel produces a different source package
depending on the architecture of your build machine.

I tried to resolve this issue in the previous hackathon last year,
but the patch set was not merged.
I am resending my patches with smaller chunks.

1/2 solves one issue that can potentially produces
a source package that depends on your build machine architecture.

2/2 is a trivial clean-up.



Masahiro Yamada (2):
  UBUNTU: [Packaging] Avoid Arch-Specific Certificate Creation
  UBUNTU: [Packaging] remove unneeded prerequisites of
    $(DEBIAN)/control.stub

 debian/rules | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

-- 
2.43.0


