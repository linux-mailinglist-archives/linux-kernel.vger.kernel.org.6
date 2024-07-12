Return-Path: <linux-kernel+bounces-250012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA8792F2F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 02:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CB81F228FB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786FF635;
	Fri, 12 Jul 2024 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTpZ/ADO"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA23376
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720743222; cv=none; b=f/yDcEx+pPAaos5C4QHCTS3jXTcc80f/1s1ncqfrHcFHYrtxBCzBY+bEW9sg3Fe2LxEVPxpKwocguB4Q8fY0bE5IVMTs1IYJ5HAiSANG6lUCr0Pk07Zt6fWLy3E4rA5a19EeaqvlXOrdCPSNXQXYmW6paz1+Y7LxHr9Y+9+T3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720743222; c=relaxed/simple;
	bh=5a8vBn/YHW4mLzVnW5So/Jm3wAhZJ78cpeMq82a27lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJy35Q/dXhIh4J/GZjx+42wCZ/eIn0gyWWHnlUhrDNWyrU3+/aa2ntFbfWWHyZy0HBJ6TxF0Uv+CWMjxRub3KPgSJe72xUfq85upzrbobS7H3CW1GfTiiKQJgEQBm0sa+Riz2aVc+Nnt1fTPMNLhdQx1kgEA+isSx3vn4HxeQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTpZ/ADO; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-447df43324fso69141cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720743220; x=1721348020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvmJJCnLXZLr1KbbD5fKBqYw5WHyRFvoxJIcU+eMWec=;
        b=dTpZ/ADOQmm+mqKXztmACMd/f82S9JeRII1UdB+3DW0Sp8YvI4fWR++ciqXi8KSxfs
         XBDgjz5B/1bCcOLIZMaWaGVsHwZKEDTd66+5RSZMQE2rsEQ1IF49Xd/rqVws8Qn6hJ0n
         JlSFx+OxPN29j+iSt7WrI3wN2OOR1xbZ75HwFRE2Va4TD0utLqgKwuHg4sRE6f2UQtwC
         EKbD/1JlaUBOL2xZNQ84zZU3qZAVRyCrN1pW0WKtFBK081ok3d0W3A1iYUaPDcQAw8TE
         KStNRPCOM4iCyUhy6ViHI9CCC61hS293/ZTOiM+GyptFygyphwp2Lo3sCaG4fDG30l+i
         0afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720743220; x=1721348020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvmJJCnLXZLr1KbbD5fKBqYw5WHyRFvoxJIcU+eMWec=;
        b=V41rneISWADCiKFQicBivtgUjs6PQ0aEM2LhnIPEqyoF6A/zdWzzE0IkiKKb6hUatR
         UuLw9TtezsT5zbMwNK4ySnXGcFZsOHCe1n1q12HqASrWJeSn6JAJMnB2Yaw3zPtD9WXm
         ExEF8NOoA20zPDqxMx1Rtscgz34PmJ59h+6M1xNYfj65xGgAgSUBEraHeAQueOrKsbqt
         sEs+FAQrv/PVYBMTcLZF8Acy88S8/4N+rXr4m6QrHQ8tCUSoGfzV2vlXfX/7fttf42Ng
         2syQivgvHL9gnHnHyBjdAFRsx9rDO8P03nvUMHPX7V0raF+xhiVx4hOKffVZi0K9++/A
         +7yw==
X-Forwarded-Encrypted: i=1; AJvYcCVDa52SpK4Hw4G93B9sWFEKJvaXs+dQz+MR4LfGNtqMiUpEprefVVbe8csXjAb0z/nv3U+X5I1leszJSpTu5mUH6jkmFG+gOMg4HGwP
X-Gm-Message-State: AOJu0YzgTcWCKq7X6488/bkt67TECWTIW7srXmXCYxBG0QWYdQXQFlRJ
	3B3K2qSKC/vnSQlkDQPL7UnwmwMnDovTGqlpb3k2TRAqqn5OyhIBL/8jLc9wDz7MGti7wemx37d
	UYw3fZe+iVgGKga1omzwGSm6Ust4wCXDoSON7c3nOUq2YqOwezp+n
X-Google-Smtp-Source: AGHT+IFAD8sqxPusycnznfFlRILtgKPfwSQZVQ/Kk7PE0REcOpbukysMQqB4REQvgqThSoihTZy/us5ruUkCyrSKJFk=
X-Received: by 2002:ac8:5994:0:b0:446:64ad:ee91 with SMTP id
 d75a77b69052e-44e75322eefmr1457141cf.20.1720743219959; Thu, 11 Jul 2024
 17:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711212514.2372780-1-yoann.congal@smile.fr>
 <CAGETcx--FNpz3o5TiZ3T6UkMHKBUjD8cwHR6eQAjM-U86=p_Eg@mail.gmail.com> <f2044667-e235-4abc-924e-3615c60681f1@smile.fr>
In-Reply-To: <f2044667-e235-4abc-924e-3615c60681f1@smile.fr>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 11 Jul 2024 17:13:01 -0700
Message-ID: <CAGETcx-ioF=jTbyQMeD2fsYKz8q5vw_TWYWS9m8H5=pCo5KFYA@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Set the fwnode for regulator_dev
To: Yoann Congal <yoann.congal@smile.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 3:19=E2=80=AFPM Yoann Congal <yoann.congal@smile.fr=
> wrote:
>
> Le 11/07/2024 =C3=A0 23:29, Saravana Kannan a =C3=A9crit :
> > On Thu, Jul 11, 2024 at 2:25=E2=80=AFPM Yoann Congal <yoann.congal@smil=
e.fr> wrote:
> >>
> >> From: Yoann Congal <yoann.congal@smile.fr>
> >>
> >> After commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
> >> detection more robust"), fw_devlink prints an error when consumer
> >> devices don't have their fwnode set. This used to be ignored silently.
> >>
> >> Set the fwnode in regulator_dev so fw_devlink can find them and proper=
ly
> >> track their dependencies.
> >>
> >> This fixes errors like this:
> >>   stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Failed to creat=
e device link (0x180) with 2-0033
> >>
> >> NB: This is similar to the commit a26cc2934331 ("drm/mipi-dsi: Set the
> >> fwnode for mipi_dsi_device") applied to the regulator framework.
> >>
> >> Cc: Saravana Kannan <saravanak@google.com>
> >> Cc: stable@vger.kernel.org # 5.13.x
> >> Fixes: 63c7c9e16c8e ("regulator: core: Get and put regulator of_node")
> >> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> >
> > The change is valid but the problem is that managed device links don't
> > work correctly for "class" type devices. So, we can't merge this
> > change yet.
>
> I was totally unaware of that.

Yeah, it's not obvious. The TL;DR of the problem is that your consumer
will end up waiting for ever for the supplier to probe but a "class"
device never probes.

And the fix is non-trivial. So, it's been on my todo list for a bit.

> > So, for now, we shouldn't land this. Are you not seeing probing issues
> > when you do this? Or significant changes/delays in probing?
>
> I just checked my logs : No probing issue nor noticeable delay.

With your change, I'm guessing you see more links under /sys/class/devlink

Are all the consumers in these new links "class" type consumers too
(like other regulator devices, etc)?

> Thanks for your answer, I'll drop this for now.

Thanks.

-Saravana

