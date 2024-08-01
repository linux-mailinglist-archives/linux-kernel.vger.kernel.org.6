Return-Path: <linux-kernel+bounces-271641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E159450FE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC2C1F279B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61EE1B8EB7;
	Thu,  1 Aug 2024 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eggplant.pro header.i=@eggplant.pro header.b="Tu9Tfy4B"
Received: from mail2.eggplant.pro (mail2.eggplant.pro [3.13.54.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677B11B3758
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.13.54.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530511; cv=none; b=Cqjinv59gXb99T+wOG35oz/NGXrk+xMNT3PdLRTmpqcPaf51z0Vxyo+RRlq7IYVoLPsUADj4kHRoAYFIhZN4jcBJC1SESZVfgHmJmIfyqFV12iGiOMmpd6Gj+Ag3EkimsRgt/GsWTwZjUCYKdB+Xan9LV74aHgKitmVGLboEF0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530511; c=relaxed/simple;
	bh=evS2AUC8Jumd6lP3I7Vv40UlE2cYL5Dg6TKmnCwhM6A=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=kppP+CQi8Kr5LcxLEqqCiVqQyJioSaSXEXUypV5HrpwadYP8tQe4cy0Ip5wRq4WbMABLzK2sRPvuO03+Hm7yhiL0ngqRBx2CRxttDn3ZkfpDCzQVdUXd57J/Nor/BtgYC/dXxr+D5GaZhSMtbvKDmwaoT7kuxY0vPkA/l6ywIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eggplantsd.com; spf=pass smtp.mailfrom=eggplantsd.com; dkim=pass (2048-bit key) header.d=eggplant.pro header.i=@eggplant.pro header.b=Tu9Tfy4B; arc=none smtp.client-ip=3.13.54.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eggplantsd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eggplantsd.com
Received: from mail2.eggplant.pro (mail2.eggplant.pro [127.0.0.1])
	by mail2.eggplant.pro (Postfix) with ESMTP id 4WZZVh3VWxz1yf3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:41:48 +0000 (UTC)
Authentication-Results: mail2.eggplant.pro (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=eggplant.pro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eggplant.pro; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:subject:to:from:date:mime-version; s=dkim; t=1722530508; x=
	1725122509; bh=evS2AUC8Jumd6lP3I7Vv40UlE2cYL5Dg6TKmnCwhM6A=; b=T
	u9Tfy4B7RSOHSxCO78QAhREiMNMMQa4aSvfbwgD3nIXgw17oRHjLvPgtSsvGN9Hq
	ySRrvqMPgaU0qSlMo1KIAtGFiw4AkChco8IkCQ1vFoqivDS2TuBFsPD9WxMyFA5e
	zjzOuv1UkiqPEQsYqrKhTzPgoI0nZw7urGyzX6oDyXGPX17Ds7Kfivh4HB52L8hX
	lkXSCKKkaKz3f98tvDLMls4oj28HWXcMfZ4TMr0+RRfddUp/XqvtGBJRw0Zb1pug
	lcuTnjPsR4vkdc4qm9IfoLJO/G26wvizxKVn+jPvkksQNJvOf6XvPXz/LGU4Exkn
	Pq3WXDkEhyEkPETl4/Hww==
X-Virus-Scanned: Debian amavis at mail2.eggplant.pro
Received: from mail2.eggplant.pro ([127.0.0.1])
 by mail2.eggplant.pro (mail2.eggplant.pro [127.0.0.1]) (amavis, port 10026)
 with ESMTP id TkoUqDqnNgsT for <linux-kernel@vger.kernel.org>;
 Thu,  1 Aug 2024 16:41:48 +0000 (UTC)
Received: from localhost (mail2.eggplant.pro [127.0.0.1])
	by mail2.eggplant.pro (Postfix) with ESMTPSA id 4WZZVh0qvmz1ydY
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:41:48 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Aug 2024 12:41:48 -0400
From: support@eggplantsd.com
To: linux-kernel@vger.kernel.org
Subject: utmp Format
User-Agent: Roundcube Webmail
Message-ID: <54294c74eaa90ba149089c6aa49dd798@eggplantsd.com>
X-Sender: support@eggplantsd.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

I've noticed a difference in the size of the `utmp` struct between Linux 
6.1.0-22-amd64 and 6.1.0-23-cloud-arm64.  No doubt there are differences 
between other unices as well.  Is there a reason this is still a binary 
log?  On 6.1.0-22-amd64, it seems to be 384 bytes long, while the 
average line length from `utmpdump` is only 125 bytes, so it's not a 
space savings.

My primary concern is forensics.  There is no consistent and reliable 
way to read wtmp/btmp outside of the installation that created it.

JS

