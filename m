Return-Path: <linux-kernel+bounces-336368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 540D8983A57
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F31DB2175C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24DA2907;
	Mon, 23 Sep 2024 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xqkol/wg"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDD42942A
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727131266; cv=none; b=aLOq13Ha+u5Plgk6dOG/7MFE4hIq5TGz1wzUvWQL5xnWhzQ6G3luMLDIkSFShRpugkd66r5/NtpZWEXnmb9Og1NhSQtEPXQQ+amtc9HR6pb6y3TKDXrLlZmv6ytWgMIFGK6DbBJG4bs6FOJGs6LrWHzSi6nQ0IuKfnJE0yQIRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727131266; c=relaxed/simple;
	bh=GSCd7C/d+ylgtXrc9F7rTXAgFQ4kzwVOtROXH16ndoc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GT3PSnWaYuj0sWQK0kuZ2CA2htFBHiXuuclwVz5fYKYmKRRww4MN8jG6sU3kkc2uoAqHw8ffV5nk3lcpT94QSq0ohv2g9Jo2l0xA/N13s2wYLtMRJTb6tajZkNl9n3m9/yy9LD0H4fzIHa641oo0sPAtnUe96Dxrb5v+xgyLeMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xqkol/wg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d683cfa528so62743537b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727131263; x=1727736063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZoULqqwj4G3XNtXjnOz7why+OLiXHg9txfngqFgB/jM=;
        b=Xqkol/wgJq9NI6dEeKU3RYZ/AyfGl6UMbxP8h+y4CylIonZ2DeQdF1bxRnOPhED33K
         0M0T8aWaK1Xn80HZVm2wlre50zqV+kBeUmbaARY2bS+Aeay/NM51sX2P2mM6StEC6c4D
         UDUkk+f+XtlkfUP72MrLUbwslM+1+yyd688k6X3HprUXUraFpLrgi92wBxWjKpEDtB/4
         V9OnlgioVOp3k6+bhLmADgvyfsIZ/fkCl+VAryUXeP/WRptY59JVLKmCuqMm4WEpBWpn
         I4+QJ1v+fJfmfDch+jvON3IkoybO1aVgsk3IH67mbrk/ti1dDZhTzyrdOV5hVyP0Uf/x
         BlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727131263; x=1727736063;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZoULqqwj4G3XNtXjnOz7why+OLiXHg9txfngqFgB/jM=;
        b=TC9W/lG3Tyr/QomW1yG7OUwMSYayI6feaig0ihLGT2O5PGinpI2PvBnnA4AZTbBN+T
         QdJ6LkL/Ys706ZBIGFC3VJa3XxawwVkMJ+fYoxmh5+klyvayuVPqZL0xhC2Nek0rkE0a
         EGxsORENfGqgLTcarHXzWMhBWKU05CLaQLeOzoPNkMV9dZRWi913jnKJMAtkhDMFsVZA
         lSzohqRcnXwwcHnhMklIFO6Y0ppSvSLQJHKsnxmIo/QKfSKTjXgYp0CRuofMV6JiJnEe
         Lj5UV2PLV6JR/U3ptgeZPaHyM9tESX3ZKBC6l1JOueOJEe14YzRURbXx19siqmo1qdcr
         2IgA==
X-Forwarded-Encrypted: i=1; AJvYcCWtcgJTMC5PFsayZEeonHCWWJBzkS/hI43/ck7fg/vXTfHMDI/k7iN5te2QEFBwmOxTuNXuc5Gqy6J4SuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcAPIIEd3ci3W5nhz4/2W70FBvihKfmOnM9gfSesui8JRkT3Rt
	wmTZKu20BhSfgGSDzkhvyQRO1gaQWIsfoEUFEin3l7aYyuOF868t2P3rIyqKmCx5XnzDkjpS8DU
	XUQ==
X-Google-Smtp-Source: AGHT+IEXpzIYcYsmTLKPd3jrRYMqBg1mBudgZ4U8Lyu2HY5beZ0fdWyVImEb0QiaDHKoCbIIu3DCYtSPThc=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a05:690c:f05:b0:6dd:bcce:7cbe with SMTP id
 00721157ae682-6dfeec02c4cmr1054977b3.2.1727131263094; Mon, 23 Sep 2024
 15:41:03 -0700 (PDT)
Date: Mon, 23 Sep 2024 15:40:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240923224059.3674414-1-amitsd@google.com>
Subject: [RFC v3 0/2] Add support for time DT property in TCPM
From: Amit Sunil Dhamne <amitsd@google.com>
To: gregkh@linuxfoundation.org, robh@kernel.org, dmitry.baryshkov@linaro.org, 
	heikki.krogerus@linux.intel.com
Cc: badhri@google.com, kyletso@google.com, rdbabiera@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="UTF-8"

USB PD specification defines a bunch of timers that can have a range of
acceptable values instead of specific values. These values have to be
tuned based on the platform. However, TCPM currently sets them to a
default value without providing a mechanism to set platform specific
values.

This patchset adds new DT properties per timer to allow users to define
platform specific values.

Changes compare to v2:
  - Added min, max & default values to DT property in Documentation.
  - Changed return type of tcpm_fw_get_timings to void instead of int.

Changes compared to v1:
  - Defined new properties per timer that we are interested in rather
    than defining a single pd-timers u32 array property.
  - Better description of the timer properties.
  - Since subject has changed, adding link for previous patchset for
    posterity:
    https://lore.kernel.org/all/20240911000715.554184-1-amitsd@google.com/

Amit Sunil Dhamne (2):
  dt-bindings: connector: Add properties to define time values
  usb: typec: tcpm: Add support for parsing time dt properties

 .../bindings/connector/usb-connector.yaml     | 35 ++++++++-
 drivers/usb/typec/tcpm/tcpm.c                 | 74 +++++++++++++++----
 2 files changed, 92 insertions(+), 17 deletions(-)


base-commit: 68d4209158f43a558c5553ea95ab0c8975eab18c
-- 
2.46.0.792.g87dc391469-goog


