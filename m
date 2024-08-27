Return-Path: <linux-kernel+bounces-303887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48634961682
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78211F2377B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540181D2F57;
	Tue, 27 Aug 2024 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="ZfSb0FUW"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B1A1D278D;
	Tue, 27 Aug 2024 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782354; cv=pass; b=ZtU8csvc9rhsISQeRqsodjciyBlclPBHTLcOVPJBl2SUf/qLf9suzTC4bUTLFnMvAWVwVAOc/ymmnhyii7YqaWKkdaNNUktDv44/8hWzGUpW7D+q9RbnM1myQVposPwm6IcduQleklpgxBpUFq4fkB399WzyeumHwDBo6jxuaWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782354; c=relaxed/simple;
	bh=aWREDDXw3VUSy01eYgB6syDfxtw33a+xK/k4CacyOAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2PddO6XeuvdqKMs2oPp9utOu+McgfpX2ubrAH7ueGky8dFoxlsdeg8ImS+KWT/5euo9lkuOZi/67KVgbEWKoNPnpXx6GxuFBbypfr2qM8V1OjVLnXjEUwlmJHXrUMccm65rXGfdhqFe1pE2vlrz0+y31Dp4E3Y42fQwPDfopFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=ZfSb0FUW; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724782336; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=brXvxwVIWeMuvOScjIxgv6Wf8xsoBqkNTcBzrDa2raD6htJhsFQef4ChT+QhP2GZCqqtWEH8pqcTOpETw+4MuiZspdflFfd8lT9/+IS/eTFdyukN3EDZyBnnMHzKllkrusuwmQf5vwxfAHbq1VIfF94VfAgcxagG1pnDWSiaxcQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724782336; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RoiMzBJ0Us9ppCH7FKAaOJox09dmiZXOo+WgF7DfWP8=; 
	b=hWq2EJUZ0+8I1cwKmnyTZdGu2fZSseu+8uvJsB9WQan2Rv5qZlvs4WDjehrkYgxaXY/gnj891YtueEXQcubqnrcQK5QOM62TbwzSjX95VEFlY/6KGjPxT/Qzlzp7wMwh3k3N5QHkJOD0/5GdUsEJ5mAX62SXsAGjSAv5tci5W90=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724782336;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=RoiMzBJ0Us9ppCH7FKAaOJox09dmiZXOo+WgF7DfWP8=;
	b=ZfSb0FUWLmpfAqvHz/IKDNIWZ3BCg1KxdSHY6pFH5Ab3AafKd9DxWb7YSZDf0fXk
	gngIOB37ZSNarut3wlYNJFFycU5GoEq1JNXUfT/awDYBMT3MdplUQVhYOc/9oJ/06km
	8AbE7/wijqQ+FslYBE2JXnHHmz8GLVxZ2w15XSdI=
Received: by mx.zohomail.com with SMTPS id 1724782334636725.3316886969787;
	Tue, 27 Aug 2024 11:12:14 -0700 (PDT)
Received: by jupiter.universe (Postfix, from userid 1000)
	id DFF724800E2; Tue, 27 Aug 2024 20:12:10 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v8 0/2] RK3588 VEPU121/VPU121 support
Date: Tue, 27 Aug 2024 20:10:19 +0200
Message-ID: <20240827181206.147617-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hi,

This enables support for Hantro in the RK3588 base devicetree. Sebastian =
Fricke
send the pull request for the driver/binding changes for 6.12 some hours =
ago:

https://lore.kernel.org/all/20240827133315.qlmwdvwmghidayzy@basti-XPS-13-=
9310/

Changes since PATCHv7:
 * Dropped patches 1-4 (merged to media tree)
 * Rebased DT patches to use rk3588-base.dtsi instead of rk3588s.dtsi
 * Dropped a bunch of people from Cc since the media side is done

Changes since PATCHv6:
 * Collected Acked-by for RK3588 VEPU121 DT binding from Conor Dooley
 * Fix resource leak of DT node in hantro_disable_multicore()
 * Support disabled nodes in hantro_disable_multicore()
 * Use correct match data (RK3568 VEPU instead of VPU) for RK3588 VEPU121

Changes since PATCHv5:
 * Fix binding for vepu121 (use enum)
 * split hantro driver patch (multicore / vepu121 compatible)
 * move video-codec@fdb50000 node to correct position
 * change "jpeg_enc*" alias to "vepu121_*"
 * change "vpu_*" alias to "vpu121_*" (to be consistent)

Changes since PATCHv3 (VEPU121) / PATCHv4 (VPU121)
 * combine both patchsets, since there is some overleap
 * add patch to disable multi-core handling in the hantro driver
 * drop the RK3568 fallback compatible for VEPU (see above for the reason=
)
 * describe all RK3588 VEPU cores (possible because of driver change)

Greetings,

-- Sebastian

Emmanuel Gil Peyrot (1):
  arm64: dts: rockchip: Add VEPU121 to RK3588

Jianfeng Liu (1):
  arm64: dts: rockchip: Add VPU121 support for RK3588

 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)

--=20
2.45.2


