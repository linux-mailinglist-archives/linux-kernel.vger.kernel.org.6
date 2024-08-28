Return-Path: <linux-kernel+bounces-305026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3388962856
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9291F23338
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DBC185B77;
	Wed, 28 Aug 2024 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pv4EmUsP"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE17A16D4C4
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850809; cv=none; b=nNppBQD5WNrS4DxK1hiNnTMTRu9Yj5J231fWTsDlCC4oSagpbF+dBzyp9LCCfS4q2aI+jNcmv1ftLFhHUC4bOAzBg0kLNdOThvHfJx5Z5W+sBwr1021vvsMQVFDZ9WMluySkGltFloXZF5/DbOFXopZl55ExD4b2l8I7HK7jevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850809; c=relaxed/simple;
	bh=c/zc+UsOMGU7+W7R+4O3camx+C1Cz8Nz25luYqSOAOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAaPJ91LH7X0oVg/WHMITGBgbSYG1Tm7tm2qkEQY/KkuaC9nX9UiJ8p5ZrzSVujCPDg2o/fS1XB5pTGnXSdQ08nfNn3e5tIKQapPPOVoBlLYLo7+oqvtHFKrqC4MaZsqnli1bAlYXHX0/VwyP1A1GWr5TDxzJu/IqZtXn2YXnJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pv4EmUsP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3719f0758c6so3949001f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724850806; x=1725455606; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oKFxTdVhG0vl9VERtDu2+jX5SZIfs0u5rZfANIo5dLc=;
        b=Pv4EmUsPR+RhkhJm3FqTYbbdMUR44zZK4F5eddJyZ4O3QO/mjkjsj5kR5HaKr8NswT
         sok37IC+taVc23VsrZ6A2Fp08lNSoOjsCtKuH2v1qYqZIftQBu630JZS1bG5ULB3GBsD
         6rRcIaXVPc48oT0RQgjR5y4B0MdhN6BYCLQ99ugKUOIERbtFjQkJRGk5vX2UmEL7aPlc
         niCGA+Z7xOqOtmE1a1FpzJbM1qDf3xdFB1bS5mgeWDQ0VLskN+HK4sh0BiduKvEXr4ro
         9txj3RGfG2glD0kusqc2WBt7eGyUAc4TRqett87tauG0zO4YCKTyW+Oae/s7rIWvm6zo
         LxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724850806; x=1725455606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKFxTdVhG0vl9VERtDu2+jX5SZIfs0u5rZfANIo5dLc=;
        b=MwGBe0OkKpnhQUs/50Rm9M4QI/ijtQImZex3s3OHkRag6wlIkOALdlODhmiU7fTnS+
         RKiY+xpPCk28p+OUGLToi+htCfK35L/cdjg5gdurFInEGjPD1wt4OVu9YAr5I6r4nPjn
         EXy7kUe5mwvW6zekexy4wXE9tvot9bDx40jth1lb8OF/i5BL3r+v4InRiFxz3tdDrOOB
         fgMMxtmSsJ2dA8l9t5X9/iRF040FQPU7j6SbAahUvrWSr6oV6TknGXjSmSao++cKt9f4
         3xu9vIhAJMaZf9c//URCkOrWZNgbKT5Q6nS+h/rHxxoySzR1kuDCmp+j8PQ0wdngEC29
         mcug==
X-Forwarded-Encrypted: i=1; AJvYcCUZngE4/d1IKGkZ1zOpLWEl0Op0WmvZglzjLqeAW+napa0FZTq5T8b39GCrOuSUma7FUBctbq6uNEcDsuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+BlrJUSyYoHwsi0Nh11UisjavePq8q83+uu/NesvTFq0j02y
	4YLaFqTylG3XKsYwEvH9VG2RoufbGjvyGbmnPn8rDIBYfRXYvdx1k3N4bxo0geU=
X-Google-Smtp-Source: AGHT+IGG2FnZQPb+umi9NbaPw0r2wgnClzF57CwQ4CjBjoGjUZ26/eTfZhl9zE3dVOSPHBTGIqLBeg==
X-Received: by 2002:adf:f7c9:0:b0:367:9575:2820 with SMTP id ffacd0b85a97d-373118d12a4mr10702272f8f.45.1724850805948;
        Wed, 28 Aug 2024 06:13:25 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308110603sm15621246f8f.2.2024.08.28.06.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 06:13:25 -0700 (PDT)
Date: Wed, 28 Aug 2024 16:13:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] btrfs: Fix reversed condition in
 copy_inline_to_page()
Message-ID: <5a19b8a7-385c-4616-a5b7-212e19c9ddc1@stanley.mountain>
References: <3a05145b-6c24-4101-948e-1a457b92ea3e@stanley.mountain>
 <40421bdb-4573-4768-8d6d-39b0d0df9260@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40421bdb-4573-4768-8d6d-39b0d0df9260@huawei.com>

On Wed, Aug 28, 2024 at 08:53:44PM +0800, Li Zetao wrote:
> Hi Dan,
> 
> 在 2024/8/27 18:21, Dan Carpenter 写道:
> > This if statement is reversed leading to locking issues.
> > 
> > Fixes: 8e603cfe05f0 ("btrfs: convert copy_inline_to_page() to use folio")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > This patch is obviously correct but it's from static analysis so additional
> > testing would be good as well.
> > 
> >   fs/btrfs/reflink.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> > index 1681d63f03dd..f0824c948cb7 100644
> > --- a/fs/btrfs/reflink.c
> > +++ b/fs/btrfs/reflink.c
> > @@ -146,7 +146,7 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
> >   	btrfs_folio_clear_checked(fs_info, folio, file_offset, block_size);
> >   	btrfs_folio_set_dirty(fs_info, folio, file_offset, block_size);
> >   out_unlock:
> > -	if (IS_ERR(folio)) {
> > +	if (!IS_ERR(folio)) {
> This is a mistake caused by my carelessness,thank you for the patch
> >   		folio_unlock(folio);
> >   		folio_put(folio);
> >   	}
> 
> Can I merge your patch into my patchset and add you as a co-author?

Just merge it.  No need for co-author credit for something tiny like this.  :P

regards,
dan carpenter


