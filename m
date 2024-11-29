Return-Path: <linux-kernel+bounces-425557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC8B9DE6AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AAC163855
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646B319CD16;
	Fri, 29 Nov 2024 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQ7J5bXb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30EF158520
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732884576; cv=none; b=D9eF0ukbRHACStRvKuiHF3uxK0VPoZWB+2sXTp8S3rKRZ++TRtwWcGrm4B+aNYUi4R62wRW1XznfOGCLE3syUwlw19H9eW3PsfXxhExsZCIxhABpS8VSjI4GxA505t1klpu4+PGP1H+2Bmp2DUX6oKRQ7Fv+aZQ4q8ZFUlfbqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732884576; c=relaxed/simple;
	bh=PyQrs98C7ByREgpNsQm58Q+Yx+JV413TsJTjRE6g63Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DARi5nf3MWlJz9kjlz276S3FwOp7tys8773pDRrFKrSz6MedW7dO6cYxRa4KMOLh1ZkrSac/RlTOz3/OF00coQO2hulJ/C9bkfgXZP4q4SYXFwBzHdN1TwjICf4gm2knDt9JUhj+ED28NEhMtQpYrKfvDAcKgk+DjK82b6M/Ho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQ7J5bXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCBDC4CECF;
	Fri, 29 Nov 2024 12:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732884576;
	bh=PyQrs98C7ByREgpNsQm58Q+Yx+JV413TsJTjRE6g63Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQ7J5bXbB8jq2D9OMwvxMDBSu9M98MzcnhnpScKDNNbhT7cPKW/CaOGNGHMw2kwb1
	 zZdx3jAsK0dJRmSbOIUYznhuNyOPOtlorXjaapMFPDLDPEvdo+vYTRjoqLenJFqCB3
	 QF7a0bFjnGy8HDjQikfrfOvNa/Aod0mZAl5EVqr+Tf9i+Hi0sQj6bJOoX53DTHujtX
	 xxlsMyObNSEJEoIWxLapzF2knCQ6vRtW/pz01O2pK6/ezquo5LoPwavAwc+eZhyhsz
	 E5kSz0DTDEVrFJFZ7RCRUPAGkHxiZlHDaDrMnO7gVwkS1VC6k+CbWB+gMxBSu1imrg
	 n5tefcXvveOXg==
Date: Fri, 29 Nov 2024 13:49:33 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 3/6] rcu: limit PREEMPT_RCU configurations
Message-ID: <Z0m4XdYo-T_XCtuE@localhost.localdomain>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-4-ankur.a.arora@oracle.com>
 <ZzTGQ_zTS8NrxjW9@localhost.localdomain>
 <87serfgffs.fsf@oracle.com>
 <Z0Xf37hJiyA7O0Ye@localhost.localdomain>
 <87zfllfddj.fsf@oracle.com>
 <87jzcpfbc6.fsf@oracle.com>
 <Z0hjNED_t_lqNFbG@localhost.localdomain>
 <874j3qfyca.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874j3qfyca.fsf@oracle.com>

Le Thu, Nov 28, 2024 at 08:39:01PM -0800, Ankur Arora a écrit :
> > Do you plan to integrate this in a further version of your set? Or should I send
> > a patch?
> 
> Sure. I can add it to v3. Okay, if I add your suggested-by?

Sure! Thanks.

