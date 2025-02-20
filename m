Return-Path: <linux-kernel+bounces-524196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB81FA3E057
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203CD167D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6793F1FFC6C;
	Thu, 20 Feb 2025 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="en1ePuD/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ADOby/gp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED31DF265
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068355; cv=none; b=I7Tn9/sw2FVXK2a8ivMDWrBbIzRFMBLATm2raAp3tSZbYi8jRKZy+GgnySu9ahtGalV6xvVu/yMpha70xsTe5gK2YqIQ+CirR/Dmc0VvxM8LxkMs5LsITZDgqKX6vzodYU88mJhnhPwoH9plnzjatGZVMxmBwiZAIs7P80tFwbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068355; c=relaxed/simple;
	bh=fFp8FJUokY1RmBp2mB7uX3L0RMS9vV9hiRF7+rlAn4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rqGmIsON/Pen+PZ8u6zGcoas5jWF/lsDDQsS4wgwgm7oFJzqsZvPJeCGaA0/ENusjmOZ1Cpi0reXOof3gwFrIEhNy107DikXvDgb1DtpkDyJh6K4nUusNvj0jaWyPFZBA6tm0NZONmcor/XwO2O5r8uoB7Z/XECplQoyBI2f1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=en1ePuD/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ADOby/gp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740068352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZ8WaAnDe7dn++wovr9Ki58qKgf9SgP+VlQv0BT4iZA=;
	b=en1ePuD/ennCbo3JTlznH30FweKS0IvBx8N2PLffzMcFvHhi/Vusd87M+qt4iydxhzaIVf
	bi3/wS/iCXvhzsexurNnQ+ig0ZRDBCsuZRh9xS19GkOv4c8yt5M20RBHDm1ejEOI6Q06Cg
	edYU5ZKtskXzIOc9jO0TAu9T9kdV99vZNWEgpRMvMnahfsRC/r6sN333kzD5Pr81cpacbz
	8aDskQSACnKeoSNHuhYkrWPv48UaivREvNRzeKERdjMKvAi3URnUz+RjWiXlPGW164joU1
	sFdskSNldy0KhdB7TnocN9o+t84rWsS7Xj8MVMt5ljkpdfSJzZ+w3NmD4jFsXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740068352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZ8WaAnDe7dn++wovr9Ki58qKgf9SgP+VlQv0BT4iZA=;
	b=ADOby/gpz3WJfQ3cu68XYbAr3xFAh5oM0wmO32oQlXaEgUrKzayNnuZ6psRDBqCP3XK3aR
	rzrdE8qplNEwukAw==
To: Eric Dumazet <edumazet@google.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Benjamin Segall <bsegall@google.com>, Eric Dumazet
 <eric.dumazet@gmail.com>
Subject: Re: [PATCH V2 1/4] posix-timers: Make next_posix_timer_id an atomic_t
In-Reply-To: <CANn89iKAiJvOXLC4SkWnsKC-6m9HU1KoYAVPE_G_UhOb__Gj0g@mail.gmail.com>
References: <20250219125522.2535263-1-edumazet@google.com>
 <20250219125522.2535263-2-edumazet@google.com> <87wmdlhwa8.ffs@tglx>
 <CANn89i+LJFHhA=VF2T5v_kN0=sFLeropuRERnhWdadj5w6kiyw@mail.gmail.com>
 <87h64oiuey.ffs@tglx> <8734g8it5m.ffs@tglx>
 <CANn89iKAiJvOXLC4SkWnsKC-6m9HU1KoYAVPE_G_UhOb__Gj0g@mail.gmail.com>
Date: Thu, 20 Feb 2025 17:19:11 +0100
Message-ID: <87wmdkh9mo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20 2025 at 16:55, Eric Dumazet wrote:
> On Thu, Feb 20, 2025 at 3:32=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>>
>> On Thu, Feb 20 2025 at 15:04, Thomas Gleixner wrote:
>> > On Thu, Feb 20 2025 at 09:49, Eric Dumazet wrote:
>> >> On Thu, Feb 20, 2025 at 9:09=E2=80=AFAM Thomas Gleixner <tglx@linutro=
nix.de> wrote:
>> >>> > This allows the following patch to use RCU.
>> >>>
>> >>> Your patch ordering is slightly off by two :)
>> >>>
>> >>> And it fails to explain for what RCU can be used....
>> >>
>> >> This is explained in the following patches.
>> >
>> > The changelog of a patch has to be self contained. The 'following patc=
h'
>> > has no meaning when the patch is merged.
>>
>> That said, please just fold this into the patch which actually does this=
 RCU
>> lookup upfront. The change is trivial enough that it does not really
>> require to be seperate. If the lockless increment would cause issues,
>> then the subsequent RCU lookup is the least of the worries :)
>
> I can squash all patches into a single one if you prefer.

Please don't. The wraparound race prevention has nothing to do with the
lookup optimization.

Thanks,

        tglx

