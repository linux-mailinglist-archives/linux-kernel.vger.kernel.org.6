Return-Path: <linux-kernel+bounces-323896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E44F89744CC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A888C287B52
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9911A1AB510;
	Tue, 10 Sep 2024 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ev1clNQT"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65B61AB50F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726003742; cv=none; b=UafEJk0QlUoq/0llpg8/mlUQNC6jpnRgTAKluKzAqcnigI2jhkIwy0HEDlT3RHiR3WFocG9xB5V4t6tNqrf3WGEALplQCqz9AQET0/V4YelDyGv0Bb/nBxEpv2snnQTFTzZs3PDIL4SYtrDGycfhJYMR9SGRJYvCnHpY+3jDCTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726003742; c=relaxed/simple;
	bh=JB8QPYV6wZvd+8554qqYMyfYwk/jZ3Z7SuNwc5aQ1ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xjn1zWeo7uUOg6+wxFSewVO/PBr98RujR/EyMy44HwJVNUWL21cHs6wYDrXiIeVaK8oqFXaPmHpp28GJsOPaPO2s/Y/g4irQ1yZ5ef5AEA/b+JiUPjZvrmBbzw3wMdc63cw8NBM/bSkRNyw+CVh0QVHg8yhGpu5/tgadslnczEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ev1clNQT; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Sep 2024 17:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726003738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQdZ/Xk3IZq0P/QkpkVbrTV28jX3yXisSZN66Q35tXE=;
	b=ev1clNQTafKiThScdYgVP+exBlsxPUvoo+prJZsHvrEkVD6+JVBTM+EeH5gHJcByAN88X4
	gmCvaTzjJ4C4WtWZJCHWAa/FlS67eOuFORW0XZ5wfZ4fUh2hqmxPUbnz8qP9JoTK6gIfbW
	o2FDmCJ+yyV2LLyEuL2ryzE1QETJX/M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: syzbot+1cecc37d87c4286e5543@syzkaller.appspotmail.com, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: return err ptr instead of null in read sb clean
Message-ID: <hz3mj5qtutvjddnfhhbeu74hoxu67qzzgwmpxzcldbslsj7fed@53sfkbbxpriq>
References: <20240910211912.96356-1-djahchankoike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910211912.96356-1-djahchankoike@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 10, 2024 at 06:18:34PM GMT, Diogo Jahchan Koike wrote:
> syzbot reported a null-ptr-deref in bch2_fs_start. [0]
> 
> When a sb is marked clear but doesn't have a clean section
> bch2_read_superblock_clean returns NULL which PTR_ERR_OR_ZERO
> lets through, eventually leading to a null ptr dereference down
> the line. Adjust read sb clean to return an ERR_PTR indicating the
> invalid clean section.
> 
> [0] https://syzkaller.appspot.com/bug?extid=1cecc37d87c4286e5543
> 
> Reported-by: syzbot+1cecc37d87c4286e5543@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1cecc37d87c4286e5543
> Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>

Thanks, applied

