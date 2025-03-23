Return-Path: <linux-kernel+bounces-572928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F69A6D07C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40255188C597
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5372313D8A3;
	Sun, 23 Mar 2025 18:04:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F171813B2B8
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742753041; cv=none; b=V8WgsjMULuhqiWItYbSitx+PAXhoICU0HX1rHMhFvwlyTSdcRA62kkj3vCSFfmWmWbItxYdLY3geQR8qciFt5yrfHhB2CebZ0DGTCZ8jXFLSGyCmPNfdnyzoK04mjzfmGRB2nmV2lCWmTY03ufAS6FWN4OhueJaNh00BehH01Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742753041; c=relaxed/simple;
	bh=nzq52aDDPv9mCUrT9fpqH1wjARvWobgYMwqIYt+vUuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPA1ph4yGe3if62aYd9oBhOM4OfTth0d4fKDW5ZeQXVyPvXR7+9r47A7Zp+NolL/juva2rnwK39tMEPHX454ND/PKAb/4R8vqrcq3EIBY2bGTuYwm1iZgv9hHV92aeHZNgI9GmdRRS6HDp+SRsMIc2Iqi7rlgE+JDFRpuaUijFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443A9C4CEE2;
	Sun, 23 Mar 2025 18:03:59 +0000 (UTC)
Date: Sun, 23 Mar 2025 14:03:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: ying chen <yc1082463@gmail.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Subject: Re: [bug report, 6.1.52] /proc/loadavg shows incorrect values
Message-ID: <20250323140358.61c1ad10@batman.local.home>
In-Reply-To: <CAN2Y7hyM6pAupptUZx-cQsbTimxYSYKinyrSGBLYq5i3Dbxmgw@mail.gmail.com>
References: <CAN2Y7hwHWFpVRL3ZTSmKn2CGtixDBdszxofE4DSUx0rAOeK41g@mail.gmail.com>
	<CAN2Y7hyM6pAupptUZx-cQsbTimxYSYKinyrSGBLYq5i3Dbxmgw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 23 Mar 2025 20:45:51 +0800
ying chen <yc1082463@gmail.com> wrote:

> Hello everyone. Have you ever encountered a similar situation?
>=20
> On Tue, Mar 18, 2025 at 9:54=E2=80=AFPM ying chen <yc1082463@gmail.com> w=
rote:
> >
> > Hello all,
> >
> > In our production environment, "cat /proc/loadavg" shows incorrect
> > huge values. The kernel version is 6.1.52. So far, at least four such
> > cases have been found. It seems to be a kernel bug.
> >
> > ~$ cat /proc/loadavg
> > 4294967392.49 4294967395.80 4294967395.83 87/16100 2341720
> >
> > top output is below:
> >
> > top - 21:12:13 up 191 days, 20:50,  1 user,  load average:
> > 4294967397.45, 4294967396.82, 4294967396.15

  4294967397 =3D 0x100000065

Which looks like some calculation overflowed.

191 day uptime is quite long (I reboot to update my kernel every
month). Perhaps there's something there that caused an overflow.

Interestingly in 5.14, some values were converted from long to int. Not
sure if there was anything there that could have caused this.

Just something to look at.

-- Steve


> > Tasks: 2388 total,   3 running, 1208 sleeping,   0 stopped,   0 zombie
> > %Cpu(s): 27.9 us,  6.7 sy,  0.0 ni, 57.3 id,  0.5 wa,  1.7 hi,  5.8 si,=
  0.0 st
> > KiB Mem : 99966995+total, 56704217+free, 22655678+used, 20607096+buff/c=
ache
> > KiB Swap:        0 total,        0 free,        0 used. 68817177+avail =
Mem =20


