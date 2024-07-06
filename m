Return-Path: <linux-kernel+bounces-243085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC75929167
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 09:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E98B1C20D84
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141C41C698;
	Sat,  6 Jul 2024 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QS5kx7C2"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48FA10A1A;
	Sat,  6 Jul 2024 07:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720249757; cv=none; b=Hrx+r98q9Br1FWLArXOwcgyJdfusVVEzqZtD6H97lf9xBJaFiN7hUZCdGXo52QqB2xao2o5uOS4hZkME2YIYrGSaRGPs7SQNtA9czxVfWaw3QxsY27bhtzc2j0Ifcjw9/VZCJZ3G/hwsEMolr23Ak0KNHA+R3rkWp4n/w6BYxLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720249757; c=relaxed/simple;
	bh=xIxRSsrufjq3R79gidF3atyyjKG9FDVof0Vmer13Pdo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=hDHORuHDwIIL3dhEqOKVRNk8oi4fG5IvGtPW4V3IMMTSleM7f1zcNHzaL5ctzRMlODpmiYD1keykIZ5+hvp9SWrT4NzDDsESHsxS4ssMh3ezaqLyrALYJvkwT6bOnTtyE/HnJNeyaJvydFKIY4sZyt027njBQbZB5GnNZvFfda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QS5kx7C2; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720249747; x=1720854547; i=markus.elfring@web.de;
	bh=xIxRSsrufjq3R79gidF3atyyjKG9FDVof0Vmer13Pdo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QS5kx7C2UCygpssHvyKXp3i1/C1o978MlFMs5Y4AMzeD48yEnzFfCkJNvvqt6Owd
	 FQXr0CcrLHDkWk6HqRStD12cyuvN4kISz9fv8/VDX0DrUYSff5upnT2jb3nGDDHPc
	 K4dSDGOUjHSYzZv9+hgEJyh6Fopq7bfme64d5vFKnsA7gUz6jZvf8CETvPlRxGKtz
	 i/IhGO0uBNtYd/6iN5v1Jrf+HaD9hrQ3vC4EigX5TFv/GJ3PcPuAhWYgxEkLIrTlU
	 4HpZ2c7PqBzeJWElJzyZXERPqbquD4k26BddhXtvPehL6jm8MnLOztThLCsr5jI8d
	 QdIZ1i7+jzffdpkz9A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5j5y-1sSkc80e66-00DYBr; Sat, 06
 Jul 2024 09:03:42 +0200
Message-ID: <202d6997-2176-47a4-a46d-40ed63609cfd@web.de>
Date: Sat, 6 Jul 2024 09:03:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Minchan Kim <minchan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240706045641.631961-1-senozhatsky@chromium.org>
Subject: Re: [PATCHv5 00/23] zram: compression algorithms tunables
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240706045641.631961-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4LFjH1W84JqCy9Ae1H6HnQZN5tCxlB1f0fFU384ODFv2yffuPi6
 OQn6JJGWm8CSNCi+VX/+QB+GIZIvXcHYbB5wDXtmk7srxqQc/E71ijJJkU68p50jF7sYlTU
 kSOZCunjo9q5TwdzaCcw8y07OfWdO/B5oyb9VeUXC73WoZI5En2nr2ds554e2TKZMftpHkj
 /b7Y46lByhk6c21goApDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Jy42c8A3ToA=;Cz+rqlZiKqtQMC05URfedoc+qpk
 I93MXANggbEWgQQ1nDqd5PRXi+JxrtlF8kPbLPl9sQv7oSHflraYR2VHRGEDmyQ2V6TdZUaDj
 x8jNgxqoaHQLEJgY2QLMnD0lfsOy8pIyKFLvdLlDXueV3i1ymhQSaxzWsRBdFrvcQ11fmhbSU
 w1pgZXtNAY1AiIZxRLO0VeCZ6KnqvKif6x0sY2Z7C+tXpkf9xWGe4OM1WFe3oWUXJRN8vnGzO
 P1IA/KNMmitho6XC1zxMsZ9nSTTwgGt+ExYYL01i99xK8cKVfle1bdN365WinRnUw59thTDn2
 lZo9rI9te1kUB2rH4VT+1Wj1o9gtOISEpWmQbXEyqWqURsqNRjh88grX60J/YYa/YomtS4dO/
 L5We48zWnN6SAbE8H/EVkPXBOiG71OkehDxbRnYgLZ2X+PnsxP66xj5vYWzQuBlr0aqLd6bkV
 wxzgf/JRM+BQ4y5p9mmoELDjSq83hbkGGR5MSUHRQsjoCjuD8kqNYACXf01U60Wm/pjWO7pLM
 EhQwpSYQxsaEWf2kSYeW/iwBWi1KF9bv6w9Zw42qyMq4MIqOogJP2ZimVj4E45KCaPfRYHqf7
 jb19UPMKtCJXnRufN/YHtk1icy+0WUF4cmjjE3zN3CDOrnMXNcOYhVCLsw6dPqOvQYEGsvVlr
 qwhN445NKMafLD5VXbPOH2BAny4fqOHSjTyXuHiycIxEuztxXNk/+U3gTlfcmZKxqINcltXbS
 nn7Uy5lE4KXMoV8YBu+3IOGGmvQJwvlehLNZhpMgtZ2Os+OtGXLBzmRZV59bwvitV7zT0xdY2
 BgAYPdYPgPMkJeacFkRl+nIXfdW5GA6pwT2siLIgsFfWk=

> This series introduces support for run-time compression algorithms
=E2=80=A6

I find it helpful to separate the version identifier from the previous key=
 word
in message subjects.

Regards,
Markus

