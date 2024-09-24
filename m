Return-Path: <linux-kernel+bounces-337444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5202B984A31
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB7C284D79
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B87B1ABEC3;
	Tue, 24 Sep 2024 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hI+i1m5O"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C982E419
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727198206; cv=none; b=utEfAP7yRr1u3+QIohrLK5Yw4kUTTuvGgOqtyBatUuorBbXtbGvm0YWUf6qYAE+DqPe6kAy0hVOz+ZmAaI8OYTu4WSs6x+6kRrlvTTsgdXAU33bT8xdVT42o8XrzIGvYpMf2j6Y9RvOXnFUUIXtss7VlKhoQhfYKeQV7Fv7erq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727198206; c=relaxed/simple;
	bh=9UhF3Lpb3Of4bksCfE4JdFE4u99sE7yWYbcYeHYirRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6QlDD4lfmOn3jhLvCQA9XVV3XQwF7OEheqMsC1gZqdBWiTDj1PveQ0Tez6c/yujbXesCtloUiOyTu/ALUQ3vfQiDBf62cyi/JmA6CXetg5whkQ3uxiTOVMjsrECoTsIShZJViz3NcJr3OGnBF6gmAS9Un1k8egBFnHqk6QxqVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hI+i1m5O; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5e1baf0f764so1751104eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727198204; x=1727803004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UhF3Lpb3Of4bksCfE4JdFE4u99sE7yWYbcYeHYirRo=;
        b=hI+i1m5OBtnOYol/cXfr+jtzhpS7Pssq3vxUtzbw2dTG5z7ZcDcOQczWJ5TPmsU8bQ
         3k4Ug5lPYVVQJm7GkB1Q39NNq0jhGehdG+qQF8KxFVpyjOzAlwRj5uHLn620fAzmCXS5
         d04ANSASyr8kwMbupheUWxJsMofn32KUy1HhZC/RRLow8ukTJnstoneQz3YyCXeNm78t
         tXhPNvG0Ud2Ym0Ja3vMHEU6W1nIDAF3shyrJpenTSYvyF+Ny9AinH2+zzN3aGX0eX8S2
         qjGG0yMxrGIbZiK234Td+Mz4kjuTjDWJmE2EqGtwXEbTc7V2I/cRMHA0D5WUvcP0VakO
         /pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727198204; x=1727803004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UhF3Lpb3Of4bksCfE4JdFE4u99sE7yWYbcYeHYirRo=;
        b=P0SC6MLfVEKgIELnnvpWcy4acfVsSAw/VIe/tjNI7wFDrzSknShmKzFNhbe2GGT/LM
         CkpAbN/h2RB3Vah7A4FlK+BTghmhyxnff4pqByuA67VNbBRnt2qNOaG+VJutZV67pl5k
         8fgc+h9xOPsSIqvBJBwiw/KXqnuiwW7xr89SspN7rKNGHk4IUYAC1cAwmPyJEimmyhlY
         6h/f6vHUWEgOkfBCXE+MEshXPpFOB9uyAPnFLQhrBZc/4q7W5qgiD62QfCmlyJ61f6PU
         y0Qx3By2n+gVNyMNPIgBzwQ4dVpg2GI7PUJ6e3q7kDV/LvyS8T7qItolpI4Rh/6b6BKM
         EGoA==
X-Gm-Message-State: AOJu0YxbhIZxp5lhUYFanjVLNePgCf5yL/aQiJilQzrZdx3Xsslj+BS5
	NPRxZZbQdcw0xNMyosmHytYB5TNr77KhsuIvBoWkCHy87sjSjaIBBovF5BK6ON5BeaBICI7moig
	GzpdT6S8dxTBlnsUaSBfy3ucGlTc=
X-Google-Smtp-Source: AGHT+IGWqlR9a/vTU3vt9Wz51UyLVj7bPEk79EiMAdhuZB9DkQZgKDoAP+ZWHaFUa6CHqH4maDsKuR2PeBCPVjGhdXw=
X-Received: by 2002:a05:6358:618a:b0:1b5:fa8a:791b with SMTP id
 e5c5f4694b2df-1bea867ddb4mr20389955d.23.1727198204154; Tue, 24 Sep 2024
 10:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com> <20240924011709.7037-4-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240924011709.7037-4-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Sep 2024 10:16:33 -0700
Message-ID: <CAKEwX=ML+8uPUm7fMRKJcvqrctH9qf0tYha0TLr0JxzFSZ-z0w@mail.gmail.com>
Subject: Re: [PATCH v7 3/8] mm: zswap: Refactor code to store an entry in
 zswap xarray.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 6:17=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Added a new procedure zswap_store_entry() that refactors the code
> currently in zswap_store() to store an entry in the zswap xarray.
> This will allow us to call this procedure for each storing the swap
> offset of each page in an mTHP in the xarray, as part of zswap_store()
> supporting mTHP.
>
> Also, made a minor edit in the comments for 'struct zswap_entry' to delet=
e
> the description of the 'value' member that was deleted in commit
> 20a5532ffa53d6ecf41ded920a7b0ff9c65a7dcf ("mm: remove code to handle
> same filled pages").

nit: This probably should be a separate patch...

>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Otherwise, LGTM :)

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

