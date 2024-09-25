Return-Path: <linux-kernel+bounces-337824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53478984F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4076F285004
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FEA749A;
	Wed, 25 Sep 2024 00:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ncoczn7Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E619F4C62
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727223727; cv=none; b=QFJVq2DIYBUF/b65f8FJ0iOVhQBjbdis+mL2reuBx+HFyv1PuJOFY5THXUH7JIK+f+ut046T3Ok7m7jCv+B3YTV3n6LRl0mkTl5psegGeItRVH4NLzrBYrYNo+NhcFEJQpv5WKpIMm7MnMDw736lSi1fbR5wQkCueg4vw3ct5hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727223727; c=relaxed/simple;
	bh=86N1BHrLc+oKQUnSbaTTDKMnP1B4/VW9d87f4a/noM8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T0OUVeIEGLipk4WsaHQVldKV+fvlfM02ZbSfXKSuQN7UY9LwyhaHPoigtTBHyfd8ar7tUh+Z7e7rZYExpnaRq/wKeR6hpwgFmNjyek4dHgy5fPbcC1/l0cNj6D1NpyE/amvc6x+G0MWMUwtmqxCE6rQP4O1Pc2PINPudh+x5CEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ncoczn7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66369C4CEC4;
	Wed, 25 Sep 2024 00:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727223726;
	bh=86N1BHrLc+oKQUnSbaTTDKMnP1B4/VW9d87f4a/noM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ncoczn7QiVu2Ohyg8gx2deBCr+8KX6tpun3s4tBCBlv+QOo3z69pM3q6DpYilGb21
	 qDscpMbsT6EHeIj7DIrSynCq0hRnG8VDQkI38Ipi6+vqYu6Pk7DnQceLLmcpaGrpjH
	 G4Cb8pvu9Zk9RAJv0QTNpRqtn/KKPlkFUtpTPU+I=
Date: Tue, 24 Sep 2024 17:22:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: liuye <liuye@kylinos.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: Fix hard LOCKUP in function
 isolate_lru_folios
Message-Id: <20240924172205.5068e86430873b09b75f8538@linux-foundation.org>
In-Reply-To: <20240814091825.27262-1-liuye@kylinos.cn>
References: <20240814091825.27262-1-liuye@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 17:18:25 +0800 liuye <liuye@kylinos.cn> wrote:

> @@ -1669,10 +1670,12 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>  		nr_pages = folio_nr_pages(folio);
>  		total_scan += nr_pages;
>  
> -		if (folio_zonenum(folio) > sc->reclaim_idx ||
> -				skip_cma(folio, sc)) {
> +		/* Using max_nr_skipped to prevent hard LOCKUP*/
> +		if ((max_nr_skipped < SWAP_CLUSTER_MAX_SKIPPED) &&
> +			(folio_zonenum(folio) > sc->reclaim_idx || skip_cma(folio, sc))) {
>  			nr_skipped[folio_zonenum(folio)] += nr_pages;
>  			move_to = &folios_skipped;
> +			max_nr_skipped++;
>  			goto move;

This hunk is not applicable to current mainline.

