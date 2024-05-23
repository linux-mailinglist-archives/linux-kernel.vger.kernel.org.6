Return-Path: <linux-kernel+bounces-188079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B358CDCE7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6841285B44
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF288128363;
	Thu, 23 May 2024 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Os5JHx3z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F8101E2
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716503874; cv=none; b=f3bV68xSwJqm+5XJom8HzRJ/0uv46DEiMczf4tX1x5ICHzCkz1P+AYmRa2Rj7S0g12pE4ScgaWhmQwZZAIMf8OlzNdMyBEg4qQtjpgjXiWumAZLpn39jk+EMvEfXks8QwmwzXEuPcsutk72VyznGbuocS1phSFU2k69oOMEJgmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716503874; c=relaxed/simple;
	bh=o7KSIBRv2vAoFHVVANgtYL179nAkdwdUTEtKFYiwJWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=se/9joADd9Nemxp/obo+XbE3CDZ0JS2UULjn9rh+6kiaunDg3kb1PJi9Jp9N7xqXfb2+VibxzEtDlnadp1l2xwdhO51xqALkWfYoJ3gyo0srhrsnYoYogID8usw2mazHrneR9/6aTb4dvK2YyVYxf/X+fSMmBFkszhe7C29aHjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Os5JHx3z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716503870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oIlPcbsczvmDF2ZQi1MgKZZe6E4/uUO2KRutECj88+g=;
	b=Os5JHx3z+KKNXaDjBwurrE7XOcV3DotwL1yjIVbHhdVRfZqnY34Bxph1W8x/EK09rGaWAX
	GwNAcv0n4lSkNhlx+5RwR0ERboPmTkPQZtecqgXeo5YGGBI/8K2fLnPH+kD2IgHLhUXqg+
	r7VXBq4HVpNGdkWymV/+H4cQSW/58Mc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-pzQmWWPqO4CJiSbNktzD3w-1; Thu, 23 May 2024 18:37:49 -0400
X-MC-Unique: pzQmWWPqO4CJiSbNktzD3w-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ab871c215fso1839626d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716503869; x=1717108669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIlPcbsczvmDF2ZQi1MgKZZe6E4/uUO2KRutECj88+g=;
        b=Xf3R4nrbLue79/mTKqZ2IzWwdemQ0PpSELlhyVP5jg0z6dusNghXM2hbtTSwiGUkC3
         7sVFZVeS0etpWJFV6UwU/jys0NGoWi3M6sQv9LdUU1R19k3PQ2ta7gBSr9ZertFTDxvq
         hobDDxENhHyUWWPS6hyR8mvwHvnV/mYVmXqj1XlkEpLzlvZpwHx9n0GkZUDgi7UJP+TY
         lQn2EdbogCQaIWkLoAmD7DlvRMTp07AHEdaAA6UVOWt7OuqcnS46pwSzYplOQPAW4oCX
         4hab4R2YGf/Ra5QNqEhTyGCks85BxQs07V5FrRDiJEYOsxYwEJbPKgN1V/u21fc87lV2
         aBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2U/KUlOCcUP5L4XDKTbfIckvmKcTlI57fFOpdCyANM03OQ626bOgPooQLctZmkGF7j0OnDh6dkoywCs1sbi64udHNsClNrcmFHty1
X-Gm-Message-State: AOJu0Yy8VEv8N4yIxjilXIo5WkeLugnEbyXKR5HveifZiX5mHl2Trtne
	fM+4a2w++TQmj9EZLOxnKWHEwIfqrv+fVkPZ2h1hKr7m2gFxvvf9gU8qOh1+emLTPLK2jFi2wAi
	TtKnOfVPZ7L0gsLKRdpG9cFgjZqIoM3hQy/nkyijkosicCzQwH4F3zfFW49JT3g==
X-Received: by 2002:ac8:5a81:0:b0:43a:b82a:5571 with SMTP id d75a77b69052e-43fb0f6977fmr4511991cf.6.1716503868842;
        Thu, 23 May 2024 15:37:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRw2DyGxB9A9IHEBFhtCHPlFJDYbxS4anIF67dyb8rs32n4ryGgsjYN9nJW93TLLvOwIC9qQ==
X-Received: by 2002:ac8:5a81:0:b0:43a:b82a:5571 with SMTP id d75a77b69052e-43fb0f6977fmr4511561cf.6.1716503868157;
        Thu, 23 May 2024 15:37:48 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18af1d2sm1066701cf.65.2024.05.23.15.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 15:37:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	peterx@redhat.com,
	Dan Williams <dan.j.williams@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Rapoport <rppt@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org
Subject: [PATCH RFC 0/2] mm/x86/pat: Fix two possible issues
Date: Thu, 23 May 2024 18:37:43 -0400
Message-ID: <20240523223745.395337-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm recently looking at the possibility of mapping PCIe large bars to use
huge mappings (just like thp or hugetlb).  Then I noticed these only when
reading the code.

I don't think I'm familiar enough with the whole PAT system, however I
figured I should post them out to collect some comments, hencing marking
this small series as RFC.

Please feel free to have a look at each of them; I've put more words in the
commit message than here, as the two issues are not related.  Any comments
are welcomed.

Thanks,

Peter Xu (2):
  mm/x86/pat: Only untrack the pfn range if unmap region
  mm/x86/pat: Do proper PAT bit shift for large mappings

 mm/huge_memory.c | 4 ++--
 mm/memory.c      | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.45.0


