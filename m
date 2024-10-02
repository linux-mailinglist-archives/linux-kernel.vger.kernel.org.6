Return-Path: <linux-kernel+bounces-346922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 313AF98CB13
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09FE1F22DF3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833EB610C;
	Wed,  2 Oct 2024 02:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGMsdAhb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA7F1FC8;
	Wed,  2 Oct 2024 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835104; cv=none; b=YuwrFRts4ANM94YR918rzKbDxKoRpAd0uMaUtymRhPsEr5NhcqTw4z6Be5r+63LTiL5npTKzNyTu/uNUPBkjHHrWjDF0ZjFMg9FmmEoP2AhpNGnkmsy/4+EupXoUS63ohkD2m+tV0qFIpjCF/lpS+0nZCzR07Ciik2w+kxb1yYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835104; c=relaxed/simple;
	bh=EwjQ6TPehPS/lxtRaCAihIaAcrt/dYqV/YEx71jpBZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2ovJDyI9oxXFMDqBVzoDOntKSyEnPsnCw26YTftcCeGOjvVEaQbx3M2HyBo4OVlNcNDlbgm0T6OxnrQ5q5iSX6zKpNch4Zu0YVyzKzCBkN75aGXTDaR913q/xBv1uyb1W28vLvbYLrfWuuOuxxzX8pHIlW0U3Oe8GT437M3CQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGMsdAhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6828FC4CED2;
	Wed,  2 Oct 2024 02:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727835103;
	bh=EwjQ6TPehPS/lxtRaCAihIaAcrt/dYqV/YEx71jpBZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hGMsdAhbhN1DfTHr16WbFONJoxFGxs2JyTPCdaz7KsAHFa9ICJfkHryFnNqzfIFlU
	 Vv0w52ZFdHVoUim02of8kYyI58V3KbVtMv0kufrLBClikNVmQr5pRTik0afCrkbOaa
	 Q6yCsMK5qKEImuaVzgtk4TA8lafe2VIORMoZm1ONLhmbadNy5jSgb3XsO03UOqZyvz
	 1LCI/gZxw36r1n2ZMRsP/ur8pO7kWkMDTkK8/GwAq0QfIlgQqZIjq5eWvMlZETXpkU
	 zR3+5Ab79gCQyOzBSDCUTmbW+eSSqxTxfMgGuTwsZQCDp/QioUhgoYCyXDTJjuIr+d
	 3LkidoqFZq6wg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539973829e7so2796140e87.0;
        Tue, 01 Oct 2024 19:11:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHGB3k65kRlXL6VA3JwV/AW1UiKVke3UAEUAKuGHfKaHXwDIK/CMF8cMF2W2+RsfuJj4fGyB69z6Ih@vger.kernel.org, AJvYcCXncsjUzIgPFP5CIqj4plhpqcHOlT39t47so/XEzTIjz68wmCbXFVCqGvURvKXgRZiJxKRZ2B/fY+IDkh95@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3CeEV97HZ2ZCpoDWFgNNHTYsnWAEiI8KeLMMr2sMgt70O7K8f
	DLRDtHP8mttmHO+HrekdIaeigOCndT8lbHlmjlACvrN9B7B/qNhFOqSXv0MHFWo0RGlrwjql020
	ao7Yq6Jxks/NoUB7BwanIAwnImA==
X-Google-Smtp-Source: AGHT+IG/l7EWLwE3pdjVLCqbpvNIby02jEPmpsXYqbt2OzpaoBDo9Bu6Y4uGMSndgl3NwCzDI4OIVZ+PFcAe8MihLgk=
X-Received: by 2002:a05:6512:3d1e:b0:530:ae22:a6f0 with SMTP id
 2adb3069b0e04-539a06580bamr711754e87.5.1727835101559; Tue, 01 Oct 2024
 19:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923094249.80399-1-chentao@kylinos.cn> <20240923094249.80399-2-chentao@kylinos.cn>
 <20240924222857.GA404805-robh@kernel.org> <ZvNAr0d5gYmuM+Zt@shell.armlinux.org.uk>
In-Reply-To: <ZvNAr0d5gYmuM+Zt@shell.armlinux.org.uk>
From: Rob Herring <robh@kernel.org>
Date: Tue, 1 Oct 2024 21:11:28 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+FJuwpJe7WW80buqpRCJv4ZHKmjfSPZKnx+4j6NOtoCQ@mail.gmail.com>
Message-ID: <CAL_Jsq+FJuwpJe7WW80buqpRCJv4ZHKmjfSPZKnx+4j6NOtoCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] amba: Add dev_is_amba() function and export it for modules
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Kunwu Chan <chentao@kylinos.cn>, saravanak@google.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 5:44=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Sep 24, 2024 at 05:28:57PM -0500, Rob Herring wrote:
> > On Mon, Sep 23, 2024 at 05:42:47PM +0800, Kunwu Chan wrote:
> > > Add dev_is_amba() function to determine
> > > whether the device is a AMBA device.
> > >
> > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> > > ---
> > >  drivers/amba/bus.c       | 6 ++++++
> > >  include/linux/amba/bus.h | 5 +++++
> > >  2 files changed, 11 insertions(+)
> >
> > Russell, Can I get an ack for this to take it with patch #2.
>
> Would be nice to discuss "how shall we merge this cross-subsystem
> patch series" first, hmm?

Sure. IMO and what seems to be typical, since the user is in
drivers/of/ and changing that code is the overall reason for this
series, I think merging it via the DT tree makes the most sense. But
either way is fine with me. I'm happy to either ack it or apply it and
move on to the next thing.

> The reason I didn't take patch 1 originally is because it was submitted
> to me without any users, and the general principle is not to accept
> patches without users. Too many times, I've merged code where there's
> been a "promise" that it will be used, only to have the author go
> silent and users never come along. So now, my rule is... any code that
> adds something must also come with its user.

The user is in drivers/of/ in patch 2 of this series. So no issue there.

Rob

