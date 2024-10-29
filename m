Return-Path: <linux-kernel+bounces-387171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA1D9B4D02
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CBA1F21B97
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A269192B83;
	Tue, 29 Oct 2024 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujTyeQCj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F51885BD;
	Tue, 29 Oct 2024 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214468; cv=none; b=tRRAUr88PdGOc7YQKps+jyyIATkr1xsuJPTlgh8PLYMzxbOSxYF6CCcjU+COLfpMedY0v0WlOO68Sb1gl7OUnk0t7AhOGObGYBrv9PVPejv9CCzkdyfvQC78+xJ5q6o0hnqh/QLlfxll8/J8EezQAK5AUcvIPLQCTXGIDF08kzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214468; c=relaxed/simple;
	bh=C1zVDiJmkhDNVoXEePt/1a59o14M0sAgd9XObfWJAIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/NWDtkG+gNTBysYwuKfOsktQWX3F7AbbdJuTr0S3zy6BmA7C9LoqyAycIdOcOi9EdZ4TdT72Caa71+TEiFtuYvFPd2QO1Z3Y0MAo+C+dRurOU9xB6tUOXVMe7JL5RzY0rqVnfYE++UbhNImpfN0v9fRR9qypMAni+u1tDtzs7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujTyeQCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124A0C4CECD;
	Tue, 29 Oct 2024 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730214468;
	bh=C1zVDiJmkhDNVoXEePt/1a59o14M0sAgd9XObfWJAIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujTyeQCj9Db1mEuV7MCKDkEVoRSwj2OAQqr9BrK6Cr9cpeOMwji0v+tPgc47wkBoQ
	 ls2BQ2Yd5CfnUue7EsqVgvxWOWdic/V9i4CXOd4j7y1+PLDQJGlcIaXpwef3rlufRL
	 HncXuI9XsBLJMmYy+2JbZ+EeLQo+olvAGFUiys3Hzc7aTh/P5k9ChFbnMD+ijX5HBU
	 MzH985WVzG6y3HExN+MuxIR4fJBIewhrOsbw1zyNS/LUbS8HTjrUIIjl4mKk0tVKpG
	 7sH2QSITsAmrfzOIUAx4Uu7P1mZsEPc8DWNmM9pdmMkRBZaQ/5T4DhvWTVw0FSO+h5
	 WHbszqKlRuWFQ==
Date: Tue, 29 Oct 2024 11:07:46 -0400
From: Sasha Levin <sashal@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZyD6QioGPyJUXI5r@sashalap>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZyAUO0b3z_f_kVnj@sashalap>
 <d75c9c2f-353f-464c-89d3-8c18dbfb4770@leemhuis.info>
 <ZyDHZHjxwmK1Ow9e@sashalap>
 <292de8f0-49e7-49c8-a327-b279924a5794@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <292de8f0-49e7-49c8-a327-b279924a5794@leemhuis.info>

On Tue, Oct 29, 2024 at 01:46:23PM +0100, Thorsten Leemhuis wrote:
>Hmmm. After all those mails in this thread improving (and maybe even
>separating & somewhat automating[1]) pending-fixes to me still sounds
>like time better spend, as then more things could tested before they
>even read a PR; but yes, I understand, the timing/order of merges can
>mess things up, so testing on PR time has benefits, too.

Automating how? Having it be generated more often?

>Maybe I'm just biased, as I could need a better working pending-fixes
>for regression tracking[2], as that allows me to ensure regression fixes
>are on the right track (which usually is the current merge window and
>not the next).

I'd love to throw the linus-next away once I find it useless :)

-- 
Thanks,
Sasha

