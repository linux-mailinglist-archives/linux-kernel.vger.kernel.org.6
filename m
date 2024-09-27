Return-Path: <linux-kernel+bounces-341367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4CC987F17
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8D71C20F29
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2917C9B8;
	Fri, 27 Sep 2024 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TsgjXtw5"
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423FA1662E7
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420622; cv=none; b=SGBvOsR/vZxl50smvP4BmT1KnQz9jcsk+8znhbi355AyakRP5owUMhDw4Y8IAY26t4R2/uFnCN451r/ojJUrfV1J4slAHJ5L35Acu0A5XcE14aTtrb+q3zuDrAPrLWiFOEKNevKQ5L7xVgODoiv5HZBqmbBlPIZ9iTxARAfjgZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420622; c=relaxed/simple;
	bh=lit4drWWoXlbmB5xZse2LmMCZxlhgrRVhkj6To1hqgQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AD++dKuUuS81LaTAyujLAwuTRMtQLiUKTQFSuILPm5qOYtk30h3X4Y6ERGuHgSyfWWxgxrbAVZ2uBKuu2bzzJV7Y4AqsSz6U11Wxfp0Apk1hI4i8fr28f9vZ9Oxq8Zrp2yh3fj4GMglYiHyvWkQu+t7pm9l5dDstiCBfDBDGaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=TsgjXtw5; arc=none smtp.client-ip=185.70.40.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1727420612; x=1727679812;
	bh=lit4drWWoXlbmB5xZse2LmMCZxlhgrRVhkj6To1hqgQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TsgjXtw5oLnaxqJigC6xC0V/xqHrIOg6CjZQf7itOmroJ9dE9/nq/sKkQZ5HmwSbC
	 DLyGXmt3WZ6zaebx2yIoXcptiFH3O/4joGo6uzfVP4shV3mn8Zhv6PzuwOwE6lgvEM
	 XDMjqgKD67zPUhmCEZyk1OFNAzaQdrnB2hkHATFwtFGlQkAtRNvHTzXS7UI+joxncJ
	 6xFVQDWL7FI8U/kcrSTjNG7Ika6lEe6myG16ggU0egR1i8U9uISzKE+CgBkhrWdT93
	 kjb5M3wPQ413rqvVZ500NZYQP3iO2MLeq8BDvfBfanfn/DB29pO+Ytkr/fSR/da4xD
	 b+QJoBSXlTO3A==
Date: Fri, 27 Sep 2024 07:03:28 +0000
To: "davem@davemloft.net" <davem@davemloft.net>
From: =?utf-8?Q?Kacper_Ludwi=C5=84ski?= <kac.ludwinski@protonmail.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "petrm@nvidia.com" <petrm@nvidia.com>, "horms@kernel.org" <horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>, "shuah@kernel.org" <shuah@kernel.org>
Subject: [PATCH net v2] selftests: forwarding: no_forwarding: Fix issue  related with assigning two different vids to the same interface.
Message-ID: <fQknN_r6POzmrp8UVjyA3cknLnB1HB9I_jfaHoQScvvgHr59VfUNRs9IDo4kQHm1uxEp8_Luym2Vi6_aUGJIec3ZPhjY2qnJ57NgLZGA3K4=@protonmail.com>
Feedback-ID: 10783966:user:proton
X-Pm-Message-ID: 8d9b28129d518c775345aac79bf29a46b24a3f0f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fix typo.
Currently, the second bridge command overwrites the first one.
Fix this by adding this VID to the interface behind $swp2.

Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
Signed-off-by: Kacper Ludwinski <kacper@ludwinski.dev>
---
 tools/testing/selftests/net/forwarding/no_forwarding.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tool=
s/testing/selftests/net/forwarding/no_forwarding.sh
index 9e677aa64a06..694ece9ba3a7 100755
--- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
+++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
@@ -202,7 +202,7 @@ one_bridge_two_pvids()
 =09ip link set $swp2 master br0

 =09bridge vlan add dev $swp1 vid 1 pvid untagged
-=09bridge vlan add dev $swp1 vid 2 pvid untagged
+=09bridge vlan add dev $swp2 vid 2 pvid untagged

 =09run_test "Switch ports in VLAN-aware bridge with different PVIDs"

--
2.43.0

