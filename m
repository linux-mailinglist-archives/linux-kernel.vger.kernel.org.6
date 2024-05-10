Return-Path: <linux-kernel+bounces-175680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C18C2395
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575FE1F25BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A05F17088E;
	Fri, 10 May 2024 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/1+Jppm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B90A170842;
	Fri, 10 May 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340584; cv=none; b=qFpDCPfuW9cy0vf5+zPqyc+mRWwMj7dCIJY1jsArxPq8TC7UzUBmki3Z8urvEgfbF+cWca82KjUgh19SoNeQnMn3Kusa5Vfu0+PS83NTsFSq/hCplURb2UwalrS5JoNPFBDVAtiJ/0bvLkde0Sa4NUqDo7lSUnjElndd5vP1/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340584; c=relaxed/simple;
	bh=XeYyFg5DbRBtBzVjd4SGMBwBKZZTfyPUcbB0DY6M97g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdIJa8RA0O84qGCWw0gi8ZKEIAxTPm4+ajxmR7w3af+Nh9imFoognTGqyeARfIZiXHXQBUqvtlfIImEX75CUfTk11HS69WhL34mkzjfNxetjMuerFtMd39Zp6xPcgJRU2bPUVh3eocrJxkmN11Qj9oFWDuw6VJueUEVeFdniTIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/1+Jppm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F691C113CC;
	Fri, 10 May 2024 11:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340583;
	bh=XeYyFg5DbRBtBzVjd4SGMBwBKZZTfyPUcbB0DY6M97g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/1+Jppm92vi00CKxkcoyBzEx13G6iXDrVj2V2xhv5XV/Zf1cM+xeCg7nZ8lbOa/i
	 z4mK0e+9PU6pdgdKbcAtBdIOhZIuSu9/LRPRpZAVw1ohii16UnootG8iTljwgmjdZo
	 iodYKs6rU04VOtm3puOT3aEkmVtd3PHUw3p2avsMfVFOgvCE0/0suKjxDkftXehDDE
	 p7IxSElGD13S766ZI+9QMs+3F5RSNttbYEq0uAyrWmgejYJ2UjkHCU5+gwiggQvQoX
	 qoTsGDBPV7j+XP8GbDWjVfP6oWHWgwjw4z5kYES0GVM9w14eKm4Q4BdFkMpf7XS/b8
	 0M9mQq3XwH2Fg==
Date: Fri, 10 May 2024 12:29:38 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 10/14] net: qede: add extack in
 qede_add_tc_flower_fltr()
Message-ID: <20240510112938.GM2347895@kernel.org>
References: <20240508143404.95901-1-ast@fiberby.net>
 <20240508143404.95901-11-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508143404.95901-11-ast@fiberby.net>

On Wed, May 08, 2024 at 02:33:58PM +0000, Asbjørn Sloth Tønnesen wrote:
> Define extack locally, to reduce line lengths and aid future users.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


