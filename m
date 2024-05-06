Return-Path: <linux-kernel+bounces-169679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6388BCC26
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594B51F239F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255161DFE1;
	Mon,  6 May 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG9IPPL7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617131DFE4;
	Mon,  6 May 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992001; cv=none; b=hhLULRfR8UylHSD31YHuxArH1c29BpQSs2l9du3QA3J2GwBcrmi2w5afXwRBL+b48oW5brfvmhEFvgmtf3Ie0EOmqfQmTaYQaMtJ3bomNewGnMsuVL5frS0v77nwqNcexrQLE5c+XNYjea2/0O33eaAHRyqqJTE90OK7f0d3MQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992001; c=relaxed/simple;
	bh=tDfOelPn8V9dkLiL9K3cCCumanrN8V3yDR3cRFRMZtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xh+gIt3P1KX5eUbZzj9Spy1JG74RMvvZn15b47W9FfWGKh2A42RFZT6P16Ht8NSYKld36+Wrlx54w+x3o8Fz9iMbFU22/0ExGINENnk66ipTO8CnFpGXP5aY/QviHkCgX85X9oJ9s6FU94+M7GbvOWtfGebbPLw67/BDGGEagLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG9IPPL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B884C116B1;
	Mon,  6 May 2024 10:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714992000;
	bh=tDfOelPn8V9dkLiL9K3cCCumanrN8V3yDR3cRFRMZtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DG9IPPL7dgNZ7H9WO8QUnHLPphxrExuDCg3YqeidDGxC/dSR3hl6qdtH8/zyL7+U8
	 ExAPUQ98YXLjwOKywlFmNQrK/fhLHn5bcsgqaEv5z6ipB7r6RM9WykyqfH9Sem25nk
	 tY2hEISXqIzKz7uyHKyDonABJk7BUKB+zP7GktciSfzyNE39ORxXd7t+L3tinYlTzF
	 QfHmn2awxYxbB0aMmziEKAh2fe2mCzcKx4903qVPtL2jaYkAHiPjtKl7XJuEERtwXs
	 Q02dnHMWmVyw+y1SLnjjaTsqew8kt/vQ95pSB1bmjgMh4rfHQDGbWYeytEfOM5samR
	 Dte1gwjR1rxcg==
Date: Mon, 6 May 2024 12:39:58 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 02/27] context_tracking, rcu: Rename RCU_DYNTICKS_IDX
 into CT_RCU_WATCHING
Message-ID: <ZjizfkwruskzKAec@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-3-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-3-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:06AM +0200, Valentin Schneider a �crit :
> The symbols relating to the CT_STATE part of context_tracking.state are now
> all prefixed with CT_STATE.
> 
> The RCU dynticks counter part of that atomic variable still involves
> symbols with different prefixes, align them all to be prefixed with
> CT_RCU_WATCHING.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>

Actually it was suggested by Paul :-)

> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

