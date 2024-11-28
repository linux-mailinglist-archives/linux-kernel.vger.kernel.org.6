Return-Path: <linux-kernel+bounces-424388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EA99DB3CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5831E281B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB7E149DFA;
	Thu, 28 Nov 2024 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fJyeNtHq"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB161863F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732782744; cv=none; b=dWVgouMZAsmabovu13t4Ilytr/9+/z9/SdgUe/63gOmfGZjjCEH2PffM13hQSRpSjXeQSPmWl2tzlAmeWgsjMt1WFq2/SSKP1GJ93Sigi5s+z56EUb5WMwBo/0PT6YM7BzFag85FhjvRA3Wwb+0vTfL2vg4A9/zIsQdujKtCh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732782744; c=relaxed/simple;
	bh=KY/jdEFrXJ/ZzyFCYnRsBs/1dt9MG/KBUn9sInofpE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz6ufIh5DHNzr4It1Iyn6T0qfYFxIvC0b/QtoSSkgnt25iay2OaIvwr+R+8/Ygz7GqEJZim32S4M2DKJfF/aW7w9qUny519WZF0nZceLbq1/ogX5zFxg3mPKMA2mpaKBuZZybZuMWOWIFX8CjkmMHSW39cTm7Bcwv1/qC5zRma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fJyeNtHq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a742481aso4652935e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1732782741; x=1733387541; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IkmUTsVLQMvFKC/acbiNHMDNlfrO4VJGSOdTD+kFhvk=;
        b=fJyeNtHqRFxZ6Iwsv5lh/py4OSAQ96GUaMQHR+iahMXWfCCJyEuBEp9rugdfhE9S2r
         FAVXdDnhvzglGSwcfmGWbzLNmxL45gEheHGf4Vq4ZWwdef7L+xbUTBDbhqXlKiuQnQa0
         i2IYdRYK/vEKKTK5KW+lS0A8OEmDUCKsGxaIZxN1VDQx+9n1F9c3qWKqHMVnbmbbUhjH
         2wvhaUAWBQRPiH+VhTa0zxxKn0mOzry5S0jdqypb+pDFz21Vdz35mEboFwVKNoSRH5Z/
         T+wbTh8UEzQTlgdW2Y/ybZwkEhOoTdIJdTYAYrQfIteSBeieah932S3eyu6BAQpPwkVo
         Y5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732782741; x=1733387541;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkmUTsVLQMvFKC/acbiNHMDNlfrO4VJGSOdTD+kFhvk=;
        b=HxVXMlKfAjDApiBA/pwBPy+iKfxoFHSwAGt/w3MwoiLKroz8sLcuXcfcPhveu+77rk
         TQUjdpb3njIYPzA/IykElOmmV4Y7owBFaYWyXFb5+eb0O5G9FZTzcZSjsJ2/XSdNPROb
         UeIEEZgbNmP3sC0dj/rd0DiX+Roxo1royUNJpQtGbHwsRRl+vdzo+AI96yVV7ZsvnFu9
         BwxvQNxQKgRI2DDZLd9oL9fRZysOaVDdhLp0zkIvEC2dQYv5ChEZjFJBL/xd+r8ntdBU
         Bs7lrX4++z20Nx/2OWe6OH3QsqOfETz8rtrs3IgIxo8LBJLaD1rIa8O0zaFTEqG0sBRw
         bqFw==
X-Forwarded-Encrypted: i=1; AJvYcCUTYl+3i4NRZLxosUxHHu7UeiCwYSmGt2UeeQrrJx5kVW61+fRNNh/7cBP6n3Ml3Vn3/NZuckPEPkr29oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh68tuO6tn0567Xr88OvL72rsfetbnMgPYR3qJbeoTHHLUfKIk
	3BLmk7JXx5/S0ZXQCvAi+34dB3UDqZb7aBgn2R/WHf5P3GXFOXXMRxnP2+wlPAs=
X-Gm-Gg: ASbGnct2Gxoy/udHt1DGQwPsRhczTurWyJI6VijytapYWVlbBGl83eQZ/0tm9T/8xlD
	HlW5jM8LVkXVSucJab5xqJg1mmWBdeLFEXxNjRZt3lY7rFpOXugIy+GDw0e+wMHlQ/TLoMJoQ9i
	I6SxuyLxhxsAmtTnnnxz3AtYPjruhS+K0koIsDntGLTuUXaDcz3YUWAN4AmCQiCZfmHFlqaj+7V
	UHmmtTS3P2v/YUfMb0IAbBb7AVf1AZ+SFkxOjaeRJ2Bo0wG82Nqa0QBA6jz9G3RRPiISnRw7K8Z
	MIIWuI3R9Lq2vvivWs8C204cAhGKGE8NahA=
X-Google-Smtp-Source: AGHT+IEwQd4MULG9+vfOa2qsE3UwH6o+SBFQmY81KWSmVFdtfK+f0e5Zt6kIK2SbhEhkH97nvavxlg==
X-Received: by 2002:a05:600c:46c9:b0:434:a4a6:51ee with SMTP id 5b1f17b1804b1-434a9dd0060mr63116095e9.16.1732782740536;
        Thu, 28 Nov 2024 00:32:20 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3729esm1033907f8f.44.2024.11.28.00.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 00:32:20 -0800 (PST)
Date: Thu, 28 Nov 2024 09:32:19 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: laokz <zhangkai@iscas.ac.cn>
Cc: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH v2] riscv: module: use a plain variable for list_head
 instead of a pointer
Message-ID: <20241128-0e953467c518d79d12dbf202@orel>
References: <20241127142519.3038691-1-cleger@rivosinc.com>
 <980b98978ab4ee912b37cb101ad43bce20b56dcb.camel@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <980b98978ab4ee912b37cb101ad43bce20b56dcb.camel@iscas.ac.cn>

On Thu, Nov 28, 2024 at 09:01:52AM +0800, laokz wrote:
> On Wed, 2024-11-27 at 15:25 +0100, Clément Léger wrote:
> > rel_head's list_head member, rel_entry, doesn't need to be allocated,
> > its storage can just be part of the allocated rel_head. Remove the
> 
> Oh my poor English. OK, it's more better than just add the lost kfree.
>

It wasn't the English I was correcting. That was fine, but just saying
the object could be "a plain variable" wasn't giving any justification
for the change and, to me, even implied that rel_entry was locally
scoped. So, when I first skimmed the patch and saw that it was getting
appended to a list, I almost stated the patch was wrong. It was clear
after looking closer, but it could have been clear the first time
through if the commit message had better guided me.

Thanks,
drew

