Return-Path: <linux-kernel+bounces-216309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73518909DC0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 15:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159911F21D8D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 13:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F191A188CD4;
	Sun, 16 Jun 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NO6gXATb"
Received: from out203-205-251-84.mail.qq.com (unknown [203.205.251.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61EF1DFDE;
	Sun, 16 Jun 2024 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718544598; cv=none; b=F2OHKmFavjzJVX464QsO0ETr3HzwXy34AbK0xLGA2G0+khzuYQGZ5UdDbxTSmRCbE2TBiXxW0cKEtQtx3E80y+oY7vFC/+de6VatMaKaY0GChgDTc6I2hvD2VJcZnpZsfb+568N7Q9Yz1Rymzy312wOrMfaWRMqF5jRO0cy0b2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718544598; c=relaxed/simple;
	bh=A2Yn9Be70Xe24ZE7ljQQm6mUKY0/vvCiGlacG+PDEkE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=arJXcSx+8O1YKFxeATSD8MZtDgbP7jnCTwF3WUFmAoJof0HsbtAFAH67frCDPD7/EVoI58SfgnuM9cewceG/EaGnNEFeifK7o8EVleSakE1A6ShABrtqIr/Fh93SBmwTEVyyXU/aq9lJeOMlGiOwRNiqwXmjYOPem9mlPPdLjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NO6gXATb; arc=none smtp.client-ip=203.205.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718544287; bh=qIs4X5rUsFsB6YbZepT+e3Lmq72es//ofNH5obBTrKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NO6gXATb2AjFe5S3dY+0ziDy29IYLpYFiA8iERNslAXsk5IdA3pveVvmYqj8JWaec
	 PC5mRuRBxarPX8Kd0LsNPJqw/m4RqQBLJM3/OIClZDG+BOlu/ieT82OYOqzcIDrpK0
	 urNWhQzAU87sk0WlBCOhfjdvDabJS7wL1frG+Ec8=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 49A14659; Sun, 16 Jun 2024 21:18:26 +0800
X-QQ-mid: xmsmtpt1718543906tmp3d8lpl
Message-ID: <tencent_FFD6C6DB52C846598999EEF3AEC04CBFE706@qq.com>
X-QQ-XMAILINFO: NvKyM24IHTKSRwfinymltxIIIUSW4aH9kToFqNBIPZPLNLOWY2bSsAJpTCa+BV
	 5cJeRcnrwFKNReVPMsj1yG5joGJKrYR27tu9gDyqR1We/XLK587L4hqt8RK17OU2c3CpzwY4sKtH
	 9roenybAmr9TR4+1fykw4g8Fc3Bmef7rq7/cEOC/lyLkmCyjE6lnxV4YUBIy5zCSRdo9kLmVylne
	 PodrQ4bQtBL1VOpQAeAc5nEgNU7GqSYJsKjnCS3fpDy4ojphF57qVOKgv4zBhLPpJNboPNLAspsM
	 VbeXzsMysS0SjXAeHtF1O4ZLNtIDLTFynmA5q0O5h+BNyQyFyuKkXCW2wVeP+F5vRvk2AhsFNcao
	 eQ1ZdwJKa4152TTD97GzqoS92JuhW+RyoF3ctgtnsaBf6Jzw3mVyz48WzBKnbABAYN8b8AFkga1k
	 RuJXKaz0NA7Tbk0vhxVT36DlgVWIFtl1pZkbTjV6eN60aKfnyV3/dCzJKsEiVGyZCTJFXJbc5rn3
	 wYbS7enVNhtetO9PsZqL6imwbwf/Bq8EeXBur3dMxQhJcvp7sz6y3enmrXNHH0QyaqKdzxx1Ekdt
	 noW1qK6ESSotzus1Yo0yei9mG3mozLTohZcZqWhDsoCXQCMNr3SqeJashF1u3Vt2KJn2hlrSgIig
	 vkML84ve6BAONK4s1konKrO4IMyMzSwlnEYms9kapeGLb5pC18lSu7xROMuQuj/AWVL0FDzPI5sj
	 8duhbuNQBff52XMCBzdaZPvHRmHZqcNWt18lZ7yAA+6tNnhqoZY0JhK4mvl++OSWf2jvVBkTaqWK
	 2wM5dQ0ZoL7Y9rwGC9j1MY9CD0T0D/coBoHeGGKvhBucJigBbVyY6WutJYYL/i6+7OvbRN9ayGHf
	 vGoMQ83QsTbU1wtxkN4SNufjKQ68uFuCUngpi380fX231QfB02sqzGphCtlMGDh/9V50qZSsjCQf
	 k7HmC3sn0bAaMoOW8IlbU48WkJqnGXlG+dtAh1Oqo=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: paskripkin@gmail.com
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	johan.hedberg@gmail.com,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	william.xuanziyang@huawei.com
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_conn_del
Date: Sun, 16 Jun 2024 21:18:26 +0800
X-OQ-MSGID: <20240616131825.581073-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <fcdde042-6424-46a8-9fa6-e4f4021b0717@gmail.com>
References: <fcdde042-6424-46a8-9fa6-e4f4021b0717@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 16 Jun 2024 13:37:17 +0300, Pavel Skripkin wrote:
> > hci_le_big_sync_established_evt is necessary to filter out cases where the handle
> > value is belone to ida id range, otherwise ida will be erroneously released in
> > hci_conn_cleanup.
> >
> > Fixes: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique")
> > Reported-by: syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> 
> There is one more user of  `hci_conn_add` which may pass too big handle
> which is `hci_le_cis_req_evt`.
This case only affect hci_le_big_sync_established_evt.

--
Edward


