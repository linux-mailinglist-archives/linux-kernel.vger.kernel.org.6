Return-Path: <linux-kernel+bounces-395709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A13B59BC1EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D896282733
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A202AD51;
	Tue,  5 Nov 2024 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="D8vZLMYS"
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81A1FC3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730766085; cv=none; b=rl1mz1a/eyxI/DI97iysT6zZrG08hvV0bo24GqTMTGqxLzBe1soJeZNqwW1DvIC7U5MrcAHAZ62SMWM2pvADkFgOpLVElkNkIemAPDXSn/HGNFoNsbdB37yoYWumJY0ZSH5sPIf5FRmRgiCL2P+1Ck3eq1OyOjZzd5x8KsDmNRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730766085; c=relaxed/simple;
	bh=wBBLFthO+avPZvl0w3KIXQNCx7bhiRzhVB/eKjmtLzM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SYUbfTFKdVJvipB5biEoMpbLKTL0UVMyhLOcreYe00e2WT4akO4UDTZX7YT03j0aBefmFzefx0gcaTjG+RNknDYUNtoizDmAlxvJi2WZRqPNqe5qsBpocuGqlBMsrQrW5qKcbQjHkLEev2vCnKxjoaIL/hfH1CdYTeYinj2R61Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=D8vZLMYS; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730766083;
	bh=1yNbghBGNR5M3r2wBA1SDgzK2daDfmstQj05ol/VTJQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=D8vZLMYSTnoKpBOwZpeEZXxXFOiNBv3pminS7s8RReGm0YHL5VDJt/EWzd4zb7oEj
	 ZMRRagZiHA5UQcdCQbPLynmnKLkdsVQyTgKWR0eS9N/YBxgbxEjRZptOr1vxc/hd4N
	 xGzp/dhlvRZCnNc7PbAV0LnVlh7nqUhlJqSPS2mTRRyCMg/ME8k9f6EWCo7pmAGIFo
	 SacWXrWJ1x6rLrAU/jcADEekfvK+7935o0M0mIo6RUHnx28Mpxp245C9fkhWDOgdIF
	 pJ8LkmmDw+oo2Tp8zIC3ytZjIClJMW4ZKOScRGrF00k8pQHivfhTKsCZzD8Lastb3I
	 gtM+RvYpGmUmQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id EE0A9D000BC;
	Tue,  5 Nov 2024 00:21:19 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH 0/3] driver core: class: Fix bug and code improvements for
 class APIs
Date: Tue, 05 Nov 2024 08:20:21 +0800
Message-Id: <20241105-class_fix-v1-0-80866f9994a5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMVkKWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwMT3eScxOLi+LTMCt00Q3OzpBTL1KREIyMloPqColSgMNis6NjaWgA
 SxVEMWwAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to

- Fix an potential wild pointer dereference bug for API:
  class_dev_iter_next()

- Improve the following APIs:
  class_for_each_device()
  class_find_device()

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (3):
      driver core: class: Fix wild pointer dereference in API class_dev_iter_next()
      driver core: class: Correct WARN() message in APIs class_(for_each|find)_device()
      driver core: class: Delete a redundant check in APIs class_(for_each|find)_device()

 drivers/base/class.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)
---
base-commit: 9bd133f05b1dca5ca4399a76d04d0f6f4d454e44
change-id: 20241104-class_fix-f176bd9eba22

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


