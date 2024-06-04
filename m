Return-Path: <linux-kernel+bounces-201353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056458FBD71
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362951C218F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C9614B95E;
	Tue,  4 Jun 2024 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndiXGRlc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53B3BB24
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717533604; cv=none; b=KCzCU9/8lwTvvMjwBsv7tYK5IGRa6T396gfF0/ZXbQ61kmlQYJQtVAd6eL/JtejKQ1GsA+XFqxCJD5DC6KKIteqf8TxRfvaQ/SyEyuZ8eqgW7z+AdSWFgQrq7Co82/UodHzVqfzMVN9LMJtDw7x3L4DGZ7bPoTgihCBR7xdlP0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717533604; c=relaxed/simple;
	bh=mboyp4Z+bXakHXnDpVGnzizJvipyHXuLon4e7sk6qBw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I47IgbF20V4iqmYk2LoRFXIxCtP0kQGIqxml858uWRnK86RJWBnxq1tvb/+fDn0bVG3fufTtq9CRjOnq4az1q4YlTaZlV8KassxBZXUb5tfdZLSdzVLV34Bu7f/IaZRnum2pkMw+f8bNqY044AQ2FztvtTDdKtJIK/ZuodWEMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndiXGRlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C0FC2BBFC;
	Tue,  4 Jun 2024 20:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717533603;
	bh=mboyp4Z+bXakHXnDpVGnzizJvipyHXuLon4e7sk6qBw=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=ndiXGRlchxSWvfojHfA4wXlHsA6TCBwy8tsTLOYIsCitJ6JWU4RsDCMVmGntAmKmA
	 jIqLn+kSVhy9wJn1nX7btdXinwvDevNgQj/JAnFWIot1gzoCpa4k7HbKiOLvrEjg4A
	 nzJ6zovyJLmwfILwWsxfTTutXUn/Y4VPpRTxllkQ3fqKyomo4IXe/gziCxVT8AlkKt
	 FEOREksFKZZchDUDA7smnyFGK8SuTahkGfSX8f6SopsdVO3h8g6dVyBCEDkTFPqN6r
	 KHFOC0cIOsl1XCj31SLevsaOqaZDYk/2G3ljZPz6HFy2vOcNt4tGFHECOP49ZymkW+
	 ES+mejMsBQFTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 02EC0CE3ED6; Tue,  4 Jun 2024 13:40:02 -0700 (PDT)
Date: Tue, 4 Jun 2024 13:40:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	kernel-team@meta.com, mingo@kernel.org
Cc: elver@google.com, andreyknvl@google.com, glider@google.com,
	dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: [PATCH kcsan 0/2] KCSAN updates for v6.11
Message-ID: <ecf1cf53-3334-4bf4-afee-849cc00c3672@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series provides KCSAN updates:

1.	Add example to data_race() kerneldoc header.

2.	Add missing MODULE_DESCRIPTION() macro, courtesy of Jeff
	Johnson.

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/compiler.h                            |   10 +++++++-
 kernel/kcsan/kcsan_test.c                           |    1 
 tools/memory-model/Documentation/access-marking.txt |   24 +++++++++++++++++++-
 3 files changed, 33 insertions(+), 2 deletions(-)

