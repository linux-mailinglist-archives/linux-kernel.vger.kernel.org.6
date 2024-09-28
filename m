Return-Path: <linux-kernel+bounces-342712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D74C989201
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 01:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E8A1F23F12
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 23:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50074186E2C;
	Sat, 28 Sep 2024 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXTtRF+B"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCDA18654
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727566058; cv=none; b=iOJ1evw2N2lXseRhXynSYFKdhy5mHi9nvbvp01Sn9/TCDbZIftlC/rEDCtEIL31F65T1yeZ6u9h9CIXy4rMZV8fJI/QHHx5zvfruwitL7Jq8s9whN/RRkqlUul2Vf5EZWDIl5+xzJsO89MNgVkb+aSR/RKdM1tY0wSf5a/4LX2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727566058; c=relaxed/simple;
	bh=npv6Rj8FWCOZ8gEBRCao7lujGD4CQ1EdbY1kbZ5iaaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxLTtePPpvlNXTbLHluebnlv1QgiXvAW+x8TFxQ/yeRs/MlTONMcOjdCZ/QpgNjOgv5HglBR66YSqAdst7L4E/9EAmqcUUwbljxsx4n7ZrHqsbaAZY6bhMPkrhv5cKZ8pD+jmdWnyJZZZKfu1+CYoY/X8soeVJ4g+z8OHj9XvUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXTtRF+B; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cb2a6d3144so15960416d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 16:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727566056; x=1728170856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npv6Rj8FWCOZ8gEBRCao7lujGD4CQ1EdbY1kbZ5iaaw=;
        b=JXTtRF+B4s+2NFAztbMtUH7q3+edZCJe5PO/i3y2RnwEQ/SeV49DPnh1IHh0MgxLTR
         +lC35796skB14leLeCSt+yXUAZPT7HeFJkSUliqaMg0k3jxQeeJimK+UaPfOR2cm/G8e
         WMGtpYdkDU8ZbNVin/lIq2u2OXSkt1TnL4DhkCj/o6sBH4MdYrw19/mP94nbBYkZagKE
         jETl/9RBdrjvhbOA9LYcfCJ5oTQ3XtqrRz0Z6lzkJvvNTrZ9/CnGUAv60lUvvH9kepPq
         qW10nPwTg7Abd9/zKZ8CRDvJ+6s1pDy1QaPTswW8T4wtdSHI+1pqSsJWmHKU2PEw7Mgr
         defQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727566056; x=1728170856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npv6Rj8FWCOZ8gEBRCao7lujGD4CQ1EdbY1kbZ5iaaw=;
        b=EDliCvbobX9bdhFWak3aZJawYEqY7x8mcFoSP+xAzeZHoCqinnI6T8zNWHNYggsgTQ
         IKojwjy3FlpXQc0Jp0Xe6J/j0YASNBcd1iUp3CF1mr/XML9AA1Dx2oQAwCHiaJzy1wbg
         jp0TQPmXZ/aLMmcZ+J6E8MP55hUlQOWAB/jVw4JbcPX+AWP48qAMFIK0yw/T3yKdHHCh
         aNHiI8ymhO8F8WjykOSZdYY28i7Q34Rv3pXPmwaIYPi2K63JEzcCco9IHrBHyzpe1NkQ
         NRDV8gNFCL3lD+/sAzhvjpRYXKIlmZj08fYrz5EynBmQNnvt1VkJVQ8ef+t8vZTsB6Ji
         SgYw==
X-Gm-Message-State: AOJu0YylPfhBOkGW7gRIfkmGgWEz4K205CcUnxN958nDyXuNwlOz2KnD
	hnflYVWwZ4h/8QdIZ9fXD3H+eoEZYLLCuzE4Muky0UUpcPqYvyY1Qo8xrjqT/D90zAfCGJaUY+x
	Ko78zeSQ8VFAzcQD02jHvo9ceyyY=
X-Google-Smtp-Source: AGHT+IE0/dKYerdIMnZGH0rnfGoWpORRuQM4LjdmeTujKZ6oQ21kxTgnWofae4IHKA4mGsBmT+zODBjm7LNEB6nkSK0=
X-Received: by 2002:a05:6214:5549:b0:6cb:2ab7:56df with SMTP id
 6a1803df08f44-6cb3b64deccmr107912196d6.49.1727566056169; Sat, 28 Sep 2024
 16:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com> <20240928021620.8369-6-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240928021620.8369-6-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 28 Sep 2024 16:27:25 -0700
Message-ID: <CAKEwX=PeF2KmOjhswDyAYJcPAREosARnpQTFKK+vRXgFwLwa_w@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] mm: zswap: Modify zswap_stored_pages to be atomic_long_t.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 7:16=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> For zswap_store() to support large folios, we need to be able to do
> a batch update of zswap_stored_pages upon successful store of all pages
> in the folio. For this, we need to add folio_nr_pages(), which returns
> a long, to zswap_stored_pages.
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

