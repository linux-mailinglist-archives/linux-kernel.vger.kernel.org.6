Return-Path: <linux-kernel+bounces-346958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6E098CB72
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8CD286C57
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E22DF59;
	Wed,  2 Oct 2024 03:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y1DKEp6E"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1122F22
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839137; cv=none; b=TPMbkcD1aAYYKgAEH+aHXL1bvQ0Bo5i12SbJ9OGAdqlX919TrIK9bw/Lb1fpWPvSn7b9KYvLXgT+VZtU0IXHRbqoj8rvppqmXo49mpui39IGXdc17H4fXRlPu7GbrPJKmUMfBC67tCOOdw/bHu++2Ph+KkGjszuknylzQ3/TW7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839137; c=relaxed/simple;
	bh=Tb7r4UVEcikt+MVOmSfX3eALxeFX7E6LPKwFSG3wMuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNoYTFGgHZaq/kJcG/iCrf3e3Y2fRTeTve4iWmdGIXSUnrCj68Z9zq774ZXagI1q67nFaaikx1ZEgMCLa/WJoTFclpU02mKJGyA8JHKc0/lmErxwvRuMkwXMaXjDqvmT1FV5sjqwq6Fs7JQlMk7hLeOoM11YqBOKKmGcWMa5Avk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y1DKEp6E; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ba9f3824fso13949445ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 20:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727839135; x=1728443935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=00LDcROEMqvWeinbcoEjEcHLwHipcWBtgKWf9IRMo+c=;
        b=Y1DKEp6E2kXN+Aq2kqA3AV0oEJKbbIGoxW7kobG0Y30l1cE39Pj5nsnwluqqw7WxSm
         1TCACTL24DqxIyof+WMTyEqqUQ1W5DV9s3kfekLMwfAXce7TAShNyX59QNshO8nRCZsU
         QSlrzzTl7Yow7VBL1cAuqqUIy/WxMLkhEfq2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727839135; x=1728443935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00LDcROEMqvWeinbcoEjEcHLwHipcWBtgKWf9IRMo+c=;
        b=bufYF8X3sVviAWyXxzppfX5+q+UOKbrXXRuU9Tw4y7mcW/YgCE7UfcmbKjYWLoFnty
         qYVbjud9IXvmWIrU1SMd1D6Fg+hrTxI2RzoNifu3SZETQnG1Og2ZK4gN8o+j9//4XC6k
         oiq919IaxDY3LfOBJ1lKdUiJy40Zsdj5PfsXYv1CwAbQxryUw9uVu9Tm9YimmIL+e/X8
         7Gvr71InsV5XrKWdetngRpnqNGg5SB7tVm3wRT6oa/Pkjmgl/whZ7kVVYfs0uFNvNMhf
         vuMP14Igf/wE2PUA4cIjlf5o3gT1s93Ie1x2oMKQ50L0EWkY6BAdkFaMuApN3m8El/xX
         wxiw==
X-Forwarded-Encrypted: i=1; AJvYcCUC/oPDQl341P3+gSv4PfhbYyrxTYrega//SDLFXUqCr874WwNr33FQmn7Cm+melnU2hY3OY/10kBWcKvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUUy7fv6x5HQABGpE2dAlFaswRLoj5YbkQmIAYvDl5zAo0LpQb
	/ISUarkdCxDI2FPNz7+C6JXko61AQu+BcOF52unStLZrGs5Ts10HuuhGq/jk0UludPQdgYiYz7b
	kgg==
X-Google-Smtp-Source: AGHT+IG/t+BpAn6gYcxJkVP6Y44GdpkycmxdlXzbfQvcDvAvrMikUtY5nEES9IiucZUn+sgLVWbsbA==
X-Received: by 2002:a17:903:60f:b0:20b:af36:ea5 with SMTP id d9443c01a7336-20bc59c3584mr20822795ad.18.1727839135055;
        Tue, 01 Oct 2024 20:18:55 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8dcb:9ffe:3714:b8ad])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e61e14sm76516435ad.279.2024.10.01.20.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 20:18:54 -0700 (PDT)
Date: Wed, 2 Oct 2024 12:18:50 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Pintu Kumar <quic_pintu@quicinc.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, joe@perches.com,
	skhan@linuxfoundation.org, pintu.ping@gmail.com
Subject: Re: [PATCH 3/3] zsmalloc: replace kmap_atomic with kmap_local_page
Message-ID: <20241002031850.GJ11458@google.com>
References: <20241001175358.12970-1-quic_pintu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001175358.12970-1-quic_pintu@quicinc.com>

On (24/10/01 23:23), Pintu Kumar wrote:
> The use of kmap_atomic/kunmap_atomic is deprecated.
> Replace it will kmap_local_page/kunmap_local all over the place.
> Also fix SPDX missing license header.
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> 
> WARNING: Deprecated use of 'kmap_atomic', prefer 'kmap_local_page' instead
> +               vaddr = kmap_atomic(page);
> 

Can you also update the comments (that mention kmap/kunmap atomic)?

---

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d3ff10160a5f..5c3bb8a737b0 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -263,7 +263,7 @@ struct zspage {
 struct mapping_area {
 	local_lock_t lock;
 	char *vm_buf; /* copy buffer for objects that span pages */
-	char *vm_addr; /* address of kmap_atomic()'ed pages */
+	char *vm_addr; /* address of kmap_local() pages */
 	enum zs_mapmode vm_mm; /* mapping mode */
 };
 
@@ -1050,7 +1050,7 @@ static void *__zs_map_object(struct mapping_area *area,
 	void *addr;
 	char *buf = area->vm_buf;
 
-	/* disable page faults to match kmap_atomic() return conditions */
+	/* disable page faults to match kmap_local_page() return conditions */
 	pagefault_disable();
 
 	/* no read fastpath */
@@ -1099,7 +1099,7 @@ static void __zs_unmap_object(struct mapping_area *area,
 	kunmap_local(addr);
 
 out:
-	/* enable page faults to match kunmap_atomic() return conditions */
+	/* enable page faults to match kunmap_local() return conditions */
 	pagefault_enable();
 }
 
@@ -1510,13 +1510,6 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 		d_off += size;
 		d_size -= size;
 
-		/*
-		 * Calling kunmap_atomic(d_addr) is necessary. kunmap_atomic()
-		 * calls must occurs in reverse order of calls to kmap_atomic().
-		 * So, to call kunmap_atomic(s_addr) we should first call
-		 * kunmap_atomic(d_addr). For more details see
-		 * Documentation/mm/highmem.rst.
-		 */
 		if (s_off >= PAGE_SIZE) {
 			kunmap_local(d_addr);
 			kunmap_local(s_addr);

