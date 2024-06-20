Return-Path: <linux-kernel+bounces-223464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE9691137B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A792821A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B04E5A4E9;
	Thu, 20 Jun 2024 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b="LmDlI1Zs"
Received: from mailfilter02-out30.webhostingserver.nl (mailfilter02-out30.webhostingserver.nl [195.211.72.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C18055882
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.211.72.193
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916085; cv=pass; b=MmC7pZV2lCAsWffLd4Vy4TdDmEeYq3pfvd7TGV6hBRgK/tOe3pHeYwnB1RCibmxuOmQl95NFnTbEpLtub71Oge1veo73McDyTfuVY5r1315YIgr2EYhHOI3CMUJ+evpe8J4EC2rqTEYkYAFhRG80ALcD1RCBVU3yFeAzBVS2yag=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916085; c=relaxed/simple;
	bh=Yh9dms0WXZymrzcy0g/1GhlgfTFOFHHjmJlTFjzHqAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XvvOeblxATPgRNgdFBTpg2dpxfyaEMVRqThnHwmKyotdHn8nhucJKrYVNYLIgC0ldMI+kIF4SkSkxlRnzn5MdMI8nO1w7Z2AyFmBZyKJ0TVX4ethSAt5v38ICTzha8EmtDx+Uj6lFPvAWxB1evL52guOzKALRnfTnP/7Y239GEM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl; spf=pass smtp.mailfrom=exalondelft.nl; dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b=LmDlI1Zs; arc=pass smtp.client-ip=195.211.72.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exalondelft.nl
ARC-Seal: i=2; a=rsa-sha256; t=1718916011; cv=pass;
	d=webhostingserver.nl; s=whs1;
	b=EkvYPrw2Wircjor/4JckQKNxiSYz5vmOqR8mASFTPKrcStdO6m7rRAumoM3Q1kllyDTI9ifeAdFB+
	 442WLEPCqp0F1zaTXhD6kLkAqPTbgJaSVBioi641+QojIMJtk7p4BYwwdJhiK0FH1iFDJ/NT6O8ij7
	 g1OPeujsnGHF0FMu8okRE9i45ItjrWQZdBzrHgAvlleJl1WtBAiYm1G8Q4D7xkdzPUha/qs7Qb7Ubj
	 k2CdgqUc9qEzwBSbWm3o8qd54DSbbGDFIeC+96fjF/I74pCJcPTyuztwpWodybEcQ42HlX4Pu/8YIq
	 p/E9TXW4wP0retD0PbM/ywCgTSl/LGA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
	d=webhostingserver.nl; s=whs1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 dkim-signature:from;
	bh=q5pA4UawuXhYIJNE6QFSktffN2eueyPiIBRTp5AEPUs=;
	b=BdAUW8j+FXB2N4Eq+sGsLqAMtmgHFDOJ+puCE85QJN10Hc1YFxHOuImA4nWo02IZc0WbXIgC+WWYv
	 Ev+96mtjQeGnp4H5C5nxcqRtY7wkEv8famdnpHpCPPbs0GCEHKMkvGeKsMvgQwsxbt31IqMIiaBRKe
	 /vxyJneMXl+3d8jEd1+heSvWIS0OC/vMwRkEJ5CP0lORsT4PA2ESWC257mkqsmdx+mcOAv9kdKTdkR
	 8LcPNynUAYn6i89uasZjw51PKJdkeo+wIdudcTCTEtpc6zsXQtdGEM2c/7FkKmt/bUMRFTIKsflYrl
	 swT2vPykyfC07P8c9QIDe1hT0OyTtgQ==
ARC-Authentication-Results: i=2; mailfilter02.webhostingserver.nl;
	spf=pass smtp.mailfrom=exalondelft.nl smtp.remote-ip=141.138.168.154;
	dmarc=pass header.from=exalondelft.nl;
	arc=pass header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=exalondelft.nl; s=whs1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=q5pA4UawuXhYIJNE6QFSktffN2eueyPiIBRTp5AEPUs=;
	b=LmDlI1ZsSlyX/vF8NyhJJWWIvwbwwUgSyWpiXyLaud0SV9vmrET95maxVvgDp1lDPfII7h3lCClR3
	 FTiPTznAilLgdG+uBoB9SiSNLSEdey1lek0080CnhsGln/rmVkTlRhC3Y7cj9+iICjGgb3OUlok8Yf
	 1EEkGE+iy7SYeCd8XR/a5VGbc9BaaoEeXrY2fmyXOn91LvU/0ZmLCQiQZ1FE8GXKdSd6Gmq5FKu3iB
	 MCHSSZcl+M4LHyir8TH2HSaYeLFDKOTWF3gcn5oaRyEWDpGwYO8K19NXiCs8/xBc5h1c7nguMHAtYu
	 4b7DTrizFJVBINcyxD9rN52Ht8uHE0g==
X-Halon-ID: 48fdeb7b-2f45-11ef-ae5d-001a4a4cb922
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
	by mailfilter02.webhostingserver.nl (Halon) with ESMTPSA
	id 48fdeb7b-2f45-11ef-ae5d-001a4a4cb922;
	Thu, 20 Jun 2024 22:40:09 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=webhostingserver.nl; s=whs1; t=1718916009;
	 b=CJYk+jrJk4ZiLTQtuPxWKDOFLhf0ZlK9D9w/HgqXPjhVtMEBiPiGtXBDnXiI8uqt2zVoupm0QK
	  ibgWIr22cmqX6aNqF1b2CYEsi7LVgqZORZLJmRx9TD/VER1oRARYeBHIIzf9SCZvUHwCoBoeTz
	  4+RX1eKUtGwpNYA9X2q2gVuc84cueJFsqvi+mYi2HlB7itfKs+pz2eIo9NgCsrscQiGjj94T0/
	  2CG897su9DSsT8BYj5VAcECJ0CYSSNqVKA4rG9Pig95iz7NIUh8KlisuuqTX6Szplmmu/3JP9S
	  OZ3naFI0f0HGVjvDQLEeiag+KvfeoVfY6D5VeU85+cZ3fg==;
ARC-Authentication-Results: i=1; webhostingserver.nl; smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	iprev=pass (2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=webhostingserver.nl; s=whs1; t=1718916009;
	bh=Yh9dms0WXZymrzcy0g/1GhlgfTFOFHHjmJlTFjzHqAw=;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From;
	b=GmMOEN7x6ZBX0pkYaGrqOQ2haOFKOHKgD9AiM1yaodhB5YzwmOyPJp1451D7pnzrlJrearsU6R
	  xzKM5u71C5oTbRFruwL+Q06fi2u7hF2StZDD6jHGMMjYsxJ6NAHSsTK6WJEwXkmslDoAVLRREw
	  RomEc697pNace8S0uOoLd91yfswFAaLX2UYrtabKWkoqkDBt5aEGhJ1CbfHTvz8qI91DjspGiW
	  Ff7XDDGVDMn9sXEZVkVcUdnX7LZG0dKfGerW+aDv4HY9JhCD0w4oktmrmMLK56UzrutdK5JdFO
	  +0ccL5kWL2L2xXzRTVbVilJ9c2oVDC2chODcWSo0psy7pA==;
Authentication-Results: webhostingserver.nl;
	iprev=pass (2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
Received: from 2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net ([2a02:a466:68ed:1:d31:9797:59c3:1c58] helo=submission)
	by s198.webhostingserver.nl with esmtpa (Exim 4.97.1)
	(envelope-from <ftoth@exalondelft.nl>)
	id 1sKOZl-0000000CPjK-0LuU;
	Thu, 20 Jun 2024 22:40:09 +0200
From: Ferry Toth <ftoth@exalondelft.nl>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Hardik Gajjar <hgajjar@de.adit-jv.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Kees Cook <kees@kernel.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Linyu Yuan <quic_linyyuan@quicinc.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	s.hauer@pengutronix.de,
	jonathanh@nvidia.com,
	paul@crapouillou.net,
	quic_eserrao@quicinc.com,
	erosca@de.adit-jv.com,
	regressions@leemhuis.info
Subject: [PATCH v2 0/2] usb: gadget: u_ether: revert netif_device_detach change
Date: Thu, 20 Jun 2024 22:38:29 +0200
Message-ID: <20240620203954.20254-1-ftoth@exalondelft.nl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ACL-Warn: Sender domain ( exalondelft.nl ) must match your domain name used in authenticated email user ( ferry.toth@elsinga.info ).
X-ACL-Warn: From-header domain ( exalondelft.nl} ) must match your domain name used in authenticated email user ( ferry.toth@elsinga.info )
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

usb: gadget: u_ether: revert netif_device_detach change

As agreed with the author, the netif_device_detach change is going to be reverted by
this series, so we will collaborate on a new one in the future that
brings no regressions.

v2:
- Add missing SoB (Greg)

Ferry Toth (2):
  Revert "usb: gadget: u_ether: Re-attach netif device to mirror
    detachment"
  Revert "usb: gadget: u_ether: Replace netif_stop_queue with
    netif_device_detach"

 drivers/usb/gadget/function/u_ether.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.43.0


