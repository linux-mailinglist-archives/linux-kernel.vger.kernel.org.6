Return-Path: <linux-kernel+bounces-312014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8487F9690E9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4185F28403F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20701CCED4;
	Tue,  3 Sep 2024 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukfW9kKi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0A19E989;
	Tue,  3 Sep 2024 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725326930; cv=none; b=A4Iq6JAuyLarVDaCvL5uobN3JyNzaKbxlTQPJl/1TmXQA/G3kS/5oMt+yyBPTxfAg1e6EL/hej7V5f+mT3rCKHAFTiiXw9DO713dAVdVTW290nxkFzYr3VyWHLbINGOjdtlv/XIaFOq8H3oZ1Uw6ql9gvcL8JKCzb9e85bHsVvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725326930; c=relaxed/simple;
	bh=B89yEqw5haecuJM/TsGjQ/Q5j0AmnwbH4PTo9ttXBG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8G+R0phyo4Pu3b4ZZdMI4mZzraXFM7CHRQTg/VakJHFCi560F2vMosJV4Dor0JTpM7hP3iLHTfI3qxLw7wRr0MrYw9j08eRhDcNFrdS0CebYThy38w474PuHZj40BBvoBs/X0yDqMK4jzd/YKdQwsBc1UAMoe5zu+nbNStdblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukfW9kKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225A5C4CEC4;
	Tue,  3 Sep 2024 01:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725326929;
	bh=B89yEqw5haecuJM/TsGjQ/Q5j0AmnwbH4PTo9ttXBG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ukfW9kKiZ+y4GoLXqKIz04O0UZEtRRwhaRLU5U6QpAXz9SxsGR+nZPs4U34MF+Kt8
	 GnjLU4FRU0k7OYLdA8OFF/Kji5Gga/B9wyRDdvWn6nFdmTYSyIPqk67MlCH3pDFDPJ
	 L435HjSi+7vA3U8xYi4zvY0WZnZVP0k/gMXpJOUkVnrJsYBWhFnLwiAUYEpM2MimKW
	 Q+Oc6nA91cBu9qrTzq9P1Ci4kXCs/4W1+nc7ta8zesOvzFEErx72By8lz5nWKxgAZH
	 R1bC1RKpRESYxUJy3uFHtQ7Wjf3Ji1ipU0qbRSbK9QuP67kCCq8TxQYayvW/mDYOE3
	 xirJC34/ym1Pw==
Date: Mon, 2 Sep 2024 18:28:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, Amritha Nambiar
 <amritha.nambiar@intel.com>, stable@kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Daniel Jurgens <danielj@nvidia.com>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] netdev-genl: Set extack and fix error on napi-get
Message-ID: <20240902182848.4e1ea70f@kernel.org>
In-Reply-To: <ZtYJX2HTeiglkxUU@LQ3V64L9R2.station>
References: <20240831121707.17562-1-jdamato@fastly.com>
	<ZtYJX2HTeiglkxUU@LQ3V64L9R2.station>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 20:52:15 +0200 Joe Damato wrote:
> Based on Eric's comment regarding my other patch [1], I should
> probably re-submit this against net-next instead of net.
> 
> It's been over 48 hours, but I'll wait a bit longer before
> resubmitting.

Change is simple enough, I'll strip the tags and apply to net-next.
Thanks!

