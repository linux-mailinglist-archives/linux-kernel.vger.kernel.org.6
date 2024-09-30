Return-Path: <linux-kernel+bounces-344443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DAD98A9AF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7A11F21B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E22E193070;
	Mon, 30 Sep 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tmGS/2D0"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC9A18A6C6
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713473; cv=none; b=hB3EXBbEPdSbDfFElOYvIUdYHcjMjO24x2UIuCWScPtY9ImFz12XL8EQcAUEw3U0sYvxkt+BS+xtY09BfO3ypB3uECzUaNM0VYCCcKwNusLAyx2pNAF8CaHWmqfIQDHZpQ3B4ILfd9oHaJkXu23LSMFqkWfZoi3JAJX8y75TfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713473; c=relaxed/simple;
	bh=MXTkDSIJkG4+O0I/bwpPCZQj+y4yghFFQxAInPbhkbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dgwFhmTH+5BteuZJIMBR/EpCqDHpON7iRF83wb/m1wtNCKwzQFMpRKJNI4GN3fY0ZFJMkDwv39gzzkJAgoLzJhWMbSYFc6FwYQGAvm2GtO9LfPcGT+4+r1mM7+mO58k6u2TrBR6ixht/EBDtP4I5ebC73KjDPDhKipMuTrNCGmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tmGS/2D0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718d704704aso3833923b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727713471; x=1728318271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MrGt5Upc5o7Dx2xzHjGWOE9OwgSldZ92rzSBdwBzh2I=;
        b=tmGS/2D0SyEt28R9KcRrTVW2f82r8MO+HN5f9H54srl9AMXxScqpHeaN1h4qOkULqi
         /LHrIm2FSE5nwQ4zXCJdAaTGqNHacleLPkGLZmEiS8ga+r+anMhS8ssWuI1Ku385lILD
         +IascO1gmdNqqzLYSOlS94YBL6mLI03SdogvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727713471; x=1728318271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrGt5Upc5o7Dx2xzHjGWOE9OwgSldZ92rzSBdwBzh2I=;
        b=ZU/OUfZdcZOwwcpgs1A+JGZHQC3d63n4gGAdiuQkS9ofNnY11e6lLamgaYVvVr5/Nn
         oXzkk8+3zdbnumD3GJ3kHiOxmWXLSBr0Qq339Ib91uCtzoNt1FgGVvjzrQ6h7l4+fnam
         uyIkTb4WHpD2FdmlcKBnYbRe+UcFTHAf37kRzogP7ioQs75Enmhh5z4PZuZUolC9Dv9r
         GtxWvl9Ojh+DnvhUL80Zb3+K9eXhW2hi95Q074o7o3VCwwqRrPLwkVuVLJyjPtD5FW/w
         iympWTeD+4xNtYFSAqmQqvBct/eC/XqSijKAy3mV2iXfpU96dFIv5//aSCWMySK2f6V9
         +rCw==
X-Forwarded-Encrypted: i=1; AJvYcCU65bGf1Gj3sIut8q9+MMuH5Jwt4abbItNooBAn3EaHv/P6+otcKQO+FD/aVM5YEZrVmu3pzXziSKbaWTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpK3SRpfyIm00YQyEEuifeSII8Enai8ktkq8B11J8wLViicXYX
	ab6+YTV38sCQvTy157M67FOgKagw5WcX5N1kFvLMIHWP5KLP+sW18yNvJ/lArDY=
X-Google-Smtp-Source: AGHT+IH+F3Tf3jKyC0qK2FNN1dLVKxM+uT+5rdmirqYof6Zm71lmr9+KaD68IeM8aJIQdD5MFKin8A==
X-Received: by 2002:a05:6a20:d806:b0:1cf:9a86:56ac with SMTP id adf61e73a8af0-1d4fa68e8b2mr16968293637.17.1727713470897;
        Mon, 30 Sep 2024 09:24:30 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649f879sm6411451b3a.22.2024.09.30.09.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:24:30 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [net-next v2 0/1] idpf: Don't hardcode napi_struct size
Date: Mon, 30 Sep 2024 16:24:21 +0000
Message-Id: <20240930162422.288995-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2. This was previously an RFC [1], only changes applied are
to the commit message. See changelog below.

While working on an RFC which adds fields to napi_struct [2], I got a
warning from the kernel test robot about tripping an assertion in idpf
which seems to hardcode the size of napi_struct. The assertion was
triggered after applying patch 3 from the RFC [3].

I did not want to the include this change in my RFC v4 because I wanted
to keep the review of that RFC focused on the in core work instead, so I
was hoping Intel would be OK to merge this (or a change which
accomplishes the same thing).

Please note: I do not have this hardware and thus have only compile
tested this.

Thanks,
Joe

v2:
  - No longer an RFC
  - Added Simon Horman's Reviewed-By tag

[1]: https://lore.kernel.org/lkml/20240925180017.82891-1-jdamato@fastly.com/
[2]: https://lore.kernel.org/netdev/20240912100738.16567-1-jdamato@fastly.com/
[3]: https://lore.kernel.org/netdev/20240912100738.16567-6-jdamato@fastly.com/

Joe Damato (1):
  idpf: Don't hard code napi_struct size

 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.25.1


