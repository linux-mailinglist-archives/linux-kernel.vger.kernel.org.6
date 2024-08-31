Return-Path: <linux-kernel+bounces-309698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FA7966F6F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265CC1C2187B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F93A149C70;
	Sat, 31 Aug 2024 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToZBxFGm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EF38468
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 05:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725082402; cv=none; b=QSCnaB+MMm6YbN4CWm3XfTr5BD/rnc/r5KRtaloOK1opRDc7/UiOC868t8+5ZsdGI8Mk9xA16v+Iysh4OjI+SbbPoRxbiNdu3MPCIPD4SnY7671Kl8ui9onRWT8BXh9cJwwT2bFcEjhAxeGWDdczJTprD1HKuDoEu0ixuP51aN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725082402; c=relaxed/simple;
	bh=bFAHwoeDnweIkyPPD48pSqdst+U6MWNnnJ86Dzi66oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB5ZoyBvbTOK0hWpEidwNKCGmTddlYhJWEa2I1LE6dFdpehrd5tEhxVEjq62T47n1rv/V/k8V5XnpMCERdG+qrCIcgM93TRc0Vt1TkMGEr3Ho+eCmHP3a+24Ct6qt/5rsTAWtlp8V/NjnG4FrlLcx5qK/bffwSEs2IYOY7X48LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToZBxFGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26253C4CEC0;
	Sat, 31 Aug 2024 05:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725082402;
	bh=bFAHwoeDnweIkyPPD48pSqdst+U6MWNnnJ86Dzi66oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToZBxFGmYYvGKvbp+tMneXbqrbY9606FC4JPDiqwAHYfQp6DgkaZl8RXwGyti57SX
	 n/Yty0ov3s44rCjCoswWJdPpIArSMbOTj6v0EqQIQo/rXTsvHF1TgDr6xuKiKmk1Xb
	 Nuj+TyWGFKV9ZzsCA8In5S84nrohuMWB8eIWWPRHvYY3ozP0NA+6bXhuSfzoS4hozO
	 JXtbul5ljXLmkipQqqqHQCdwK2qhv5DktqePDOtHqgE0mMucJI5a9CFLUXJkdp2xR8
	 Lp5xipALNso7wKV5dE25ysMorb2T4hcfiJhVkj8KvWnB/CVfDW7VgFpu7dOtERRala
	 kZoM4wdByRpxg==
Date: Fri, 30 Aug 2024 19:33:21 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] sched_ext: Refactor consume_remote_task()
Message-ID: <ZtKrISQNxZIS9JVO@slm.duckdns.org>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-3-tj@kernel.org>
 <20240831040516.GA70166@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831040516.GA70166@maniforge>

Hello,

On Fri, Aug 30, 2024 at 11:05:16PM -0500, David Vernet wrote:
...
> Not a functional change from the prior patch, but it occurred to me that
> if we just deactivate like this then we'll also fire the ops.quiescent()
> callback in dequeue_task_scx(). Should we add a check to skip the
> dequeue callbacks if p->scx.holding_cpu >= 0?

Right, migrations shouldn't trigger quiescent / runnable events. We should
be able to suppress based on holding_cpu and sticky_cpu. Will look into
that.

Thanks.

-- 
tejun

