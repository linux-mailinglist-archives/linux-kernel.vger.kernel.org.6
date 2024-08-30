Return-Path: <linux-kernel+bounces-308113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5562596576F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E0F2841D0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D0414F9F4;
	Fri, 30 Aug 2024 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="NjeXn+Tt"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D31531C1
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724998374; cv=none; b=TJ0UTuzvqWMQnnVuZ0gw2chK5uEOYR7f5yMvtbDwEXAnagU0cCuNh0b1ngBixROssIOXE9CnugTKDWpQDCTslmOhgYxgCqV0S73UjkvdE6e1hTU13Xz8fE2nzRIwpSaC/XN32VkXqcbxcx96gp+UuU4u7FU0Smg8nWxL6fIw/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724998374; c=relaxed/simple;
	bh=zTI23BYkBcXM/w/1vC44TOB5BjO0pNKRm4IyjCPJPak=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fly9mCCGR/xMkiVuOYDi25JTGndk2l9Oykewa1fziqnMvOU3GDVQiIkuc+TuGhfjEoQWIj0ZNVPVaqv7IdKoeKPRRpsNCMQ9d813unJ+tUBjzEI9A7LS+lrs5sf4DBQ8tijFhmFY63Q8dk3DMTXZw/ak6qCYUr7d7jpcufUwQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=NjeXn+Tt; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724998372;
	bh=zTI23BYkBcXM/w/1vC44TOB5BjO0pNKRm4IyjCPJPak=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=NjeXn+TtXcqsLx5N8a89TUZa+V8jx3fO30Hrw0JwJzYTVEuSh3D0Y7KzjF5bQyFoD
	 IAMn4hkOsehD6jZTs52YsIQ0G5SuieAY2/YOGK4IIrlB24B1FM3XprY1xPuGKudxDV
	 P/CeFqnhT19qom/FQpwBRRx9O1mCr5cw3EU7QfcZ3iAP2SAGd/VIQ+DDnLPe5AVbqT
	 irYgz4jrlerkvggWovA3HaeMKH6ZaIsYEaNko/KJD+pFPhHib7rVnyKEZMiCvHiM9O
	 h6N5TBryXpTqhx1o4y+AWiuGpVlxzefYuPw6KkNQDNwCAT6GD6opUnYccPfHaw2idE
	 8t3aVuGXBofWg==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 6BF7A1349A0B;
	Fri, 30 Aug 2024 06:12:51 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] prctl: allow prctl_set_mm_exe_file without unmapping old
 exe
From: tblodt@icloud.com
In-Reply-To: <202408301005.IiGdSjk2-lkp@intel.com>
Date: Thu, 29 Aug 2024 23:12:38 -0700
Cc: linux-kernel@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev,
 Ryan Houdek <sonicadvance1@gmail.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 David Hildenbrand <david@redhat.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Kees Cook <keescook@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7FEC319-81F3-4848-941A-66ECA9F40610@icloud.com>
References: <20240827215930.24703-1-tblodt@icloud.com>
 <202408301005.IiGdSjk2-lkp@intel.com>
To: kernel test robot <lkp@intel.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-Proofpoint-ORIG-GUID: Vnc7Fp3U5hGktTymwBW56W4gvDMyadol
X-Proofpoint-GUID: Vnc7Fp3U5hGktTymwBW56W4gvDMyadol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=871
 bulkscore=0 clxscore=1011 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408300044

> On Aug 29, 2024, at 7:55=E2=80=AFPM, kernel test robot <lkp@intel.com> =
wrote:
>=20
> Hi Theodore,
>=20
> kernel test robot noticed the following build errors:

Good bot

