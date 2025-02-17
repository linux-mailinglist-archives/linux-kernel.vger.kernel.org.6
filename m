Return-Path: <linux-kernel+bounces-517500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC82EA381A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7744016A702
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBC2217F33;
	Mon, 17 Feb 2025 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1kMivnV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6AF217713
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791699; cv=none; b=D+0ZiNvxhifvl4sInMTpFTaUa/Tg2CCM8RDueLe8//IF2PZx+K8hh5D3EWtmRn941nlXjWgjfVX4URH2gjMdjbvlHa6fg8240VRmkPwm/M6r1oa7grQcjA0FAZwsb9bUW0khmpQrheT7924nnqTn7V7qy//SWqlljIFeVXCIvro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791699; c=relaxed/simple;
	bh=D6bBaw3pzPm9sUurgmo05ZfpFaM0hDZ8jBH8Yj6VcVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sH9XRqgJnJBhBhXO4cXTCpUVTTSXAEPyPXL9cJieBgiL3grnN+R60McDk+h+yo04Oe3dBAuWCnOzOW+B6l+5dzUHtEKUJBxSfJacJ+u+L1qBcHnH+hshKaqc5DU6p04tX9Cspw1MUXLUzcZlNwt4rcCRe+xvzetKYIp7/bvCGAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1kMivnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEB2C4CED1;
	Mon, 17 Feb 2025 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739791699;
	bh=D6bBaw3pzPm9sUurgmo05ZfpFaM0hDZ8jBH8Yj6VcVQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Q1kMivnV1CFv1j0+aRxvvNWr21DAiL8zGo3NR1vuxVSwTuycA9wgfv1eFVaIT11B0
	 qORDih+jdNyWOymSS3p7VWe/o5j/MPRsxAf36a2Jqhf9kZDcOqdwEdusXs2W8tj9bE
	 6krWE1jbJqXXkkqVtQPtpBdg1NGFVQw4FSD5nb29YO9xJ2pjDDaSU8n2X4F/vfBL2s
	 awU46cxn5heA8ZH9o4+UmTvAdYYXGtVhH++xGGMaf/xA/BWt1gonWBvqgQ+riTos1B
	 WRJUK7texV4PU3+wlXNqz8OcJhJJ0DtPiovAp1t+fT2icOAC+bLWWJyIPj9DWd44qX
	 6ghkzIuhcFyjQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <christian@brauner.io>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH] binder: remove unneeded <linux/export.h> inclusion from binder_internal.h
Date: Mon, 17 Feb 2025 20:27:51 +0900
Message-ID: <20250217112756.1011333-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

binder_internal.h is included only in the following two C files:

  $ git grep binder_internal.h
  drivers/android/binder.c:#include "binder_internal.h"
  drivers/android/binderfs.c:#include "binder_internal.h"

Neither of these files use the EXPORT_SYMBOL macro, so including
<linux/export.h> is unnecessary.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/android/binder_internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index e4eb8357989c..6a66c9769c6c 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -3,7 +3,6 @@
 #ifndef _LINUX_BINDER_INTERNAL_H
 #define _LINUX_BINDER_INTERNAL_H
 
-#include <linux/export.h>
 #include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
-- 
2.43.0


