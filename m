Return-Path: <linux-kernel+bounces-253512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265D6932257
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5AC1F21F32
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64C71957FD;
	Tue, 16 Jul 2024 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZVRYIMa8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1A71448ED
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120387; cv=none; b=Fv28InjmSQW2K3unImI3nnltn4ahqvYTNBLEQ2f7AUYC1kYCxwGbeYLRikmaomhl2MbEDsm1Cxa5mpTYwMf0WwVLzBsy2wWm/8djckbsXy07qLYnWVjSHtqBirlscLpbcgZWSGZolxF42jJC0GXqLFavtfXKwN81kOkUzBZr6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120387; c=relaxed/simple;
	bh=vfMZ4OOea8EYEcHwJZTVq7OQ7I5SYY9dGgEUDyxNsaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkDSUf6bnJBCw5lpupGvnhclOaRTrLtiMj/TFZ9qEyZR3b3w1EzdrZlwNS79GQGEPYHTTEy20fa87IjlohYO1eFtP2ktS1a5k6Xn+qgMupXif3a3QeObuKPbMWpx/QDUipsDParD6HOnsxBPDcgy5qqm+98Kj7mXKz7hnLaSg6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZVRYIMa8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jaFiRh7yQfXfw/BcfU9waynT2DYhHakIUKB6SZF5G4c=; b=ZVRYIMa8IUWHPH5hktw25NPQXN
	SBdLTAH2h17bcg5qY3lSl1j76GHHA8CGILG6L5JUa5V/MOE9XtgueG1UlPhG65wwx0aUmqAfPEH+5
	gWgapmGLcMJSCJ8usJe+e3NvpA7O+5RBhQkd7F/jU0q2BG1cZlPJ64cNbZASZZWHzbM0/4QUUIYQT
	d46EHEoy9thWekrS4lW+uB+xGosY/bOMovY0WT2S8KysrommSq7X+eghgqvljMX287vS8J3POd4s7
	GP6+QeIylp7Y3hbKftvUtsyNJ4oMTOS3siZ3UuGUWdRpvDxIBfky1vnrpLhlKIfuXEkNnaQ2i0852
	EUmo9nrw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTe1v-0000000GuUC-1cTu;
	Tue, 16 Jul 2024 08:59:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F361C3003FF; Tue, 16 Jul 2024 10:59:26 +0200 (CEST)
Date: Tue, 16 Jul 2024 10:59:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Xavier <xavier_qy@163.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH-RT sched v3 0/2] Optimize the RT group scheduling
Message-ID: <20240716085926.GP14400@noisy.programming.kicks-ass.net>
References: <20240716052543.302383-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716052543.302383-1-xavier_qy@163.com>

On Tue, Jul 16, 2024 at 01:25:41PM +0800, Xavier wrote:
> Hi all,
> 
> Patch 3 fixed the issue with handling tasks with prio set to 0 during
> the execution of blktests.

*sigh*... are you actually using this horror show?

The plan was to scrap this code -- and replace it with something based
on deadline servers. Sadly not a lot of people are able to work on that
:/

