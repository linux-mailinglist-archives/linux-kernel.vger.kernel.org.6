Return-Path: <linux-kernel+bounces-576690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0183FA7130D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50E63AB55D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57EA1A2632;
	Wed, 26 Mar 2025 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BuQqIv0C"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7930019CC02
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978976; cv=none; b=pHsmTfaEWu0urm3ascpNP6HyB/ViUXdaLZSx436BFX56m4s4VS1DePFelSc6p1n71KKFwackis5GXPqTWROyygodnPK8RqmYykvKDSqxp8m6U3dP2wQnwP8ra8p6gtARmtt5j6Pv1JM/2T+kO20gPOZ8CU0U7UrOnz9B6gvjQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978976; c=relaxed/simple;
	bh=ZA1Ac6DarqLHrHBuo5JGC8xWF9bwRLLdYnUT1IqWCyw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CyQRw7NQ7uybCvg6Nh2mzOppIO0HLx2Jd8Rta200FBl3ElXsqHZi9QhuqFXT8JH+L8VuIj+ZMRYf/rboCdCz9Yp5ETKfRHvNVaer8gPijPbZQJ2jj97ExeHcW5WJfTn3zokGiobQQ3hz5HRULD3LDFU29fm4CSt8blox6X6y7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BuQqIv0C; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742978921; x=1743583721; i=markus.elfring@web.de;
	bh=F0gKURSAiuIUqSPfcoCp0bxD+Fxnceq0ZyFc1KA1xQs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BuQqIv0Ci6zUWrVFLwaIenmk5iqiLVqJ4ea/kZ95RVVtSXEnWdW0QYNFc9QX4byP
	 NzEsd+G4x+C43DzTlhScpRHWIwQiycD+6gtLObdE2kZMzRdj3jN3J8x2lxALD6wf8
	 QcCgUITAoNGyUvH+rScUBk762I2DBBC3sj872gzyYcIMh8VK8qnxycfw8w4wKZklQ
	 0m9Iurco4KeTfKulS9z/h5pmZMMD2aKlhaLBkxi2tQuvipPvV0eYOKlRYrUFeeDcA
	 rd0d7c+buD8wQP/wM2OnavUbmZxVxL5fOgzEbG5YYlTseZXWSBCehxLklmg0ZwsaT
	 4HugaMiGSZTlAzzLKQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.33]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFJnh-1tupCC2D0L-00BDDp; Wed, 26
 Mar 2025 09:48:41 +0100
Message-ID: <0ceb4ab8-adb5-46bf-98e4-61a1bd908e20@web.de>
Date: Wed, 26 Mar 2025 09:48:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3] mm/page_alloc: Consolidate unlikely handling in
 page_expected_state
To: Ye Liu <liuye@kylinos.cn>, linux-mm@kvack.org
Cc: Ye Liu <ye.liu@linux.dev>, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>
References: <20250326011752.917564-1-ye.liu@linux.dev>
Content-Language: en-GB
In-Reply-To: <20250326011752.917564-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vWhInb2AlYD4tAVbHvewD1VPWvI0+YNui6YWeK2xih+zmZ4CSyL
 SJpDrk76hOSy3i5nYndkseF1JbE4OsvD++81zPnQ7hQZBut7tJ8t2jicirwW4KpnHnKjZHZ
 fdUUCo2OOPXonMMk0S6Yf1A5OMNFmcZE25K1BCCkncSd/9TrbV9RzvqMUxhLj9R33XT2PnW
 e8J2AfgjyyHN3ypT3f/4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fsvazxaONtc=;dTSNIURCaZ7ykEaAXXTEcAHFPWD
 85cNrth6Yqlmx1Nw5liNL1tZX2aF+g1OaZok5xSWLTEf2tAmpbLIwm/vdCiXt9BFQY9OzwMvB
 hUww1luu+HBJKDk9uns2K0a7AYc54ifnnASUHdE8Zkx9M8ObfinZ9Bj2KTjoY8XqJnSJ8FeFM
 Rt7MOfMEBndU3/kAJe1lMYoYgokeNonYgecvQ2vlp5uqLOK/mluRkThFRDK/RonQnRSrqfgla
 YTMj2jzNE8LZ2Rzs5dqYQ5idgQ+wyKCrAMjbvpG7+Z2WWhsChI6PfloqZ11hIIx51BFI+AS7s
 OyAg62phZtzYiT6ock29ar8Uadz8XZCCeW9jCywKACNpJadsfMNSRopT6iL6rr3cFeMcD5/sU
 LDi8NfTzYixg7lSEY1hPIty18zjE2QV66J+wDRChbakCq85wILwAb/0mvzObG9hOGx2n4I0Vl
 4scLcub8wu3gfXtIgumup8658ctp43B4KQmmLfn093jgepVUHi33PSdKCc4jgLyGJ5IRCi5oG
 BoMrTVY5wsUfrD/38n5y0F4Az1q9dO4HTWuBnygHCQSw0tXCiKw8xleFilbGySduXacJjx1W2
 CvGRtUGJ6uZIR0TYnc51eabgWDDFampBWCQ6RmajziT4L6btw0yqo1MgLL3SvuFYoIUAXAR1b
 8R72Amotpw70OOCmD6WQnAP8csbnnRnRHHGA0CimMpuZqaMXKUjjWmrY0sexFvmzUXOTG38gm
 95ppwSsKP+N9qRhkK0fbDUeMt/N3r1Fjix5qlYS0H+cmu7KGxgUuXbJcYDjgJ5/5d1Ys9Zqlu
 qQH9w6CE3LHU3ZYTUDjPWv1E9bj8m1abtBjFkl6Zlx6ssfZ5PS5hUUGyTRzsf2mlvWWNXSRIw
 HNzwDHv8nnUZFFZDOu7jf83z+emt7V6gGIYUcoLt3jj1D+tbpQraXu89yjve5b66I8pbcwUao
 AuCpMG1OMVhmmUfJfM2DVaM+XIgjS/OrdUdRWeZtD8zkzSmr9fQHjBv3p1VnbNBBROox3859c
 w+K+pct7zO5NQe+9mexJGcBz5BR2pGtqswcPocNHiK89jvNw//EowOvsQ1VCRnrQtUcvzSHUL
 q+eBJqgiRWCm17DXyDTZ28uJ6oeIqG7SBdiU1pStPvDmcceCbHE9w8fNAeKtBdzRCcy2Q/U5/
 lSE6ab9zHgCLADIJ0D8Hhft26QgcLt04Rj0hlIlGpbjYsrpH1NgNchzZCIGCMRJEqwlUNOnSY
 FjEXrS9XgZamvpeyC/2zAbAZg2KJukeVJBxtbwMA1h3HL+iVfZSxr3FtQknljiJW5jVKDKL4e
 Nl56Z/V5B88luz4xNC6tF1czrfvzIQGlIdLVWHTwa/TmoK71zYcgOjnNZFeHmu2McWwuPPslU
 YDodLBcHhyHZTa5MRafvzSAiYIY3lFFRbL8YJb3cBySAfql/gsQP33z8PkGkvpBNhodETx72n
 R0Df+CB7owyskCV4ydJKQYTO/4BtbuiCR79kZfn8SmiOIGqql

> Consolidates the handling of
=E2=80=A6
> This change simplifies
=E2=80=A6
> ---
> V3: Delete 'This patch'.

How good does such information fit to the wording requirement =E2=80=9Cimp=
erative mood=E2=80=9D?
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14#n94

=E2=80=A6
> ---
> ---
>  mm/page_alloc.c | 24 ++++++++----------------

How do you think about to omit redundant marker lines?

Regards,
Markus

