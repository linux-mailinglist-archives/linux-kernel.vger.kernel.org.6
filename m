Return-Path: <linux-kernel+bounces-184885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8B98CAD70
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A29B23272
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978A5768EA;
	Tue, 21 May 2024 11:36:44 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F08C6CDA9
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716291404; cv=none; b=pd7vgaSSejJQlzZN3n0ZBSP6B/NveUVxHTMP5b6cuZz/c+MPPp7RHIcv2SMEx72fTsi546Zd13Djfkbd3Trdd8cQFlpVu7+hulrRpT2ooiWInCjKpPfVnucfXTH4FqJuIf/pWbNKm2bsv8qKoOFmB9u1ruSnOR+2KxGzupJZjZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716291404; c=relaxed/simple;
	bh=ZQWoLegHRDJ0koVC50FV1ML2VQhF1kSaOq31Kd87KlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SuxQmGlAOoHiSUe0DM36PmOvs9N/U1tmsqphKCPCg96AfC8JceOdfFddPD/KhsOscOi2wB5t37JIRfU465cfNnzRibywZ119REHpxNYdQxf4C7KDTPITT+Vs1ssey8kQf1TOxeMiQImwIbzTtgcq0Fhcdc5dDeCLmFMhQAMjzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.117.69])
	by sina.com (172.16.235.25) with ESMTP
	id 664C873B00002956; Tue, 21 May 2024 19:36:29 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 82644934209900
X-SMAIL-UIID: 995FF44FBFCE461097C881061510F556-20240521-193629-1
From: Hillf Danton <hdanton@sina.com>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Input: uinput - race after request submit tiemout
Date: Tue, 21 May 2024 19:36:19 +0800
Message-Id: <20240521113619.2092-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	uinput_request_submit()		uinput_ioctl_handler()
	---				---
	wait_for_completion_timeout()	case UI_END_FF_ERASE:
					req = uinput_request_find()
	uinput_request_release_slot()
					req->retval = ff_erase.retval;
					complete(&req->done);

Given the race between request submit and ioctl handler, memory corruption
could happen after releasing request slot.

