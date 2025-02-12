Return-Path: <linux-kernel+bounces-511188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD3EA32773
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4705188BC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE644212B1B;
	Wed, 12 Feb 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tf0qqWKO"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359CE20F073
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367724; cv=none; b=IBqw5aL0NSW6TZAvr6mdCApE0xk6hwLCWYR9lU0OHWUur/YmozXfX5sPzUPAugDr21EFpkeF922KY3vxqWfaZuyRIzjZBvAVooGFJoFOM8olkhHm5xg+ij4q9qhZz8Elb1fkyQ30ivPyYndtbSD7qqpDpmqKBteM3ODfCGBbIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367724; c=relaxed/simple;
	bh=7h6nbFnzFOLt+RWCH5AbtMdfobMx6uMJQ+/GW3rjNHQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HC9z3N4uu8TwjCFvAYc015foLoZi+Yb7xmGKltMcqY0dm/GB3vdyBDsZH3I9LFBmy1BUHP71QQmXvTm5tPXPgoVlfTU141/JMZG+so70Ik5ri7qAO1QsHY5VDMcT6BvvqG+LLEwftoeh1j5L1EA3aWbI98b1WNUEXFnZw725GpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tf0qqWKO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dcdb56c9d3so10815758a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739367720; x=1739972520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CiPPwWHAckmQZTxpa+xmoPK+TKz+hzKWUS2Ki/RrKBY=;
        b=tf0qqWKOCPdHFeTouhdCNfqMdXM62rqIIVelxnjxAPdmmhzshZs38aLfAZtN85B0sG
         dgLWvuXg90S53hSVVIlmCGwmovdaqjSrXPXrfkF4pAE+3287z1h21K6D5a++9KpNwLon
         V+WBPKihByguP+Yl99d++KU1WRA+qcLbweZlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739367720; x=1739972520;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CiPPwWHAckmQZTxpa+xmoPK+TKz+hzKWUS2Ki/RrKBY=;
        b=IKRt49o6gcCBB6ZmZR4RYj2Wv0RhMDGMSZF5Bm47uyr1iOG2xTInpO1mopurL/Ym5D
         ijeZkd7zEw3jkxmhvJypjymI53brCmSMZ29Z4IeFaoVrzO64INiw+gyn9Mc8kFqchkgW
         ih3WaNbrhPLrApuGymSNLrT0oQZ6Wm3okatL3hJIJv17j//cFTWw+8BgejirhSLs78bv
         H+fvm/imJ6I/WJ73vD9aMEfSEe4LsK6qMyTnLXrT55LWPyBQkpfKAGEu77PZ32c6r/aE
         mX4fxzjzejIQVd57xk9ximcy0zqTggUeNHNgBLA1PMgDAQjSLizfloL9Ts5yJaySlZpt
         ObPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeEazgJNovJjIgic9aWkKUyNGeROnsSO8xldcb2R69L9HXe75wfqhNvrbOQnFgILVOt2ddxZp524Rnrb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTkM3IXM+IczHY8DYw26jedSxrkrXgEB13mi619A05mY9JCLBS
	HUyl9Pj5VvJbLspoib5cAGzC7CCNBKjuOfeVgxPDWqeFN9RAirjrpHETfEjH+CVgO7DePdewlvF
	/QLsR/fyOzAgrRG8LK+O4Sfk56hZ+mgJJ9GCzEQ==
X-Gm-Gg: ASbGnct5nly/27xvH2qprzx0aJfwascPs7vJOb1jPjioBiDvDv6jZ6+CCo8PLNR8WHT
	wD5lhhWf4tN5E880ZkpNhwd1xRGflRLZ9mbxf8zFdha4xgy/hJViwZ0nOUpZ6BQjG7qC5yVs2y8
	8fwIX+uvSQe87622VhzFsZklkr
X-Google-Smtp-Source: AGHT+IEdAA4vYWE4f6Jqe5kfoXPBf8sLR14CrtIsQmKMdovKf9+A7oyaNsjV1HVscFoUluPDJ6oVMDtmO0huBxs8zNA=
X-Received: by 2002:a05:6402:2088:b0:5de:aa54:dc22 with SMTP id
 4fb4d7f45d1cf-5deadddd507mr6946407a12.20.1739367720462; Wed, 12 Feb 2025
 05:42:00 -0800 (PST)
Received: from 155257052529 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Feb 2025 05:42:00 -0800
From: Joe Damato <jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212134148.388017-1-jdamato@fastly.com>
References: <20250212134148.388017-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 05:42:00 -0800
X-Gm-Features: AWEUYZnEliqL8EWyyXri7CgDbBmA6yJKuyWcDbYIfwZ4SEiiHdkwBqv8IjRtz70
Message-ID: <CALALjgyPqYGEw2dzi-AN6oB4jcQUt9e890=FA9+FPyV6=dXbaQ@mail.gmail.com>
Subject: [PATCH net-next v7 1/3] netlink: Add nla_put_empty_nest helper
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, stfomichev@gmail.com, horms@kernel.org, kuba@kernel.org, 
	Joe Damato <jdamato@fastly.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Creating empty nests is helpful when the exact attributes to be exposed
in the future are not known. Encapsulate the logic in a helper.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
---
 v4:
   - new in v4

 include/net/netlink.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index e015ffbed819..29e0db940382 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -118,6 +118,7 @@
  *   nla_nest_start(skb, type)		start a nested attribute
  *   nla_nest_end(skb, nla)		finalize a nested attribute
  *   nla_nest_cancel(skb, nla)		cancel nested attribute construction
+ *   nla_put_empty_nest(skb, type)	create an empty nest
  *
  * Attribute Length Calculations:
  *   nla_attr_size(payload)		length of attribute w/o padding
@@ -2240,6 +2241,20 @@ static inline void nla_nest_cancel(struct
sk_buff *skb, struct nlattr *start)
 	nlmsg_trim(skb, start);
 }

+/**
+ * nla_put_empty_nest - Create an empty nest
+ * @skb: socket buffer the message is stored in
+ * @attrtype: attribute type of the container
+ *
+ * This function is a helper for creating empty nests.
+ *
+ * Returns: 0 when successful or -EMSGSIZE on failure.
+ */
+static inline int nla_put_empty_nest(struct sk_buff *skb, int attrtype)
+{
+	return nla_nest_start(skb, attrtype) ? 0 : -EMSGSIZE;
+}
+
 /**
  * __nla_validate_nested - Validate a stream of nested attributes
  * @start: container attribute
-- 
2.43.0

