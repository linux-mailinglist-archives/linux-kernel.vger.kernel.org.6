Return-Path: <linux-kernel+bounces-532263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14934A44ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3C04232A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D941A5BBB;
	Tue, 25 Feb 2025 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSGLmxjC"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FE51A5BAF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509110; cv=none; b=qPPIuUHH7T/lr2YsBqH40VmcbgPSGORJBjgKNtCyMn/b9eFnt8Uu63FHxmFTfCh4GP3EAlE0KIyC5w21kKgLuZBIcBS+7uw5KClR375OG4RkhBq0iy7v2i57BfA8JmmBqk0WudQnwF+AeJAgMsZBcIDEEaoe74eUGfSkes5uy94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509110; c=relaxed/simple;
	bh=6IihvIBx7CTuNvNSW0s445hgmcegN2gSRUziakg2f4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhgrc6U8kqDKM55FsVw+cx5YbtUUuBwTaSoH1q/A7NzSfhKERmMvYTSESdOeq0NYfMBJ+ee86IEhh55TPYx7Ui3Hm7ASF0yw4OMHzackhgofmBcV3/xCd48jXRbnUi0NpcSGb8yUJDiFHRFlqqb3dwnRyAuT4uUn0XM+4iEJp10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSGLmxjC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c2a87378so101694595ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740509108; x=1741113908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IihvIBx7CTuNvNSW0s445hgmcegN2gSRUziakg2f4A=;
        b=PSGLmxjCWnJD3ECgg7VioQuJBIAfiNsLAIHS1jNmHLrGNIFRFp4kLWtVyCqdiXI80V
         OUygeWOb5lxKbcy+9VxyspSGS2Ql46stYCjMhGYlBj6XEHiWkXPNve+93C8lg4AMf9Ov
         GwiVRVsv8PHMTY1O/OvxobgYL/07/Wo6e/4wdkNeyfihfAs/KCVFdVfa+jVAGq/VgVpK
         IsHQDO7h1ckq7Ja3usUhQwcyKe/w39UA70ioVgQ0maZKlyhmhQaRSsq5fGTMfX66Q4h3
         5QQaT4HEha6z/bwi1eL/VLb8m3E3p7JkPzPF53HC8A0ieKlk3cCXGeMp+2ZGLvM8ork9
         GVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740509108; x=1741113908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IihvIBx7CTuNvNSW0s445hgmcegN2gSRUziakg2f4A=;
        b=JmJqw7YTwZT2DGXOG8NVfsN0+EQx5g+zFZR13EBtF+XFdgxPApSeMXHbLePFYjfm/e
         yb+wavidAyOGwyLfELZQDEGpAAsX00TDu2z1etcOnEI7QS+0WMPO1N3+kFv97fX4i5I8
         Q0Kg+oxvarGhjAGmKH9DsU/kWREytGeWH+2zenvAcLkGtpIkXZ3cHAx8M6TXV3D8ypPg
         ichvGEnZgWc3KIlBzr9vvf0pjHcg5d5LlQ/BIHScAHA3KMuTxPyCtbV8esMPQrtW5CbC
         qBfMOhTb+W5axsa8jTUSTX5rXzHgUjuB87O5fCKXNbg8WKQlSdEg6Gwy1zz0hmOFgjBL
         E63w==
X-Forwarded-Encrypted: i=1; AJvYcCVWwFCSzLI8WAzcTgq8b+oLf559cAtxfZwbC5ky+9IqvkoLEnMDetaPrKbqedGCRsoZRBaGx+dXmMp9jM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK6MYzwdnEC8MjN/YayRlaSl2as4MsY28gKLiAYcQsstyjLUFT
	lDcYJRpXQez3O4ryIU9cs1X4zWMK+AWijtLQJsj+WSthyePiQ1xR
X-Gm-Gg: ASbGncuDP98W+zzcz12DLOrABrnshUJfkbJJ7WlG19sxuWKerHwXz59ynxY7hjGq2n9
	h4DzaXf9h5PApMiDBNRkj0cdV6xdPFR5S0gS+X5mbZRzSPGPKhr1x/SWGcbF6VgpfcwMyZQRvlK
	JgBlpUz1MnZRvkjNrmoi+w1XvqoJ3U3oYjViEFRJHlCDMUQhoaabWLyK/FLKY0rpipd2zUmX1uM
	h4wRa0AXrmuCVmakaMzOUqyyY44/lbW0qrKYMHTQe7PaVF1pkSDyDhCCGIYv4xnPX3vwUwZ2QBt
	cWCm9s6wuv14EpCFI0VpkCQdC89Qyh5atZTBuXE253EZVkD5cS+/
X-Google-Smtp-Source: AGHT+IGApZrzeywhChiSfHA9SwSFpXhrOiTvaZKX1WlvvQNLrEXZxvDkN6xmmX2mZ4h2HyS1cFdFWw==
X-Received: by 2002:a05:6a21:164e:b0:1ee:aa06:1a48 with SMTP id adf61e73a8af0-1eef52f7e0dmr33718090637.22.1740509108139;
        Tue, 25 Feb 2025 10:45:08 -0800 (PST)
Received: from ideapad.tail50fddd.ts.net ([139.5.199.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81ec94sm1913969b3a.137.2025.02.25.10.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:45:07 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: akpm@linux-foundation.org
Cc: ayaanmirzabaig85@gmail.com,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] radix-tree: Prevent NULL pointer dereference in radix_tree_node_rcu_free
Date: Wed, 26 Feb 2025 00:14:56 +0530
Message-ID: <20250225184502.1222081-1-ayaanmirzabaig85@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250224202723.aa20e103b6b3bc3de65ca7e4@linux-foundation.org>
References: <20250224202723.aa20e103b6b3bc3de65ca7e4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andrew,

Thank you for reviewing the patch! I’d be happy to assist in debugging the issue, though I’ll need some guidance since I’m still learning kernel development workflows. Could you or Paul clarify:

What specific symptom or failure prompted the need for investigation ?

Are there subsystems or tools I should focus on ?

How can I reproduce the issue locally to gather more data?

I’ll start by re-testing my patch with CONFIG_DEBUG_ATOMIC_SLEEP and lockdep enabled, and share any findings. Please let me know how I can contribute further!

