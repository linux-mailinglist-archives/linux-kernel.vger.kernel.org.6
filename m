Return-Path: <linux-kernel+bounces-345680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B055498B97D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABA11F236E5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0077119DF77;
	Tue,  1 Oct 2024 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="aT2AiQ+W"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC551A0AF7
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778172; cv=none; b=W8f1aIBBXIr9+sic954g/Te6kRPMJOXunmYlBCz6WMeKmqDPq32c008fHBYVb9bTaQUFtFD32ubzWMHOdQqEvZQAppGRLp53EuMNpsx0MHOASvlffg7JLg86M7soc8wTxZUJtS/Ii57BuZBM9zgw/nyMbHUC7qR51d3VbTzrXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778172; c=relaxed/simple;
	bh=iYx+LfpEsundvFrNWsLliqzdT16mNGC6KUGgjZwt5PY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YFCU2TKcsvOFUkhdauVdznczhWZXnHeLVE3EG0Li6hQZRh16Y/M66ZRkObgQkalJ2OZgCFqD46YlzIm9hudAiB0uCOhOusSNP5IN3hthzp1fvj/H/kgyOlQRF9RnDyfQZMldPKfNZxfJRDNn4BVBdtjQKkbV4+++PVjt3CFvb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=aT2AiQ+W; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727778157; x=1728382957; i=spasswolf@web.de;
	bh=iYx+LfpEsundvFrNWsLliqzdT16mNGC6KUGgjZwt5PY=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aT2AiQ+WcHZ8OO8Vom8zkHcY9cEwETaLGfQisg8Ky/n1OxRaxhfmxXG6KHwZNTWJ
	 qv+Lytwds/okXBRKE6qujgTQ8hRwKpXX9GgtZYOnRS4kX4Q/+2Ozk7+6HGHmpB2HP
	 AsOh/I7HDfGfI4beLJFtl7Owfm/xggqPHDSeixoySt+ULX+VXTCLu1zHWCepnZE+r
	 pydx79S7et3U9yIYZQ4ELUO8nD1euHVIngZlriFJj0up4d/oYSrrOQNSZHzBNd46O
	 tn0m6JAWmIsLyQ0AVk/P3BFANO0nAud7nlpwzRDYdi8JDqKJqgZTE6Y6eAnailyxq
	 gm1pJL2E/MufW34aqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MActe-1skben17w8-009iio; Tue, 01
 Oct 2024 12:22:37 +0200
Message-ID: <dac4dd705b0c5084cdc15b3bae4d363bc6448544.camel@web.de>
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in
 mmap_region()
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Andrew Morton	
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 	spasswolf@web.de
Date: Tue, 01 Oct 2024 12:22:35 +0200
In-Reply-To: <81235f36-7266-4ce0-8175-7c4d0e6ae3de@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
	 <5ec8665e-2f51-4b06-b68a-c878a969fb06@lucifer.local>
	 <cdbf216338d40b0aa768f93b0fe5aff1994ebd9c.camel@web.de>
	 <2f1a5621-1c3b-4c2e-97c4-86e36bc47788@lucifer.local>
	 <9a97af91ba1925629d5c7fa1f1aec34f92123a15.camel@web.de>
	 <fdaa29c2-e1de-4f77-a23e-8fa7523919b2@lucifer.local>
	 <32226c4d16d2a17d8dbdbbd007d583a2a6a2663c.camel@web.de>
	 <cb24ddf8-2299-4b65-af04-e8a1ecc180e2@lucifer.local>
	 <386f485c-5dec-4c7c-81f8-a23aa98a72e7@lucifer.local>
	 <0e9eb75f6342a7aaa1fd0eee3dcbbb15fb1f6539.camel@web.de>
	 <81235f36-7266-4ce0-8175-7c4d0e6ae3de@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hb98AGjUe1kV9kcBQafqL9SiKEx9gQ8VMnEjaYCsqVMqmqYvPXo
 q5zbR9ekaZ/cbkQNftBwfAtKXwHJKJoAT4g+vXd95L2QZOojS3mS58AWmIZIcANYcueOSz6
 gxbCyt1bFVDTgqpHGB7o679n4cFSSR5O3Srmch+gHjwGQbNb3iIIqrPcKN3iMHIpUyBqm24
 UX+MxLQs8WdxMnznQ/pVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RDlJ2IsfdXo=;7DVkp2jHxkKta9UtEaKy1iFR6/C
 w256zxMEbcoxq1tCdp7h90tcEz83GWPTJZhFJFJxIStdcBvs6UaUX4OqLR4Yz3pNLNQRxY92T
 k2VHbAQHiKjYlGY1/JlCaF/9W9wwtSYgN4Is/4kZnsmKKr1ecUxiCcip1CrQw5teWuRqeGtx2
 Qk5vkHmXy2WSaCEeZU37y+yU/T5/RqNmzTor7GFw6BA3qPfEGoE9Z0ZTjWNFTL2vzzYidVxdf
 qf/5sCbpHDMYdayZBbY6RhPiYIsm3045bm6yTK/12z9MokSpISfnyk8zBBGyQbideA43e0LUS
 eeoydTu+ryY8rCNDViCcXB8Cf0jUR8/zjj+prclRSgydmr1R/ybSbGCxOt+xXgYAUe4SsI4tj
 w1HqJKT1Jw1Y+A4+U7shxpsSoFfvW5P+kJC/lbk1/2SLgQ0o1xNdlqI1tmkuEnkYC+NovuVH2
 B5U/uP5/a16KgN+CkzbeeQ4g5RatusuYOffnN7NOh1BIy0ouqbx0lOq+8vczPkGNF+KBI6IFy
 Xd0zd02CX8OGg3uLfo8Oh2lDzLFqwGhfa1qpLMf0SWagZnQe2vt49h/lc3pLLvVLfngWJSSuE
 ww69Y3q0usGzFOr9hL07WWeaEcp2zkglBuvMY1Bu2OW9i5ouiqYnU2HnEOjwV8S7kV4HBkWIt
 YDd9OaeMqC4+VDU5W/0e99aaWK8OefY8UbjNfN35QQFAYMR9Pfi+kMnkY3clPs4t32ZyU3va2
 xSMTUSWRljBXZCiFG2bwGK+dMKMrXU3SdLPQ4c515OFv7EXkuDprfJVZHw9HcQvLPau5C04Tj
 f4n/W46Ntbv2yHtcZjnBkfrg==

Am Dienstag, dem 01.10.2024 um 11:02 +0100 schrieb Lorenzo Stoakes:
> On Tue, Oct 01, 2024 at 11:57:02AM GMT, Bert Karwatzki wrote:
> > Am Dienstag, dem 01.10.2024 um 10:49 +0100 schrieb Lorenzo Stoakes:
> > > On Tue, Oct 01, 2024 at 10:20:02AM GMT, Lorenzo Stoakes wrote:
> > > > On Tue, Oct 01, 2024 at 11:10:55AM GMT, Bert Karwatzki wrote:
> > > > > It seems that the maple tree broke down, here's the result of th=
e run with
> > > > > CONFIG_DEBUG_MAPLETREE=3Dy in all it's g(l)ory. (Here I didn't n=
eed to try to
> > > > > kill
> > > > > the processes to get an error and soon after the error occured e=
verything
> > > > > stopped working so I had to reboot via powerbutton.)
> > > > >
> > > > > Bert Karwatzki
> > > >
> > > > Yike thanks very much!
> > > >
> > > > If it's at all possible for you to confirm this happens on Linus's=
 tree
> > > > just to be super super sure (again I totally expect this) then tha=
t'd be
> > > > amazing.
> > > >
> > > > I ask because we have another thread which bisected a problem to t=
his
> > > > commit which we didn't think was the cause and seemed actually to =
be the
> > > > result of something else fiddling around with things it shouldn't =
so just
> > > > want to entirely rule that out (a fix was applied to Linus's tree =
for
> > > > that).
> > > >
> > > > [snip for snaity]
> > >
> > > OK so looking at the output it looks very much like your report is
> > > unfortunate truncated...
> > >
> > > There is a 'BUG at mas_validate_limits:7523 (1)' report but immediat=
ely
> > > prior to this there should be a line containing data formatted to "n=
ode%p:
> > > data_end %u !=3D the last slot offset %u".
> >
> > Actually one can just grab the report from /var/log/kern.log after a r=
eboot, I
> > just forgot to copy that line, here it is for the old report:
>
> Well depends on distro etc. I suspect systemd systems probably store too=
 but I
> like to go with the 'easy' or at least straightforward option :P thanks =
though!
> :)

Distro is debian sid, last updated 20240929.

> >
> > [ T4598] node00000000f48524f2: data_end 9 !=3D the last slot offset 8
> >
> > and here's the error report from next-20241001:
> >
>
> Can you confirm that's definitely the first line in any bug report in dm=
esg from
> boot? As after the first the tree is likely to get more corrupt and late=
r
> reports are just not going to be that useful.
>
> Could you upload the full dmesg somewhere and give a link? Or send it
> direct to me at lorenzo.stoakes@oracle.com? As pasting whole thing on li=
st
> might cause lore to sick up a bit. Possibly...
>
> Thanks!
>
> [snip]

I used bugzilla.kernel.org as a pastebin, here are both full dmesg logs:
https://bugzilla.kernel.org/show_bug.cgi?id=3D219338

Bert Karwatzki



