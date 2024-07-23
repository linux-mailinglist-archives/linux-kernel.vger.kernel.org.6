Return-Path: <linux-kernel+bounces-260337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C1A93A780
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A2F8B20F16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607C113D8A8;
	Tue, 23 Jul 2024 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW4TP8Z2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F713C3F5;
	Tue, 23 Jul 2024 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721761014; cv=none; b=DzXY5xQKP625kEtELQr23O+VP8pFvin2D2Y9arQI56eWdDThvyjPbQsCLw+3QLOy4p3WV+DPzyWlts5ysRqolUzKyq7JB5hz0S12niOKEbGW4yuyzNLLL1VZIsC2IE7VMphLe86i8rrpfMBtgOMuVg0+i4+EOwBec2VSVNVi3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721761014; c=relaxed/simple;
	bh=9xDIG+5djq1SZxXsgPZ7tEvUAZb128DiJUneX51wHQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXfunBe8JnxA7Jggcodi78WGCC3K4uh4mbefxaRjSIkMoAvwEEw8biGN8IU2q0ULEmgzwbhd8v0W0tQv5dMtYKdRh8O1s9rTZgP/QP0gv37UuO+L8WBf3ibCoeflZDxSc4XKd8RrB2a6s5TBdTpubmKI256od8GM+MI+ZPy4hpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW4TP8Z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1928DC4AF09;
	Tue, 23 Jul 2024 18:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721761014;
	bh=9xDIG+5djq1SZxXsgPZ7tEvUAZb128DiJUneX51wHQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SW4TP8Z2Oymu/eM3j+cijfcvWL4Cuo/SNCM1jWXdAIsUH+7m0anz2O/CWleNLZkk3
	 B4js9jfDnkt0VOhJmikfY9AivmEtZmPAqGJqxj5r4PYOW4fqGK49/ua7ayWWZ08uiX
	 lTo7ssnI9HeMXYoDhrwpOamuGmcq3nBJ9L6VPC/M/px+/vg8mXHV9vgvtYkJj7fFCD
	 p3S3RMvsDy75TgKyoqEtvofBbw0hiYv86yGrMRIi8IXICzFRS7BW6n8Go8NDNJnEbu
	 ZBs6wfp0Y48xtaIfccT9gqbKOxbugayw8ASIpkSzgh5Noq5q+bGiLk6FJtfPOlGXKi
	 +LpuR/AnGZ38Q==
Date: Tue, 23 Jul 2024 20:56:47 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
	hch@infradead.org, kees@kernel.org, ojeda@kernel.org,
	wedsonaf@gmail.com, mpe@ellerman.id.au, chandan.babu@oracle.com,
	christian.koenig@amd.com, maz@kernel.org, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Align kvrealloc() with krealloc()
Message-ID: <Zp_87x-PgtnZ3A-n@pollux>
References: <20240722163111.4766-1-dakr@kernel.org>
 <Zp_8XVdxHLtf203L@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp_8XVdxHLtf203L@tiehlicka>

On Tue, Jul 23, 2024 at 08:54:21PM +0200, Michal Hocko wrote:
> To both patches:
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Sorry, I was a bit dense today.

No worries, thanks for reviewing!

- Danilo

> 
> -- 
> Michal Hocko
> SUSE Labs
> 

