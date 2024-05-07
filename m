Return-Path: <linux-kernel+bounces-170898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4638BDD8A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0D31F2564A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EB314D45D;
	Tue,  7 May 2024 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vIlyTMbo"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F70D14D456
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072126; cv=none; b=a8q7g5mZm5NtSaThgoYPRXxfzlgUVFNRXc0tDPLbEZmowSy8uSPJTNmMUwYpNu+6rRBq7yVmMTWbTkDSijxbsEm+s1w7svZkuj08GJyHW+4R7h0+fBUc0vpZVRIC/7TRLDXPlXhOk1Ak05gh8mcWqleg968a4JRACsZQm+ypP/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072126; c=relaxed/simple;
	bh=ZIvdSpIfCxhJ1EfFdfeWhD/aMB47HvlZ56AkDlfXrps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwCG/HqVS1cq5KP2ognrlEDTmq0jrkV6t9MgvjsSGBI+2FX4IHzEgs6zeZLKGPAVzR2ia7hkqUKU3fXXhX2aQzMLBav7yEllJmndlAlhvzkon8DNRtwGU+qS+oy3oliIa1gxDaYgVGzZ08uCvLwa5v9Hk9xIkWPDHYkDYOl9WmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vIlyTMbo; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 605E8424B9
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715072117;
	bh=Jo8OYnmn4OC8OiXlkwsI28aekX0eSHBqnnXbWjkcswQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=vIlyTMboQrscpUW6+FZ2088WM6dfkH56BRAbGHuh4dCQ9y7jh0k/eMOpCSius/qvy
	 jdp0sG+8g2J+Of+8ZC12sj5pPWqH64KLoJQtn+W2z3Qw4ruwo88q75VKvxPvte9YG6
	 GAxXKLG76hgXNj+8v0CPDckwY3dBcOaLWbjlEbE/sWO5oNClQfDljSbLwwLfjqYUde
	 RyfjdhNhzAo1RR3uKPDIinvthDcqoIEGyb9c+Npw3mVVP58IoJEqUMIgjseJF272Aa
	 i5qyRgdE93+lFfKLOKc/1PtESt59U9jo10/i/KqgyNjt8/yxOuEGiIVL80Kepa4Ooa
	 soOpfbiLbenxw==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5206ef0d6fdso2097449e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 01:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715072104; x=1715676904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jo8OYnmn4OC8OiXlkwsI28aekX0eSHBqnnXbWjkcswQ=;
        b=pnkCWox/PaDFUGL1tTQtpx2WsMHn+2ENrN6VgTfdtreNEIs/+EXV5+C6HaKm8X/hTJ
         QvPu33f654y1Mx8LAktEhEvMgM2sVHq24k0v506OJsHlAABoC+Q7QgRqwOSrbqHWL4gs
         8lfyT0Y2BSLQrvCIKft27XAqG963xXi51OEzis+Id4sAe//cTN5/VFspu0XUXq8F15Fk
         xMmnerWGws+50HPU2GMq4gPwVOrW2YgtR4fDi8zvbbntMBwqnt8WiGa4VwOzzfpPtHGE
         iYd/QANMpkNz25JW0IZG08V7UWCfKeUn/GdFg1vmxe2YsxsgxrnKe/j+R84J2EfVLZdq
         O9Tg==
X-Forwarded-Encrypted: i=1; AJvYcCW3/Bd6/aKG8AxI57+5fAzTPYTxWItBQeKkEx9bH8AQWu6JbmX4tHL3rSQg6GVJUjs7gKcUiEbURMTB2fTk/QvNFTKvrB3edW5ViO4+
X-Gm-Message-State: AOJu0YxRSKtoBAI6Ep4JDDR2PEv2DB+6U5TQ7W1jyaOFoxGnzTxbMAUo
	DgVRHFMHTmnlWHlzEah5QcHHPl8tn+xhizRy3Iprccym38tAzN+JwBrRrjQ/ONtz3xbTWAmh3aP
	wtxfB0xHvu4uR426FDDCPMqD/DwHabs3mAkcrdBJ33MVwwMN+0rJ/QpCuSH+9QpRHfYZFyypLHy
	4qqyWIZj4N0hOZrOkT4nMj9YdBnNWlBVyf7YOeTAG+1Hj78iiYahrn
X-Received: by 2002:a19:5e55:0:b0:513:e63c:cfe7 with SMTP id z21-20020a195e55000000b00513e63ccfe7mr7624856lfi.66.1715072103924;
        Tue, 07 May 2024 01:55:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcHr569y8CXVv1K6jlp8zJO7oa0VJugnPkcRf2d/9ahiU6CQowCeVXshdDc2dOJTtspM4xzmgndcLovNTDPwk=
X-Received: by 2002:a19:5e55:0:b0:513:e63c:cfe7 with SMTP id
 z21-20020a195e55000000b00513e63ccfe7mr7624834lfi.66.1715072103481; Tue, 07
 May 2024 01:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503101824.32717-1-en-wei.wu@canonical.com>
 <7f533913-fba9-4a29-86a5-d3b32ac44632@intel.com> <CAMqyJG1Fyt1pZJqEjQN_kqXwfJ+HnqvW1PnAOEEpzoS9f37KBg@mail.gmail.com>
 <d2d9c0a8-6d4f-4aff-84f3-35fc2bff49b7@intel.com>
In-Reply-To: <d2d9c0a8-6d4f-4aff-84f3-35fc2bff49b7@intel.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Tue, 7 May 2024 10:54:52 +0200
Message-ID: <CAMqyJG2S4yvO-UiCiWydO+9uzOWpeKR9tmMDWrw=m6O7pd3m0w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 1/2] e1000e: let the sleep codes run
 every time
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: Sasha Neftin <sasha.neftin@intel.com>, netdev@vger.kernel.org, rickywu0421@gmail.com, 
	linux-kernel@vger.kernel.org, edumazet@google.com, 
	intel-wired-lan@lists.osuosl.org, kuba@kernel.org, anthony.l.nguyen@intel.com, 
	pabeni@redhat.com, davem@davemloft.net, 
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Content-Type: text/plain; charset="UTF-8"

> Why so long?

> Furthermore, if I am reading this right, it appears that, with the
> proposed change, e1000e_phy_has_link_generic will poll the PHY link up
> to 10 times, with 100ms delay between each iteration - until the link is
> up. Won't it lead to wasting all this time, if the link is actually down?
It seems like making the delay 10ms is more suitable. And if the link
is actually down, it takes up to 10 (times)* 10 (ms) = 100ms which is
not quite long in terms of the configuration path.

> (1) How serious this problem is. It is normal for link establishment to
> take a few seconds from plugging the cable (due to PHY
> auto-negotiation), and I can accept some link instability during that time.
Actually, the problem is not critical since the link will be up
permanently after the unstable up-down problem when hot-plugging. And
it has no functional impact on the system. But this problem can lead
to a failure in our script (for Canonical Certification), and it's not
tolerable.

> (2) Assuming the problem is considered serious - have we root-caused it
> correctly.
The problem seems to be a PHY manufacturer errata. The patch here is a
MAC workaround and I'm wondering if we can root-cause it.

On Tue, 7 May 2024 at 08:22, Ruinskiy, Dima <dima.ruinskiy@intel.com> wrote:
>
> On 06/05/2024 19:46, En-Wei WU wrote:
> > Thank you for your time.
> >
> > Originally, sleep codes would only be executed if the first read fails
> > or the link status that is read is down. Some circumstances like the
> > [v2,2/2] "e1000e: fix link fluctuations problem" would need a delay
> > before first reading/accessing the PHY IEEE register, so that it won't
> > read the instability of the link status bit in the PHY status
> > register.
> >
> > I've realized that this approach isn't good enough since the purpose
> > is only to fix the problem in another patch and it also changes the
> > behavior.
> >
> > Here is the modification of the patch [v2,2/2] "e1000e: fix link
> > fluctuations problem":
> > --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> > +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> > @@ -1428,7 +1428,17 @@  static s32
> > e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
> > - ret_val = e1000e_phy_has_link_generic(hw, 1, 0, &link);
> > /* comments */
> > + ret_val = e1000e_phy_has_link_generic(hw, COPPER_LINK_UP_LIMIT,
> > 100000, &link);
> >
> > Do you think we can just add a msleep/usleep_range in front of the
> > e1000e_phy_has_link_generic() instead of modifying the sleep codes in
> > e1000e_phy_has_link_generic()?
> >
> > Thanks.
> >
> > On Mon, 6 May 2024 at 23:53, Sasha Neftin <sasha.neftin@intel.com> wrote:
> >>
> >> On 03/05/2024 13:18, Ricky Wu wrote:
> >>> Originally, the sleep codes being moved forward only
> >>> ran if we met some conditions (e.g. BMSR_LSTATUS bit
> >>> not set in phy_status). Moving these sleep codes forward
> >>> makes the usec_interval take effect every time.
> >>>
> >>> Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
> >>> ---
> >>>
> >>> In v2:
> >>> * Split the sleep codes into this patch
> >>>
> >>>    drivers/net/ethernet/intel/e1000e/phy.c | 9 +++++----
> >>>    1 file changed, 5 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
> >>> index 93544f1cc2a5..4a58d56679c9 100644
> >>> --- a/drivers/net/ethernet/intel/e1000e/phy.c
> >>> +++ b/drivers/net/ethernet/intel/e1000e/phy.c
> >>> @@ -1777,6 +1777,11 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
> >>>
> >>>        *success = false;
> >>>        for (i = 0; i < iterations; i++) {
> >>> +             if (usec_interval >= 1000)
> >>> +                     msleep(usec_interval / 1000);
> >>> +             else
> >>> +                     udelay(usec_interval);
> >>> +
> >>
> >> I do not understand this approach. Why wait before first
> >> reading/accessing the PHY IEEE register?
> >>
> >> For further discussion, I would like to introduce Dima Ruinskiy (architect)
> >>
> >>>                /* Some PHYs require the MII_BMSR register to be read
> >>>                 * twice due to the link bit being sticky.  No harm doing
> >>>                 * it across the board.
> >>> @@ -1799,10 +1804,6 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
> >>>                        *success = true;
> >>>                        break;
> >>>                }
> >>> -             if (usec_interval >= 1000)
> >>> -                     msleep(usec_interval / 1000);
> >>> -             else
> >>> -                     udelay(usec_interval);
> >>>        }
> >>>
> >>>        return ret_val;
> >>
>
> Regarding the usage of sleep/sleep_range functions - they can only be
> used if this code will never be called from an atomic context. I do not
> know if such a guarantee exists.
>
> In general I have quite a few questions and concerns regarding this
> patch series. The comment in patch 2/2 states that it is designed to
> work around a link flap issue with the average time between link up and
> down is 3-4ms, and yet the code waits a whole 100ms before reading the
> PHY bit the first time. Why so long?
>
> Furthermore, if I am reading this right, it appears that, with the
> proposed change, e1000e_phy_has_link_generic will poll the PHY link up
> to 10 times, with 100ms delay between each iteration - until the link is
> up. Won't it lead to wasting all this time, if the link is actually down?
>
> Looking at https://bugzilla.kernel.org/show_bug.cgi?id=218642, at the
> problem this commit series is trying to solve - I wonder:
> (1) How serious this problem is. It is normal for link establishment to
> take a few seconds from plugging the cable (due to PHY
> auto-negotiation), and I can accept some link instability during that time.
> (2) Assuming the problem is considered serious - have we root-caused it
> correctly.
>

