Return-Path: <linux-kernel+bounces-170631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A0C8BD9EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3FD1F228C8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BFC42AAE;
	Tue,  7 May 2024 03:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b="gh5OC/nW"
Received: from smtp68.iad3b.emailsrvr.com (smtp68.iad3b.emailsrvr.com [146.20.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1914087F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 03:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715054223; cv=none; b=YV2/gRip1XKiK7cesCeswQrz4+Z93SBo5iJKMjjpqSgeBpnRxosHtPu+Ev7PTaxsCUi9ZCTC/tpSX0croyFBd6TTD9+wVJAMzrDE0wOYghWeguc1fng7Q9G4LxHWCx4T7GCRC0gGMJfk6QDSodUphZcD21lSc/sStN3y+qObOuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715054223; c=relaxed/simple;
	bh=cWMEq59X7zXzL3nJa3BLDmbI7tPBBw3giwZaDz3gBLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7XWxS6UABn5WOrb6393GxMxAhpBMHa05EFAHBpRTPM9ppfEjxXMpjZUuhrqEQWhXx3gmZkfk4WtwEG54fVMQHK1QIfmi48Tg5LM2MMEsFqeiJ7FqdFbjQWx2GZtkK77m1ORscuWNZ764rGcKiRbwMeg359Rf/faXQ7EIkNHf/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com; spf=pass smtp.mailfrom=oddbit.com; dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b=gh5OC/nW; arc=none smtp.client-ip=146.20.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oddbit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
	s=20180920-g2b7aziw; t=1715051887;
	bh=cWMEq59X7zXzL3nJa3BLDmbI7tPBBw3giwZaDz3gBLI=;
	h=Date:From:To:Subject:From;
	b=gh5OC/nWu2m+qCk6m0PPZVQuqzfvydgDIjESDhRMMppqckZ/n5+QjiJhRy4hCYjND
	 59EjcycsEBuXz4t8EnBMrx/7wNVNtkJSZcs+vaPEmElxiYNIXw8Slbu5ct7020lsLA
	 IchtCetQlquQGfB2uJiffbK2EpbEY9NblZGnzfX8=
X-Auth-ID: lars@oddbit.com
Received: by smtp17.relay.iad3b.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id B39DCA02AA;
	Mon,  6 May 2024 23:18:06 -0400 (EDT)
Date: Mon, 6 May 2024 23:18:06 -0400
From: Lars Kellogg-Stedman <lars@oddbit.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Duoming Zhou <duoming@zju.edu.cn>, linux-hams@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, 
	edumazet@google.com, davem@davemloft.net, jreuter@yaina.de
Subject: Re: [PATCH net] ax25: Fix refcount leak issues of ax25_dev
Message-ID: <eb5oil2exor2bq5n3pn62575phxjdex6wdjwwjxjd3pd4je55o@4k4iu2xobel5>
References: <20240501060218.32898-1-duoming@zju.edu.cn>
 <my4l7ljo35dnwxl33maqhyvw7666dmuwtduwtyhnzdlb6bbf5m@5sbp4tvg246f>
 <78ae8aa0-eac5-4ade-8e85-0479a22e98a3@moroto.mountain>
 <ekgwuycs3hioz6vve57e6z7igovpls6s644rvdxpxqqr7v7is6@u5lqegkuwcex>
 <1e14f4f1-29dd-4fe5-8010-de7df0866e93@moroto.mountain>
 <movur4qy7wwavdyw2ugwfsz6kvshrqlvx32ym3fyx5gg66llge@citxuw5ztgwc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <movur4qy7wwavdyw2ugwfsz6kvshrqlvx32ym3fyx5gg66llge@citxuw5ztgwc>
X-Classification-ID: 523c2de5-7003-4c0c-8800-1836014b2a10-1-1

On Sat, May 04, 2024 at 06:16:14PM GMT, Lars Kellogg-Stedman wrote:
> My original patch corrected this by adding the call to netdev_hold()
> right next to the ax25_cb_add() in ax25_rcv(), which solves this
> problem. If it seems weird to have this login in ax25_rcv, we could move
> it to ax25_accept, right around line 1430 [3]; that would look
> something like:

The same patch applies cleanly against the Raspberry Pi 6.6.30 kernel,
and clears up the frequeny crashes I was experiencing in that
environment as well.

-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS

