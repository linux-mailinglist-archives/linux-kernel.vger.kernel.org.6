Return-Path: <linux-kernel+bounces-318934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB6196F550
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52BE1F24D2B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749AC1CEE94;
	Fri,  6 Sep 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tm4t2fJ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A921CEAD6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629253; cv=none; b=SoLCIr61VI3AixB3vx3g2zud3pSFXQsRH09cEkp0W8n2Q5uvWEknPV7B/EDiHgOyh6yOjLwqi0o6isPUuN9ORRdb0zhfKYempAyQEotG/nDtAl2LSa6/GwafLRmq09U2+kyeZh2l8vZZHFoPZ3ByVd8VYwBqPuPagHIPNoaUiqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629253; c=relaxed/simple;
	bh=saLEl7JSnMdb2yHQxQ7dyU+SPe0RMebWIVrSMslX0pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXBy1jD8zZc/4Udw7ts+9S58s5hgu1pbrdsjyBYeql+IDVheUKKBkNon7SaeLeWsUQ8oLPIVz7yNQ52SBnngsJXkl83Kgu3EzBc8KzWe+YBq0TWiT5enjIyOYhWB9vTG2vNYyH8y2hoqheamY4En634tFbiQy/SnHEdFk1dF8jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tm4t2fJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F68C4CEC4;
	Fri,  6 Sep 2024 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725629252;
	bh=saLEl7JSnMdb2yHQxQ7dyU+SPe0RMebWIVrSMslX0pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tm4t2fJ7zTQyy4qAGX56BVevMGzJh3PjYllVPmWFPs3F3hfHcwIE9AmB25AIXv5cU
	 9OTVRbHSiCTrQnnMhuNlBXfpmCyNeawrNvejxinmfr8dn2uoev0vUzdXzrcc9xj9fl
	 9gzo/miUVzP+iGVtb852iCX/NBuLKaNwtJYpcmS6ysQeoqQfRXlCn1mYkn7vyQuRfC
	 +r6VYiffg906I8cRdT/WbY4H9PHqN8AzpQJvMJP8AU6RvTSkHlZC5fdacCOHkhuDIJ
	 nkYrNzmU9LYtlLIaHYz3MRW+aMrIS5tfiOc50ermInsMnKYm83qTRFPXuZ/p7QPyFr
	 IPRwpLjIJ3d+Q==
Date: Fri, 6 Sep 2024 15:27:29 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 02/15] cpu: Use already existing usleep_range()
Message-ID: <ZtsDQXT_FhuFYy4J@pavilion.home>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-2-e98760256370@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-2-e98760256370@linutronix.de>

Le Wed, Sep 04, 2024 at 03:04:52PM +0200, Anna-Maria Behnsen a écrit :
> usleep_range() is a wrapper arount usleep_range_state() which hands in
> TASK_UNTINTERRUPTIBLE as state argument.
> 
> Use already exising wrapper usleep_range(). No functional change.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

