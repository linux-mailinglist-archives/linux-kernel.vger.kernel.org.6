Return-Path: <linux-kernel+bounces-231097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A228918629
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA86B1C21EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8930518E762;
	Wed, 26 Jun 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syYgb2Zq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3CB18E745;
	Wed, 26 Jun 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416692; cv=none; b=U8L32pboe1JUygIjZvevLWOM0FLeEFfzQphh018PgdDcFGLKvV1mJlKd9EeQmEQVwKCMIjnVm9SpiNkRhWznd/LahjlkTlGJaGwAQbCWxXYh6326B00XPiAmnhJbIE5tCqxgwnHgLcZwBmN6s5GSIktJ3FKx236MdcS+4qdkOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416692; c=relaxed/simple;
	bh=n4OVtT18I3FXKBdUsf9p+/05XLMgkzCu5iBmKdJSptU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jtc0d9vqdZtnH/UfWKZF+XhjVwzTmx8ZdHcXQQIvYhAek6kLyt27eBg1/b+9k4UgZEEdbLhH1RodmzTWsiahEutzDChbBsCwO69Pwn93QAL/mQeKgxbhZSC7kU3N/zGBXOspPMsfWqx5fUo/PGf6ot0tyxD5z2XvqOYy5YdNGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syYgb2Zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C952C116B1;
	Wed, 26 Jun 2024 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719416692;
	bh=n4OVtT18I3FXKBdUsf9p+/05XLMgkzCu5iBmKdJSptU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syYgb2ZqRg/UNp+WtArfo2u/rtjCYUDuT0Y0QsegV9F8edrHaQmiy3ZrRtkqAktpB
	 XWpRbzO3ZxL8t0TEXFtReC9KRXEYmmu9do/4yLFPEffcY3LCta1Z/3CmvMPQ1i02Z/
	 N40XkEtBlK8hxNTL/E0Gi318B6o1lbwlMvmG43VtgwcVihtBaI/oklQSJax7R8Hgpp
	 c/arl3iHLbnD4VymI3Kqr7Bhze7uXnzEIO6hUNMgZHY7b01OymjW42MT+kvp5FcrIr
	 7zlqfxm+Bk+OnfCH+ofbAqZ47Q7AmhVLYiD1eJ9Kdu+EevWojpCH3FHVdhPyFVt6ra
	 98XFQe+9sNWVQ==
Date: Wed, 26 Jun 2024 16:44:46 +0100
From: Lee Jones <lee@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Furkan Kardame <f.kardame@manjaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	kernel@collabora.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: mfd: rk817: Fixup clocks and
 reference dai-common
Message-ID: <20240626154446.GD2504017@google.com>
References: <20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com>
 <20240622-rk809-fixes-v2-1-c0db420d3639@collabora.com>
 <20240622-exquisite-absently-e35b2cf335e3@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240622-exquisite-absently-e35b2cf335e3@spud>

On Sat, 22 Jun 2024, Conor Dooley wrote:

> On Sat, Jun 22, 2024 at 12:57:18AM +0300, Cristian Ciocaltea wrote:
> > Ensure 'clocks' property does not allow more than one item and add the
> > missing reference to dai-common schema.
> > 
> > While at it, move 'clocks*' and '#sound-dai-cells' properties to keep
> > the list ordered alphabetically.
> > 
> > Additionally, drop all useless/redundant descriptions.
> > 
> > Fixes: 6c38ca03406e ("dt-bindings: mfd: rk808: Convert bindings to yaml")
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> I'd argue that these should not all be the same commit, but w/e.

Are you arguing that, or not? :)

> Acked-by: Conor Dooley <conor.dooley@microchip.com>

-- 
Lee Jones [李琼斯]

