Return-Path: <linux-kernel+bounces-210935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 076CE904AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2808F1C22A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5818B2F50A;
	Wed, 12 Jun 2024 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFZBYd49"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF4928DD1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718169048; cv=none; b=tDy8yt3ynXinzq44W2AkAAlM5CMSYNKywDtwER4YIredcke3FbdqhOQkzNkusjxGklT15/yKscLDlAPSJwDPnmB7uA4CgvSynIw84jHpv/1Vmju+lXupEy7bVVSq8ycjniAFiDDLlOADpF0VbeY0M3oP3oXs0j1dxMp477RCZk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718169048; c=relaxed/simple;
	bh=E3FbBH6yhR85/lFWGiidknlpDoPTLw5NjmfksYFNlNg=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=g+WnkKIr9oFNsH6F5Ow7MPPNz/tf140XZYahegH80Hy7ykEPrxQe7xFI7VPfYaovHa+ScvTm93+yEGII4KuY2oTNkPqzTMpgg7cYAU8pB2w9P2fr8MayPnx6smJ8ufiuObEzRvPJdNpQ6IoeWvYTPOUSJdtbKW2p1SaAXtsAmj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFZBYd49; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-254a370e7a4so270169fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 22:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718169046; x=1718773846; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gxIuQyI+KqEjqXSPbt+rLQHHedM6hADL5yUtu3q/GcU=;
        b=ZFZBYd49bt1dHw2Gsb9WuKhT7znRb/HLJV7vHC0SVl/8q6lz/sMy3RzyE/utTscdBw
         qJ8oBSrXSqYLmzp01Wow3VzB/hlHScb4txX8NWk+3HwxEW8PLAy1lg5DEXh/PZddc5kj
         v8Wbj3hePOemvdz3YCDViRH5Oi7f0T9puGmLRoLxV69OB80PgmWnEmVtkvmoj8ipfl36
         bgVRW/sfEWvnUrlCb7Phj8P0HN+YrlpQxmn89kixOUDVDMAlRfBkiU0sIasMGLzWgxAk
         snmTIDiuv0SJ257PApSEsLJ4n+EmqeVGFp8BL8p7t126xtExzlHPFyFp6liJcyes3X/2
         o/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718169046; x=1718773846;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gxIuQyI+KqEjqXSPbt+rLQHHedM6hADL5yUtu3q/GcU=;
        b=B+0hgMwcy5p3Krxdw5jLRWZfNn3V/YC9TlLLB7RirNpVf7ybBCG1mEWV4lpGlg8hZD
         PClIv19rhMaGdK0VdVZa76oUfkNVEy3FCE2UFNqB7rF++9XQtw/N/HyYkGf7VZhZQMuK
         JpJ24hML9EzMcDcc5UMAMIXZ80iv+y0A8K1tkkV/HsDLnYU02bySdfe+JQiqia8/4XbR
         /bm9QngQfBX/LoFQqAdAHj0jjIUh8LvEM2ax775zf+U9SRiirIk42LL9U1S9PfkHbWWL
         KA3/SQemtaNwEuHay1KnnA9bn32q8E8+GVovY+mMQtABpQbDahEuCSyXtpYtENssB3Oy
         /5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVYt/qgxy1RFvD93IrYeDF01m49Vm7kgFWjIO6K2SHkKlvNAcitU3WdUxCP7TS5ZLcpamslu0m2a1xSMmn/5T3iPRekyC7DLGzqhvbS
X-Gm-Message-State: AOJu0YzAqdXExOSOcECqg58RlALDSA4/rGNL6IL2iaJytTeHT3p7YC1i
	seAB14rjuAaBv33Yj3mVvNMDN5Nr15LFQbRat2dw6gxKIXdIV/hHwFOtUms/wg==
X-Google-Smtp-Source: AGHT+IGiNmcr+Nz2B0xj5+N+rKP1+pl5UWeNkvv3gEeqh+JA35GJJ3cB5kaZJhQz2KxpNG2GrPrSKg==
X-Received: by 2002:a05:6870:968f:b0:250:3c9d:fd20 with SMTP id 586e51a60fabf-255131599d8mr469507fac.0.1718169046206;
        Tue, 11 Jun 2024 22:10:46 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-254a8de199asm1855570fac.22.2024.06.11.22.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 22:10:45 -0700 (PDT)
Date: Tue, 11 Jun 2024 22:10:43 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH unstable] mm: rmap: abstract updating per-node and per-memcg
 stats fix
Message-ID: <49914517-dfc7-e784-fde0-0e08fafbecc2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

/proc/meminfo is showing ridiculously large numbers on some lines:
__folio_remove_rmap()'s __folio_mod_stat() should be subtracting!

Signed-off-by: Hugh Dickins <hughd@google.com>
---
A fix for folding into mm-unstable, not needed for 6.10-rc.

 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1567,7 +1567,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		    list_empty(&folio->_deferred_list))
 			deferred_split_folio(folio);
 	}
-	__folio_mod_stat(folio, nr, nr_pmdmapped);
+	__folio_mod_stat(folio, -nr, -nr_pmdmapped);
 
 	/*
 	 * It would be tidy to reset folio_test_anon mapping when fully
-- 
2.35.3


