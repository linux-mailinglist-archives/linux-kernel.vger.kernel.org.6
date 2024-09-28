Return-Path: <linux-kernel+bounces-342481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B33C8988F85
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADCD282076
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A70188013;
	Sat, 28 Sep 2024 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="AmJo7Ab4"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7E188703
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727531632; cv=none; b=VEqb+DYoSEb9t+Hp+HJ0Uth/siK54FNYWs56lx5r3XxizNlSYCMN8wP9YPeEfm0NrAEQ1PMtrmeiUNRwewEuMLxl9lGrpKArzOm0m3FhqjTrFlBhgQEAzScz/lgmHOeGgF6LAAEKwZr7fMAuiaVWYNAnelSs1Ikrud6yFBN06ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727531632; c=relaxed/simple;
	bh=p23RQLyoKlIeRAa5KuGjKRJENRQ2fdoTF+wSfPDPzIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrgpgLlUDddf04nbrzlTBZ6MkxCkPSmi08/O2lDcpnvOM8YY+HqFbsMaZ4ePnPL/6iF0cNwb9eJnAhKI3iwX5ZNQDrZcCJKqVDNcUUuymdWxpVgt0sXmKJaxQkIaGC5GKXqRxmO5uKSOWqFwioeCTSsbZH1vk4/LomWnVBIjul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=AmJo7Ab4; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cb37b34a87so18587366d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727531628; x=1728136428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dayhq3MTxfga64TVXaDsvojrghHz89xXzeqjJuXzgwk=;
        b=AmJo7Ab4uSiEhf8iouaQtRhyakSmav1RvxuGx/Uk/tUGpaQ8cBtp1wy9TEKzX51sLX
         T35HgURcEFNkSIfqfIeZ3yRSj2auvOVT0/stvk7jb5Gwgowwz73+2gwKRzuhQvwqftGw
         2y1eGMzvoAFFykgY2BUjGFuJsW0hHdf32/RKgxkeLpWSi0QYQ1sseYQDuMbaWDtimNXb
         LPDvwWnI0eRrxwFYy/7lUsdSCy7GePpzwm1p636u+HY9EM9kAkt4agMA4krrKSStI9Az
         CBpEJ6FBUbuO3Mj18NGjqgVfTyB7eYfdDmcSt/jm8sh+fzpPmIUVIcR+Y+Nxi9eEabtB
         mVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727531628; x=1728136428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dayhq3MTxfga64TVXaDsvojrghHz89xXzeqjJuXzgwk=;
        b=g9Jk4St+LuY1EQE6wozByCf5fzqORb4MEsS2IY5GJNlQM2BZsSfc8buuyxahUl4zGE
         gB7cqEwd9jknt/Eb2scFgFsdv22ad2U5dxh3PWR8nJ1hkZX++8T7v6TeyuQ8Kw2fYuTB
         Nd+fDhrnN8GZ+XJKv0zr0Tl36riGN9yXHlV5GY1ScWD3/TPdrqRF4tYX+x+ODCSReDtK
         r4YZZoPLUrZwlTjpXUWmJtJAz+dmH3YY6Z9zlV1rzlUAQmzpLXPzpQaXRuLnkKQ/XIr9
         Xvq+eIfkkMl7KrWoCfW5FOq6X+9Wb6s7xHlY4xhUQN2Eu50geWQjkU+hTWitte1VZE8x
         iS1Q==
X-Gm-Message-State: AOJu0YzCfuCagNPrRlXGWATgW7NteQljPLPGLvY1x68yJBfOCx94hZZq
	XHPo51s5mparlkUgdRJ5ghLWxWtfYoYwVKoXRK+sqffy+vm9LprakKDlkEXgmkc=
X-Google-Smtp-Source: AGHT+IEj8ecZQlUVp6W/h+37oUBnpND2E6jQoQDicgs2joAcvMOP+ThVv/U8AlLrIsjEWgOlvkuL5A==
X-Received: by 2002:a05:6214:4884:b0:6c5:b883:92c6 with SMTP id 6a1803df08f44-6cb3b5da9eamr82694856d6.12.1727531628043;
        Sat, 28 Sep 2024 06:53:48 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b5ff612sm19534126d6.9.2024.09.28.06.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 06:53:46 -0700 (PDT)
Date: Sat, 28 Sep 2024 09:53:46 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, yosryahmed@google.com,
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com,
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Subject: Re: [PATCH v8 5/8] mm: zswap: Modify zswap_stored_pages to be
 atomic_long_t.
Message-ID: <20240928135346.GD957841@cmpxchg.org>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-6-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928021620.8369-6-kanchana.p.sridhar@intel.com>

On Fri, Sep 27, 2024 at 07:16:17PM -0700, Kanchana P Sridhar wrote:
> For zswap_store() to support large folios, we need to be able to do
> a batch update of zswap_stored_pages upon successful store of all pages
> in the folio. For this, we need to add folio_nr_pages(), which returns
> a long, to zswap_stored_pages.
> 
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Long for pages makes sense to me even independent of the large folios
coming in. An int is just 8TB in 4k (base) pages.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

