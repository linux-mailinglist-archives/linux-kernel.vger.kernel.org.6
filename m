Return-Path: <linux-kernel+bounces-311982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 244D996906C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573BD1C2185A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 23:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB54188598;
	Mon,  2 Sep 2024 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="SjReh5Bw";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="tb7gm+FZ"
Received: from mx2.ucr.edu (mx.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5F41A4E8D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725319745; cv=none; b=SByyvhNIbwSHCkmnCjQGH+VLeb/7sy0mcerRRQLsjOsLsYBamgHNTQ6ka4YX30lPJ1z9Nx3VJqhkbFn02cQx1k38K+69A0ZFsKUg+tCt4SioUGg8fMk1BZSGCcxQAyMcfYBp6tqGcNflSxVbj8qFx9eZZBIVw+CZp54CY2fqtqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725319745; c=relaxed/simple;
	bh=y/F+/GgDvFvcwrmUg8pbztRfV6eMm2E4eLzjHVuP154=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTsv8MOzCszCDioB9lPWf4UeDqTb8jlgI2JHP2z/qXDf6wD8dMNpNOLPJQxfiB65ZDJV2sD9dx0sKPNOiLbu6/xa4xrZqvFfKZWSCY5P1vYl+5bsgsQIRJIA8IF0zaqUh3SpES5EspBApgCnIxPq1r3j5Q5lXskmPT27klysFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=SjReh5Bw; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=tb7gm+FZ; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1725319744; x=1756855744;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=y/F+/GgDvFvcwrmUg8pbztRfV6eMm2E4eLzjHVuP154=;
  b=SjReh5Bw+A+CFOLptJ9HIM3HAdACEIOjV77BF2ebEsyC/yeaog4Gei2T
   OrUtPR9gC/v5F8LPCTN7F/37MlYhIplSWc1sJa4S/9t6k+r7DBpMG3dxz
   7jhEoEOiKC80n1qWycKusr15blDxOgrblOq5Pk4Q86zRboRO+8O4TauFj
   ZRVUR+O2o00597dKc/U5XrVSW0YwqrVE+VXNCFSFinPxuL0ACfHLBxzVo
   uxgq2KxaimSKbLLDoA2BQHEH8ctLm/KHLnFYgWIAFE+0CrwaRLmW/dBU4
   xvhvXgiW9TlrrMb/JVQrGYxAJ1N6TExXaKwVFn+NmVVSxGKXCM8b32uL4
   A==;
X-CSE-ConnectionGUID: vZH/1ODwQq6XG0bTWPBOtQ==
X-CSE-MsgGUID: FClsCmUeSFuLAVQP13qnRg==
Received: from mail-pl1-f198.google.com ([209.85.214.198])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Sep 2024 16:28:57 -0700
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-205529040cfso20322105ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 16:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1725319736; x=1725924536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLMDgI8GS+FF7I9fYvOQkG+Kp/ZhUSqDaKg5U8Dcy7E=;
        b=tb7gm+FZDFBqLA9kKugVlEBESYqqN2IwJTnUYM4i0SWBFLB+4lFoRF3aa+OIcZPrS9
         J2bEggErOEhfTV42ZEHxfIhHN2k5AKhJlTKE02SM9sRZO98IbVN1xAKZDdgEAsT7uIE5
         NLmUW9Fhe4Cn8629GxZE94pz1kUgJsutXL53I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725319736; x=1725924536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLMDgI8GS+FF7I9fYvOQkG+Kp/ZhUSqDaKg5U8Dcy7E=;
        b=l1WJV4oJV1p+L55N6satWBG8423M1gJ+wpNS7N9nY59dGHZNMi7jZlg1yEjYR65Ktq
         u5QA/gKP6qtZKL4EInlciND3QTAdD7J+bbP5sdCakSIa97a3JUOgXYisFabSRkmpzE0y
         23sqPRX+uYZXb4tyOlI7ObJy8sf6buT4vuyqz54MlJpt0wTyIpVdx9veE1RGMBWvfN8W
         MJYAJx1XMy/6I1KLu1oTGOfIFyK7iLE8eMz3PYOWkC52nbx2l2BYhEzu6kzKfanVJzUN
         EqgfoJphn7XK7e3jjsxGTfDAQUnvvow+oCXybkNNJ/iJxjYOKmuZ9UfBgbKbdLuerb1U
         WFWw==
X-Forwarded-Encrypted: i=1; AJvYcCURVCknk4R1aHALFLWnwcVOZkMbcRzQOKm592cLZU249/SFVSzbdgMIaZDqVU08Sh/OCzsOm6/duPBbmGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqF6+mRJHTIi9FYhRNMXbcJH/IzQFJm+jE6tzXZv7zeaOpzGEL
	EBXvXfp5/nwID/N6B/5neGmzAg9jml6lFngZRBMeMRM6IPMzzc5JEumFZLyAilF0c3ySAX/TSuN
	TvcDjimjrHcNINngQv4WVqAj9hi+8iFMUmj1V2FIlOloRAKPzvaP5hE8KAnYgN74wGFE6z4cHUq
	tD9C+iISb+VQMylgSLXuwxfqmWttd8GkhIxswdYKOLqnlAjg==
X-Received: by 2002:a17:902:ea10:b0:205:7b04:dde4 with SMTP id d9443c01a7336-2057b04df10mr40410975ad.28.1725319736463;
        Mon, 02 Sep 2024 16:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+if6RDEgkqjk2GPCCGVm5yKBRP+2fdWP115HjdFhiFeqL1LrTMbBy/bdkO8XbYJXoiAR34q+JUs6voX/9JHI=
X-Received: by 2002:a17:902:ea10:b0:205:7b04:dde4 with SMTP id
 d9443c01a7336-2057b04df10mr40410865ad.28.1725319736071; Mon, 02 Sep 2024
 16:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-7TsMdA7rjxfpheXc=MNqikEXY9TZNxJt4z9vm6Yfs5qQ@mail.gmail.com>
 <87frqi76ns.ffs@tglx> <CALAgD-6MwUxVzN9Q=U5qBNnhO7tUy43dnT==Vh=TbJ4aCZpsgw@mail.gmail.com>
 <871q2163ov.ffs@tglx>
In-Reply-To: <871q2163ov.ffs@tglx>
From: Xingyu Li <xli399@ucr.edu>
Date: Mon, 2 Sep 2024 16:28:45 -0700
Message-ID: <CALAgD-4jwtynur5hT2N53_y-dA7j3fYM4im3VhptWOC_9xKFVg@mail.gmail.com>
Subject: Re: BUG: general protection fault in __free_object
To: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please see here: https://github.com/TomAPU/Linux610BugReort/tree/master


On Mon, Sep 2, 2024 at 4:22=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Mon, Sep 02 2024 at 15:55, Xingyu Li wrote:
> > This needs the corresponding
> > kernel config, the exact kernel version and a description of the
> > reproduction environment (compiler, qemu command line ....)
> >
> > As mentioned, it is on Linux 6.10. And here is the config:
> > https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
> > It is compiled by clang version 14.0.0
> > (https://github.com/llvm/llvm-project.git 329fda39c507e8740978d10458451=
dcdb21563be).
>
> You still fail to provide the reproduction environment:
>
>     - qemu version
>     - qemu invocation
>
> This all matters and I don't have time to figure that out myself.
>
> Thanks,
>
>         tglx
>
>


--
Yours sincerely,
Xingyu

