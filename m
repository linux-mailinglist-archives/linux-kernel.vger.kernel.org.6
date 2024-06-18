Return-Path: <linux-kernel+bounces-219671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C31990D64F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52DF71C24CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E1613DDD6;
	Tue, 18 Jun 2024 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="L9eH6FHN"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06CF2139AC;
	Tue, 18 Jun 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722461; cv=none; b=qGJ3C3BxOm/5I0F3cU10ftziucDx+T5Fq3oCuVTB/Ot0zjKAmUaXWQcTVW0Vlg5ooUinwe2Rl2N1VI8FdgeeXYVv6AZ9ywVpkMCeTBBbsm7KccROZDaboRpWf6Nrkh3xdqykV6HLWhXbGP6Dw20niqvlZExq4Bpq4sqZg+XESnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722461; c=relaxed/simple;
	bh=SVxWgSsTLkbbevP+rZOoUCtaJN1R+tI6oN2N3FUQRbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQFHxaXiKnAYPThybMHz1AQNVBi+W8xIpXkMNXI5Y8wKEGcsvwj8vWjiPMo34jVO5YiSJdTxZ84rcXLDmq3eTO/7OMdeTIlbtE0EttPgQIMUzi5FzwUzTgVf6FILqDEZ5koEg1Pu+dpZQTy7yG37D8zmnxYN9E/LDH5xJs/Tnkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=L9eH6FHN; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355091.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IEbjmV005872;
	Tue, 18 Jun 2024 14:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=ValpeSbsANs/RV7jg6nw2kz
	E3zQw4ipJknXEqT3///o=; b=L9eH6FHNhOlkc551BtGBPLwXjkoH4m6slzXhe8G
	YYg4FRRFcBu1S8SusWROaMnwQDg/2cBUJwG2DVuw8/SyhD6mew79KUZGJ1rXteda
	NVHcUGB21Irka0JDU1UxRIW5a6TVZ1w0A61DLqbOdbC/KURsAnfBDTE1nnIiXKV6
	sQHTi/MZgPErAsfQbwUMd5EAQCNhykrHSU02PSvTnaRGVq7Pa77SyNrQ/CtNFALK
	EZIc9Od+qsSE6KI3+Qh39HT8rsi5nDbC+BHsSp4+MvZB2Y6Z2qNuhDmt2+x7tWVh
	kEb64g5dzNBuqHZy+j4nlKGZzQOHvZQF1qlIP3tBPgONJIg==
Received: from va32lpfpp04.lenovo.com ([104.232.228.24])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3ysr2gpnqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:54:07 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp04.lenovo.com (Postfix) with ESMTPS id 4W3VBk3yk6zfBb1;
	Tue, 18 Jun 2024 14:54:06 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W3VBk1RB4z2VbbF;
	Tue, 18 Jun 2024 14:54:06 +0000 (UTC)
Date: Tue, 18 Jun 2024 09:54:04 -0500
From: Maxwell Bland <mbland@motorola.com>
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ptdump: add intermediate directory support
Message-ID: <i7zss6v6tb4gc6ul75idpiqludwfca3xpwdioznffnoo5ctslk@nhe4vb5hhwx2>
References: <fik5ys53dbkpkl22o4s7sw7cxi6dqjcpm2f3kno5tyms73jm5y@buo4jsktsnrt>
 <2b8cea32-b460-4152-8c7e-964031eed990@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b8cea32-b460-4152-8c7e-964031eed990@gmail.com>
X-Proofpoint-GUID: 9Z_tDitlrU8QrIpVRinrQH3uU8V2JmgT
X-Proofpoint-ORIG-GUID: 9Z_tDitlrU8QrIpVRinrQH3uU8V2JmgT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 adultscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180112

On Tue, May 21, 2024 at 12:54:34PM GMT, Jesse Taube wrote:
> On 4/30/24 12:05, Maxwell Bland wrote:
> > Add an optional note_non_leaf parameter to ptdump, causing note_page to
> > be called on non-leaf descriptors. Implement this functionality on arm64
> > by printing table descriptors along with table-specific permission sets.

Hi Jesse, sorry for the delay on this, I have been putting out fires
at motorola, and have just gotten time to sit down and rework these
patches. I have submitted a new set here:

https://lore.kernel.org/all/aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv/

And thank you for your comments. This new version should address them.

> When you reply the email client(and git send-email???) seems to send it
> twice?

Was missing set record = /dev/null in my .muttrc, apologies!

> Typicaly docs are seperated into a seperate commit and sent as a set.

Done!

> As said by Catalin anything that can be seperated into smaller patches
> should be.

Done!

> > + | 0xffff800000000000-0xffff800080000000   2G PUD F BLK     RW               x               MEM/NORMAL            |
> It's probably good to add another space between F and BLK to show that F is
> related to the type? Also maybe add docs as to what it means, but I may just
> be dumb and its obvious to others.

Yes, the "F" for "this entry is invalid" is unintuitive. I decided to
rework this section of the docs altogether and just provide an exact
list of attributes for version 4.

> > +	static const char units[] = "BKMGTPE";
> This doesnt seem to be related to your changes is it?

Yes, I was a bit confused at this time, thinking the range specifications 
for tables should be the size of the table, rather than the size of the
region governed by the table. This is corrected in version 4 and the 
byte-sized specifier is no longer necessary.

Regards,
Maxwell Bland

