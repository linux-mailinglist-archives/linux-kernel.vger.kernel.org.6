Return-Path: <linux-kernel+bounces-259186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8086A939255
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F0D1C216BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A1916EB61;
	Mon, 22 Jul 2024 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="ANXBP8w9"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373038F70
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721664612; cv=none; b=XmadRIWYlldeWpgXxLy3KwQnONfZK9T9RtXkk4UlWyGy8tqxfWqCv3EBJH7iwZX5XqeQLbL0wgwfmX0GpZOuql+EuT9lsK77JXWq2/dmvtSMRUMz62/XtWhCdSy94CTimspD8x1XT/vYKF3vEK++oHFgqNb1QLTQtpwJJr6Ym9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721664612; c=relaxed/simple;
	bh=KPqpw+Rw363nK1U4y/Ityjaf6K1QdFD+vTvOqNdWhUo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BcEkcsdzEICMzLGVSm74Xuf5BlETqU60nbBquqWBsvUKDaKAw8KqP1PR6EOLoPipOFPJZrtm6aCWdsYXe40ESjRwf0vfNcYOlRgSxt81G0p2JlJDtxihbL41zE23jjs6UmpgL6Ymc4HIzGE5cAfpmApzsTCJ4C2Idcvij4e0G+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=ANXBP8w9; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721664595; x=1722269395; i=spasswolf@web.de;
	bh=Q6n9mqxDqEcK3NlYYkLieebEU0QAs+R9mU1jL02YaxY=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ANXBP8w9PfbCiI5SgKxuv0ONq8iV9GGzr+Ih4dGz5TgCIC1URxTxsU8Rxx7JwNeQ
	 VPW6NLbKEWopHggfjLdtGaMxZAwoM3h1GL72uTTHjH0nPiIZCNX2iH9mQM/7rxZyK
	 FG49+a0Yu/vSzWFHtDg6tgWdV2TlwJODhqT9v5MJZMi26lnbC/q2WQcOD1dRiPLnl
	 2OqRUF/Biwlw2CGolODwK9Qw/O6hssiWrMI69p6eNh6KUU/jF/cfdceJ6s74p4TbC
	 z99HuPTyjTHbVzT+SfFuCMq9VCiSDbKgHJPDykyCHpbkT6fsFKteelebuCQNTbvjF
	 oxjKxQuUwsfpUaS0zQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxHYA-1s7geg3pwO-00x2nQ; Mon, 22
 Jul 2024 18:09:54 +0200
Message-ID: <804033d07a13a8c53c9dc8a55c2383799f55020e.camel@web.de>
Subject: Re: commit 7a5ee4aa61af causes warning on boot
From: Bert Karwatzki <spasswolf@web.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, tglx@linutronix.de, 
	linux-kernel@vger.kernel.org, spasswolf@web.de
Date: Mon, 22 Jul 2024 18:09:54 +0200
In-Reply-To: <Zp5cPikQUTgQxcHS@localhost.localdomain>
References: <20240722123912.3602-1-spasswolf@web.de>
	 <Zp5cPikQUTgQxcHS@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c/E4oyMG0BZjPyopXOAxVZLNi8onkyW6j3uzhOxpV+gpNIzFs0R
 IFIcjje9D6cwkik89JIW0QC5qHP1OITvPBVg+8Uk9t/S3azchgm0uG26VAvjnlC5UbeEkui
 g0cG1CoqFWqShtDE9mxcMm2p6bqLpONVhJbSLiaEzlVdqA8vCR3iRDj3OD8LTOwNo9ud7IW
 68Lw/k36l+0d7sDT9jf3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:irX6kDWpysE=;VVrJo98Pdq5ZOtZ/o5xm9YUwk71
 TpqAS24U8soZtJEHbWi+ruLOxO7H3srAbieKkoYTyb8SpoFKx7Ca2SxGdx/9okbJucVX5/n6Z
 EfWAD/WY0q+dkPeq587KukRzBngbETgS5aLzyqeYFYTV5ETaHatY6h2B1WoM25sFdYeZOqjf8
 OYQ3G7llp6S9RAatb/1htyePWD/FZqIZImdU6Chu37wqwZv5RfDUAkqzMZ8b8wUrQIRgD/+cz
 r/214s7RHQNWx5IctRjE4HcHjCyUAzB39QyV7NvcI1mqeRTRPvkD/i5uXgz1SXp22ze5GFZ5x
 ug0KgIz0C2zwEg/CCH7Ijfiu/aIRVQc+yb1BB0DnmHaINJx3SqfqBUbJF9YFyjG5Tb94XChZc
 PMXYejxqqk56nXQ20rw6WsW2DLbC938ramD03gFC+RyqP4OTRF8NOQqyEpoo9i3667ui1E5bl
 KkzV5jR8mCxcoCZ/S5J5MHcvbR4SMx6qwfngU4gayMj8CBc9xXy8m2XU4TU5sBMXiG3+vu6Y0
 KbYbqjSO0Owq77o7IlmEWdZ3Mv77wRypodOY11nYa/VwEGHJWK3V6rFCmhR6mbjNjcGcVUdrX
 XI2zhvWteko44GRhJgypOU5ObzvOccR+8nu1bulAnY9TGBXt37GBcI1CaKrC3FeOubVVhJqJJ
 JIKq/cbUyNTj/2EoVS/vXZWaHSjQd5TWydfe3ccXDaAoPioqKw8yz14PRLtR9dRQEVuSjrEGX
 9xywfbVHyeBtKLPGtxxZsH7J8t85T886NRd+SZiIydqLrAmJef2AdZ2FK0F+VBeg93XRUqcGW
 tQ5IpyQIzRJgJZA5gO2Y8FvA==

Am Montag, dem 22.07.2024 um 15:18 +0200 schrieb Frederic Weisbecker:
> Le Mon, Jul 22, 2024 at 02:39:11PM +0200, Bert Karwatzki a =C3=A9crit :
> > Since linux-next-20240722 the following warning is shown on boot which=
 can
> > be bisected to commit 7a5ee4aa61af:
> >
> > [    T1] ------------[ cut here ]------------
> > [    T1] WARNING: CPU: 0 PID: 1 at kernel/time/timer_migration.c:1742
> > tmigr_cpu_prepare+0x469/0x540
>
> Good catch, and here is a fix proposal (untested!):
>
> https://lore.kernel.org/all/Zp5bpLJHlYsZinGj@localhost.localdomain/
Just tested the patch with linux-next-20240722, it works for me.

Bert Karwatzki

