Return-Path: <linux-kernel+bounces-329243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE2C978F10
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1A21F239C6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052F913C90F;
	Sat, 14 Sep 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSObA0mm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4288B749A;
	Sat, 14 Sep 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726301869; cv=none; b=n7JF+E5Axp29GMZNkSDWbkgQB4f9MM4e0ZKg2JzAPOmnqWs8NPuJiaTXKU3wMmtfSf0jYqbscaAhztnRznjv4YCd6w48NNAIjfJUGcVQb4cVmwuw1uFy6oTinPdeMwQ2TlNJBVqKhJBNVIus4yyOdSv03kHbIGgDevIysBaupX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726301869; c=relaxed/simple;
	bh=dyfkrsVc2HtRB1v6GvfuG8CIQ8s4h4aWOGeOrjMRZSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnIWoVMYfpCj2fBS+2DFKDMPVCzMnTvUU3zConIYeI6Jd2L1CtTPGLDjt14rueV1Z2JiGu2FnIJDrhdUIpOhNTf+c/DMYRWXo150mRPJSa4YQ4cl/Hj8hOpeq1DQGrxwSJAossYNFb0AbWTDq97UkF5CNSgMVa35Gbl26tR8MMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSObA0mm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64135C4CEC0;
	Sat, 14 Sep 2024 08:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726301868;
	bh=dyfkrsVc2HtRB1v6GvfuG8CIQ8s4h4aWOGeOrjMRZSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSObA0mm3Lp0X3btXTFANk2a0eiBIrP6ReZIM7NBGuepMtgFE/8nVZIp8A3HEtMBx
	 xSgmoh7Nr3F8RLztjcRwtXYvSQgr+mapcPROqKofWo8GuhYV/miN6PgeS/9nw+wa7C
	 7eRXUs1b4ygYffr80njs3Kt3aelSXymJmXxxjZKQpCH8IuIx3Py+VraFcij+yUPRNT
	 oGluFxWUd5m/0ghM3q8B6RCbbAT2/Mc9VoiqcwtPPrsv7NbALoCCDVc5qXbvKh9qGC
	 MZ7ncU48t8eWiKIgVnJyq3KAOYIDJ0oXjW2dQJOR4YEAbJsALNp1+AfFoXusZQ914c
	 k19k0KAheP13A==
Received: by pali.im (Postfix)
	id 152A7758; Sat, 14 Sep 2024 10:17:43 +0200 (CEST)
Date: Sat, 14 Sep 2024 10:17:42 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Steve French <smfrench@gmail.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] cifs: Fix creating of SFU fifo and socket special
 files
Message-ID: <20240914081742.wlldjjlogrmk533i@pali>
References: <20240912120548.15877-1-pali@kernel.org>
 <20240912120548.15877-7-pali@kernel.org>
 <20240913200721.7egunkwp76qo5yy7@pali>
 <CAH2r5mvEa8mUrK7mEKFiimkb1asTWA0p7ADz4937yoxM916RAw@mail.gmail.com>
 <20240913224248.k5tn2le3gau2prmo@pali>
 <CAH2r5mtgV=NkZVChDY-apdqkvM9KFkraRGy_jDCpLmFU6PFMAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5mtgV=NkZVChDY-apdqkvM9KFkraRGy_jDCpLmFU6PFMAA@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Saturday 14 September 2024 01:21:17 Steve French wrote:
> On Fri, Sep 13, 2024 at 5:42 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Friday 13 September 2024 17:14:22 Steve French wrote:
> > > How did you find the format of the FIFO and SOCK file types?  I
> >
> > For fifo there are multiple sources on internet, but none of them is
> > normative. Everything is just what people have tried. For example this
> > old email on samba list:
> > https://lists.samba.org/archive/linux-cifs-client/2005-May/000856.html
> >
> > Format of the socket I have figured out by creating it in Interix
> > subsystem and then dumped content of the file from Win32 subsystem.
> > Then I checked that it has also same format over older MS NFS server.
> > It was easier than trying to search for some documentation (which I have
> > not found).
> >
> > > couldn't find any references to those so added two new types to allow
> > > current Linux to be able to create these (especially since they are
> > > opaque to the server and thus low risk).
> >
> > I was searching over internet again and now I have found patent
> > https://patents.google.com/patent/US20090049459 which describe symlink
> > content:
> >
> > #define NFS_SPECFILE_LNK_V1  0x014b4e4c78746e49 /* “IntxLNK” */
> >
> > But does not describe other types.
> >
> > > > +     case S_IFSOCK:
> > > > -             strscpy(pdev.type, "LnxSOCK");
> > > > +             /* SFU socket is system file with one zero byte */
> > > > +             pdev_len = 1;
> > > > +             pdev.type[0] = '\0';
> > > >               break;
> > > >       case S_IFIFO:
> > > > -             strscpy(pdev.type, "LnxFIFO");
> > > > +             /* SFU fifo is system file which is empty */
> > > > +             pdev_len = 0;
> > >
> > > My worry about the suggested change above is that it is possible that
> > > we could accidentally match to an empty file.
> >
> > I fully understand your concerns, but code in this patch is for creating
> > new fifos. Not recognizing existing fifos.
> >
> > Code for recognizing existing fifos (=empty file with system attribute)
> > was not changed and is in Linux cifs client for a very long time.
> <>
> > > We intentionally added
> > > the two new dev.type fields for these to avoid collisions with other
> > > things (and since they are Linux specific).  It seems risky to have an
> > > empty file with the system attribute marked as a FIFO, and similarly a
> > > file with one byte null as Socket.   Since this is for only the Linux
> > > client to recognize, I wanted to do something safe for those file
> > > types less likely to be confusing (ie strings for Socket and FIFO that
> > > were similar in length and format to the other special files seemed
> > > intuitive) and "LnxFIFO" and LnxSOCK" were used as the tags in the
> > > file to reduce confusion ie the tags for those two start with "Lnx" -
> > > ie "something used for Linux client" not related to the original
> > > Interix (those begin with "Intx").
> >
> > I see. Now I understand what are those types (as I have not seen them
> > before). It is somehow misleading if such "LnxFIFO" and LnxSOCK"
> > functionality is provided by SFU option, but is incompatible with MS SFU
> > and also with MS NFS server. And is also incompatible with older Linux
> > cifs clients (as they do not understand those Lnx types).
> 
> I am not as worried about FIFO and SOCK type being recognized by
> older servers (since almost every use case for them would be for them
> to be seen (only) by the client - e.g. for mounts to servers that
> don't implement reparse points yet), and since they are less
> common file types I am willing to let them be unrecognized by
> old clients (we can tag them for stable if older distros don't have
> them),

This is quite pity for old clients, to break existing interoperability.
At least I see sfu as an compatibility option either for ecosystem with
old clients, or option where server itself does not support reparse
points.

> but I am concerned about allowing "current clients" to
> create empty files for an unusual purpose which could be
> confusing/non-intuitive.

I understand this concern. I thought that this should not be an issue
because files are created with system attribute which is not common for
normal/ordinary usage (system attribute could be less confusing) and
also because this format, at least for fifo is used and understood by
many SW for about 30 years.

> And since this change (at least the one to allow FIFOs to be created with "sfu"
> has been in mainline for a year and also since it uses a more intuitive tag
> ("LnxFIFO") than the empty one used by very old Windows) the only
> clients who would have created these would be already using this newer tag
> (older Linux clients couldn't have created such files - there seems more
> risk of regression with reverting the change than with continuing with
> the Linux client specific tag (at least to the one for FIFOs
> since that has been in much longer than the socket one which is recent)

This kind of stuff is lot of times used on LTS/stable linux
distributions and new kernel to these users/admins do not have to be
delivered yet. Mostly it takes 2-3 years after release. Look for example
at RHEL cycles.

I'm looking on this from opposite perspective. I see this an regression
in -o sfu option that after upgrading from previous LTS version to new,
-o sfu stopped to be compatible with SFU-style fifos.

But your point is valid. But maybe it is not an issue because users
do not have updated yet to new version?

> Will discuss with others - opinions welcome.
> 
> There is an upcoming SMB3.1.1 test event coming up next week (and the annual
> Storage Developer Conference too) so I can see if others have opinions one
> way or another on whether to move to empty (or 1 byte) files for
> creating fifos/sockets

Ok, perfect, let me know then about the result.

> > > Note that in the long run we hope to use reparse points by default in
> > > more servers to store special files like this but there are a few
> > > cases for unusual workloads that need special file support that would
> > > have to use sfu still.  The newer reparse tags that Windows uses "WSL"
> > > have the advantage that they require fewer roundtrips to query (since
> > > the file type is in the reparse tag).
> >
> > Yes, new WSL tags seems to be better. Also SFU mount option is not
> > activated by default.
> >
> > > Also noticed an interesting problem when mounted with "sfu" -
> > > "smbgetinfo filebasicinfo /mnt/fifo1" will hang (in sys_open).  Is
> > > that expected for a FIFO?
> >
> > Reading from fifo sleep reading process until some other process write
> > data to fifo. This is how fifos are working. You can try it on local
> > filesystem (e.g. ext4 or tmpfs).
> 
> makes sense - thx

