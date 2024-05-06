Return-Path: <linux-kernel+bounces-170189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97CF8BD309
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343701F22B4E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB15156C5E;
	Mon,  6 May 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="B1kgrnh0"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5BE15688E
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014034; cv=none; b=o9ZQrufmvVjVNniMbjVE6xrpgpNsb0WgcJkubmcxLB+qeGZX3agdIdEjHkAcSdZ1R8Qct8jLzDb/EtFUXITBQo7nEqlnK3/LRIY+XLGVwUbLoF4imT6JmTtempX2lsXf7LdCCAkNoaA3grJxzLQkK7uX9u9lw56lQwlHZFKob5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014034; c=relaxed/simple;
	bh=ne0VrpciWO44fCdFNq8qPNWA+XkpPJ7XBbp6hOq5Wek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PE8huWv7Vl4DtMUQk2fys2AtSDB5h36quoX678UfMVnRtmGzEyCc6z6Yx7m9Kt9l7gvk0so7dOqa/BkO7QaLoc5t0OTblNc1mS8dOSgsRyCTIoLmlK7StL326hN0rgfyfXZ+E2nSQpwZmCwS+4Tp27t8OBC7tKg+IDCjiqtTSKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=B1kgrnh0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9E18C3F298
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715014028;
	bh=lBDhS1Ebaa+YuFiVFmddrCNWvRnay3hvunupCOY2htE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=B1kgrnh0btQfBa8NnAftPhEln0cGKwyH7xtRfUIJhKu9aLkEMZWPfqoGwmfqptbcc
	 xxX/JZSvndj0Sb7xztbjmm6bXx4tdK2XnKIKPoePQzP8s8Epc4mt01g8qZZaD8sb3K
	 HLtZNIrGJ7axOEhQVOvatxGmwaZ89aqsZ3OR/yu18kE5aZnD48Mje6JN98d+IFHdiv
	 jQ9WVhjxVvh3UkzwBdSwaarbp+6elxW/5/Kg/asOAMDyOnI6fUy7Pyn7LNdKXcE1Wr
	 HN3fxmf5XD+5J12GBUDzE+9k1UztPb9LER5C5CPVIgaywMZe9yZ2e/sR37gXMZCKsV
	 jr8eyL6IRplYg==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34da8f1bf7cso1777790f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 09:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715014028; x=1715618828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBDhS1Ebaa+YuFiVFmddrCNWvRnay3hvunupCOY2htE=;
        b=M1OEJ7gH+AmcvjKqM/u7rls2fyZI7+ghrQuZfJqAASyYjQbylLqSnHFw9TfELyCBlD
         sOj1Y/hGqv959XYbDJPt8r31OmN5kOj1g0KTjZTutjDdCCItZwoD3b2cZqDJjMWvDsPf
         rFByjhiF0kXO3NT/o+WPCIINH/qqCCoiXGYx4zs1OR7N2lDay6GanPpnaDhnHN3AbUpI
         ac+4t1mEUGexhaN5YTNdyJrXTfftacoawEO63LAPIZQhbMpYCZYmT8x7PexIsmPLy7uG
         Zn3OVQlyOck8I2E3D6uIBxh4wjCIQu/55bSxQWgghcXOCkINvJdBt/XI11aFxhX9QnsC
         GQpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX55dJN9qMJVQ4JLNYet5wO5BvC1gdmAQgqSC3WKcqIeYjCVPOQZERLdcDfKYbTUeyfoXP59phgJdlxVUxqu7sJ1KSeNqKo8f2I0WnH
X-Gm-Message-State: AOJu0Yz5hcnZdR/yw9S/dFQbcAPDtOlHOzmFR8yGOR8m+8Z55/zcgBB4
	OkAUtKA4KZCxuMpffpTOldfa9EKNNRRQgd7eMaZ/AYTuUlT7MKMyiS255YPyiLoa9LErYcSY76x
	Kjh8C/SPlWP5LIvw3xiMrOjmL/6SksD3ch4LWDW7aYQSMWPAVBHUv5jD3PZN2LRVs6fKo9V9cQY
	7T2SnGF97xDRGAaFi3HuHKATJqGVkkMjLis2I6J0b/xl8ZjIYptzNq
X-Received: by 2002:a5d:5445:0:b0:343:6b09:653c with SMTP id w5-20020a5d5445000000b003436b09653cmr9213441wrv.43.1715014028040;
        Mon, 06 May 2024 09:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELDM24XgpFlJfKqTrie0KzqLju4QkFgMrMwyxkhc8UujUz4TrH5RzyaUIOGAI1gDgrRnTn9pHTWWPlV8jlkw0=
X-Received: by 2002:a5d:5445:0:b0:343:6b09:653c with SMTP id
 w5-20020a5d5445000000b003436b09653cmr9213423wrv.43.1715014027737; Mon, 06 May
 2024 09:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503101824.32717-1-en-wei.wu@canonical.com> <7f533913-fba9-4a29-86a5-d3b32ac44632@intel.com>
In-Reply-To: <7f533913-fba9-4a29-86a5-d3b32ac44632@intel.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Tue, 7 May 2024 00:46:56 +0800
Message-ID: <CAMqyJG1Fyt1pZJqEjQN_kqXwfJ+HnqvW1PnAOEEpzoS9f37KBg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 1/2] e1000e: let the sleep codes run
 every time
To: Sasha Neftin <sasha.neftin@intel.com>
Cc: netdev@vger.kernel.org, rickywu0421@gmail.com, 
	linux-kernel@vger.kernel.org, edumazet@google.com, 
	intel-wired-lan@lists.osuosl.org, kuba@kernel.org, anthony.l.nguyen@intel.com, 
	pabeni@redhat.com, davem@davemloft.net, 
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, 
	"Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Content-Type: text/plain; charset="UTF-8"

Thank you for your time.

Originally, sleep codes would only be executed if the first read fails
or the link status that is read is down. Some circumstances like the
[v2,2/2] "e1000e: fix link fluctuations problem" would need a delay
before first reading/accessing the PHY IEEE register, so that it won't
read the instability of the link status bit in the PHY status
register.

I've realized that this approach isn't good enough since the purpose
is only to fix the problem in another patch and it also changes the
behavior.

Here is the modification of the patch [v2,2/2] "e1000e: fix link
fluctuations problem":
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1428,7 +1428,17 @@  static s32
e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
- ret_val = e1000e_phy_has_link_generic(hw, 1, 0, &link);
/* comments */
+ ret_val = e1000e_phy_has_link_generic(hw, COPPER_LINK_UP_LIMIT,
100000, &link);

Do you think we can just add a msleep/usleep_range in front of the
e1000e_phy_has_link_generic() instead of modifying the sleep codes in
e1000e_phy_has_link_generic()?

Thanks.

On Mon, 6 May 2024 at 23:53, Sasha Neftin <sasha.neftin@intel.com> wrote:
>
> On 03/05/2024 13:18, Ricky Wu wrote:
> > Originally, the sleep codes being moved forward only
> > ran if we met some conditions (e.g. BMSR_LSTATUS bit
> > not set in phy_status). Moving these sleep codes forward
> > makes the usec_interval take effect every time.
> >
> > Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
> > ---
> >
> > In v2:
> > * Split the sleep codes into this patch
> >
> >   drivers/net/ethernet/intel/e1000e/phy.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
> > index 93544f1cc2a5..4a58d56679c9 100644
> > --- a/drivers/net/ethernet/intel/e1000e/phy.c
> > +++ b/drivers/net/ethernet/intel/e1000e/phy.c
> > @@ -1777,6 +1777,11 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
> >
> >       *success = false;
> >       for (i = 0; i < iterations; i++) {
> > +             if (usec_interval >= 1000)
> > +                     msleep(usec_interval / 1000);
> > +             else
> > +                     udelay(usec_interval);
> > +
>
> I do not understand this approach. Why wait before first
> reading/accessing the PHY IEEE register?
>
> For further discussion, I would like to introduce Dima Ruinskiy (architect)
>
> >               /* Some PHYs require the MII_BMSR register to be read
> >                * twice due to the link bit being sticky.  No harm doing
> >                * it across the board.
> > @@ -1799,10 +1804,6 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
> >                       *success = true;
> >                       break;
> >               }
> > -             if (usec_interval >= 1000)
> > -                     msleep(usec_interval / 1000);
> > -             else
> > -                     udelay(usec_interval);
> >       }
> >
> >       return ret_val;
>

