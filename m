Return-Path: <linux-kernel+bounces-434148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 847529E6241
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B5F188526C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F68F1CABF;
	Fri,  6 Dec 2024 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JpfLPAS8"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379421D696
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445093; cv=none; b=iP63DFPvCkB1vVm/wWl7JwTnjSubZAjbr9P9jKCx2dD2YLOQto4gLqTF2a97rs/M08URVEJMQUyfBjs6L+E5sXUeiKzVj9e5Uz1AwmyVWScNsENR05ZtdDEtnwNJTY7p9xbD8Fildqq0ykq0JbY59yQIBHykhodYjTYSaTsh32M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445093; c=relaxed/simple;
	bh=3swxGZfUDrJ2PGxA22ibZxCYLCvQJGErx/Nh3e++yv4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=s46nD6mJRuJX3zZIC9lhaSO5wrUsAtmt82zn6wGsQ6ts+h2HR3nMuliwrZjALXCQ2/CzQWLQiHyipU46qe/vJSCXmMbcMrjMPNP4HV9NeFbWQXfaxODfN/U2UnzxqAp1ShLspNoEaEbsZQJ44VC2GexaOy+Mkp+mwhZIlzLtPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JpfLPAS8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21568166458so14099685ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733445091; x=1734049891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hticglYA+AY6G/VbzEo5oWORL0uTnFc4cL9bY6hALNU=;
        b=JpfLPAS8QDPQZ73bslQq3IqS4Q7d7C/vOBomrOUpCZjilo7LInueyjQd9QQPJH5cJC
         tixlIwMvZGrZjmRtOEPqdPzi1iOtCnssyiSnZ/+4wS4utXxA9HXsHvlVoGR6cddop/yo
         o1tNYhvWmV9iYZEtAC5WIqcJ8uN0acrBhX77tHaYdsHTZapraPthZ2IXJyLDyzcorNaw
         ZCeshkQbiieg8YmS895mx+5wfPt0alFZrwUIRDwAtYlH3o1FrmQ1/oZ69c9u2fUgkUao
         cZzJmqmWve4at44BOsfwxND8g48ELEFCCbWDXzwbIY9+Mt8VeRBgnWg0yFzzA9kTlBGs
         UdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733445091; x=1734049891;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hticglYA+AY6G/VbzEo5oWORL0uTnFc4cL9bY6hALNU=;
        b=HISwCa2kXmnQAGFPQvhmpDwiHNCwcHu8Q64YTQvwEa7cTXxHo6mCZcGUJsHHED2scs
         fOwKGJ/8Y/ILGAD8cOpFFzvtPZumqQBufVjOG9mwPxPhkf4K12uHRrvmelpj0rdeiZyL
         pSbHtG0lScS12RBXAVNl8eXLM9eoMrXCKhpmiTgDum0m3khWNZcwBx9WYiikLOfCRsTz
         mljS22tck3afmn/glcpHUL9BZrUapdhI1Mi1aoTN3jNV09kl4SVW56Uti35RUfzXt3Xb
         QgteUY69eEzwYm72fQFSLu4nwPm5SwNOq/iwBaL3VGWdn+k6CBr5S9m2ft51GyFOyWBq
         v80A==
X-Forwarded-Encrypted: i=1; AJvYcCVcGzoEOy6xSBbDqecfoFxpU8xyjOvgwRqtyqsDIE3aiDb2gJuPJ27UA3YeiTd1cjhk4MYrcPXZpmWfExk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXLSvD6iqDGiI+cUjB4U19cLCmAFip41INRKINHzp5LqAS3cGX
	LI03GY/K08jB55AVoJDUNq9G4VFqBr8D1LKyauC/RHzJcqBNla9sfmTNE5hCQiSh3+ABA2J+ipb
	KIg==
X-Google-Smtp-Source: AGHT+IFbK6okF2l0G44yN8zS8lq/AKk4+Mkz1tjM8/kCKyXgGKAWjsg3D2qTDCp9YQPUhwRItmhx8mZ3R24=
X-Received: from pllq4.prod.google.com ([2002:a17:902:7884:b0:212:5134:8485])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea0d:b0:215:8847:435b
 with SMTP id d9443c01a7336-21614d2ec47mr12408445ad.9.1733445091459; Thu, 05
 Dec 2024 16:31:31 -0800 (PST)
Date: Thu,  5 Dec 2024 17:31:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206003126.1338283-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v2 0/6] mm/mglru: performance optimizations
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

This series improves performance for some previously reported test
cases. Most of the code changes gathered here has been floating on the
mailing list [1][2]. They are now properly organized and have gone
through various benchmarks on client and server devices, including
Android, FIO, memcached, multiple VMs and MongoDB.

This v2 mainly fixes a warning reported by syzbot [3].

[1] https://lore.kernel.org/CAOUHufahuWcKf5f1Sg3emnqX+cODuR=2TQo7T4Gr-QYLujn4RA@mail.gmail.com/
[2] https://lore.kernel.org/CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com/
[3] https://lore.kernel.org/linux-mm/67294349.050a0220.701a.0010.GAE@google.com/

Yu Zhao (6):
  mm/mglru: clean up workingset
  mm/mglru: optimize deactivation
  mm/mglru: rework aging feedback
  mm/mglru: rework type selection
  mm/mglru: rework refault detection
  mm/mglru: rework workingset protection

 include/linux/mm_inline.h |  94 +++++----
 include/linux/mmzone.h    |  88 +++++---
 mm/swap.c                 |  65 ++++--
 mm/vmscan.c               | 423 +++++++++++++++++---------------------
 mm/workingset.c           |  67 +++---
 5 files changed, 372 insertions(+), 365 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


