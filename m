Return-Path: <linux-kernel+bounces-238756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706DD924FA2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BECB28ED1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC441B5AA;
	Wed,  3 Jul 2024 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kN8xoRpK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="Wsd/zUeQ"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6426617BA2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977774; cv=none; b=dNyMHoTmhDxVkK1A0wgUJ+G7YT2ltRLd6sdUeYfTQL1ZZZ5e0Ua856glQjy/048ZZatcrC03hKX3iYde0W26W9yMp6Is8atvfJRBJtODBNMuKz/NL6/eJm5hrpQAhCo3XVuEpxWWVXRux0jHS2ZSTXfDqioscnD6DUxLMY/GuT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977774; c=relaxed/simple;
	bh=sJ/0Y0US+YmrNKKtDWfsP2IwcHc6tZwz8z7wevcvAC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y6NXaFciidN+HZ+pHQfQWzccj1RNnVrG2R3o7KrR7UEb4NjbSWJN5014uDbfwS779K+Zt77Dv5FTkbwIUuwkBZbum9fzExmfvZmv6smWhtO+sEOjdssrXtnCkvR7YQ4Kpo6bb1jiwaXGRFp1RpFUI9tMIDsjmHqMp/OxMN1kLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kN8xoRpK; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=Wsd/zUeQ reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DDA103647C;
	Tue,  2 Jul 2024 23:36:11 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=sJ/0Y0US+YmrNKKtDWfsP2IwcHc6tZwz8z7wevcvAC4=; b=kN8x
	oRpKQmTu+//YbdeXtzjaWBvjgWUrGWiwS8Jy1asiIuIA1FlY5+Rf9rKWrkz0dzpm
	e7l6FwA/0H2RSV9+PE2ZbRI2KQe384eqc3Uc67ItqlytAJQoLbNp97qn8AtznanQ
	tQY0Cek0vYxPW7BKxYxKiiMtmhlb4vQGeGElf6I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C7E653647B;
	Tue,  2 Jul 2024 23:36:11 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=2016-12.pbsmtp; bh=sJ/0Y0US+YmrNKKtDWfsP2IwcHc6tZwz8z7wevcvAC4=;
 b=Wsd/zUeQRdb4KbG6E+QdHWIunz83HU27AsJNq5lue08+WYfwWm4mmc1M+vBC5RNEvyDwZu5i9BW1mch620FqDFECXZkpmkywSfbagezNeZqUBGQQwoU/n1+E56bIxrKRbQDF+eK2zs3yVGR0DjxTjGL4aI1EDdWSJiPv5c2ie7A=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CE54D36479;
	Tue,  2 Jul 2024 23:36:07 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 6FD01D31180;
	Tue,  2 Jul 2024 23:36:05 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mul_u64_u64_div_u64: new implementation
Date: Tue,  2 Jul 2024 23:34:07 -0400
Message-ID: <20240703033552.906852-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 62411B34-38ED-11EF-8FCF-DFF1FEA446E2-78420484!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

This provides an implementation for mul_u64_u64_div_u64() that always
produces exact results.

Changes from v1 (https://lkml.org/lkml/2024/6/28/1130):

- Use the already available u128 type instead of "unsigned __int128".
- Add a test module.

