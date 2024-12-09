Return-Path: <linux-kernel+bounces-437882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 154039E9A09
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05372826D6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDF31BEF97;
	Mon,  9 Dec 2024 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="GPDhfPXV"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E71BEF98
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756853; cv=none; b=ULps0rnPCZ+Rm1TAyj1xmHFGtPCBi5mbRu6CQEUh6pkOQLRFhqDOyDUKiWzcQvhRmpNf2qdi64xE/PaA9V3+IQ81g2fNagOq9klQv7+O8/EN3/L9lm89r8FNrJj4/CPTF7KS19rJIOj2YeiQE30Ns1mBuXP7J9nJ2wf975FujEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756853; c=relaxed/simple;
	bh=9f3vujbTXO8uOl84Tyqa8qCxvsA2+EMws4ktPgevJV4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iHYU03UVpB6hwOWa1rCj90zaC4u/vjF1RmW396oYeUu5AANL8pQuhig6dQ391kFVKuYV4yXgTrdVOYvvLGcY8DOJpir6DwyB9aqJFnpSMv+wPFjJoFV/ojbpsh8iUqiyuWri8dpDNDwbMpLV94g4ZhCQrDiw6SpUS9reh8p9v40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=GPDhfPXV; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733756810; x=1734361610; i=efault@gmx.de;
	bh=3OrKUs/zb2+Sg602XGJwth7C4F6rxN0Awgtak4ba/io=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GPDhfPXVxP9A/PbUq3NcqeD7NlnAvYWQs2wO/lPGTAoS+w8VsaIB2CmFaKmoCUEn
	 cMRVz4IWuh9H8li57A8W0Xt8yuENjLVr/WQ0uyyt8iP78tpp3zpjD0dXjMhVY5dKy
	 xfnITywQd3fBYOCIXZMc64kCUhpG9QM8Qr2ZdoyHWgYthLSLnlz+on2+dYq3NJf1Y
	 UjFkGnF2iQmHHZ4YryMc0m326mL41mfFDAybv+zoaLkv/9NLvUkhueXCDoJG+/Pse
	 f4IuVjnQUfdK+Ac7P0A6tgT+Ung6vNmaZkWo1Eb2CQFkY380JwkNC8b4xemIienBN
	 lfYE2NJMXxLz7cWSzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.190]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FjR-1tELpG3OFj-00AKuB; Mon, 09
 Dec 2024 16:06:49 +0100
Message-ID: <b5239b5fd2680c4cef61d526a44fdb5a37c256b8.camel@gmx.de>
Subject: Re: [PATCH V2] sched/fair: Dequeue sched_delayed tasks when waking
 to a busy CPU
From: Mike Galbraith <efault@gmx.de>
To: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, 
 youssefesmat@chromium.org, tglx@linutronix.de
Date: Mon, 09 Dec 2024 16:06:48 +0100
In-Reply-To: <20241209131110.GC117639@pauld.westford.csb>
References: <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
	 <20241114112854.GA471026@pauld.westford.csb>
	 <20241119113016.GB66918@pauld.westford.csb>
	 <bede25619ef6767bcd38546e236d35b7dadd8bd4.camel@gmx.de>
	 <915eab00325f2bf608bcb2bd43665ccf663d4084.camel@gmx.de>
	 <20241121115628.GB394828@pauld.westford.csb>
	 <bf4f50886c462ee1f33cc404843944fea4817616.camel@gmx.de>
	 <20241202162427.GB1226982@pauld.westford.csb>
	 <9c78aebb3fdb8af68937a0301fabc3acb3e20c2d.camel@gmx.de>
	 <20241202191252.GA1233297@pauld.westford.csb>
	 <20241209131110.GC117639@pauld.westford.csb>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wAYYlXVoZw2TRPxE4rc/77KB9H1z/UUvpIf4jqdp5RtwUSAOEyT
 Nl12iTbZ4sxaj3y/uyyEGtAUXbJKVuEYtTvDaTB2Es26p5emXsvpUgH5p8FZm2YRrocyCQ3
 DHSez03BkwZBe+our+nosYkbx3WTdEPNga5ac3TBrzCET9Cu8/D2NX5HfJlZ4Si1yztm/BW
 iq5jgvHdYSihT5UrK9pog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C9ThPDmQbsw=;V/pbmfcMlUedIU/AgzYwjWO3yg7
 l0A1ZWkWRHvbESkkoo4OevBscz8LoAuryF+HJPEmFw9ewUEg1na/o7r1/MMcVFDFTEzRZ2NLj
 Ch2sksPcML8xDXhduPRwNMgtV0c4mmYpy9nW5LjJs00ZAoppzbnT6t6D5AHYcizB3wqBT6NX6
 edXVD36R3ehUMf+URrkHTdzjPM5fzvJWqlzzSnE+805N24e1CZEZVy1fxF1d0Likx2ynKBXa+
 /+PC/LUU+4GmE1msC5ZYNIW7ZLdX3S6Os2rU/zPLI2I76UBCre66yJAYSavTx12K4kwjrpBwX
 3JMgPezXf/YSofxh6A0MDW+cii/iW8Lwb+GTCrQcyT8XWy4Uv3ZO7UmHhkGanfoFmTFAcmy8c
 DMc0pqN8WbdqrhjSpuaXIfgU/A/WwvfHxv0Ozk8UsiixOiDiG0kkAKT2kLVB2I+LxAlxyH+wO
 lVDzuonX1dsQCyZ/rblNFv1SNqTiXvYsY9xR9L25pXuWwKNsMCmC4IH41/oc1zJ5cRGilR0pw
 Z4cIKy4Z1hM8SdysF50/mKSN2FE3NkxDJucgcDelyzEV2zHN3Xam4x3Ng7PrCHBB5AxvSA28s
 ieBvhnitU81dBKkDwIzfDBYAJcTcO6GLLk7RBl5+kCI7JBXsEzShlvhRUx6IFnBCOsXhqsWUu
 SWAfCJIN8oZ0lQwsXlBJWa5GrVjD0lj+OYIupjgC/iRbufaMzMLRMBYjq8zgoQHU2YcvJhE49
 FJntS830sFLpD8QnkemUhD1p+OyJqmafJthE691EbwDTJe8KGqaFK34KoXwsxZ4WXUqi40Ede
 +1HBo/D2QuD/zDfDjWP8F6Q9fNPpOCMdlROPHtXqF6VKO4yQYYMg8U2cwV5CHm+hdRvlL1tSz
 o1V6lV2d7MgecVzcZ2i2Hucu+q7FG1KY8ICuEUOnRtlEb2bBcHc8a4pd7sYBJB58etYWbCbHO
 MdeHeZ0ZOqbgwr44JCPwy7XLR8OyYlvFJ6Qmv9OBPEXhumrHCvu+Gg5iehqxBJIV75O5H1tuN
 xLzUmVS0vKryIJblXmM8v8cbTo+a2Toho1mle0tCmd8cFh7sVNB2qAiAwX2Z1IPM7dhqO9GQm
 kzm17VwwoNpFuHXJoYB1D0zs32Fbnm

On Mon, 2024-12-09 at 08:11 -0500, Phil Auld wrote:
>
> Hi Mike et al.,
>
> On Mon, Dec 02, 2024 at 02:12:52PM -0500 Phil Auld wrote:
> > On Mon, Dec 02, 2024 at 05:55:28PM +0100 Mike Galbraith wrote:
> > > On Mon, 2024-12-02 at 11:24 -0500, Phil Auld wrote:
> > > > On Sat, Nov 23, 2024 at 09:44:40AM +0100 Mike Galbraith wrote:
> > > >
> > > >
> > > > > Question: did wiping off the evil leave any meaningful goodness =
behind?
> > > >
> > > > Is that for this patch?
> > >
> > > Yeah.=C2=A0 Trying it on my box with your write command line didn't =
improve
> > > the confidence level either.=C2=A0 My box has one CPU handling IRQs =
and
> > > waking pinned workers to service 8 fio instances.=C2=A0 Patch was us=
eless
> > > for that.
> > >
> >
> > I'll give it a try. Our "box" is multiple different boxes but the resu=
lts
> > vary somewhat.=C2=A0 The one I sent info about earlier in this thread =
is just
> > one of the more egregious and is the one the perf team lent me for a w=
hile.
> >
>
> In our testing this has the same effect as the original dequeue-when-del=
ayed
> fix.=C2=A0 It solves the randwrite issue and introduces the ~10-15% rand=
read
> regression.
>
> Seems to be a real trade-off here. The same guys who benefit from spread=
ing
> in one case benefit from staying put in the other...

Does as much harm as it does good isn't the mark of a keeper.  Oh well.

	-Mike

