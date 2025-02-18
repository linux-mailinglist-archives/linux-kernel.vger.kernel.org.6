Return-Path: <linux-kernel+bounces-518494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EFAA38FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 01:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE843B2069
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ED7EEBD;
	Tue, 18 Feb 2025 00:35:07 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7ECC8EB;
	Tue, 18 Feb 2025 00:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739838907; cv=none; b=prqaBN/dCXzIheNMynOvgfb81cBXWMOg3WCfAqmM4FiQsrxy45FhPJKAE9avWcIsT+GHHLszmVVRlJ24KkSrG7QeF22FosH+roLEJ+XV87bWp/AVUseKq7Ye2+4w7cgqh/o/Bo6b72T+kuh+innvVrMEMcPrAXFKy1x5JxFFfFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739838907; c=relaxed/simple;
	bh=6z1+LWnsnRGAQnhfVlsd/K6Wv25tAb42tgFzwI8wILg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehuapp4zKany9ofe7Mln23AsPjmHO/n5jAHlVR83k5qoAEqiwQRK+e+sOeuY9q2BX4SFh+icOLkZrekhKQaCMaeA1G9YdCENkdRGUlrALoG7X/+IDto31g/zL9khs9xpQ6uPhfUMqaIJ8HjW1IWSqzOwQ3BqAMOPBdOqHfz7/Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost.localdomain (unknown [180.172.76.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E6210343119;
	Tue, 18 Feb 2025 00:34:59 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
To: linux-kernel@vger.kernel.org,
	Javier Martinez Canillas <javierm@redhat.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	javier@dowhile0.org,
	rjones@redhat.com,
	abologna@redhat.com,
	spacemit@lists.linux.dev,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/2] riscv: dts: spacemit: Add initial support for Milk-V Jupiter
Date: Tue, 18 Feb 2025 08:34:32 +0800
Message-ID: <173979802066.53738.3069472182540355902.b4-ty@gentoo.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214151700.666544-1-javierm@redhat.com>
References: <20250214151700.666544-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 14 Feb 2025 16:16:36 +0100, Javier Martinez Canillas wrote:
> This patch-set adds a minimal support for the Milk-V Jupiter board.
> which is a Mini ITX computer based on the SpacemiT K1/M1 RISC-V SoC.
> 
> The DTS is very basic but at least allows to boot into a serial console
> and get UART output, similar to what exists for other K1 based boards
> such as the BananaPi BPI-F3.
> 
> [...]

Thanks, Applied to SpacemiT's SoC tree:
 https://github.com/spacemit-com/linux/ (for-next)

[1/2] dt-bindings: riscv: spacemit: Add Milk-V Jupiter board compatible
      https://github.com/spacemit-com/linux/commit/8c8d2a19a3ad87d9344a5e58172f8e0c05c4622a
[2/2] riscv: dts: spacemit: Add Milk-V Jupiter board device tree
      https://github.com/spacemit-com/linux/commit/5b90a3d6092d9292d3c4fe4eef8969282e070ae3

The for-next branch will be sent via a formal Pull Request to
the Linux SoC maintainers for inclusion in next merge window.

Best regards,
-- 
Yixun Lan


