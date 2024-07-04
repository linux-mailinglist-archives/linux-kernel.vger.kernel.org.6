Return-Path: <linux-kernel+bounces-240400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D41926D3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7737C1C21A2D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BE9DDC3;
	Thu,  4 Jul 2024 01:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FS1laYF4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F52581
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720057972; cv=none; b=NqfDipl3QRUAkO+cwV9+N0AGJQq9TvRxGfzHDW206wYOIyjwwi0u06xBo1VD2y0YZBJ4zZFFtATB00hcLXX+mvNThAeZKtjrfdr/w4LM+l1Jw0euDeIZ26RmzZ+9T98IrE0sJXMQ0uwQVbnWXQYD7CHYyXL8IByyn8ym4gnCRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720057972; c=relaxed/simple;
	bh=F2j2b220f0kH6ASBWQuxfwQDqDRaPBMclWh3MbAtpkY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cTUCu0dqGWoA9Ho+BQIrCwvlAWXgZi3Km9VSuu//9UMS+TeS7CT85Wg6w3UGH+ytN/lOEv5oZqu9dDIJbp40nCeCa8+Weug5dQwSFsX67tkvgdv8eEkypOPrFTbI+Pgnhdzi7EJyWcaxwQy1NwMMJ5imNiqro3X7JV30XJPidFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FS1laYF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F552C2BD10;
	Thu,  4 Jul 2024 01:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720057971;
	bh=F2j2b220f0kH6ASBWQuxfwQDqDRaPBMclWh3MbAtpkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FS1laYF4xPIP8MvziXSKpZ0B6nzToMKWGFhFUaAO0dDn+b2e83ijM0JDu4s7sn6WF
	 Keh0h+ZN1nDmqnMrTmuAGIZEVpZ44oI6zMUFWRI5UFfFxoGdMxpR2l1wWLKGHeLA2z
	 A/vtA0K97oQ3w7cLqXCiNT0JuLC5BSk1wuNlcP70=
Date: Wed, 3 Jul 2024 18:52:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal
 Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH] mm: memcg: move cgroup v1 oom handling code into
 memcontrol-v1.c: fixup
Message-Id: <20240703185250.ab96286a5e4747665520ddb0@linux-foundation.org>
In-Reply-To: <20240704002712.2077812-1-roman.gushchin@linux.dev>
References: <20240704002712.2077812-1-roman.gushchin@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jul 2024 00:27:12 +0000 Roman Gushchin <roman.gushchin@linux.dev> wrote:

> This is a small fixup for the commit
> "mm: memcg: move cgroup v1 oom handling code into memcontrol-v1.c".
> 
> I forgot to actually move two functions mem_cgroup_node_nr_lru_pages()
> and mem_cgroup_nr_lru_pages() into mm/memcontrol-v1.c, so that they remain
> in mm/memcontrol.c and their commented out duplicated versions in
> mm/memcontrol-v1.c.
> 
> Andrew, can you, please, squash it into the original commit?
> 

Seems this wants to live behind "mm: memcg: move cgroup v1 interface
files to memcontrol-v1.c" so that's where I placed it.


