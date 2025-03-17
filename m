Return-Path: <linux-kernel+bounces-564918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB05A65D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582683AF9C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DB91DD539;
	Mon, 17 Mar 2025 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UZ+Wjvl/"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6025DA47
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236992; cv=none; b=rZwonOlPZASz6MqbV3ByfJp91lJ4fQkGiwOZEdXgHpbjgfKCZ3iNdIucb2D+UDU4mfyuwCgagkBOxByX9C1oi0V4cF5v3gvTaeKHPQE/bYTmCXMLBSmlg4b/iDHysZkYUtr4Xb3DYRZ0fFQsXqz6iSwaU7+UOXau1zvNJeRqu8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236992; c=relaxed/simple;
	bh=/fwDvjGTmqCM1OlkPLVoWJP7tYxigoJaZ1g/RajmrWQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ax/lIdjXupnsnu0YW333IRYa3hBXOt4ZS6MjgNa/4vVt+JQEq6r7Z+oLpXSd8EGcdDy2M+A0tdebtL1a9PVyxgC/0ZsbgKhtqEYSNljEmmfccSDpJuqteSZtKWLxV4+keknkJFYKcO3zRH7L8Epl0BU9qs+ivoufMlUvI2NNwpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=UZ+Wjvl/; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52HIgWYP665151
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 17 Mar 2025 11:42:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52HIgWYP665151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742236953;
	bh=REDJtYGbH5GtvkMLVZUaW6QeOxOHTGnsBXTjcOzTpbs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UZ+Wjvl/XONt/FW7XbLTyjrG3Wo219jB5MuGIaszG6G2C0a/X0Ki9fzvGhxh5TJVN
	 AOO2cp9rwopikKgogbJjpLyciH2aBd9mf9TQdkfs5E4YUqcqjsNOFEKMo9lzhYYzmI
	 vVN8evmNX/oj1AyV2KEF7fSGh2zTSB6eqplAHkdmXoHsFTfECmtqK+xbFik5EQ2OYH
	 qBqWGTrDhsl6hmo8G8bZD1vU/mczCh5ONqn6qsiEv7+Hccs29tGljRugNaQbf82GGM
	 xz4x5SYE+CNwnZP0MsILZOt/hmGLLQpO5e0H3Im12oWONdJXy2ra7hOs0vpti5SdnY
	 Eemip5IbnqwDA==
Date: Mon, 17 Mar 2025 11:42:30 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, kernel@gpiccoli.net,
        kernel-dev@igalia.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/tsc=3A_Add_debugfs_ent?=
 =?US-ASCII?Q?ry_to_mark_TSC_as_unstable_after_boot?=
User-Agent: K-9 Mail for Android
In-Reply-To: <1238b1d0-275c-9117-a2e3-5e7684404980@igalia.com>
References: <20250226132733.58327-1-gpiccoli@igalia.com> <1238b1d0-275c-9117-a2e3-5e7684404980@igalia.com>
Message-ID: <EA2BAF2F-3F8E-4F81-B71C-7B97677216C9@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 17, 2025 7:35:45 AM PDT, "Guilherme G=2E Piccoli" <gpiccoli@igalia=
=2Ecom> wrote:
>On 26/02/2025 10:27, Guilherme G=2E Piccoli wrote:
>> Right now, we can force the TSC to be marked as unstable through
>> boot parameter=2E There are debug / test cases though in which would
>> be preferable to simulate the clocksource watchdog behavior, i=2Ee=2E,
>> marking TSC as unstable during the system run=2E Some paths might
>> change, for example: the tracing clock is auto switched to global
>> if TSC is marked as unstable on boot, but it could remain local if
>> TSC gets marked as unstable after tracing initialization=2E
>>=20
>> Hence, the proposal here is to have a simple debugfs file that
>> gets TSC marked as unstable when written=2E
>>=20
>> Signed-off-by: Guilherme G=2E Piccoli <gpiccoli@igalia=2Ecom>
>> ---
>>  arch/x86/kernel/tsc=2Ec | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>
>Hi folks, gentle ping about this one - any suggestions?
>Cheers,
>
>
>Guilherme

To be honest I don't think this belongs in debugfs; rather it belongs in s=
ysfs=2E

Debugfs should not be necessarily in serious production systems =E2=80=93 =
it is way too large of an attack surface, which is a very good reason why i=
t is its own filesystem =E2=80=93 but if this is a real issue on hardware t=
hen it may be needed=2E

   -hpa

