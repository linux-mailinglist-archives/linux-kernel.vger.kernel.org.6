Return-Path: <linux-kernel+bounces-348354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CCB98E687
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169481F22CAE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50E419CC0E;
	Wed,  2 Oct 2024 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Rywbkb1x"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46227DDD2
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909949; cv=none; b=WlQ9xpljo07uRXWi0OIuajler/H6fqv70s0YlGzhXftkB29n2hwgZ36ED+M6PcF/rbr0QXcLNMTwesE3MdXnfeQNn3ClyyybbBU+Qb577jg3/+I/dPlxvLd2pjaedDZwtMiDRc6S8kiJH//eZAeNCkNNAroAMW0njH4UNVFMxDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909949; c=relaxed/simple;
	bh=lAsF6IVlXe40lBcUjo3FNXG5ZR2xnvYds3q3H9gIiis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKw51WTYetM13M9DQDrJloMGqLFe6OdA+ok9l4o55T8+/G01DOTweiHvNnbOffdKi3/LobXlERhjppNo/KWPnvaUFXnTJprr0kR1apW1F6VpTkgu5NV/y7I8dIrO4gCA/HkzfnUudipKJxVPnkZ5Cimo7JSBQYEBJArvz/8uATY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Rywbkb1x; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727909935; x=1728514735; i=spasswolf@web.de;
	bh=lAsF6IVlXe40lBcUjo3FNXG5ZR2xnvYds3q3H9gIiis=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Rywbkb1x2g8uTear9w2wkmaW54hOLLlCVgjw1kUirxaRJIFWzmIFU640T4i4+yj3
	 85hQ6fGM1E7xz5G15hk2TOnBrDECNDGCBBloJEoGm/M+adwl9ldCwIXkTxeqyrARI
	 bpgekldXkeroEbz4YAA9TTZzTawUbfZnOU7qZyzV//Z4Z65BRIOmUv8e/iRs7zfqi
	 b6PSpHZ5uhbruzcf5M33rjdFk3TNrsSASw+9bIv6Rx1qDmT5U3pcF+2A5uozrZjjs
	 JFbK9Hlosw/E6ughuvlpJSd+9eP4sZe+Zd2JywTbk6LMq2BIz4zcpdSTm1egJFnoT
	 6BpsaqzOBDfxpv6ICg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MJWoU-1scH4R0VFg-00JMLx; Thu, 03 Oct 2024 00:58:55 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Date: Thu,  3 Oct 2024 00:58:51 +0200
Message-ID: <20241002225852.3863-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: 20241002215808.5475-1-spasswolf@web.de
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RYTTU9MEafiMd0207De91fwINDOAE+xPa4p8iB6BTt3DPozc+C7
 ygpexCEQN47dXt4E8BVmvsRGB2K+XcGABo20fbdwY/5Eyc1bqgoPxTFpb7Tw2rLwQ4s9hVr
 PSqX2cF4A/I0Jm7LoeeyDw4N7RY6wVSwjkCMVCa8qG1Mfmhblxf34DeFDVuhFeZUSQnKQxf
 sqCnZ7BMf6RrwZq9Ohqag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BjaJ/4095ag=;sW6sDjW4gfrLM5QM3WaKObULrTs
 k9ANOxyoOX/s354xPYGe2nC+vY1qLfLnfvTHIeug5jt3oNaOKns49yQY7ILBM2ZZ1M5w6FuZo
 9E/rCG1pnH0+/e8sK8XASsQYot+J1VOwJcqjuJYwyRNABLkGaxqePDrJXkzktxhH/AEo8eT0Q
 RS7gdZa6W5tBwv9oGjr9idCTdPJdpSt8kfjZMIPuERDzUcHkLsXp/nN0ilWGV5LhwC8swOpyz
 HbZmJdkEA8mOV5DINkEWR9dVNY0S7wVX4F3GA6hSD2Kv84w8QWsqXC2o9uRGeWXPet/QC69fV
 /nZf73nxk5c+8GNPCB5di6Xczm6ICsuR0jawSvVpEF2iqmXsiy3342pMx5JZr52/UE+Ken/gx
 7OloXx3oyMfkdvBOCJmsMTwJ7NEkr3NRLbuDpT8OcWpbnZ3pcxhGBLtwwRUxveC/WF78N35pi
 32adM7VYGbNjHgP5EoigbhF7y1/h+jSWbDQSPuITMT8h/pXwT/kxu5hG6suhm41daGsVpsDVP
 yF3zqhG01swQf4J6lPpS3iUgRlO79PkNe86R22IwuemOmb/t/n0PZv5LUQMI5tHUjUvq+brKH
 ZBY/TUDy58ZXjCRUC0DQlSsT3kGUcQEjz7uRb+2Fvw6W3z1vh8fUlXoEztAf6AE2KxHBcjf+x
 YwMbdrqN56W8Z2XJJJF8iwcg/EF5WtTwt/eI30qqw8B15h5EER+xHf4Si4n09ir7T6RKY0RnX
 K7JwZUrwUo0OOwsz7MP9HU3nGHTIWdoZZjU/idFybEL7nVm071ZWBBYMrMZdl2I70eqflLQnw
 /fAC81O+W/S0dyQHEXOMfdsw==

I justed tested the same kernel version with a .config which was created by copying
the .config from the standard debian kernel, running "make xconfig" and saving.
I got a crash here, too, but only on the second attempt (this has happend a few (~3)
times before). I'm not posting the log as it got to long due to the repetion of the
procedure, also a standard debian kernel does not print the thread id which I guess
will make the log more confusing.

Bert

