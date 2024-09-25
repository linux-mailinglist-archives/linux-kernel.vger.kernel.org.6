Return-Path: <linux-kernel+bounces-338172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 149B798544E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA24D1F21C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7F2157A72;
	Wed, 25 Sep 2024 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sefENcld"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF33C156F36;
	Wed, 25 Sep 2024 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249855; cv=none; b=FsdhmDsNRQHwQ/RgRQbERrz0QCpHcYbDl72myKNQWvOdqaE7cKwP9ROP6BUFXgWEibvGY2t9sdXbgoQTrZDmP0T2UpglulHcTcLpM1NjM4ZWNJdVevGFPq16uub5YLNQPyvqKxYQgLgUBRo9flk06lUQySHVvD/eNyQXqjM+tBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249855; c=relaxed/simple;
	bh=EUBt0puZVNOm9DciLXRmxe+8daLNMpdvbGB4Ago1RaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQIMWZVwNAY7qfyMQaheet2hmGYCspRdf7XiLKtALAKesLeH+k8stg1jupzTsYpXPBVPU2rCH2Fb0E1bgV21phAo2OTH0BzIS79mNcCZLO6foZY7zKRE64N1KSjfxyoAeA+0D+R1YJWHvT9gMm/CBVRlL7cY0Lwl5EgBCLX/rw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sefENcld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B8DC4CEC6;
	Wed, 25 Sep 2024 07:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727249855;
	bh=EUBt0puZVNOm9DciLXRmxe+8daLNMpdvbGB4Ago1RaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sefENcldyHF3F+JjE4JgRKyXF5UmrhRWjSQcFSC4fxKB4chlJzh8q9ZaP37Co8Bq+
	 bNJn0OIiC5rn+jGDETCAxj4ix7jKTADT/acx44z0w26968yzvuvexrimsgKbp078GD
	 DlcbA41nY16h/VuHG3eh0I1nzkq1mp9mmR/kpVMg8umXj97AQskBIK2I4x0XeDTWU1
	 +wm1pLwpcqZTjvkMa++BOZdfpvVm3lwIQswR8Ihsr9y3oNTdwvQEc9KpCiLCOch0/X
	 oASWseXXQ21OXzF30TZn6ho2viLh4rES+8HAHKy32i5wWRGmmz6RIQs4D0Ro+163D3
	 ciUF69t428cgw==
Date: Wed, 25 Sep 2024 09:37:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yikai Tsai <yikai.tsai.wiwynn@gmail.com>
Cc: patrick@stwcx.xyz, 
	Carsten =?utf-8?B?U3BpZcOf?= <mail@carsten-spiess.de>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: hwmon: add renesas,isl28022
Message-ID: <5r43dvdywunpottd3uuobjzrzfn4w6xgy2vug46niufih6v6vy@jsix2hkc2dg7>
References: <20240925031131.14645-1-yikai.tsai.wiwynn@gmail.com>
 <20240925031131.14645-2-yikai.tsai.wiwynn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240925031131.14645-2-yikai.tsai.wiwynn@gmail.com>

On Wed, Sep 25, 2024 at 11:11:27AM +0800, Yikai Tsai wrote:
> Add dt-bindings for Renesas ISL28022 power monitor.
>=20
> Signed-off-by: Carsten Spie=C3=9F <mail@carsten-spiess.de>
> Signed-off-by: Yikai Tsai <yikai.tsai.wiwynn@gmail.com>

??? What happened here? So you are going to ignoreo silently our
reviews?

Best regards,
Krzysztof


