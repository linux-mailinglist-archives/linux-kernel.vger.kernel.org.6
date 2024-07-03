Return-Path: <linux-kernel+bounces-239480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E763C9260AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5283028A61B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C053A177992;
	Wed,  3 Jul 2024 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIYNugZo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383117625D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010547; cv=none; b=RE6v/MF7GYglVF4rH9M8YAPwKaVvG92s3rQWU5T0xnEg4OaRuBlamfBnYSZzSK2Bkvfv3JCNAeif3SVL5htJmlmkRR3C1eaQtGMVZAK3o3ukyKLd0yq2a60L+kZkxl5m0SVuK96Hi/Tgzc5HuqJbNpfhTf+COjqvkn/+VZOHPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010547; c=relaxed/simple;
	bh=aR1sRx+5wdnbbOfVm83Okl4fAoRrSX+0k5m6goYQEpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e950qZuzp4bIhgMn6nZKDuYQsa+EvKQfJEHjwZnfeYY+ate8tCyQ9XTIa17YbISWDEm2324W/uQLfELAv1X6GEK4vAAngshCh7xdjXsZv5NwbaWQMJeBEwLKPNBTelV9sWoBEgPq8p4BlGxDLx1nJ3X7QrM5EN71n8YRd9e8qAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIYNugZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEE5C2BD10;
	Wed,  3 Jul 2024 12:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720010546;
	bh=aR1sRx+5wdnbbOfVm83Okl4fAoRrSX+0k5m6goYQEpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIYNugZoG8VEjVphtS3Y/PX8inBsZU0V+MVKBkko/hoqZOXRXDRSNiD6wB2SeCw1u
	 mLFVcsO2vne//xQiiPyCGbS+nynPeYPtfMPtCZZLenc0JHJ/zLpOX3X0Gz7Xctj9rr
	 g5gefhklAFIUqbtNMfpIq17/9K6quXal5A+MkMFmvtlEQd6+HHg+z+YzjhONOb68Gm
	 xhIu7Psd7gAMIOK4OKuzo8D1f2AikssMdOPS1lyXjypZopncE86KzlC1Dh/htd8HAO
	 Rtpw9eTkLdv8B5N2XZVq/mjAnykOuRpE+7ncdeYGQ0wkChtUMSyohNj8J+SIgryAOJ
	 4W3ccI1rlb2nw==
Date: Wed, 3 Jul 2024 14:42:24 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/6] task_work: Provide means to check if a work is
 queued
Message-ID: <ZoVHMOb1ZN_OvL5q@localhost.localdomain>
References: <20240625135244.20227-1-frederic@kernel.org>
 <20240625135244.20227-2-frederic@kernel.org>
 <20240625141539.GA14254@redhat.com>
 <20240625151624.GB14254@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625151624.GB14254@redhat.com>

Le Tue, Jun 25, 2024 at 05:16:25PM +0200, Oleg Nesterov a écrit :
> And probably task_work_add() should do the same when it returns -ESRCH.

Good point!

Thanks.

