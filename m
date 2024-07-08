Return-Path: <linux-kernel+bounces-244372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE2392A360
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C5E1C20F09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8711881754;
	Mon,  8 Jul 2024 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUIgGPvl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649DA1E487
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443627; cv=none; b=XwIszzKI08TEkaPuBzFuxYjzw6O/nyqee07c634HiedLMYcLHl/1Fmq6HltfnyQ6SeSvTMhLaRolfdCmQt9R5iOasvWr9bxxdoAIR9VSEyzeFwdeAKrBG69Glj4CmHdeP5vOdfwSH6+X43QcT+9E5un6OjaFV+AXFwkmJOmQpXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443627; c=relaxed/simple;
	bh=ytsuwiTcNZSiT+T+qsX4ne4IrcHVH4+2JpYK6ZEYM8o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T1zqxRJbPsqqu13T50WVZp+BGWHxiMC3+pxKB4c9GcYLNpFaK2E8Kf7W+MMiVSEaH3V/bl5ZETdHo3UOb/gdkYb9jn0zeBXtLpg/Bdz++T1R1Cof1tp10HlqqGrmh7XlR2LEpjkHU/xvaksSkjiwEHelE5WMrI+EGdGpzCfFTLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUIgGPvl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720443625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CD8myRrs4RTlNxSULWgCahpXgFY86Y6s4yMzzgxCsRM=;
	b=XUIgGPvlGnFhmDz9u/hflkAcUUt0E7lvlL41mY04q6O0Ew0TjNPMedanTWj80q7OEDD0Wf
	Jknz04aWGavH+xnYtp+EMjdlrYT5hiLn+Mt01D/yVPcv4hNCjQj5ct/mcZHTVx0Tob8OnJ
	mTxbNbY4D0QsYdqOTAkoP4xchMukcoU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-u4dzoU3oPeigfFwEUTLIKw-1; Mon,
 08 Jul 2024 09:00:21 -0400
X-MC-Unique: u4dzoU3oPeigfFwEUTLIKw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F4B31958B0E;
	Mon,  8 Jul 2024 13:00:20 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F062519560AA;
	Mon,  8 Jul 2024 13:00:19 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 5FF9030C1C1C; Mon,  8 Jul 2024 13:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 5E60D3FB5F;
	Mon,  8 Jul 2024 15:00:18 +0200 (CEST)
Date: Mon, 8 Jul 2024 15:00:18 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the device-mapper
 tree
In-Reply-To: <20240708182025.5f2e36cf@canb.auug.org.au>
Message-ID: <1c807c9-910-7eda-59ed-61f144af7894@redhat.com>
References: <20240708182025.5f2e36cf@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40



On Mon, 8 Jul 2024, Stephen Rothwell wrote:

> Hi all,
> 
> Commits
> 
>   eb5f088474c7 ("dm vdo indexer: use swap() instead of open coding it")
>   feb0cdc1d47d ("dm vdo: remove unused struct 'uds_attribute'")
> 
> are missing a Signed-off-by from their committer.
> 
> -- 
> Cheers,
> Stephen Rothwell

Hi

I fixed it.

Mikulas


