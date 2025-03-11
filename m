Return-Path: <linux-kernel+bounces-556026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B627A5BFFA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706B03B3F87
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A3C255E3E;
	Tue, 11 Mar 2025 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XTFMkfjH"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA2221F3C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694585; cv=none; b=gnfm24ly8zAtM8/s+/RstA3g8U7bx6qwoln9KIPzwXYFmt1ngIm0qNU5wU4G2lJUOph0lqdMLN0REBpYEqQwN9fZAAfVJsVzQa3cSp1d0KeQ29vkXurrUJyHeVndUd0MSxGB28Wkj468fbNp1jbxixgElMezQu2eR3WCQfLys/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694585; c=relaxed/simple;
	bh=QEzlu7tBYZBQfQErYYPjmA/2wV/XnH2Uoqtr0IRVZR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W88PbfrFIRaW/TyOhKHxSs6JhK0xEqjqccK9mnSh/pKG7pk8hd6LRF/euampl3JKHNPWtV5k6sC7hlHTLA6gN7QnHd5jA2W/K5VdBdB15t5W4Q5qrMmy5qsYgm4+vTNRAw/uIOaksFnsIiBHHvxi7O41ZKVKI/gL9veIjjIzpV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XTFMkfjH; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so2996971f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741694579; x=1742299379; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GZd8g9oClFpKacY11uhhEhq1YIVwvdzwKauFBaAciSw=;
        b=XTFMkfjH/XyJFnWWFFL0OuXuptriRQaq16UQ1ihtw72XjdYYYuV5VycRvYP8pPE4Fi
         w9MPAyv0Mj2XNFmlBN7PX+O9Muj3SJ22pdjcIW35sfpWnTrk5xEWHxsQnByz3qpOJ18p
         KHQJhx/f4UN+GsI9n8/7v1OAo3fpO3qb+tGtbHS85tgNDFmUD2Jaeggac5ao6zEOb/uX
         ccIS90ZRHdiK+yJ26XYLJRkpNE3BoEB7oDlViNUfa7f/MM1WLnrE6MB3BcRiwlWiiIAM
         tu+wtwJ7GTCiCUyNlVKlBgOzEkfZh7c0/pVQJRoZgTiW4uxqBMRoGaMgDSa4pf3+WibA
         WL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694579; x=1742299379;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZd8g9oClFpKacY11uhhEhq1YIVwvdzwKauFBaAciSw=;
        b=ElCoFRr67RBqAI98IR7tABq1whJ/O8TrYFtEQQJyfkTnC3hunANmIoy5kPHqc5WXjH
         Cavwen2qwH/k7YjbuROfhRCvc/qIfg3sJQguww51kY46ZJG+V7v9uhQOGGVVpTVblCdY
         8xMj+PRJtHgOX8RVSXU0WPNe6SbPkBYF/WCA0ixYGaotKB/blFzjM8W8KRO3srKxClws
         TulOOqb48M806UyvacfuvzLKPgHbHGr+xbEGv6eEgwPoB+luhmaHG6lCog84pRlLO+gW
         1hTfsMlQ+Ap5Wej2iMH/eZxMQe1HyjWRbzWa4R4lizeVOm8SJvQj2tkTOQB0BhXDm0H6
         zRCA==
X-Forwarded-Encrypted: i=1; AJvYcCUj9BVHh47RtH8ba3wALz6vCAf8kF+1fQu8Vj1qZwlcPnTrKrctuqJLC/X9VHb/E+WBPxu0k/+3lza2LXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJmJA2Tc8fLMtPRKdK5E3i8agbawovjcGejclsVNhg2V6s+zP
	o4R/c45s70494mllr7Miu6ICwOYiCRhh407sYoJXf2BnLr+DwGm+r2JBx6VF/fU=
X-Gm-Gg: ASbGncvWRxtzZYxgJyQE8HM8lW5NwxJQTyJ5AI9KWVM1xZZq2n/WMZpmQj+rel1eVSA
	0F8GRzFOj0cWjX3jcFSZgAMQaa1z/7JiW2oz0fw207ZCoeR1eqDzAYNrNaDx7JhKigOHZfHzuL8
	qpBayfYdeZh1D3T1T6yV61VWJq/vzsfSqtsQo+fkWaOxzS+cHLEBxA8MXJRTs81BClmir6FTzZT
	+ehRtumfmDJ4ln3fW5aTumtGCn39cRCRvhmjKQh93jVJp41VrD/jKWVNwqo93Bq6+Kau4HrkvMu
	Y63TlAiVaFTrfEyl8cDJ99qNV4CUlLKW4j3zMvwB3Q==
X-Google-Smtp-Source: AGHT+IHczIUM3+sWO+uj6v6xvF08SLG0NXd+dJffFBEyZKS2O1hR3ger+1bkJG79UzNlIMXZ0uUmFA==
X-Received: by 2002:a5d:64c3:0:b0:391:31c8:ba58 with SMTP id ffacd0b85a97d-39132d16dd6mr15325986f8f.10.1741694579308;
        Tue, 11 Mar 2025 05:02:59 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:52de:66e8:f2da:9714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceafc09d5sm110537605e9.31.2025.03.11.05.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:02:58 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v22 00/23] Introducing OpenVPN Data Channel
 Offload
Date: Tue, 11 Mar 2025 13:02:01 +0100
Message-Id: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADom0GcC/23SzW7DIAwH8Fepch4b2HyEnfYe0w4QzJrDkiqpo
 k5V331Opi5Ug1swP/9xxLWZaeppbl4P12aipZ/7ceAPgKdD0x3D8EmiT7zRgAStpAQRtRiX0yC
 IF5rOeh2g4dOniXJ/2Vq9NwOdxUCXc/PBlRhmEnEKQ3dcO91rL1+hH1Z57OfzOH1vd1j85n/Tl
 P1LW7yQIoRIPgGYkMzbeKKBK8/cbktZlCwomJ0qyTa2zqB0zkVyFatK6wur2CbS1redwwC1XNg
 tFD+IC2wBfc4OMWZfy8XSFuMqZGtdjjqStZagYnVpyztrthRAY5eV1aqWawrLM+7WsEWlCbqQp
 FVtxdrSlrl2tYRSKmXQtlix7m4NH5KFdWy1i4DOkbGqZtvSYmFbtipLmaLvICZbsX63j/Ou76q
 1yaSQIWgX/luQhQW3W1jflceMFlHJFvWjvd1uP1cSP79fAwAA
X-Change-ID: 20241002-b4-ovpn-eeee35c694a2
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 steffen.klassert@secunet.com, antony.antony@secunet.com, 
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6070; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=QEzlu7tBYZBQfQErYYPjmA/2wV/XnH2Uoqtr0IRVZR4=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0CZrRYlFTh09SzBbDNRUbwD1uexzxjJRZaLYQ
 sc17lbBxWGJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9AmawAKCRALcOU6oDjV
 hwsPB/9fMq4im/xQXNiQjrnnCxhEWYzCR8sjrELny+oRTjushSk72igVxsd3GfS8BpxNA+Cp03w
 H2eBMX04KSa5nscCe57JQJiF9toqunOOXZE4zC/4FhJ18Lahmc5m4pcc/vqsMdrLycHbqjM4Xoo
 3wkWCrTZ3fL/rzqf64d8aW2VRZmtRjI1Pcsp2/IkPE9Q+gC49eYe8VpUQS/rNckae8QliMKxHpK
 MX5DiSC1k3ekTRWsm4zhBa8txA8/zG/QPrB/Xj2RvGB8gXNbHEj+pKRAT+Mq1IyQ7pFi/C8i7H2
 +WdMdRWb+E6xIXtnqbI2gtC1GNE8O6xkx9FaJoQGjrOK0Jls
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Notable changes since v21:
* accessed crypto_slot->primary_idx via READ/WRITE_ONCE
* made ovpn_aead_init() static
* converted link tx/rx packet counters from u32 to to uint
* ensured all u32 NL attributes are read by nla_get_u32()
* ensured all u32 NL attrivutes are written by nla_put_u32()
* reset cache upon float or local endpoint change
* dropped check for delta > 0 in keepalive worker scheduling
* improved comments in update endpoints logic
* converted local_ip to void* to avoid useless casts

Please note that some patches were already reviewed/tested by a few
people. These patches have retained the tags as they have hardly been
touched.

The latest code can also be found at:

https://github.com/OpenVPN/ovpn-net-next

Thanks a lot!
Best Regards,

Antonio Quartulli
OpenVPN Inc.

---
Changes in v21:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v20: https://lore.kernel.org/r/20250227-b4-ovpn-v20-0-93f363310834@openvpn.net

---
Antonio Quartulli (23):
      net: introduce OpenVPN Data Channel Offload (ovpn)
      ovpn: add basic netlink support
      ovpn: add basic interface creation/destruction/management routines
      ovpn: keep carrier always on for MP interfaces
      ovpn: introduce the ovpn_peer object
      ovpn: introduce the ovpn_socket object
      ovpn: implement basic TX path (UDP)
      ovpn: implement basic RX path (UDP)
      ovpn: implement packet processing
      ovpn: store tunnel and transport statistics
      ovpn: implement TCP transport
      skb: implement skb_send_sock_locked_with_flags()
      ovpn: add support for MSG_NOSIGNAL in tcp_sendmsg
      ovpn: implement multi-peer support
      ovpn: implement peer lookup logic
      ovpn: implement keepalive mechanism
      ovpn: add support for updating local or remote UDP endpoint
      ovpn: implement peer add/get/dump/delete via netlink
      ovpn: implement key add/get/del/swap via netlink
      ovpn: kill key and notify userspace in case of IV exhaustion
      ovpn: notify userspace when a peer is deleted
      ovpn: add basic ethtool support
      testing/selftests: add test tool and scripts for ovpn module

 Documentation/netlink/specs/ovpn.yaml              |  367 +++
 Documentation/netlink/specs/rt_link.yaml           |   16 +
 MAINTAINERS                                        |   11 +
 drivers/net/Kconfig                                |   15 +
 drivers/net/Makefile                               |    1 +
 drivers/net/ovpn/Makefile                          |   22 +
 drivers/net/ovpn/bind.c                            |   55 +
 drivers/net/ovpn/bind.h                            |  101 +
 drivers/net/ovpn/crypto.c                          |  211 ++
 drivers/net/ovpn/crypto.h                          |  145 ++
 drivers/net/ovpn/crypto_aead.c                     |  409 ++++
 drivers/net/ovpn/crypto_aead.h                     |   29 +
 drivers/net/ovpn/io.c                              |  462 ++++
 drivers/net/ovpn/io.h                              |   34 +
 drivers/net/ovpn/main.c                            |  339 +++
 drivers/net/ovpn/main.h                            |   14 +
 drivers/net/ovpn/netlink-gen.c                     |  213 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1249 ++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnpriv.h                        |   57 +
 drivers/net/ovpn/peer.c                            | 1367 +++++++++++
 drivers/net/ovpn/peer.h                            |  163 ++
 drivers/net/ovpn/pktid.c                           |  129 ++
 drivers/net/ovpn/pktid.h                           |   87 +
 drivers/net/ovpn/proto.h                           |  118 +
 drivers/net/ovpn/skb.h                             |   61 +
 drivers/net/ovpn/socket.c                          |  244 ++
 drivers/net/ovpn/socket.h                          |   49 +
 drivers/net/ovpn/stats.c                           |   21 +
 drivers/net/ovpn/stats.h                           |   47 +
 drivers/net/ovpn/tcp.c                             |  592 +++++
 drivers/net/ovpn/tcp.h                             |   36 +
 drivers/net/ovpn/udp.c                             |  442 ++++
 drivers/net/ovpn/udp.h                             |   25 +
 include/linux/skbuff.h                             |    2 +
 include/uapi/linux/if_link.h                       |   15 +
 include/uapi/linux/ovpn.h                          |  109 +
 include/uapi/linux/udp.h                           |    1 +
 net/core/skbuff.c                                  |   18 +-
 net/ipv6/af_inet6.c                                |    1 +
 net/ipv6/udp.c                                     |    1 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/net/ovpn/.gitignore        |    2 +
 tools/testing/selftests/net/ovpn/Makefile          |   31 +
 tools/testing/selftests/net/ovpn/common.sh         |   92 +
 tools/testing/selftests/net/ovpn/config            |   10 +
 tools/testing/selftests/net/ovpn/data64.key        |    5 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2395 ++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
 .../selftests/net/ovpn/test-close-socket-tcp.sh    |    9 +
 .../selftests/net/ovpn/test-close-socket.sh        |   45 +
 tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
 tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
 tools/testing/selftests/net/ovpn/test.sh           |  113 +
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
 57 files changed, 10072 insertions(+), 5 deletions(-)
---
base-commit: 40587f749df216889163dd6e02d88ad53e759e66
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


