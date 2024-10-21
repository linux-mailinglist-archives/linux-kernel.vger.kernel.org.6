Return-Path: <linux-kernel+bounces-375021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62259A8FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6261F22A25
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4718C1D0DE8;
	Mon, 21 Oct 2024 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="ayevwYMR"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AC979CF
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539152; cv=none; b=pwHCeRTQEQ3e3GZ9uF5F1vDRvgbAj5714RDGbhKRJucLieomCCT+2+i0DSMHr4WS1yZEUlyORSoEIfJzBe94WKKVjTkEfiUZSIX6olsEbfUF+5VdA2aOMe/4FtQEGCDdCBu6u4R3j50pjkvP77+MTQT9mp8qFinMEFSU21dUOH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539152; c=relaxed/simple;
	bh=lvbUhXDFjOdI5unZDc8utq3G1xeo/THENAURmkXLtAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsxufHiVBUfylAsss7d2L9KTx4wu4v8x6q3LaZ22TnNLGmKBmzzWq6nzLYZVUMBItveXmiYi1oUVhJ2ladFwNRiPZ2ecNJqojxtWY7daL00YFeUZK4DJtRZc+F1A3D/as1+6Gdjd7kfYQvO45yQaSCh6HxJU8NR4nJeqmkIVrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=ayevwYMR; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id BCC6D177106; Mon, 21 Oct 2024 19:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729539143; bh=lvbUhXDFjOdI5unZDc8utq3G1xeo/THENAURmkXLtAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayevwYMRcN7dicEdONEvabO2FibzrRiry7l5ZKbLeqdEgM8C8FaRZoTMQVuPKL/7I
	 Et2VA8ljzNLKY9zPdDYbbxvHuD+lIwdl6VPDDDUOIc0Vy/qMQKWzNLBlLQIU+o+R2p
	 Ui+iR14IjhPFSVqK/T5jYQwr94mQkpEAtlg0OtsARJ/hVi/8OeArLGdJy79OTDrjug
	 Nc3xHcIuUBcocj0T4z/yRBFvRmOrIPcszGXMf2RftseF0iS3mzW1wfM1ZFYAE4aE0O
	 xea9b72iRodg9saIxHHB6StUI2eehfJbzhVw9GoMG6GZgm/uLFj8uBxiCYTPKUxeQD
	 Rc99NetmJWMPQ==
Date: Mon, 21 Oct 2024 19:32:23 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Doug Anderson <dianders@chromium.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Yuran Pereira <yuran.pereira@hotmail.com>
Subject: Re: [PATCH v2] KDB: Fix incorrect treatment of numbers in the CLI
Message-ID: <20241021193223.GA834839@lichtman.org>
References: <20241019195715.GA810861@lichtman.org>
 <20241019204212.GA811391@lichtman.org>
 <CAD=FV=UpKjTe78vexUXFThPXtx1KjhfR_u+1hpQpkh8ei-F5aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UpKjTe78vexUXFThPXtx1KjhfR_u+1hpQpkh8ei-F5aA@mail.gmail.com>

On Mon, Oct 21, 2024 at 10:14:15AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Sat, Oct 19, 2024 at 1:42 PM Nir Lichtman <nir@lichtman.org> wrote:
> >
> > Problem: In many cases, KDB treats invalid commands as numbers and
> > instead of printing a usage error, goes ahead and just prints the number
> > in hex
> >
> > Example: This can be demonstrated when typing for example "aaazzz", this
> > confuses KDB into thinking this is the hexadecimal 0xAAA
> >
> > Solution: Transition to using kstrtoul instead of simple_strtoul.
> > This function is more strict with what it treats as a number
> > and thus solves the issue.
> > (also better practice as stated in the definition of simple_strtoul).
> >
> > v2: Removed redundant if condition I put in v1
> >
> > Signed-off-by: Nir Lichtman <nir@lichtman.org>
> > ---
> >  kernel/debug/kdb/kdb_main.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index f5f7d7fb5936..4cbd5cd26821 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -402,18 +402,15 @@ static void kdb_printenv(void)
> >   */
> >  int kdbgetularg(const char *arg, unsigned long *value)
> >  {
> > -       char *endp;
> >         unsigned long val;
> >
> > -       val = simple_strtoul(arg, &endp, 0);
> >
> > -       if (endp == arg) {
> > +       if (kstrtoul(arg, 0, &val) != 0) {
> >                 /*
> >                  * Also try base 16, for us folks too lazy to type the
> >                  * leading 0x...
> >                  */
> > -               val = simple_strtoul(arg, &endp, 16);
> > -               if (endp == arg)
> > +               if (kstrtoul(arg, 16, &val) != 0)
> 
> Instead of just fixing the one case, do you want to just take over the
> old patch series that tried to do a more complete job:
> 
> https://lore.kernel.org/r/GV1PR10MB6563E0F8DB2D335BD9CFE4D3E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM/
> 
> I think in general that series looked good but just had a few nits on
> it, but the author (Yuran Pereira) never followed up with a v2. You
> could take that series, fix the nits, add your signed-off-by, and post
> a v2?
> 
> -Doug

Interesting, will take a look.



