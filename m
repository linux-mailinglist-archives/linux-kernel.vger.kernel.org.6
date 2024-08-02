Return-Path: <linux-kernel+bounces-272191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9704A945874
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A79285CC4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D305715B134;
	Fri,  2 Aug 2024 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="GCoE0s4D"
Received: from forward202d.mail.yandex.net (forward202d.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043D3D982;
	Fri,  2 Aug 2024 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722582896; cv=none; b=PuJWUmBeGjOtPD7vcrz0cIZhu/NOsbaL+GpSuYwC/4q+lAaAMOyoqaN5vMg2ubwykFQCFS6ul4//AbvyzxcaA4X+jdhTRdTyJ9J7WECk7sIhCZUv+Tc+/Chs946D3A3bCqZG6wBraTaRzS5tIMTAq8GvmR4erpXOvHquZrbpogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722582896; c=relaxed/simple;
	bh=+H3UscldKpnbwihBTWC8wA030P9WbYbZ+lu6xrBz2IE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=MtnOaMFIplK4vlCOgY5r1oLx1e3KsKOupph08CRbhdFHp0tefn5qKoXe/m7MZqfjaHruMJNxnW31MHUfuP8nDlRDD/ShnBxCiM706oH81HTvd5p6hIJnLh8dQDsYDPzkd2CJLE4Gh9az+NmvuSBxnZG1QbuG1XTUSiJwcESXCDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=GCoE0s4D; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
	by forward202d.mail.yandex.net (Yandex) with ESMTPS id 070E1614A7;
	Fri,  2 Aug 2024 10:07:46 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3143:0:640:c03:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id F2BFD60091;
	Fri,  2 Aug 2024 10:07:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id a7SC6W32SiE0-dZji5bIF;
	Fri, 02 Aug 2024 10:07:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1722582457; bh=xsaIK4/EnVOTYIPtcBZdmJmfVFRbdam24wsGhkd0NBM=;
	h=Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=GCoE0s4D0DNmaAhumCShIXf9BogDTcvSlX/Mt696Gv4MrcKoltDZaaSEDDT2QOSWQ
	 jtKKwtGIheJLf20GwRr4bj1zY/E8WX/tnTcQxgxmr27URf/Y582rsb0gVGaPZFjxfr
	 UJUTrFqClNCyZ0mNoyopdbzD4T9rojusKXWhazNM=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <7e91180bf4cb632b5ba23df10f8e9b998144acb6.camel@maquefel.me>
Subject: Re: [PATCH v11 03/38] clk: ep93xx: add DT support for Cirrus EP93xx
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mturquette@baylibre.com, nikita.shubin@maquefel.me, 
	devnull+nikita.shubin.maquefel.me@kernel.org
Date: Fri, 02 Aug 2024 10:07:36 +0300
In-Reply-To: <20240715-ep93xx-v11-3-4e924efda795@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Stephen!

Just in case you missed this one in last series update:

Changelog for this patch:
- added devm_ep93xx_clk_hw_register_fixed_rate_parent_data() for
  devm_ version of clk_hw_register_fixed_rate_parent_data()
-
s/devm_clk_hw_register_fixed_rate()/devm_ep93xx_clk_hw_register_fixed_r
ate_parent_data()/
- replaced all devm_clk_hw_register_fixed_factor() to
  devm_clk_hw_register_fixed_factor_parent_hw() or
  devm_clk_hw_register_fixed_factor_index()
- s/devm_clk_hw_register_gate()/devm_clk_hw_register_gate_parent_data()

Stephen - it think that's you was aiming for - to get rid of all
functions that are using const char* parent_name directly instead of
clk_hw or clk_parent_data.

