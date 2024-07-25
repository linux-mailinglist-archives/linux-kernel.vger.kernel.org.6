Return-Path: <linux-kernel+bounces-262421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DB093C6E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8366FB23370
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A39019DF5A;
	Thu, 25 Jul 2024 15:57:26 +0000 (UTC)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5419CCE6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923046; cv=none; b=VCXrLYq8vW8y3A2ILTqu+T19P3HcqiCAGrLmzlwOK3Hg5YLnvK9fLsng2imcb5rA4pxU1iphj51TvJAmgSIDF5gFe0CqVkn8iZEV3ZXhn7jCMg3ceggkAkyCCEpE84okqDkm3cIzOWwyss551ILLhz+zEAUWiALLiOH6pkyPB7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923046; c=relaxed/simple;
	bh=oTPONtTzXYR5SDfW8ChCBw8Ri7LlCHzSCVivakusNn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTAqpKvatbsyHG0U/ylvFSAubp8bRmEZJFDD9urR+w9QqSbE7wFS5V6UGbSAaaRle4XNaudfH0xqWi7mQJlKHJH6AMCmQjCzwdFv9JJt3HWe3bSHuoI/r75gvbREQq4HBc9P/tGOqUYls0iSJYXd1XwOYBFoeYPdhuq26LBGBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Jul 2024 08:57:09 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, 
	kent.overstreet@linux.dev, peterz@infradead.org, nphamcs@gmail.com, 
	cerasuolodomenico@gmail.com, surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, 
	vbabka@suse.cz, ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 3/3] task_stack: uninline stack_not_used
Message-ID: <kr6mlwsev2ofogrt2m4siaucticqqclc6zru5q2k74oei65cbk@53fn4wzmgmzb>
References: <20240724203322.2765486-1-pasha.tatashin@soleen.com>
 <20240724203322.2765486-4-pasha.tatashin@soleen.com>
 <grznsm36eydexh7q3fpt57cd5w2g72mb57s7som3wf6c4jt2j6@komzdw3zm2lw>
 <CA+CK2bAWbp7T5tvbFd7NKYYNWyOY1LSiOGAFQGe0BrmSRNQU3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAWbp7T5tvbFd7NKYYNWyOY1LSiOGAFQGe0BrmSRNQU3g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 25, 2024 at 10:30:15AM GMT, Pasha Tatashin wrote:
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> >
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Andrew,
> 
> You took the other two patches, but not this one. Should I drop it in
> the next version?
> 

Please keep it as we do want this patch. Most probably this was missed
by misttake and if you see the commit message of first patch, it says
"This patch (of 3):".

