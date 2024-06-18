Return-Path: <linux-kernel+bounces-218472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB52790C05B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987771F2235C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C8C5221;
	Tue, 18 Jun 2024 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PTTn2YzF"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E646617F3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718670969; cv=none; b=uC00I5Seg0NsiRo0JUCOjQzLkzuEzS8z0ub3LPSX8HejhzATg8PYm+iOqhfS1w9Be2MrfybEnQaj7ZOSjnLnxu4wqroK16EKeU2thfC6d9J0RVMbYgV8FeCep88OeMwGudSZCcjSY9zJ/hM0/urse4S6z0vDuhBTfesqOvrEZ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718670969; c=relaxed/simple;
	bh=9px3wyebkBbJYS658unJTN3zeUWI1tlbu+B04rK6Re8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbT6LsKYLnZRUQi43dM7C1DsNIZ8tC8CXcp+dVuvv1qjNr0hX6OTxNKE6ChnC3myi9eFka8cNHTD2EEURHk10mNSXc1MiZ5ZyBV1iNbY/2M5kLUwZ1RL0sP2JMJ26VtvQHFgKSPGq0P6nq+LO2q6u4EsmAAztdbJG1ds/FqbOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PTTn2YzF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7046e87e9afso3906657b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718670965; x=1719275765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EAmTQGDwnRoUTYe26zjjCbDBySNjpTqbxdCkAqrJzA4=;
        b=PTTn2YzF3zaNb0P7jmffuo1BD9Q6GUM86+KXoMrBMs42OgTx9lubGX1aFoHn1sKmj7
         rTLi7oMyC/GevRwKtIm3bDp55RKTZxF4Nh+VjJyA3cXO/kCCv34AQ8nZuoiIZex4PHl9
         p5jyogkWhmomV8aJbH1xNcRnWmfQRJ/Zm0zvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718670965; x=1719275765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAmTQGDwnRoUTYe26zjjCbDBySNjpTqbxdCkAqrJzA4=;
        b=AfX8TrrCPg8VdsDGxYo/EuNw7M5A/NKSD5ioAmdG1ylamHHVQmwPxzq17MxzNf/bXb
         1qcERTzejmO50m6EX+dVoTTTSFgYMfN4gr6SHMhAnSJncMq7HXAW1uZGguyWmvfmiBxZ
         32eZkkn9wCOXiPCi9T4jw4pucybZlDjapwOILY0jd8GXu7AoSGIZkQK6jW08VugiV77F
         ff+68vqM+6zXv3oTjvGUJEhp5UZZKD1E137YgAYgUydcFNGfEFABv0FEkr7l/PKwrr67
         aWiN2K4FLPNRwB88vgwjVP/s1GvvzTLOI14iPY+kOYbbAXOZwrS6RU07FJJnMLJPlou4
         t0ug==
X-Forwarded-Encrypted: i=1; AJvYcCVI6avka7OpDO+GBHQdc/YDmQwwj/I0a+PKwo1krnDTjjjucg5DO8RogmvnuBrL6KgXBWIUnsnoKJyoZ6N1W2j7A+xE2NH8Z/NJZVym
X-Gm-Message-State: AOJu0YwmDdqX7Leor0ofSNkO8lTvU6BxUnpWLzVWvWxFt1iKXROOGZcK
	Nhohwzks+GTK+36+Hast735a9KOvtPGlTDLj1Qvrhrx4n94Ot97mYb/hAJYZhVjNTmdG+KWFAKw
	=
X-Google-Smtp-Source: AGHT+IHMNUwf5V0/59skzGTiBwg0s5Cu2tXWTY9d3on5TY7byFeiOmGlppfKSTCNe4S1l2n9pqUGHw==
X-Received: by 2002:a05:6a21:7884:b0:1af:86da:3f7 with SMTP id adf61e73a8af0-1bae7e224c7mr11021501637.4.1718670965170;
        Mon, 17 Jun 2024 17:36:05 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1798:e71b:11ad:8b94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb99f4dsm7905917b3a.216.2024.06.17.17.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:36:04 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Douglas Anderson <dianders@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] kdb: Add the ability to read iomapped memory via kdb + clean up "md" commands
Date: Mon, 17 Jun 2024 17:34:34 -0700
Message-ID: <20240618003546.4144638-1-dianders@chromium.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The overall goal of this patch series is to add the ability to read
from IO mapped memory at the kdb prompt. This is something I've long
wished to have but never got around to implementing until now.

As I tried to implement this, I realized that the existing "md" code was
a bit of a mess. I spent a bunch of time cleaning up the function which
made the ability to support iomapped memory atop that pretty simple.

The cleanup code here is not quite a no-op. The "md" handling code has
some esoteric corner cases that it handled and, as part of this, I removed
some of the weird corners. I have a hard time believing anyone was relying
on these, but if you think someone is then please yell.

Also note that it would probably be good to add iomapped memory writes,
but this series is already pretty long so maybe that can be done later.


Douglas Anderson (13):
  kdb: Get rid of "minlen" for the "md" command
  kdb: Document the various "md" commands better
  kdb: Use "bool" in "md" implementation where appropriate
  kdb: Drop "offset" and "name" args to kdbgetaddrarg()
  kdb: Separate out "mdr" handling
  kdb: Remove "mdW" and "mdWcN" handling of "W" == 0
  kdb: Tweak "repeat" handling code for "mdW" and "mdWcN"
  kdb: In kdb_md() make `repeat` and `mdcount` calculations more obvious
  kdb: Use 'unsigned int' in kdb_md() where appropriate
  kdb: Replease simple_strtoul() with kstrtouint() in kdb_md()
  kdb: Abstract out parsing for mdWcN
  kdb: Add mdpW / mdpWcN commands
  kdb: Add mdi, mdiW / mdiWcN commands to show iomapped memory

 kernel/debug/kdb/kdb_bp.c      |   5 +-
 kernel/debug/kdb/kdb_bt.c      |   4 +-
 kernel/debug/kdb/kdb_main.c    | 309 +++++++++++++++++++--------------
 kernel/debug/kdb/kdb_private.h |   5 +-
 kernel/debug/kdb/kdb_support.c |  48 +++++
 5 files changed, 236 insertions(+), 135 deletions(-)

-- 
2.45.2.627.g7a2c4fd464-goog


