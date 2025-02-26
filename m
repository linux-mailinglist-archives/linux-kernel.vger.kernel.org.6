Return-Path: <linux-kernel+bounces-534716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 372FBA46A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF03D188996D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A65236A88;
	Wed, 26 Feb 2025 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVrIBSZI"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2E2233724
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596115; cv=none; b=OBUhJJ26M1bSmEAIcWzjB1oW8ogDFmel5htY3GUZ2u+MEEbwo+LeQBSp7e5VaIYe/RK8sy0h+TSr/auM5T7ETicH9QaHTiISI1gorJdjkNRDZPYf+6NSJH57y2/MggxTWotf9F5eMkEnEokHZ11OVeUAoMHTXuxjdEH4epg4XGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596115; c=relaxed/simple;
	bh=3hozpgoSS59OL/VEqqi5QtKt2hfzFcBfjU/Lbnupyjk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sj2EW4t2Jgxv+rzRfnVFreEwym3iYks4N9gvsLc9QYUuR/2QHvQoh0JCzgotqTDyBW5H/r6QdvGvSAjsT8M4yBDjJPAKbo2UHAzZajRTIbn5TlehgMNvdIKdj0oO73HT/IDNyNYZYpcEjp3HqkkRK3cIE+SdKh+u34jbIgkYgfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVrIBSZI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22101351b1dso1173755ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740596114; x=1741200914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tz4Qs953FyQ8pSwuSRRMRObCEn7/+1IJwtCxcvgUByo=;
        b=QVrIBSZIgZzgdatwxWv/2nuYHAGYHzrrCe4RxydfADy2Yo32UId4uVC6SF/XFx+oF3
         iTKYEBUPAwp+mjviMbykoIT+zV1oXoB2c9zPuqGBjxmUZbIdwjvXJR7hv0T+nWYB8BqT
         En8KbJywhdIbQHDOavvTTxkC4wj3Aw685g0WiR4Djfa7vWNYjENL4JFEaJnYRf83NNbf
         7pFK412HiGbl1aa7wJ479rbTT1lV3qOFVygGUg8mRKBJQlMDpBAi6m2+XonzCbVLgIgZ
         dPKsSUnhI6+ng4UutNH1pya0uuotKQ0C10qwlsFDa1FyT/BDQa5iaU1Q4Gp50qvjZNGz
         rtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596114; x=1741200914;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tz4Qs953FyQ8pSwuSRRMRObCEn7/+1IJwtCxcvgUByo=;
        b=nsG43AzFR2649qaiGOqmKLW/LeSpqxiB6tDJAYv1OP19w1cyKyLjS47bDC4AfSiid7
         pFPuawwXBVHFCIpLoD+Z6Oj6Oo1AfYMiWS1xrqFWCYM4AqHIvTbwFa4yq0K8lKoVzniG
         uZ5qwobb4Ti5kZ7iUqlyOFkZZryjJCtfFJzeZbZsaY4RPRUXSEEJ1UN6nXfcpGmh4Jk+
         8dWuUp+svv/OZALM6oGgq1tu+oN1ES7+J9kud17Bz3J/tcP9bOpgmTjfBMqHOteZLBR5
         u6lHTyHl2lK5sqcAOhR1rRziIsIQ4fvIyUoVKFO60gFsFwdU6fIyKgx2SDEuR51WhaaX
         eq6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcSEM3t4skQawRQCG8F+4GQfvljxXbJgUiyJPg0Ab9wUU9yg3n94mcaVGIJ6TNUZVLIC16MbmE3v2plGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzfxQTexCx7aNGn3MagyJ3mlRj465B+uANkN+9tEzpn9CcL9RS
	f07Bj8fsu4q9K7njiHYS660gXxB91REO0HVmeOMQtjbR8d/tJhQK6B8QZGxGkWYpIQOmgKLLht6
	I5w==
X-Google-Smtp-Source: AGHT+IEiiWKKK5H8nmcWMiqbiAfTi/yBBsoyxX+kvTyaicEXWSkrrWW/xyqbnD51MQeATwdUE4l+c4dsV6M=
X-Received: from plhv15.prod.google.com ([2002:a17:903:238f:b0:220:e5d1:24c2])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c7:b0:21f:4c65:6290
 with SMTP id d9443c01a7336-2232006201dmr74561105ad.1.1740596113491; Wed, 26
 Feb 2025 10:55:13 -0800 (PST)
Date: Wed, 26 Feb 2025 10:55:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226185510.2732648-1-surenb@google.com>
Subject: [PATCH 0/2] move_pages_pte() fixes
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, aarcange@redhat.com, 21cnbao@gmail.com, 
	v-songbaohua@oppo.com, david@redhat.com, peterx@redhat.com, 
	willy@infradead.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	hughd@google.com, jannh@google.com, kaleshsingh@google.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patchset bundles two *unrelated* fixes in move_pages_pte because otherwise
they would create a merge conflict. The first fix which was posted before
at [1] fixes a livelock issue. The second change corrects the use of PTEs
when unmapping them.

The patchset applies cleanly over mm-hotfixes-unstable which contains
Barry's fix [2] that changes related code.

[1] https://lore.kernel.org/all/20250225204613.2316092-1-surenb@google.com/
[2] https://lore.kernel.org/all/20250226003234.0B98FC4CEDD@smtp.kernel.org/

Suren Baghdasaryan (2):
  userfaultfd: do not block on locking a large folio with raised
    refcount
  userfaultfd: fix PTE unmapping stack-allocated PTE copies

 mm/userfaultfd.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)


base-commit: a88b5ef577dd7ddb8606ef233c0634f05e884d4a
-- 
2.48.1.658.g4767266eb4-goog


