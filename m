Return-Path: <linux-kernel+bounces-420177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E049D7675
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F82C1654AE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6404E1C4;
	Sun, 24 Nov 2024 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Q4fDzbuD"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21A229A9;
	Sun, 24 Nov 2024 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732468485; cv=none; b=Gw20XxUDT4WSgc5Kya41A1iQCxPgJwT7Hn4AVIjmyCsjXxBNstWs/TRv8m24pFzdkGoiwvKhgjEq/yEIn3p6q6Ag0PpL0SH1CJj1yqCGvWC4qfnGlJKz7+E5/tBXUNLHmQvmNE02JcERR6qarYf71AhPlan4F4AT+9UIf1V8rwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732468485; c=relaxed/simple;
	bh=udAcJOACT7U/H2CcBU5L92HQobthyBmwYRNjxKgJbMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DWkHPogDLopf6dBfX9PXD9Ap3mK4Q+uv559tb9F2I39JAgBYfdhG+GiZwWYyO7jhtr2jsTmbHfMn0Ne+1XFQhmq84iNIV+sQl8jhwgUg4TIRrWW0Hkwyz4cNYKFxXYgea6pSevJNncIT1p4vBCCxjjWyTS7vYaA8jvzfW6Ngiic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Q4fDzbuD; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732468473; x=1733073273; i=w_armin@gmx.de;
	bh=JfHaAZ/rNuezEq8mQg3VvjNWuiQQZF97s5DmtuFnO24=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q4fDzbuDIMZ8ENMatiHPizNvSp1H345gbOAhlJueVyWxN9ktURPoHhgzgfSQoJBe
	 KN6Mih3ID32KXjvn1drw74vhCpp6MCI8lH6iaGWw73N0XoreoPFJynZz4sEDCQM3R
	 TlRLGDGHbnxqKfPH5KjItxI5gKWY7GklPeb5/NGhIxo9+UFYt+2LYLOTK3JI1NXR+
	 x/HKuUTHTPKIRtNLn9y+989rjPCT75layA5p/nSA0mj6XC7e+wTZjmOmVMApOTb5E
	 /6RHJsBpg9EBoYShqLAH5e0N/ibK0dHgmFh1l+QWG4cBpwRIEZEOLIikPEgu8lpZ2
	 5QXt5Nk8w9CjB5b/QQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([141.30.226.119]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M1psI-1tHS2z09vM-00G6F0; Sun, 24 Nov 2024 18:14:33 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] platform/x86: acer-wmi: Various improvements
Date: Sun, 24 Nov 2024 18:14:21 +0100
Message-Id: <20241124171426.29203-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I9WzMYTCVT8xFfdTtU/oDtk4VA6Ig7S70A/ByTdPD2aSlaEXEZu
 pV73GVKKFKP251/PqGpjkuK3IbXmfk1cJ5lc/iLYMDe3BV+241nu6Z8O3FIFo+q7IjDyavI
 UDaTv7WYo8Jpz/RET+tcATFhzxqxahkVAVG6r1ImH+nvmnM3MsaJftpiBuRphhJhxf6VQDI
 sdJUIfn8UpYsO3aH4F7Cg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GuyheWM476U=;BSyeWHa5e+AlA+edkHFLdlw45fr
 JMrOVU8l2CSWOtuIB9xDHmcULUfVBdZu686NRqy4ieBAw53LbEgXOdR+57sbRgN1qJtZrC6Kq
 oj9RDufi4LuJI8zOb191zfCaaY0x3wBf3bhO31PLTBLyoo/e/rsIy6BzXMylaRM5TEN1Z/Xau
 A7KtrU6jCVaBVEYksZtXBiYKZmJb5hPOyqq1mknW0nYGiKhtnnL3MIUtPlJqrXlDPP/KM2r2g
 jNyXVjFVnRp9YMmMxzyMJnNBb2Ny6ojM4WTCJXSy4qPOheSZDXYKm4zYLttevRlKzj1G8jPps
 sV8IRQcwBk/2Y621ffHb4OYBE25eu9N3napaJqBE/HaSkpQd1qGpaXy/ka9S5DfRLURBBgwUv
 B8Xmc15ThfDNVlkZr3Wj0BVkxcehGweDkoMPcbQtr47izU/lRXwX8wSHFwnB3pAhy/WNX+oPC
 J5LYegmiYRL8waQz2sIRGnzY24dgAb/0EuY1zuK5/700kgR+1WP5Y2sBn27eChErmsNSgRZRo
 PxLayWS558Mh8f/vSl2XHN+YStP3V82t2/2g4f1q0ilBw+9ZCjuy2OTxe29GbEUO67cRxYccl
 gH3RrAPhlrB/r9QZZ8MERbcREiZt7d7c8UU4G/jBA3WyO2UQtCs9FCzzjt/2k5FVDNNrZ6vBx
 JZDrW6thP6XBbbJr5DAGRz9LRLq/lQ6LFOt0/Q8Sr+VaVf6VNwjSsn2XEKXavt8T0+a1c6FJI
 iuP/ACsoBGU8lQeLMv/6pZw7EwS8mx6EL8KN3JXJesrY41NeWnriOj70RXrKjziig6LrdMpAi
 QJZdO6YUzH4apP2VDybHvfg1ggNZTFAqDBB2NNTgBrhzoLkefRt2aT+winJcozYYp6rlAKGrX
 D8ZC7nXppRROgmwXD3k3dLfJl2mV69XhfFV4ni+BCdgbe0xomt2M/bfYZ

This patch series contains various improvements to the acer-wmi
driver based on user reports:

- adds support for the Acer PH14-51
- improves hwmon support
- ignores function 8 events

The changes are compile-tested only, so i would like to have them
tested on a real machine.

Armin Wolf (5):
  platform/x86: acer-wmi: Add support for Acer PH14-51
  platform/x86: acer-wmi: Rename ACER_CAP_FAN_SPEED_READ
  platform/x86: acer-wmi: Add support for temperature sensors
  platform/x86: acer-wmi: Improve error handling when reading AC status
  platform/x86: acer-wmi: Ignore AC events

 drivers/platform/x86/acer-wmi.c | 164 ++++++++++++++++++++++++--------
 1 file changed, 122 insertions(+), 42 deletions(-)

=2D-
2.39.5


