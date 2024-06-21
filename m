Return-Path: <linux-kernel+bounces-224898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B83691285A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF59B27A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCF6374DD;
	Fri, 21 Jun 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUYC+g9S"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46E14F60D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981216; cv=none; b=GSXgtUsntDmM9AbTkO9b5VpQan/0NY+saO6CEaTbIRRNlAjHUkEYlkVaH6vxjHRs3LXOCSFT1f010rC/gTLaTQPjWp1SLpX/wsX5g5Lk0ymYUHgN7Lw3bJ7CrpntKyM5sDkBv+1IbMsTxzZ2VO4kek+mB5PkUKcAuuWKnPp7ziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981216; c=relaxed/simple;
	bh=LuDV1jit+LzHW/FnOB8Sm/385vZGIBsm1cA9SJgn1pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ukc8SzFfRF/Tc72TzGzAigIf6uSnDEinhUO5xPL8O1MoW43x8uUwn3V++XZXIg2EVq5AdzkOTkD6D4Zq4pzUYMRq9EZNHtrBTFp10tYsS/rDoSoaDcVmSmAd1gA10hYJqfRCKfuZS9bQpWzPT5UfMy5NU2nUiRsWxI3x6h7oKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pUYC+g9S; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3636c572257so1915704f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718981213; x=1719586013; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DBkwuvx+qzIcwOnXOSKtVB4mU9IrbBnzcqFsSbdvXpo=;
        b=pUYC+g9SCw4/qSSVy5C2frrd67q7sfJ10/sZw7ziD4qv4d1Y8BAmQR01dtEICWZm8m
         EC0sMR6gonll4ajWSiQVoogo5XMKoLZvlDINK0XS+GGzl3GyGN4HAR7Jilp1ECj0qFAs
         sFW2C0ZVEpJmGtsKDUZ3HCr4DqmLMwow5hYjEkBOe4oDTall/uSEftDxTl9x3BV/CC2a
         2xRRNhSIzf7LYqG3zz14rsLL2Xe8BTR0WUJWsZ++vHJTXcYskv4BYHcR3zz6/MOfkipg
         PZ1+n60SRiC9iEaYYakCGOYdxS2ge9zHlZzzFCx7HUVJxWZqb4dMYuy2GJjJXsrId2CV
         GEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718981213; x=1719586013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBkwuvx+qzIcwOnXOSKtVB4mU9IrbBnzcqFsSbdvXpo=;
        b=gCb977+By4Ql/zfDCiWWQhneZTzyYzHQ5MwAbeH+DMFCS8ahk1QnXXOV7noMNtkf25
         kbidIK5gjo9qMKj1nB/ux3QD5ew1x4enXOmjING/daW9rS6QI87e2ujGOHLX4XX8Kzo0
         p6VeHNMEpHvNRcRa81ysja1DoYUD4xQo/5+sgmUtvQeaWnJECpoWlvFtrpooH7t1Rld7
         /jqJmdV6ZTBY79UnudM3jq1cW3fYnPqiRZtSBi1m5l8xAvFJCaO5KEZbwTg9iSBcvugd
         9Y4kRwTcwPXGKfZHXPrsmayhS/I+G77Jgfy3bY9WCg/XZsXgctgHa/ok7fHB6Sjr4w93
         33RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE9Mr/ku/fsc566C8SCAK89WqhakeCklCvl+c+DHP2nV4rGF/kd122+0hE4iw9oxLfXRuPkCc5LXoCBvoj7lOXoFp+s30eMtNFeF04
X-Gm-Message-State: AOJu0YxnGmNjC/2BwbA3dW1ddit9cfr5GjbPfF81GXv1CD3DrW+2kJSq
	J5E0EbZhieFzHCsSJxzv2DQRIna4Za2H9ailXSRZAC+uBrJwMc/QjypujwmjOrM=
X-Google-Smtp-Source: AGHT+IFuaYVvQQ5U+lob8+mammMMATTKb0eN6b3Bkn7maKlnKEA90KDPdKc5TSvOFx3y9exnTmabaw==
X-Received: by 2002:adf:fcca:0:b0:35f:2363:e4fc with SMTP id ffacd0b85a97d-363175b8fc2mr7663280f8f.17.1718981212841;
        Fri, 21 Jun 2024 07:46:52 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b63d4sm67564025e9.3.2024.06.21.07.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:46:52 -0700 (PDT)
Date: Fri, 21 Jun 2024 15:46:50 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Zheng Zengkai <zhengzengkai@huawei.com>, jason.wessel@windriver.com,
	pmladek@suse.com, christophe.jaillet@wanadoo.fr,
	thorsten.blum@toblux.com, yuran.pereira@hotmail.com,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] kdb: Get rid of redundant kdb_curr_task()
Message-ID: <20240621144650.GC285771@aspen.lan>
References: <20240620142132.157518-1-zhengzengkai@huawei.com>
 <CAD=FV=Uw4-czLekDJ1aU55Kxb5NeXVufnpo4fYy9EwQ-KUqDCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Uw4-czLekDJ1aU55Kxb5NeXVufnpo4fYy9EwQ-KUqDCQ@mail.gmail.com>

On Fri, Jun 21, 2024 at 07:36:49AM -0700, Doug Anderson wrote:
> Hi,
>
> On Thu, Jun 20, 2024 at 6:58 AM Zheng Zengkai <zhengzengkai@huawei.com> wrote:
> >
> > Commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> > removed the only definition of macro _TIF_MCA_INIT, so kdb_curr_task()
> > is actually the same as curr_task() now and becomes redundant.
> >
> > Let's remove the definition of kdb_curr_task() and replace remaining
> > calls with curr_task().
> >
> > Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> > ---
> >  kernel/debug/kdb/kdb_bt.c      |  2 +-
> >  kernel/debug/kdb/kdb_main.c    | 18 ++++--------------
> >  kernel/debug/kdb/kdb_private.h |  2 --
> >  3 files changed, 5 insertions(+), 17 deletions(-)
>
> In case Daniel picks this one up since it CCs LKML, I'll copy my tag
> from the one that didn't:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks Doug. I was literally getting to it now!


Daniel.

