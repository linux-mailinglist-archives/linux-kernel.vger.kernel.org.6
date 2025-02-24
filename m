Return-Path: <linux-kernel+bounces-529009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3EDA41EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31DC178BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7519F233736;
	Mon, 24 Feb 2025 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKSs7pgA"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E893221F1C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399444; cv=none; b=qKMVjuaEFXXDHFQIxNqldLP+5i/egMULT10SjzNA19djvVCxw6gWnxYgoGIqDTKnchlg2OX+FKyQyuO/D9Ib0PIU6N/B+oALlLem3zlnW2LAd0VmqRr70PJ2zLPPY24RVvM9zBiYSXSM7JhwHitRA/XrKOjGe8R6P+nNc3uMHPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399444; c=relaxed/simple;
	bh=i8BCyQZA2KjDPBQrmOPrvK++2JfiudfMcGh50LMt8rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUdq6XfxryEgvMP/A3B8AD6HnJ8aVW9cOvx0eKfxP0NV75JyCStAP22RKb9tRwiAlHIb6G0pa7WFSVVbyN4xopnXDsNwVAMkyQO+tZVDMfxP2nsWwzv8eXySNgP6aJvHd1FQailmdPQYkSRnvDDPnchsEER6iac+2StYN+nf8WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zKSs7pgA; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e549be93d5eso4571468276.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740399442; x=1741004242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vMvNtutvHMAptcP5aSgqQ3Rpg3q4pARtFCm/FUX2MJY=;
        b=zKSs7pgAQlNBQKzBg4QNmOiooFNHSRO8eOfv3qR1ZCdkKrGtB48apN+tRZ2QFuiPY6
         1HZ/Fg9jPa+nBsU8t7g52yTMgRpszAaOBn2cu6KzDR1oadlQW9UrHbtCxBFVRsFjaWeh
         /DOxuiu2NSOcOH9o4eyY5bLxw/BMoyMv+ci0XpQMdvxnHAbB4b943RUcoTnyMZfpiViF
         KWIe3VWscBSQ6KNEzPdAEuyawoVoxvAe7oege/GtS51drCTScU7Dhpx+x4Z6El/P8tQU
         cl7AXjmK1nnw9ewnuRKuYJExvob3kmy+wzahODKe/r5Aq5BHIVRw/nbm9E6UlIlyUzX+
         aAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740399442; x=1741004242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMvNtutvHMAptcP5aSgqQ3Rpg3q4pARtFCm/FUX2MJY=;
        b=kJADH8Nq4VNNgE2I9jPN1pXd7NLJx5LwNRME5z9PY7ycfgQVMSJtLYr/bDIhX+mkis
         PEglYEHT0YxD7VGxDG1O9SFaZwvu2hjqu+DCrhGvdtldvL2bJ+mPKEilDf/APuou+4aH
         gNHyt5bZ7MimVGxK/NY6D7wJJKuFiz/MAGh6ijiLgnz/dIXfaAdgc5Wctlr0VVNTx+23
         EXCvy1rTzXrHmME6jCzB67jSSlSi/2RI5uUCZneEqKMrsjbdJuMy3qNZXAMs1vB3tJKi
         vSRaMztoIPn6GNJL6bsXYFfliC027vZEPXo7SrFDMiBvuhdZcIvVDe+w8KQTkZUYZiLf
         2uIQ==
X-Gm-Message-State: AOJu0YwywlQwjMibEmkqis+e7yQf+3306/7ype18D1PC0ljpO/Y1HLLg
	qzE19WothqEx4/LkadAsNtwGDzZL2b1qeMK6ueTfXjKjCXqzEyHdgiuuHtKYlIV380s17/gZYLO
	kuXEHJrEKe7zg3EjJChZnhqNgPGiqNY8Smo2O2A==
X-Gm-Gg: ASbGncu2Xds2t20/lzmkRUcgTS1iOcQVjh9WujDlBlwndvsx355HCqUcgdwIcg6c/sQ
	ynPUazzOF4004jbYzwfLzk7H9vzAlPOL5sROiGpBMVp25w3QzLMA+neGRaM9ac5xxob1Xx8+3q0
	SB1paDXwCa
X-Google-Smtp-Source: AGHT+IELOk5ZXAqmoOudEZqUSDKLpqR/4L/Z9SA60povjeh84JPDLDRKCUYn0cTHIiydrsnhjz9f0XWowWtSem6OafA=
X-Received: by 2002:a05:6902:2845:b0:e5b:3af0:d4a1 with SMTP id
 3f1490d57ef6-e5e246880f8mr10067451276.40.1740399442088; Mon, 24 Feb 2025
 04:17:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220113338.60ba2290@canb.auug.org.au> <20250224122318.228f695c@canb.auug.org.au>
 <20250224162048.7806bb1d@canb.auug.org.au>
In-Reply-To: <20250224162048.7806bb1d@canb.auug.org.au>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 24 Feb 2025 13:16:46 +0100
X-Gm-Features: AWEUYZksBg3IE74M1moVSjQJhnuSmrxpg_pv5byEOd0zI1JVF6jP9rg_85gkz_M
Message-ID: <CAPDyKFqBwari-MoRefG82kbxovVaLt3ewRVFihHoLbrOSWSnMQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pmdomain tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 06:20, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Mon, 24 Feb 2025 12:23:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Thu, 20 Feb 2025 11:33:38 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > After merging the pmdomain tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >
> > > x86_64-linux-gnu-ld: vmlinux.o: in function `rockchip_do_pmu_set_power_domain':
> > > pm-domains.c:(.text+0x19aa103): undefined reference to `arm_smccc_1_1_get_conduit'
> > >
> > > Caused by commit
> > >
> > >   61eeb9678789 ("pmdomain: rockchip: Check if SMC could be handled by TA")
> > >
> > > $ grep CONFIG_HAVE_ARM_SMCCC_DISCOVERY .config
> > > $
> > >
> > > I have used the pmdomain tree from next-20250219 for today.
> >
> > I am still seeing this build failure.
>
> And now that commit from the pmdomain tree has been merged into the
> scsi-mkp tree and so the build failure happens there as well.
>
> I have used the scsi-mkp tree from next-20250221 for today.
>
> --
> Cheers,
> Stephen Rothwell

Stephen, thanks for reporting and sorry for the delay.

I have now fixed the problem on the next branch as well on the
immutable rockchip branch. Martin, please pull again.

Sorry for the mess!

Shawn-Lin, no need for any action from your side, I have taken care of
the issue.

Kind regards
Uffe

