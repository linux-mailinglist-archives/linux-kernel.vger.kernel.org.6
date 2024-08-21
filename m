Return-Path: <linux-kernel+bounces-296165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A850D95A683
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FED21F23CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1480175D34;
	Wed, 21 Aug 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MxRHrxwH"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2116EBE7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275422; cv=none; b=qBwIuG/7TFGZ1p3m7cbdZmt1wh+wKl2QKPzih0nK8yvQTc/ExKP4QBGqmw21nYv8V4vDlSMyRTn+wg7DZ64UQN5YeVQyY7vD+m3WgxFkNnRwHC9oH2kiHWYItxtO38WyGnXWG7VeyIQ6otomd8jropovmET3FVJqxfR4d59SdHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275422; c=relaxed/simple;
	bh=06XfuB6+MpXx4jW/NwCvJBpc8sUCcEjxtgVv5Fem5ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKWR+US5uzEAyMxBWwFrjE6Q5e7Gtw9RCBIbujwAhPCynSBrxzc4WKeaKpIcfsG+kmLp6M53TGIIGtNu+YFcj2iES3GBCDMLkNx6Qr/KbzVicx1MoZsLtbxERwMrfRegiiomCUKgRDryBMBoGdGI/zlK32jvSVLhJEwTuthr7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MxRHrxwH; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e115c8aa51fso185773276.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724275419; x=1724880219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=06XfuB6+MpXx4jW/NwCvJBpc8sUCcEjxtgVv5Fem5ss=;
        b=MxRHrxwHiuINOa3zOQVfoBRGLTCiFIwOKotd5QJmnMRxoVS3Mf3ZkzadGNUeSRhpv5
         KEEDt42VQEFx0r2isFm2P6aK8UEnsvrM5w/j5xG76FamNW9gU8kE38FfzPisjyAI9saK
         M99FqA3GcZPdDyB/yCBO5ETqO+Yx6XbjmExTesmrPR0t+YFG90iF/odwbpEw5VXWuN0q
         XR3zKYlMpz1ijjq1dkbXEwjVOLRG/zqpY6N+dauzev2FKD/jXLXmA0sBhmqKOSrNVBAZ
         MaGrBLDU/5UP5jWIOdTn/cKfw6pqaq4RCg5D41sHReNiv7+gOE79Dmwxds/XyIaZPGlm
         HcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275419; x=1724880219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06XfuB6+MpXx4jW/NwCvJBpc8sUCcEjxtgVv5Fem5ss=;
        b=lCfQceCsjvPPjkeEQcEF2jlr+bempNmjZcHjO2ln1mCB1ye8byh4W4bKzT3fjSA5ka
         bvw944ZaybXGliMO7LePpkZy91mMxdJXUk2BwrdYTlR0f0stwcTyVbfagjeBPvtmhAZK
         JwGzKa6Kaa2ods6sQahQTyV7s4eAqH9JZWN68rA9xh0WY3MZLSNB/ix+4o/XviDgKP/Q
         Ff188HBdhpPnOo0TeFDeGcIu4ZhcU5HaMr5fi5AQ9USXC5CWOELdTyCs012cJNsRj1RF
         k4jqIkaaXdEuFzhQERpxs4ozbpbzY1/XIe/YcaKpjoPlgHJHxs3UymIRJlnxkBjIRyW5
         ZULw==
X-Forwarded-Encrypted: i=1; AJvYcCUnjsj7RXFZLsr9lTxyhxvZCRgbNmN844dr7VuZAGKaURwOvmYdTAG0pYgU+Ku5ZgZrF7Vsibb3HRPDQcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo27ntyhwTtbofHz6Dl+W/28ZJwH+4X4/IDiXEGoMiIrrPJ21j
	DgevEOodWo76CRPsnnCiyquVXg6J/dl/G3DNeRrAu4leaRAZ24IIlo9AFMI/gW+eVmYR7pfuEcU
	CEl/MhrkESkLs92Up11aeIRHXNTrGZXibAoi68A==
X-Google-Smtp-Source: AGHT+IEXbBfasg0L51VJ+s3QV0pg6W35UDhcXMQ7PYnH1YM/7uO/Ba/XJW9qtnapmhmS6B3z3oGMVg81ulRaSmD1W7I=
X-Received: by 2002:a05:6902:1583:b0:e13:c4c5:89ed with SMTP id
 3f1490d57ef6-e1666400ee0mr4317516276.17.1724275419451; Wed, 21 Aug 2024
 14:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814153558.708365-1-jens.wiklander@linaro.org>
In-Reply-To: <20240814153558.708365-1-jens.wiklander@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Aug 2024 23:23:03 +0200
Message-ID: <CAPDyKFqBuQ8uUdeThRaJtd2CYNWMmpLCEDxfO+znhwjPamH+Gg@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Replay Protected Memory Block (RPMB) subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Manuel Traut <manut@mecka.net>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 17:36, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> This patch set is getting ready to be queued for the next merge window. The
> issues reported by Mikka in the v7 patch set has been resolved, the issues
> turned out to be outside of the v7 patch set relating to configuration in
> the secure world. I'm planning a pull request to arm-soc, but before that
> I'd rather have acks or at least an OK for:
> - "rpmb: add Replay Protected Memory Block (RPMB) subsystem" by Greg
> - "mmc: block: register RPMB partition with the RPMB subsystem" by Ulf
>
> Arnd, please let me know if anything else is missing.

Greg, Jens,

To help out with the merging strategy, I don't mind queuing this whole
series via my mmc tree. It would also be nice to let it cook in
linux-next for while, via my next branch.

 From my point of view this looks good to me now, but please let me
know if you prefer a different route or if you have any further
comments.

[...]

Kind regards
Uffe

