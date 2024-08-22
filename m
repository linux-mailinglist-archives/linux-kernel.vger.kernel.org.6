Return-Path: <linux-kernel+bounces-296679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A4C95AD9B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3525D28330A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD3913C3D3;
	Thu, 22 Aug 2024 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y2mRCS1l"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B503249F9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308566; cv=none; b=ocYf1ECWuhqK5gsU+i+rMeuxET5CCzLjlltGvmYzNXYLPiSZTECJEy+4+/hJDiiPOeIK2X939KQhuAiJYqpycD/TolAfU9Rm3ax4cPONHXSiNr4Ost74ADF80TqYmXiuYSUFzS7SnP/ZQHvpiny6BzSR9M7sTyWktolGv+0ZgE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308566; c=relaxed/simple;
	bh=YYRZKY83NhTEEWCRstoorUA3tZ1kfLMmksgfFQQZPJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHRc+tJRtULD0Ws3P+/2nM+Vg9MPPcsk7lT+GPsxc6ZBP3gwp8ZrWtUnA+BxnuVhhXVwolmvynunFMiFs2Qy9udVo/7Lj1j+NgQxG2Jaur/QOK50bCicPUWJTM3mjdg56ZkYMk3ky1p+UNTmepEKERdXggOPIo9qtuFibY6sW04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y2mRCS1l; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Aug 2024 02:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724308561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4hldB3EXQE5gPgGKgidKLfdyEId7PDYm7eacMW8ZxeE=;
	b=Y2mRCS1lknsIIJ5HMC7e8A5EuaGv0ayuMhRnLeuwr2PWVxgJRAPKycKHltqRehETaY5aCm
	0ADKXDpCiX/+7xTyt+xVj41iD/ioPQzjrnj6XfMMY065u36DbTGThsNt0PINhnTyBn9GXH
	lYNvMfalrffOQkEY1ZPPuPHqZU9to24=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Yuesong Li <liyuesong@vivo.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] fs:bcachefs:fsck:Fix double assignment in
 check_dirent_to_subvol()
Message-ID: <tge2dhrjuurcwahfzto7tk7tuxjcsbhhc4bl7ipw7w6xidyq7q@24fvb6vbkez2>
References: <20240822062158.1314554-1-liyuesong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822062158.1314554-1-liyuesong@vivo.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 22, 2024 at 02:21:58PM GMT, Yuesong Li wrote:
> ret was assigned twice in check_dirent_to_subvol(). Reported by cocci.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>

Thanks, applied

