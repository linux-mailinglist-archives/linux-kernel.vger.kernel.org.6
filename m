Return-Path: <linux-kernel+bounces-223401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0A391125E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DE2285CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F246B1BA07C;
	Thu, 20 Jun 2024 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="L1eYpBTo"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C11B581D;
	Thu, 20 Jun 2024 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912556; cv=none; b=UY0jWHQRV8+RZtSSm/wIuJBxInJjqtrUWSt8ILJBAb5G8oUt4mpDyxnWG0HKIJLkX8sbBs0+PdmOi7AWKzXEQOHHDBpkY4ev9xLdnEoAfEgGB5rmP4R/JftnSaGcf2ww5o8/C9xhiVyk6ekh8ABQE7chCU7KUx3vCK5oA3ZTkok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912556; c=relaxed/simple;
	bh=ECgi3CdmL1IBbAM09BgzUfuA0fD7KyCteZXV15dr4d8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SsBL9QRhKKVenVm2FB2EcctRkh/foNSj28bO9RMIDyEoesPeySWrX1r4yUBdZnjlt/+d/PuMkRKZAdo7TxjBLNj52FTZ008xrcF7BOrmyU9jal6jj25YmUibwPQSCBvkIs2M0Fi2OMhS98kRMulzoKAuj0rG/m/mhNTqAirf1eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=L1eYpBTo; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718912538; x=1719517338; i=w_armin@gmx.de;
	bh=iaPhRbRv38+q65n4kJOR2c71pb2fVCjU1eMDXoyOUE8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L1eYpBToSojl9ts3D6+Tib8j0zGXeV1ZjokzlZ5/I2SOf7Wvz5Dkc39ou/QU6f9p
	 qslDRuEcRL7UvZWH4NSD2lE2ymOlR5NK3Z45Bv8Oj72nYWP6S3VjIFY1N86XOO491
	 exw8xDfwYwzPPEvX288Rvl8Z6fhoZjFDN6GBFB3764wyn9XUbg/e+tenq+qYBXHuG
	 Eb9kdWFi2YD1hFRXrVSOHS5sAqKfr5zfdirJbpWlg7VW/wXzDCAKW/XiPLhKhmHiz
	 ZwcCyc6HHGlWJJX+rOVZIefEaQPzjsQGOz9nvHudy1ETdx396HVfoKiNjnRvIPmkA
	 Q8tLgqXEr0k+FnL6bA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MVeI8-1rsyw22oFA-00Ukom; Thu, 20 Jun 2024 21:42:18 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] platform/x86: wmi: Add driver_override support
Date: Thu, 20 Jun 2024 21:42:12 +0200
Message-Id: <20240620194214.3071-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7uTI6OJAiA80JgiXISRvTXMcYUYVNj7pQye5Pk2uYsm7E48Fcrm
 tHCXGknVLZgMh4jPHtPLfSOUcEDoq5LCbFvMMGPvm+9Z05u1Dz5P63ovdX8XzBx51KIgh7K
 OcrlIvgGxotT5NN3GjVAqjRouOHqnqKLvloLuv25sux/E8vEDV45VU1tEFcRuUwQM5by7Oq
 pNCTn2eN0XcF3h7mxFYGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w5XkaRLCBOQ=;TLPvEoi7pkao0aOQw/nP8FQ7cBN
 hWp9jjFCoUn5uU98TXQfM9xfk9LsLulaN/x7H+gUoNatniN0XtzgfYYCMXBEIXdlio1fWW4gz
 GHvsyHFwB93L+E3qTkunEogyI91wdX1hWFvbfbJH8SCl9qn1WCATVmwlJGSWWKG2tPZcqThfF
 UCc6eOGWzxbXNAxwdYb5SFOJbhsDdI/cYk0apwelR7BScfrVoHE1N+uNj3qWdqqJGHITB8JHT
 1H0gFSU+fELZ4F6z4vVF/MD2gpGM4PDFlmtEOTc752sfAEMpxrKLmiNa5ESIxVw+KIaNwPg1e
 8uQOAmcjuUrdLrOTEx6h0JRsZlMH7i2Xmi9pzFlz8e+IKbZeODkXomtxtzcOMYM4+bf2MxMGM
 pzv8SthEdZMlYmBU/t02KuWanpctETvxC3Mo0KPhXyFbdEuSEpVyKAQJnnWs8TAW7OSCpAnPi
 ld3PLSQBOnc/sKTuWjpSVuJJi/y99A3OATcHUvfbh873g7YPQlUH4IsnCBiMduieiWX0gUiDq
 leqaFvjLUtusKHWkaoE+bSkoU+1CIuXg5GI7dqDArtOsbqP9YlNn6+wIfyr1dddeayqkdu6JR
 WVIVSjocf4Q+pFo85xXwxeko1vm3faP+oFb2DMr/9GOeUh3PHJpsehiD8bFbJ5QRBPZnAhvcG
 llfcK8WIlgTzPcjpxEKbOJjf6kxKijZ9ZFcg9rGrDGqIcBPrbU1BqRlbHNPiWgGLO71dtwEcQ
 J0GvTvigRNKZCEaGdt0KGg7n5b6bJcpw8CTOxStba28oz3CoLCCuhRmSa+M0FaolZldiESbQf
 QO8WtrJ+SJBTG1EWUpIuWYUw+bWamphrBHgsDKJwdMQU0=

This patch series add support for using the driver_override sysfs
attribute with WMI devices. The reason for this is that there will
exist a couple of generic WMI drivers in the future for allowing
driver developers to directly access the underlying WMI device.

Since those generic WMI drivers do not have an ID table, the
driver_override mechanism is used to bind them to WMI devices.

Armin Wolf (2):
  platform/x86: wmi: Add driver_override support
  platform/x86: wmi: Add bus ABI documentation

 Documentation/ABI/testing/sysfs-bus-wmi | 79 +++++++++++++++++++++++++
 MAINTAINERS                             |  1 +
 drivers/platform/x86/wmi.c              | 33 +++++++++++
 include/linux/wmi.h                     |  4 ++
 4 files changed, 117 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-wmi

=2D-
2.39.2


