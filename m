Return-Path: <linux-kernel+bounces-435341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DB39E764E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D1616AEA0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2FB206299;
	Fri,  6 Dec 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwO/jMC8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA55A20628D;
	Fri,  6 Dec 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503319; cv=none; b=M9CIi/WyoIwZICqj7rnYG1g+Kn4lgdJ7o6xHQGspxYNpH/DzE3zDs9DPfrm7C3HFnuZ7cnWpJGR09JJj0O7UNboeTg+PtNLBgYcVvo3zyurA3dWyfhn06dZp9yLq52u2GpTV9PS8QmkkNmkGpcPjgF3OIDonDKPdmef+gd6Z8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503319; c=relaxed/simple;
	bh=GVom6tby0lr+M+AdlKnmYonY5gX0lhsKBw9N6+oS/bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKsuAeEOwiABZyr6rFp0uYx6WqzE0yoMNxst/vA7mfANBfudTN3bP4mOQ3Xp+9HmKK2dn7TG5fZ9VI0Q3ihv2E2qNaqrXJPi5uDVwviPsTHcwMbObgGyQcVrqL9dWuUWxXVGmZrptaCAS9xaTb9liTHWLFc5wBb9wAkJUwj/ctk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwO/jMC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC75FC4CED1;
	Fri,  6 Dec 2024 16:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733503319;
	bh=GVom6tby0lr+M+AdlKnmYonY5gX0lhsKBw9N6+oS/bw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XwO/jMC8QaCOnt3zj3h6VCYp6SCCGwoyMOAhzWRUqNn64xF6MojGsx9sWOlOeFqV3
	 wsBwLjUHlIVI/+hUMM4RTLNsJ+6rlAcREgSPMQVUFNcaiBMg6NjrrCiN1QmcLD8oNi
	 UGwDS9hCAh9FIqZqJ9MFtmi3vAwRlTHXMqSc0M7F6zYbhE6z8Tzd6yAwIVqZUHST2N
	 5HziS4EYJby5A0U92JqecswBFhYO39xEQhHDpbSSAMMnyGXNf+QiGymwL/C/ghqhz8
	 9JmxpYf1gNYRPsTs+DtBAM+GLxMIil/7cnNdRygVRCVkdxAjNj9KFOsbNVVhTebRtM
	 JTv6LGo6YOj3Q==
Date: Fri, 6 Dec 2024 08:41:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Justin Lai <justinlai0215@realtek.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, horms@kernel.org,
 michal.kubiak@intel.com, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next] rtase: Refine the if statement
Message-ID: <20241206084158.172dd06d@kernel.org>
In-Reply-To: <Z1LVqssDBEZ7nsWQ@mev-dev.igk.intel.com>
References: <20241206084851.760475-1-justinlai0215@realtek.com>
	<Z1LVqssDBEZ7nsWQ@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 11:44:58 +0100 Michal Swiatkowski wrote:
> I am not sure if it is worth to change.

True, tho, FWIW, if it's the maintainer of the codebase sending the
change it's generally fine. Our "no pointless churn" rule is primarily
for randoes.

