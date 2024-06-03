Return-Path: <linux-kernel+bounces-199567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A178D88A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF8CB23775
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0009B13A3F0;
	Mon,  3 Jun 2024 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CN7y9waX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155F139CE3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439496; cv=none; b=VI9eacTHk0QEuS0J9TyEBbLciPJnRK854ipqbn0DjxZsPba9ucQ2XqmjOx1qj60h7LUwVvzg47HCSVmyjN6KCfAM+j5wo26Gh1IfT77daDGnN3Rcky/6SKPt3Ny94mw9tlbXlfFPZDoSQgczKOABmzqvn0KeaAdbyZVmGfOs6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439496; c=relaxed/simple;
	bh=hLoX2IbM9Dc7g8XZC4sIIbm2xI5YIG+DCSbPVcZQL2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/cTOhySI4FVhA74HuSJEIUzlncIBlKDqF9IvEibqoRVpXv/CUAM1qr17/1AjoMIZqkbeHQucMzE7lYSMUWNL9lbo5ar/Ratm/eZAcP+bfJslxtcVf2R25SPyWtkMgT0IURRvV1XClqqoRZUNRZeQJIcyCtVoRawJqftbXXRTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CN7y9waX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717439493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NbybIFAPNiJYTP2dPOGJz7xcoG9uvl5NWDzivsSBGLw=;
	b=CN7y9waXuCZqcshnmSuyD2bt4kmj83OpahUT3h6I/al5dkMQu9rPLrbL6cnFjz3k4WgpEu
	YeKpE5/DEYkOGhQLjIOh1AWIR9PZ9Ng92zoG7Od91YV6YDOgmEbLlCBVwgxe2vPXmOBjBk
	3Z1/upRqhPe5GcJeiRJ08qOSki+wkrU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-gdLL279nNteQGXOeK8LKTg-1; Mon,
 03 Jun 2024 14:31:28 -0400
X-MC-Unique: gdLL279nNteQGXOeK8LKTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 917AE3806703;
	Mon,  3 Jun 2024 18:31:27 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.112])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94870105017A;
	Mon,  3 Jun 2024 18:31:25 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] selftests: openvswitch: set value to nla flags
Date: Mon,  3 Jun 2024 20:31:20 +0200
Message-ID: <20240603183121.2305013-2-amorenoz@redhat.com>
In-Reply-To: <20240603183121.2305013-1-amorenoz@redhat.com>
References: <20240603183121.2305013-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Netlink flags, although they don't have payload at the netlink level,
are represented as having a "True" value in pyroute2.

Without it, trying to add a flow with a flag-type action (e.g: pop_vlan)
fails with the following traceback:

Traceback (most recent call last):
  File "[...]/ovs-dpctl.py", line 2498, in <module>
    sys.exit(main(sys.argv))
             ^^^^^^^^^^^^^^
  File "[...]/ovs-dpctl.py", line 2487, in main
    ovsflow.add_flow(rep["dpifindex"], flow)
  File "[...]/ovs-dpctl.py", line 2136, in add_flow
    reply = self.nlm_request(
            ^^^^^^^^^^^^^^^^^
  File "[...]/pyroute2/netlink/nlsocket.py", line 822, in nlm_request
    return tuple(self._genlm_request(*argv, **kwarg))
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "[...]/pyroute2/netlink/generic/__init__.py", line 126, in
nlm_request
    return tuple(super().nlm_request(*argv, **kwarg))
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "[...]/pyroute2/netlink/nlsocket.py", line 1124, in nlm_request
    self.put(msg, msg_type, msg_flags, msg_seq=msg_seq)
  File "[...]/pyroute2/netlink/nlsocket.py", line 389, in put
    self.sendto_gate(msg, addr)
  File "[...]/pyroute2/netlink/nlsocket.py", line 1056, in sendto_gate
    msg.encode()
  File "[...]/pyroute2/netlink/__init__.py", line 1245, in encode
    offset = self.encode_nlas(offset)
             ^^^^^^^^^^^^^^^^^^^^^^^^
  File "[...]/pyroute2/netlink/__init__.py", line 1560, in encode_nlas
    nla_instance.setvalue(cell[1])
  File "[...]/pyroute2/netlink/__init__.py", line 1265, in setvalue
    nlv.setvalue(nla_tuple[1])
                 ~~~~~~~~~^^^
IndexError: list index out of range

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index b76907ac0092..a2395c3f37a1 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -537,7 +537,7 @@ class ovsactions(nla):
             for flat_act in parse_flat_map:
                 if parse_starts_block(actstr, flat_act[0], False):
                     actstr = actstr[len(flat_act[0]):]
-                    self["attrs"].append([flat_act[1]])
+                    self["attrs"].append([flat_act[1], True])
                     actstr = actstr[strspn(actstr, ", ") :]
                     parsed = True
 
-- 
2.45.1


