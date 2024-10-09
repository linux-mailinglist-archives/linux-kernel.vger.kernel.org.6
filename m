Return-Path: <linux-kernel+bounces-357241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF2A996E57
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1497B21A25
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAACD192B7A;
	Wed,  9 Oct 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="MR0ulu1t"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4073127E18
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484899; cv=none; b=Y6OwXi0R2+GR2ipFBZYJYiIKj+ChL+kVSW4RZ+ilPnpwGE40NEDQb9ZGgZ9tGrfQSxLu/oBpOqpOcxpY0Ka6cf4VUOYVL2u6pEgEtNm/lT4OKVGoSa2h0h12kF+CXCjTwZLAw4ytv9LMrEQdBbHg4U987+Iz7/NkZ85+YEN4Jk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484899; c=relaxed/simple;
	bh=32vFmCSc5ZEMb4AhzJtfcV3h3hUM5xDYrKqyzkNbPEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XDp386clAd0LhB86xWoytj+0HHOi/tjHwQMYjjcS4hSmsCi3VJH+oBOUwczi4hs45XQOD6FCQExBbkaqfnGWDYHPCD6cXOL8q9G9E6CYYr4Mc8nNCKeCzfYAzQ1X4xCK620JdsMr3bpUHnWYfTvm5shnl3L6QZd8V4nwSst39nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=MR0ulu1t; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e10ae746aso1845983b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1728484897; x=1729089697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qHFKwQFtdhqDpsvNepQo/3TMbFBjVSDDfwKOH3x4ow=;
        b=MR0ulu1tvKEemN2nXI8gEoQ5ldOKxAVMcyb8voWt39FxJe5+oJhaSK1YamHig3084e
         3yXV0fzBLzshPhiGWuC9alzTJkMkL7CR7wA3GqtpYIjkhDVt22QYmoowN329GKw+pQol
         xnpVRE7WgAY0hXWJX07hJVVb41vu/OJo59LlehwU6JjEq2oG9KpF5xCp8/02GpWPsFqK
         YME0nSP2nfcThIWqkGO4/FCZ5irzkz5uuVtr1exdA8/I0XCDJXqLrNiyjV9iEMPiqhKH
         4WVYtCtRGM91saZMh14S/eiGceviMRkFeYjmOWca0PmORaiJJPV0bTae6ZlZB6QVY2Yl
         tcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484897; x=1729089697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qHFKwQFtdhqDpsvNepQo/3TMbFBjVSDDfwKOH3x4ow=;
        b=iUJITf0O+y6CrkhtjRKD7l8N5PRmi1zkjMS4ojW9sB2zuyhyUMfwvW7Ahi66iDTJoR
         zjsIbkLOHeK57CI1kdond33qnnmkkW/FBBt3I/3SlwfOFfYqMEu8PzT6KO1Z64dQtpvo
         fOvNky1AduFUeMjHLncj9kgIMFPa1GV614MwGBdfpQynlOxPs6FHThqSfHQ13cU+p+ju
         c/CfABYSCnuJY4vo8oMJXDP+smYPztkN45TnXijVzL1LI7YhSYet8XGXjbDO2zgdhCJX
         Qc4ZkQwW6x9StHngZgYQlJBce6EOgAc/HjGqS6AULuQvIU3FvbkECI34R5NC8nJUdfT9
         8S5A==
X-Gm-Message-State: AOJu0YxNSZ5Tw4JWHrS6WiFyV2rC+eEPb7Z0vAwqU7/A0kBokKsyWoSa
	f85WXckjcpPHMiKRl+1f3SXQaFK+BTu0wJeKqby97UkLeFck0WmSB3Jae7vrXCLLe/UCqh4NAqg
	h
X-Google-Smtp-Source: AGHT+IFpmvUjs98ZpK9INq/XOOz7Y1o2mXU9E+TcGA1VnD0NJIUMPP6zP7j/gYPu1kScqkViOogk+w==
X-Received: by 2002:a05:6a20:9f8d:b0:1d8:a354:1acd with SMTP id adf61e73a8af0-1d8a3c1def1mr4460478637.25.1728484897223;
        Wed, 09 Oct 2024 07:41:37 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccdb64sm7852764b3a.48.2024.10.09.07.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:41:36 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: jack@suse.cz,
	hch@infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v3 0/2] Cleanup some writeback codes
Date: Wed,  9 Oct 2024 23:17:26 +0800
Message-Id: <20241009151728.300477-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

v3:
PATCH #1: We haven't found an ideal name for BANDWIDTH_INTERVAL, so update
the comment only.

Remove PATCH #3 about XFS.

Tang Yizhou (2):
  mm/page-writeback.c: Update comment for BANDWIDTH_INTERVAL
  mm/page-writeback.c: Fix comment of wb_domain_writeout_add()

 mm/page-writeback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1


