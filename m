Return-Path: <linux-kernel+bounces-402728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7ED9C2B0A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 08:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE47BB21FED
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7389413DDDF;
	Sat,  9 Nov 2024 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="JJEnPS0N"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D87A55
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731137713; cv=none; b=dyXiFbb9YydYXNqROAoPhnid3AAElcosWm9p7sipb138Ap7SVT2Ywq99HAFUX1PewnpcrRCZ65oEee6IEN3smCMtoqeG72AdpegqDphHa1SrzRBLIfEFIyYUanfGKFHux45F+fD8mZDRe7mF7Fd641DZ3eWlnHEz8Gk18rGyGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731137713; c=relaxed/simple;
	bh=zNhMYak1rnVDMapsu0tk3BwDJu8yuPW5Cr4i8jS6QXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvJa4J5QU1XiTHIUWhCNb0rsxUsfK11PGo/0yc31beTUL7jSOUGq7ZyviIyDhgvUW8rqBZVsDFKuKkzFwklkVQwgf9xSkl0kQ95Qn7tcCfE9X/hnL4Rzwh6jtIpdtBdzfZGwBlkTrwdp2+xEnJO86hZ1NGsHbc8mPq9QjpCv/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=JJEnPS0N; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 0C3D61770C1; Sat,  9 Nov 2024 07:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1731137711; bh=zNhMYak1rnVDMapsu0tk3BwDJu8yuPW5Cr4i8jS6QXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJEnPS0NBfqhAOkZp+9oFqhMXwA8k9XaMAwBDC7ZVlSpFJ+fT6kErGnfB6OVZoC8I
	 rnze6w1+8CtPWhGQG2x4zdm2ywjD6o3M/HXQrno3upRBd5F7OukI+6fZsZirQ0QTuK
	 gsmL9Q7qPUugcaKsSRvOfzyOsvm72OOapCD1ddMIzoY66tWczlzRJTBkY2mmSGFaM0
	 /coIiEaZ4Nj6QWQFxA05HzUJ3l4+GeQEO4TRSIqZ0ciPr6WwelD5HSTo5OesapbJlk
	 Q8NyPk/VEj53ugJKZwHk5nalswcergu6Q9pK3//uWNnjGsSCEcnmZiQJKKHL5iEdpD
	 h+FAwbz8y7rzQ==
Date: Sat, 9 Nov 2024 07:35:11 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Doug Anderson <dianders@chromium.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: fix ctrl+e/a/f/b/d/p/n broken in keyboard mode
Message-ID: <20241109073511.GA128495@lichtman.org>
References: <20241108221116.GA123748@lichtman.org>
 <CAD=FV=X6oS+v-ZvJWsHYAnfVg0Lurt8z4aYaboDKkib=p4zyJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=X6oS+v-ZvJWsHYAnfVg0Lurt8z4aYaboDKkib=p4zyJw@mail.gmail.com>

On Fri, Nov 08, 2024 at 04:31:12PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Fri, Nov 8, 2024 at 2:11 PM Nir Lichtman <nir@lichtman.org> wrote:
> >
> > Problem: When using KDB via keyboard it does not react to control
> > characters which are supported in serial mode.
> >
> > I have took them all besides the TAB control character translation (I am
> > not sure what that maps to on the keyboard)
> 
> Tab translates to 9, so the 9th character. Ctrl-I.

Noted, thanks

> 
> 
> >  kernel/debug/kdb/kdb_keyboard.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/debug/kdb/kdb_keyboard.c b/kernel/debug/kdb/kdb_keyboard.c
> > index 3c2987f46f6e..2c004abd5375 100644
> > --- a/kernel/debug/kdb/kdb_keyboard.c
> > +++ b/kernel/debug/kdb/kdb_keyboard.c
> > @@ -172,6 +172,9 @@ int kdb_get_kbd_char(void)
> >         switch (KTYP(keychar)) {
> >         case KT_LETTER:
> >         case KT_LATIN:
> > +               if (keychar == 4 || keychar == 1 || keychar == 5 || keychar == 2 ||
> > +                   keychar == 16 || keychar == 14 || keychar == 6)
> > +                       return keychar;         /* non-printable supported control characters (e.g. CTRL+A) */
> 
> This is probably OK, but IMO readability here (and above) could be
> improved. Untested, but I think:
> 
> #define CTRL(c) (c - 64)

That's a good point, I will work on a v2 with this fix.

> 
> Then:
> 
> /* Allowlist supported control characters */
> switch(keychar) {
> case CTRL('A'): /* Home */
[...]

Thanks,
Nir

