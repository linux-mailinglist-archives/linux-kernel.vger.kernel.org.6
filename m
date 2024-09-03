Return-Path: <linux-kernel+bounces-311990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DF0969097
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 02:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C522840B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D869E80B;
	Tue,  3 Sep 2024 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="UpBWR/AT";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="KfkNL15+"
Received: from mx5.ucr.edu (mx5.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F2A195
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725322229; cv=none; b=Q94jVEaT4imXlrl3c3DWDNFrnUSsDZpnmx/RmBsUu67r6siC/uSCjj6wafg3z2ZNivQJNjTniMMiqLBNUpfo1BdGIIDRuuZk07HgoirlchdDoSeIsFBdXpA+5Xq0BhJCFWOwzBt2HLu+8xm8/ci8n+BQ0h1fSpP+SxLtdQyQ3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725322229; c=relaxed/simple;
	bh=TP4gJbbnoHDGxHy+QdObbCvvzCQDy2Y35KZH8HI8+y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoYcJaTKNEbZU8X3JBLmv2ae6+tdnrYVK2mGFkUb2PAhtLZFwEqxx7OHvgx4p7QgnmuAyLC4ji2fn2QGu7EvND/3nLYJtKdXHMQzcnDRjYSPYN/WWFUncplP54BZWuSF/sjlxLTtDPbXKyYL54Qs09LTQ60eNaIlkyrkknDadRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=UpBWR/AT; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=KfkNL15+; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1725322227; x=1756858227;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=TP4gJbbnoHDGxHy+QdObbCvvzCQDy2Y35KZH8HI8+y4=;
  b=UpBWR/ATjKARhBe9TksXAxvlgg/CpMEEOh6L/kOoyHGULDUUybZBDcmE
   WGbAt2EiN5IKQE0ojwfSeoYFC/3wnCn+37sGqq75D2OpOtV6xAP8e/UxD
   y8jZUZYz4WggOogYTYvtLK0NkQdu19Z1AOkMPVeZRVi+Co9a3lc8BKhmS
   nE3CyelBPsep+/8dkbH3Yk2mdnKLCLULWZ9vVNstEZjvKHb5PipDQ4zt+
   Ls+VhCXsxRXGJW8ki5P4DRxogxYXgSrlZRvZad2Ruso7l5NrkUKjwl7bI
   Rf0ou50vTq4z38OEmqIWHtStMp/M2AHhKaKNjlanMHEsGO37LDAY9D3hR
   g==;
X-CSE-ConnectionGUID: k4p25HZIRv2/LYYRROGrVQ==
X-CSE-MsgGUID: uDSYX0zgQvqNt8cQ/B6b/A==
Received: from mail-pj1-f69.google.com ([209.85.216.69])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Sep 2024 17:10:21 -0700
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d9a2b8af50so601456a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 17:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1725322221; x=1725927021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGvYwO44csENz7/cJfzBYNaUGUCiFEyNNrAyQ1H9aTw=;
        b=KfkNL15+Kc0VuJ9dtuf0YxqC+bjWDd+16SVKSbfF3XclTSrE5bNogG9YvKcFOIaIHZ
         TrCovxx0z5a1MJQkF67wuP7YyYzmGqmrKd3q3nxNnv0F2ZsN1OcksQtxO0eeqkAbRWqT
         0XMrNSJmPzJiabEicltfO9xVQb20QHxVBnkKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725322221; x=1725927021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGvYwO44csENz7/cJfzBYNaUGUCiFEyNNrAyQ1H9aTw=;
        b=fVUd4S6J2rI5DgzvHq3CMa5I5HMhsi3cRmWStvrf0RLWJ77ay+P+FfATDiHKvsrT29
         XaRALZ8e6R5EiXM4ebSl3y935YcFzYyFHSKKlv/BUo/cQq+A0IXXBHxOM9dbXTAnWKQF
         a41qFEA03BM4zQXxR62JoaVFNDANz3Ptr0IlAqUG5PmX0kt035VwJKJa5CpP9CYwmehO
         brhlceileAmeVc2Ypt18HvrD1qWmwWWbW4dYk6UuolCsExHhnpgHndNSpq4uRFSFXCdp
         iak9lARs1hpPeyBpKRusMfsEkWHPNSl0xHASwX2yodVX33zPBoDtnVjTcwrNXMUAhZEr
         MuxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSB0aR6x/gwdsozqB35QayR+/I9CVSQlysvy7cMm4yL8EE2wedhAxQ4GBmLVVx16ZD/vrlV1lrjxz2n1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjEvJ2fgvFdmkPvXWh0sgi0bs+U1PGXvIszrofB2FOvNQZvmrk
	aW85aTlP/nzyCQAW6MOD1ra+gVVlJGlVJ0HUt25DVHGW1SihrP9fA6pJW6B/Y/ALEbCqeTlr6+D
	xNy23It+7u6ha96BOlpQGNsKJLwkgVw7cl0Sk2BylauV/xgd0CP1S9lke6k00YmRn0HuAjRTzcl
	JvjL8yQHkw30QOH6BRL3GqtuC2T/4c1guAyNAf/Q==
X-Received: by 2002:a17:903:1c8:b0:206:9536:9778 with SMTP id d9443c01a7336-2069536a0f5mr6554125ad.19.1725322220831;
        Mon, 02 Sep 2024 17:10:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGf9J+u1fmfHhxDxKgnGKqFL7hgR7c68E01OWe3sV/RwyZR4n6eBttyE6TfaJ1Fsadfz4NZuQL3dxB1Vjqddk=
X-Received: by 2002:a17:903:1c8:b0:206:9536:9778 with SMTP id
 d9443c01a7336-2069536a0f5mr6553945ad.19.1725322220474; Mon, 02 Sep 2024
 17:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <draft-87y1494nw8.ffs@tglx> <87y1498uq1.ffs@tglx>
In-Reply-To: <87y1498uq1.ffs@tglx>
From: Xingyu Li <xli399@ucr.edu>
Date: Mon, 2 Sep 2024 17:10:09 -0700
Message-ID: <CALAgD-6-f4Dax=iiC8_J9Cu-ztYFCAhXSgQCQMTt2nv4Hfe3pQ@mail.gmail.com>
Subject: Re: BUG: general protection fault in __free_object
To: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

it is linux mainline. We already provided a link to the linux that we
used, on https://github.com/TomAPU/Linux610BugReort/tree/master.

On Mon, Sep 2, 2024 at 5:08=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Tue, Sep 03 2024 at 01:49, Thomas Gleixner wrote:
>
> > On Mon, Sep 02 2024 at 16:28, Xingyu Li wrote:
> >
> >> Please see here: https://github.com/TomAPU/Linux610BugReort/tree/maste=
r
> >
> > Can't you have the courtesy to provide me a consice anwser to my
> > questions without making me chase a gazillion of http links?
>
> And you still did not answer my question whether this is still relevant
> to Linux mainline or to the latest linux-v6.10.y stable tree.
>
> Thanks,
>
>         tglx



--=20
Yours sincerely,
Xingyu

