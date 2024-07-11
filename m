Return-Path: <linux-kernel+bounces-248860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA55292E2D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0751C21CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772FF154449;
	Thu, 11 Jul 2024 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="D/yo9PPI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="UQFJaNHk"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8D78283
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688190; cv=none; b=Q5puehqJnopCKZiPMgfy/RqK0QubPoM6ZDnRrx5QZI3UQIstvMGPmzbHErnLJYdD9FR2NHcZlSBHBQX/PXTG55ET/zhHQRxrNy2LVE7L/coZWzpCptZQHU+V+ZsAokjwfYFsS9A7rqSnPu2XhxcfSOahrQwp0Idv26gjxcTNJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688190; c=relaxed/simple;
	bh=AFh67yJBhp9opCNI6CDPp2pCSN3rJD5px+/AtHVVc1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDTOPt37vq4HjA/pxdQVu+GrW90NRCUPaihG9EaAUiv+28ewnoB9WY/eROYtO8kC87sg7vfYL4T9RxC5TO8Ur3BmVKqaKNGTVVsvO910Or4ZpKSIOaaG9pf1AtpBjwjYnib5tyFR+VHEDwxkz4DFLhP32qSGBEpimtiyj0pa49w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=D/yo9PPI; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=UQFJaNHk reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1720688186; x=1752224186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H9qlI4pk+ye2RpN83vQxNvan7I0OeFogdvLcBH4HVJs=;
  b=D/yo9PPIN7mgASoCSjgyNqMfRXnZwABEItjEvIGnJ9SSkbzjKjZx1lnK
   VDXHUe0cSUeqCq5oZIxEm3rghhDCgXQpB3DnHyi/8nfxeZaYzzjlrO95h
   vB1EAJcZcaN1GAmF8toZFHBI7G53M6NLJK/p363Kj448iBCyKSHjnp725
   KvDD6W/H+iIqfzqG950q3Wd2VaQ/+kaUjDb3x7Rw8RP641Q9r7EzZTBAS
   eIKA6MGahgDSvcx0XdzPZnrom0zCxJRlxEONmXI7C1CtquAbdSSmHSG2Z
   7h6fCa5bkCAfAvtgp+u3MmLJXWVxTs55rZAMhdBJhI3NT2Uxc0aHXXRL5
   w==;
X-CSE-ConnectionGUID: ABsygcojSe6Dt49ugvv40w==
X-CSE-MsgGUID: c9PtCTAARaODurvovE919Q==
X-IronPort-AV: E=Sophos;i="6.09,199,1716242400"; 
   d="scan'208";a="37857163"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Jul 2024 10:56:16 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31698160A83;
	Thu, 11 Jul 2024 10:56:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1720688172;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=H9qlI4pk+ye2RpN83vQxNvan7I0OeFogdvLcBH4HVJs=;
	b=UQFJaNHknVDh0mcP7+cI4+tyhBPiCLoqsMIjDNgTDdWif/hXw6X8pFbPzla4OnMwKUMz6q
	zXPL1H2246ZC/ojG8x+yQgXJ+ggcGzGLQHXsGgVNjVyTsMYkCUKr7nc1RRJBpIfBTxFa72
	nP7qJgJrQfo1Ux/x+L7cpcdbuaCHTE2+2mpDv9BstyV4FZLr4f9W63RP4MtO8jtYfw+iDO
	EBRgibiwoS3vwVpKbooccZe1lrXoK6E1ijmgOU3DUXx8G1a+xD92AkRfUpWbxPT9tBhp54
	QtG5HFr1/ZZgokcqDyRyUbdO66ChwfASGTA/z+r2jZvTsDLrCSKYmPvWdHIP3w==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH v4 2/8] timers/migration: Move hierarchy setup into cpuhotplug prepare callback
Date: Thu, 11 Jul 2024 10:56:17 +0200
Message-ID: <3580126.iIbC2pHGDl@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240703202839.8921-1-anna-maria@linutronix.de>
References: <20240701-tmigr-fixes-v3-2-25cd5de318fb@linutronix.de> <20240703202839.8921-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Mittwoch, 3. Juli 2024, 22:28:39 CEST schrieb Anna-Maria Behnsen:
> When a CPU comes online the first time, it is possible that a new top lev=
el
> group will be created. In general all propagation is done from the bottom
> to top. This minimizes complexity and prevents possible races. But when a
> new top level group is created, the formely top level group needs to be
> connected to the new level. This is the only time, when the direction to
> propagate changes is changed: the changes are propagated from top (new top
> level group) to bottom (formerly top level group).

Now that this commit is integrated in linux-next I'm starting to see the
kernel error message:
> Timer migration setup failed
on my arm64 i.MX8MP platform (imx8mp-tqma8mpql-mba8mpxl.dts).

Reverting the following commits
* 746770499be55cf375a108a321a818b238182446
* 2e0bd37f7b395173f879225b9d8b1811af4a8a35

* 633c77727d32ab3487a10ec8f125c26b416236ad
* 56f9a5fd69eae92d7051a228ee192452248a6bdc
* 6dbb59418c5c7b014e542db76595417c9b95ccde
* 6d8a8f54e045e2030eebb53b5ce859c80d9425f6
* 8cdb61838ee5c63556773ea2eed24deab6b15257

I could get rid of that error message.

Best regards,
Alexander

> This introduces two races (see (A) and (B)) as reported by Frederic:
>=20
> (A) This race happens, when marking the formely top level group as active,
> but the last active CPU of the formerly top level group goes idle. Then
> it's likely that formerly group is no longer active, but marked
> nevertheless as active in new top level group:
>=20
> 		  [GRP0:0]
> 	       migrator =3D 0
> 	       active   =3D 0
> 	       nextevt  =3D KTIME_MAX
> 	       /         \
> 	      0         1 .. 7
> 	  active         idle
>=20
> 0) Hierarchy has for now only 8 CPUs and CPU 0 is the only active CPU.
>=20
> 			     [GRP1:0]
> 			migrator =3D TMIGR_NONE
> 			active   =3D NONE
> 			nextevt  =3D KTIME_MAX
> 					 \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator =3D 0              migrator =3D TMIGR_NONE
> 	      active   =3D 0              active   =3D NONE
> 	      nextevt  =3D KTIME_MAX      nextevt  =3D KTIME_MAX
> 		/         \
> 	      0          1 .. 7                8
> 	  active         idle                !online
>=20
> 1) CPU 8 is booting and creates a new group in first level GRP0:1 and
>    therefore also a new top group GRP1:0. For now the setup code proceeded
>    only until the connected between GRP0:1 to the new top group. The
>    connection between CPU8 and GRP0:1 is not yet established and CPU 8 is
>    still !online.
>=20
> 			     [GRP1:0]
> 			migrator =3D TMIGR_NONE
> 			active   =3D NONE
> 			nextevt  =3D KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator =3D 0              migrator =3D TMIGR_NONE
> 	      active   =3D 0              active   =3D NONE
> 	      nextevt  =3D KTIME_MAX      nextevt  =3D KTIME_MAX
> 		/         \
> 	      0          1 .. 7                8
> 	  active         idle                !online
>=20
> 2) Setup code now connects GRP0:0 to GRP1:0 and observes while in
>    tmigr_connect_child_parent() that GRP0:0 is not TMIGR_NONE. So it
>    prepares to call tmigr_active_up() on it. It hasn't done it yet.
>=20
> 			     [GRP1:0]
> 			migrator =3D TMIGR_NONE
> 			active   =3D NONE
> 			nextevt  =3D KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator =3D TMIGR_NONE        migrator =3D TMIGR_NONE
> 	      active   =3D NONE              active   =3D NONE
> 	      nextevt  =3D KTIME_MAX         nextevt  =3D KTIME_MAX
> 		/         \
> 	      0          1 .. 7                8
> 	    idle         idle                !online
>=20
> 3) CPU 0 goes idle. Since GRP0:0->parent has been updated by CPU 8 with
>    GRP0:0->lock held, CPU 0 observes GRP1:0 after calling
>    tmigr_update_events() and it propagates the change to the top (no chan=
ge
>    there and no wakeup programmed since there is no timer).
>=20
> 			     [GRP1:0]
> 			migrator =3D GRP0:0
> 			active   =3D GRP0:0
> 			nextevt  =3D KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator =3D TMIGR_NONE       migrator =3D TMIGR_NONE
> 	      active   =3D NONE             active   =3D NONE
> 	      nextevt  =3D KTIME_MAX        nextevt  =3D KTIME_MAX
> 		/         \
> 	      0          1 .. 7                8
> 	    idle         idle                !online
>=20
> 4) Now the setup code finally calls tmigr_active_up() to and sets GRP0:0
>    active in GRP1:0
>=20
> 			     [GRP1:0]
> 			migrator =3D GRP0:0
> 			active   =3D GRP0:0, GRP0:1
> 			nextevt  =3D KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator =3D TMIGR_NONE       migrator =3D 8
> 	      active   =3D NONE             active   =3D 8
> 	      nextevt  =3D KTIME_MAX        nextevt  =3D KTIME_MAX
> 		/         \                    |
> 	      0          1 .. 7                8
> 	    idle         idle                active
>=20
> 5) Now CPU 8 is connected with GRP0:1 and CPU 8 calls tmigr_active_up() o=
ut
>    of tmigr_cpu_online().
>=20
> 			     [GRP1:0]
> 			migrator =3D GRP0:0
> 			active   =3D GRP0:0
> 			nextevt  =3D T8
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator =3D TMIGR_NONE         migrator =3D TMIGR_NONE
> 	      active   =3D NONE               active   =3D NONE
> 	      nextevt  =3D KTIME_MAX          nextevt  =3D T8
> 		/         \                    |
> 	      0          1 .. 7                8
> 	    idle         idle                  idle
>=20
> 5) CPU 8 goes idle with a timer T8 and relies on GRP0:0 as the migrator.
>    But it's not really active, so T8 gets ignored.
>=20
> --> The update which is done in third step is not noticed by setup code. =
So
>     a wrong migrator is set to top level group and a timer could get
>     ignored.
>=20
> (B) Reading group->parent and group->childmask when an hierarchy update is
> ongoing and reaches the formerly top level group is racy as those values
> could be inconsistent. (The notation of migrator and active now slightly
> changes in contrast to the above example, as now the childmasks are used.)
>=20
> 			     [GRP1:0]
> 			migrator =3D TMIGR_NONE
> 			active   =3D 0x00
> 			nextevt  =3D KTIME_MAX
> 					 \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator =3D TMIGR_NONE     migrator =3D TMIGR_NONE
> 	      active   =3D 0x00           active   =3D 0x00
> 	      nextevt  =3D KTIME_MAX      nextevt  =3D KTIME_MAX
> 	      childmask=3D 0		childmask=3D 1
> 	      parent   =3D NULL		parent   =3D GRP1:0
> 		/         \
> 	      0          1 .. 7                8
> 	  idle           idle                !online
> 	  childmask=3D1
>=20
> 1) Hierarchy has 8 CPUs. CPU 8 is at the moment in the process of onlining
>    but did not yet connect GRP0:0 to GRP1:0.
>=20
> 			     [GRP1:0]
> 			migrator =3D TMIGR_NONE
> 			active   =3D 0x00
> 			nextevt  =3D KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator =3D TMIGR_NONE     migrator =3D TMIGR_NONE
> 	      active   =3D 0x00           active   =3D 0x00
> 	      nextevt  =3D KTIME_MAX      nextevt  =3D KTIME_MAX
> 	      childmask=3D 0		childmask=3D 1
> 	      parent   =3D GRP1:0		parent   =3D GRP1:0
> 		/         \
> 	      0          1 .. 7                8
> 	  idle           idle                !online
> 	  childmask=3D1
>=20
> 2) Setup code (running on CPU 8) now connects GRP0:0 to GRP1:0, updates
>    parent pointer of GRP0:0 and ...
>=20
> 			     [GRP1:0]
> 			migrator =3D TMIGR_NONE
> 			active   =3D 0x00
> 			nextevt  =3D KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator =3D 0x01           migrator =3D TMIGR_NONE
> 	      active   =3D 0x01           active   =3D 0x00
> 	      nextevt  =3D KTIME_MAX      nextevt  =3D KTIME_MAX
> 	      childmask=3D 0		childmask=3D 1
> 	      parent   =3D GRP1:0		parent   =3D GRP1:0
> 		/         \
> 	      0          1 .. 7                8
> 	  active          idle                !online
> 	  childmask=3D1
>=20
> 	  tmigr_walk.childmask =3D 0
>=20
> 3) ... CPU 0 comes active in the same time. As migrator in GRP0:0 was
>    TMIGR_NONE, childmask of GRP0:0 is stored in update propagation data
>    structure tmigr_walk (as update of childmask is not yet
>    visible/updated). And now ...
>=20
> 			     [GRP1:0]
> 			migrator =3D TMIGR_NONE
> 			active   =3D 0x00
> 			nextevt  =3D KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator =3D 0x01           migrator =3D TMIGR_NONE
> 	      active   =3D 0x01           active   =3D 0x00
> 	      nextevt  =3D KTIME_MAX      nextevt  =3D KTIME_MAX
> 	      childmask=3D 2		childmask=3D 1
> 	      parent   =3D GRP1:0		parent   =3D GRP1:0
> 		/         \
> 	      0          1 .. 7                8
> 	  active          idle                !online
> 	  childmask=3D1
>=20
> 	  tmigr_walk.childmask =3D 0
>=20
> 4) ... childmask of GRP0:0 is updated by CPU 8 (still part of setup
>    code).
>=20
> 			     [GRP1:0]
> 			migrator =3D 0x00
> 			active   =3D 0x00
> 			nextevt  =3D KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator =3D 0x01           migrator =3D TMIGR_NONE
> 	      active   =3D 0x01           active   =3D 0x00
> 	      nextevt  =3D KTIME_MAX      nextevt  =3D KTIME_MAX
> 	      childmask=3D 2		childmask=3D 1
> 	      parent   =3D GRP1:0		parent   =3D GRP1:0
> 		/         \
> 	      0          1 .. 7                8
> 	  active          idle                !online
> 	  childmask=3D1
>=20
> 	  tmigr_walk.childmask =3D 0
>=20
> 5) CPU 0 sees the connection to GRP1:0 and now propagates active state to
>    GRP1:0 but with childmask =3D 0 as stored in propagation data structur=
e.
>=20
> --> Now GRP1:0 always has a migrator as 0x00 !=3D TMIGR_NONE and for all =
CPUs
>     it looks like GRP1:0 is always active.
>=20
> To prevent those races, the setup of the hierarchy is moved into the
> cpuhotplug prepare callback. The prepare callback is not executed by the
> CPU which will come online, it is executed by the CPU which prepares
> onlining of the other CPU. This CPU is active while it is connecting the
> formerly top level to the new one. This prevents from (A) to happen and it
> also prevents from any further walk above the formerly top level until th=
at
> active CPU becomes inactive, releasing the new ->parent and ->childmask
> updates to be visible by any subsequent walk up above the formerly top
> level hierarchy. This prevents from (B) to happen. The direction for the
> updates is now forced to look like "from bottom to top".
>=20
> However if the active CPU prevents from tmigr_cpu_(in)active() to walk up
> with the update not-or-half visible, nothing prevents walking up to the n=
ew
> top with a 0 childmask in tmigr_handle_remote_up() or
> tmigr_requires_handle_remote_up() if the active CPU doing the prepare is
> not the migrator. But then it looks fine because:
>=20
>   * tmigr_check_migrator() should just return false
>   * The migrator is active and should eventually observe the new childmask
>     at some point in a future tick.
>=20
> Split setup functionality of online callback into the cpuhotplug prepare
> callback and setup hotplug state. Reorder the code, that all prepare
> related functions are close to each other and online and offline callbacks
> are also close together.
>=20
> Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  include/linux/cpuhotplug.h    |   1 +
>  kernel/time/timer_migration.c | 181 +++++++++++++++++++---------------
>  2 files changed, 101 insertions(+), 81 deletions(-)
>=20
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 7a5785f405b6..df59666a2a66 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -122,6 +122,7 @@ enum cpuhp_state {
>  	CPUHP_KVM_PPC_BOOK3S_PREPARE,
>  	CPUHP_ZCOMP_PREPARE,
>  	CPUHP_TIMERS_PREPARE,
> +	CPUHP_TMIGR_PREPARE,
>  	CPUHP_MIPS_SOC_PREPARE,
>  	CPUHP_BP_PREPARE_DYN,
>  	CPUHP_BP_PREPARE_DYN_END		=3D CPUHP_BP_PREPARE_DYN + 20,
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index d91efe1dc3bf..9b86efded4d5 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -1438,6 +1438,66 @@ u64 tmigr_quick_check(u64 nextevt)
>  	return KTIME_MAX;
>  }
> =20
> +/*
> + * tmigr_trigger_active() - trigger a CPU to become active again
> + *
> + * This function is executed on a CPU which is part of cpu_online_mask, =
when the
> + * last active CPU in the hierarchy is offlining. With this, it is ensur=
ed that
> + * the other CPU is active and takes over the migrator duty.
> + */
> +static long tmigr_trigger_active(void *unused)
> +{
> +	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
> +
> +	WARN_ON_ONCE(!tmc->online || tmc->idle);
> +
> +	return 0;
> +}
> +
> +static int tmigr_cpu_offline(unsigned int cpu)
> +{
> +	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
> +	int migrator;
> +	u64 firstexp;
> +
> +	raw_spin_lock_irq(&tmc->lock);
> +	tmc->online =3D false;
> +	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
> +
> +	/*
> +	 * CPU has to handle the local events on his own, when on the way to
> +	 * offline; Therefore nextevt value is set to KTIME_MAX
> +	 */
> +	firstexp =3D __tmigr_cpu_deactivate(tmc, KTIME_MAX);
> +	trace_tmigr_cpu_offline(tmc);
> +	raw_spin_unlock_irq(&tmc->lock);
> +
> +	if (firstexp !=3D KTIME_MAX) {
> +		migrator =3D cpumask_any_but(cpu_online_mask, cpu);
> +		work_on_cpu(migrator, tmigr_trigger_active, NULL);
> +	}
> +
> +	return 0;
> +}
> +
> +static int tmigr_cpu_online(unsigned int cpu)
> +{
> +	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
> +
> +	/* Check whether CPU data was successfully initialized */
> +	if (WARN_ON_ONCE(!tmc->tmgroup))
> +		return -EINVAL;
> +
> +	raw_spin_lock_irq(&tmc->lock);
> +	trace_tmigr_cpu_online(tmc);
> +	tmc->idle =3D timer_base_is_idle();
> +	if (!tmc->idle)
> +		__tmigr_cpu_activate(tmc);
> +	tmc->online =3D true;
> +	raw_spin_unlock_irq(&tmc->lock);
> +	return 0;
> +}
> +
>  static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
>  			     int node)
>  {
> @@ -1512,7 +1572,7 @@ static struct tmigr_group *tmigr_get_group(unsigned=
 int cpu, int node,
>  static void tmigr_connect_child_parent(struct tmigr_group *child,
>  				       struct tmigr_group *parent)
>  {
> -	union tmigr_state childstate;
> +	struct tmigr_walk data;
> =20
>  	raw_spin_lock_irq(&child->lock);
>  	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
> @@ -1540,22 +1600,24 @@ static void tmigr_connect_child_parent(struct tmi=
gr_group *child,
>  	 *   child to the new parent. So tmigr_connect_child_parent() is
>  	 *   executed with the formerly top level group (child) and the newly
>  	 *   created group (parent).
> +	 *
> +	 * * It is ensured that the child is active, as this setup path is
> +	 *   executed in hotplug prepare callback. This is exectued by an
> +	 *   already connected and !idle CPU. Even if all other CPUs go idle,
> +	 *   the CPU executing the setup will be responsible up to current top
> +	 *   level group. And the next time it goes inactive, it will release
> +	 *   the new childmask and parent to subsequent walkers through this
> +	 *   @child. Therefore propagate active state unconditionally.
>  	 */
> -	childstate.state =3D atomic_read(&child->migr_state);
> -	if (childstate.migrator !=3D TMIGR_NONE) {
> -		struct tmigr_walk data;
> -
> -		data.childmask =3D child->childmask;
> +	data.childmask =3D child->childmask;
> =20
> -		/*
> -		 * There is only one new level per time (which is protected by
> -		 * tmigr_mutex). When connecting the child and the parent and
> -		 * set the child active when the parent is inactive, the parent
> -		 * needs to be the uppermost level. Otherwise there went
> -		 * something wrong!
> -		 */
> -		WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
> -	}
> +	/*
> +	 * There is only one new level per time (which is protected by
> +	 * tmigr_mutex). When connecting the child and the parent and set the
> +	 * child active when the parent is inactive, the parent needs to be the
> +	 * uppermost level. Otherwise there went something wrong!
> +	 */
> +	WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
>  }
> =20
>  static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
> @@ -1661,80 +1723,32 @@ static int tmigr_add_cpu(unsigned int cpu)
>  	return ret;
>  }
> =20
> -static int tmigr_cpu_online(unsigned int cpu)
> +static int tmigr_cpu_prepare(unsigned int cpu)
>  {
> -	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
> -	int ret;
> -
> -	/* First online attempt? Initialize CPU data */
> -	if (!tmc->tmgroup) {
> -		raw_spin_lock_init(&tmc->lock);
> -
> -		ret =3D tmigr_add_cpu(cpu);
> -		if (ret < 0)
> -			return ret;
> -
> -		if (tmc->childmask =3D=3D 0)
> -			return -EINVAL;
> +	struct tmigr_cpu *tmc =3D per_cpu_ptr(&tmigr_cpu, cpu);
> +	int ret =3D 0;
> =20
> -		timerqueue_init(&tmc->cpuevt.nextevt);
> -		tmc->cpuevt.nextevt.expires =3D KTIME_MAX;
> -		tmc->cpuevt.ignore =3D true;
> -		tmc->cpuevt.cpu =3D cpu;
> -
> -		tmc->remote =3D false;
> -		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
> -	}
> -	raw_spin_lock_irq(&tmc->lock);
> -	trace_tmigr_cpu_online(tmc);
> -	tmc->idle =3D timer_base_is_idle();
> -	if (!tmc->idle)
> -		__tmigr_cpu_activate(tmc);
> -	tmc->online =3D true;
> -	raw_spin_unlock_irq(&tmc->lock);
> -	return 0;
> -}
> -
> -/*
> - * tmigr_trigger_active() - trigger a CPU to become active again
> - *
> - * This function is executed on a CPU which is part of cpu_online_mask, =
when the
> - * last active CPU in the hierarchy is offlining. With this, it is ensur=
ed that
> - * the other CPU is active and takes over the migrator duty.
> - */
> -static long tmigr_trigger_active(void *unused)
> -{
> -	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
> +	/* Not first online attempt? */
> +	if (tmc->tmgroup)
> +		return ret;
> =20
> -	WARN_ON_ONCE(!tmc->online || tmc->idle);
> +	raw_spin_lock_init(&tmc->lock);
> =20
> -	return 0;
> -}
> +	ret =3D tmigr_add_cpu(cpu);
> +	if (ret < 0)
> +		return ret;
> =20
> -static int tmigr_cpu_offline(unsigned int cpu)
> -{
> -	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
> -	int migrator;
> -	u64 firstexp;
> +	if (tmc->childmask =3D=3D 0)
> +		return -EINVAL;
> =20
> -	raw_spin_lock_irq(&tmc->lock);
> -	tmc->online =3D false;
> +	timerqueue_init(&tmc->cpuevt.nextevt);
> +	tmc->cpuevt.nextevt.expires =3D KTIME_MAX;
> +	tmc->cpuevt.ignore =3D true;
> +	tmc->cpuevt.cpu =3D cpu;
> +	tmc->remote =3D false;
>  	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
> =20
> -	/*
> -	 * CPU has to handle the local events on his own, when on the way to
> -	 * offline; Therefore nextevt value is set to KTIME_MAX
> -	 */
> -	firstexp =3D __tmigr_cpu_deactivate(tmc, KTIME_MAX);
> -	trace_tmigr_cpu_offline(tmc);
> -	raw_spin_unlock_irq(&tmc->lock);
> -
> -	if (firstexp !=3D KTIME_MAX) {
> -		migrator =3D cpumask_any_but(cpu_online_mask, cpu);
> -		work_on_cpu(migrator, tmigr_trigger_active, NULL);
> -	}
> -
> -	return 0;
> +	return ret;
>  }
> =20
>  static int __init tmigr_init(void)
> @@ -1793,6 +1807,11 @@ static int __init tmigr_init(void)
>  		tmigr_hierarchy_levels, TMIGR_CHILDREN_PER_GROUP,
>  		tmigr_crossnode_level);
> =20
> +	ret =3D cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:prepare",
> +				tmigr_cpu_prepare, NULL);
> +	if (ret)
> +		goto err;
> +
>  	ret =3D cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
>  				tmigr_cpu_online, tmigr_cpu_offline);
>  	if (ret)
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



