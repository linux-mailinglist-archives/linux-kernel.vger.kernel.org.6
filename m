Return-Path: <linux-kernel+bounces-310608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3459E967F02
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAB21C21AC8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 05:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8191547C3;
	Mon,  2 Sep 2024 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ5D+k9r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F615382C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 05:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725256791; cv=none; b=th4uNrcU6DVBfxqktU2kdpj+XxvIYgDjQPfCFzWBYME1k2ZWP5TxgFBP3O7ELI8Qjz8XS9ws2EWtgQ2Qzj2zPfIiJtWAivX48G5+A0DMk/oCArlxo2PZiHl99ErULhcOA/oWliJDrafpEMtDRTbHTvMwxh3w+V05rV1MTPaXImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725256791; c=relaxed/simple;
	bh=rRvQwl9p3I9292cOCveOmB+PYkj3eiNabphAqeHzurU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpOKGasE9hxEglTwsCUduR7dQO0IEjtEUTaPoLKGfcUfLlObb6kOP0lBQrH27O5QAMlbvXr1V9uf3pgn5YcySqo81CeiaqNd212yxN4xUg4wbTyk43KITD+wv7tVOr8A7HG3U8gqL8ccYxvkU7o3rLqaulQ+7JaEjB/UZGB8V2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ5D+k9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA45C4CEC2;
	Mon,  2 Sep 2024 05:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725256791;
	bh=rRvQwl9p3I9292cOCveOmB+PYkj3eiNabphAqeHzurU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZ5D+k9rwUZHjEaQ2+05SEG59a616rgKBLIfpLT3mefjnn0i5oO/1ihnEi+qE2YtH
	 mlmfqdkb/TM7m4+H+rHCZnJrewiGOQ3lQwEDFLBqCRYOvYrZZELlPZo7Qw+hQlGyKh
	 icWW6LVTwQv1BLyccSl6MknBaNiUQZwwV2kXxkxAY+ZvMA/47iART86ulHL99E1hkR
	 TxMvwh1ASlYwBsnyaDuPqJXWAarH4z/4u5O5unFsf7Cml1L44NrcJxlyrpy570DY/D
	 3thHOo65OAfQYXVC3hNvV5eODrtx2eSqakntvwT68do5bWMNZjPJpU5b1eaPKYF8Jn
	 7rDg668V6QaCg==
Date: Sun, 1 Sep 2024 19:59:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <multics69@gmail.com>
Cc: Andrea Righi <andrea.righi@linux.dev>, void@manifault.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	Daniel Hodges <hodges.daniel.scott@gmail.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [PATCH 10/11] sched_ext: Implement
 scx_bpf_dispatch[_vtime]_from_dsq()
Message-ID: <ZtVUVfWYJtl_3hX9@slm.duckdns.org>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-11-tj@kernel.org>
 <ZtMpIb38MSn5r4-U@gpd3>
 <ZtNC6l9nUEPnneag@slm.duckdns.org>
 <ZtOH1YlEgyP45UkU@gpd3>
 <fbca5a6c-d1c2-488a-a605-7403aa7db21e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbca5a6c-d1c2-488a-a605-7403aa7db21e@gmail.com>

Hello,

On Mon, Sep 02, 2024 at 10:53:33AM +0900, Changwoo Min wrote:
..
> > IMHO we can simply drop them, introducing a separate struct makes the
> > API a bit inconsistent with scx_bpf_dispatch() (and I don't think we
> > want to change also scx_bpf_dispatch() for that).
> 
> Dropping @slice and @vtime would be cleaner in terms of the API
> interface. Some use cases simply move a task from one DSQ to
> another (e.g., from a shared DSQ to a per-domain DSQ).

Yeap, I sent an updated version where both parameters are dropped. There are
separate kfunc calls that can precede the dispatch call to override
slice/vtime if necessary.

Thanks.

-- 
tejun

