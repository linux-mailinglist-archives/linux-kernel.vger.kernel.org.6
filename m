Return-Path: <linux-kernel+bounces-407823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 187A09C74C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BD41F21E81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA5612DD8A;
	Wed, 13 Nov 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1BF256d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E02AE93
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509438; cv=none; b=WBq6FBllvfl3jjPFbindDskui2UGxo3OpaHgmTzO6CrB/ROhPOanGcSerh83H9uYn6+Lp6/397j9iSgoB6OBq+4QWTnFcvyBkOaKBsAI3sYu9vOSnyCyVC4RFgFoJ29urTm982fxKk5dKvxQe2mjR7/ztZNnR9+a0iYhXmSN0NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509438; c=relaxed/simple;
	bh=X8mFCQYnvJSNUc4OPD3wmYeYdZokj4EvkEqhXAx/ILc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkVuUYMAEEpzKBkrflpq9SwVXNiXt7oCske9KMK8WwSrorhjPG/Fi1JlWzsKafUV7J/rA48yZfqJe76ztL7RFv8BlFdNj/m3tRdfbuk3k8izWbvkKhOywEqe3WVRbBxIdlQQRXNqDQJH6Py2h9r9K+0KrwY6SR+JvhBIkKl0rUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1BF256d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9A5C4CEC3;
	Wed, 13 Nov 2024 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731509436;
	bh=X8mFCQYnvJSNUc4OPD3wmYeYdZokj4EvkEqhXAx/ILc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1BF256dqBCOfPSJxtWXwsWYkq9pOmz9p7YArJwkjYw3oYspvTu0nsQEZuMSxQI3A
	 COLTzkzN6fnH5qxO6XOEnlGHGkOKFZM8goMlIY0yYV60X8X+5qv4bFQbkGzuydawup
	 QcpIzFAC90rq5N1KjbxBZUxkmHr/ElNHSDekUPbVaRyegzIwG9IlP8aW4OV/2NEK0P
	 5sv5ycb7mUZHVjrnmKFThzmAfOeMCOVSnz/KRCQom6x9Tkcxkn7C1KIHeoxYfPH+vf
	 9G8cxO25dQ/TxQzTWYexRl5k4RtCP7MeOXBCtE1CfgERoACOJC60rlWHq/E5KVhvC1
	 jSe1EUEStWMGA==
Date: Wed, 13 Nov 2024 15:50:33 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 1/6] rcu: fix header guard for rcu_all_qs()
Message-ID: <ZzS8uUYDllho-fKu@localhost.localdomain>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-2-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106201758.428310-2-ankur.a.arora@oracle.com>

Le Wed, Nov 06, 2024 at 12:17:53PM -0800, Ankur Arora a écrit :
> rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
> is conditioned on CONFIG_PREEMPTION.
> 
> With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
> CONFIG_PREEMPT_RCU=y.
> 
> Decouple the two.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

