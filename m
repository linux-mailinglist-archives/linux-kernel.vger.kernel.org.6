Return-Path: <linux-kernel+bounces-191736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E7A8D1372
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8312F1C21921
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FABE1BDC8;
	Tue, 28 May 2024 04:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqMmx9Wf"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA81182B3;
	Tue, 28 May 2024 04:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716870880; cv=none; b=ju4tim1srCpck41s8gry6oX7pmqmn0z5LN3JLfI0bAeb4JPXqmHR01/zFv3wKm9uYqqCvcGgH9+9pM9IUDZ0dny2WPpKXc3nxQUvqkdEkGzlfvDv9kK3DxBMUSBFLFHWMJ1+AFPmm7S2uc73Nmc2eJQg7XSjXYsAJFeh0ear/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716870880; c=relaxed/simple;
	bh=+RTyw5meJeHDhLxVGc1wXIQTghCvsLRNuCJS8aBp4XU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sR/j+46ga+3EHkdoXxwy3yE/h561Qd9XKObEuHabRuBj8lhwF9AF16u4N8w3g5CcXLhluU0i05dOeG6nH2ZYIu6RvqVnsF6iAILJv/jVtKlzD5PyCcaVSIGcAuoOPw6XMZsL/9xNaSahjuT9/lP86YWUNOpGbMn2vXuaeP7TuVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqMmx9Wf; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-681adefa33fso383886a12.3;
        Mon, 27 May 2024 21:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716870879; x=1717475679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KWUjtdr3n787r/jcZJXOANKHrObcYlm050O4MGl6CXg=;
        b=OqMmx9WfJ1OppDgUkwOtJH/EuAf2smCgO1FFZfxpJfyluCcZd/yb3IjBwgO36eLSKb
         i0l+3GbwoaBCC13Xm5ahDbMkqTBnf63WOlT29AKlW64wrP5AAHVDww64Knt8c05K07a2
         1yF2YJyYMSvFoELH7zFX1X2rm0Fco1/k/oqncnus9nAIHsYV7tgOyGNvxWZ/7Q079Oqm
         yUv3wrNGT7bBGU2nwlAE/ngbdFLOOLbXirs3pCeO45NzQtCNd26YaRw4hd7wgkQBlO9X
         k7PrQ/DI7b/p1ijhChJemMQTLYFw4+o+ue6bUriozNlvRMBHR7UPpGHEKK6xKfjY5pM3
         zDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716870879; x=1717475679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWUjtdr3n787r/jcZJXOANKHrObcYlm050O4MGl6CXg=;
        b=QipA66/EQqM3AG6i5O0J+deS3MBDXUFsNODWsnx347nty10Ny5U2Szbr+sPxuyqPTw
         vL5agAIxhYMMV6NeUA+B+DPUcZlO23C9xV97N5w1ENzJViJxQdEGFALa6rqTeWM/BJ5W
         pQbxqlytsc+BqyrUkGP9boGHRNbycaeGsGZ4Ew5XwM+uY5HuazXboYS0hTwbSmg36+O0
         shIcyBdXPEw+d1jApkz/aec/OjsVqyvZ0F4+isKDa2pnPzWERp/hU5merZzDR4S1gXdd
         TKH1xdVtaPPMZ/CkVYhzBRvuOegCCZ59MrgBz0hQgnZM0zpOoYNw1KzIGj4j4uIRPjX6
         6lkg==
X-Forwarded-Encrypted: i=1; AJvYcCXhRk4sCic6fFUQxuzseQhCiG6wxW0HM7O8eXRfwjZ5SsbJZy8k2A9MtKYCy3qeMNNSUpa+rSaTyhFk0qomeRB5mEJ4LpHOSv77xxqq/rfR6urDVSY8KD1S2zF560AxFLhbhTVIfY/K
X-Gm-Message-State: AOJu0YwcEPKLUb1FsySldfH3YZVcXickikWu6rqqHXLw4fH0X/yo90xE
	3hCBZd7V/ihzK8ii9e4vuAPPOMZ3ErgDIQU9k3PyBrUXrDKlAsso
X-Google-Smtp-Source: AGHT+IGuRS4sS/MTKScuE9idRBh3tQ29cfiL0aCBeleXVPFhg3GGey75h3G+uhN/Tif/VBMPt97PYA==
X-Received: by 2002:a05:6a20:324d:b0:1aa:92b3:acd0 with SMTP id adf61e73a8af0-1b212d09de2mr13080168637.25.1716870878867;
        Mon, 27 May 2024 21:34:38 -0700 (PDT)
Received: from cbuild.srv.usb0.net (uw2.srv.usb0.net. [185.197.30.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d57b9sm5620036b3a.193.2024.05.27.21.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 21:34:38 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: flintglass@gmail.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mm: zswap: global shrinker fix and proactive shrink
Date: Tue, 28 May 2024 04:34:01 +0000
Message-ID: <20240528043404.39327-2-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series addresses two issues and introduces a minor improvement in
the zswap global shrinker:

1. Fix the memcg iteration logic that breaks iteration on offline
memcgs.
2. Fix the error path that aborts on expected error codes.
3. Add proactive shrinking at 95% full, for 90% accept threshold.

These patches need to be applied in this order to avoid potential loops
caused by the first issue. Patch 3 can be applied independently, but the
two issues must be resolved to ensure the shrinker can evict pages.

With this series applied, the shrinker will continue to evict pages
until accept_threshold_percent proactively as documented in patch 3. As
a side effect of changes in the hysteresis logic, zswap will no longer
reject pages under the max pool limit.

Regards,
Takero Funaki <flintglass@gmail.com>

Takero Funaki (3):
  mm: zswap: fix global shrinker memcg iteration
  mm: zswap: fix global shrinker error handling logic
  mm: zswap: proactive shrinking before pool size limit is hit

 Documentation/admin-guide/mm/zswap.rst |  17 ++-
 mm/zswap.c                             | 156 ++++++++++++++++++-------
 2 files changed, 119 insertions(+), 54 deletions(-)

-- 
2.43.0


