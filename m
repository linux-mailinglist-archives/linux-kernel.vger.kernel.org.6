Return-Path: <linux-kernel+bounces-529645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15614A42928
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB631688A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35CB263C8A;
	Mon, 24 Feb 2025 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tidylabs.net header.i=@tidylabs.net header.b="ZzIPgZNU";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="L0it4tZo"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4192627F7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417047; cv=none; b=ZWejZDvkbBNYPvA8uuPF40EeKetSw2cCTKRXk2awat4f8UWq1kmW4PoYo1OA0m2zklgEf99EcdTE08W/GkhtEpLq/+NznPvAzLny+kloJ41wWNZmU8E165OjFNadSZP32MjQAHFfhs1TMbNMlPjfB/KzuWwfVoRNQrimFcYGpvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417047; c=relaxed/simple;
	bh=PIuf9WUHbdR0oDHD3UfUqjwbtLdy6WEiW9F2eJXTuuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uNliLL2M0J93scPwPdyjjPYZq/i8bUL946BTdMkBq5Nmq84pTg1TJAq8W6e4Msjmof+Vh7diHRlPv/Q/me5p304F84mUGCZKP7f/NoKZpshpTfmmv36zKOO2oe62NOMRXC90HVQBSlNsHrJzNBHe9d/dzFRV+Tdd/Zf7EmyQM1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tidylabs.net; spf=pass smtp.mailfrom=tidylabs.net; dkim=pass (2048-bit key) header.d=tidylabs.net header.i=@tidylabs.net header.b=ZzIPgZNU; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=L0it4tZo; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tidylabs.net
DKIM-Signature: a=rsa-sha256; b=ZzIPgZNULnbX1w+n3o8dprtM/Kqd2iWJd78UtC7LNQShoNXLTD3xjgvrGFlpjD+PQqeXkJxImXBfvoK+J3N5T4RtfDR2yvf3/684PTF9hsLnwLkBAzguysybT3YrOXd+0GYh8uLUkAfIDQUR3ydk7ONrFX/6B22MoWISYAGLDxE72R9RLTG3s3yx52JIpz+kjRDPiC38TpXewHPjsKLuWDY40ikxmHq3J5p2yk0fox3ZFG85UqQJ9cxGtTvMDnhr4108FU+lNmJ7NedXffxzsS2zdr6ReHAnmOU4YRmaQrRbVJp9OsPvw5Y4wi47OesdoZbM6fve6Vv59aVOQa4anA==; s=purelymail1; d=tidylabs.net; v=1; bh=PIuf9WUHbdR0oDHD3UfUqjwbtLdy6WEiW9F2eJXTuuU=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=L0it4tZoj3QVHfn5Jt37tIzkZQEWjq/CrioyiY3sDq8Na/84DnDEKDQPccyirDWh8yKpWBoo3Tf2/6TLggfNbkb/F8fMAXGUF7i9BOVjcn2j8/U3Vb9BzO7c9pZ2He/iaNoYJ5aAT5VrWR/M0rhY2UMz0aBF1zVYGKuRSKLN5vw/QbUttRM42TFzGCELHAk7UGOOchsNe4qh4+Dcvz4XN4XFt5qgZxfEDhHw7KvftqYS/jXQozUC4AxxPySQrGdzvnU5zrFs+Z1/Xbp2us2Z2iJxgVQqZ+/08gk20LVzuWP6QY08rZZ/TAQPXbg3cSldqWKX1PcvJ/wkGlnaB0pRmQ==; s=purelymail1; d=purelymail.com; v=1; bh=PIuf9WUHbdR0oDHD3UfUqjwbtLdy6WEiW9F2eJXTuuU=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1560088192;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 24 Feb 2025 17:09:59 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: Tianling Shen <cnsztl@gmail.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Johan Jonker <jbx6244@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Justin Klaassen <justin@tidylabs.net>
Subject: [PATCH] arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S
Date: Mon, 24 Feb 2025 17:09:24 +0000
Message-ID: <20250224170925.39126-1-justin@tidylabs.net>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The u2phy1_host should always have the same status as usb_host1_ehci,
otherwise the ehci driver may be initialized for a disabled usb port.

Signed-off-by: Justin Klaassen <justin@tidylabs.net>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi b/arch/arm=
64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
index b1c9bd0e63ef..8d94d9f91a5c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
@@ -115,7 +115,7 @@ &u2phy0_host {
 };
=20
 &u2phy1_host {
-=09status =3D "disabled";
+=09phy-supply =3D <&vdd_5v>;
 };
=20
 &uart0 {
--=20
2.47.1


