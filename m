Return-Path: <linux-kernel+bounces-558707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDEAA5E9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D4E170517
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6B078F2F;
	Thu, 13 Mar 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyI2M/R8"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED0E11CBA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832399; cv=none; b=eAQgrQ1FE/Lenm982xhiKlo0rZd04WEy2GgA3EskaD/fBSRxXSUFotLGeDd8m8i1eAmIi9FWyW5fl0Y37Eo0cF5Iw893eb33m05h0CC80YIdKJtpNKxMRhfkVODiFN2w0R/lFu2U8ALDqF7cquzOhOgIRPK+CiiWF2Js2cekAec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832399; c=relaxed/simple;
	bh=fG/YikzrdEjuJbrqMAudYIKwA6Y9eUTW66YbD4lDmzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jy4+dZQ5OmdbJ/EAW9M7NK30Twl8QAI+Cxjtm1gx4LI4CO1JIBh9/il4mu9mg7CUIQQNU02U0dPlDs6V9LcHOteUUM6hqXDxI6ljXcUtfGcjCMNPiCI0H0P8VjNERlgwA3S50iG8kktkUchjXtZvHBxStqk1/ocbKRfQJscUifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyI2M/R8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224191d92e4so8586555ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741832397; x=1742437197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2X0zLRd9NddFffy12lVG5DNnWJTtdDxYSURxmcbPPGs=;
        b=VyI2M/R8rnILjQcXNmAEAlzcm/KWboNeQpa2VmITNPEKyaFOEFrFsQ3vN+icoykD/5
         Z6AOMs6ZnTp7GSC2nyPdzpUm4lvJU+SrMuKmjvhcZyMxwdf+4Xp+Nhm8Kjxjm9IOChAj
         lVg8vnutDn1jP+OzmpTf40yubZ7lELYB+NdG6Jd/Qw563xTppQrzaT3UoFBnmAPad8ay
         kXAaYnCHdRkonRKGUcyugifL1iJY5cElgi6dCYpN/nX8eg+9OcY3nteXWVHtwra4trDM
         DmqunLa5/ahPoyQpxluIfpPE9kJI7S/tJfsdqqQyiW760YUcM0q+qaqR1dDBmzCTODMO
         fHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741832397; x=1742437197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2X0zLRd9NddFffy12lVG5DNnWJTtdDxYSURxmcbPPGs=;
        b=GZa+GBs2YKNcDpb5JW+0/G4gddE1pooDA4dgqs+E3mA+j4y7lHoKdA3CWJyno8mLUD
         ex5lt58lY2QvD2suny4lvfnzgxJzvdgYtiYXvuYNpLzrDUZ9UnCW8D4JdEORUGCJCPOI
         wRZAvs+QQqpFqS+nz3TZyDsQBdWzKlaT5uIJioqPZ7eZRvkCajHa1bGutruZeOP9FROZ
         7oGRafmvtepFmF7FdqZuHC6D97RArz9utpAXoxKR4PkbfQYgyISuTQGCHC0GUyFm0Aov
         TPcdL89ApqnwsEsVY6L0SSs4wtiUw9OMb2qj4+SO1u+mSiTn22yfU0AdGS3JPFsNg/ZY
         kZNg==
X-Gm-Message-State: AOJu0Yxa82WI7v9mmjR+RZj0LneqUTSNHAL6asvBZXHQrGe0pzK4qQw4
	o4AUlGc6nMJtVaxCKgxxeoorsV3HZ9E6rl3ODK4D3zFW2Ie+jg8pZ+pD4Zfv
X-Gm-Gg: ASbGnctdA197wAGT+/KdEY13X8aj1B/cq6DAIwpoFbfLIEMs03+mWZ4iu200sb3dI6b
	vn68ziHS/SOVTcIEWGNcWqA/n/aSTZjnVoFWpfYA6riSMtdw7zIHeIgBgaEOF2E/GrpnjntvT1n
	dBqPd9mANi60ejGU+s4E0WshSmWNiELWlyE9LH+RNOjmX6EtbdCU0O41d9CIhMhMG+AjH7X1KQB
	DRlcBkvzVNd1PXcgLwU8J+MmXfhCc853t47tuYw5qnuT3LfIhs5juMU7HjjsW4N7+A5eW2z000w
	G4UWd217gcCpMEyxSs+rSZShUqLxZkm2MF1mQfPldbBY
X-Google-Smtp-Source: AGHT+IGUUbSyJ0QDHcHkMIAjP03ULd0lMeCdX1HDPPOjpdH715uX03jqaD5cx6WCzUd+w7d6In6D/Q==
X-Received: by 2002:a05:6a21:7116:b0:1f5:8479:dfe2 with SMTP id adf61e73a8af0-1f58479e277mr20721508637.6.1741832397552;
        Wed, 12 Mar 2025 19:19:57 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea7bd0csm242006a12.47.2025.03.12.19.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 19:19:56 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH 0/4] cleanup dead code in nodemasks and cpumasks
Date: Wed, 12 Mar 2025 22:19:48 -0400
Message-ID: <20250313021953.86035-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup dead code in nodemasks and cpumasks, and while there, fix
set_icache_stale_mask() that misuses atomic cpumask_assign_cpu().

Yury Norov (4):
  nodemask: drop nodes_shift
  cpumask: add non-atomic __assign_cpu()
  riscv: switch set_icache_stale_mask() to using non-atomic assign_cpu()
  cpumask: drop cpumask_assign_cpu()

 arch/riscv/mm/cacheflush.c |  2 +-
 include/linux/cpumask.h    | 19 +++----------------
 include/linux/nodemask.h   | 19 -------------------
 3 files changed, 4 insertions(+), 36 deletions(-)

-- 
2.43.0


