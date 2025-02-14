Return-Path: <linux-kernel+bounces-515720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35876A36823
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C723170F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AE01FC104;
	Fri, 14 Feb 2025 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Qa1FKUpY"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3DF1DC198;
	Fri, 14 Feb 2025 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571218; cv=none; b=pUSb7xUmaf23a9QvzAhuvpWF2zS8M82Y/aINuIRUqQgEYs0K2QoCczO4ygjh9um2RzejLmAkaduoUGT6MTzAOkqHSlDK97cHkG4a4JMJJPjQ9fZh5uJXQNZcrOLB0Nbqf46u9b3Nf5t4QbiYcVzHceRWOD0khc4bh6kyrB+KULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571218; c=relaxed/simple;
	bh=A976kho9tvDjwldgynuMsJy0tUCAeUQXR3jZw4nOWUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AhfRaXG2mDv6EaCYk80r9J7m4TUAykKOoELOv1K2pYdF4lT0BUbrifsx+G1Y8uoXQxC5Gw5ItN9dI5BBPX1nsiipKoqJeoNeteVjTJy1cPyZ6z0bXNo00nt46oTh5axQpvsN7Xm8rW++7K98SaYo55Oo1ZibOXg59guomr0Jxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Qa1FKUpY; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739571210; x=1740176010; i=w_armin@gmx.de;
	bh=5QZ4BawZWjsxXt1lxQ7qg5LeWAimKHrcKnYrlxWUE14=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Qa1FKUpYWCWPxC5pLH47fkzswIok62J0ZMF2fTpv31UICV8qwaRJEYjrMC8Oe1NT
	 MyaQ44bMQ5QRNG485MIT9oEHRMTX7ea1we+tItNDQ/lRVP/7/DgE0Lynq3hKSEdAa
	 hfdSED+8gp1H+NBs8K0dyqndvjn10rJeAMrGL5JHYj122NiyXcLzPzmevzp7YIvq/
	 ZU2MnuvuXYaRpeDeOkWiJyjCPBy4SHyBDYNMRNrtFijk9SKPhBbGOpNZUIJqbQ9zi
	 c/INrxqCUI3vbfIhFwB9LRIChMF/dNkB9qTyM0/IjI9y7qcSMjxGmWP0ums9qhjkT
	 2UDAUVwgqYiIMawlmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MLzFr-1u0Jq43uIT-00N8PS; Fri, 14 Feb 2025 23:13:30 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] platform/x86: acer-wmi: Add fan control support
Date: Fri, 14 Feb 2025 23:13:19 +0100
Message-Id: <20250214221322.47298-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/TUWr9hKVT+HhzqbiK/tUjh/l7dIJuTNIFlSStIGcxcnRrbX8UX
 Q+aak2T4YFBuAwcN3NlCY5XH2bQWTbPF38VTmzYpZF2nyN2lvtc7elpKRT1Nca7KQ57M5kJ
 JC8LzgVWiMRPYbPIhac2eJPFRcainj47hLT4+gMQ3pvKcsXaOdLZQJCnPi/48t0motrabW2
 ZkWv/m3HngNlazimVAF1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2H5ckGdaZ1Y=;blqNhZoXQpRLYDheqoe2Z6GioqA
 CQOIR5UmlUDt6kLb+noy/ncDsK3swxvs7eHTB7aavuXar9vzVzu1+NcyMUqkNMfxQjs9TMHKK
 kFWStQCYBks54XEPmd0s/piDsYFsiCRceT6egAaFccm9bCmjpX5ggMRzTf+nCLecpdsZQB1bo
 +Ng46QEph4WAdFlDj3wg2DPZ0VwEiQfHp5INL5WOuj9JBsXvSWnIVvCQ8PcKhYItgv6Hj5YjV
 zRlCO+JoXd5Xsr1N59JAgKarhI6a3Uc39P2YmBlCxmHs10rIKXC3pbMwvfraEYkLC6V37ThIQ
 TQyvDxBLRWkMsHQSEe0lndw0g8CAfaZ7d/CQvgF3KkSVLuMGuRDo1+zktf/14zOxLp8c8+FZn
 XuOUe2AsdZUi1LwKcmzzd5GCJpMr9ZNpjRvbdw06geBsEI/AGLiyEe3iI9gFZNbyx0CV3AIpP
 gGFW+bAzP9VQzsMCB2BGinNT1GtKJqI2zxCDLd3SNcfYJq08+or4q8PQD/1XvOXE1qSH5gvKN
 LMR77pGPxYE6sYoX42wr/zmweaV9uitaTqRjndaaGUsW9THIOulL1KY7G/T4Hxh/Htlh8ssUw
 3J2RS/Bh61JbtMBtb4EGagznCVwrc+Z77aiXj1YW7AGAkviI7wMhV3RPFoAZalWGWuYoJH5gb
 OaBtWAc5jWyZeo3OyLshCjtiUTd8rKHV6NQhPCExFhZDEym2oVfY/5VbiC1Dvetgzv09xwL6L
 9oi+QtAkdRzdw+3tOpQivhLUXx9OHwAZvPfaGO49qmyUor8lMaciw15RTUQmVKmahqfLz+ve+
 l4tDA8QGMNuii8UbWcTSiFGOTOlIdAs06Vwo9E2WGQbVGTmr/jSQN3x8dOeMsbf7UeIgBp4sN
 4fw5962Ch7b9Mg2a2LMe86Hp+nnuMEK9CvXxOy4gtR1LOjzom/1sue7KPB7s1QUSVj8P5w6CL
 XrLJJCkkkmSScvFlbv1viLGqlUV9+Old/iyyeKPr5LUKKyE1wWMsSY8LqNHPVTDd+g2kpoJwD
 n05Urugo1rK/VNxqlNqAMTk9tzh34R+KxMzu0BMc9FVtxcyqqnwdQEvz2FBI6jmGt2+HAojVF
 BbhMJxDQutTJOZaaI1t6KmJSRT5loQi9Do7nl5VmPfLKSgPdth2Fn/sHNzVT+j24cEH9F02TW
 fYGJ8ZA4kLOH4FXXi0CVnIK3XmIxipyL+ZvG7M6ut/QH7S/7HQ+Gi6ZchORqwa1IZCoa2Iv38
 aLcuXD/P7FIKvsBZ+zID3n8yHvHRz9XBapA9BdFSj1a0UOd1cRn+skQatBJOK4cPYD+1SqG/+
 gLh3r/WitG169iahlH6OHR7UpIuUlUyWsOi0Ys1ztUgGewXgVO3FzoP4vF5fbGPH7+FtkzMPY
 b8HHEEJxs8ZAlmo7UW+mR5Wr34lFdBqFUpJ4Yw6n7OKTjDBCjF8QdRJXYq

This experimental patch series aims to add fan control support to the
acer-wmi driver. The patches are compile-tested only and need to be
tested on real hardware to verify that they actually work.

I CCed two users who requested support for this feature. I would be
very happy if both of you could test those patches and report back.

I am ready to help you both with compiling a custom linux kernel for
testing this series.

Armin Wolf (3):
  platform/x86: acer-wmi: Fix setting of fan behavior
  platform/x86: acer-wmi: Add fan control support
  platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51

 drivers/platform/x86/acer-wmi.c | 299 +++++++++++++++++++++++++++++---
 1 file changed, 274 insertions(+), 25 deletions(-)

=2D-
2.39.5


