Return-Path: <linux-kernel+bounces-569800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 724A5A6A7B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3900A16CC23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7440B2222AC;
	Thu, 20 Mar 2025 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yyL44LQd"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8A51EB1B7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478804; cv=none; b=B+T2dg+I51rG7daH2zfnPJdjEArCuLaYxEaMixfOyD1BJkeLFEiNZWoyTdhUo2oMBoJESV5eQi67fZqUu42LSg6fYC3cwVTVN2X02rrUHPVwvW+BPW4qgDxXPnfu7HielGMkAtT1g/o529zTI3YejwaT7VW8dYBg2syCaX9j7L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478804; c=relaxed/simple;
	bh=B9K1n/mGUHQRO2sjgH/aLUdFA/yNf71Yhz2hg79uIoM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KqCfDOBo+ZFuSpQ/XVwhLLT9w1iS1XnFOb6Jv5vN2/HhhvAEhFIZTFvM7/Itq8I0RpIfi+i+Z8z6dgeKJY5CUooyU22D38I8KOprXyCLwyS9axbFJu3sB76j7WHBLQje3jVH4V2+jEploTg1xls9YROVCoFuCk4L1BuQmeRUgfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yyL44LQd; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3912e4e2033so404916f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742478801; x=1743083601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w2mWJmy2u1GYFbgeDHhnsd96uGQJdZ1c4QTCymqNCsU=;
        b=yyL44LQdqGUM+DxrjB8sgROcvKxBzJue9kONIhIdPL776il7+t92Yo85RTWOY7WAx4
         HSilE6RO3cm0mzXw6CS6Y9u5qvPKYZTX8MtOfcVh0oUPfZMlYs5SfT9G1BMw+E1dZIly
         NDxyyGkMZyptXoL5CxCH36cs0dlchXL6AEjAmBD6o6Xcle+eufQFPOY32GRUKsDlwvfB
         /mEIBGjHGDa6dqablCzUgwidOhYfx7o3rZEOcS758rPkKfmDzyM3z0QlLw8vl+uAmnNa
         yH6RheVQEvx05jvJz048x3+Wl6R5WtMTVUhFMnBW9SNVBE/kNYVbAKazuIMm4DASCmok
         mVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742478801; x=1743083601;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2mWJmy2u1GYFbgeDHhnsd96uGQJdZ1c4QTCymqNCsU=;
        b=wVtNhd+fQOMZf6aY6PLl/bdwbHYOXbde7L7AhEzt6IM5qV0otwX7+ihj15EtDLIU3y
         u6xhJyDpx7oPPEBMJCOyhgQ3VCGvrHWp1WTkTQB9yM0VGjAbXSCsgjyqNTrr+PA/FRU7
         8MT1Vx2Lca+VrL0vbFfC6xRn8Zp8dEZCHJ5JWSVTF2pnnTg7FzPdOvAq3T/qKIMAyqdI
         3zfFsSRce/GYL8YmNIv9l0JHR9riVzH83MXAdyTcXtUAJDMHIRINbuq5BXv/AiUHCseR
         eT657nNlx2IJPsfaLmQWi4lzEcJg3xiY4aYzxkPe62z5T0zZfrjC3Gy/j3s4fq5skLZ3
         O7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU1mIiut7YxsCPoCdwHXxUXpSMA40GUDoTNIrriNerxYsIIYfRSGJgmSalc9yoE1cB7qguq/in5bFlV2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXUEnxmaHQ8x1LqERgu1JxriX8lThQ/mWWQz6ShcTTMM3S16yh
	NmUbPvUKpZgFr20Up4Iymm9qIpAMv/7+L2fgPuBitw9H7fRcZPZ8jwoKEvVfyltlLedldkjtWKa
	E52QnYySfWVv6wg==
X-Google-Smtp-Source: AGHT+IGbAKOA0v9sCj5t+Y2E5fvJS93xgACb0e+jTy7qh0irV2sZVlA2Dh0gpDE8uLrWnIONoWBuxiFgTb3fPD8=
X-Received: from wrbfq13.prod.google.com ([2002:a05:6000:2a0d:b0:391:35ba:879a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6c62:0:b0:391:41fb:89ff with SMTP id ffacd0b85a97d-399739c9122mr6345814f8f.27.1742478801739;
 Thu, 20 Mar 2025 06:53:21 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:52:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALgd3GcC/x3MTQqAIBBA4avIrBP8yU1XiRaiY84iDQ0JxLsnL
 b/Fex0qFsIKG+tQsFGlnCbkwsBFm07k5KdBCWWEVoI3dPzCJ2ZfufXBrhKN0VLCLO6Cgd7/th9 jfCdxbWddAAAA
X-Change-Id: 20250320-vec-methods-adfa41e55311
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=958; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=B9K1n/mGUHQRO2sjgH/aLUdFA/yNf71Yhz2hg79uIoM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn3B2/YEE4DuqeeNw4iulKAvSm5h5v0pXccvgQM
 m603M4po6aJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ9wdvwAKCRAEWL7uWMY5
 RuCKD/4u5F0YQXOJaajHS68W4lBQC0WaZA2onPzKp/531kOq6XqAvMkH0omhlTYluDcO/XWLmo6
 HmuKTuwa60AMIDKa5MUywpj+7yBicCpfr7oayPNE8IWY07uuJsyMKht+J9uSYg6P1IATiszOnDn
 BL+DIZELBr8UDrgY02QBy5AaK7r+a+raoLZUiMCKUkLAb2mT/ZEFLGQbqTCivtGpajQJ++e96tk
 cL3mK2ISRyEqZ6GaI3TReQhUGENBzRMmQ49IKgPXlw9fTUvA0SAo9zzCtADqa5BKsUoFGUYeagj
 8CVEkWtYFA1gHP1bcLX3DyzneWBvGVRh7jLZCZMkkP88412o6pt4ZKasHXMVzUV9zslN3O7/2lh
 Fakv2DcouhegBWW+AgtqLLZwxVf0xB9QJVKPMr+qybK7cApUYrnfsKEjJCWUj8caMSZzlwSPk7U
 kfJXj+p+goja4/pRzHQ5zHj1o28pwsstidVJwxQxeb3t5Y1ddyrn4n9babbTAHOzF7fJFB9GHDl
 5twQLgUYNwmqz/dndKcJqf659jrILpEErBUaGPRJy65xBfWdz4gW0qh0uW85nd0TUa8xTWWinX/
 xa7FifW22khpPOU5+qINzHY2hcwVmMBLhWFT2mDXbetjR5dftmCKYBKjzT31tArztJ5eZEfcIPJ BYc7gKRCr/FwQFQ==
X-Mailer: b4 0.14.2
Message-ID: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com>
Subject: [PATCH 0/5] Additional methods for Vec
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This adds various Vec methods. Some of them are needed by Rust Binder,
and others are needed in other places. Each commit explains where it is
needed.

I'm not sure what we concluded on the set_len / dec_len changes, so I
don't depend on that series for now.

This series is based on top of Vec::truncate from
https://lore.kernel.org/rust-for-linux/20250316111644.154602-1-andrewjballance@gmail.com/

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (5):
      rust: alloc: add Vec::clear
      rust: alloc: add Vec::pop
      rust: alloc: add Vec::push_within_capacity
      rust: alloc: add Vec::drain_all
      rust: alloc: add Vec::retain

 rust/kernel/alloc/kvec.rs | 147 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)
---
base-commit: a337a03281efc4553191b432d757d4c04884bf4c
change-id: 20250320-vec-methods-adfa41e55311

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


