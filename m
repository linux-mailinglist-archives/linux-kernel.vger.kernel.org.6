Return-Path: <linux-kernel+bounces-223612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C818F91158A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707F91F23048
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48D914F13F;
	Thu, 20 Jun 2024 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fzKJTPJa"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6914F9CA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921963; cv=none; b=tBdImazlShAkcZ6PleLgytqo92ugbAtITfKAZC4qsDPmTnNqBombNwTVqNlJ7wGkSRZmRNqWgfIZ+2T8rR+VHKuSjtPVOAeXNjaxbOU6sGXyrG/MFwekpX5DHlxGqOAUeEKZQxVX6J5ewICL+wTP2ZN9I+GNqmYyi6oTXiNZaJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921963; c=relaxed/simple;
	bh=32x+O/uigML8NJ7XRYMJBXLGcM/DNjaft/fQ6ZGj9FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgDNUhtSVIQ5KiyB6jz/9JSzYRMUb1KBAY/nxAPVriS9ztEZVbmlJE7lrYag8THgyAAA1hjkbHufH0l6KGXYVDUG3CyzSGal6uIufWFaNhLoPyaNoI/acboQEZpuTOcymimkahK9f5F64tw8SBhyk7HXw0jYpI02+RDsX0TKBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fzKJTPJa; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48c3402e658so498161137.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718921959; x=1719526759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl7TiTwQUumMiW4m4cKincFWubuOSv6Mg3YKWODD3jc=;
        b=fzKJTPJaicBERd8CWyHAtXq4F6oyMmqjLDw3hac60JWvELF32YXdSTFodn2jYvrkwC
         MnJVGDhyShORGOvcZGkY0+NfsafZ9eh0tdWDS28lJ+JW5kRzPNfezlG0m9zk9+C7C1M/
         tyU6s+i6BUSlL9JNr12BVt5GrXMaBsGWEsK5eKdvw8KlBPAObgiEh9QBCEvrimnojV3D
         zS2euioS7ZrlsVpv7zhFujo7C0a4n+GeMZ51BIqG44/GksMw0wF0ozJtYzihen66au6P
         kS7p3TMgW17CJsvs9ZgkxnHepfcohTivEGFQ+YzruZZKG4+KPfttHI4K+WMPJQCwXNr2
         uB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718921959; x=1719526759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl7TiTwQUumMiW4m4cKincFWubuOSv6Mg3YKWODD3jc=;
        b=N7ZnaQlHtSrlY6le23lsrL9n5PKpzXKR32iCPUTmKihWk1uIu+sjx1LHb3fu4r5rgp
         JS+I4c+bbR/b79hf9AebCdy6Pikx15dc8ygRf07wB0GObXNNNTy923XIKqb0/LgKWRlq
         yfGRMYiJsCTLkhiM+wNRZxoVx1pjig1X4aXZu/yDV5CDK5PmEqcRI0KCEzAvY1jqk1UF
         ZytCjEYqx8vi/JfztVJSqImk5zdJdfldaTMAGizI/Sq89tnl0qNt5+1QxwD9Yvda8w45
         xfiQcYdqzDmlfZZXcXvPLcwR1gx/O6e3UPdBlzaADbVtHUP41gGQieF2KW/bTQbXjHz8
         RiDg==
X-Forwarded-Encrypted: i=1; AJvYcCVlKw8sNgWIm9TCc9thvxIPMYtpiS8hffA/rBbYg/cmktU02XgKDWeOCRPzFXSC+iCzRWPYY1+Xr6ADBg9b/nAMiv3wreY8LGmplX5H
X-Gm-Message-State: AOJu0Yxmacr47I1dL8qEEJeaYmLO+R3fiX5aR+5XGt+L6k4jFe0FtL36
	gj78slRFZ7rqKKcUR4fsmxZTeqmZz66kgwxdL7OFzThNAbD/0hA84WlUvKlwyR8=
X-Google-Smtp-Source: AGHT+IHjgSMTq2xDbJSSKDE+rkyZk34gRQgY7afYxp/41reT7sQo1zzV37XQCPuh2Rgngca8xB4+iQ==
X-Received: by 2002:a05:6102:366a:b0:48f:135f:55ef with SMTP id ada2fe7eead31-48f135f5696mr6983814137.15.1718921959364;
        Thu, 20 Jun 2024 15:19:19 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:19cd::292:40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce92033bsm17250685a.87.2024.06.20.15.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:19:18 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:19:16 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 3/9] xdp: implement bpf_xdp_disable_gro kfunc
Message-ID: <e31ce8f27a672e3c0def5a586a9a10f1d71e9948.1718919473.git.yan@cloudflare.com>
References: <cover.1718919473.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718919473.git.yan@cloudflare.com>

Add a kfunc bpf_xdp_disable_gro to toggle XDP_FLAGS_GRO_DISABLED
flag.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/core/xdp.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 41693154e426..d6e5f98a0081 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -770,6 +770,20 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_xdp_disable_gro - Set a flag on underlying XDP buffer, indicating
+ * the stack to skip this packet for GRO processing. This flag which be
+ * passed on when the driver builds the skb.
+ *
+ * Return:
+ * * always returns 0
+ */
+__bpf_kfunc int bpf_xdp_disable_gro(struct xdp_md *ctx)
+{
+	xdp_buff_disable_gro((struct xdp_buff *)ctx);
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(xdp_metadata_kfunc_ids)
@@ -799,9 +813,20 @@ bool bpf_dev_bound_kfunc_id(u32 btf_id)
 	return btf_id_set8_contains(&xdp_metadata_kfunc_ids, btf_id);
 }
 
+BTF_KFUNCS_START(xdp_common_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_xdp_disable_gro, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(xdp_common_kfunc_ids)
+
+static const struct btf_kfunc_id_set xdp_common_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &xdp_common_kfunc_ids,
+};
+
 static int __init xdp_metadata_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_metadata_kfunc_set);
+	int ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_metadata_kfunc_set);
+
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_common_kfunc_set);
 }
 late_initcall(xdp_metadata_init);
 
-- 
2.30.2



