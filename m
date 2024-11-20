Return-Path: <linux-kernel+bounces-416180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20DF9D41BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC7A1F22E96
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC2B1B5ED8;
	Wed, 20 Nov 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/MxMZGb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EADA150994;
	Wed, 20 Nov 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732125555; cv=none; b=FKABQ1tz3H/h4dmqluP31zIRkH17wiUKQRKVBvmfW/JKd2De7gTtrXMwOGjh7YAZPfo4hLHljZq6DDgOt9wgANWYqwiMfz3URgUkMhSigl1VHtqM2//rHJpvL0fvYXhQXg/65LCOao5u/vG3BeD4cvdK1jEZ4kCDBTvACElwgNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732125555; c=relaxed/simple;
	bh=hwqWZQPgkK5ssNxl8O13LuYP+NTlv4KpZmZuEV2pLGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrnYmH9K4eP0do/cioiQ8BiT8DLYin1/1gV0QReuDO87rKUr5fqKRGPLkuGXdBcy8+3eK1oJKltxyNl2HLa9QTiIq4Wg77tXq8wNBzDuLlFBPsqvnOIzod+5y6V0oIXBLVpFu5flEwxeXl+9Is+j/zELYZoCyhx3VG6yfgiEgek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/MxMZGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF26C4CECD;
	Wed, 20 Nov 2024 17:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732125554;
	bh=hwqWZQPgkK5ssNxl8O13LuYP+NTlv4KpZmZuEV2pLGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/MxMZGbR/dB1FwR52MyiCBnyZRDN0X/0LjDh19la/jGbGN2G6EWipPpYJYk+L8nG
	 ob/avAT+IaJwNfxrJv3s3WDRbqlKsbYfCF531DRDwtRCTz4Cr2B84+6F3ypHlfKmL8
	 X+FC78a9C1FeRfmCZffbPCYl3IJPCfdzjZCV58AVZlAAmvCSVkD2OZZC29RE07flBo
	 rf0b/mf+EJCutWy4uHCvMOajRXjJZpbZ7aoR9hJbllxkFYLMnwh1TKhG37ChgEy8m+
	 jGdaZE9PIL7Kiml3RI3UMGUELYdI2kJhJuh8SoH86zwYp03wpUPX4mPb8SJcWMsldo
	 bzaFomh3iBRLw==
Date: Wed, 20 Nov 2024 09:59:11 -0800
From: Kees Cook <kees@kernel.org>
To: Yabin Cui <yabinc@google.com>
Cc: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Allow CONFIG_AUTOFDO_CLANG to be selected
Message-ID: <202411200958.F8A656A080@keescook>
References: <20241118222540.27495-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118222540.27495-1-yabinc@google.com>

On Mon, Nov 18, 2024 at 02:25:40PM -0800, Yabin Cui wrote:
> Select ARCH_SUPPORTS_AUTOFDO_CLANG to allow AUTOFDO_CLANG to be
> selected.
> 
> On ARM64, ETM traces can be recorded and converted to AutoFDO profiles.
> Experiments on Android show 4% improvement in cold app startup time
> and 13% improvement in binder benchmarks.
> 
> Signed-off-by: Yabin Cui <yabinc@google.com>

This looks trivial enough to enable. ;) I expect this could go via the
kbuild tree (Masahiro) with an arm64 maintainer Ack.

FWIW:

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

