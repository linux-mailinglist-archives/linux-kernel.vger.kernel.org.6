Return-Path: <linux-kernel+bounces-227906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB04E9157F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A851C21F90
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556081A0720;
	Mon, 24 Jun 2024 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGmfrb+x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE351A070A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260983; cv=none; b=A2o9Cu65FQRbVr48fID2IGUZkqdWm4cALOtyywS5Ac4FOdxRF9Q47ijBjc5p5DPlBFnRWm/BRpl/oIYSxjdHRRijih/R9KD2iKaDoF4D/u9yoZKu+osOXI6cSi/VGifdBJgnKjsw0rE49K5vN/5odz+lGv2PvSU9pKVFZvDtdp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260983; c=relaxed/simple;
	bh=u+BpKOOoJfeRpAxwIr98z3P4xzupMrSKTfoKTBmQTCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9dnRxTG5LCHtMNxPrtqbB0EX+syyUcZTK+SzfcBX3HHAsnBS8QqqWIcLCMNM669L2uHT9oNcjzRrPbQj3MZe6LfFpJi4Kys8WsHigsjuyx0coq5jSY01IRWkaXYAn/uFeojNFnd8sqVUlj+WWe5CS8vj6nrVr0N5TtX+CNfNr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGmfrb+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78F8C2BBFC;
	Mon, 24 Jun 2024 20:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719260983;
	bh=u+BpKOOoJfeRpAxwIr98z3P4xzupMrSKTfoKTBmQTCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGmfrb+x6fpsp0DtCcZkkILdy81ZzthCBA2Nvx9+UtwF7gfpvZfgr1M0yn7n+Uq1Q
	 MY/EhWP2KhZjWt+SvPqXM5Z+nJHK5FkTnD5OMiFSo6CMoG5/tkQOCEp75vohcdegVT
	 b1cXFMMi//ax5MSpjuMyu8E3nNS85jEPIYjcOP/ITv69306WCPlG7HIu2w0UsODsfV
	 hQe0Bjhfr3lXrxxFwkhsyo41aSxGPvL3BuZbV3hi/I8jt4Vzde3e2xS9/5fsl5MuZr
	 9X7Zaz5LvRDZrjy0whcqaQe1XV5zm8JAcGM3GctSdmQoiZjIb3KmHK5jW8sPI/CJ5r
	 Zuw8fmdKLwruA==
Date: Mon, 24 Jun 2024 22:29:40 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/5] timer_migration: Do not rely always on
 group->parent
Message-ID: <ZnnXNCOJ91C_CSZg@pavilion.home>
References: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
 <20240624-tmigr-fixes-v2-1-3eb4c0604790@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240624-tmigr-fixes-v2-1-3eb4c0604790@linutronix.de>

Le Mon, Jun 24, 2024 at 04:53:53PM +0200, Anna-Maria Behnsen a écrit :
> When reading group->parent without holding the group lock it is racy
> against CPUs coming online the first time and thereby creating another
> level of the hierarchy. This is not a problem when this value is read once
> to decide whether to abort a propagation or not. The worst outcome is an
> unnecessary/early CPU wake up. But it is racy when reading it several times
> during a single 'action' (like activation, deactivation, checking for
> remote timer expiry,...) and relying on the consitency of this value
> without holding the lock. This happens at the moment e.g. in
> tmigr_inactive_up() which is also calling tmigr_udpate_events(). Code relys
> on group->parent not to change during this 'action'.
> 
> Update parent struct member description to explain the above only
> once. Remove parent pointer checks when they are not mandatory (like update
> of data->childmask). Remove a warning, which would be nice but the trigger
> of this warning is not reliable and add expand the data structure member
> description instead. Expand a comment, why it is safe to rely on parent
> pointer here (inside hierarchy update).
> 
> Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

