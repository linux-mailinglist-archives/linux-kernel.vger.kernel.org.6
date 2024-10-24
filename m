Return-Path: <linux-kernel+bounces-379167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5BA9ADAEE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BBAD1C21A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0397A16D4E5;
	Thu, 24 Oct 2024 04:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=LISTSERV.KSU.EDU header.i=@LISTSERV.KSU.EDU header.b="Ays+2qXa"
Received: from it-smtp-p-appspam-02.compute.mhk.ksu.edu (smtp-relay-45-30.smtp.ksu.edu [129.130.19.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9279F158862
	for <linux-kernel@VGER.KERNEL.ORG>; Thu, 24 Oct 2024 04:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.130.19.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729744336; cv=none; b=lM5/y/z3fWb9sSVqc813bFr2BvO03YwBeYBpdqwopJCswpv8zjqjDxrIrAIERMz41y9DSepd0ogBTllmXGApEamhaVzh9MsyxwVwH/UikB9xQfHebHVjCsm5AsO3cI2YsHv5JnsqNTAOW0+scACmzaVDBu3MI3T9FH5OTXFoE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729744336; c=relaxed/simple;
	bh=9xcCkePY0mgaIRPScxA0TUA8A8Xvld7J14bL3N7RQJU=;
	h=Date:From:Subject:To:Message-ID; b=eK9664yo78HFW5+LBezElRGboPfBU30DBA4Fpdi25onT/xGTekUeOqfJewrMPX67b0r1OtbF+VyDB7g5OkDs0Xi3/AD4OB1oCQDiPUG07OmnVGRYGYQdld11aRaKfR/P1WBUWCtThj34V6vG3ErI0kpAIpn2uwG1GswzB/5GYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=LISTSERV.KSU.EDU; spf=pass smtp.mailfrom=LISTSERV.KSU.EDU; dkim=pass (1024-bit key) header.d=LISTSERV.KSU.EDU header.i=@LISTSERV.KSU.EDU header.b=Ays+2qXa; arc=none smtp.client-ip=129.130.19.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=LISTSERV.KSU.EDU
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=LISTSERV.KSU.EDU
Received: from it-smtp-p-apprelay-02.compute.mhk.ksu.edu (it-smtp-p-apprelay-02.compute.mhk.ksu.edu [10.140.41.245])
	by it-smtp-p-appspam-02.compute.mhk.ksu.edu (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 49O4VNYb1062599
	for <linux-kernel@VGER.KERNEL.ORG>; Wed, 23 Oct 2024 23:31:23 -0500
Received: from listserv.ksu.edu (est-listserv-p-app-01.compute.lwc.ksu.edu [10.180.42.3])
	by it-smtp-p-apprelay-02.compute.mhk.ksu.edu (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 49O4VNu91619223
	for <linux-kernel@VGER.KERNEL.ORG>; Wed, 23 Oct 2024 23:31:23 -0500
Received: from est-listserv-p-app-01.compute.lwc.ksu.edu (est-listserv-p-app-01.campus.ksu.edu [127.0.0.1])
	by listserv.ksu.edu (Postfix) with ESMTP id 491A654D110
	for <linux-kernel@VGER.KERNEL.ORG>; Wed, 23 Oct 2024 23:31:23 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; d=LISTSERV.KSU.EDU; s=DEFAULT; c=relaxed/relaxed; bh=OkBJTgU7Q07w69akQo0QfP9k9lbI735m0XTn/pCxeLw=; i=@LISTSERV.KSU.EDU;
 h=Date:From:Subject:To:Message-ID;
 b=Ays+2qXawYwxHIgrgliSR1jp7z9VyREYLxvO1wOEQU+o9lS5lnnUR0YGKVULyWp01ptG3R0q8HAqm+yvfBxPiNNOzPHsoLru3ci1esFIkzd1adOM9y848qIJva+jzqqF1rtCzvNQrhASXYd3zdkZux1tsD/mrB4itSKCNCBFUl0=
Date:         Wed, 23 Oct 2024 23:31:23 -0500
From:         "Kansas State University LISTSERV Server (17.0)" <LISTSERV@LISTSERV.KSU.EDU>
Subject: Command confirmation request (0931FCEA)
To:           linux-kernel@VGER.KERNEL.ORG
Message-ID:   <LISTSERV%202410232331232374.255B@LISTSERV.KSU.EDU>
X-Scanned-By: MIMEDefang 2.84 on 10.140.40.48
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Your command:

                             PW REP ********

requires confirmation. To confirm the execution of your command, click on
this link:

http://listserv.ksu.edu/cgi-bin/wa?OK=0931FCEA

Your command will be canceled  automatically if LISTSERV does not receive
your confirmation  within 48h. After that  time, you must start  over and
resend the  command to get  a new confirmation  code. If you  change your
mind and decide  that you don't want to confirm  the command, then simply
discard this message and let the request expire on its own.



