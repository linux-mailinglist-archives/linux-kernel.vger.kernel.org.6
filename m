Return-Path: <linux-kernel+bounces-407835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD389C76A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91850B34D78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F43200C82;
	Wed, 13 Nov 2024 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfoZ52oM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0E200CB6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509960; cv=none; b=mWAi0bqTTx4FT3F7FgvIqtOs+FBGqby7TKBrkcx6I2Z1Od9Or/MoSVAHeQU92oei+qLeD9TkglV3ovOaD6q3SVlSNFS70TDLDgYI+rGp03kvkbdA+frLNDWc+CbOOOLwZxPYRA+M1QIQFxyXnCu9/UrYrPjc2gPrKyQk6Y2Z7Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509960; c=relaxed/simple;
	bh=CKu64jp1juTalbBn2ApyUk2jf4j3w9mFZOKemA6T3vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKnjosp7C9OJEd7FQ1nNOvK5KUdseStidR2YSngUc92+g3nrNxjul6KxtoBtDBgXTghn63mZXuMuYJDgLOMyn2/6H11kp/qQisIVp+kcIQp+l+IDO6M3CeiKCK+NmKgy55aNnEVqX8r5AhwU04MD/OJf249hDVRNYIymtDuH3js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfoZ52oM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2964C4CECF;
	Wed, 13 Nov 2024 14:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731509959;
	bh=CKu64jp1juTalbBn2ApyUk2jf4j3w9mFZOKemA6T3vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfoZ52oMZXgwoAp3sKIE0YvNgAcWz+blEQ7EQTd8yETMfqBerQrxlyg7ncf62DVV6
	 LH78UMhtwy74CNvf0zkPpzksGdGBCsLKBhHxr33/67jhP+pxOiVnFAJBfAoCyJrpr+
	 xMW3vLhLFfjNuvEYPbCu3e+EMUzIYNueWLHYQlgHrgclf2naBgZ39rlwxfjlMhjKTR
	 pYKlXxioO60bAQtc9nWx4VNsYMWPuD9BdWU8rIUNnRXfvmaE0YamLNUUiRUkzshILU
	 wr80YS4tKtDMR6IEUcC/AC5NKpjnsqgZ8/SHhiACBHgYEBFRv8g+ghpximIcIwCQS6
	 4/F6QOVdwormg==
Date: Wed, 13 Nov 2024 15:59:16 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 2/6] rcu: rename PREEMPT_AUTO to PREEMPT_LAZY
Message-ID: <ZzS-xESs1KPk1D8n@localhost.localdomain>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-3-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106201758.428310-3-ankur.a.arora@oracle.com>

Le Wed, Nov 06, 2024 at 12:17:54PM -0800, Ankur Arora a écrit :
> Replace mentions of PREEMPT_AUTO with PREEMPT_LAZY.
> 
> Also, since PREMPT_LAZY implies PREEMPTION, we can just reduce the
> TASKS_RCU selection criteria from:
> 
>   NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
> to:
>   NEED_TASKS_RCU && PREEMPTION
> 
> CC: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

