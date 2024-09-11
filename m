Return-Path: <linux-kernel+bounces-325361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217F4975894
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCC31F224F2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B79A1AE864;
	Wed, 11 Sep 2024 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="jlnAjPsg"
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF9157A5C;
	Wed, 11 Sep 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726072542; cv=none; b=LtTPKMyDN1E9Kz6DBq0ehsEj2icpeErrFZ+n7Ho1Y6ZB6tvfNNmEGBbOwHhU6WDKV1oJbH9qL/AkXVuF6omkGDxyDRuVqO4RjD4LzzDYXvNqIViwVwBaHoWkj9Lx93Jid0YkJ72kVCQve4M7BrZsiyOH3uCTR6rVMHHP+6YmCVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726072542; c=relaxed/simple;
	bh=jVWLJNJvpEN9e3zz9iqEToW+PGIpKGy1T0EKWJUXGx8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tj31WzlxpSGaMYr3QllNtJkNIT3MDpvzYEjxYOa580IzJMnaa9tNHQVSnkUo4btOMi9jaCYfk2Z3zBriuphkcsZVraFmB3oD4u+VctARk5dXaGRPjD3UiT7FkFlllAfTnCrSwAIdDcAUF4hCv8vGN+dO8vF4Cw289tQFzO69L+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=jlnAjPsg; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:3dad:0:640:7b05:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 4697A61B2A;
	Wed, 11 Sep 2024 19:28:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3SmF5L02OKo0-i0P6dBhR;
	Wed, 11 Sep 2024 19:28:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1726072084; bh=jVWLJNJvpEN9e3zz9iqEToW+PGIpKGy1T0EKWJUXGx8=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=jlnAjPsgktdlCyxm5Rg2u+j7zitMs5z0r4JnxHxZZOdupLi1DUvF4XOy5Qf2BaLjW
	 viH9I04ENeFRbIw7bef94hXUruKQQ0pU0zM17CRTqIVPH5Wqy78FyW/0gj/uNljohV
	 KWUiEkeH4TVIBmiqFk66SuYx5xDAOuMd+YHV1hN4=
Authentication-Results: mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <ddf9785a0b6e8ddee0de327423cefb22d7aac71b.camel@maquefel.me>
Subject: Re: [PATCH] ep93xx: clock: Fix off by one in
 ep93xx_div_recalc_rate()
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, Arnd Bergmann
	 <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, Russell King
	 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date: Wed, 11 Sep 2024 19:28:03 +0300
In-Reply-To: <548605182873dadad9ee33dc6ed70e0eba4bf495.camel@gmail.com>
References: <a05454f8-e409-4f60-93f7-6aa2ea0a2a23@stanley.mountain>
	 <246de2986dce9d867894bb006a1b2b3601e94a4e.camel@maquefel.me>
	 <a1ceab99-f26c-4edb-8f72-12abf20eec9f@app.fastmail.com>
	 <548605182873dadad9ee33dc6ed70e0eba4bf495.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Alexander, Arnd,

On Wed, 2024-09-11 at 16:59 +0200, Alexander Sverdlin wrote:
> Hi Arnd, Nikita,
>=20
> On Wed, 2024-09-11 at 14:54 +0000, Arnd Bergmann wrote:
> > On Wed, Sep 11, 2024, at 08:14, Nikita Shubin wrote:
> > > Hi Dan!
> > >=20
> > > Reviewed-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > >=20
> > > Alexander, Arnd
> > >=20
> > > unfortunately, the ep93xx DT conversion series is also affected
> > > by this
> > > bug.
> >=20
> > Here is what I did now:
> >=20
> > 1. applied Dan's patch on a new branch
> > 2. applied the DT conversion series on top of that,
> > =C2=A0=C2=A0 removing that file.
> > 3. applied the first patch (with minor context changes)
> > =C2=A0=C2=A0 in drivers/clk/clk-ep93xx.c again, along with
> > =C2=A0=C2=A0 the MODULE_LICENSE fix I did.
> > 4. finally, merged the entire branch into my for-next
> > =C2=A0=C2=A0 branch so it actually makes it into linux-next
> >=20
> > My plan now is to keep the branch in linux-next for at
> > least a week and send all the other pull requests for
> > the merge window first. If no other problems show up
> > (either with this branch or my other 6.12 contents),
> > I hope to send it all later in the merge window. If
> > something goes wrong, I'll send only the bugfix as part
> > of my first fixes branch for 6.12 and we'll defer the
> > DT conversion once more.
> >=20
> > I should have merged it earlier, but wasn't sure about
> > interdependencies with the parts that already got merged
> > elsewhere and with the comments about DTC warnings.
> >=20
> > From what I can tell, the current state is as good as
> > it gets, as we'll always get more comments or conflicts
> > with new reversions of the series. Let's hope we can
> > address any other issues on top of what I've merged
> > now and stop rebasing.
>=20
> thanks Arnd for resolving this finally and Nikita for
> your relentless efforts!
>=20
> PS. I've archived Subject patch now in soc patchwork
> (because I think I've messed up the author info, but
> all of this seems to be obsolete now)
>=20

thank you for your work and support!


