Return-Path: <linux-kernel+bounces-243706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DDF929968
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 21:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A2F1F21109
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 19:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA016F303;
	Sun,  7 Jul 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vIs54/I3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="Lumv4+/v"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5E25674E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720379227; cv=none; b=dkzltADaFmDfgDheO1o7chDUTzNpiD+EoIMS/t9kL8vy7GNML/FZ8cj2C+76Dc+jYypiGXBsLvKHUPJC87aYOuc2S9GAXG3AnytpaWSL/kQ+JB99JBK+gY/jktHXKDEJ+oPIxDRNMpkhycAGua4ccEMauKvS5FgkAFkZ6FSSQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720379227; c=relaxed/simple;
	bh=ttkxkuHdYyGROCztq4Km5rtQyR7sKE2u9A7NVaY9xYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HhPnayS9nqoI4TfalV0fPcVmEEcZnzDu1dY5jUea794DSvMpHio7i7PyJfsNWaF8iHqq0PpbUj9OVp+d+AT5CUWjtmF8fcE847Xzc488zb0lQY9uBKNOwqGWApO+7xGalkQ1of46xvf1acJa/pSi54+yyaxPtVj7jCs/oi3q/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vIs54/I3; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=Lumv4+/v reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 12F2B32D95;
	Sun,  7 Jul 2024 15:07:00 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=ttkxkuHdYyGROCztq4Km5rtQyR7sKE2u9A7NVaY9xYw=; b=vIs5
	4/I36YsnocjUp8GwZwfbcAUxeMEnSd2qq+5C0vNpw1R9eicLX0lyUeGo68Rclw2N
	UC4Bo+RYwh/QFfZb4NZYyQEiTkul6sdM3CYXWKfTEp2s4ROejteczd7RPwYcOYu7
	oJ3JEDKOBoOtq81ufXoA7qUMhAA2SyKVSMNCl0I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B1E932D94;
	Sun,  7 Jul 2024 15:07:00 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=2016-12.pbsmtp; bh=4pzaOcpp88M6J1iv0NQMg9cdDN1s+TaJNOnInjqVeMs=;
 b=Lumv4+/vj5gh8YrD9GybTHGvvyHSFKF+l7stYUxF7LObLuQf9uSouv0L8TOGlpWBra3op7k0JXbiYpIJfGw5UE/hfk44L2gbIMBoEqdc+UuM5my7gzaU5M8K8WUrIyoXILI4vbyhHwOKUMw6kpip8HgHHklW++oHHEp3noEZ+yk=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0573032D91;
	Sun,  7 Jul 2024 15:06:56 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id AC266D3B4E1;
	Sun,  7 Jul 2024 15:06:53 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] mul_u64_u64_div_u64: new implementation
Date: Sun,  7 Jul 2024 15:05:18 -0400
Message-ID: <20240707190648.1982714-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 14036A62-3C94-11EF-B613-DFF1FEA446E2-78420484!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

This provides an implementation for mul_u64_u64_div_u64() that always
produces exact results.

Changes from v2 (https://lore.kernel.org/lkml/20240703033552.906852-2-nic=
o@fluxnic.net/T/):

- Dispense with the fancy union. This makes the source smaller and
  avoids #ifdef for endian ordering that trips kernel test robot somehow.

Changes from v1 (https://lkml.org/lkml/2024/6/28/1130):

- Use the already available u128 type instead of "unsigned __int128".
- Add a test module.

