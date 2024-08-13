Return-Path: <linux-kernel+bounces-284006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9C794FBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE351C2234C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 02:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4BF14A96;
	Tue, 13 Aug 2024 02:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tzm6IBH/"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D671CAA4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 02:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723516331; cv=none; b=lMxT9od2Hk6YFq1dzlbsdbwuNl9XYXHUvPbDmzGAzI/HHQspSQDGRjehrlGFBljKoxCWaYe3mbDfQlXWQABepGxMXx6VDp7EK/DTQyaHA75N0iuCfmXUcEylWoDRi7oNeuxRC/YMD1R/vNCiK2vrQhVv96leqDBXxWQviKh/mZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723516331; c=relaxed/simple;
	bh=tW3pLjfFNNjGIdVGU10xKMxIktHWsWbuFlD5w2eRw+w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SKRWXXSVyqaXOeUo8y9om+b65mrcgNiRMB62kNKElSsKS+DDHK2NX8rdiCrqLxYk5WE/amn5HgTHsHlTqBVjW+ZpOECa38K06s4gE3hNcxJ44L1dkJW9ace4WdFoN/D0JShZxnBN9o0/ToxbR5/OzUF7m2kFr5nBlSeANF6X2Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tzm6IBH/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fed726aefcso27225ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723516330; x=1724121130; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t9sY5RmT4/nr5MM6zTPnlljtK1dnK1Uy+5vyxxFPmqY=;
        b=Tzm6IBH/dzpmwDZNy+q0KWATQMpt0ketgLqW6aVuIHaR14gFt+bBHwbpZM70WR+YKg
         B0ypu+XJixHI8/4PucNRgEa57QVEhh9jstBLZC4EVQjF8LMmKfXf+Nrwt26gXOLkJp1+
         WyfmxmjLGy5N2bVzcPxrnLN0dfKR4ZrLvzvx230LWkp5DZ2NZlcZ7QH3uM46BiCdwOV8
         /SWnDAxSZJ3/H750QKZYVE2vlDMgpDRRbeSdG91TTtnlArxjxyjSaLNzlfbGrHomMuEF
         N3kt1wybINEVsL7iM82Jv8Sh/jo75li/ZOpG4wNzEel49gxCc5xs8s+JJM3UA9jOyZla
         TqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723516330; x=1724121130;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9sY5RmT4/nr5MM6zTPnlljtK1dnK1Uy+5vyxxFPmqY=;
        b=CxpJMvX9b2EyXlvdIpmtSXl5/6Y88R6PodIPLGRPCfboDImesMtXteIJceGGwkOAwI
         S8qEJT301G4It9+h3JoVjMVTpsa6zCT+FPprCOas/v9giVaF9azYlVIA8rCCTWDZOiU0
         uQYyQQCKjJA5pmrj4WZqI9QNsNxQGCB0v4Cg0ydmuUpeu9kmvZbN7jZO5WOnb9Zr/Epo
         Kmo14a/roeUXbJQEmDl0B/GAEGoiJLQwqGkBdx9HRiFTx+uLlMTJBIkRF1tXa79//GDl
         n+y+jEdzAVjT/aG/JvPyqwg2EBIC6CuOS193a8D4lG7O/mc5Kvo6UAhQc0hjNBaFxBam
         8h8A==
X-Forwarded-Encrypted: i=1; AJvYcCVMcxSdWZYlWxc2MUp8jdIOa6bYqpKTd7b/w37T3VmqrumXgARpofE0bFrsH+dWjcZwRGED7Orj3ud8RsPB0UylY9QVpsn7t6YR7YM5
X-Gm-Message-State: AOJu0YxN9qNs4WbpBoVmw2/8sVmFufSp4IZcS9t56R87pg7IvzZNyMVN
	uXarbQfiUtjI7sX3ZDvsMGRzA0yxBKL8DYOl2BwjpZiNH9640OzvD6d2HjXOBg==
X-Google-Smtp-Source: AGHT+IHRRIw0TKIKJPd7TTATQI7KUNnCwQkdTzS2vPZCS2AuBREI+ud00sZeDMvyyHCnnEpMYPYKgg==
X-Received: by 2002:a17:902:e80f:b0:1ff:44be:b9ea with SMTP id d9443c01a7336-201ccb3bd9cmr809345ad.8.1723516329366;
        Mon, 12 Aug 2024 19:32:09 -0700 (PDT)
Received: from [2620:0:1008:15:da50:c231:9581:2fe4] ([2620:0:1008:15:da50:c231:9581:2fe4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1e285bsm3303115ad.303.2024.08.12.19.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 19:32:08 -0700 (PDT)
Date: Mon, 12 Aug 2024 19:32:08 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Danilo Krummrich <dakr@kernel.org>
cc: akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org, 
    iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev, 
    42.hyeyoo@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] mm: krealloc: consider spare memory for
 __GFP_ZERO
In-Reply-To: <20240812223707.32049-1-dakr@kernel.org>
Message-ID: <1f5ae113-3782-7351-ebec-c7f2e3cdb14a@google.com>
References: <20240812223707.32049-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 13 Aug 2024, Danilo Krummrich wrote:

> As long as krealloc() is called with __GFP_ZERO consistently, starting
> with the initial memory allocation, __GFP_ZERO should be fully honored.
> 
> However, if for an existing allocation krealloc() is called with a
> decreased size, it is not ensured that the spare portion the allocation
> is zeroed. Thus, if krealloc() is subsequently called with a larger size
> again, __GFP_ZERO can't be fully honored, since we don't know the
> previous size, but only the bucket size.
> 
> Example:
> 
> 	buf = kzalloc(64, GFP_KERNEL);
> 	memset(buf, 0xff, 64);
> 
> 	buf = krealloc(buf, 48, GFP_KERNEL | __GFP_ZERO);
> 
> 	/* After this call the last 16 bytes are still 0xff. */
> 	buf = krealloc(buf, 64, GFP_KERNEL | __GFP_ZERO);
> 
> Fix this, by explicitly setting spare memory to zero, when shrinking an
> allocation with __GFP_ZERO flag set or init_on_alloc enabled.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: David Rientjes <rientjes@google.com>

