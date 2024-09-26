Return-Path: <linux-kernel+bounces-341148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A8F987BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E931F226FD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FB01B012B;
	Thu, 26 Sep 2024 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3gET8Axi"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBAC15A87A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393802; cv=none; b=humjhhm1nvBy3SC21zjTtmU3dqwG6yB4x8nnQWUavBzqdQvWZ1+8Uvr/SOTAZx3dZKRoxLJr14EfVITcdnux1IrnMt4Fq6RJAg5EI/Egy6DlY8oy5eAf/Lv48KYT8xyy8f+azXAHrv1QFqVhYfrIX7BxEFyjy/i5uA7hGFpmmik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393802; c=relaxed/simple;
	bh=btuG0rdXl4iycnF0syedQgjixOF4epBMnIrgHcGRgko=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VUJllCyVvMb2nz8L3emjYZTWhNnaR7VWfFDZTsSftOGxglVv9KNx0tvcDAkGMyQDtG3qB3QTHxZA7x7T2r8jm4Q+icdBqRa7d5EJ3+rY0LvmiUN5LGUPj+yw2m1zDCd5GAYcEfKwe3KeHzE4zBWBvHPN9UzocNWhmFm++Hbxmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3gET8Axi; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71926732629so1661036b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727393799; x=1727998599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zA+NTTDrNsYiLWyeaQyWbu0C8Sd9VhUHtR4/aWFrb0=;
        b=3gET8AxiM0J+OkjELMWE89de13/XGyCPhebRHe0cAhqg52vZXhE+dfQqO0c2uvwUmd
         ginoXg8KFDmdWiiIvzUeQAGCp6zw3I7Q8TqVPKixFpxy7j47hBS/OULmyGTFO6FQAVqE
         aMHp6g64WnbkzNCZrl/3PYjUNg2V4nWIUlfoZP4uIjikAOlecfO9AIwyAzdYvkHcI9zt
         HjrN1mwsH4/Hj6Abnq0lbsLuRIV6qiB04BRx9WG5MNhVRR3E0Lk+sv1uFhJXOCcol+3Z
         vvYVuDdIKtofHKAzOhgrUhyWdnzQPT8/y5jxBMuW+9oHJmYpZAmMx7vwOvSBGPJv96Sm
         rCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727393799; x=1727998599;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zA+NTTDrNsYiLWyeaQyWbu0C8Sd9VhUHtR4/aWFrb0=;
        b=Pfcxl7WvgkHGF2GJNS/b3F2xIj1yGjJzftzyxZ4qaw51dDhadsdfT8rOaL1JgJ32Pm
         T34uSNw8wxL3U8gJRU+rrChF/c1dfS91INR5Fq4xaDfe+CsnaAhXTFSBvT9jNmsSTWz9
         TqPJav/pKdmSDgk9nWnr9uZME73Llim/JleI8lwUI7qzdOpI4mkWR3vqmam7Ldepy1nB
         BSCnpTKDqGQwuqUxIjjwlZrQI0J1fYv0Xp41IPjNgzVwIXtScLjpqbi1jFv18mEcNLkH
         2WSug4ndDFFKfDKjyGYzcv/IGKKPRb/6nSg91DXWeU2Rv43hys5nE6mBgtkqa0RMS87h
         y/aA==
X-Gm-Message-State: AOJu0YxYqElrTbEtWCECMUDQshjCqabJh81UdkZZQrC0av+2S2eGaYIp
	1CWSfkG0owG/+rLkU3a7pI4F3J0jwSWPzc9/PyxrXWs+xGXGFer2B4UJg8eBlPMN/g+V+O4sdCS
	zCbJMeChm1A==
X-Google-Smtp-Source: AGHT+IGCxy+wJv8OHzbyv/7j+8lY+SUfQRcB6l5MQseGCOvdCvySd0fiWD3iueTVvTRZKAMAXhW61Dy8Pss2bw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:aa7:8b46:0:b0:717:9865:235e with SMTP id
 d2e1a72fcca58-71b25f3520cmr4837b3a.2.1727393798608; Thu, 26 Sep 2024 16:36:38
 -0700 (PDT)
Date: Thu, 26 Sep 2024 23:36:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240926233632.821189-1-cmllamas@google.com>
Subject: [PATCH v2 0/8] binder: several fixes for frozen notification
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, 
	Todd Kjos <tkjos@google.com>, Martijn Coenen <maco@google.com>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Viktor Martensson <vmartensson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

These are all fixes for the frozen notification patch [1], which as of
today hasn't landed in mainline yet. As such, this patchset is rebased
on top of the char-misc-next branch.

[1] https://lore.kernel.org/all/20240709070047.4055369-2-yutingtseng@google=
.com/

Cc: stable@vger.kernel.org
Cc: Yu-Ting Tseng <yutingtseng@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Martijn Coenen <maco@google.com>
Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Cc: Viktor Martensson <vmartensson@google.com>

v1: https://lore.kernel.org/all/20240924184401.76043-1-cmllamas@google.com/

v2:
  * debug output for BINDER_WORK_CLEAR_FREEZE_NOTIFICATION (Alice)
  * allow notifications for dead nodes instead of EINVAL (Alice)
  * add fix for memleak of proc->delivered_freeze
  * add proc->delivered_freeze to debug output
  * collect tags

Carlos Llamas (8):
  binder: fix node UAF in binder_add_freeze_work()
  binder: fix OOB in binder_add_freeze_work()
  binder: fix freeze UAF in binder_release_work()
  binder: fix BINDER_WORK_FROZEN_BINDER debug logs
  binder: fix BINDER_WORK_CLEAR_FREEZE_NOTIFICATION debug logs
  binder: allow freeze notification for dead nodes
  binder: fix memleak of proc->delivered_freeze
  binder: add delivered_freeze to debugfs output

 drivers/android/binder.c | 64 ++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 15 deletions(-)

--=20
2.46.1.824.gd892dcdcdd-goog

