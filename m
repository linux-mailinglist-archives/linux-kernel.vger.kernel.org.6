Return-Path: <linux-kernel+bounces-560547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75998A60666
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA5319C34D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17041291E;
	Fri, 14 Mar 2025 00:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR9ODnTu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0B195;
	Fri, 14 Mar 2025 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910738; cv=none; b=nAVpWaoZe8rt1t7l5j3HIxhGylGaQEDDdl3uiZoQNQh+Ce3esioNxTwgOiFeKQTJQG7AEEWDdAhFhRyrCRBqRfTSdxI/7QUtuFVpIKlcVVy1Xfoj0l+MRBRh9I8yAgx4UJRJ5Kq2ZTItPp00qVafORcURp8ZU1YIp2K1/KDLchQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910738; c=relaxed/simple;
	bh=F9FO9I6Gv6TkCqiBMccTZtM3eIaDVyVuRG1zgD1RXe4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=lPTy3KgU8n8T9PIrJK0nZIE9U0i4mhOjAlpZyJnr0991HWZUsSsURob41TeoGf7pc2Ik1QeMpls+nbJVnp0S/G17eGBjJVUnUJRCdpNMDdjQWW8UsS+8sfN7FSIVvwmrN1uy95xnmnphDPUFJzOv+x4JQJqMToDVVtJQI1HK7dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR9ODnTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D9CC4CEDD;
	Fri, 14 Mar 2025 00:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741910737;
	bh=F9FO9I6Gv6TkCqiBMccTZtM3eIaDVyVuRG1zgD1RXe4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=IR9ODnTuDxCKFwlsx6aNR5bSRbdNoDd64633B7ZzVz4T9tSuSztvNtsCh5S6mUIsn
	 4Txn6oBIHywGXDFK1nWds4/PrA8xxs7guEWahsVf+USGcZ4Se/MWDoqPZyrwwh5sIM
	 HFd3YIaihu66XOZfIG5dgfG5T9ua4U/5xUYRlRRYgj4Q+x4yNbrH7mv7gCFfMIpCh2
	 BAILfL/0Lsuhj3k3PTNr5HM2hfd0wuKug5UzGMMkHcdhsdGRQRkVqjvzua7pmOsYjK
	 wNZqrHuYYLalPd3y7qqIjiItBaFRJIy6BzHaYa4QGElh24Re5YQ62+XYZrtAcxaaZ2
	 k04h84oY1hL7Q==
Date: Thu, 13 Mar 2025 17:05:32 -0700
From: Kees Cook <kees@kernel.org>
To: Aditya Garg <gargaditya08@live.com>
CC: Petr Mladek <pmladek@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sven Peter <sven@svenpeter.dev>, Thomas Zimmermann <tzimmermann@suse.de>,
 Aun-Ali Zaidi <admin@kodeit.net>, Maxime Ripard <mripard@kernel.org>,
 "airlied@redhat.com" <airlied@redhat.com>, Simona Vetter <simona@ffwll.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "apw@canonical.com" <apw@canonical.com>, "joe@perches.com" <joe@perches.com>,
 "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
 "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 Hector Martin <marcan@marcan.st>,
 "asahi@lists.linux.dev" <asahi@lists.linux.dev>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_lib/vsprintf=3A_Add_suppor?=
 =?US-ASCII?Q?t_for_generic_FourCCs_by_extending_=25p4cc?=
User-Agent: K-9 Mail for Android
In-Reply-To: <PN3PR01MB95972EFA147FB0453D5A7FABB8D32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB959715C19BCEA54426D24934B8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <ff3a9c58-5c7a-4c48-8a9e-cc828a43baed@app.fastmail.com> <PN3PR01MB9597E5C609290DB1A967263CB8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <Z9HgVn-XELC065w0@smile.fi.intel.com> <47AE7FCD-0F30-4379-ADE9-090A15ACD58F@live.com> <Z9Kb8zMJgmSP-rgD@smile.fi.intel.com> <PN3PR01MB959780176C0B16C36FBD59C3B8D32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <Z9KdzZUxs3vlwp0Z@smile.fi.intel.com> <PN3PR01MB9597A8F02423B9E4C585F5EBB8D32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <Z9K36SRz7Ja_AyQb@pathway.suse.cz> <202503131035.A5FEBE32@keescook> <PN3PR01MB95972EFA147FB0453D5A7FABB8D32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <0F278A68-EC62-4267-9AC0-C1FFB9B5592E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 13, 2025 10:42:10 AM PDT, Aditya Garg <gargaditya08@live=2Ecom> w=
rote:
>I already sent the 1st patch to DRM=2E I can rebase the test-printf bit t=
o this tree=2E Sounds good?

Yeah, sounds good to me! Thanks :)

-Kees

--=20
Kees Cook

