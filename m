Return-Path: <linux-kernel+bounces-187997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2A18CDBA9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255D51F23E48
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A05D126F32;
	Thu, 23 May 2024 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="E2t9x9mp"
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E06D86ADB
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716497869; cv=none; b=tV4INker7kZCW7yTxPa2eknCx/3QdN/WCExFteGLlKncLGIzVF4EYOVx14mYybzxu9lAJg86JiH48LjKCaYdO4JZQMSQnQ0d6S3J8aLC5vqBVHSHPrhQL9QCU2bDtq8Edj/evucuWfNmDGbkOiQiZFxNSSj453ka7d1TT3r0djA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716497869; c=relaxed/simple;
	bh=B2vume0Zk1YqRsDnDJ6VeYzJZ6A+QH9zV+wpmsJkPJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0ZHcmVZt0CRs6mDbYDXaYgj6Mf13gVU2aM4lJthsSnfp63zv07VfcZxGUEWRabwtCb88mIUNAWgOYCdb+DkA56nGEP04vZ/Bm3JMzypdt9wXT0ALhpzTQp1uBk4rcCrg66t7ytnq+11jSFPkpA4qE9Mg+kJ1tPkpI3EokQx7oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=E2t9x9mp; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6562214C2DB;
	Thu, 23 May 2024 22:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1716497859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26v69cdZHR88qOWgnjCjlho7Xx+de5LKxz/UUm1HIkQ=;
	b=E2t9x9mppdKpE83YU3N6wGC75alQXfX+tRC9PcnCgyuOe3/jT5DoaVuR9652HNNbVR3I4i
	FdqimkYT3PxAJqbF0IMGbkk26UGsRdBsxAgJd74OyyLPuTcbiUzeBQtVcE37ByNSkw75zI
	9kDzx7kWfp1ib1hg8sOpPm3miALhIDw3yGPUVizJQhI3fFq1EFDWCeYrcbJ8clnE+HKmUR
	UhV7rLaIoGlWL35+2wtVnHjO+fJEX2rQWncf/9c3zXlIRNNpNiFH3McF5wLwscfI5V4rjj
	9D75AUWAlut3n/3cXDeGsEDzM2n8U1ffGSFI86rtweLj1UKPBf10q5jCp3Bxjg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 87e35d6a;
	Thu, 23 May 2024 20:57:32 +0000 (UTC)
Date: Fri, 24 May 2024 05:57:17 +0900
From: asmadeus@codewreck.org
To: David Howells <dhowells@redhat.com>
Cc: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>,
	brauner@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in
 p9_fid_destroy
Message-ID: <Zk-trSrUlNmodxLx@codewreck.org>
References: <Zk9y21FktxyLGqDJ@codewreck.org>
 <00000000000092914806191382ac@google.com>
 <580959.1716475058@warthog.procyon.org.uk>
 <641239.1716487625@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <641239.1716487625@warthog.procyon.org.uk>

David Howells wrote on Thu, May 23, 2024 at 07:07:05PM +0100:
> asmadeus@codewreck.org wrote:
> 
> > > There's a problem in 9p's interaction with netfslib whereby a crash occurs
> > > because the 9p_fid structs get forcibly destroyed during client teardown
> > > (without paying attention to their refcounts) before netfslib has finished
> > > with them.  However, it's not a simple case of deferring the clunking that
> > > p9_fid_put() does as that requires the client.
> > 
> > "as that requires the client" doesn't parse
> 
> "... as that requires the p9_client record to still be present."?

Ah! yes, that works.
'as that uses/depends on the client' would also work.

Thanks,
-- 
Dominique Martinet | Asmadeus

