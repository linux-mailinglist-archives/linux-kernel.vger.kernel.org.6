Return-Path: <linux-kernel+bounces-304080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4829619D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 00:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A892877C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 22:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AE318BC2D;
	Tue, 27 Aug 2024 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="V8OaSezP"
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1359158DC8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724796270; cv=none; b=nCnqFh00PqCTurb/9j4tfOVp7eoFYKGog2ITAlmvnhPdh+vgI4UjcLBVhN+REhBWcSIP/IGUvEsD0TtxdBjzUCy5w6XQSmWRneF3jkkGPt/+4PtoPJryX49MNAfHN92m8XgVrhHxF4Dqc/azH7Dfc4hMFoC0a1u5Wj4MLCElEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724796270; c=relaxed/simple;
	bh=XoQxxmEoNrrSJ1A4BhYsRt9j9YFrtuAFb0iWeX95F1c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=R6KkmyVxUlAH356c224UVao6RlfBlRe06vGcvVho8hs9pWybhkjtwO5D0af3w8tuyVOmUOhSrRGaN+haHmcW8MvA9YhPYD+0rcdTMxUuKbCGJZpogWOy/ilAaMl9tPJa0dpKf4QEiIEJPOJc27bw7DaaVq+dQQclfRurDeNh6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=V8OaSezP; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724796269;
	bh=gd2P4LrVBVbczM1BBbyqCRdxy6b6HjwxDG7G61RFLLc=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=V8OaSezPT6MtI5fxqkuvwrF9ds1xAjTQ+7ZyR751fO6c6viyhhdg3ab3DKIoqM5VW
	 Ko4oxRAXhTJc+1vsxVsGcevST8R0VKfT9zhAZY+CJppuN+TzPkw1jmNymXglh82ADy
	 COf7IV4X5akqTa39zGhDRZqqV8b/V7gFPgWC4X0y1RLUDrbRoZqmBA7m19m3m1+XJi
	 Sjn3x2OZtqCOjYbvIVoIOnYCFElPK6/yOa1DerezegpluXVk33HmT42o4DbLRNxPTZ
	 d1xdAwDr15Z5v1WifnXG6B3IuUHG4naviqiSoKGiYU8XTJwEpSbuDaiq9ZV88YfshQ
	 AXuxcYVbthSGA==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id AB2359600FD;
	Tue, 27 Aug 2024 22:04:27 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] prctl: allow prctl_set_mm_exe_file without unmapping old
 exe
From: tblodt@icloud.com
In-Reply-To: <20240827215930.24703-1-tblodt@icloud.com>
Date: Tue, 27 Aug 2024 15:04:15 -0700
Cc: Ryan Houdek <sonicadvance1@gmail.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 David Hildenbrand <david@redhat.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Kees Cook <keescook@chromium.org>
Content-Transfer-Encoding: 7bit
Message-Id: <82C762FE-B3DA-4985-AB79-C648763F143A@icloud.com>
References: <20240827215930.24703-1-tblodt@icloud.com>
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-Proofpoint-ORIG-GUID: RNoKVAlVAvomSBgnFi66oU9-wvJaXv4P
X-Proofpoint-GUID: RNoKVAlVAvomSBgnFi66oU9-wvJaXv4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=785 mlxscore=0
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408270161

PS:

1. I'm not fully sure of my research here, please contradict me if there's
   some non-obvious reason to keep this check.

2. While writing this I discovered that someone else had submitted
   essentially the same patch independently about three years ago and
   gotten no reply. Hopefully this one will have better luck.

~Theodore


