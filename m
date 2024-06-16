Return-Path: <linux-kernel+bounces-216435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B79909F46
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4571F21C9F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F481CA85;
	Sun, 16 Jun 2024 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="p5aU+BXm";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="m9zuvCI+";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="J6yFXe9o"
Received: from e2i411.smtp2go.com (e2i411.smtp2go.com [103.2.141.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061543E478
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718563305; cv=none; b=lw0spuKfo79Kv+9/kPGR89F7sGMIUQB/nZL+czsWWEu/s1TkHV3ocfhn0OurEh/Hj31BkV7ybMWOAUAa4WeJBUduLTlcoI1ZF0ljmO8c9wJeu+VUwMchXBi+HyH95nOaPohAC9PPtRkbIJaFP4xmai9JN+CDfi4fQ/wNJZ7qJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718563305; c=relaxed/simple;
	bh=6ACv2bY6r0zfKilkhSR0qAqUlb4hMLiS2w9z7El4auw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnc6jzZ+YoLRLbuoarMxBGl86n0eojCvk/VLwdOkr7C2liv2t2ydADHMpAS5v5F44CS+5L52HgplrICgETCXLGiOS1em+oI64JsqaGp9wGdHdFyN5ceQkpJlBTCuzgJ6Xuq6wZEcvJ+AXn4S2fUpPPb4O88cmhbUK+Ww9zssKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=p5aU+BXm reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=m9zuvCI+; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=J6yFXe9o; arc=none smtp.client-ip=103.2.141.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1718564199; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=6aR9HQaE4Y4lal1GRYEHgr3+/2qU9T5sijRZ4zLk+BE=; b=p5aU+BXm733K58ryDkiZNA2rHk
	QZdtEUEABGnoghhRkq5+LKXBHuBy4kDiYO50u49jd8Z4eNEHBYVmvIYPcsafdJk7NIOHHjA6f/3XL
	Rcti712/Y6KuV3yihRrHOGwcl6cQdOcEEnAMvYR21n9st2ytwvqremv5w5rXHqaBu4qNATPBAgFTf
	hvJC44J19S3kcqq6yFqv1/LITA5sQQrbdYr30iD4w6zpBa+6xUZ8Rp1JMI/8Vr1qfk44S/dEirGk+
	80GHYVbFpxEbeLUiUnodMH1tiP8QocqNOk23m/4KonCb09beWGkGiVfFWuOULnS83eMTVBvCWbTzI
	tRD1utew==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1718563299; h=from : subject :
 to : message-id : date;
 bh=6aR9HQaE4Y4lal1GRYEHgr3+/2qU9T5sijRZ4zLk+BE=;
 b=m9zuvCI+VnTnYgztLQsmP2nEoXCPGrmv/JVbjt9SZhXe7O/CYm2WBy/A44JdUYXMHYCzc
 Nx2I3sXFZ4PsBxVDrl2U+vwtdEBMOVn5FQa1RVSMWdaxg7z8MslRlDSoqHmghT1FUkmTRqu
 MoLQP7Ui+7HBi/BwV+JJ7WwRfvqEEb8IymuJTDFLj8B/wIgfWuAMSjA0lRX4tDeyR7kXlK2
 fdUS1uG4isPKpm3uBvyRG8nkJbO+JZ6QlYWVEy99p7zyvKQKrvnENrnoM7xPx2f++X9WBrh
 du5UhlKKwY1TbEZqnA+ar+leGkzK3iMpIVNZPVQEAZC5UW3brlCGyZ7ZWilw==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1sIuoF-TRk2RG-VL; Sun, 16 Jun 2024 18:41:01 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1sIuoG-4o5NDgrtfVC-lgmk; Sun, 16 Jun 2024 18:41:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1718563258; bh=6ACv2bY6r0zfKilkhSR0qAqUlb4hMLiS2w9z7El4auw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J6yFXe9o80kwHORoqDUYJUjUXOIB2T0JZU+1hrjlCggInbSSj76zFt0mJYNG8d655
 qes3jWF/ztIRn2i/W0ufP3wom/j2F7nRLK020WWZ9isrywROjKpqI8v/PuR8/DDTuZ
 GfW+rDSKQ47psKzI2BDvlqSaa0FUcPg9/3zD4ZAE=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id 365EC3E724; Sun, 16 Jun 2024 20:40:57 +0200 (CEST)
Date: Sun, 16 Jun 2024 20:40:57 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 2/2] kbuild: package: add -e and -u options to shell
 scripts
Message-ID: <Zm8xuTWFx6SRAAHk@fjasle.eu>
References: <20240611160938.3511096-1-masahiroy@kernel.org>
 <20240611160938.3511096-2-masahiroy@kernel.org>
 <CAK7LNAQyPRKes7=wNtYXre+nU=5-1oZ-g1uzbjFMFd2e10jFjA@mail.gmail.com>
 <20240616-dandelion-lynx-of-philosophy-6be45f@lindesnes>
 <CAK7LNARPP_OsaOhUHT+5-vi5XJ36hDs0bNsiM7pwuAmj4S+MNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARPP_OsaOhUHT+5-vi5XJ36hDs0bNsiM7pwuAmj4S+MNg@mail.gmail.com>
X-Smtpcorp-Track: 7wBz__Bss3fp.7W5YueSCJYjB.yCHYvARkCnX
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286sxlsKb0eUo
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Mon, Jun 17, 2024 at 01:52:23AM +0900 Masahiro Yamada wrote:
> On Mon, Jun 17, 2024 at 12:56 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
> >
> > On Mon, Jun 17, 2024 at 12:21:15AM +0900, Masahiro Yamada wrote:
> > > On Wed, Jun 12, 2024 at 1:09 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > Set -e to make these scripts fail on the first error.
> > > >
> > > > Set -u because these scripts are invoked by Makefile, and do not work
> > > > properly without necessary variables defined.
> > > >
> > > > Remove the explicit "test -n ..." from scripts/package/install-extmod-build.
> > > >
> > > > Both options are described in POSIX. [1]
> > > >
> > > > [1]: https://pubs.opengroup.org/onlinepubs/009604499/utilities/set.html
> > > >
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > ---
> > >
> > >
> > >
> > > Setting -u needs more careful review and test.
> > >
> > >
> > > This patch will break 'make deb-pkg'.
> > >
> > >
> > > ./scripts/package/mkdebian: 150: KDEB_PKGVERSION: parameter not set
> > >
> > >
> > >
> > >
> > > To set -u, scripts/package/mkdebian needs code refactoring.
> > >
> > >
> > >
> > > I will keep scripts/package/mkdebian untouched.
> >
> > uh, I missed that during the review.  Do you want to refactor mkdebian
> > in large scale, or is an explicit fallback definition possibly
> > acceptable for you?
> >
> > diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> > index ecfeb34b99aa..7e3878197041 100755
> > --- a/scripts/package/mkdebian
> > +++ b/scripts/package/mkdebian
> > @@ -7,5 +7,17 @@
> >  set -eu
> >
> > +# Optional user-specified environment variables
> > +
> > +# Set target Debian architecture (skip auto-detection)
> > +: "${KBUILD_DEBARCH:=}"
> > +
> > +# Set target Debian distribution (skipping auto-detection)
> > +: "${KDEB_CHANGELOG_DIST:=}"
> > +
> > +# Overwrite the automatically determined package version.
> > +: ${KDEB_PKGVERSION:=}
> > +
> > +
> >  is_enabled() {
> >         grep -q "^$1=y" include/config/auto.conf
> >  }
> >
> 
> 
> 
> 
> It depends on the code.
> 
> 
> 
> 
> I would fix
> 
> 
>    if [ -n "$KDEB_PKGVERSION" ]; then
> 
> 
> to
> 
>    if [ "${KDEB_PKGVERSION:+set}" = set ]; then
> 
> or
>    if [ "${KDEB_PKGVERSION:+set}" ]; then


ah, yes that's probaly better than the default value assigments,  Please ignore
my patch.

Kind regards,
Nicolas

