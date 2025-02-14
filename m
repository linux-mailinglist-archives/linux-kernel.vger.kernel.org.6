Return-Path: <linux-kernel+bounces-515679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9476A36796
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF8B3AE6CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF2F1C863E;
	Fri, 14 Feb 2025 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAYO5fd7"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723D18D65F;
	Fri, 14 Feb 2025 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568864; cv=none; b=jCxg0AH7J9OPWSti96yqQtEav9dKArFLMPssrYwVckZMwYHY3un7T9NhWbCDscgbJWqww9XkxOpifZEt08i3kxPGT6kCTW9u6bkyCQNRiBNR1XcuN2duReV5XY06mZqNIMpvLHcHqdnugH7+vWZ6OwyiEY0WqN2y88V1H+93hWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568864; c=relaxed/simple;
	bh=Tm6Q8E17ESs78RyO1F4EhDwGngIxgLnmFOc7QTHzsFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tkMPkitTE1q29ej1eP7FnZR2mZvxDiMksDHjNFqq/Q9UFoqJmuOCHdC/X0ybsGxRdH9qg+7a446BfH8Pp+VOV9boF0siVjmUXBApiHCp7mrcdwOYveqHcpd4jti/erJr/l2f6RjrBr/PZp+uCrZ4xq+UUxq8utEf9cnzohMx+3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAYO5fd7; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dcdf23b4edso22320276d6.0;
        Fri, 14 Feb 2025 13:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739568862; x=1740173662; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E8u7wIHG8kSyEgQ8ATJAJl//wkpaMbHWlAYLaiSoP4M=;
        b=FAYO5fd7aacJgLySzs0NlgalE+zPmURomyAcqehkunOj5/y5iTs68VLO7w38ZmNW93
         7BjBX0BmadQcaF6TDnHoTwolnNQ8TAKAjW6Qy3VFC9pPB8dozplWlbOsNpN9kr44Zz4b
         ezEWVZDbBK9zdfgfJzeCMg0cMLcYrLO0djh3y0jzt7Z0pZTZIdXlXIPVbQ/xAr1bT1oj
         2U2hUa6gdsovKcfZ93u3El+5DmcRf1LccqRnROBoGvmtSId4C8TB022jzj9ExXQl9Z4x
         Umoaj0XMHFqiiOIZEMA260yFr7BLY9Eul73uaPYw0eaZRJDt/u/3cbIHioEd46xvtz0O
         aVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739568862; x=1740173662;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8u7wIHG8kSyEgQ8ATJAJl//wkpaMbHWlAYLaiSoP4M=;
        b=RPfKaJjxDnA186oAZuKRgT35hyjZ/+FbXRRllvmf1/RQt9SvXQuSQ89v5FlEkwNXtl
         NUNUwwYeGbd0e0oRxf0jF04mBNWnReK4dPHXQQLAV++Ai4ghbfVfqX4WIV6H/d3cJqcW
         t4xAi/l/FZ9Y88FGHeU4MuQPbF5lX0nblB3/HsqWvJWCmjiMPmHp1PnYc6KYg8tcBINC
         XodRqEHT4xwAV8RsyyUb63ZJu4PhnlcYEte1kDIHhHcjzNuumtKUytmNoCV5Rh/DuG60
         nBCBo+YLeefhG+RXOa1m/go4c6VOgfOt59SWuKKfwevNqxSOEPoGrq4A64vaQ5lQLuIf
         tfug==
X-Forwarded-Encrypted: i=1; AJvYcCVaqBLz3QBtz8eNkLeDbbh7YnDhbFYuGvgwzPQhbsy477DyncyGsjVqeUxT1aelezmLrMqhQa7awTVAp8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwVxsQcfIXL2VaNJE6X4nCbMh8HJflrkoDU1uEJWeGqjLZfViC
	K/dD+n3BBPTJDzIKLvy6f/X0YNJUc8u4eHdFKjJVdOGz3Dh9A1BrOg/Qfw==
X-Gm-Gg: ASbGncsNIEgnq8G0B2dOESlZX5+Zh6CCiUEylvFlgIL3AxybKz0BMdhgvcf6pP+OFWW
	M++Cls4kWYkfHqLGSWVQoJ2jRRBvzAmvVSvaReZ4o8cI+4Dj6/JGK7aAg05/ZquSz6fpBhrx9ic
	RqnasMKTpYFH5yxUTUn3NZdu3U4zzXtZEqvbATk7J76qdVCD79tl+NvRfr+PxfhG+qVx/odMgfY
	7xRCyqY1A5/nzLeD/vTwJyPtyGJatOHaVvrpOxQoW55FBf8xES6zEVwA678FI0MZReHpfPkumht
	CRGkoo8A
X-Google-Smtp-Source: AGHT+IFB/cfp8uk0elSZaZiEfV2GpD5stvE7d2C11AGeFPBZJMGo1qSrFA57elbWNZd7GIVQh95+RA==
X-Received: by 2002:a05:6214:c4b:b0:6d8:8fdd:9791 with SMTP id 6a1803df08f44-6e66ccd4369mr12918816d6.25.1739568861925;
        Fri, 14 Feb 2025 13:34:21 -0800 (PST)
Received: from localhost ([162.208.5.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d779348sm25254136d6.12.2025.02.14.13.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:34:21 -0800 (PST)
Date: Fri, 14 Feb 2025 16:34:18 -0500
From: Matt Turner <mattst88@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PULL] alpha.git
Message-ID: <w3rw6n4cbgmlcylf5gbzzocqhyxjoyjy3qiedb7fzvd7jdwgap@44d323cbjljd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fmxgypvwkyrhsehv"
Content-Disposition: inline


--fmxgypvwkyrhsehv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull a few changes for alpha, including some important fixes around
kernel stack alignment from Ivan Kokshaysky.

Thanks,
Matt

The following changes since commit 128c8f96eb8638c060cd3532dc394d046ce64fe1:

  Merge tag 'drm-fixes-2025-02-14' of https://gitlab.freedesktop.org/drm/kernel (2025-02-13 20:04:43 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git tags/alpha-fixes-v6.14-rc2

for you to fetch changes up to 1523226edda566057bdd3264ceb56631ddf5f6f7:

  alpha: Use str_yes_no() helper in pci_dac_dma_supported() (2025-02-14 14:06:41 -0500)

----------------------------------------------------------------
alpha: Fixes for v6.14

Some important fixes for kernel stack alignment.

----------------------------------------------------------------
Ivan Kokshaysky (3):
      alpha: replace hardcoded stack offsets with autogenerated ones
      alpha: make stack 16-byte aligned (most cases)
      alpha: align stack for page fault and user unaligned trap handlers

Thorsten Blum (2):
      alpha: Replace one-element array with flexible array member
      alpha: Use str_yes_no() helper in pci_dac_dma_supported()

 arch/alpha/include/asm/hwrpb.h       |  2 +-
 arch/alpha/include/uapi/asm/ptrace.h |  2 ++
 arch/alpha/kernel/asm-offsets.c      |  4 ++++
 arch/alpha/kernel/entry.S            | 24 ++++++++++--------------
 arch/alpha/kernel/pci_iommu.c        |  3 ++-
 arch/alpha/kernel/traps.c            |  2 +-
 arch/alpha/mm/fault.c                |  4 ++--
 7 files changed, 22 insertions(+), 19 deletions(-)

--fmxgypvwkyrhsehv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iNUEABYKAH0WIQQWI4p9kkSLArexA0S2sc6uUQPbBwUCZ6+2tV8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MTYy
MzhBN0Q5MjQ0OEIwMkI3QjEwMzQ0QjZCMUNFQUU1MTAzREIwNwAKCRC2sc6uUQPb
B7ZwAPwLFsA3jEKtxa2XAgS04BNbzPP/LXtefTrpeuMtXyg2tQD9EqgZMS7bnmDX
ljzaWFN+ZQAg1DLzwkKLFS+SRvaIRgc=
=IY0a
-----END PGP SIGNATURE-----

--fmxgypvwkyrhsehv--

