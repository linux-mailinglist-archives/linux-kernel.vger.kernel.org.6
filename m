Return-Path: <linux-kernel+bounces-330568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE6697A03F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C301C218CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F0814F9FA;
	Mon, 16 Sep 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y+TA9Ovj"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDB1208CA
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726486238; cv=none; b=pW5GT0hTqOe2ZPX66Vee7MeuXxsOyUtTfGRhwckLPdFZ8QV1JOXOGHyzF8k9TU5GWS61yEm0dd0UjgFdSHKdZhyYeHXgd9BQid5NPI1Hwir/UNt8cTCatJXQRPQOCl6gBvzTdlTXAA+gC45cqiPUf6N/UJktaUbg0DNDeP07nJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726486238; c=relaxed/simple;
	bh=m6jH1htB5FdgJVoEJa4KBdZa2hyJQgdYmVTkYudxVTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hevAuvMIvRtUuxrxXRv/UGZI8EG777xtJlcCZYQVwFR/7peLUz1jQoLd/XlQXyrNPmG/SwrRYehZayQROrJT07qQvdb2MXVmFQM14nTXOy0Tc4Ud8cXgG8O2ds9JitCsNAEfCvfPtJGIc2uygaqRqCsIflhHblq1u5u7jdldjiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y+TA9Ovj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m6jH1htB5FdgJVoEJa4KBdZa2hyJQgdYmVTkYudxVTc=; b=Y+TA9OvjKnKh5m1TmqaZU1DKj+
	/VHFL/XVtOCU5oV4v83bhqgxlzAIOd/KOgboFPNQAAyVd1WZFMOmtP/mlTgyoXbJ2ObmN+GqcfO9K
	CI6ZhGma0WIkcyz5gv2/UWMSDF4tjn/FveacprrRRFLHv4EWX7MXFrSJnw1dZRxLnqBPw5A43q/r8
	hds0r7zUcFlS3Iqx4TqUD5nNZJa+LnVwiqmxI/A8ItVb8RRqiqBvlvBqSqMJq8RfiMXm/OIkprs2I
	ZvyMYt0fLeyIryYjP12Mb8qECEDCfZ9YxbxQLPm8KbreqicWlUkzj8AyKQsQF1JV3dZ01zxQBIPwi
	Qtm8gdsQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sq9w6-00000000NdC-3K0h;
	Mon, 16 Sep 2024 11:30:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 41D0230049D; Mon, 16 Sep 2024 13:30:30 +0200 (CEST)
Date: Mon, 16 Sep 2024 13:30:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	vschneid@redhat.com, mingo@kernel.org, sfr@canb.auug.org.au
Subject: Re: [PowerPC][Linux-next][6.11.0-rc4-next-20240820] OOPs while
 running LTP FS Stress
Message-ID: <20240916113030.GZ4723@noisy.programming.kicks-ass.net>
References: <82b9c434-a0fd-4488-95be-a45b8cd4b6e6@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82b9c434-a0fd-4488-95be-a45b8cd4b6e6@linux.vnet.ibm.com>

On Mon, Sep 16, 2024 at 12:00:52PM +0530, Venkat Rao Bagalkote wrote:

> I am seeing below kernel crash from 6.11.0-rc4-next-20240820.

0820 is almost a month old by now, did you verify if the same happens on
a recent kernel? We did fix a bunch of issues around this.

