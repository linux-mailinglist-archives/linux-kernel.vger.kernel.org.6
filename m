Return-Path: <linux-kernel+bounces-549638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52137A554CE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529B31622AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949E225D541;
	Thu,  6 Mar 2025 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLuDa/Z1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1AC25A2B5;
	Thu,  6 Mar 2025 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285309; cv=none; b=Co7ydYKIdIhSdotx7T5NEbXwvxTY/o09HjLSKgO0qr1Pcj2TU1L2svf3EfjXFjOdXP4YWgr10fRXimqevTVAtj/5GrHFL0IQwX92qdzmigejFElKTT3CCAakIa3oPmSAqL0RBTcvXtdFHSM/ygIaoSWHjJxGlMbXwR8YR3ho8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285309; c=relaxed/simple;
	bh=qXRgkDyjGR8YLzfH/EKdzyabtiSvlRyjtiG3fHLKk7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CygX+g/C5TYOBTyIjMO9oqtxrIdtCk9vVwGmYcm5CqbDU70nFrmuf1UTaa3MfppVd3+ohrot9DdTCmKm9hbCsmpc8hNKfRhLcRr9xPL4o40JgYmQJ2Jvo2MdCtSjgjkKgUwbwqHLozrvq41UHt8zdKYU3boXyMJy4sIMw0fxCRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLuDa/Z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F60C4CEE0;
	Thu,  6 Mar 2025 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741285308;
	bh=qXRgkDyjGR8YLzfH/EKdzyabtiSvlRyjtiG3fHLKk7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DLuDa/Z13r8gWyfbZW9sHlgJAvyq/tN6kRHxVtD9dr/VItOtk6fnEfLRISWEESOzo
	 Y1se2INMUgyehchnK68nRHYfDRbG5/r6HA8JlhbFiNQ8ynwjCu3BzOzAotkKy+5LKE
	 bx4luz3TGG47gfz6WNDA9zaWJFTuzALSotQnh848EeITSMvYX8tLerwhK34ylSxchF
	 yLCIQ99RvHHThYOwTm9HkNxSqnmBbMwgRwW/yuVbgiWt8sI4ySz9lq2VVC/FH3pThX
	 ag6wxPZQFlIdZKHoZVTrNH85OpSIjumUc/Wudw/vvl7o8eJ2vQxGAX8FfaDXIsMjtk
	 qswTG7ztiDLYA==
Date: Thu, 6 Mar 2025 10:21:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
 gerhard@engleder-embedded.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, mst@redhat.com, leiyang@redhat.com, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "open
 list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <20250306102146.70803a61@kernel.org>
In-Reply-To: <Z8nUksjJyKEbP68-@LQ3V64L9R2>
References: <20250227185017.206785-1-jdamato@fastly.com>
	<20250227185017.206785-4-jdamato@fastly.com>
	<20250228182759.74de5bec@kernel.org>
	<Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
	<Z8XgGrToAD7Bak-I@LQ3V64L9R2>
	<Z8X15hxz8t-vXpPU@LQ3V64L9R2>
	<20250303160355.5f8d82d8@kernel.org>
	<Z8j9i-bW3P-GOpbw@LQ3V64L9R2>
	<20250305182118.3d885f0d@kernel.org>
	<Z8nUksjJyKEbP68-@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 09:00:02 -0800 Joe Damato wrote:
> +                *   - wrap all of the work in a lock (perhaps vi->refill_lock?)
> +                *   - check netif_running() and return early to avoid a race
> +                */

probably netdev instance lock is better here, as it will also
protect the return value of netif_running(). IOW we need to
base the "is the device up" test on some state that's protected
by the lock we take.

