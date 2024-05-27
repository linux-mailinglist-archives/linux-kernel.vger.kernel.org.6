Return-Path: <linux-kernel+bounces-190736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8C58D01DD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EE1294D33
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F2915F304;
	Mon, 27 May 2024 13:37:43 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 57ECB13C676
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817063; cv=none; b=tMLHUfoKOI552X8e34FCN0O+LFJHo9LUpopzdeCA4FLL9YBLMZidyzKqG0nQPi2OuQDd5HpT18WdPWQ7RjXZO1UdjaX5Z8bGKDQlrMa8By31u/NvLR9Bfk6hRNRl0uZCRCAfan96cTSSHhMi2uBIZKSJJ0hWkws9W/l9kdL6tbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817063; c=relaxed/simple;
	bh=hu3RbPEZYu07ul0XYi5mcIaOW0Fav7jWM8/YiVU2vBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpbxGVpdBHBOC+1lCwskUT6d/las7Qdt4vI15Smojm4DLvP5cY3Ru7vRUL89/xqAyhewBb0PcUYrEXm7o9sO3LVLjKfyLeom5czmlEcSNL6bI6SBCWb4vx+qxTmeGb2yWX0HQPlWxIRpopS07Py2prq91l8nnG6kCBs923/zUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 660015 invoked by uid 1000); 27 May 2024 09:37:40 -0400
Date: Mon, 27 May 2024 09:37:40 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
  will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
  npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
  luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
  dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
Message-ID: <79b55c10-dd06-4947-8545-20ffeb324bc6@rowland.harvard.edu>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <1a3c892c-903e-8fd3-24a6-2454c2a55302@huaweicloud.com>
 <ZlSKYA/Y/daiXzfy@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlSKYA/Y/daiXzfy@andrea>

On Mon, May 27, 2024 at 03:28:00PM +0200, Andrea Parri wrote:
> > > +    |                smp_store_mb | W[once] ->po F[mb]                        |
> > 
> > I expect this one to be hard-coded in herd7 source code, but I cannot find
> > it. Can you give me a pointer?
> 
> smp_store_mb() is currently mapped to { __store{once}(X,V); __fence{mb}; } in
> the .def file, so it's semantically equivalent to "WRITE_ONCE(); smp_mb();".

Why don't we use this approach for all the value-returning full-barrier 
RMW operations?  That would immediately solve the issue of the 
special-purpose code in herd7, leaving only the matter of how to 
annotate failed RMW operations.

Alan

