Return-Path: <linux-kernel+bounces-334253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FEE97D492
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3742863CC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C371428E4;
	Fri, 20 Sep 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDfdLhjd"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC113D26B
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726830608; cv=none; b=q7gjKGfVF+AM7icVTqeGndi2LLve4Ne7OOui5LygGc5HsV9V051B2uIeyYrkU+eQrT+00SGWi+MJPh18mNALmmtShx+p5OTd3cPj3kOywEVG8c8caBx6oLh9ZKcgCVmSVg6OkEJmnwhYg9InUDowOT6M9gDBr05jXfEPRhWCT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726830608; c=relaxed/simple;
	bh=SP8iz223UYOSo5BzrpVFkVxPNjsWT3Y4xNAfrH2OA8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDysdoauGR9fPM0fjwlCJAzUWjC/4HRkvxivPHGIsNAHpN+mTbAR+q7MhEkAj0wuip9za5orn6KCLrew6cdwUVR3rcGEqD05jWLkDxM/FAFDkueNFKKJXUX7YaEYXBwkBDfS8L+btnoRcGzfzctblOonyvkeIYngIL/nTuXgr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kDfdLhjd; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53659867cbdso2972071e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 04:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726830605; x=1727435405; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5EHjGRXCWgZwp1krkmlisCOVeWPEKWd2TIUOSRIDt8I=;
        b=kDfdLhjdBeOydgV97U6nK5UAgSczZtr7yRru4NBKNrF6QwqmYVduDpJwyIQ+FPo3AO
         9uIr95jJCMAa4OETbEt8/g7g3aoxigVNKYiB+xp214OMOjURWy9D5C2KqtJO9dOLtbyH
         yfweLpkd4nRIXHz7ZjtxzO8EOGKh0+zXYXwYw03BAlFbS1dba5WnD/JNWcwyFLsuW3zp
         Rr4sFS93+2Z8sFpaJBn4fM+ClwbLtRFgSJAGsJ3y2H2WpHh5gAKZgHkJUA93TQrqBOYM
         vjcP4OZGnWoIe+SkMtmnuB9U3DkFhTGeMnQdjfRWMe9IWFxbG1QHwg3ZTNjYGjpOBOMu
         kUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726830605; x=1727435405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5EHjGRXCWgZwp1krkmlisCOVeWPEKWd2TIUOSRIDt8I=;
        b=ZKnfF5JlDGwegR2p4Cs9IbMPPlw8GPFW28OtYaU9n8KYqqJIWZaqoCkahMj+n+tDq7
         liJb/G+JxLGTAh+uROQh8Hk8yBGT1CYkJ0vdvy0ocSe2BH35TZdUOmSmRooeU9RPncJt
         uKZ0groDa/c2GNaizGPCN7vz93v3h972IFeh69cIUq9tAMrKty7Lk0ifuRC2Tc+3EEjL
         5G9zm0CisJqN4dwVjtTH0NMegMsMSuRGECShVv7WEW9FjOcrK0tG1SLXL61LeTMia7VH
         g2afCY6o3skukIYJTRdB6PSEqisuKqMm5TJseqLL/Tl/bPhnC4Or5Z4OEmaSrKDAmkPD
         5/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCV4Mvb1d23cFHu59MWDZMYs0qjsPfGHl/0qOY99Hmr6Ow+ms5H7nypZw0B9YiroTl92ivCXOh7GvmhfRGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Pakhy9rOPoClWunP0qgL04/yEwFxz0XmahlqhUlvCRPsOELm
	8TbsbNN0xd3MdoI3RpjuBBW3ghmV5W00puxLE6qFAwXiyTpII7N7dDqKD5Cy4zk=
X-Google-Smtp-Source: AGHT+IFNGKP6ElDwKV6SnNuyGO0cfMJ44eZrIuCs6c8/FaQcThhnYhR3j4iMkCX5GmVhPiPCfnOd3A==
X-Received: by 2002:a05:6512:39c4:b0:536:a4f1:d214 with SMTP id 2adb3069b0e04-536ac2e705bmr2027275e87.19.1726830604714;
        Fri, 20 Sep 2024 04:10:04 -0700 (PDT)
Received: from localhost ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096762sm835762266b.37.2024.09.20.04.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 04:10:03 -0700 (PDT)
Date: Fri, 20 Sep 2024 14:10:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: prevent integer overflow in
 decode_cb_compound4res()
Message-ID: <183154d2-cb65-4161-a737-394aba9c1d43@suswa.mountain>
References: <ed14a180-56c8-40f2-acf7-26a787eb3769@suswa.mountain>
 <C185CD71-0AF6-4D83-AEE5-F8C87EEDE86B@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C185CD71-0AF6-4D83-AEE5-F8C87EEDE86B@oracle.com>

On Thu, Sep 19, 2024 at 02:02:19PM +0000, Chuck Lever III wrote:
> 
> 
> > On Sep 19, 2024, at 1:12 AM, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > 
> > If "length" is >= U32_MAX - 3 then the "length + 4" addition can result
> > in an integer overflow.  The impact of this bug is not totally clear to
> > me, but it's safer to not allow the integer overflow.
> > 
> > Check that "length" is valid right away before doing any math.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > v2: Check that "len" is valid instead of just checking for integer
> >    overflows.
> > 
> > fs/nfsd/nfs4callback.c | 2 ++
> > 1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index 43b8320c8255..0f5b7b6fba74 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -317,6 +317,8 @@ static int decode_cb_compound4res(struct xdr_stream *xdr,
> > hdr->status = be32_to_cpup(p++);
> > /* Ignore the tag */
> > length = be32_to_cpup(p++);
> > + if (unlikely(length > xdr->buf->len))
> > + goto out_overflow;
> > p = xdr_inline_decode(xdr, length + 4);
> > if (unlikely(p == NULL))
> > goto out_overflow;
> > -- 
> > 2.34.1
> > 
> 
> Hi Dan, I've already gone with
> 
> https://lore.kernel.org/linux-nfs/172658972371.2454.15715383792386404543.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev/T/#u
> 
> Let me know if that doesn't make sense.

Oh, sorry, I got mixed up which things were patched.  That looks good.
The truth is I always prefer when people give me a reported by tag so I
don't have to write a v2 patch.  It just saves a back and forth.
Thanks!

regards,
dan carpenter


