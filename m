Return-Path: <linux-kernel+bounces-248513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F7C92DE44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3722E1C2128C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E37946C;
	Thu, 11 Jul 2024 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dE066TLE"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5EAD50F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720664004; cv=none; b=OlIDs9MbjPkMcPiRejaVedk2VQwVSq6A3kuzIVv221KNoGX7PkgnhIFKwfvdpAKju4+y3R8KD5w2GpdQEiuTIeDHnHjEULc+jX3Pb502FV/VbwiA9mBi0ntp2m3N+CYned20orrEX10FybB8X8HpyTva4vm2hoCV1rmTgfiMkLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720664004; c=relaxed/simple;
	bh=InqsazDLaTDEsMBHtv27CsYRFFsS0lQGSbENa+0J1Mo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gh+7RFzbqnfMkCkCHovcDNpjzm3bxAEZwtyMXN3tF5B+aI2jookIFidco429ZYMBfgZWbSp0orl9Chx2hkzCydBS/CFIcO4IqNp4eqeoodtLQxOg1bGrHblTaE4WKq8U5AIpu+UXJEiimvl6wUx0Yb705buhlAoAqwGp0xp6ku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dE066TLE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-650b621f4cdso6201947b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720664002; x=1721268802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ni9rKczF40GrcfFt9GEMDFIGhJ0QRYO98iDUbRTJSw=;
        b=dE066TLEjqAvDdSFZgLifXs5t7pszxl0gV9T7HQBYSDbrZDH3K8heCMNPwQsH0gr/Y
         PijREsRDqrxrCXptBgPCh01682nRtpGOVn5/e2DaLRi6vogx4BFrc4e+DfM5PbxWLEV7
         bvKeQxaikkpdqwubVw6iT5FEen+5fJwfLVNK63WO7VErKzp0ONKZU08TKGG0klxB+kL7
         hc3RZn5O++Ad7Zi2IZBgeqE38JoVmrU7inS8vmluefE/sTJnG1gqWI3WT5cZ8o2npCjL
         nhhXNuNgiReJrt4EKto+Jx6+ytrL/VabSb41wQfJKbxanFNhuE/FIM8aTSwwUW1qgkNI
         zjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720664002; x=1721268802;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ni9rKczF40GrcfFt9GEMDFIGhJ0QRYO98iDUbRTJSw=;
        b=cPfaDxMR8+yreFZPE79t3+EGOmTnt00CmNpKFUkzv+Gkgflgacmqg1q85QXjdORlwC
         S//W6lSVs9koXSx4xOE2HJsCFPlKJ9bJ9twGjd0ml9BRzlWFaDX+HP+MEclGMkqrFyhK
         ZkaelfJUFBBZ8DJ6HbPA8eMMaFDnhZDnEvEHhvauDrig/v2kGO7q5Yr9B1GTG1pX+2NM
         2rGqloaht5UUlObHgr0lVBWs5WP7NhhX7KEmq9Wk3ahQ/HNn17hnOOWXq9PIYoxMKMsc
         cyYj3dfYwuCbFJkLD5ivFtGRsuxV634NJtdGKJaSifMXJborgI5wC6auzbzhpct3OOl+
         u8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI9Zq0S7cP46gG1wpKkNT15xFUSCb5lbPA1RNG7lE+DNQSoeIgCv/WCbfPleKAidEp2zfPKaB63FP4Mse1IasavLCmczzK6K7FaQ1s
X-Gm-Message-State: AOJu0YzcyyK7l7l7Wd3jjgIRNT0gJhYB0+SAp/kUSgdBRlLGYi4pIblF
	bKz+qUvm9v50qSluQSfCZJWprr0HY5A30msk7KPE1v0D+Mwy722znUfdBWySJdkVSO5UDG1Twwn
	YgA==
X-Google-Smtp-Source: AGHT+IFOxzrR2bVnP7JYh+vLfXLNNPK/nDMN+vnM+ywC7hFF3f7JX5UwfD1uk5Yqqk51uLGGuXY2zKyN9aI=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:9b06:2f28:6675:a98b])
 (user=yuzhao job=sendgmr) by 2002:a05:690c:4906:b0:648:3f93:68e0 with SMTP id
 00721157ae682-658f0cc04e7mr1805307b3.6.1720664002467; Wed, 10 Jul 2024
 19:13:22 -0700 (PDT)
Date: Wed, 10 Jul 2024 20:13:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240711021317.596178-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 0/5] mm/swap: remove boilerplate
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Use folio_activate() as an example:

Before this series
------------------
    if (!folio_test_active(folio) && !folio_test_unevictable(folio)) {
      struct folio_batch *fbatch;

      folio_get(folio);
      if (!folio_test_clear_lru(folio)) {
        folio_put(folio);
        return;
      }

      local_lock(&cpu_fbatches.lock);
      fbatch = this_cpu_ptr(&cpu_fbatches.activate);
      folio_batch_add_and_move(fbatch, folio, folio_activate_fn);
      local_unlock(&cpu_fbatches.lock);
    }
  }

After this series
-----------------
  void folio_activate(struct folio *folio)
  {
    if (folio_test_active(folio) || folio_test_unevictable(folio))
      return;
  
    folio_batch_add_and_move(folio, lru_activate, true);
  }

And this is applied to all 6 folio_batch handlers in mm/swap.c.

bloat-o-meter
-------------
  add/remove: 12/13 grow/shrink: 3/2 up/down: 4653/-4721 (-68)
  ...
  Total: Before=28083019, After=28082951, chg -0.00%

Yu Zhao (5):
  mm/swap: reduce indentation level
  mm/swap: rename cpu_fbatches->activate
  mm/swap: fold lru_rotate into cpu_fbatches
  mm/swap: remove remaining _fn suffix
  mm/swap: remove boilerplate

 mm/swap.c | 296 ++++++++++++++++++++++++------------------------------
 1 file changed, 134 insertions(+), 162 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


