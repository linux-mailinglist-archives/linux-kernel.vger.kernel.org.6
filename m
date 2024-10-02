Return-Path: <linux-kernel+bounces-348352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739E098E683
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BD11C21E09
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2417719CC1D;
	Wed,  2 Oct 2024 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="gbxsAUOw"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C391AAD7
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909859; cv=none; b=iFbaK59jge0nScaSzIxZQk9ilKcmx0IIlDhuXjRh7Zw0ZPuYyNvkOVWF1orxyXTkkew4fT8aQb4BXCOhRP8m0esSFmRmiwwLIGGX2xVlZmT1uQQL7muOx0FpNaTo2mCLvwkRTcU2aGHWcU5rbI1HZ9E5jB+R/yTBbQxKjck1LVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909859; c=relaxed/simple;
	bh=lAsF6IVlXe40lBcUjo3FNXG5ZR2xnvYds3q3H9gIiis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUpfX6CKBOp1yLoIqMc9xznyzu7NMuesEMVcvtTc7MIqYpMeb1Q2LX9ZMlBsMGh/sZkE6lO9kdHRMWXiZIBXSUwDFjyNZjajVMoh7kJU1sSv/JvYMl9Mf/ehZamV0g7cJ+B/yB2Vadg1tpvSXjpjBl1a0HZPCbi+1vCyEKtqOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=gbxsAUOw; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727909845; x=1728514645; i=spasswolf@web.de;
	bh=lAsF6IVlXe40lBcUjo3FNXG5ZR2xnvYds3q3H9gIiis=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gbxsAUOwkeWXl2SNwA4MrgBVE9/fPcXzpEwoKtcjgMMIAtkCOmO0sea1azblrVkI
	 wm1V98Nl7ulw3MlM8yCgpzNE9XEYP4pDbaM/VIfkUOsvcw68ZGJMFRpyndcqJ/ejN
	 Y9uiFxRKZkqfspPDbgJojPkrDsLGsdEmxyb+HpxpxcvgRRL9jN3pZT4SqoBIzcRjv
	 mlDKRkIHSOdpbgVM7oENt9cHQi4WzaX8dOe/YCnALXtzf3KGU6yUddxhYjxq222eD
	 511EcFfgSDj/jXOmOqaZg1eApcDcy/1TfYFuUp86S7GsEzC3AdbpbtCUA8+3hZ4h5
	 l9V4GawU1GcuP3fCMg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MftBr-1sFvhs1dvt-00ffPO; Thu, 03 Oct 2024 00:57:25 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Date: Thu,  3 Oct 2024 00:57:20 +0200
Message-ID: <20241002225722.3746-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: 20241002215808.5475-1-spasswolf@web.de>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dcVF57nzmWjv9Kqavfj3Y87JdJ1oZOuf/cHghXf4g0NowELCMbU
 jqz97cwAqPSLqhh/s2yW24UmYUEy0lwZgVYt+ojKUEvuK5ZyvRDRsihOYn5temfNPCNF86t
 xRgSKyXVrfFbZk/oev+hbd2dLCI5OucbWJRFR+2hqFYeP/V0yuO+oR8LyrI09uWtdEElIY9
 tWnDNZSaTbYL/N/SITY1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hlQOM40TuE8=;Bihb255ISJTyIiQH3W7mKk0/Q6O
 SpUSd4J0SE+usEC15yDfmX/DvOLf2NpwJf/G9fC2P3ZnlL2yFs29CHbfeCrrSwI3XYeVgoepF
 6S21Ukfb6TlJa4mkurKj6S9fg48IhrGX+e1K8ZfVGSLIwKX0QHDTxxyBSdno7fLeYmFA8WW9T
 6QCPKyDdXVcUGAVEDGEidgzQUln0PFKzuvhM+C72Wfx5kHXsGezRNJHxnsul6yzCiiPENC2b5
 GDl6tcJPFTYW2JUjBspSG/FwaHdxCI/knx3Da15+JzEWsEU7exW6DJgkicA6ooIchGZJmclkA
 bKY9en3+qNuOh111zkokjFmyA8EeEq45LIq2zh482maHCanMtMwiC4Nfh4PwCI+BJT8MM2+gD
 8oaz5oqIvWiiDiAApp6IO1EZLz79+EWmzpEFBEoZQMNajfabjpbdFz1aonxrjk+Vb51bq1rce
 GOeWrTF9Z4l149NQx8TO3SRihsrm1cU0dAARWVW1XSTnTY2agv9RBVMVGYe75FLwqQT5qeC9g
 e9jNVWZV2owgGT7HMspv7QWcBkzPCR4LSXwBpiAXvThiIiYnc3s2xNULMCF/xPkUuRm6cGw3N
 wg35ZbWjRwk9Zcs6jtuyxULWft9c8oUcCVjxGl9VH5ZqvdqUPjG4Bf0EiBJFgXoi4ceuiRP7e
 4eK+s04AGr7XrhumBZ5+syqnFw4zcGaB0q2n4BWgR8yxGnTYzlj7IrFtZWm5WjUJjl3FZNoRC
 TfTS6ps5BTCv6IwKlfXBoNA8CM5Ci4QEWg7xNuuwgPzMJ96ITnQwqQmQEqh34SZrWL0ZxTu7g
 idSk2fpwgIIO6e2Y+nU2zHzQ==

I justed tested the same kernel version with a .config which was created by copying
the .config from the standard debian kernel, running "make xconfig" and saving.
I got a crash here, too, but only on the second attempt (this has happend a few (~3)
times before). I'm not posting the log as it got to long due to the repetion of the
procedure, also a standard debian kernel does not print the thread id which I guess
will make the log more confusing.

Bert

