Return-Path: <linux-kernel+bounces-444822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 241179F0D06
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422D916649E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DD01DFE33;
	Fri, 13 Dec 2024 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT9SLK/q"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E2A19AA58
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095344; cv=none; b=m6p1c3grpMxe9U+ojhLOLKWiyKxle+MEBtwG2hpVrMuzclpLm5go2VxXuAhwELc90OAaVEAod3aBIOeUPGCi66pxLmMumTf4N+gZhchej0GKRYEu8M9lpMIsjVod1QdMGTsomrqg2z37Vd9g4Q+rAyzuQkvABV3MT0kkd6YcyDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095344; c=relaxed/simple;
	bh=rqaTtvm5IEyKWS5ONUaBUZiybgpVMBEkcAqj9ZEe5vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+k4y4RYQtMiE99+fy5Vi+wcsSOW4DPiSSLANJQunvZDqYUA8uxjqwDQHvZ8RByHsPkPua54pyFLE3JKzrU/NXzE98zhvs3HC3FIkvzE0uKKo/AeggbFx5KwLPjKN9dAglO5YJKRcP6SmfKnyIvJrcZb+MRHt3qraIsT6pXzDno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iT9SLK/q; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so886817f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734095341; x=1734700141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti6eEstcDMekLF5cg8h/xv4zkeUEnh0EvJjkx52ON2A=;
        b=iT9SLK/q2Of32nA57EUWVN2MGOAoCkHnEimt82wzFakEMtzrzae/nDDZ8JTX0CZ2iG
         kK+BHNERV32qfs/P8Cbu6j86n+CNByf62QnpSo2V6t68EuLU8sKGMluDPMbC5JEso+/v
         xnfThKtdusUtuXKoM1Wh0DL+/T1geITh2mgRW0WVRrLobHcgdyOlSboIHa2E7q77A1kv
         1RvItskZOryf4tL9Th5LK90j89N09w0dQelHYpwdZflGQ2E3xKe6fkLbrrGoRHeYaRtD
         hpzS6/Vmu/bnkhWcZgyKTgBIsRMYR2dmDMsDHZIBIQgZ8ssdwC6eqG1joK/mYj+gyH/+
         Ek/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095341; x=1734700141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti6eEstcDMekLF5cg8h/xv4zkeUEnh0EvJjkx52ON2A=;
        b=XcNMzp3zhYYwdEW4zjIBoLBKjTbdwn1no22AfzneEr0sZfjamweh4+9Ibsy4DERLFL
         LL1LX+WKDpJoHEtLbAInvw9YZfQEdS9q+HiiVaTlZ3KOuhAXc9cUDNStKulCwsIg43dg
         VN96X9cUKEAYzy4eYXm3oQIWj+cRjO8B8tc10LIk7urtzl0Iw5N/PEVPcZBMz8UgwWhS
         5F9KIgVcqddQz5o97VAjWGRnOgmb1VMpV5v29hwWmCKkLXQBXzotwasS1I0T3gRcA/zQ
         szn/Fjt3qK9LOdcOsq19egFLUqNREb2gA667XRvkwd+lhgrrfrMQbgRuKN8bGu8HDCvi
         1JwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwRe2sFtgN4HKi3tWGK2aGXM9OmsijGj27VFZYg0zpiICJPqbgTcaVHA0qa6UzlO/aiZp0EqK8wNYRwV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc1f6jLD8xUGpNskAG8U/lbIkVm0SKTcB07F1ExqnKbLDcPQrp
	H2q/rBSAZuxokQn8xlUawd26S1g12Gdv9UNcEZ/a1zQ1dX5/EAQW
X-Gm-Gg: ASbGnctcK3nnALy5fA5HiVxPebltJS0lb42ft9oxtlcInGW5x0upBHl3LCTuIwZT9HC
	dA+bjxaUewMndRPDiEua6XIwh6C4IlqAnimGAPLK2nihOA/2y8oayCImVt1gGNHRZHVNXrg/KKq
	Bg0oyspBv/rgCUvpTyzjuf76Ju/5D0w6VJg8ifsuIv0v3Tv9P0xoPiuuwU5gZVDqSsPAZSCszqt
	6IPSmj+ge1gYcGnx2oqmgb+2ApAlzV5NM2M2DXfRVUCu2g2GWStgm0FAZEiOFzw/X4BZ87f
X-Google-Smtp-Source: AGHT+IGwFfs8iXyzrUmAhIxlrYsb8xItJ9t24BgPCHxAf5Rmj6592z/EvjXbYKnSSg7OPilEoegBwQ==
X-Received: by 2002:a05:6000:4025:b0:385:f1f2:13f1 with SMTP id ffacd0b85a97d-3888dcd4796mr1824519f8f.22.1734095341001;
        Fri, 13 Dec 2024 05:09:01 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514ec8sm7196646f8f.75.2024.12.13.05.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:09:00 -0800 (PST)
Date: Fri, 13 Dec 2024 14:08:58 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Rohit Chavan <roheetchavan@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Prarit Bhargava <prarit@redhat.com>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: gpib: fix address space mixup
Message-ID: <Z1wx6pzVdh0y9w4d@egonzo>
References: <20241213064959.1045243-1-arnd@kernel.org>
 <20241213064959.1045243-3-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213064959.1045243-3-arnd@kernel.org>

On Fri, Dec 13, 2024 at 07:49:51AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Throughout the gpib drivers, a 'void *' struct member is used in place
> of either port numbers or __iomem pointers, which leads to lots of extra
> type casts, sparse warnings and less portable code.
> 
> Split the struct member in two separate ones with the correct types,
> so each driver can pick which one to use.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../gpib/agilent_82350b/agilent_82350b.c      |  4 +-
>  drivers/staging/gpib/cb7210/cb7210.c          | 12 ++---
>  drivers/staging/gpib/cb7210/cb7210.h          |  4 +-
>  drivers/staging/gpib/cec/cec_gpib.c           |  4 +-
>  drivers/staging/gpib/common/gpib_os.c         |  2 +-
>  drivers/staging/gpib/eastwood/fluke_gpib.c    | 12 ++---
>  drivers/staging/gpib/eastwood/fluke_gpib.h    |  4 +-
>  drivers/staging/gpib/fmh_gpib/fmh_gpib.c      | 25 +++++-----
>  drivers/staging/gpib/fmh_gpib/fmh_gpib.h      |  4 +-
>  drivers/staging/gpib/hp_82335/hp82335.c       | 21 +++++----
>  drivers/staging/gpib/hp_82341/hp_82341.c      | 16 +++----
>  drivers/staging/gpib/include/gpib_types.h     |  3 +-
>  drivers/staging/gpib/include/nec7210.h        |  5 +-
>  drivers/staging/gpib/include/tms9914.h        |  5 +-
>  drivers/staging/gpib/ines/ines.h              |  4 +-
>  drivers/staging/gpib/ines/ines_gpib.c         | 22 ++++-----
>  .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        |  2 +-
>  drivers/staging/gpib/nec7210/nec7210.c        | 16 +++----
>  drivers/staging/gpib/pc2/pc2_gpib.c           | 16 +++----
>  drivers/staging/gpib/tms9914/tms9914.c        |  8 ++--
>  drivers/staging/gpib/tnt4882/mite.h           |  4 +-
>  drivers/staging/gpib/tnt4882/tnt4882_gpib.c   | 46 +++++++++----------
>  22 files changed, 123 insertions(+), 116 deletions(-)
> 
[ skip ]
Hi Arnd,
Thank you so much for these valuable patches.
I have successfully tested them on the agilent and ni pci boards
on an amd x86_64 system.
This exercises the agilent_82350b, tms9914 and tnt4882 modules.
Your patches have also fixed the i386 build issue as far as I can tell.
Link: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
cheers,
-Dave

