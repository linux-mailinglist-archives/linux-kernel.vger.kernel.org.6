Return-Path: <linux-kernel+bounces-235271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C059491D29F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 18:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4ED1F212B4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8775F155307;
	Sun, 30 Jun 2024 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="kc3Ow34u"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0223EBE;
	Sun, 30 Jun 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719764014; cv=none; b=Dj0wJgySXNfkrLL7v+iAEEACUhnD/46z2jISbtIkt3FARwUhDgj52pA2xXBI5RU5dKW+MaTVTDlUlMX1dea5Tecxje9V27e8NW0Ttd+h+o0MZBa1BezvOVhlSdAG9acVylat7OJglMDjPIiKEvfPoqM0yHRqIEqUMKXtB3W/m2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719764014; c=relaxed/simple;
	bh=KZ9Fvjx21g1K1TNBXpyW6oYm1QN04Uupz8fL4zIgRR0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sKGqisp3TkepoV+6/OvNdilqhxymppjr8WCOwpDZEMH7eg9q9LxIXj5OP+O8cpyrCLFYelugM/EEzujVszgPm9/QDO0ZW7lKQxl8TFTV1Q0pgVKWIvqvD0mRBZoCk+RL11ShNOzjyhCbNj0CQJznumZ8KFeTAKIswpNHiKW74y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=kc3Ow34u; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=C+OMEzWC8Q8OfStFZ3sYY824ePX+m699ULbpSYW5f3Y=; t=1719764011; x=1720196011;
	 b=kc3Ow34uc3m1h0DZt2RVSF6JOVGHfRjvu/7PTHlDqrBMBklCfVOxQxWixThv8P3+Pj0faBnxjU
	IoqIKKyU7FI63g6XoFpf1F4WqjTo/dC5/1PU65D1CMxGoeJWGVehfOZ9IY24TFVtVNkAerVev5vEP
	7unfNqSFEQ0QlZ2pgC8C0HnF8+9NINIBiAhRPvptXKQMMaArz96Gs84qfBwkGfdoWZ48zoYyu8Oho
	N8d3UGu4bew2KOBUOCdPHG03Cj64KNTRz/rr/xYtYcd083Kdgi73cld8EUPkoCf7wgywhPU9NYE0R
	jaJUufcoQI3KfC9BruruHasKe/+eb/9LtQl6g==;
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1sNxBA-00045G-My; Sun, 30 Jun 2024 18:13:28 +0200
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-06-30]
Date: Sun, 30 Jun 2024 16:13:27 +0000
Message-ID: <171976397650.2207205.3016482698479351675@leemhuis.info>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1719764011;b9630135;
X-HE-SMSGID: 1sNxBA-00045G-My

Hi Linus, find below the weekly report for regressions introduced
during this cycle. Overall it does not look to bad, but a bit worse then
in the recent cycles. But there are a few discussions I will prod
tomorrow to hopefully get a few of those resolved before -rc7; I might
CC you on some of those threads if no resolution comes into sight soon.

Ciao, Thorsten


---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 14 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


=======================================================
current cycle (v6.9.. aka v6.10-rc), culprit identified
=======================================================


:drm/amd: green flashing bar on top of screen
---------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com/

By Mikhail Gavrilov; 35 days ago; 9 activities, latest 0 days ago.
Introduced in bc87d666c05a (v6.10-rc1)

Recent activities from: Mikhail Gavrilov (2), Rodrigo Siqueira
  Jordao (1), Alex Deucher (1)

One patch associated with this regression:
* Re: 6.10/bisected/regression - commits bc87d666c05 and 6d4279cb99ac cause appearing green flashing bar on top of screen on Radeon 6900XT and 120Hz
  https://lore.kernel.org/lkml/CADnq5_PDxJ8O1JUQ9RBYRFB9G1WZJos05ZAM4jUKuPBwPxjNkA@mail.gmail.com/
  23 days ago, by Alex Deucher


[ *NEW* ] ASoC: SOF: Intel: Lenovo Thinkpad X1 Carbon Gen 10 first S2idle fails, S0ix fails in all further suspends
-------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218961/
https://bugzilla.kernel.org/show_bug.cgi?id=218961
https://lore.kernel.org/lkml/ca2d3d47-0ac0-48a5-910b-e481f2a9870a@leemhuis.info/
https://github.com/thesofproject/linux/issues/5072

By Todd Brandt, Todd Brandt, and Pierre-Louis Bossart; 16 days ago; 8 activities, latest 1 days ago.
Introduced in d5263dbbd8af (v6.10-rc1)

Recent activities from: Todd Brandt (5), Pierre Bossart (1)


[ *NEW* ] tpm: init of TPM chip fails
-------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240617193408.1234365-1-stefanb@linux.ibm.com/
https://lore.kernel.org/lkml/20240617193408.1234365-1-stefanb@linux.ibm.com/

By Stefan Berger; 12 days ago; 9 activities, latest 1 days ago.
Introduced in d2add27cf2b8 (v6.10-rc1)

Recent activities from: Stefan Berger (5), James Bottomley (3), Michael
  Ellerman (1)

3 patch postings are associated with this regression, the latest is this:
* Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize session support
  https://lore.kernel.org/lkml/5427fe09-199b-4b4b-a451-044e8e352595@linux.ibm.com/
  12 days ago, by Stefan Berger


[ *NEW* ] thermal: core: trip points crossed not detected when no cooling device bound
--------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org/
https://lore.kernel.org/linux-pm/dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org/

By Daniel Lezcano; 4 days ago; 11 activities, latest 2 days ago.
Introduced in 202aa0d4bb53 (v6.10-rc1)

Fix incoming:
* thermal: core: Call monitor_thermal_zone() if zone temperature is invalid
  https://lore.kernel.org/regressions/be6039dc-58a9-4e22-bd46-caed136460db@leemhuis.info/


net: dsa: mt7530-mdio: mt7531 switch on Bananapi-R64 not detected
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240516204847.171029-1-linux@fw-web.de/
https://lore.kernel.org/lkml/20240516204847.171029-1-linux@fw-web.de/

By Frank Wunderlich; 44 days ago; 29 activities, latest 3 days ago.
Introduced in 868ff5f4944a (v6.10-rc1)

Fix incoming:
* arm64: dts: mt7622: fix switch probe on bananapi-r64
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=df768350a87031971a3c834b480aef6ad6f1f1a0


[ *NEW* ] btrfs: increased execution time of the kswapd0 process and symptoms as if there is not enough memory
--------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs%2BA@mail.gmail.com/

By Mikhail Gavrilov; 4 days ago; 3 activities, latest 4 days ago.
Introduced in 956a17d9d050 (v6.10-rc1)

Recent activities from: Mikhail Gavrilov (2), Filipe Manana (1)


[ *NEW* ] kbuild: "make xconfig" fails with "No rule to make target …/qconf-moc.cc …"
-------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/5792762.DvuYhMxLoT@devpool47.emlix.com/
https://lore.kernel.org/all/5792762.DvuYhMxLoT@devpool47.emlix.com/

By Rolf Eike Beer; 6 days ago; 2 activities, latest 6 days ago.
Introduced in b1992c3772 (v6.10-rc1)

Recent activities from: Nicolas Schier (1), Rolf Eike Beer (1)

2 patch postings are associated with this regression, the latest is this:
* Re: "make xconfig" fails with "No rule to make target …/qconf-moc.cc …"
  https://lore.kernel.org/all/20240624-remarkable-hog-of-aurora-fefff1@buildd/
  6 days ago, by Nicolas Schier


spi: omap2-mcpsi: boot hangs with ocelot_mfd driver
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zl/V0dU6SjAMkpLG@colin-ia-desktop/
https://lore.kernel.org/lkml/Zl%2FV0dU6SjAMkpLG@colin-ia-desktop/

By Colin Foster; 25 days ago; 6 activities, latest 8 days ago.
Introduced in e64d3b6fc9a3 (v6.10-rc1)

Recent activities from: Colin Foster (1)

One patch associated with this regression:
* omap2-mcspi multi mode
  https://lore.kernel.org/lkml/Zl%2FV0dU6SjAMkpLG@colin-ia-desktop/
  25 days ago, by Colin Foster


e1000e: s2idle and S3 broken
----------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218936/
https://bugzilla.kernel.org/show_bug.cgi?id=218936
https://bugzilla.kernel.org/show_bug.cgi?id=218940

By Dieter Mummenschanz and Todd Brandt; 25 days ago; 10 activities, latest 9 days ago.
Introduced in bfd546a552e1 (v6.10-rc2)

Recent activities from: Brandt, Todd E (1), Paul Menzel (1), Vitaly
  Lifshits (1)

4 patch postings are associated with this regression, the latest is this:
* Re: [Intel-wired-lan] [PATCH iwl-net v2 1/1] e1000e: fix force smbus during suspend flow [implicit due to Link/Closes tag]
  https://lore.kernel.org/all/6be9d31678aa4d8bbe9e1ddb75a2791f@intel.com/
  9 days ago, by Brandt, Todd E; thread monitored.

Noteworthy links:
* [iwl-net][PATCH] Revert "e1000e: move force SMBUS near the end of enable_ulp function" [implicit due to Link/Closes tag]
  https://lore.kernel.org/netdev/20240610013222.12082-1-hui.wang@canonical.com/
  20 days ago, by Hui Wang; thread monitored.
* [iwl-net][PATCH v2] Revert "e1000e: move force SMBUS near the end of enable_ulp function" [implicit due to Link/Closes tag]
  https://lore.kernel.org/netdev/20240611062416.16440-1-hui.wang@canonical.com/
  19 days ago, by Hui Wang; thread monitored.
* [Intel-wired-lan] [PATCH iwl-net v2 1/1] e1000e: fix force smbus during suspend flow [implicit due to Link/Closes tag]
  https://lore.kernel.org/all/20240620063645.4151337-1-vitaly.lifshits@intel.com/
  10 days ago, by Vitaly Lifshits; thread monitored.


drm/bridge: adv7511: Intermittent EDID failures
-----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240601132459.81123-1-aford173@gmail.com/
https://lore.kernel.org/lkml/20240601132459.81123-1-aford173@gmail.com/

By Adam Ford; 29 days ago; 6 activities, latest 9 days ago.
Introduced in f3d9683346d6 (v6.10-rc1)

Fix incoming:
* drm/bridge: adv7511: Fix Intermittent EDID failures
  https://lore.kernel.org/regressions/1b79fc84-588e-4ff1-8034-8fc99686f831@leemhuis.info/


drm/qxl: VM graphics often malfunction after boot and sometimes shutdowns occur
-------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/DS7PR12MB57665F9F4BDF0598D7CC53DD94FF2@DS7PR12MB5766.namprd12.prod.outlook.com/
https://lore.kernel.org/regressions/DS7PR12MB57665F9F4BDF0598D7CC53DD94FF2@DS7PR12MB5766.namprd12.prod.outlook.com/

By Kaplan, David; 27 days ago; 3 activities, latest 16 days ago.
Introduced in b33651a5c98d (v6.10-rc1)


====================================================
current cycle (v6.9.. aka v6.10-rc), unknown culprit
====================================================


[ *NEW* ] spi: omap2-mcspi: omap2-mcspi broke, Oops after a timeout
-------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240612170030.3qatttsgrwjg2m5s@joaog-nb/
https://lore.kernel.org/lkml/20240612170030.3qatttsgrwjg2m5s@joaog-nb/

By João Paulo Gonçalves; 17 days ago; 5 activities, latest 6 days ago.
Introduced in v6.9..v6.10-rc3

Recent activities from: Louis Chauvet (1), Linux regression tracking
  (Thorsten Leemhuis) (1), João Paulo Gonçalves (1), Thorsten
  Leemhuis (1)


performance problems on Thinkpad X220 (GPU working harder and causing throttling?)
----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZmrTZozoi0t/tuva@duo.ucw.cz/
https://lore.kernel.org/lkml/ZmrTZozoi0t%2Ftuva@duo.ucw.cz/

By Pavel Machek; 17 days ago; 11 activities, latest 10 days ago.
Introduced in v6.9..v6.10-rc3

Recent activities from: Pavel Machek (2), Gerhard Stoiber (1), Linus
  Torvalds (1)


[ *NEW* ] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218946/
https://bugzilla.kernel.org/show_bug.cgi?id=218946
https://lore.kernel.org/lkml/f16d49f6-01a4-45c7-aabf-ab6a1b8bfe6e@leemhuis.info/

By doru iorgulescu and doru iorgulescu; 22 days ago; 8 activities, latest 13 days ago.
Introduced in v6.9..v6.10-rc3

Recent activities from: The Linux kernel's regression tracker (Thorsten
  Leemhuis) (2), Miri Korenblit (1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/171855416884.750783.12465497601688065358@leemhuis.info

Thanks for your attention, have a nice day!

  Regzbot, your hard working Linux kernel regression tracking robot


P.S.: Wanna know more about regzbot or how to use it to track regressions
for your subsystem? Then check out the getting started guide or the
reference documentation:

https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The short version: if you see a regression report you want to see
tracked, just send a reply to the report where you Cc
regressions@lists.linux.dev with a line like this:

#regzbot introduced: v5.13..v5.14-rc1

If you want to fix a tracked regression, just do what is expected
anyway: add a 'Link:' tag with the url to the report, e.g.:

Link: https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/

