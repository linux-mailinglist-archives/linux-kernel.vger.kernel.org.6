Return-Path: <linux-kernel+bounces-390482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FAE9B7A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77451C21FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD03D19CC16;
	Thu, 31 Oct 2024 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQZ8Hmfl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A0C14831D;
	Thu, 31 Oct 2024 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377599; cv=none; b=on0oNr+Jwt+seVr0Nno8+MHEtnmsghat/KfRcwdVR/9K1pY3FoTzYCj5P/MZa4i0VuwYgBfZ17iuUkyWAuJccpWVEF8G78LtjAj0fnDHIXIFjdjXzD8c9GQx9WHBXB0Su7rCwzLtTNp4HrIeVk77a5G/fMtZpRJyw6kYuE+v3Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377599; c=relaxed/simple;
	bh=ROImIcKd26I37IIPZ7G3j3tGh80SEofFXW3tR61BJI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pV8cCQxMxOqN6fdzEhh8PImPZWk+Dv4N4ofbB5SKCd5IHgRuNM75S58XE9n18e6CtQrR7Yb6cKp05hEGbtYDHbSaiSntwXZnu6MsJVxbZxAEuMi1KT+tJ7uG6F1p3rlGH3k1Y4fgvjh2nZ+u+7MSMtlO93AJsX/wFIaercaB75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQZ8Hmfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E411C4FE0F;
	Thu, 31 Oct 2024 12:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730377598;
	bh=ROImIcKd26I37IIPZ7G3j3tGh80SEofFXW3tR61BJI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQZ8HmfllQmBOTiIj7AXghEbzCewVOl5UEKOTbuj/oF9tT8vmfaZti53DuzStqOFg
	 KJLwrCdV/8Zky2cGPZckIQkZA8AdWyJDefksndBQIX7jeHyHjL9tTAT1pA0uWiWlyX
	 49shJFYqGwYDWq8EqWvCfCruM5eDunH+FAymVk6Pseh4Sn1BJsTprZsLTh+wPQqCa9
	 ZmAgHnUdnjvMXPRZdlnBCGi9QSbqmqv5aPpZ4krsVn0lzmxKRuQ4TS+IYT8hh9KGpK
	 RxaNryz+eLxzGoVxwfdCzlO2TiSbEtw09YpJSXUgIzVQekmN46opDXkc3r/bCZgYoh
	 VvCKISkHqgwOw==
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	rafal@milecki.pl,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guodong Xu <guodong@riscstar.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	Alexandru Stan <ams@frame.work>,
	Daniel Schaefer <dhs@frame.work>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	Yuning Liang <yuning.liang@deepcomputing.io>,
	Huiming Qiu <huiming.qiu@deepcomputing.io>,
	Alex Elder <elder@riscstar.com>,
	linux@frame.work,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] Add DeepComputing FML13V01 board dts
Date: Thu, 31 Oct 2024 12:26:19 +0000
Message-ID: <20241031-synapse-cycling-0f7834a28b91@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028082553.1989797-1-guodong@riscstar.com>
References: <20241028082553.1989797-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=zWFfzFih/Cg5hWs+WTraOfKNpKZTj9yvCQj0KE3sbQ0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOnK5Tnr0tcHFdVmFD373qH2YlbwiYTsXRkHQrS1hP/vK /wnV7O7o5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABNJt2f4K2AbbrR6f+/1JZX7 5fafkVxq07NYwWKhboJmDSev+v4d2YwMSy6p1QWv3WqX6X99h+qK9XEWx5/lay3/1WOwI2y9kN5 /XgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 28 Oct 2024 16:25:48 +0800, Guodong Xu wrote:
> This series updates Device Tree related files to introduce the
> FML13V10 board from DeepComputing, which incorporates a StarFive
> JH7110 SoC.  This board is designed for use on the Framework Laptop 13
> Chassis, which has (Framework) SKU FRANHQ0001.
> 
> The original three versions of this series were posted by Sandie Cao
> from DeepComputing.  Her mailer configuration caused mail threading
> errors, which led to some confusion.  After some discussion, we have
> agreed to take over moving this series toward acceptance.
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/5] riscv: dts: starfive: jh7110-common: revised device node
      https://git.kernel.org/conor/c/5a5001d27065
[2/5] riscv: dts: starfive: jh7110-common: move usb0 config to board dts
      https://git.kernel.org/conor/c/817eac165ed4
[3/5] dt-bindings: vendor: add deepcomputing
      https://git.kernel.org/conor/c/e9b4ceedb5ae
[4/5] dt-bindings: riscv: starfive: add deepcomputing,fml13v01
      https://git.kernel.org/conor/c/e87fa39dbcb4
[5/5] riscv: dts: starfive: add DeepComputing FML13V01 board device tree
      https://git.kernel.org/conor/c/c8b72c301dbe

Thanks,
Conor.

