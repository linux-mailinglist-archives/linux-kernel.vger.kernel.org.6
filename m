Return-Path: <linux-kernel+bounces-189899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4A98CF6D2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 01:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8771B1C20D80
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 23:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264CE13A3E7;
	Sun, 26 May 2024 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=seb-dev@web.de header.b="QptUMr+a"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821C8494;
	Sun, 26 May 2024 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716766434; cv=none; b=iXKvU8VAeCltPv9BI+5ACI00aF40Bdv3gmtKubsy0Y1IYvoO79ni6Od1Wli58FVdXT7pBcfZUpVppG8U4Zu1v3+2eyXxk7Qq5KVOJs73C+40ozNjKo3ToWjEeFAeJXzTQm1qEW0F/bUBLFE2jsESzUmJ9iNtDh6Avrd1KxodryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716766434; c=relaxed/simple;
	bh=/yahvlFAlI1KiXni2dKRY5F1eLx91D3e5J7ZQamDkoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rtYLpkM2+wz5MAbSPX+URy8FQqwHrU7h2XCRdHLoJ9T1Gl0VIBE4azVufX0OWqWNwASI5flNf0PwZtmQCrvDGmUBNZSxPNZkz7rXHCY4jfoLAXFzha7xcGAxJXmespv1D+8QyoH9FzuloZ1AvLmjN3ZEuHt+hAYC55qQnhHgUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=seb-dev@web.de header.b=QptUMr+a; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716766402; x=1717371202; i=seb-dev@web.de;
	bh=Ck9yiP7ihI2T91SwUO4f1rkfndnqU2p6BXfIvig2gCk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QptUMr+arYl5MZp/xa6LZ8b3ptXqm/cOxcMvWNiuSf3Zi2G3eQ7cpcoUu2zvfIvJ
	 iOe7bf797xsyweXv1uN0b1rVd6eH+bLEmJWUPAaTXdJGlio3bycorF68EpPQV1olT
	 mqsF266MB6RE7EprOQPNJaVofBbwWfcG36I6zPpCL3Qv94GWyyz7C1hW5QWkYAap0
	 1u46QGzk1pij3Zi/WoWrPWgtlyl0qwMB6wQ8h3ZPbiL544YF7lloaeo0EKomAh2kn
	 zgip5aG62kIjfAs1Pywk3tqfH31v9BZdiOZlkiiVv1XrSn2vsbqYt5UJwf7AsOfM+
	 mQQ9mBcTevUmoFFE0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.155.184.248]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MUUAG-1s2Xf02wlc-00Qf6F; Mon, 27 May 2024 01:33:22 +0200
From: Sebastian Kropatsch <seb-dev@web.de>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sebastian Kropatsch <seb-dev@web.de>
Subject: [PATCH 0/2] RK3588: FriendlyElec CM3588 NAS board support
Date: Sun, 26 May 2024 23:42:15 +0200
Message-ID: <20240526214340.8459-1-seb-dev@web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UgF7Y/I2rFfSRmOfe5K9q7vLJJ0MHmaYtmPoJ40u8djNgfnfKlk
 +q5ycSPzDccYAp0qkQpvwxAJvxy4N3/Z8dld+M4F43q0zR2JV5QfisMxtOFNXqoRz0BPrQi
 nwkfA+8Qufr2ar+eRszvoaCFbJe6nMs0ZOQg6yFeud5Fem68IUyA6kP29co/AeRittvstoz
 +n2Ifsq9V1zmbsmZ/xxYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mCzxCoR1YFo=;U39Y6KVr2BoiWscYlUxP30KLxFB
 d1aIuZq+RiHz+5DlSNZcjT4FEnz4mTrOEegtDs6z23CNcEXlP8XKxIRiPLHMG5tuQgYukDjTW
 NxhCpX5smb9jVAk8Fqd3hXLYjIiBCexwGNgl9jUdEtW7grUH6SjX223v1WpP9BerBLoM3Vq3I
 2IzI1PvX0tHmZTvNEStBRkhNd0KipV2XjfgyvnAzsXUCetsQyfGq+em7XwnerPVgRCQQhs4ie
 QkmMHslnqnlQnbPVbgLzuPRneI7L9XFGs0NKtYJrvjzlw2vq3kJZWxL5IIy0kapGY6st10oFT
 JjtvEJSs/O6vp78aw1If+yob+bCBNCv0uNz7rpN5Mp0g6War8rettZgbBw1yfgEtp2MLy15HU
 AQvxCK8YSymI0TD47eqE+HyluxI8H9ml3bdZDgc26NEzi3AIEl6j4i/A1axBe8AndkAkcrq6V
 vkIlaxLButWpWvhweiZNRjRZoOmRFpuyHlYiMmtli34VntIkznlD8tqzptiIAIcXV0Nba4GVm
 izgsBVaibPcA9uq4AS8QimJPeVwCgdUIsilqxiKbyjS8Mte1JUhPvIwsm2ynEchm2N8MdEI3g
 NbRcfmvhy9vdG7/4QFFu+QKyUQihIlbklv3k72laiINiX6GkmSSuJMVSOnSPlpEHZyNJ1F6Mb
 G1STDjwc8pb774XK5uXcsNVXOkTztqwxDL9BKQaYWY8+s4lj2voMN/OZcrZAqYTRxsedBZjpD
 IzxyvGrhXWh2iI36j5G/9kmSSfgxDdmiWSz6NJZaACvymPa0d2i5FRd+jBrajb58yCXwIwg5I
 +EVgGwCnR74YER28y0BlelmfpUWuAX1AoooPvzPVbYk68=

Hello!

This adds support for the FriendlyElec CM3588 NAS board.
The board's device tree makes use of the latest upstream advances on the
RK3588 like USB3 DRD and GPU support as well as the latest Rockchip PCIe
driver bifurcation fixes, but some features such as thermal management
and HDMI will have to be added later when SoC support for these features
is merged.
Since the hardware has similarities with FriendlyElec's NanoPC T6, the
device tree for the CM3588 NAS also partially shares some sections with
the NanoPC T6 tree.

Minor issue:
The device enumeration of NVMe SSDs plugged into the four PCIe M.2 slots
does not follow the order of the slots on the board: The slots are
physically named from 1 to 4, top to bottom. However, they do not show
up in this same order in Linux when all slots are polulated:
   - SSD in physical slot 1 shows up as nvme0
   - SSD in physical slot 2 shows up as nvme2
   - SSD in physical slot 3 shows up as nvme1
   - SSD in physical slot 4 shows up as nvme3
This is the same order in which the data lanes are mapped for PCIe
bifurcation (dts property: data-lanes =3D <1 3 2 4>).
I could not solve this by using aliases for the PCIe nodes in the device
tree. Perhaps this is something that can only be solved at driver level?
I am not sure if this behaviour is even considered a bug or if this is
intended behaviour by design.

Devicetree validation:
`make CHECK_DTBS=3Dy rockchip/rk3588-cm3588-nas.dtb` does not give any
warnings or errors, tested on Linux next-20240523.

Best regards,
Sebastian Kropatsch

=2D--
Sebastian Kropatsch (2):
  dt-bindings: arm: rockchip: Add CM3588 NAS
  arm64: dts: rockchip: Add CM3588 NAS board

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3588-cm3588-nas.dts   | 1269 +++++++++++++++++
 3 files changed, 1275 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-cm3588-nas.dts

=2D-
2.43.0


