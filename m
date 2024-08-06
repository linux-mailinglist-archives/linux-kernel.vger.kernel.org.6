Return-Path: <linux-kernel+bounces-276693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5352294971A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077361F21D21
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A537580C;
	Tue,  6 Aug 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7FPHPBL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C693D7347C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722966646; cv=none; b=i2Xm/LDgiptoN9VJOsqouHIhiWgQNMu8Cnt02vlygcKISbHx7eIAJ7ik2Hod04tzdyEuUhDIUSSu1hq9YMU179L4LoXWILpn0fqC0u+nN/rTuevTChq2S+ExLuiV+BxL4f5Hldlapr92k0cpU4glLQWXjYvhbo9vrFuZX2GP3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722966646; c=relaxed/simple;
	bh=t40YoKWd+Io9Ezvm5uWWh3ir9V6e6eG6U1qjbIzg1g8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=lLyGhfDywDCwLoAb4damVWTrQCPik7XS9r08bwaoHZS06IKZmW+rb+Q2Gcyl2yVXH2oA+1CDPdVmv6aaT/Frnd+MLUEZx8EvmK9GmbBpZ1gKaf4MXDquxW2PFeSdlZUlcwepJyQ5Rf5hRd4PTZ4pE1z5yVhAzTFNDKUV0QulXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7FPHPBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F819C32786;
	Tue,  6 Aug 2024 17:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722966646;
	bh=t40YoKWd+Io9Ezvm5uWWh3ir9V6e6eG6U1qjbIzg1g8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=X7FPHPBLXhJyJH9UIdSMiny2oEcItLJmL9hI0c2qVUkdOSEEkgY63gQbYh8XeNUHi
	 C5F759XmZaNP94zDXEqfbfZNCttU+aP8uzATh/BBVkQCR3JEcEBZR29w8nYSP9LJhc
	 CtKe0xmKFp5fHYQgHXScLt6+P1qcXW+dToqCPO+4EfkeqtTKNIuWJYTAYI3IeCW2FG
	 gBEQdfEHSpd1qSwjcg0T0A4ngglEBHAhyplPUdsjUgW2GVBdYYRvRXquRyU4LLhxLW
	 j+L9wbWQLNHpBCQ8ZOjdToVRS9TpH1bkVsfsvxSILXzZ96oEu0yhvWn9piPJm/ase/
	 GH8ms9xapN07A==
Message-ID: <b34788391df96f39025d2b1ce47e6d26.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <921e3180-231d-ff14-32a4-4bd5dbed2f32@huawei.com>
References: <20240803065625.347933-1-cuigaosheng1@huawei.com> <17286822755c4420d3ec2e405ccab41a.sboyd@kernel.org> <921e3180-231d-ff14-32a4-4bd5dbed2f32@huawei.com>
Subject: Re: [PATCH -next] spmi: pmic-arb: Add check for return value of platform_get_resource_byname
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org
To: cuigaosheng <cuigaosheng1@huawei.com>
Date: Tue, 06 Aug 2024 10:50:44 -0700
User-Agent: alot/0.10

Quoting cuigaosheng (2024-08-06 05:06:40)
> Thanks for your time.

Please don't top post.

>=20
> I've made and submitted a patch v2, and I think the right fixes tag is=20
> as follows:
>=20
> Fixes: 39ae93e3a31d ("spmi: Add MSM PMIC Arbiter SPMI controller")

Don't think so. If the resource isn't there, the pointer returned is
NULL, devm_ioremap_resource() would bail out early if the resource is
NULL and return an error. I suggested that fixes tag because it removed
the size check. But now I see that resource_size() on a NULL pointer
would blow up. So the real fixes tag is

Fixes: 987a9f128b8a ("spmi: pmic-arb: Support more than 128 peripherals")

because that introduced the call to resource_size() on a potentially
NULL pointer.

