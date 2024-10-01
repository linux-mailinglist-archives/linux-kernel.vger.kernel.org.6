Return-Path: <linux-kernel+bounces-346710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0A498C7BC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38C7CB23C16
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FD01CEAA0;
	Tue,  1 Oct 2024 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HWuT9H20"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E71CB32B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727819076; cv=none; b=H0RxgC8ZraNJZdETOT6Wkw5ueVF7Q8wiG9gpeL7tADgaEfM4DRDvViVulpIJanmpjDY9LwPhdynsTiWSDj96AmTAh4QPTgbtqaqCYquOtoyTEtPxHQl61oqgKfR5ltYgQnvfY1PU3s2ZQRD5g7szi1czK0U0i6R1DboiNxd04VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727819076; c=relaxed/simple;
	bh=co7WDqrPrmFe5ct3i2oYfBwmIhNQlWyLwVeRToZuOOA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hsu5bhIZjgUZ29IQjijIruFa1wLJNKIlpnU2dceG8qeFb0+8SMVCM8FtCFaTfsUWwQ2w8QO3QS2F8DZZAGvt1OB/+HMhiHhwn4/nLHvIEe1/NP09/nr4tJqpgONB0hWDhM90fv+8dNSEMrVo2lIAFAj/5bsg2VP3vBPuyt7opl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HWuT9H20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E33C4CEC6;
	Tue,  1 Oct 2024 21:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727819074;
	bh=co7WDqrPrmFe5ct3i2oYfBwmIhNQlWyLwVeRToZuOOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HWuT9H20i0iMCVtvc50YEyPlFcDu3hRGAsCgUP5YI+frwvRnjdUITFhUIeX5AOLNw
	 N+VFyjmhvLWZtDZGMYio/hZruM+KnBnCZPhZEwhulnjlpQG4bYYR+zp8oj8TNbqSZK
	 9RFLIZuFAWksJJ2H3uIkHADOUsDLJCFHZhQPADP4=
Date: Tue, 1 Oct 2024 14:44:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Bert Karwatzki <spasswolf@web.de>, Vegard
 Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH hotfix 6.12] mm/mmap: correct error handling in
 mmap_region()
Message-Id: <20241001144433.ce56e7afddabc40febe94bee@linux-foundation.org>
In-Reply-To: <bae80e71-a139-4209-a2f8-3dd08d1b2c5b@lucifer.local>
References: <20241001133726.160275-1-lorenzo.stoakes@oracle.com>
	<84837835-b483-4d15-9e0f-1719c350423e@suse.cz>
	<bae80e71-a139-4209-a2f8-3dd08d1b2c5b@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 17:51:07 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> > I'd be surprised if that fixed the reported issue, but yeah this is a bug to
> > fix anyway.
> 
> Yeah it seems that you brought about a tear in the space-time continuum and
> the very moment you said that Bert reported that yes sadly this doesn't fix
> it :>)

Please resend with a new changelog?

