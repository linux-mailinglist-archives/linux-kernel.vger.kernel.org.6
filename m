Return-Path: <linux-kernel+bounces-562978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4547AA63546
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 12:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417CE3A8D2D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E11F1A23B8;
	Sun, 16 Mar 2025 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAHJVaLK"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F6510F2;
	Sun, 16 Mar 2025 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742123834; cv=none; b=tWuKTaKUZftkOKJwss2iMJnUvzTScRO3VFkinLUIhrJ2V/BQw87ZKi0ChJJhugWuqbk+hIkFaPS5Vjymj15X0koaLM9v3m6VHykPLPPaTgafyjOIgHhj/oOc6Bk2/xmmM3XwGXRfh5PTBD4Zmy1Br9uz2wBvSaBmZS/vwKBOyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742123834; c=relaxed/simple;
	bh=+gAddgEyWK30UG5V+WNUHSesJ5OD3hxKBrUiQQHq0ik=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RCQkXWkUWhu8t8yT7MwGGmDE6J9GNGMwuyy4NfbBndiyTj8F1IRN1rAwjLIczKC1vKa+dmbH9mjgTmZZvZoCB8PptcfIxzNvqLfwUkfTj46FEDIeduW7ak5FSEj9U5zywyIZ2rBQi3SwJtsD+lf6HfGl/gFBGp2SlhKHGQ3LbAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAHJVaLK; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7273f35b201so2181444a34.1;
        Sun, 16 Mar 2025 04:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742123832; x=1742728632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+7jSFadTV9A/Fg7psg6f9yxG1LE2BjltriuoZ2nFmIY=;
        b=TAHJVaLKNFUloeSKi/NK8ZsiGF+EuDU+wfOEYrfauRo9lG4GYgO06wpQqTqt8mDbBC
         xhxN3Zr/RE4WFw7HKxvLFMqTenkNCLb94ao5IssceCysZouKW24crMNi+fAuL8Vrq0bW
         pnxsUryO2gdFS/ksxPaqkfDzxJ47mxggRrDaSOy1c+hxXawcVnOEbXc0PxDI8WfiS7nH
         6oR1HcbJuqLRCrtkrHtv9aL2wmq49DFervJvRLtJyILRDlh2Bn7r/g3PBEzqO9ZWdU/b
         uLDFcT2h7FDacvNMk0RDbqBCoIzOY+Hb0aNUbFbcoEkTHvlPcER1nEMzNwFU+weBkXYw
         C1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742123832; x=1742728632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7jSFadTV9A/Fg7psg6f9yxG1LE2BjltriuoZ2nFmIY=;
        b=IThOdVOcuBEJRpvspI3PmziN08zoLHEzru0zMCZmwlopllDNDVsksyy0FnQv+xrWqz
         goNLdMx2/8aF0eCSSjFX2OoNAVElDxZIOfZQcwDx2814kS0c/hVqITQHkzvnt3vwxs0N
         5uLjI/GT8YN89Z5Fvjm329CC5WLjJuerVCta9mr3mVzYNCQKuMQxRq1SsvgRqbQp9thZ
         bEZ3t2HMeOwR8pwyhGoBXvqioIZ7kipI6W7Friz9+84wgQYWGW2w43tbp8bv9cIXqhkt
         5wE44lHu4/BCbuhtCQIizmCWq1xpeMZ7BfK0TYtJW+17nJbZG4grAjQo859Ul3DU/Oop
         CMhw==
X-Forwarded-Encrypted: i=1; AJvYcCU1f3afA9SMn3o9OVtbevslF3Z94Lp+cVa2gmFexQ8kec/20rc8t3lpQC8QSA+IgAJqsp9lChce3kBWqEWz6Lo=@vger.kernel.org, AJvYcCWk2tl3daTJMLnz+rauKMsj48TDKtQCE3Oc3GD11v5FvWV1uWkZcoOGDTqyGLGEOIwIvZdmELDEi0lcjcd+@vger.kernel.org, AJvYcCXi01a/nGaP8axaH2J4W7uOxCXikWBJ6OHNGXAVDZNP7Ntw4XbXxnwp944je2lFJe9zh55mD9wuomg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1IgyNIz+cflXCMXgOZeT3rU9l94+Z2BbXnjVdGMM36JzMNwHX
	vlIAtmn5T20tHpqDfTqgx+A0Hs7twq+1WUtTWJxmrzQ2m5JuUVKF
X-Gm-Gg: ASbGncvfCpk3bJF6qKpKWPPU2tiFxgSXHul4NMPcxY1tsgqGFS0oyjSKq+5TlRxREbl
	ZAYiCq/gLQyK7vzD+im7tjic/90q98duIgVpGIjRzliWm57yvPXG07mRYFJkMFOwm/5U4UcG3LU
	E0HtiCeiwDiEkkNOafdYuUaj327CHszMofpXsoZNg+SJmPdAon6EzDzEiTEOb0OTIiBepYnIM6v
	x2CbBQPF9GELSSTtiTpCmJvRRE7a1jI9yTvbT07VFEq91WCWjuGKWL0RBe3WLcnaBYmdPU8WPW8
	4pW10BsqhzXVGW3qI57k6XCTz5txFmiigXlv7/wci+iwV9QOFlEHjmYdRF8C5m2UMLazu0Ywcoy
	rtoV9DwrX4aWmsn7e
X-Google-Smtp-Source: AGHT+IHv5t3gQ55bzS+qLlelppCqZRdREWE+WDUuqOccgurK2T+zzctVZElnhWhnl3PVs2DrOmfNeQ==
X-Received: by 2002:a05:6808:10c7:b0:3f8:4523:2697 with SMTP id 5614622812f47-3fdf0928cabmr5073566b6e.37.1742123831755;
        Sun, 16 Mar 2025 04:17:11 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3fe832ce015sm715978b6e.7.2025.03.16.04.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 04:17:11 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	andrewjballance@gmail.com,
	acourbot@nvidia.com,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 0/3] rust: alloc: add Vec::resize and Vec::truncate
Date: Sun, 16 Mar 2025 06:16:41 -0500
Message-ID: <20250316111644.154602-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements the Vec::truncate and Vec::resize methods
that were needed by the nova driver and removes the corresponding item
from their task list

changes in v2:
 - updated safety comments
 - fixed rustdoc comment spacing
 - reworded commit messages to be imperative
 - Link to v1: https://lore.kernel.org/rust-for-linux/20250315024235.5282-1-andrewjballance@gmail.com/

Andrew Ballance (3):
  rust: alloc: add Vec::truncate method
  rust: alloc: add Vec::resize method
  gpu: nova-core: remove completed Vec extentions from task list

 Documentation/gpu/nova/core/todo.rst | 10 -----
 rust/kernel/alloc/kvec.rs            | 62 ++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 10 deletions(-)

-- 
2.48.1


