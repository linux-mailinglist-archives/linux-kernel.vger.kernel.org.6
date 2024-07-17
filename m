Return-Path: <linux-kernel+bounces-255609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 152219342DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E131F2183A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EAD1822D7;
	Wed, 17 Jul 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N+sHKc17"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1220B208BA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246433; cv=none; b=Z99OVmttRdY3qY51mR8onUuNy8h7vGpqNq59Rz8dTCARhXPnxC5gexiTrE/8+Tr+CgWUjUTkme2U7knGJFdSnehjtgW/cL81+rFjTszAb40I3LJSOXmEyVfuWjM2HJy9DwaAxEvoUeozjMhnkFe02p43PMmB8FJy2jmZQix3UCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246433; c=relaxed/simple;
	bh=snv3uo7dlSvsI4pryvUtANpWj1I2FdlRdC9lDbRx5C4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ExZEKK4xn2PTymt0nR6JVKGSz6dnzmnlQ9VYh4sDvnYKf6qGEmSP8NzFQw1ZFX7LOxbA/0TDx3YWT8WrlhCycIP73DXrIQoWJZ/27Q+2hFPEPAZec3nzGiykc9YcF2uscij/Vl3qqLeZjo1u+NC5QcE5BjBZhmWszGZxq9L5a5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N+sHKc17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FFCC32782;
	Wed, 17 Jul 2024 20:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721246431;
	bh=snv3uo7dlSvsI4pryvUtANpWj1I2FdlRdC9lDbRx5C4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N+sHKc17jImNta8f+Ksh4IWFx+c/9l6FIsv/oiWeoMHKb60W31gwWOxzTNHXCI3DY
	 w84G83wKMGrP3KYgGlOcYs8tLxwZ/2lLry70osEhcxJ2yxzJERxKhizb9EIxn/R/jN
	 sfujIpJztDTx/kyEtXquPtpl2OxYgEjBmAfm3OZs=
Date: Wed, 17 Jul 2024 13:00:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 "peili.dev@gmail.com" <peili.dev@gmail.com>, "Nikula, Jani"
 <jani.nikula@intel.com>, "Saarinen, Jani" <jani.saarinen@intel.com>,
 "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: Regression on linux-next (next-20240712)
Message-Id: <20240717130030.09a778a38aae6a23a193b357@linux-foundation.org>
In-Reply-To: <e3c17dad-a93f-4885-8f14-69874be76482@redhat.com>
References: <SJ1PR11MB6129A77D51B206E29E242B95B9A22@SJ1PR11MB6129.namprd11.prod.outlook.com>
	<e3c17dad-a93f-4885-8f14-69874be76482@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 13:00:58 +0200 David Hildenbrand <david@redhat.com> wrote:

> > Could you please check why the patch causes this regression and provide a fix if necessary?
> 
> This is know.
> 
> There is a discussion along the original patch [1] on how to do it 
> differently. But likely we'll tackle it differently [2]. So this patch 
> should be dropped for -- which I think already happened because I cannot 
> spot that patch in mm-unstable anymore.

Yes, I dropped it on July 15.

