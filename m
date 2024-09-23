Return-Path: <linux-kernel+bounces-336126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 589C997EF7E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE395B21F84
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E29F19F104;
	Mon, 23 Sep 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTNuz6qW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153F19E975
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110033; cv=none; b=b0nXrD10f8ztrP96THmAdWzgh3hvfKbCvg3SmL07K3rlPNAhBnvJea2nJcglJbFzTBfLgcjt8rsanQyssOchFLbzNFVUNmfvkNPk/hGAGO0zeDSuXIAYtanNL4P50yo85IdwT5eZiOC55D7HeBhNAktMFxj5ed8AizhH5rBfpq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110033; c=relaxed/simple;
	bh=O8BQzVjm3qfGSvjlj+uC9Ax2xc7gVkjR7+6Md/HId98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IggkjMDgEV6m7yapZsEiBzI8LOpcDTDJfnw6JeUmsizER6DOx0T5tq6N9v6ZnW0jweaSlamPHDPO/xR+y9fn8jVhwCEwOqp0jFHAzUtW2gCmTDYRTumlpSgB0comdx1mzJGFD2/eZZcmvUbn5sbX145Q1MYglQMIvg5PVGYhcc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTNuz6qW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B7DC4CECD;
	Mon, 23 Sep 2024 16:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727110033;
	bh=O8BQzVjm3qfGSvjlj+uC9Ax2xc7gVkjR7+6Md/HId98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTNuz6qW+eTg2+6GVHk8AscnUlpM5TWxWvjTBsyIRVYntUh5kEhy+mg+gfmrcbiky
	 ifsE45A19aagpzHuWUagxR6D7HKc5hsAcLIPx28f9zicFYiTQXGFWzAP7RLhVEsRbo
	 sWjiWxDHNuIRrpcjgLd/PbPREWfVK4Wr9OQZde841md6913xcbS5sNqtfM16Hxp99I
	 0VVms6IZAIV/4iIiYr9ymBgmilB5joGF7nqzJYqOqkedNa+6TvlZRwmaJd3i9I4v2T
	 ZBtB0242K/wTxXnid06wRV2K22udWAdcgk3WBGqg+PTrYdMtM881nkXnlhfEPRYQvj
	 QESzYK4fuP3FA==
Date: Mon, 23 Sep 2024 06:47:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: Phil Auld <pauld@redhat.com>, David Vernet <void@manifault.com>,
	Giovanni Gherdovich <giovanni.gherdovich@suse.com>,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Provide a sysfs enable_seq counter
Message-ID: <ZvGbkCWR7AbgA6ug@slm.duckdns.org>
References: <20240921193921.75594-1-andrea.righi@linux.dev>
 <ZvCKPkwwC9-o2dsQ@mtj.duckdns.org>
 <20240923104548.GA308802@pauld.westford.csb>
 <ZvGJ_xT2LhYJHQbZ@slm.duckdns.org>
 <20240923160007.GA313849@pauld.westford.csb>
 <ZvGYjKAB07VJW7jq@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvGYjKAB07VJW7jq@gpd3>

Hello,

On Mon, Sep 23, 2024 at 06:34:20PM +0200, Andrea Righi wrote:
...
> > > Yes, the load sequence number should stay persistent across all schedulers,
> > > but each scheduler should report the sequence number at which *it* was
> > > loaded. Note that this doesn't really change anything now. If you only care
> > > whether any SCX scheduler has ever been loaded, you'd always look under
> > > root.
> > >
> > 
> > In my testing root is not there is nothing is loaded. 

Ah, right.

> Right, there's no root if no sched_ext scheduler is loaded. Maybe we
> should always keep root present, or have a global counter and one
> per-sched?

I'll apply as-is. Let's add per-scheduler load seq separately.

Thanks.

-- 
tejun

