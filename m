Return-Path: <linux-kernel+bounces-177245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24A18C3BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0C11C21075
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A400D146A88;
	Mon, 13 May 2024 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwJWlb0O"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E83146A7A
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585018; cv=none; b=P1vlD76VuuyfBWocp70UZF0xhgMqky5YTfbgGnE9wlw/lLzlJBZzg4gep/liDySCl/ZDHJ6Bagu1oxEOtucvUxeqE4YO8epe4AnKASS2u5C8sd92aN4gseo9RMWjRTm0z3E4Dw6mPm9OG1LlYkUsQBMGXKzVk20SKYTpNhjrZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585018; c=relaxed/simple;
	bh=EwyLiFCPJ79jd0x/s3FX01TmG6JE/p2BuT/kfZYBST8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML6Z3EEzq027aEHUyMsKPZS4JhUpXz+dm92aMt7scaVsQtv53ZyrZV2dh9rjBHOI8ZT0A+pB9a5g0ECD18QydgEa009/5uJx0TS7k1tU4nZ+0jnzJTzKzzaq1Sw+0Qp2Af0AUxD4x1Qo56oZY9nhKZJRqWVkmxYKuueVKh2Icss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwJWlb0O; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4e59081e6so1635787b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715585016; x=1716189816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkxOXqnTBAhY/tIMjPE5oqoapUJpOqskDlUKhDUKdtU=;
        b=VwJWlb0ODVd+Ywh4nJ1CxPL36BOthk6ddYHn2lQUJIpS7Nql/lJDK7qBDWSLrYxJAK
         2Dtp+xwIcvL5OuBxgfj2Zlhhh6c2ZZfXB6aw1xmANMmUqa6ZEDHNtKkT3eWQubIYMt6p
         ZE4bTQr8kV05qz9NoEPeXKCBHDBWH9v8ZxJuGe66wfPiu3Mpx06JLcHmZiQ4m94yDgIt
         YBig4D1pOuF6SMRMpPb0bNQjtw33vXAwVyPTQgTGW+JN8lkGUSwuXOP8jcIe/IF+wWf8
         h4h5gNPMDLsmqlmkThXBpC2W/QRUHqv3+A9OD9Zyj+inFSmVGp9JZmTtfNWD6ZVOMCze
         v78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715585016; x=1716189816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkxOXqnTBAhY/tIMjPE5oqoapUJpOqskDlUKhDUKdtU=;
        b=UOzL0HJAYVezY6Cj334FmQogkgMeDlKus0O9rNDCIQ+cAumxkFCpwHhWT1/JdMUDVU
         nQuR+HKvTVvuPFVkYFuhowmhZ1SxeuXR1AVjwuJd+UiKgiXUhYzdl1rSbxzmMErto3Gj
         U6opGjhlbq7A2+B8wN1mQqLlAmZLI7zxiiJxQyD2fi2RQvRnSFoPEnCbG7/dkmptPuih
         JZ12AhtAre/fxpANnhlsWvAtmaWnuI0p1Mc6lE3KWl9ie6e8tyUJwfa80JHLFW4apn5q
         J+sZiw0ANY97b+1cmLv83ZITaE8IM+UN+1dkj8douU+El6fd19nDntde4WFdLicQjNRU
         ytfg==
X-Forwarded-Encrypted: i=1; AJvYcCWSwISSfPJmFNp2jgw31Fm9kG9kFTJk48DewWF3Sw7Nvo6LG97zpf2P34rTSTuzNIBhSSwuebljqr4Rug5L0unrmfCm7vvqLqCu6oG0
X-Gm-Message-State: AOJu0Yw7LGeUYnkOleHgLiKgdHTo28VqsV+tNLCEOz7yBGOUueydfUyl
	X5Eb2bn4wPSkgdcbQk7BTeE7qipPoY46+OfwfB9QS1QLt1oH6Crne4MADAgXw1Y=
X-Google-Smtp-Source: AGHT+IHowW17gu11/yK0M22fhOEW8qcMNS4xoNIh9z0IjYf2fw+m2cvq0nqva4tljyfTeocrcYhpaQ==
X-Received: by 2002:a05:6a00:845:b0:6ed:7684:484b with SMTP id d2e1a72fcca58-6f4e0359ecfmr9241749b3a.27.1715585014226;
        Mon, 13 May 2024 00:23:34 -0700 (PDT)
Received: from five231003 ([2405:201:c006:312d:c30b:6348:71fc:1f89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0bacsm6752159b3a.105.2024.05.13.00.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:23:33 -0700 (PDT)
Date: Mon, 13 May 2024 12:53:27 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: kernel test robot <lkp@intel.com>, Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] soc: ti: knav_qmss_queue: do device_node auto cleanup
Message-ID: <ZkG_7wJvIjZ4ZlcV@five231003>
References: <20240510071432.62913-3-five231003@gmail.com>
 <202405111846.3m9z398l-lkp@intel.com>
 <ZkCZTv0Gci3xxKtw@five231003>
 <20240513064451.GB652533@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240513064451.GB652533@thelio-3990X>

On Sun, May 12, 2024 at 11:44:51PM -0700, Nathan Chancellor wrote:
> On Sun, May 12, 2024 at 03:56:22PM +0530, Kousik Sanagavarapu wrote:
> > On Sat, May 11, 2024 at 06:12:39PM +0800, kernel test robot wrote:
> > > Hi Kousik,
> > > 
> > > kernel test robot noticed the following build errors:
> > > 
> > 
> > [...]
> > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > >> drivers/soc/ti/knav_qmss_queue.c:1853:3: error: cannot jump from this goto statement to its label
> > >                    goto err;
> > >                    ^
> > >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> > >            struct device_node *regions __free(device_node) =
> > >                                ^

[...]

> > Seems like gcc didn't catch this when I compiled locally.
> 
> FWIW, you may notice this as you do more conversions. The fact that GCC
> does not warn at all is a GCC bug as far as I am aware (i.e., clang's
> error is correct):
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91951
> 
> which has come up in other places:
> 
> https://lore.kernel.org/20240425174732.GA270911@dev-arch.thelio-3990X/

Thank you so much for these links :)

All my internet searches ended up at stackoverflow posts which didn't
even describe the problem correctly, which also lead me to write an
email explaining a partly erroneous solution, which is sitting in my
mailbox ;)

Thanks again, these will help a lot.

