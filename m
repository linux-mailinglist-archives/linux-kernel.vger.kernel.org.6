Return-Path: <linux-kernel+bounces-185398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B698CB479
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1EF2826AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9785C1494A2;
	Tue, 21 May 2024 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOoSLhwp"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D24500C
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321173; cv=none; b=itBFw5639dOHgp/wLbMf6x1v229/OrKQvI8bl3my4Xsx60CQb+V6uo/y28lquw4Xjnk4fyH/lGwJTf3PXcWLZyUc7JYGqbHagrS2JaB7PNLul9bAJ2eaAwZwbEJ5K6po8Zf+IpSTIHGVyoZOrVyLmFbY/F12tHqN0323dBV0r0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321173; c=relaxed/simple;
	bh=AIk3Te5Khbgkj4dKDNmyOBw5nTwQzUiQDLhOI3cOvyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElWrlUvPl3xSwgqhZ1NwsBf43jRkds/DU4e8yLWWO+OaQPxHa5VJk/a5zHUqt8VszlQClExOr15KdxJYsWjxGUitJHhOMm5c5wP1+XXV2ZFuQnpNGkoTYGTCM8m6CKeDsIgJFxxdtkguF2w0YJQ/9nDzageThgDE+27ELieEoaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOoSLhwp; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-66afccbee0cso583979a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716321172; x=1716925972; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uwoRMUgGVs4zYJZWQT/GwK3gau3xPXSHiwBTODwTHaY=;
        b=MOoSLhwp5TAMxPAlIRtfpX8l8XN3Ar3DAHflCzDsp2mDZ//dfsj3GPuarBlhSwZtRA
         i0L+JfgG0Rtn/OwpQ7MZSSMU/Sj2B+1lvyL0U4eaPywoqjfcuMkMebgx382emxO/L6a7
         QYjivSfT2Q/JscznXz7SA7j5m7V9lU0pZMbifnLnine+g5zXykts4sxvB+D3zCUdwP3p
         WZXBEDHh3tsvknYFy2LWFE6lbcXh6g+o27fgWWR8Xtzz/3KqUTzpVMuiZsUdBysqln4M
         iK5jfN5mAY5xdm6t30XtKL05r+vIAU6z7LPXNtqUbqr+KVtP+9VLhgoyClpiQpwdw4rb
         bkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716321172; x=1716925972;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwoRMUgGVs4zYJZWQT/GwK3gau3xPXSHiwBTODwTHaY=;
        b=mDlW7w7ZENPIEj5UGGao+SfEzB/6xpVbeiYVpf5b4AtQXypUn/gvuH/F+k0dbgGd3X
         22LkYazfKYmtwIrxSN8d2ikeel+xcd9/jscDJlsyACUCRnaSiyj+/h0E/2ADoPN86ald
         frGXwcK/+6xbr5azLlmOSPSntIrkUL3fyHq3BP5GsFEhEIxLF7LQK/2G+AnTK0Uz5d+N
         7mzLIrSpthzzmoRIg0l5e7lNw1yOspLfRd7aySTgPtobKVIEdwSRre9L1Ut/aT/SyeKR
         P2F+RQcuVDuYGu/dfjehsCS1DfzdtlJYT4MVIjqeS9GGNvcI2+dh80VlhUGle9dDhBa0
         wy7A==
X-Forwarded-Encrypted: i=1; AJvYcCUicVBBsW8TCMv6y1wIC4B45wBRm7KTs9fgHOkjCcdyzvxpx7f0m7qxRrgTtYsc4IDvJeD+cJu3WjD8PwCB+i/89EPfN2yU1AA9keJV
X-Gm-Message-State: AOJu0YylnAwi6tuZRs2AcB/wz5n2gdUyQ8rD4F0zeh6EwaJmddQdEJZe
	o9/aknO+trbzs5d61V2fRH7Zmnu59adt+PmGWo5F3Fyf8OTsB1bx
X-Google-Smtp-Source: AGHT+IEFd/vGdGtVxyc5m8sFqOz/xr2BLWYWyVMmaQij104lOaWQWm5gWr9QT9MPwCP16LKSRll+cw==
X-Received: by 2002:a17:90a:b30a:b0:2bd:7fa1:29cf with SMTP id 98e67ed59e1d1-2bd9f5adbdfmr100383a91.39.1716321171722;
        Tue, 21 May 2024 12:52:51 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b671782d89sm22160498a91.55.2024.05.21.12.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:52:50 -0700 (PDT)
Date: Tue, 21 May 2024 12:52:47 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: Alex Elder <elder@linaro.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] bitfield.h: add FIELD_MAX_CONST
Message-ID: <Zkz7jyR1HJCIPqku@yury-ThinkPad>
References: <20240515172732.288391-1-mschmidt@redhat.com>
 <Zkuksm3K+pKugjgF@yury-ThinkPad>
 <3f3b75df-3488-4915-bc21-54cb6a6e2a74@linaro.org>
 <CADEbmW0BZbJQbaycqq+vfisEJyGd57uzEgFEckusGLJSLvmYDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADEbmW0BZbJQbaycqq+vfisEJyGd57uzEgFEckusGLJSLvmYDA@mail.gmail.com>

On Tue, May 21, 2024 at 04:44:33PM +0200, Michal Schmidt wrote:
> On Tue, May 21, 2024 at 2:33 PM Alex Elder <elder@linaro.org> wrote:
> > On 5/20/24 2:29 PM, Yury Norov wrote:
> > > + Alex Elder <elder@linaro.org>, Jakub Kicinski <kuba@kernel.org> and
> > > David S. Miller <davem@davemloft.net>
> >
> > Thanks for adding me to this.
> >
> > My bottom line response is that I don't understand exactly
> > what problem this is solving (but I trust it solves a
> > problem for you).  It *seems* like the existing macro(s)
> > should work for you, and if they don't, you might not be
> > using it (them) correctly.  And... if a fix is needed, it
> > should be made to the existing macro if possible.
> 
> Yury, Jakub, Alex,
> thanks for your reviews so far.
> 
> All of you want to avoid adding another macro. I agree and I will be back
> with v2.
> 
> To clarify where exactly I ran into the current limitations of FIELD_MAX:
> I am reworking drivers/net/ethernet/intel/ice/ice_gnss.c:ice_gnss_read().
> There, I will be changing "buf" to a small on-stack array:
>   char buf[ICE_MAX_I2C_DATA_SIZE];
> where ICE_MAX_I2C_DATA_SIZE is defined using FIELD_MAX.
> 
> There are a few more issues. I extracted them into this test case that
> I would like to make compilable:

Whatever you make with this, please add a 2nd patch with a test(s)
covering your cases. You can refer the test_bitmap_const_eval() in
lib/test_bitmap.c for an examples of how the compile-time expressions
are tested. The best place for the test would be lib/test_bitops, I
think.

Thanks,
Yury

