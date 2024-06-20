Return-Path: <linux-kernel+bounces-223480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD4C9113A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2123E1F22233
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A3769DF7;
	Thu, 20 Jun 2024 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b="iaefMUsz"
Received: from mailfilter04-out31.webhostingserver.nl (mailfilter04-out31.webhostingserver.nl [141.138.168.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7693D3B8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=141.138.168.145
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916595; cv=pass; b=lFRvIC2V2nnFFuK6PYrsY7BXjvXIePaiNhmemVmtuW1crnYRcrha8MdCRz2AQnPNtjS/cxKSbv3F0gDERhNnD70BcA8D10tY2vOnWYDMQ+xtremQ3iuAMFUO4DOYZ7n2iJdwHfWK1zh8zmMPwUbDQeAzSapy8HB7f1fOzgb/MR0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916595; c=relaxed/simple;
	bh=tO7RlLGvnbzcseEbdf7AXIl94m/yGIpURI+8T+ue3CM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RzIyj5bdOFmOt/FD9RAroeow9vs/PkFdYslTEJv1mZRF/uQC2/wR4VhyHc6AOnhA++3/5W1+Br8alHsoF54k5eCLZ+B0Z15ohMWQAhF9QS5XUyNMBtH6aeud1/UqhVnCSYnDQgLx2FZ+FF8OOJlKHlzetn8rzHmSFlWGLNe/TBk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl; spf=pass smtp.mailfrom=exalondelft.nl; dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b=iaefMUsz; arc=pass smtp.client-ip=141.138.168.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exalondelft.nl
ARC-Seal: i=2; a=rsa-sha256; t=1718916524; cv=pass;
	d=webhostingserver.nl; s=whs1;
	b=wnFydICEv+xW3xlIRqMyR/l6ybBVxvqH/oLdCpWeoXCCYv4fbsrCxd4WwIUjRGueaFwRwlw5sFTDT
	 h3CBzS5+hpa2qyI/cFEXffnpzVjKFvDYzWldMpgDEcE9m4nwPO8F8XHxEf44CpuVipl27i/3tMzOlB
	 H36jqaG1fZnM1iiFKKvHRiZiHdBMNxfIf9f2TKMLmMxquxdD/VEXbrHE+lBW6aH7cW2PVvgL21fFQd
	 /LYVFZwa17PjiMThlsZSoemk3ciqNlItftbu1NmDVdKKEjWyECWxe5Uv2D2f6l68xH5xn0GoOxyF3W
	 JqvUZ6fqgQR8BWTCjQTQAcXxzbqkVMw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
	d=webhostingserver.nl; s=whs1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 dkim-signature:from;
	bh=9+M3Uv1SDWgEtwezAhMtgvAm7m6c69NggQHCM24fRB0=;
	b=X7Iwj+AOfuM1l4OKN9lzCBWw2690WdTTVZ/cquD00IXeZvK++eepKe3cX9zMJZulaQKzAVe65gots
	 79euhqAFr7XlIPRlKjfCLQSor3Asow5j4Qb/EvmyMj8gMJO53/HYvq9STAqD9cMCSn1fPqVd6XUzCI
	 RQBBdmx9m7VbFOUynusS8BMJx3PQwqWSnDuchSVzqP2us/Weu9RX+KHmuFLj2Q19wKubd+P0WUXf2+
	 jc6/8lOB/7QgTUVYe/iceBAECMB2jXQ4WZaDCHp2MXkwtYTgcGPiZ771sn4jFl4YYNv0GzQAVj0H/C
	 zXIu0nBUD0wljVmAQhKnzNFo/W4dTjw==
ARC-Authentication-Results: i=2; mailfilter04.webhostingserver.nl;
	spf=pass smtp.mailfrom=exalondelft.nl smtp.remote-ip=141.138.168.154;
	dmarc=pass header.from=exalondelft.nl;
	arc=pass header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=exalondelft.nl; s=whs1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=9+M3Uv1SDWgEtwezAhMtgvAm7m6c69NggQHCM24fRB0=;
	b=iaefMUsz8UggPjTYIA44AH7EVYegCGiJ/QRCDSjG4xmNbrJTzRXB1obnmFTc/1CoNScTfFioavVle
	 OrN44Wn/HmdmMD/sU5HbKQWhPjjwl4i0P+ULeZuYsgAfJGqx0oDUAWx22spEiJPPdW83FrCkeZjaMV
	 9QmoMzXBVMbS8Q6IK7dxhlqCSv0jVG1We6aZvObn8ypzgQCi75DD7CU/CSTlQ1rV7BYW5hH+icKaNC
	 nMKze9aYGe+03I/x9lr8SIeJxJcfCxOb13XLLtTKiyyhaYwcsxYLG4ThaK95i+k+xfxLRwM7XFKwQ2
	 APp5Wdqhef71R5mlSyMmOKMZ4kbgsfg==
X-Halon-ID: 7ab212cb-2f46-11ef-bd6e-001a4a4cb95f
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
	by mailfilter04.webhostingserver.nl (Halon) with ESMTPSA
	id 7ab212cb-2f46-11ef-bd6e-001a4a4cb95f;
	Thu, 20 Jun 2024 22:48:42 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=webhostingserver.nl; s=whs1; t=1718916522;
	 b=Xp/WLBvuEUcU1nsOMV1hqJRPU2JUbw9r480WaPblP/zecDExKlgvizFSKziCp/k9w7mqmBsFUX
	  8OaK/0o64dTMv9rINdZcTyEHVL+ePqS51M6/76zPZpsaiXGGptd3C3o9xb/U3Ez7zBlOJlMqyN
	  5kyvsfnSZwV1E0d/BNvJYZNpVb8uj1m1YTVMhKUOWPwUeZJq06PaMseY4VPF3ho//PuJXYdNY8
	  nAOzuMz/faC6zs30vHuHI80UPd+LRF6LPeVbj70sozsQcGcRu9sTX2b1XZcEUpuvI8tKH1j9zN
	  X3Kz/kwB9DTfmQ7cLyJELTA0qs/ucU2vb+U8V3C43W0Z/Q==;
ARC-Authentication-Results: i=1; webhostingserver.nl; smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	iprev=pass (2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=webhostingserver.nl; s=whs1; t=1718916522;
	bh=tO7RlLGvnbzcseEbdf7AXIl94m/yGIpURI+8T+ue3CM=;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From;
	b=qv7djCnvLVoPb7yFq1BaONkGl9GKJZFHK9siRE/5vRnhyQXQklkQ1laIt2yvndNux3aDHZi13u
	  PYQovDcM56m8M9F7KAAjWCda4kGuazwwzWHseAKnP5iHXwaLghJm+C+lgFK/MfGqCDq26wZNdM
	  H0hUHuHC7EbN4r9OaesELnN52MBj0W3mSUvKf+LdWdk5XKWg7TX7bppyFmZo/WCSeexZvLKEKP
	  VpD/8j5BnvfekWvpmJTH72CpRWmcjcCtwtmwqD2LF9VR+2mbkFQ/gBO7QDmfKHEtg0kR3mrvin
	  edjaKqEnRSjh5H+F6cuiGJQmcLGvOSTxC7QyVfE1pw0G9Q==;
Authentication-Results: webhostingserver.nl;
	iprev=pass (2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:d31:9797:59c3:1c58;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
Received: from 2a02-a466-68ed-1-d31-9797-59c3-1c58.fixed6.kpn.net ([2a02:a466:68ed:1:d31:9797:59c3:1c58] helo=submission)
	by s198.webhostingserver.nl with esmtpa (Exim 4.97.1)
	(envelope-from <ftoth@exalondelft.nl>)
	id 1sKOi2-0000000CsKj-10V7;
	Thu, 20 Jun 2024 22:48:42 +0200
From: Ferry Toth <ftoth@exalondelft.nl>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Richard Acayan <mailingradian@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Linyu Yuan <quic_linyyuan@quicinc.com>,
	Hardik Gajjar <hgajjar@de.adit-jv.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	s.hauer@pengutronix.de,
	jonathanh@nvidia.com,
	paul@crapouillou.net,
	quic_eserrao@quicinc.com,
	erosca@de.adit-jv.com,
	regressions@leemhuis.info
Subject: [PATCH v3 0/2] usb: gadget: u_ether: revert netif_device_detach change
Date: Thu, 20 Jun 2024 22:46:40 +0200
Message-ID: <20240620204832.24518-1-ftoth@exalondelft.nl>
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

As agreed with the author, the netif_device_detach change is going to be reverted by
this series, so we will collaborate on a new one in the future that
brings no regressions.

v3:
- Send out actual version (Ferry)

v2:
- Add SoB (Greg)

Ferry Toth (2):
  Revert "usb: gadget: u_ether: Re-attach netif device to mirror
    detachment"
  Revert "usb: gadget: u_ether: Replace netif_stop_queue with
    netif_device_detach"

 drivers/usb/gadget/function/u_ether.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.43.0


