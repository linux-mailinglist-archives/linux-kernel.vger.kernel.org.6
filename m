Return-Path: <linux-kernel+bounces-568906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B607A69BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654C21890759
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028C421B9D5;
	Wed, 19 Mar 2025 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbNT/bmM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65643217F5C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422734; cv=none; b=jbYQbyLUVaRlI/vrtViQVrLLeT2zWPM51UhsXey+Xha/agICHHnbQMkSVuNnnD7yavVJZRqeFRHO+/AowgFDQoUVKRrSxgdAIrnu8eCEviWJVdO6kiujDH0bdkYaSqeqFWfp0Y6Iky45ibzicTndaPIaiDN8qvvnbu8cJ0ZV7FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422734; c=relaxed/simple;
	bh=QdV1+SMu4HpBGZyg5lnI7/wNWGNcm4ftqeuKf0mhxKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=da0GB4hFoWleh+3jFPJJRLICg40PNyajNGTnMUso9DXnph9n3cao6r6mxjklyeyufgjSiKdqly0Lk+Y549Ut5+BsA3BmRgkcDqGvwU+w2E4KrwljuHcF2+hyHrCoaAf/3PCwWzh+QfY2IZK56ONBSyM0w146aZqZ1U0llzWgUDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbNT/bmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE13EC4CEE4;
	Wed, 19 Mar 2025 22:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742422733;
	bh=QdV1+SMu4HpBGZyg5lnI7/wNWGNcm4ftqeuKf0mhxKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbNT/bmMSZxdnPfhlzLHWfPLfA4SQwXh9eNHBsNGKCelV9ygzZseK9QL88GmlUvHR
	 gC2Cuk5OpKwXb5gTouPjn2nnHpSoO2zcT88LO26Aze4SnsKHV/kyhcf5Jcx0cCGVtm
	 IpOoXqHt1na5lI3Qsx1/nSYJY8tczBnjMDi837A04AKu7lek90dP0ATzRZhE3pvVrv
	 wmnFx7KLhR9dzvDJzMZwKoX3irxZOwpyhjmK4jXcXOboDcQ4Xy1IMj/DLdY/V0yX7k
	 Bi2zGpT8jDfMtV3QtvYBDpwsE5VlZYa1Wiksb1E8vQfTV0/LKQUe/NEqqjByZZOmbr
	 mcFfPb6MUUi2Q==
Date: Wed, 19 Mar 2025 23:18:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Matteo Rizzo <matteorizzo@google.com>
Subject: Re: [PATCH v2] perf/x86: Check data address for IBS software filter
Message-ID: <Z9tCyVkqCzbulODv@gmail.com>
References: <20250317163755.1842589-1-namhyung@kernel.org>
 <0eb55fa1-3b03-4550-bdd7-c7c50294dcbe@amd.com>
 <Z9m20YMkMfUDBxgv@google.com>
 <d1dec8b8-10c8-4da0-920a-d1f744543253@amd.com>
 <Z9spTE_M47M4qpCR@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9spTE_M47M4qpCR@google.com>


* Namhyung Kim <namhyung@kernel.org> wrote:

> > We have two options:
> > 1) Restrict IBS + PERF_SAMPLE_RAW to privilege users.
> > 2) Remove all sensitive information from raw register dump before
> >    passing it to userspace. (Kernel data addresses and all physical
> >    addresses are the only sensitive info I suppose?).
> > 
> > 2 is better IMO since it will allow unprivileged user to use IBS
> > with full potential. wdyt?
> 
> I'm slightly inclined to #1 for simplicity and safety, but #2 is fine 
> to me as well.

I'd prefer #2 for superior usability, if it doesn't get too 
complicated.

Thanks,

	Ingo

