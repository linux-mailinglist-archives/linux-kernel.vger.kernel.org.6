Return-Path: <linux-kernel+bounces-310969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0E596836B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601661F22239
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B340E1D1F6B;
	Mon,  2 Sep 2024 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="es0FvngQ"
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A4318661C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269816; cv=none; b=QvtPJ0+yIbPJK0/wTIVH880u50J3mzWO1Jbw0MLhycbiate6lJBhOuKU1/3WtNcdS82Gm+AK1SuzXcBhit8m74GOH7+lTVqkVUvKNQSL+d4McGgAtXX41Oy18L5mM6Uq9ObzBMLOeuniJ6cjDKpilcQDY2g+Z1iDUGDGePIsXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269816; c=relaxed/simple;
	bh=rnuXzdgCGoImph8Ipq8xud3DbZM8UBv3EMrMcvHGWbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZfZS13hNONMvjRkhP3hcSMWh/MrYw6Sf6HyQ+tgA9XLIGxF7OVzDCDGG6fKHWP/gh/HXfAlQnXnz1FuKBvuDkPVrGN3xPK+uwA7aZoRizW/bUsm+K/s1SdPGnyMtRr+J2J7pfM9vjjp4y2E4fu1B3n3htMdwaiG2yOYHDqe09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=es0FvngQ; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 39EAE6983C;
	Mon,  2 Sep 2024 05:36:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725269813;
	h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=EqEGzAiSFpj6BRzXs2WVH89o1of8MQ5nzTl56kfrrR8=;
	b=es0FvngQszJgDVQeFkoupklBku32Kv6QHNpv43O/egwQufhYhjLnrkf/mvaS5Tjs9elqtT
	KNkU5j7JzQuUYxX934RDkWsiLG4fnq5MCXXpX5zDiSPojOzfHvXTLGRjkw3ALstI+eNVFd
	4orPj67gx0mgUl1HPMg8cbCkv1voNJqzZd4qThczllznSrmYc2lI+I7k1l6EFWp9binNd4
	rbZAj+HUSFR8ek06dIT29/T1mTgDCE4dhaZ/xRBwU5ua1DKAc8cw4oVv/gA+jvt0aySOdA
	5iLG4Y97OXMAz1AK8jc5LUWaHPVVa0K0ypK44ScCC8QEhW/IHauo5l1ElaBaNw==
Date: Mon, 2 Sep 2024 17:36:48 +0800
From: Yiyang Wu <toolmanp@tlmp.cc>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/2] erofs: refactor read_inode calling convention
Message-ID: <3qxpexpa6gd2yc2ez2miar2vhdswbj6juxc6zdawyktpjorwds@mljzzugbspxc>
Reply-To: ca8dea24-1ef2-46a8-bfca-72aeffa1f6e6@linux.alibaba.com
References: <20240902083147.450558-1-toolmanp@tlmp.cc>
 <20240902083147.450558-3-toolmanp@tlmp.cc>
 <ca8dea24-1ef2-46a8-bfca-72aeffa1f6e6@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca8dea24-1ef2-46a8-bfca-72aeffa1f6e6@linux.alibaba.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Sep 02, 2024 at 04:53:02PM GMT, Gao Xiang wrote:
> 
> I don't quite like this new line too, since
> it's already simple enough.
> 
> New line is used to seperate different logic,
> not just different block.  Yet that is my
> own perference though.
> 
I have refactored all of them and rebased the patch to dev-test branch.
Please check it out.
> Thanks,
> Gao Xiang
Best Regards,
Yiyang Wu

