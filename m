Return-Path: <linux-kernel+bounces-337513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E099984B36
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE6F28156F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BE21AC896;
	Tue, 24 Sep 2024 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="faxkAUmj"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858011ABEBA
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203445; cv=none; b=fyjSW0ybYMyL5jE9nVoeYHAo6vqUtmktLSzGU11GdKTH/Z44PBxT+YcpgxNDvuaKB5wNHIc3dNGRAeT6zWMcoVuOckHqloHrBjNbsMx+2sVNsYqyQcaz4UJOZaBKriMchgdXb6RZJKr5uYOarKFLSd157WZDFgu2vQWXVac+ocQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203445; c=relaxed/simple;
	bh=kpIYtViOQeWQiFTd/NLgMquBDxjgF1ZQgKK3T4bn+cg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SS+ueBrK5iYHNYq9wxKJRLa8iNR4SLNTN9hKojmgMPPTcQMNuq9RWPMI0C1SZE1X2Xx1so7d3X0T4QojiBAt9quCqok1EPuGEc3A4qqkmJs1FJ+I4xyxsoAGuEdFsbLLgrh1Ku3BHTavY3SIMktyC/j4kixg6Td7jaKA7coyqv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=faxkAUmj; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso124085a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727203444; x=1727808244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1oXC8Fyd+mfraJhY/OY1aVwil/UuSylKa/jz0IG2oVU=;
        b=faxkAUmj6fNd11rsZgceFOmi9uJBfEwIRBBX2Is5cXUdIGdAxRmqHfBgj9+zPbSSzn
         TFBM7gSz4jbWMWADge6Itz0piVrNepDiVFH/ycCVwtLTyM5YhKo7D+IeoOaAT7PiaR6V
         e5bWG/jfI8gLCdUIyCoIpnKPvOVaJeiWLGMSo78WS45TGhlrjb56sG6i4ttRczQGMqA7
         H6rdS9oTfkGu8xF99iZr2dgqgsupjXTmTF6/2j7EZVtt1F8dQwKEJTf0aPE8V3WFr9GN
         c65tWWjGnBdGnbsZcA39r1JYgnT/YqofqitjQkChgtEPUne8pcGEHxr+WUR0kTj3szrO
         V3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727203444; x=1727808244;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oXC8Fyd+mfraJhY/OY1aVwil/UuSylKa/jz0IG2oVU=;
        b=pUFdOKk9TPYjTk/eyEA5wE48F7krv4COKw3sTCbTRBnoyxfAiWuHBjmJd8sZfNgVBq
         QBMrm6+v3/XecYEpTNJy+GuejjaWZ5BIMeqbDODFwzBgSpWts3dSiVg25+hjx7GPpmU2
         NpMgqR4VFyApBQiertlVxQE/rEMLUf8LFA1YaidMmwdYgBHPFrWp/DPS+hEZo+65ANYN
         ltvUZHhA5dxoIjUHV8U9bqYUkuT1/B7ku0wyRIa6DOMS/R6IQvwPLyBitLsD/HtcTv3j
         y3G7IxW9De7LJcoShhHD55+SoyzvlRpV7MlkjwmTRGoqjJuILfvSFK+6fSL6989tUCVs
         w7Yg==
X-Gm-Message-State: AOJu0Yy0VqVvTIv6QEwrVSxAV3NNzmf6M4n5a5ACbRjhAKhRWqzPWRwW
	EdghmvV0cfQyRA4pcToOj/64IkMKXfBB+OHzOrcUvWCqec9r7ipex2lHkrdiLv3rM42iL7OhFb5
	BLLk1ndOdcQ==
X-Google-Smtp-Source: AGHT+IFbyC7MQFY9cq99fUMRJyL2CLYOxSU62ATMuruSt9AJVRvuWwWgZ0ZDePt6LkCD6G+9LD8GCQ9u2gPJyQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:1208:0:b0:702:4fb6:8724 with SMTP id
 41be03b00d2f7-7e6c1a24f4fmr180a12.1.1727203443587; Tue, 24 Sep 2024 11:44:03
 -0700 (PDT)
Date: Tue, 24 Sep 2024 18:43:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240924184401.76043-1-cmllamas@google.com>
Subject: [PATCH 0/4] binder: several fixes for frozen notification
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org, 
	Yu-Ting Tseng <yutingtseng@google.com>, Todd Kjos <tkjos@google.com>, 
	Martijn Coenen <maco@google.com>, "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, 
	Viktor Martensson <vmartensson@google.com>
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

Carlos Llamas (4):
  binder: fix node UAF in binder_add_freeze_work()
  binder: fix OOB in binder_add_freeze_work()
  binder: fix freeze UAF in binder_release_work()
  binder: fix BINDER_WORK_FROZEN_BINDER debug logs

 drivers/android/binder.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--=20
2.46.0.792.g87dc391469-goog


