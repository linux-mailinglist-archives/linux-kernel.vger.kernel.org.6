Return-Path: <linux-kernel+bounces-217888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1F790B59B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCAA1C22ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8D714F137;
	Mon, 17 Jun 2024 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B3KanVpE"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6981914F129
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639436; cv=none; b=cHf/PVMxXWYDDVDsfsuUih/wGMXVhR34++NUKjgWiQppM1bccfOFcTaj7073h3P59Khe6WrgU+fFJLysZkGFjs4br5RrdIAC++gaHTD85iqVZcytkLLC1opGaZ2vagvyqbuTtk317LdOAjX+IjHlZJRuc4JE6O0Ckf+2T4XPdjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639436; c=relaxed/simple;
	bh=6c6xgA4P8aORyStWKAmp145H8gS8e96XewBDcMkrTnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbTt22KPWqD7WpbT+0cFUS6kHV9EXuWQujKcaUIQlKPKvOgdfZCyfHdNVILKGlW64UO3r17T0Z3PNmrLHa/UvQFSeQd+OGRBUsC338V/MpN26u0NxEeshb+cPoEV+P2Bcbtdhnsj8YQdZt036GR/2X9kPhpI19kWEHwE3g/tJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B3KanVpE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GiXMDBQM2bh/ZHhiF6KpBhIPYwtm+O82FUi384eYgSE=; b=B3KanVpEM4qVys33j0B4ybIHTq
	QEtaiDIDcn98mlFRvNw8gcReaLNTXNqz8gUgHdfF52BYsH2HnZnO+8rUr5Bk2lSyhcUISttIC19MC
	mEWJo6DJLpYw4P4PyjPFMyruErq+/54mJd4q/kOxxHSnEx3PxzM0BluuOdPM0FwXrFp8w+BhO17Mr
	LtoZAX25mUdKut88e8sIzx1gjH2IzINVEpi2PhT8tPf0iJH6zTqsGutu/OcRJugOfciPJypAzOSjW
	qjnI9JCc3Xtv+fbrBIzI1FmVtnj7AZRDRtNplO17dypl0iykP4YHUTZlF7JsG9YmVgdKUf1Msue5t
	BgXOcmng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJEcm-00000006V5O-2ZVg;
	Mon, 17 Jun 2024 15:50:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 144F330088D; Mon, 17 Jun 2024 17:50:28 +0200 (CEST)
Date: Mon, 17 Jun 2024 17:50:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com, eranian@google.com,
	ak@linux.intel.com, yunying.sun@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH V2 1/8] perf/x86/uncore: Save the unit control address of
 all units
Message-ID: <20240617155027.GX8774@noisy.programming.kicks-ass.net>
References: <20240614134631.1092359-1-kan.liang@linux.intel.com>
 <20240614134631.1092359-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614134631.1092359-2-kan.liang@linux.intel.com>

On Fri, Jun 14, 2024 at 06:46:24AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The unit control address of some CXL units may be wrongly calculated
> under some configuration on a EMR machine.
> 
> The current implementation only saves the unit control address of the
> units from the first die, and the first unit of the rest of dies. Perf
> assumed that the units from the other dies have the same offset as the
> first die. So the unit control address of the rest of the units can be
> calculated. However, the assumption is wrong, especially for the CXL
> units.

Oh gawd, that's terrible. Was this actually specified, or are we hacking
around a firmware fail?

