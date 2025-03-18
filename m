Return-Path: <linux-kernel+bounces-566307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E75A6763E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA7A19A7BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450D20D519;
	Tue, 18 Mar 2025 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifRv6Di8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BB720AF7C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307462; cv=none; b=dy6o+cgEBEcYR+n2akn8Nd8C77gOvHQsCOo+wjxY6GYgjSs88xWcuDh2Go0+RrsA6kj+5dHtNeErQJfFurw7TOX57KlMHF7IlyMP1tnL6DTtcGE3Bjrwk7va8nxr+ICf9eflEGmiDsEt3z6zO4us7oDGa8NT1lCRHAbuXZCoUbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307462; c=relaxed/simple;
	bh=9GhsrLULgaBmV5CiLPjez8oF/aN0WlSsAJSDEcI+Qb0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HRuhRN7h1KEmnhhWvHjyPwcjgpM54BartzzFRGy6eb9Sw4diRqtwQvAmdulnz/7XqriSx3wX/iDZPMZPLfmsvK7nkGZU9SOJ2LZktgStTyfSQh0jMgeKm+o3KmrkS/UXpBkpeRwR8aIbR2lcrDK2bwTgQKGm3JMQOzDaygDI29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifRv6Di8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D22CC4CEDD;
	Tue, 18 Mar 2025 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742307462;
	bh=9GhsrLULgaBmV5CiLPjez8oF/aN0WlSsAJSDEcI+Qb0=;
	h=From:Subject:Date:To:Cc:From;
	b=ifRv6Di8nFchAv5fgaTdDdZ4iUL5/v+aUlnZIuwRFUD4Kgk5SW8Up1fLwG5/e25jW
	 fQROWA3attN9A3xpL1kxMJeLdurh/begJoVzEx2jR+3Qvykx5JMfUzc+cQLT9/uIQ0
	 WDzYZMHG3tbdlLuACkjUZnUuooj8yuNg7S8hRrHiXygOzFAjT1UpnFnmuKX8V8coii
	 uAoIFnfA1k8QvoiERmxvzkP+2er3HazJV7DlHz0VNMmHrXKcfd3dge+5I332tYsieb
	 tvQIC8MF00pf1ne1/yPVNTcqb+6TKraLkPNFOunV5RPtpyKGpi16T4R7Uk5Wl6RNp5
	 C7PjTgCddWhHA==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 0/4] drm/vc4: tests: Fix locking failures
Date: Tue, 18 Mar 2025 15:17:36 +0100
Message-Id: <20250318-drm-vc4-kunit-failures-v1-0-779864d9ab37@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAICA2WcC/x3MQQ5AMBBA0avIrE2iWiGuIhZVgwlKpohE3F1j+
 Rb/PxBImALUyQNCFwfefIRKE3CT9SMh99GQZ3mRaVVhLytezuB8ej5wsLycQgG10p0py8IZXUG
 Md6GB73/ctO/7Ad/d6ENoAAAA
X-Change-ID: 20250318-drm-vc4-kunit-failures-313b4775c438
To: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9GhsrLULgaBmV5CiLPjez8oF/aN0WlSsAJSDEcI+Qb0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOk3GxpLOz7dK7aNv72Nvb/71QvZb6+8U70uZ8lPMWiMP
 LN+ZcS7jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjAR462MDXN2Lp95f/45rjml
 PS/4nv89c/x74ItrTwo5wt2i+gp+OzOdbP6XpNnC9padp/gve3GaJmOd3YXzwfPfMVmvfVgrJOA
 fdz98q9TBHTwbEo52yE5X9lnV0hq22f/6/f6THSLeFqZCTxYAAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Hi,

This series deals with (lack of) EDEADLK handling in vc4 PV muxing
tests.

This was leading to failures with CONFIG_DEBUG_WW_MUTEX_SLOWPATH
enabled.

Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Maxime Ripard (4):
      drm/vc4: tests: Use return instead of assert
      drm/vc4: tests: Document output handling functions
      drm/vc4: tests: Stop allocating the state in test init
      drm/vc4: tests: Retry pv-muxing tests when EDEADLK

 drivers/gpu/drm/vc4/tests/vc4_mock_output.c    | 62 +++++++++++++++----
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c | 85 +++++++++++++++++++++-----
 2 files changed, 121 insertions(+), 26 deletions(-)
---
base-commit: c0988d693eb10e115d95747f8a0cccc83babb3fc
change-id: 20250318-drm-vc4-kunit-failures-313b4775c438

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>


