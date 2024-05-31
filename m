Return-Path: <linux-kernel+bounces-196696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3AC8D6007
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD7A1C229B8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1990515666F;
	Fri, 31 May 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="TfOFzbxn"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4D15099E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152637; cv=none; b=FOPCzy7Jp6w2Y4CBkJoZisCHOlRaav4SU5Xod4Galg2udqbHTnHGeFmuAn4hXB+Fqzi0F3DGy9BOLwiXH3CjKw5M6V38OmvHqqNkX2TTxoyHaKNBNIXihGsrTzMm1/doCKowJH8gK5Y2iwjsvf3zbkYG4RNgg5H/2mY9HeRDuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152637; c=relaxed/simple;
	bh=UY1FqDHsZnYgoumOk3tPla3SZJqZ70NOtacqSwzZs+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fQWdWjvrIncT9+7Qt/JGiG/ND5a1tFuSjc8iDuKZoEM1+2CwrRpTQypJMd2D+Z95jb0duqiIg/3bnwODFN6lK/SdDOhXSEO73H8ZAQS68PEdy3NsGuGbu/IwYRa0Db+N9/xty5Uq9eeg7xj2ISvKY6ePjZMAKwcqf20D+VPPWjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=TfOFzbxn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1717152633; bh=UY1FqDHsZnYgoumOk3tPla3SZJqZ70NOtacqSwzZs+w=;
	h=Date:From:To:Cc:Subject:From;
	b=TfOFzbxnIk5YzSVmKszx+/7eom1GXGZF9Ehz/5CKVW1+fMkEyJh+/h88ll1Mp4DhQ
	 g24cdiB0pdgzwKVGlPvDiCwdzhcNLv2Y7PQ1on1hDZ/8H4PKorOZnrIXwcRh1s+PCE
	 jCyYs2d/xUAlBFQy1nTzzxLDax/rS5P+YCQIT1qk=
Date: Fri, 31 May 2024 12:50:32 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Joel Granados <j.granados@samsung.com>, 
	Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Current state of the sysctl constification effort
Message-ID: <7823ff95-1490-4c1b-b489-a9c05adad645@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Joel, Hi Luis,

most of the sysctl handler preparation patches have been picked up by
the subsystem maintainers and are available in -next.

Only two are missing:

* utsname: constify ctl_table arguments of utility function [0]
* sysctl: constify ctl_table arguments of utility function [1]

Both of them are going through the sysctl tree anyways.

With this done it should be possible to also queue up 
sysctl: treewide: constify the ctl_table argument of handlers [2]
for the bots to chew on in -next.

My local builds are still succeeding on the last submitted version of
the patch.


Thomas

[0] https://lore.kernel.org/lkml/20240518-sysctl-const-handler-utsname-v1-1-27a6c8813620@weissschuh.net/
[1] https://lore.kernel.org/lkml/20240513-jag-constfy_sysctl_proc_args-v1-1-bba870a480d5@samsung.com/
[2] https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-11-e0beccb836e2@weissschuh.net/

