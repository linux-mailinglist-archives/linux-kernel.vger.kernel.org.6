Return-Path: <linux-kernel+bounces-173840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03D38C0646
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13E51C21413
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62375131E41;
	Wed,  8 May 2024 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UkxCOW46"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5112BF20
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715203679; cv=none; b=s9Xl15AUnFVkjTXz0/vt+ZBQf5awXU7fGzz9UkAFrBJ67Bem7tzRJU7c5bHTJHqh/pOdo0dc3CWWKYyCpsHMR4K2CrakqdzRzjSYEDoldOsG2CWGHiCmiGQsafSV0J0Hf/nhHiVQuUJ2gKMlAEQfhtgz2Wb1aTpzUouUL/Yw8xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715203679; c=relaxed/simple;
	bh=tcyUkUGFCBs0apT7j12lUi7+Ta45tAkzDbK0EVCuh4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYt99Yd4QmKLxxs66XWfNLxARYFFyEyWnAq1bJeGYZvdv3isJwcPPu/nod1NEuqHL75oCjCELkiSSiD6uv5F1P2cSjD+Qk4tptRo9zFtUN02zJGVeO17fhfv09d99kh/QEO/o9q/OQeC0cD1Ur+GHQ0ZG4CD1xS96KKTHITc0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UkxCOW46; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 8 May 2024 17:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715203674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2PIVc4MsF5g5dNnPzDWtY9lOI3+7BMrFx1/YjZoqfI=;
	b=UkxCOW46H3sIjs6jdu40nEnfyl29X4TBl2yJBNFlw9i4iUwt+AlRzuqhp8lYAdectpmkJe
	LxyvKl+SqWIMO45lRJA9dzool9ftAt2mK0XtR/wz4n31CbMwnDiJ1O4zO80zEYkhfFvzEh
	CQ0c+WO13oF8wZ+ec/WiRsaETdrodtw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Cc: Glass Su <glass.su@suse.com>, linux-bcachefs@vger.kernel.org, 
	Su Yue <l@damenly.org>, Brian Foster <bfoster@redhat.com>, Coly Li <colyli@suse.de>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] bcachefs: Move BCACHEFS_STATFS_MAGIC value to
 UAPI magic.h
Message-ID: <fg3cvwvadldeglwrqdeeglswxwupyy2cjki7si7sz3jwsrpzpf@5pkugq7jyzb2>
References: <20240507153757.150891-1-pvorel@suse.cz>
 <6D9FCB08-480D-4CA0-82E2-284B1F2BF8FD@suse.com>
 <20240508211759.GA209026@pevik>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508211759.GA209026@pevik>
X-Migadu-Flow: FLOW_OUT

On Wed, May 08, 2024 at 11:17:59PM +0200, Petr Vorel wrote:
> HI Su, Kent,
> 
> > > On May 7, 2024, at 23:37, Petr Vorel <pvorel@suse.cz> wrote:
> 
> > > Move BCACHEFS_STATFS_MAGIC value to UAPI <linux/magic.h> under
> > > BCACHEFS_SUPER_MAGIC definition (use common approach for name) and reuse the
> > > definition in bcachefs_format.h BCACHEFS_STATFS_MAGIC.
> 
> > > There are other bcachefs magic definitions: BCACHE_MAGIC, BCHFS_MAGIC,
> > > which use UUID_INIT() and are used only in libbcachefs. Therefore move
> > > only BCACHEFS_STATFS_MAGIC value, which can be used outside of
> > > libbcachefs for f_type field in struct statfs in statfs() or fstatfs().
> 
> > > Suggested-by: Su Yue <l@damenly.org>
> 
> > Would you kindly amend it to Su Yue <glass.su@suse.com> or
> > Kent can help if the patch is going to be applied.
> 
> Unfortunately Kent was faster, it's already merged without your SUSE address
> (and your RBT you added in the end):
> 
> https://evilpiepirate.org/git/bcachefs.git/commit/?h=for-next&id=ce8f9355f23be9756e499682d0d642a741db6c3a
> 
> @Kent: Maybe it can be even now amended (with Su Yue's RBT).

..sure, make me invalidate my test results :)

> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > > Changes v2->v3:
> > > * Align tab with other entries.
> ...
> > > #include <linux/uuid.h>
> > > +#include <uapi/linux/magic.h>
> > > #include "vstructs.h"
> 
> > > #ifdef __KERNEL__
> > > @@ -1275,7 +1276,7 @@ enum bch_compression_opts {
> > > UUID_INIT(0xc68573f6, 0x66ce, 0x90a9, \
> > >  0xd9, 0x6a, 0x60, 0xcf, 0x80, 0x3d, 0xf7, 0xef)
> 
> > > -#define BCACHEFS_STATFS_MAGIC 0xca451a4e
> > > +#define BCACHEFS_STATFS_MAGIC BCACHEFS_SUPER_MAGIC
> 
> > > #define JSET_MAGIC __cpu_to_le64(0x245235c1a3625032ULL)
> > > #define BSET_MAGIC __cpu_to_le64(0x90135c78b99e07f5ULL)
> > > diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> > > index 1b40a968ba91..bb575f3ab45e 100644
> > > --- a/include/uapi/linux/magic.h
> > > +++ b/include/uapi/linux/magic.h
> > > @@ -37,6 +37,7 @@
> > > #define HOSTFS_SUPER_MAGIC 0x00c0ffee
> > > #define OVERLAYFS_SUPER_MAGIC 0x794c7630
> > > #define FUSE_SUPER_MAGIC 0x65735546
> > > +#define BCACHEFS_SUPER_MAGIC 0xca451a4e
> 
> > IIUC, due to some historical reasons bcachefs used to switched
> > ondisk sb magic from BCACHE_MAGIC to BCHFS_MAGIC.
> > Other major fses uses  *_SUPER_MAGIC both for ondisk 
> > sb magic, kstatfs::f_type and super_block::s_magic.
> > However, for bcacehfs there are three magic numbers.
> 
> Thanks for info. But for struct statfs in statfs() or fstatfs() only 0xca451a4e
> is needed, right? I would not expose the other(s) unless it's really needed.
> Also we'd need to backport UUID_INIT() into UAPI :(.
> 
> > Anyway, it looks good to me so far:
> > Reviewed-by: Su Yue <glass.su@suse.com> 
> 
> And also without your RBT.
> 
> Kind regards,
> Petr
> 
> > — 
> > Su

