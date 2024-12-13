Return-Path: <linux-kernel+bounces-444847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC5F9F0D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC9D2843C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F31E048A;
	Fri, 13 Dec 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHV33kyS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B6238DE1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097135; cv=none; b=lzvuNx/CrNYy8FGf4YKyIo4fzHfVY/scY/rt26AVy/m1F/Dpxa+XpLfeTNg1nWG9qHt3eYbcEGs9sFLVdS1+hPgK6xBz8TiQnmiEMtvT0MQQMXLGMdJ5j1mV97hF6K1gkPBraFlCs5cimifuZnvq8NWsuHu/IFpV3dmcG+wIkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097135; c=relaxed/simple;
	bh=5RZh7hnP3yWoi+qXTAw32Ht7P/z+WccKnzz3BgXMpRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iskfd68fX0Z8V5rLsT7flD9rJvIu7EqNZU6dS+nOowIk3U/yVqJdJ7FpDYZ73VwKytS6DX1CEPOMAlp+NF7w8JurW6B0ia6s/0Yg62gaLSjA5ejnDrXafrTW+1vp01ACsOnlJX8bf7fVH2+F5sedEuTspkxOOkMmZAG3AYXnPWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHV33kyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA32BC4CED0;
	Fri, 13 Dec 2024 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734097135;
	bh=5RZh7hnP3yWoi+qXTAw32Ht7P/z+WccKnzz3BgXMpRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oHV33kySg59RojrVWR0d4EL5X5iJeeyCVwwBfifZOShteZT3/UaHGcK+lRcWYT3NA
	 wUimb8BRkSnCNiC1D9pVUCbVlMCzPXjQ/tPiwdqP89WRWDtQyV7EqB2o9KeMLdM9l3
	 aXltBNUucNq9aPqkh7BmP7nI6iRnuh/IWNqQI/T/go4phxSfngYc1HOyGsarBpyZaA
	 Vq/quN6phphz6Onk6gSLrlM2zcHgl2sIT/iVKQolRUCQIYZbF1gv2MyafZiXw492jf
	 ULqFXNSmoqjwBNCSnnimzx9tkP8PW+n1jwCopEl0p3x9ddO3cmhjl2+EaDO+W6A19Y
	 /2/56UqawA7hQ==
Date: Fri, 13 Dec 2024 14:38:52 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v3 4/7] rcu: handle unstable rdp in
 rcu_read_unlock_strict()
Message-ID: <Z1w47BFWBVIHWFeD@localhost.localdomain>
References: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
 <20241213040658.2282640-5-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241213040658.2282640-5-ankur.a.arora@oracle.com>

Le Thu, Dec 12, 2024 at 08:06:55PM -0800, Ankur Arora a écrit :
> rcu_read_unlock_strict() can be called with preemption enabled
> which can make for an unstable rdp and a racy norm value.
> 
> Fix this by dropping the preempt-count in __rcu_read_unlock()
> after the call to rcu_read_unlock_strict(), adjusting the
> preempt-count check appropriately.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

