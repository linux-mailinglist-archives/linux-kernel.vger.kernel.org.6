Return-Path: <linux-kernel+bounces-516346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024CFA36FF3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8746188F8DC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F501EDA0F;
	Sat, 15 Feb 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="VYC4w4NI"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A6F14A088;
	Sat, 15 Feb 2025 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641561; cv=none; b=SEPb+OU/O6uzV5D7h/yFDbw9az/3PDDbn8g020gTjOD835x3os+dpVMlsg5NMEUh1wR4KzV/lRgKasnRK5rqQCxNAw7xmMJ2FPBsyCuKwfMdhWyVBA5z1//Qtw6gEdYZ6hrtDnnuCj1wKttAO3ipmtfuwD/9tJzLX0wgBXmOcDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641561; c=relaxed/simple;
	bh=V5eZgV4YqqU1WMKnOEa29nBsCkNgtkDVwMzLz60eI4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cKxlMshqT0H8cB6OfJtqtq/beI/9Fco4FY3uBB1h7Lchh/AtQ5IO0ldLj4Hgk5g70S+Iz+LAJw4tVAeFe3yH2HxDdkzJx5sep8+QfYy28WOfNeEbF+fcJJpoSicRQo/aAFrBKGqPfTFSZNetC88/61DcTzCvc1qDBesZdbZQI+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=VYC4w4NI; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739641550; x=1740246350; i=w_armin@gmx.de;
	bh=6bZeHd79oLqhFLOspuVVuNjpgjtmeGOKV9JZokmFqgg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VYC4w4NIq1bnZf2jtQY527ogqGOcdwsD76YLEzx4c69/RHGfCGxNt5rsiOj+2rkB
	 d9NGp/VYVZMh93xkPpjz/aG0CnnyoTBtldXFt0fGiKqGrkg1xZOSVW8OqiZbI3ISI
	 q3P58KSQi6G+BFo3YxXbE/62+meIjyFO3kjDyoZvW9sf6mexqZnZI3LsdIrHzphIB
	 sjpSOmvZ6LZAkOagldNM10mhfrvJPNxAUqBajyowGrEZEGuKf48S6sO2YC+hjK8Im
	 Eds/sYohqmP1cfNFzRkQwfbKeJcuJ0Q4DdNGDB3gSTYzdYt4d24jl24wA+uFINKeJ
	 2bPka+9TmwrauaGyog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N6sit-1tIVSj1VMt-00v0XC; Sat, 15 Feb 2025 18:45:50 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/3] platform/x86: acer-wmi: Add fan control support
Date: Sat, 15 Feb 2025 18:45:41 +0100
Message-Id: <20250215174544.8790-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aU8fKXxED2XE3UjW99HTHU6xUDbt7/BmFrnhU6dAUzQLngMz/Wh
 bJWrXt7HRCxEcndZ7jGti6YM/7V3QYlxPS79lGM22mcX7tHgzZTxsIaGxpfR57PrVLv4rqu
 /DyVkktyrHTRbf/O8irzcuSUetDJdblVo3jHVHF90oHzTcbOR3CMpe+MT+d1aHTgJG4+bKc
 y5AgQo4P0oHJZBPW4gDIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZG6f9kcBSSI=;bb/XQvLytO0Xx31QZUlUPRyNjsW
 80zJsZC8IcBUQACyo5TFjY/qhqIEDKg8ABD0Gecf2mjQ3kQHEW4vw7hQUsov6pGjx4LPO5ek7
 /z2NC3h7rERsqmwTuqCOky94bYmLEM/BVvo3nWHsM4SOyShQSHestEYJd2N8X54SFV5Yo8y/+
 pQG8UtEf4A8jE3JaT2OBhqu0bjnsbvF2swkx+zCFl/ZfaQW6b0p4foAZ7N/L957BwuU24qDga
 jgGO+PqjXVYWRBKvQomWlEcpAsJwjcWoad7GtFWCfAPQ75plcrmBgh0Ot9WKODSlgo391XD02
 nGxGhnWsuxyou02cSk+KXDuJaf3AoMw+JtZmfsgUXIjogfF7X+laz7Oo/StXH3Q29Nga0Qb5n
 mJDIT6ljb9GR4iSZmS70rxKBzGSymIhzcgN5SGzdS23ImKKOpZUiA81kBc3VibBtng/0QWQ9q
 TwD72SFljQ2iQyFj0qx3L2NOX3scksjTiYqYU+2RmZFrD6WxQEmO1ITtNPLQeXXs+ns+OTp8K
 wdd5D5L7CI81NcUINEAWwI0gLNrH55pB5IO+PdNKng1+C3hOqJNO4zxSKCduuVwjW8LXg5twj
 QIVb3YEcN16aHeLGKeiDQ37aO+ul/BKPzy6kZplAlp8/mnEcttp7ZuYGyLN+0hu1N02UKYvdA
 112J0oc8TBHfIftEsiD/ZVWfvh9KWnCrRSdA8NwxWLiPoe6lyv+PYZ1M/VJ74zLw6ByKaFyCc
 l5hNZowxDZyC26CFvlXK8Q9EVwIWh9SXBCFjs3f41mKjcqhbSv1fN22JRk+X6WtZFZ5DYMWnd
 xIXxByTGL7gXpufzqNs4iKQV3QtrW10FFhZBc7GI94JjkTkJk+MG2Lq9RpioPGP5QjsCtbREb
 w2oEc40c8yrJN7R1ouJnDG6AH0hAQjKvxH1Q98BSxvfcZC6rAdrcajvTlrrze1Aw48Ygy9Y0y
 MugyFI2JLGBCprsmQIK0m0pTuGBAWvp8VmZJiW9dmESBHkjrFrgPtqaDDfVfUX3snBAOZ6IYv
 pMewx9aSn2zayN7C1lY+y/i1dYp6FKkSbSUKD2/r8DPWGO8C1AHa6V7s+UEgwG9xO/RxIoh5y
 sKcRq8ue2eVGr1cZInzIZ6O2ZoW1f70Sm5+tTve9/fCdVKKll+dVr7xkHjcHPVHvUv3uHJa5E
 uvs+TyNeE8NlJ8oMgodMkMunJf5//J+O4guff5qFXvrzMhhqQhEszkJMlVH9s/728kBRaHXBa
 k/DRyxxkLKrmnHW/OKnJVv5ecGbkYHQ5fXQUbxRom7qCnCM9cGou5eRQJVpcV8tH385Kfxgs7
 FDuIZY5nm6Zm2bTr8tLyKHrqPE/hHm1DrZrENMBGImr3MoKlymaHkCnOKopJLGzBR96p8T0ui
 J11OZME1nOkOU2aA/TBPSDjYVz4c5Dd+CJQL3g8mauJGbelz1B7E4P8ZM4

This experimental patch series aims to add fan control support to the
acer-wmi driver. The patches are compile-tested only and need to be
tested on real hardware to verify that they actually work.

I CCed two users who requested support for this feature. I would be
very happy if both of you could test those patches and report back.

I am ready to help you both with compiling a custom linux kernel for
testing this series.

Changes since v2:
- remove duplicate include and replace hwmon_pwm_mode with
  hwmon_pwm_enable in second patch

Armin Wolf (3):
  platform/x86: acer-wmi: Fix setting of fan behavior
  platform/x86: acer-wmi: Add fan control support
  platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51

 drivers/platform/x86/acer-wmi.c | 298 +++++++++++++++++++++++++++++---
 1 file changed, 273 insertions(+), 25 deletions(-)

=2D-
2.39.5


