Return-Path: <linux-kernel+bounces-202740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F7E8FD089
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19AACB3520E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1E91BC59;
	Wed,  5 Jun 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JVTeID7y"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9219D8AD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595650; cv=none; b=ogxjdu03RrcwQHgtQE8HWH63zbc3XGZASRn3f7zm1SggD8qaHSSmT7qhmc8fQQuEdYnclwyLZzXQ8X24kxJTvx2rjsaQFl266zrohCyZurczwnezwTpWdeh08ajVxNESJxjYauUDpngsi9PF8gNZWa2FMTrlEDE/UpGZZTlOW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595650; c=relaxed/simple;
	bh=KgtgECh8TfWkkBQSSaUQ2WLQ2CDSch8PaxsQ2s7DuN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyHxlgHFLW1WK2lUuSGu2aFFcS7BIlWKoDfxY10TN4142pywNtAtOiph/XZ8I1Vf+kO0DXAbxCLj5czrJ1MUz2yIUCF6Lv+UTELgo8nrUz/39jAc2xUHJsEG2yx9QthKdmwZ5spT9pLggIQZecotojh+9UIHdr0HHprnhNkRaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JVTeID7y; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso3150746a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717595647; x=1718200447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTYnKO28j3YI9ux1Zgv39qkSZnMjwNV2K+hqhI8JYnc=;
        b=JVTeID7yDFEMKzPZ8uxkcxQ+klB/vCheYqe4LUcriCzich/omNJdM4Ykfz26ITNcrh
         El4h/gvJJQtjokFxJ7Og0N5xI4PubTyRcOhpv5MmnOhlKbMhmQIzlPhuk3Dy1zJLYYY8
         TEcMeXcqcXmROBOA68uCT3mSz+JSBhzlBHv5cOLOCqyR2R5I66QOOr+P0OaSq7/lf+sW
         rsrg9OPOfbik6b+sVkddYKaeao3q3pQzQ6tD/cM2u25p9cWnf5xvE+tSnFhyhe7GSiYK
         C4boi7YKMfmFFWQRyCmoxB82iOgda4Rek4Uahb0klGAG2/pz3HhWXTE/gLXkyMiNqXcC
         fPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717595647; x=1718200447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTYnKO28j3YI9ux1Zgv39qkSZnMjwNV2K+hqhI8JYnc=;
        b=eGk6KKTSbaYRfmVDfUJ00x/WZu8gKNRfC21IPSKwGqVkVXP/q0/s4UlG+Excc6bhkr
         Er4a72ECxn/FJEHVOanNkgbTaV/GVdY2Y8ws0oRGBMwoCQ/M5fmOB5+lGWBe5rKqsJ4E
         Hq4pYZmIrWdrOx8LiRI0C4DVjhi9Cqn4lm+Z89q2HkVjKRE/00csO4PEfSGkVowioWHd
         ggRPv40fH69mzbzYbaSpd85F5YbjjiEGDMjeJVbKZvmEMtTql2trLnEkTFbg0l/9O/0g
         0vhQH4Dy4eRsTgdmt0PAZqCFV0YijSquJumBZrYXi/eZ06XT6l2FkRdz/yDbxkf4uMo5
         YnjQ==
X-Gm-Message-State: AOJu0Yw8QDVpz3PHogS7O/f9U8vzD1aJPJd6LeInF9L+aYabDeMvEQ2G
	Bebf9HyXO7zZvRBzxF43a1gSefx7Munv+rrU24urAndSbz+kiba9zxl3fA3PnCs=
X-Google-Smtp-Source: AGHT+IFdZN11IhO+Wzyc/C0Q4Y5W12qxkiMbqEoJ7pPfnvvovPjrkZuFmtGBH6F4gxxBTXjxG8vPLQ==
X-Received: by 2002:a17:906:2750:b0:a68:f1ca:a8df with SMTP id a640c23a62f3a-a69a0016ed5mr163026566b.71.1717595647239;
        Wed, 05 Jun 2024 06:54:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68b7b8c33asm642098566b.69.2024.06.05.06.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 06:54:06 -0700 (PDT)
Date: Wed, 5 Jun 2024 16:53:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, kasong@tencent.com,
	LTP List <ltp@lists.linux.it>
Subject: Re: WARNING: at fs/nfs/nfs3xdr.c:188 encode_filename3 on rk3399
Message-ID: <ec11cd23-18a8-443c-8dc4-bb444a15b35b@moroto.mountain>
References: <CA+G9fYuzd9Cz2Ndwc7HFOimJPRZL7w376N=2R2cV-d0mjzT+nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuzd9Cz2Ndwc7HFOimJPRZL7w376N=2R2cV-d0mjzT+nw@mail.gmail.com>

On Thu, May 30, 2024 at 06:54:05PM +0530, Naresh Kamboju wrote:
> The following kernel warning has been noticed while running LTP statvfs01
> testcase on arm64 device rk3399-rock-pi-4b with NFS mounted test setup and
> started from Linux next-20240522 tag and till next-20240529.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Test log:
> -----
> mke2fs 1.47.0 (5-Feb-2023)
> tst_test.c:1131: TINFO: Mounting /dev/loop0 to /scratch/ltp-9gvw[
> 5211.161721] EXT4-fs (loop0): mounting ext2 file system using the ext4
> subsystem
> F2L8n6/LTP_stadLH0F7/mntpoint fstyp=ext2 flags=0
> [ 5211.169391] EXT4-fs (loop0): mounted filesystem
> af9dfac2-88f6-453d-9d02-c14cc888a51d r/w without journal. Quota mode:
> none.
> statvfs01.c:32: TPASS: statvfs(TEST_PATH, &buf) passed
> [ 5211.175518] ------------[ cut here ]------------
> statvfs01.c:44: TPASS: creat(valid_fname, 0444) returned fd 3
> [ 5211.175938] WARNING: CPU: 5 PID: 786885 at fs/nfs/nfs3xdr.c:188
> encode_filename3+0x4c/0x60

I believe this was be fixed by Neil's patch which was merged:

https://lore.kernel.org/all/171693789645.27191.13475059024941012614@noble.neil.brown.name/

regards,
dan carpenter


