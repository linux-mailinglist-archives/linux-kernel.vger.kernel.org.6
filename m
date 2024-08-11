Return-Path: <linux-kernel+bounces-282371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9994194E2F7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6CA1C20B5D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 20:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCF815B98F;
	Sun, 11 Aug 2024 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0V+HuYqp"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5EB16B38D
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723407834; cv=none; b=K5DggRnlu+rnX8Ugvu9I9bw+TOjgk1HXrEUACYBqLcUDIyGdIhresITGCs6N1GEgK2X1ImRFTbwN6zggU6/8kW5aQwmYKwPDjRwxFR3akdmk9DYA7MIjwPDLTCKOTeJsE3x4WdB6ui74smU6ivUaVdbX65bNOelJXYF4Gg4VKbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723407834; c=relaxed/simple;
	bh=My3uMee4xFLSPzftRadt35yXZiJQFUD1laI161zGpnI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R/1J4NksVrqzkgmF3suE4/7OkrWeZAuE/X6U9aeTyD4bLmdV2pCAd0Ajjs93Kb4zDQ1WXad4tl00TTogHFGLOEPR3FWBc1kVcguuFGvOY9iERNhnY2EhVkaVI6qbCA1PRF9pVbLA0bpIR3UQuv8NiJT/TMoOUL3rDRt/MG3iTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0V+HuYqp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fed726aefcso174935ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723407832; x=1724012632; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5bxH0HIvgBIX62IPBNWvzW2DcCvjALZOS7xYRmAPq4U=;
        b=0V+HuYqptoMErEgetMT7vEgjAx0aKNtOLaUanC8N7uMQmwCYYYXP4u+nBPgMxwx8eP
         CBVKRw6Jdc5hyil9Qqq7Bw0hVZFzTA036hJHBlTZndSbm7zOJLrI12M3qA0kqXOw7/SA
         G+QdasciWELMuONMezZbkiXhGVuLQghK2gUppQdr2KQPOoCVe+CjtfltHkdhf05bT/ir
         vriN5eeV7dXVcOSC3/imvmtOJdDd+a897c3Oiop3lWfHkVVQ3QIHv5azbdWv2juosN2d
         G2d+OnobOt4NO7JvQSpDZUCSfsbY2b+YtirqUv9ZawzH0IDWCDEQS+DG1ODyw+N/h/Lb
         HO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723407832; x=1724012632;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bxH0HIvgBIX62IPBNWvzW2DcCvjALZOS7xYRmAPq4U=;
        b=CKVRx/e2RYWyj8l1H9L2APinx1/2QkjteI7gj/ZHDZ9GlIlXWcLlBnCHXdcNacD3tU
         YJOzqIYRp0OsNnAMRMM19jzZSywX6M41k3HA/oklD++hY1e81IAmFwih9H2GlZtRSDVZ
         O+XRhOaKUB4sqB3sQ13Z1/UsB7zl7IRfn+vR+WgsjNEewUf4di3OmE0GE+8dPj/nHgei
         r0O09c8SNzlfPF+oQPZPYclZL1MLBSQPLBf0XoCY8j+pKKQkWqwQOrKEMBGN4UMJqXN/
         YYvWrXAGu4KH4kJ4U0eWBckxhH/2hTED9nsmsJRx2oWKPGQ8MHsZCOYZE60cP88Z3hOc
         T7NA==
X-Forwarded-Encrypted: i=1; AJvYcCUdXVPvcH39WhQnsKDfLEVjzaVA0h1toAAekrZuE3MdGYFDX08JPJ0XLNJGSaXvbwkj3CypqqGIrG/ZG/FBW9vUDGUrmnRn5PKGXLz0
X-Gm-Message-State: AOJu0YzqBvJM/CKFOrszsZA2isy8esDOV7NxXo963TSG9ct/uoYW/x4D
	1Ig9wsba1P01VWfSghqNkxnUA4xM5FW3Hk/4Bnyl7OCcRT3C8MmzVv9Q2G/O1w==
X-Google-Smtp-Source: AGHT+IFzt+R10qaB9GO91xPW9cFIB/jOO3ilfp+AfFpKq0UrmbSVV8L6fnyPExoeusMwzL1aescGhg==
X-Received: by 2002:a17:902:e84d:b0:1fb:19fb:a1f0 with SMTP id d9443c01a7336-200bbb56b70mr3361845ad.4.1723407831541;
        Sun, 11 Aug 2024 13:23:51 -0700 (PDT)
Received: from [2620:0:1008:15:49ba:9fa:21c6:8a73] ([2620:0:1008:15:49ba:9fa:21c6:8a73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb7eddedsm25974795ad.49.2024.08.11.13.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 13:23:50 -0700 (PDT)
Date: Sun, 11 Aug 2024 13:23:49 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
    hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
    muchun.song@linux.dev, nphamcs@gmail.com, rppt@kernel.org, 
    souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
    dan.j.williams@intel.com, yi.zhang@redhat.com, alison.schofield@intel.com, 
    david@redhat.com, yosryahmed@google.com
Subject: Re: [PATCH v5 1/3] mm: don't account memmap on failure
In-Reply-To: <20240809191020.1142142-2-pasha.tatashin@soleen.com>
Message-ID: <511c4828-cee9-72a8-8e47-ccdf80011a44@google.com>
References: <20240809191020.1142142-1-pasha.tatashin@soleen.com> <20240809191020.1142142-2-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Aug 2024, Pasha Tatashin wrote:

> When we fail to allocate the mmemmap in alloc_vmemmap_page_list(), do
> not account any already-allocated pages: we're going to free all them
> before we return from the function.
> 
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: David Rientjes <rientjes@google.com>

