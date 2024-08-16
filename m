Return-Path: <linux-kernel+bounces-289853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA878954C68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A242428487A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CDF1BCA17;
	Fri, 16 Aug 2024 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="cea/qfir"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385581B29BF;
	Fri, 16 Aug 2024 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723818897; cv=none; b=jgz7vTJUup2o3ZmOJs7T6bDQnff72GrcxULCv8+s6Lr7tI6ymkR1GfK+qVYP2wwN5c+jnXdGU/CCzLKV6i24q8WAHwjcC7yc7MH0Lt1OL0ebNZTQtR2v5sil+OjB7s/tOwICBIPcw/CUmoH8puyCGvEQOf/5TqT1GvwEQSrVG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723818897; c=relaxed/simple;
	bh=N8fqyg8l237PqTU9TOdxbqpAwLEzrLJtjV7LkYslsH0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=civxDnfXcWKG9nydcEzIjgkZFSLXa9Ogq2PInvRc7xJC4QPksKap7L00ITPnRO3Zo9ZBfceRA2hGTIBRrbMRuU9DvWQZ/oyzQ3pcn1tihj7Afmk2q9ebbOfVVxCs/6Ger4MT60JQuA7Md/SkOn6cemPSasfDwig9c/hiFUN9CRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=cea/qfir; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A4B61483139;
	Fri, 16 Aug 2024 16:34:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1723818892; h=from:subject:date:message-id:to:cc:mime-version:content-type;
	bh=RKxJmlhNEAqQkdoBYd2vI0M1holWIRsdMAXqhGnFoZs=;
	b=cea/qfir2el/OmGMUZvXhpIcUClMdrhJg4FY34xMPo4jd/IgvrJauZEtqjZP98Fs6Rn38R
	Bf1K3Jgsu4+D8CZ1bufDBVdKaH+QiTqA3HMp6Gy1+ucbjaCy50n7nLIeuNzWVo6Gtg8b5+
	agVCcALt3AP9ALvt9pL4PABK3NxJ8EwQ6rM3lvvgCGp/GRY4euJ4TXmnUpatVfLrDZPQzH
	w/yxAcAa4Lqrm8kJ83RNOPoNndPtwHRsUidUigrIiFEHV3c/jy1rxLw7ty8KK8/pQt59/g
	z4Gw9+XfknEdietPBmlOxL5U/h6qXa6ywZqKGp0Cso5pYk4bCfI0qO+NHjcBwg==
Date: Fri, 16 Aug 2024 16:34:48 +0200
From: Alexander Dahl <ada@thorsis.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org
Subject: get, prepare, enable a clock not in DT?
Message-ID: <20240816-ludicrous-lagging-65e750c57ab4@thorsis.com>
Mail-Followup-To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

while further investigating timeout issues with the at91 otpc
controller on sam9x60 [1] I came to the conclusion the main RC
oscillator on that SoC must be enabled for that driver to work.
(Verified that by poking single bits in registers through devmem
already.)

Fortunately the necessary clk is already registered from the SoC code
in drivers/clk/at91/sam9x60.c [2] and I can see the clock in sysfs clk
summary:

    root@DistroKit:~ head -n4 /sys/kernel/debug/clk/clk_summary 
                                     enable  prepare  protect                                duty  hardware                            connection
       clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
    ---------------------------------------------------------------------------------------------------------------------------------------------
     main_rc_osc                         0       0        0        12000000    50000000   0     50000      Y   deviceless                      no_connection_id         

That clock has no parent and is not found anywhere in devicetree, nor
is it handled by the two clock-producers on that platform, so
from within mchp_otpc_probe() I just tried this:

    otpc->clk = devm_clk_get_enabled(&pdev->dev, "main_rc_osc");

However that returns with -ENOENT, so I assume I can not reference the
clock just by name?  Same result with this:

    otpc->clk = devm_clk_get_enabled(NULL, "main_rc_osc");

How do I get a pointer to that clk then to enable it?  Docs [3] where
not as useful as I hoped for, neither was clk.h header docs. :-/

From what I understood from header docs reading 'device for clock
"consumer"' I must pass the device from which I call that clk_get() as
first parameter, so this would be the otpc device then, right?  What's
that second parameter clock consumer id then?  Are these terms
explained somewhere?

Greets
Alex

[1] <20240813-payable-ecology-8a9e739704bb@thorsis.com>
[2] https://elixir.bootlin.com/linux/v6.10.4/source/drivers/clk/at91/sam9x60.c#L217
[3] https://kernel.org/doc/html/latest/driver-api/clk.html


