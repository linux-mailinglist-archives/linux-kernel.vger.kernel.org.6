Return-Path: <linux-kernel+bounces-562370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C129A624CF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8784519C4352
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C17E1885B8;
	Sat, 15 Mar 2025 02:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2V3ZK63"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819FC195;
	Sat, 15 Mar 2025 02:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006596; cv=none; b=pbUZ46bHWjtLjgtVxW4vNELL/YnNzOZaj4vwVcoiw/idNlBvyE4CfWqcKH+1tCecntDRgxae/l4jVpY/Q5vqiKq65GBuM4XvH3h5MWENrMu96q526Zr0SbSRVff2ihPl1SAZ/K07XCcBooBWe9aa55tTM0l+bG2Txv6YZpNJ+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006596; c=relaxed/simple;
	bh=4BkVTlSCmwx0Bh3zJofQLJrh0IHzF3b8G7aattxY8mI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GkLAJuagJemjI7Mahdl4pSYhenoywtfHqTHWqjtTVvPbdoNGaGgjqFX3TcG9Xijp+/noR6QO8X1ga9utvMtYcJ110mQoAYtUCozpiyZ5E4FKBjLwzlEVeDtMjz4OiOBZgcBiFKmN0sdOEBp4KGYQWzZogKbNq4+cMi30lhVINbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2V3ZK63; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72726e4f96cso1937601a34.0;
        Fri, 14 Mar 2025 19:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742006594; x=1742611394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XT8HYn51QyYArt1rrJadjd/k3O2KfE7Vq5w9HaXKeH8=;
        b=V2V3ZK63cmb+hRRiKCpZGivvJPggw9hV3yCm8xwbFwcZX0W38NvFrHMYWyWatT5J/s
         HEp4lNWgaOMu6DTxQNK45afvfRC0nFeP0Dgm6aQz4RVh1qjWoDmLyQ+UzogDDicGI7o7
         qVD6AjV4WU+EVUW8hY9HZuSX+MPwfvkGYuJZz2h6gu+q2TxNpQsU9WyaHg7e2jqcdnY4
         Sm+PxuJNw5ayDs9WGQRqsUbEmD0R6j2mxbWo9IwmmzkaEFl5b7n1usMY0PeMp7lwFQQO
         EoYsjhx5HhKdWLXIIDcSkQS8fmNdU4vgrAY/UrpGgp+KwowjAIe8K3PmRtE5eohLs/zg
         8+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742006594; x=1742611394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XT8HYn51QyYArt1rrJadjd/k3O2KfE7Vq5w9HaXKeH8=;
        b=QKVCRvz+d8xCrKy74EZhFFmXw0Hx8FgS74eOO+KUMsHXLntETZQhvRkHja/NQ5Jw6q
         RY8nhRL4aZFtFIYGpnNxCIqiA9N1t9FhBboqO2yYhm6bMYf1eTn48lgyoxiH9b1R54hN
         1NYaqWlOQ3c1/MXVGarqGZeXBXGN6OM8qjMg6ah6On808bIPfE9zAt6GYcFHFxsX2+z+
         H9/QJPt5z3BQXB+3SlbBbmunN/6IhgfAsjdM3gFpRb83scbBCoTfs85KwJ044lCm7QNs
         vlqWYbldnH4Z6xrWgDSMP3AVxqGzzu7GeyoLg6xsI8P5rm24WQGi0bQfLXT4X8XLs1AG
         6g5g==
X-Forwarded-Encrypted: i=1; AJvYcCVUDJpLEhaAeive3d3AS/qM/1sP3wntUWNuAW5SFgUVyevd7R1zvStaKzsAFcJxXMkHO3Tkphe8xTyRsdzuX2c=@vger.kernel.org, AJvYcCXC0OVcDkakL8nPMbWZpJvtxIxJb0EKVtevuFuMNsL0f4EYTSBHGI5i91a1ZGTQrLh9DngjvapqdNM=@vger.kernel.org, AJvYcCXs+t+LVhgdbJVqbJF/3WewB5do+OhwbM9bVLHVsioZijFrmvcUsc6rXg/1VawS1oCwkIsYiNrFF6tAUl5b@vger.kernel.org
X-Gm-Message-State: AOJu0YzEwDjCTVm8pC4Gi9gbs4KTOI3gN2/jG4QG8Apnx1ZQuLnDIGlm
	jnewutVs+q1GpmkcFesp3JpgNrAJaI9IbUAaLdGsKJ0h9uoO9WHB
X-Gm-Gg: ASbGncvBDVnTIY3DktTx+Aml/q4iPEeyIKN9iPzjKGy1dttnuABrJH72sLV7RNixMsw
	k2DODcUcj2J/SbiaXXogmgQ11EhNJFH07tVFE5v21FX1RWpMB4wiZj+kz5WiCG72TPw9IOAhWWY
	d2WmjwVfLehTBKgTjI/vzsDgFplvsBw7yHjyMboDWxmtn1VYH0FXwcUdvmfX4ylQiADVpga2Ct0
	fTAcAE9ZyWz7WbJOkmCASR1CS98hoVQ9OYMM50jHylfZmNFACBGWfGrbx1Kkfai7xnSApnA3QLQ
	eaCyd/9uAwOaMGVzZSGACXM2UpXcNn3qsTeLTOOB2uqa+pNM8btRLSdL7KCSwiRyJBPD//nSecz
	/2pYJB61NJZi7Mn3v
X-Google-Smtp-Source: AGHT+IGOVE5wyNqOM7/fv6cFlMkko9+hHKdXOnxrJZVF0sr7+N4uWGsQlnAMOYDClGQej5nEuFl4MA==
X-Received: by 2002:a05:6830:2b28:b0:72b:98f8:5c95 with SMTP id 46e09a7af769-72bbc23c75cmr2905119a34.1.1742006594247;
        Fri, 14 Mar 2025 19:43:14 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72bb26bb82dsm882990a34.32.2025.03.14.19.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 19:43:13 -0700 (PDT)
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
Subject: [PATCH 0/3] rust: alloc: add Vec::resize and Vec::truncate
Date: Fri, 14 Mar 2025 21:42:32 -0500
Message-ID: <20250315024235.5282-1-andrewjballance@gmail.com>
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

Andrew Ballance (3):
  rust: alloc: add Vec::truncate method
  rust: alloc: add Vec::resize method
  gpu: nova-core: remove completed Vec extentions from task list

 Documentation/gpu/nova/core/todo.rst | 10 -----
 rust/kernel/alloc/kvec.rs            | 61 ++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 10 deletions(-)

-- 
2.48.1


