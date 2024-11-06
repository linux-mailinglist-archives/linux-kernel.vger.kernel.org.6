Return-Path: <linux-kernel+bounces-398363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 170EA9BF039
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA27DB24B89
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8D12036E9;
	Wed,  6 Nov 2024 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nqJWy2wM"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233E2022F5;
	Wed,  6 Nov 2024 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903341; cv=none; b=AZfnYjWRm8AcpXtSUJqLVlfuogWHaECQSOe/G8RYcN0uiu6EzUseB8symjLCwy9flHVa03YTN5PWyb3xrv4S5JhRJjGOefF5Zx2ALo46G7Y+Ne9LemCXFAKhVJCfp0FCCgahrESUUumyXI/LDU5smQuDZZA76kZP+rdYzH943l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903341; c=relaxed/simple;
	bh=TUBw2uIBrv3P6Vu94x6Bt/3l45ZfpEg6eDWmfn9rJmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iIKbY2qkUCRr2o3mPa3FwRFniCouUZGX33yh1Vix01NWc5Vgz0h3FvdN9px9TB2AUVINHYnm+zGEnADYHhagseB+zJ0sBswsWV1CiYrwnMxBJY6wVJtmMaKHuF8sdEqCgkS7nYYHWmisBQAXA8C3k9l3rFh4NnkF+jsDNF1nb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nqJWy2wM; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4A01A42C18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1730903333; bh=zlLF8omotvZApa3hMNvREdMOe0PP8IHuj07kcO93LH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nqJWy2wMQC+qyxsFeZd2htuNSXGlVPULYqAA/CcvISYCFX0T2rWntfYHfE70jEhen
	 P8blfMtfeyKT8jSp2nHOy44EJOFU7MO+V4kMdMutmUXqrp1+VSKu58gQMWPqtzUJ5k
	 q8mnDiWouD1ZyNrrZeTw8Ye3GYze3sB6jWAw0j4MsesXS2X4zidgyvqZ3+iXbJoyAC
	 hFfVpLi9xBqyEmwlY7FEn7nLR/SZ9LjTomWz091R1zWGsql4zq9WrO2D0H6gIHDI1l
	 5IO9d+5zNrJJ1aCwjUK2mnqnq2fkYPgGX+g58dKfTQvAcqPnUUXYw3/VneiJZ6uCGe
	 SxvKSJooXfzgQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4A01A42C18;
	Wed,  6 Nov 2024 14:28:53 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dragan Simic <dsimic@manjaro.org>, apw@canonical.com, joe@perches.com
Cc: dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
 workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, wens@csie.org, dsimic@manjaro.org
Subject: Re: [PATCH v2 0/3] Make Helped-by tag supported
In-Reply-To: <cover.1730874296.git.dsimic@manjaro.org>
References: <cover.1730874296.git.dsimic@manjaro.org>
Date: Wed, 06 Nov 2024 07:28:52 -0700
Message-ID: <87h68k4esb.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dragan Simic <dsimic@manjaro.org> writes:

> This is a short series that adds Helped-by tag to the list of accepted
> tags in scripts/checkpatch.pl, and describes the intended use of this new
> tag in Documentation/process/submitting-patches.rst.
>
> The proposed Helped-by tag fits well to indicate someone had helped with
> the development of a patch, to the level that doesn't warrant providing
> a Co-developed-by tag, but is much more than it would've been indicated
> by providing a Suggested-by tag.

The documentation is meant to cover our existing conventions, rather
than to drive new ones - usually, at least.  There are exactly 11
commits in the history with Helped-by, suggesting we're not really at an
established convention at this point.  Given that there has been some
resistance to inventing new tags, are we sure that we want this one?

Thanks,

jon

