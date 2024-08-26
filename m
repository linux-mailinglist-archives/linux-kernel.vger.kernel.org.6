Return-Path: <linux-kernel+bounces-301077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6767E95EC10
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E51A8B26641
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58A0139CFC;
	Mon, 26 Aug 2024 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="HXFaF3yS"
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D36AFAE;
	Mon, 26 Aug 2024 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661203; cv=none; b=q5lCu/lK2oSqtoyXidXNHWLXciyAMCmvUkc0kt4wOT5bM3y1/RTuL/NcwLrDpe796WQlPPprefiRxbMcH0CGYvKke11OdHmrJTaAnCsLB/CsgAXY3YAJolFolzOQ0AZgXMlUuvEIGCm9Szz54McqIn6PGLoTh+amH/+zflJO99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661203; c=relaxed/simple;
	bh=zc2h4Lnh0BPNkOA449ju3jNVU/AE4b/J9omnQqnq6uM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=njwr7W+MbHWuxMTuBVAJEACgMQBOzpa8pI8rrbhtDme/sKm1RkfS8mGKiIs8cMeCivmjcVVfIZzOpuyy8/MJZ80erfGjHlBhKW/2XhUAZ870NVxDRIFwSEs/mlA9C8fQOKIjc/F4ArFuCbkOQvPndyNEBDsFSk7K+uNrO9guKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=HXFaF3yS; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:799d:0:640:253f:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 98EB461617;
	Mon, 26 Aug 2024 11:33:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6XOGuELZwiE0-xhDhcxdP;
	Mon, 26 Aug 2024 11:33:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1724661187; bh=zc2h4Lnh0BPNkOA449ju3jNVU/AE4b/J9omnQqnq6uM=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=HXFaF3ySQHsLGpy+nYMHM4KYw3UreK/xgUOLaof49dtU2V+Ow0R7dVe+0veB47EF+
	 TZLUfacdfe6cI1+Yn/K8s0qbKkQ+23GSTLn0wpXTK4bSmyk3a92w5opb8xLit1G/jM
	 hY7gS77vHzgTi08vegog5m/J/wnslPDjG9KcA24c=
Authentication-Results: mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <df5d5a90953ab8e746dbcaaa065279745784ffa8.camel@maquefel.me>
Subject: Re: [PATCH v11 03/38] clk: ep93xx: add DT support for Cirrus EP93xx
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mturquette@baylibre.com, devnull+nikita.shubin.maquefel.me@kernel.org, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>
Date: Mon, 26 Aug 2024 11:33:07 +0300
In-Reply-To: <7e91180bf4cb632b5ba23df10f8e9b998144acb6.camel@maquefel.me>
References: <7e91180bf4cb632b5ba23df10f8e9b998144acb6.camel@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Stephen,=20

A gentle reminder on this particular patch, hope you'll have time for
it soon.

On Fri, 2024-08-02 at 10:07 +0300, Nikita Shubin wrote:
> Hi Stephen!
>=20
> Just in case you missed this one in last series update:
>=20
> Changelog for this patch:
> - added devm_ep93xx_clk_hw_register_fixed_rate_parent_data() for
> =C2=A0 devm_ version of clk_hw_register_fixed_rate_parent_data()
> -
> s/devm_clk_hw_register_fixed_rate()/devm_ep93xx_clk_hw_register_fixed
> _r
> ate_parent_data()/
> - replaced all devm_clk_hw_register_fixed_factor() to
> =C2=A0 devm_clk_hw_register_fixed_factor_parent_hw() or
> =C2=A0 devm_clk_hw_register_fixed_factor_index()
> -
> s/devm_clk_hw_register_gate()/devm_clk_hw_register_gate_parent_data()
>=20
> Stephen - it think that's you was aiming for - to get rid of all
> functions that are using const char* parent_name directly instead of
> clk_hw or clk_parent_data.


