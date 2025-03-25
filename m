Return-Path: <linux-kernel+bounces-574649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A989A6E81B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21D4171860
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A9042A9D;
	Tue, 25 Mar 2025 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxhG3Bd/"
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0043E4A0C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742867784; cv=none; b=XO3hH57ZEyFD85+2o5o7SoDtVztewp7Owz2Y9qC5EwLAi8FiXZQEliKyk+CJ5vEKFkFPwXxVgVYiy6LhVkbEfrQ0KF4l6LjqfCa2mLRDDJfyK+sgj6g+l/ZPtEwdafvL78H1vp5VqdzkbzOfHWtDxYbvUZXS+jwK9NdnEOHzrAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742867784; c=relaxed/simple;
	bh=iW8dJ7iHFc7kJ17qorglPOnxf2Mp3LzySJvvS5iXDTM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LQQ2ubcXVkGS1pkGsWBT8urBtDIe7buEkSjKBstX9ueA9/bj/7n1CV08L+l6Zsd9IUXValnhfAdeZ8GtVOTrLf3zuXB7ocLZBpd7qjWfMCtk8beetEljG1pY8hYqf4OF9VtcF3A6Uj/HJlg8g+mO4Q0UWW4pyOVrj3rCwVerN6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rxhG3Bd/; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-6021152ab3cso2159669eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742867782; x=1743472582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ib9+Q0ada4H11TeWZKVSJ40rZdGKNeCFH54Ppv1IWfU=;
        b=rxhG3Bd/oQeq9vCDpIIsJO5JPm/nxulyfNTPMcCvRr1Q4JOVghdI1OSh14lmgQIXOv
         DMRRNvNrM1k75JUQQJZ0wjICYmuzHaa4U2oY1oGN6HhVRoWnh2XEK2vDt4D5MyiySZqs
         lAl4H/MaD6QJV2KlwuNEcGzPIivmWM6Rel74+3Wagx0BdlxqIQhmzpUSndlDbE3HmAVf
         eKqdGsR+O9xDPqE5ghb9cAd+zPsukv1x8hvqrDd3VObrSuTC+Tlj4UAcoKiewotdJFiv
         XihQz1TYd/khfjK19bzXG20DFoyql/EUB/WU8/RuFGqr+9XgzUDC+FAZBr9FoGa7Q6GL
         ubEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742867782; x=1743472582;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ib9+Q0ada4H11TeWZKVSJ40rZdGKNeCFH54Ppv1IWfU=;
        b=gGB8DWAaiGOWXmI4Dt7k8IwJCNZ2OJ27JBX0bbErC3rWJAqUzBU5l2Tzj7qlYMeEnj
         BVo2/EU8qonhfDPXqGCDwgBQ3BJjb3cMnSXDnArhdbk+pI+mzNbte3i5iM+SnzQ5KMmQ
         wiRMMnkvoB4aYqlN6G84iWOyow3napkhTOlaOBdixVrU3uVhr+KL0DbTLUjalc6wQmc4
         Dhln3NN9r8XGD0lKmuV1hZlexwD/JGNmMoKGw+gxQn4gUjz/noN2twnip6riWCjJ0TCf
         dXlELa80gBatHHeLk/rYTTFpwKrtIGh9OTKH8lKnuBuqlhsTbOx0ubYF1L46ZXGwk43z
         pt/A==
X-Forwarded-Encrypted: i=1; AJvYcCWWkS61yjw96OjG+viYoy+22a5zJ3UubUuGF2K9GM+eKLOr7EkpgoCvIQFMx4pK2xO/3SKBZb0UJ4jFZ2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Vhl+/cmu36OQcy+YCJEwPbJwFiorf31dL+1xIe6Kvtod67fe
	W9kUxBpoTjErfsTo5BXxbOTAdcz/BaxI3LjfbUC3rLMiB2cu8myk2DUxGk9gmHMkuw==
X-Google-Smtp-Source: AGHT+IG0+uLGPYG9slyIicgnfJMvJ/fL3LCjzaIbzQaDguDS59/5o4ooegKCdV6c7y6nONpb9SxgUdw=
X-Received: from oacpc8.prod.google.com ([2002:a05:6871:7a08:b0:2b8:faad:4f1d])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:e496:b0:2bc:7d6f:fa85
 with SMTP id 586e51a60fabf-2c780298b2amr9783186fac.16.1742867782106; Mon, 24
 Mar 2025 18:56:22 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:56:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250325015617.23455-1-pcc@google.com>
Subject: [PATCH v3 0/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

This series fixes an issue where strscpy() would sometimes trigger
a false positive KASAN report with MTE.

v3:
- simplify test case

Peter Collingbourne (1):
  string: Add load_unaligned_zeropad() code path to sized_strscpy()

Vincenzo Frascino (1):
  kasan: Add strscpy() test to trigger tag fault on arm64

 lib/string.c            | 13 ++++++++++---
 mm/kasan/kasan_test_c.c | 13 +++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.49.0.395.g12beb8f557-goog


