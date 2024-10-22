Return-Path: <linux-kernel+bounces-376490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FC09AB251
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E392839A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E311A08A6;
	Tue, 22 Oct 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bysqj90g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9BF2E406
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611749; cv=none; b=qDscHx/Qsvl9642tzpsaH/MOvv9doh+zh58EJFuqXcue7PsRwQD/EfphF/7z1npRJVQJ7T4vX/uvvJ8nFC7iTRkJYiQHE/lL2eKR8UgqVfV0e4vq/pT4O3nQLLUNu+yHG8YsGKrtiYZwq7MnIysphODFoiTF0ccgFESRhfrRb/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611749; c=relaxed/simple;
	bh=SJnHqgpVAzDwIQ94l1Q6tRFmiyLTKWSefNLCjU7aPDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKW9+Hftyits/570o7T+cZ3oC/VVvFpVKdsdBekozoNOxDkrbNg7TyDInPWbl4GYXLWYW677yPjZx3Q98GtGRjROtTGn4pORaSt/C8CpOKfxk9gh47LdRDz/+Nv3+dxICRbkcbwOArtCQCC5yQWqVcKY5PP+vKg19G4ZjFYr0WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bysqj90g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A984C4CEC3;
	Tue, 22 Oct 2024 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729611748;
	bh=SJnHqgpVAzDwIQ94l1Q6tRFmiyLTKWSefNLCjU7aPDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bysqj90gHSGKOPNMMiTravysWl2nx9CdL81PX03cbNdaT7kNvkvcrmfmbfM6FaWDp
	 F41QyJnKj2PmzTY+usfAjmE3L+MhtE7ramHjOrQwoDfPsBavfam10XQPLBRTm2Vx3d
	 N8BehsDzfFNrRlTFOkA0Wu0uoySlAO4x7p8Z8ecx5RTL6HQ9UJYtt/k78F4GJp+boT
	 R1zzNHbiXWOBc9IZyHVGmU+MjWGVd5r1jTcEdQpr48nlzkOz3879yQtfKJ+iAAIpp8
	 bbsyjCl6U4OFsRYALWoyws1HwaYxw+xXf59uKh6gQgmkT7uuB1o8G6MEgxAXT6aryH
	 1PRD9Tqhxyfew==
Date: Tue, 22 Oct 2024 05:42:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: David Vernet <void@manifault.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-6.12-fixes] sched_ext: fix fmt__str variables in
 kfuncs
Message-ID: <ZxfH42ObDMu7agSN@slm.duckdns.org>
References: <20241022074035.139897-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022074035.139897-1-andrea.righi@linux.dev>

On Tue, Oct 22, 2024 at 09:40:35AM +0200, Andrea Righi wrote:
> Commit 3e99aee7ce48 ("sched-ext: Use correct annotation for strings in
> kfuncs") renamed some parameters without updating the body of the
> functions, triggering build errors like this:
> 
> kernel/sched/ext.c:6881:45: error: ‘fmt’ undeclared (first use in this function)
> 6881 |       if (bstr_format(&scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
>      |                                             ^~~
> 
> Fix by renaming also the varibles in the affected kfuncs.
> 
> Fixes: 3e99aee7ce48 ("sched-ext: Use correct annotation for strings in kfuncs")
> Signed-off-by: Andrea Righi <andrea.righi@linux.dev>

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

