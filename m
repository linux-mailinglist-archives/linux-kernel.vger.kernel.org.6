Return-Path: <linux-kernel+bounces-349729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A373598FAA6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C166B1C21B94
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430031CF5CB;
	Thu,  3 Oct 2024 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="AwsjBeeh"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39935186E3D
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998745; cv=none; b=r1/A9vynYeavWvL6lflMMbvK54Vd9tQWWAugwChpo7zF/fBFoD3ffodFWR9aWe/aSTgkr+lepj3ufBoN7VAPDWZGG7UZh+6oJ8ipBckt5oUy+2OiKeOmhkeY2q+ITL63BIK0Ynipd68uOCbUYOL69CyDezNMjFhcdIB6ofn06e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998745; c=relaxed/simple;
	bh=C+PeM70xzurWIN1T6xBQ4odwRcIf2HMMfSOBfc1Q5Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PVCCq6lo1tu8+9Ipy3S0TB64pHyUrznM0SoQXYkkkonngBXumvzGORM60WG/mvU7UgcdeQk/iJwVxZ4xgfAIr1mh2PTeip/MWZDEPy8ojScPFjgDycCBWB0EEii9vl1nUjXc0XtloMOez3AXhwEtv21ZU3gLS294GJ2MzRz4Nu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=AwsjBeeh; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e091682cfbso1212332a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 16:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727998743; x=1728603543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X5uM8+CsvXiU2bmxtLKhHDD6o30h8WQH0Z1Yw+U9EME=;
        b=AwsjBeehyZ1ltyJWjJ6ntBE4LWrHicHWsAmKHzCr3AxCzlcwjahWzohP8M8YW7j0Ge
         /CShp4c63hzHnvczG6zTn9jsSE/zTt529XEtOaHQIy2lE5tSXIgMRQ/0Qyr41d7OwNt2
         8WiywDijAHUTl4q8ohNE+t/3SY9+/4zRhqb4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727998743; x=1728603543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5uM8+CsvXiU2bmxtLKhHDD6o30h8WQH0Z1Yw+U9EME=;
        b=ubMYhNvf0gk/ltzcduzD62dQ9k94W4DQMYs5rwwfLFEXNU3SjtALCEe3fz2UKYzHbW
         v7WV4kwAFK8PF/0F9/tm4dSYCiKpMdFDBBiRHUjn4vOoV824xc8lGa5ufZIIfn5wqWoe
         lGUtEGUje88oB23JwopkRjxf6/OcCcx3Lkgs/GivxRcmImzfZx8Fn8+QwbB0PgjP+Ap3
         6oD8JDqO/kgNeXhkVMJF1QoWstoaIVIax/t98AOcriRoLqiSaQX36bRBXkSmy6QwbLeb
         9v8V21R/Fb857V16YPUaRe4lAt3l6/33G8G0V+qcX48fW2JkfZ9+iFRS+tKNDM3w7u/I
         9rFA==
X-Forwarded-Encrypted: i=1; AJvYcCXQc715n+5dRZBgHbV42oNgaIj1uDx5aT1ergc45BB0pZ81S9mkAPTsbVrvNso0vfRuouQbvlLdLbT4S68=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxK09L7lqkjZXChA9U2wafJ4QeNdqeumFuM4k07lz2lUhchmqN
	LoCpvCO4ILKX8m9qK5FQbWCmOonr0r3dNAdhVMfk/sRNLKd0bpvn24knaK8DaxY=
X-Google-Smtp-Source: AGHT+IHEWYORPHjnHHVp6I9/kLAbZHfWNaSuzgQt1JIWu8FqZigoY7u1EMlJMMl+mRfWDmx9NcDWEA==
X-Received: by 2002:a17:90b:4f87:b0:2d8:8430:8a91 with SMTP id 98e67ed59e1d1-2e1e6221b1dmr1015791a91.10.1727998743501;
        Thu, 03 Oct 2024 16:39:03 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beef8ec6bsm13960705ad.158.2024.10.03.16.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 16:39:03 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [RFC net-next 0/2] igc: Link IRQs and queues to NAPIs
Date: Thu,  3 Oct 2024 23:38:48 +0000
Message-Id: <20241003233850.199495-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This is an RFC to get feedback before submitting an actual series and
because I have a question for igc maintainers, see below.

This series addss support for netdev-genl to igc so that userland apps
can query IRQ, queue, and NAPI instance relationships. This is useful
because developers who have igc NICs (for example, in their Intel NUCs)
who are working on epoll-based busy polling apps and using
SO_INCOMING_NAPI_ID, need access to this API to map NAPI IDs back to
queues.

See the commit messages of each patch for example output I got on my igc
hardware.

My question for maintainers:

In patch 2, the linking should be avoided for XDP queues. Is there a way
to test that somehow in the driver? I looked around a bit, but didn't
notice anything. Sorry if I'm missing something obvious.

Thanks,
Joe

Joe Damato (2):
  igc: Link IRQs to NAPI instances
  igc: Link queues to NAPI instances

 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 33 ++++++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.25.1


