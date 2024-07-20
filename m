Return-Path: <linux-kernel+bounces-257786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAB4937EEC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 06:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B901C21243
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 04:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B403BD30B;
	Sat, 20 Jul 2024 04:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBICqFhy"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D88917FD
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 04:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721450498; cv=none; b=LZiOeskAd2z2afR7LBaVEqyCweWVbCwLvVWBrrwog5HIF/cNhshDTWU8EGFU0Yl0Ueh218k3+qaxXZFca7mvWEpdmG6wrXF9a6pUfIDPJI8CwFVWVWnDliohcfXd55MHzpkKC0eJS6u0h9/4xn6fMIVr5kpFFX2N2/CY7Y66ERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721450498; c=relaxed/simple;
	bh=s5tMGJSw+PmyLmw+DJ4FYIqzjhsgNktnj1ofxvzPq4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZwKtiCAXvGZwqPoqRuUUDRYIcrvTZMrppfH9e5Gx7VjS4puqXvOOgb11p0kM/3IYpq3tTsZiF1VPXhMnHPio4PW9ZLPpS4D06wuPod2s5EqoQSgQK3+Q6CTZ3B7yOOolGfMvpKn55JVHMYDKA0hONIU7aiUPtNq8aCTLsZOuAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBICqFhy; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d9e13ef8edso1570788b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 21:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721450495; x=1722055295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TazlOyBq9n8e3ZgcH3KBbY9Dk+2vyIhBQceuB/M1KFA=;
        b=CBICqFhy+cpI2M8B9F8tIKUoVrUz76qJbTOcCdy6eWVMbR35BZSHBYCyJUZg4XQBUG
         l7XD3qWBDGlO0TvVIKJSOBE7FSLb2N+/x5dYfJgRILtWXGdssMC9vwcYx5ECe/UBslk+
         D44pWVrsE0iFP9yJSytfeillm+p0d5k4ifRrmG3vrjqb3x9s6dYp5zSyoOfJe6H1YnoR
         fIwa0gK3a9SYFMrv3+croj2eOWSIYZaeK71HuNffiqyhXXQs1jj2v81iIqSB7Ro4b40s
         iOhMdON+Q2SlgXIRWHBSrpSMgZyLTCGCbLZoa4ldAgXPv9bEIE9dKIs9JpdYeHXeMhcL
         aiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721450495; x=1722055295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TazlOyBq9n8e3ZgcH3KBbY9Dk+2vyIhBQceuB/M1KFA=;
        b=p0NQ/68yqkpSLuaKcz8WZe1IS0G1fs1ijFJYdhG49l9oIi46MdKDKbrcSCvHrNGL/7
         g69f2s6U9TtKVyoqlk/P/SjKSqIqi3ncbxjEIrfr5kUaeoGWw0WwcUgWE3AJnFU5hcUn
         FPwcRF08wSKL0aAcEVM3KJ++dMsmfAysQtkM93y5atyMhDsuTUee3/7zoC0ilFhFUT13
         TpsjNuuF7Z+vneR7R+oPktrJrepRve7DkidBj9Ehmr4HkFP3BZoGQmvVu0VZMelAlXf+
         ur22tt8xA6ftmgVgOcKuvf2TC0LXM4bz7C20nA49FhEsVVH7frUaTrWeX1CrjlE4Pv8l
         ROJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzgymle+AzfBpnPpjHyHD7xtyZKrSDrNHfZMfLUPJG4YGebUojzwEPSsmqATUt9sMA4U4zO4H5gmh2Fc8SZtsZ3zus8Ks4aNplMr6P
X-Gm-Message-State: AOJu0YwByRWUWa7siPigT4Ti2Vsd0oQ8OelfwQRAIDCGtgq53kg3FWSU
	ap11FBv2OybnnQsIRGtmqlM8+kR86pL1vtL1G495LlSRv4ZiLHz/
X-Google-Smtp-Source: AGHT+IEQTgYsXPO4r/PNUv8ffc7ODyfYPBm5tDS4j4swPzpIs3ZqD+AJtllRuvQV+fjq4BAIx5ShFA==
X-Received: by 2002:a05:6808:1a01:b0:3d9:2562:7541 with SMTP id 5614622812f47-3dae62e9898mr1980921b6e.24.1721450495625;
        Fri, 19 Jul 2024 21:41:35 -0700 (PDT)
Received: from cbuild.incus (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f315c11sm13023465ad.125.2024.07.19.21.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 21:41:35 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] mm: zswap: fixes for global shrinker
Date: Sat, 20 Jul 2024 04:41:23 +0000
Message-ID: <20240720044127.508042-1-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses issues in the zswap global shrinker that could not
shrink stored pages. With this series, the shrinker continues to shrink
pages until it reaches the accept threshold more reliably.

These patches were extracted and updated from the original patch series
v2 (mm: zswap: global shrinker fix and proactive shrink):
https://lore.kernel.org/linux-mm/20240706022523.1104080-1-flintglass@gmail.com/

Changes in v3:
- Extract fixes for shrinker as a separate patch series.
- Fix comments and commit messages. (Chengming, Yosry)
- Drop logic to detect rare doubly advancing cursor. (Yosry)

Changes in v2:
mm: zswap: fix global shrinker memcg iteration:
- Change the loop style (Yosry, Nhat, Shakeel)
mm: zswap: fix global shrinker error handling logic:
- Change error code for no-writeback memcg. (Yosry)
- Use nr_scanned to check if lru is empty. (Yosry)

Changes in v1:
mm: zswap: fix global shrinker memcg iteration:
- Drop and reacquire spinlock before skipping a memcg.
- Add some comment to clarify the locking mechanism.

---

Takero Funaki (2):
  mm: zswap: fix global shrinker memcg iteration
  mm: zswap: fix global shrinker error handling logic

 mm/zswap.c | 100 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 73 insertions(+), 27 deletions(-)

-- 
2.43.0


