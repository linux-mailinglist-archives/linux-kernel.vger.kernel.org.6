Return-Path: <linux-kernel+bounces-313643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEB096A80A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EEFB1C243E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE16191477;
	Tue,  3 Sep 2024 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjWWX9YD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A24174C;
	Tue,  3 Sep 2024 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394077; cv=none; b=iUVXdJr626WWuCPWv8PSkYYVfJGroSvT9QYNZ7LVds+SVWi8MJf82ztd/TyezyliDV2E6WZVUYI5/IZkukjyE4+Sm7x5EXeP3MEQRzKUFPIHeZSNft/GgiPyXZZtVHSep2xkx95cPMVUOmRHMbt+mm8guDDE0z+XXPqhP6dATf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394077; c=relaxed/simple;
	bh=ofIu1G3mGdDM+dEnrbE5L6i83BK0MeHk3HL2b2wyLzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BAa0ZWjfw5hpKe5eV3UJE8baKXyTsmx2unOb60i7/0UJrW8ftNctq21+IKXZ3ShipchTFG/4p7zclWKSqbKqgjImDc+3+2kdxIfA3ZHVPpwng9/Nn013iB15ehBU2LltJQjFzQxS6GjiGHyXIs1tk0WW7fdK2eteerC5j1U4ZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjWWX9YD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA9AC4CEC4;
	Tue,  3 Sep 2024 20:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725394077;
	bh=ofIu1G3mGdDM+dEnrbE5L6i83BK0MeHk3HL2b2wyLzw=;
	h=From:To:Cc:Subject:Date:From;
	b=PjWWX9YDtiosjl+81Ws4tdsKCuoD74J5WDGnBKeJ9Yjyh3o6rEgwzGOm2vxjUNiBw
	 1YIXKtY5lchAQekmzfPsY4UjjrcrdcMjtWC3a8ALj8rHCujgRY/67oZzI4Xd/qIZ2L
	 FS+9yy9HFrc3mMEDl9MY2I/fapcHOrL02rWKhNnpwQ8CHgQZZzq1ECPkEfLP6oZuoX
	 uIgGMgmW6ozv8NVdizGqeswC2/M7lUNUmlCmnU5RcJ08JIdv3JlmYLR72+BiTTs3WX
	 N9X5ldKYinfS9OAaa5Ylb26++kVe/YIGRXLhKdFUH4X0e4SQsaswIgYL92YkzkPV7j
	 9BSKqNqIcwclA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt: dt-extract-compatibles: Extract compatibles from function parameters
Date: Tue,  3 Sep 2024 15:07:52 -0500
Message-ID: <20240903200753.2097911-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Various DT and fwnode functions take a compatible string as a parameter.
These are often used in cases which don't have a driver, so they've been
missed.

The additional checks add about 400 more undocumented compatible
strings.

Cc: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 scripts/dtc/dt-extract-compatibles | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/dtc/dt-extract-compatibles b/scripts/dtc/dt-extract-compatibles
index 5ffb2364409b..13ea66d49e6c 100755
--- a/scripts/dtc/dt-extract-compatibles
+++ b/scripts/dtc/dt-extract-compatibles
@@ -46,6 +46,15 @@ def parse_of_match_table(data):
 	return match_table_list
 
 
+def parse_of_functions(data, func_name):
+	""" Find all (device|machine)_is_compatible() arguments """
+	match_table_list = []
+	for m in re.finditer(rf'{func_name}\(([a-zA-Z0-9_>\(\)"\-]+,\s)*"([a-zA-Z0-9_,-]+)"\)', data):
+		match_table_list.append(m[2])
+
+	return match_table_list
+
+
 def parse_compatibles(file, compat_ignore_list):
 	with open(file, 'r', encoding='utf-8') as f:
 		data = f.read().replace('\n', '')
@@ -60,6 +69,10 @@ def parse_compatibles(file, compat_ignore_list):
 	else:
 		compat_list = parse_of_declare_macros(data)
 		compat_list += parse_of_device_id(data)
+		compat_list += parse_of_functions(data, "_is_compatible")
+		compat_list += parse_of_functions(data, "of_find_compatible_node")
+		compat_list += parse_of_functions(data, "for_each_compatible_node")
+		compat_list += parse_of_functions(data, "of_get_compatible_child")
 
 	return compat_list
 
-- 
2.45.2


