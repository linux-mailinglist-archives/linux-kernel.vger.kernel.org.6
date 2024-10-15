Return-Path: <linux-kernel+bounces-366351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E9299F42B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CBA21F230AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BB11F9ECF;
	Tue, 15 Oct 2024 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="OB59CKMm"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94251F76AA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013724; cv=none; b=aYSDb6HTWNTrcwM0D2QXBVKCnuUIWztoBjfSWS68HTI3Ho0Nkcy5mgOMGZv7SpsHwbzUvDizzT2jGU6N2dmKbFmjd4pAnNvmPtvirZ0yDbHq3ZKwGBQCTp9imggdKhnAl+NmIR0ItjiOeONAWlDDzTDtdXtGqPHvTcjDTCRjQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013724; c=relaxed/simple;
	bh=NnE26QuJL8kx6+nbQti902lo90aIRg62wHnFCAy3axM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYGltLugg4PIL6xPJpPFo+Ub3fKkDFOQftlDBWVezMZb8EfV/XPX1FvGC3nRpmvVqREpzjuMc3rTLCeBBZWv3C6l64FQ8ggisocz0zeKI6GFPEjKFWhNqzY3KOzEE3O3n1+lhY9E7M4u/htcM6knq3c4QPKwivSfkrFpKYbNd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=OB59CKMm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cf3e36a76so21669645ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1729013722; x=1729618522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JytOzcc+dUIDL9WdRCARe9Uv3pKvU7/eSVdxVkOAXWI=;
        b=OB59CKMmnuVW8Gv4Jyw7vxRpstTMGWAa/XpilTdlpgIeXoZuDF6NnlzfiVkbxf6TbT
         EZaWkFGR4UZ8QVuswGw2sVHhvkYat/jqf2ZOW8eppiS8gy6iBYqclvIZFzuGgrN1mJ9A
         qZkTq08umUdMw+kHbJB72hXSSumbmVv5Dpt2Dnd/xCpXWEE9PbcBgrdhVRVg8Uqs3Zzk
         vyPzI/+LHi04B3S6DSqqxgmkq9F/UTn/lCO+RtzMPIOGdq+vj5r9m0mweMIranXVzXug
         fgocse758hBtLfMM2BAAz6IkFNhHfPTm0tzmQQ89PUSniw3AdWVB09snPkR2T0SGrnNd
         NgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729013722; x=1729618522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JytOzcc+dUIDL9WdRCARe9Uv3pKvU7/eSVdxVkOAXWI=;
        b=ZjIEApr+ZszptY0B+P9C+Wi4Xzwe7zo8fNZ7WujExoYETyOROMUnlsbyGsDsqif9Xg
         fHZaShQ2Zj506p+3fmrHAozDrD17iBvE8pN5duDT9ybio08BoaSKkgpPVTt54MmehKmk
         L29RHFxOsdIo10W7gFbIY9Ibtrc+JpUjIG5/wxRrb0QsgsEyhiUOsbvoISIcup92IYd6
         fCtvwy0Xp5RFcle4IljAhXob847cb3nRYU9vaL7vQ12LskknReuWpdVbkkHA7McKYuPi
         +/pYNpdoiVw64UxmHRcxZxyk9PIlXZaOYV7b8+OSKZ4Ba6NmSJubKjLfWjtvcEpbnj4H
         FY1A==
X-Forwarded-Encrypted: i=1; AJvYcCVG7m6bllOOyPvaOiJuzWEBFiFlisXTJgSfJmy4Ae5aVFJMNuzYYFIO+Kt16f/R0LQUMQ+YOncXTVhj1aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQl45HhGpl/G2TdHgfwihdkc86T4KW4Y0M9QuAZArWHA+nzT6a
	W0FFXR8gOYjGq2RIpc5AHLyGzjl5p7CwmD53iX0JFJjNk5kvz3xFzCdMHzqs190=
X-Google-Smtp-Source: AGHT+IHgnKPG+JToMuAc0LWW3oeijO/iQFtN52pi0xgDD1whm+yFZJ03BLmZqH4aS986t90jj6sCwA==
X-Received: by 2002:a17:903:2301:b0:20c:7d4c:64db with SMTP id d9443c01a7336-20ca16be1f5mr250149925ad.49.1729013722182;
        Tue, 15 Oct 2024 10:35:22 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1805a180sm14526195ad.242.2024.10.15.10.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 10:35:21 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:35:20 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Conor Dooley <conor@kernel.org>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] riscv: dts: thead: Add TH1520 pin controller support
Message-ID: <Zw6n2HJqltna1Y3U@x1>
References: <20241014-th1520-pinctrl-dts-v1-0-268592ca786e@tenstorrent.com>
 <20241015-thriving-dizzy-4708ff6b6ebe@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-thriving-dizzy-4708ff6b6ebe@spud>

On Tue, Oct 15, 2024 at 06:19:19PM +0100, Conor Dooley wrote:
> On Mon, Oct 14, 2024 at 10:54:17AM -0700, Drew Fustini wrote:
> > This series of device tree patches enables the TH1520 pin controllers on
> > the BeagleV Ahead and Lichee Pi 4A boards.
> > 
> > Patches 1-7 have all been cherry picked from esmil's th1520 branch [1].
> > They do not have the issues pointed out in the previous series [2] that
> > I sent out which contained out dated versions of the patches.
> > 
> > The final patch was suggested by Emil as there are not currently any
> > users of the spi0 node so there is no need to enable it in the board dts
> > files.
> > 
> > I have tested on the BeagleV Ahead and the LicheePi 4A. The leds on the
> > BeagleV can be controlled as expected through sysfs.
> > 
> > [1] https://github.com/esmil/linux
> > [2] https://lore.kernel.org/lkml/20240930-th1520-pinctrl-v3-0-32cea2bdbecb@tenstorrent.com/
> 
> btw, this should have continued the version numbering from [2] and been
> v4

Thanks, I'll keep that in mind for the future.

-Drew

