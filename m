Return-Path: <linux-kernel+bounces-425912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 101C19DEC7B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BAC163BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9315F14D430;
	Fri, 29 Nov 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="bh4jOloq"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516719ADA4;
	Fri, 29 Nov 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908855; cv=none; b=Ik/nTCFAinWoscfcG+PK/r8DTppiDijDkr8pg5Xk3RtAoW8lnobMqY5p1IH0ZD5wmb1BKHobExEiTiDXX/f1l02JX0jJCE4VrqeTG6mgKdmVUGuV8FfgY6cecPZdVxEOjTGRIeu5VasH1NzdMjv0/vXKv6D/U/sHM1avJd5348s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908855; c=relaxed/simple;
	bh=+NsfS12z6+nfWgmBv2svKQe8/TOaOgarqjh82miSqDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qTkXUldLmDz+JL7YEC9L2+/K+55FkUuOdZGKFyV5kPzvvboQji8WhxzohM3tVnoDnU60ebcIy4t8EcusEUIZnrDPa55m08lF9F4g8Q561bk31jCrYC2fOtCcPwGI48rlmbW7Z5P4g8HJ+siGmCoyJ/qgjUdoCQ7EvLoksYXVtSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=bh4jOloq; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732908844; x=1733513644; i=w_armin@gmx.de;
	bh=azNbtrU1reEQ/0X/FcYSXs5uIBdbUWPAC66MU+MvUiM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bh4jOloqWYL9dSXt90A+hoVTBGtMJLCEW/6cPpdDmVSqIhAo5rENWIrfyeil7e/t
	 QMaffhch9NCAA2TXcn2whtVxtGUH7SMZh5Ww1eQ382wPiJsMhbdPJZV5eg+M76KEm
	 A9bZF+OVjUI/AB/uvCEaV5pXoIrkpg0WWULOw4bs/ly3HcRrjiQvJUf33JP0M5tkO
	 4wIY6Litb8Ixvagamwjn9okG2YjVTWYkG9Ny8RlZ+OTXXvemJLkKC1UryCV+qwHnn
	 zU1HMDntTspakOxycev+2TMmmQzO7IVsWXeKLlf4sGfu59rBeiv01NFXPTyqBZjZn
	 pJlg0My0hwD8fHNMaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([141.30.226.119]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MmlXA-1tzoxG0ZPC-00ejpl; Fri, 29 Nov 2024 20:34:04 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] platform/x86: acer-wmi: Various improvements
Date: Fri, 29 Nov 2024 20:33:54 +0100
Message-Id: <20241129193359.8392-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KWhAc2gdZu1E/LGG+pUyK1OE0KLeBkWdP+jGxTcZ9Us8taDIA72
 bhyZ9XNocqVnmgDsS/GBVkxrff/ajjM0g+vhz7/ZI0bAFv0XM64gHe8uxVuCB4fB/1qqyqT
 N2toUmq0xBUhvUEQK8S8kx5gzCN4fEHHOMLEdxmLVbx99k2TVxdlZZrq+/JlfPASOGkqwZV
 zu73G7p3MmEJORxcqhs2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RRGsize+mok=;95V3EA2PmJjQNHnMZVkPaqEzFwF
 9+d/fiZZ1W+Rf/s6UnkXEfnEgdI/kKg+Khub3L05fWuZr4B1aIDV7/Ghp4lG/jvzcuk38wGla
 Z+Czmywb2dBDNW/RpbfJHorg64UMrc9QRQBw36qr1pUMnxcLamlHiLWzj9bsOf9zVHLuW7pmw
 EhWbnBs1iuAG7YMALU1gDnPHSdDuf2JQoD7jv/+BdGKV+a3quWQzJMEDbXocAp+Vw3j272kLn
 np6r9XWC6IJJIPcoJCPHF/au+30mJ2DurNhc11GSftSc0tgjiBsHUNedPZJnIrrrr5jFrtwXi
 WXDP4lexwIBpdd/SWRG7Kczx30NOTOrJxTLSja8jjfYd3dzVi3hBpdqwzbAmQOeMcZ+cH23PA
 wTx4CNuMhHnM1RNEuSEqNzqD7bKg06yqh/sE1L2kSjwV425AUrIEmNUEROOsFX3kniANX0x5P
 SrMp8aNhXUYIU6/p1llkFbYr0dGtbY8Djz6BF8BTjYxk3gDIRuVR7hdGrNQvJOCLFIUsRpk82
 85P9Eh+dogh38c+QhjFxb7hfsVk/EhuMuO0C0/qBtxAUfHJkuMaMz01DaZpH5r9uM62QwaYW/
 6Brvy5F39At8QsAaUuMuhSgBb/oN+qdxmuxscvonf1hnNpanIpaRVSPevlGHnK/Z79G5PGOHU
 9tQqIBqRE1hJwMCR0syr8yxGwDLDsowggMJ3IG2dQGzFJpsqPfFwT9+nVybY41CuY1mwHpsNp
 BfcFtGiLHDVMfsKwdowo93E+smPq1sfVpYST5bvq7sNKYA9NakFhvJwOUFxVVZwjKQ9epLFex
 TAQrs38IV/7Uo8NqtaXvsYL/iLdQ9SrUOea1Um1IPctXQnFa46gvU0Dc/IYa0WgDXBRoKDQ8z
 npDrNzSL2D1xCmp9/Sjy1gOFNMxZqFlRnG7zT76PULNY4NOtAbC+wjJKdnss0QM/qAIVvJmNN
 JgsLOSEVcQQxWyo8BEcQqIAqWcaVceG07QWRZdPspKOftEhKwq9RMqnHL1QFLbPvSx9Lw/zjw
 rs6z6oMx1EdsBidfksUYaDIVGLYMrFU+zdBdmR2t13Pmz0n9GyJjonQ+16iXz7gyOgj55ct7D
 s3EYSKCFgFcUHqMrneMUWXT9nwFkXX

This patch series contains various improvements to the acer-wmi
driver based on user reports:

- adds support for the Acer PH14-51
- improves hwmon support
- ignores function 8 events

The changes are compile-tested only, so i would like to have them
tested on a real machine.

Changes since v2:
- fix compilation error after patch 3
- replace GENMASK() with GENMASK_ULL() and adjust bit numbers

Changes since v1:
- fix spelling issue in patch 2
- rework patch 3 and 4
- add Reviewed-by tag to patch 5

Armin Wolf (5):
  platform/x86: acer-wmi: Add support for Acer PH14-51
  platform/x86: acer-wmi: Rename ACER_CAP_FAN_SPEED_READ
  platform/x86: acer-wmi: Improve error handling when reading gaming
    system information
  platform/x86: acer-wmi: Implement proper hwmon support
  platform/x86: acer-wmi: Ignore AC events

 drivers/platform/x86/acer-wmi.c | 167 ++++++++++++++++++++++++--------
 1 file changed, 125 insertions(+), 42 deletions(-)

=2D-
2.39.5


