Return-Path: <linux-kernel+bounces-568155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A82AA68EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD813AF37B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9392C1957FF;
	Wed, 19 Mar 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=zdenek.bouska@siemens.com header.b="EOUE4a5r"
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374F1B4F0A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393944; cv=none; b=u2Caw0uQ4sbnkKuZaPLwfEuCxehleBFIgOq3Pc+XBz4jFhvUVA5jKmMwDamHyaqvdAh+3zCcpduXR0ag5JYOs2XR8XDWAsquvg4tx5KaNsVgb6BPVsSfAHMxFtoitNQ0ghQoHU+ajGzWOTlBUoB7zM/ggWHBhnmFRfWtuKxDcPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393944; c=relaxed/simple;
	bh=2L1hcEbbpNxwS2XQn1kzLK0IbRFrHfVbWmh856XdmwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZTdgFPQwmp4sBYv/85yD8S+nDgA1wi8iR/egwRE9zxcr0Pg9TmSrfhh5h4GyyjUkw0qDD5ZUj3hncRLWgABPO3RPJlctgEkx1snN+N2dDOmwBJVkkb0PNXGVo1ZqJHlcwLbg/tFOgaHKdvj301xspPstQgMCV5OM54YmrXE18VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=zdenek.bouska@siemens.com header.b=EOUE4a5r; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250319141854b38800acad74a74e2e
        for <linux-kernel@vger.kernel.org>;
        Wed, 19 Mar 2025 15:18:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=zdenek.bouska@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=FXf6tL/+fXL9ZakOV01DQToLMo02isnVavTFvix+Ba0=;
 b=EOUE4a5rtVTenrtqYNTdHbRZYiix4F6UPZZaUfLC9KR+J+VW2I4JzXjU0fhpb3yc/pJhgG
 BfiHg7QNxOvU4sCp6rMCoRiFHaqd/cegjSrLxQ4kYctXFLuVMoS8ZehW3owXNSoKqnhSUWb3
 n+6w6dNm+gWOqA5Qo/JQzZV67sl0ws2zlPIVdnHkeYElI+FtaOTtrBiLI9uzd2ETDBq2VzZK
 aBju6jIeizNfSdVWRfLzp37P0X+O4Id9B8dA2qry6Pm3V0WZcCb+/IQqXuo20IRkwTZoqsls
 083OVNl2TAjQ3WDz91CS8mdaccSShswMP3BA4vtZZ+gmMnCl5pUPknZw==;
From: Zdenek Bouska <zdenek.bouska@siemens.com>
Date: Wed, 19 Mar 2025 15:18:48 +0100
Subject: [PATCH net-next] igc: Fix TX drops in XDP ZC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-igc-fix-tx-zero-copy-drops-v1-1-d90bc63a4dc4@siemens.com>
X-B4-Tracking: v=1; b=H4sIAEfS2mcC/x3MQQrCMBBG4auUWftDpokgXkVclHSss0nCJEhs6
 d0NLj94vIOqmEql+3SQyUer5jTAl4nie0mbQNdhmt18dZ4ddIt4aUfr2MUyYi5frJZLBcew3Dg
 Edt7TGBSTUf7nD0rSkKQ3ep7nD3oYTEp2AAAA
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andre Guedes <andre.guedes@intel.com>, 
 Vedang Patel <vedang.patel@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jithu Joseph <jithu.joseph@intel.com>, 
 Song Yoong Siang <yoong.siang.song@intel.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Zdenek Bouska <zdenek.bouska@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328595:519-21489:flowmailer

Fixes TX frame drops in AF_XDP zero copy mode when budget < 4.
xsk_tx_peek_desc() consumed TX frame and it was ignored because of
low budget. Not even AF_XDP completion was done for dropped frames.

It can be reproduced on i226 by sending 100000x 60 B frames with
launch time set to minimal IPG (672 ns between starts of frames)
on 1Gbit/s. Always 1026 frames are not sent and are missing a
completion.

Fixes: 9acf59a752d4c ("igc: Enable TX via AF_XDP zero-copy")
Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 472f009630c9..f2e0a30a3497 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3042,7 +3042,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	 * descriptors. Therefore, to be safe, we always ensure we have at least
 	 * 4 descriptors available.
 	 */
-	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget >= 4) {
+	while (budget >= 4 && xsk_tx_peek_desc(pool, &xdp_desc)) {
 		struct igc_metadata_request meta_req;
 		struct xsk_tx_metadata *meta = NULL;
 		struct igc_tx_buffer *bi;

---
base-commit: 8ef890df4031121a94407c84659125cbccd3fdbe
change-id: 20250310-igc-fix-tx-zero-copy-drops-1c4a81441033

Best regards,
-- 
Zdenek Bouska

Siemens, s.r.o.
Foundational Technologies


