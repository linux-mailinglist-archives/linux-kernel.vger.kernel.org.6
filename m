Return-Path: <linux-kernel+bounces-283858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384DA94F9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71AD8B20D73
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EB0197A9B;
	Mon, 12 Aug 2024 22:39:50 +0000 (UTC)
Received: from melduny.fyrkat.no (melduny.fyrkat.no [217.144.76.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F07192B8A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 22:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.76.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502389; cv=none; b=Iw6CPNA0Ug9rWPkjh9m79kZ94nVOag4nuE0pfavMxOM+XBrwh1AmxCnNqPpWeYQVcL0phW737p1nyQv/+o/ST6EV2XB0q4vleCo7aAjOn35SU1MJax0/66H+SI7y4RRuCp8UhOSiytOdgal98oR6I8nbCyw/xhK7lwCLrCJQBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502389; c=relaxed/simple;
	bh=gU15LT00zNRGMhhon0eZ6ygnLcVbAhlhyKhKWklurWQ=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=tYtLuMqmT6EvHEh3nxjwmJEuo6YdeXg5vTohvLDx58wTgycVcfyLKbrB1ust7XR5IZltDSudw+850izdCfI0Ocr0QuBt6kU8UBp5yz+9lEZFg2jtichXGLksu3jM4makgpVV9OKaxaFSEZne+1WYtwqIeW/SoWvDK53zNfkkCgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kolla.no; spf=pass smtp.mailfrom=kolla.no; arc=none smtp.client-ip=217.144.76.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kolla.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolla.no
Received: by melduny.fyrkat.no (Postfix) with ESMTPSA id AFFB9793E;
	Mon, 12 Aug 2024 22:32:38 +0000 (UTC)
Date: Tue, 13 Aug 2024 00:32:37 +0200 (CEST)
From: =?UTF-8?Q?Kolbj=C3=B8rn_Barmen?= <linux-ppc@kolla.no>
To: linuxppc-dev@lists.ozlabs.org
cc: linux-kernel@vger.kernel.org
Subject: Since 6.10 - kernel oops/panics on G4 macmini due to change in
 drivers/ata/pata_macio.c
Message-ID: <62d248bb-e97a-25d2-bcf2-9160c518cae5@kolla.no>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


Ever since 6.10, my macmini G4 behaved unstable when dealing with lots of
I/O activity, such as sync'ing of Gentoo portage tree, unpacking kernel
source tarball, building large software packages (or kernel) etc.

After a bit of testing, and patient kernel rebuilding (while crashing) I
found the cuplit to be this commit/change

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/?id=09fe2bfa6b83f865126ce3964744863f69a4a030


Exampe of what a opps/panic looks like (and they all look very much alike)

https://share.icloud.com/photos/042BHRkrXqPO-fllvpxMFl2CA


-- kolla

