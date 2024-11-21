Return-Path: <linux-kernel+bounces-417431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C1C9D53FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CE8281C63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA38B1CB331;
	Thu, 21 Nov 2024 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="aiLfPXII"
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6428F1BF58
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220924; cv=none; b=QDqfODkTYLN5KSdIQFWrVy3iOjsjQ/OSt52SwPMNwLdvLQq5n7Rwbs+OY2Om9bGpKLcOSb7wLsOHlWDQJi1SVgnf+T/8ADoQxT0NF44C8R3mttRpa/WZrzA2jOYkJC+sFNQirE6SntcxXXE/mLUa5iMHYbjHRr4caddkuOAu748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220924; c=relaxed/simple;
	bh=1CIuCQ2Idh1P3CXHCxjdIw0x6Xfb5dBYnqzXNx0HDzo=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UfCuxWBIRqC/EFnGWjDmpYwmDsiK7wMxiiFxqxVdFiRLseBUSLSqfgVktg8NKIUsAgjSms7xGwZiOfY13aJvWcTLIdI9/xezP2s23wfIyXEzJTbAXigw2ArVK+y5KCYBIVtRRq7tVT5dx4k5JPTakTGpXNcM11igEZGnyLNU3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=aiLfPXII; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4XvVDf74Nbz9wQQ;
	Thu, 21 Nov 2024 20:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1732220915; bh=1CIuCQ2Idh1P3CXHCxjdIw0x6Xfb5dBYnqzXNx0HDzo=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=aiLfPXIIMxNv+Ak3ng9/K/fZQQYbAFJ+hj7DID6TLosM1UzFCI8ak3AFidpcHCnVv
	 Bg27hCrvalzJntyhR9jJb6htCjiC+mMxfAx/Q5xSppyPVjA0/yy2LMe3insVFNM4AA
	 xdP+xvu1eNUXwF8LqYZDwkdjU1ZmewEcAdZn4uBM=
X-Riseup-User-ID: 60DD21AD3028D52608F08AE50A1CE82203C79030CBD4A7ED658510D6A09C3DAE
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4XvVDN0YQLzJmqy;
	Thu, 21 Nov 2024 20:28:20 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 20:28:19 +0000
From: sk-alexis@riseup.net
To: linux-kernel@vger.kernel.org
Subject: Re: MAINTAINERS: HyperBK - altenate kernel by Hyperbola project
In-Reply-To: <E139FBBC-879B-4282-9FAD-B3300E4715E6@riseup.net>
References: <20241120085609.199586-1-keith.zhao@starfivetech.com>
 <E139FBBC-879B-4282-9FAD-B3300E4715E6@riseup.net>
Message-ID: <0ea4a89cb6df1cf81a2cb6d42a5126b0@riseup.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hey there,

We would like to share with the Linux kernel community, to current and
past maintainers, our efforts to release a pre-alpha version of HyperBK,
an alternate kernel, which is part of a bigher HyperbolaBSD project - a
full GNU inspired BSD-descendant operating system.

Since 2017 we ported software like Xenocara and LibreSSL from OBSD, to
our system-distribution (Arch / Parabola and our own packaging-scripts,
Debian security patches). Our focus has now turned to creating a
copyleft hard-fork  of OpenBSD-kernel, v7.0. The kernel is already
enhanced for a different stack of build-tools, like FreeBSD make(1) and,
also several issue fixing, inclusion of other components from the Linux
side has well has other BSD distributions. Complete source code license
audit, improving upon LibreBSD scripting work, basically mapping out
necessary rewrites, results documented in:
https://git.hyperbola.info:50100/~team/documentation/todo.git/about/.
Furthermore we provide HyperRC (Gentoo Open-RC fork), HyperBLibC and
hyperman our own package manager (fork of pacman) that all will work on
HyperbolaBSD.

We are sending this message, to present our vision, providing software
to all.
Has team, has limited funding and are struggling to provide adequate
technical assistance. If you disagree with the recent decisions, then
maybe our project might be of some interest. For any questions, happy to
respond, you are more then welcome to join. Look at our wiki, and to
check current state of the project, please review:


Code-Repositories:
https://git.hyperbola.info:50100/hyperbolabsd/hyperbk.git/
https://git.hyperbola.info:50100/hyperbolabsd/userspace-alpha.git/

Documentation:
https://wiki.hyperbola.info/doku.php?id=en:manual:contrib:hyperbolabsd_roadmap
https://wiki.hyperbola.info/doku.php?id=en:manual:contrib:hyperbolabsd_faq

Article/Interview:
https://itsfoss.com/hyperbola-linux-bsd/

