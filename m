Return-Path: <linux-kernel+bounces-193936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA09B8D343C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B26A1F22DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B292117F389;
	Wed, 29 May 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CCHuvYqN"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E665217B4FB
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977633; cv=none; b=Oh1/RoHCf0ApR6uCPCtlOyOkBlXjMJuaZWwhwSYian9x1MsIpyCsGw8l79yGbCSY7R/NRbXq/YGxmrsnfDtzOCrdq60MW6bH9v7ZM2aJ9EvR3R7YI2BxrWvIoDeyTP/qmZM+7TjmAP67mVPstWLci1iw9Gi/Rc2CcaYJvJgoJEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977633; c=relaxed/simple;
	bh=RgeY+bfDNoZzO4vZsnnU/cGly045qdyVLEtGwYs+1fI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psgk8pdG31cRQZjw4IMztgyJ800W4IP4cTUQQA9kUk9YBrC7UWqcYLb8XYADF9QXLTOyGa3oZfIPbU0vNGjcSsW7KwanUFz+RcU5Ba774yEcpNM42KdougbX0OOYB6BYIXtTFXhyly4hDy+MiKLeFI1jGuR1B6dZIKqpgur1WYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CCHuvYqN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-354fb2d9026so1777566f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716977629; x=1717582429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DWva4iesfpIM/la1EwXKKVb8Cdii/+9H2sXG1XsGOhg=;
        b=CCHuvYqNI4Z5I3F13XIxjHTM2IJLD1U/0z9g6WpooipVk8M3cn5G9q63aCRAHmrx7j
         qLZDPLXsrNnfrMtDkx/fDZcrEUBJ/CPHM/tuw5303u5a97/JZOl0I9e47/wyNmkqEu83
         vF1tM0Ur044hJhXkz+eUqg/A8HHdwmtGIW0Q/B+6wG1+V1E1AIBp0Xm4dweK1kAHdtrq
         Dy9kX8fp/Gg6v7zH9GU/YrPig4RqfFM9lPw5h9AAHQVO9zyke99w/bR2aYMi5fw523rc
         kDL4shaH2zLh18kNJrqxroQ0/CQR1of2Fxf42LavcPT2qfcDGyif2JHufwdhxSojkXHX
         tARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716977629; x=1717582429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWva4iesfpIM/la1EwXKKVb8Cdii/+9H2sXG1XsGOhg=;
        b=s9l2pY31vD3QnmZUaB/YILZHbsPh7FW7dLnVbiJtdRewFxKi510IGH2ZGiHCBCjkel
         JnMfTDqh40L9ZDPX89HHmzbchs0nnGz/8cWA7zpHAyv4LatuMx7RCc4Cnpqe56Bye3Y7
         JyhiW/YmnjrLy58RpyUaXKaV9zoTHBNbGA8J+hSZzBSgVdupBql9HCwRRDOmVgCfVfCM
         LePRKNGgpDrXUR+fSNEre9jmGUyqDToHzHWWII2+4ESvAWAuK8wfx1uB0rnIObfc9feL
         maqpZu5Yrg/f3gzQS4cXGaZ6cO9lgd3/hOYqfq63XGGmWISFw7q683aDc7g5UiMm1OfJ
         fLFg==
X-Forwarded-Encrypted: i=1; AJvYcCW5RDJKdXGU+ty8AM9HgYeWn2oM/hX87f+FwPwD1+7VmxnBz/rqpkTPs0pAUhivMqL9z+DwFqfyw/ZeffaFpwrd9lSjhaCy3q3mIuiN
X-Gm-Message-State: AOJu0YxnFCfgsBGIpLMDn2bLdckSSTEqdtDWfG6j8uUNGBxWYjV3tCrp
	Re/kLzq/YXSopm1C/FbN0YW5i655WndGwEsIQTa9CFfj6b+/67AuHrjL8QBlvc0=
X-Google-Smtp-Source: AGHT+IHt9Ba6L+0f+m26haQIjzUpLMjXASE+7cuXYPhAXHN7krwAJUlx5hJ8S9Vd/bRx1rHfXxW0sg==
X-Received: by 2002:adf:b350:0:b0:354:f82c:78b0 with SMTP id ffacd0b85a97d-3552fdf968fmr11329720f8f.70.1716977629174;
        Wed, 29 May 2024 03:13:49 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3574c7017d1sm11775623f8f.76.2024.05.29.03.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:13:48 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Wed, 29 May 2024 12:13:47 +0200
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v4 16/16] mm: Remove CONFIG_ARCH_HAS_HUGEPD
Message-ID: <Zlb_243CPcPiN7Q-@localhost.localdomain>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
 <98d6ff5bc9395785e268b9f8eff08fb742c045c6.1716815901.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d6ff5bc9395785e268b9f8eff08fb742c045c6.1716815901.git.christophe.leroy@csgroup.eu>

On Mon, May 27, 2024 at 03:30:14PM +0200, Christophe Leroy wrote:
> powerpc was the only user of CONFIG_ARCH_HAS_HUGEPD and doesn't
> use it anymore, so remove all related code.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

