Return-Path: <linux-kernel+bounces-207343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C179015EE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 13:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB6B281CCA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 11:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65DF2E64A;
	Sun,  9 Jun 2024 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DHwhssFk"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC71865C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717932081; cv=none; b=cXzFxX08kB85u2P0nCkiiOXpq7Hg+r2DVxYNnPjCVtRyGqYcN9DJ84Hh6cuV2Z/z8qIXi04mRMMNAwQ7fN1dGHrWQqpDonHiMGQj5Mr0vn7BbRvunaANazg6b3ycphqfxyXTC+XVzjq7vUFcwlnWrClYJwxPYhlJ4Qu0UOpI+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717932081; c=relaxed/simple;
	bh=d2E1HOzpQ4klUKYDWhUxaisPju1rtPEq8I2QuvIorLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PdOKlHp5U5J7xRZb/DXE4WO/pG7iSsKa7o3nhB7K3v6J3D0zSqPLdpq/A1ELX9HVxBKdc9kVrYfNHqN8G7HBw8v0diuNuY8Ttx/qsjj3iGJuQ31WHKdJJispuB9hwzSS909OjuZ1JUEyaQ78/LcMWq8PQp2PROKrAvKWZ77DdGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DHwhssFk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6e5fd488d9fso1093422a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 04:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717932079; x=1718536879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8RkJz7STlGmWW8jD0TSVOv8fdv0p5pL3iIjahqzVhas=;
        b=DHwhssFkyEtEzQvpBJ50S6qtc4qz7aU69CMfEIbE4ZrTgEJfxVBqDt+mre90waeQ8a
         Ex1puFhdLYqgqFr3f8jHdIkhC4CK4KOWVxApmOx2r77AnFVJG2/Qw3VUX7MFHji/H3we
         j+ocw+R4BfZfNXtazDQGQNbHuDS2iIZiUnBLqNZ6tXtLRVHbb1Tr0PQXDPcTLfS909wF
         0mB+ebg8QKzZy1RBxy4t05lxnwxuQmucEBC89v1d8UNappQP1vxbrko5Md6qlZJ1UeQX
         KRzjCjhlKXDpG/ANMS5XaJ9sDqtEB2pQ9dbKWD5ZshLotjNckRqMAv/c8DT52MZD+6S6
         Gdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717932079; x=1718536879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RkJz7STlGmWW8jD0TSVOv8fdv0p5pL3iIjahqzVhas=;
        b=aIW9e9+Do0l43EtcaXjB51zy2t89lfF4GUXaUTbymV5fgt+QGCoCx1AzSzBOl0ZaGH
         40wGydgkj4OUVo1rdmWzllDWECkjUZq0pSeuraL4vxBiPAaPRrL3GVBYm9qvz+55LcDl
         QTLA3k9trpHBazknc+RS3G7xsMWM5WJZJmp+NiViwDC7/dToEjF667ah7dEOa0tsY7le
         4yIPMTxuDCrSA0M0UHFUQ7Xfyv2+Zam0PWUH4WWYcZJECLRqt/w2e4IAaKbOJuGztWKZ
         p9y/+889YPFHiofZ8tc3oiDSfArllRu+B82VxNHtuEZ++OxBgJWg2uxrhs+tV/FAS4Sd
         ZhfA==
X-Forwarded-Encrypted: i=1; AJvYcCU8IbuJf1Ie2nuft+yAX+S1myNqdMiorp1OK5ZIbjqPjh5/i3dwkYMkwV0aj/2O3NUCS/XIu8WBMKU2rg5AjgZLuV9laXv321aBpJpY
X-Gm-Message-State: AOJu0Yw2N/X948tncyyp9JZJHVnm26MCqRuy6S6OQ23T7yfyAnBWve/S
	6PV44eindXdHVLDTMWKZePKDlDzXYQGyaHDIvJV5pxKrt+QzzyreOb7ZjNfgGMI=
X-Google-Smtp-Source: AGHT+IFog+F8+3CtcaQAB+IE2NjOh3YkhfJjv6SZ9tbLhc0+ydCcGWmNOlM33MkzDXR7SiIUO6y9Sw==
X-Received: by 2002:a17:902:da89:b0:1f6:ff9a:cee9 with SMTP id d9443c01a7336-1f6ff9ad07cmr31639975ad.58.1717932078923;
        Sun, 09 Jun 2024 04:21:18 -0700 (PDT)
Received: from ThinkPad-T490.. ([223.233.86.175])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f7092a525esm8168355ad.241.2024.06.09.04.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 04:21:18 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v6 0/1] Risc-V Svinval support
Date: Sun,  9 Jun 2024 16:51:02 +0530
Message-Id: <20240609112103.285190-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for the Svinval extension as defined in the
Risc V Privileged specification. 
Changes in v6:
- Rebase on latest torvalds/master

Changes in v5:
- Reduce tlb flush threshold to 64
- Improve implementation of local_flush_tlb* functions

Changes in v4:
- Rebase and refactor as per latest changes on torvalds/master
- Drop patch 1 in the series

Changes in v3:
- Fix incorrect vma used for sinval instructions
- Use unified static key mechanism for svinval
- Rebased on torvalds/master

Changes in v2:
- Rebased on 5.18-rc3
- update riscv_fill_hwcap to probe Svinval extension


Mayuresh Chitale (1):
  riscv: mm: Add support for Svinval extension

 arch/riscv/mm/tlbflush.c | 58 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

-- 
2.34.1


