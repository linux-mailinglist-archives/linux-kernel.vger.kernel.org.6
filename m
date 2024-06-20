Return-Path: <linux-kernel+bounces-223615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 194AB911593
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92E21F2322E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15128154BE7;
	Thu, 20 Jun 2024 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HtLvSN0k"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B18F15357A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921970; cv=none; b=D4CX2tl6VYXLhhwJ94XUVlmMJkAqFjegIJZeP4x0CRvYNX5kWNNTHReGTgaJyOHXnRbj9JaIgN3DWUIzwQLJ7gJUUa8qhMoIalUGA/9qGUDrfVxR0hCuTFewd0FGqz5GkTd8bEtFBixILoIflP8oDApKwontg25P4Wv2ngV48eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921970; c=relaxed/simple;
	bh=AzuBu/nYd4noTnvcgiEnKbx32LQxb17oyJeVJ8ndhOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F38rDuhU7nZcgddfRyoTXNGLp48CKNrNrtArgIFf5ajZSh04e80kDFB1QDbjVTQZbvmlNMByR6YyTYMEeeF0GOGOPsfFCNKJiA7KyVE53zTOMMts+dfveC6BhHItTiiBuFpuQCFRlFDdJ+wOj6FJ8jndGBh7Qo/nLrc5W3sDNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HtLvSN0k; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-797f1287aa3so80821685a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718921968; x=1719526768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W5407+z82JKtvMOrobuAn0ratWMuTj2tNIkXM8wd5dc=;
        b=HtLvSN0kZiZXE+JFmxRY6iFK9eTRGriwaSfVKvUbqKH/77dcW3jOYqrOGVl1Se/S4/
         ykpF23sXHvepgwQlxeWEdrOtBn7kBt3W+weZG5JptvKINIo8U0AzJMTZeXoVXfplDqUG
         y2kwz7dDkXCwSlzh8jidcVYK5pQaRvB+Z/GQtW/Xc3/iBNkVcGJURTizb5GypurA1+g7
         MrsamVqDuDS2E05B6xUN8hCcB6HtZxEJ1duQ+YqQ7ryLiskkaB1m4alP63zASyj9rLMk
         oUox0b2qJi8bg27fBV0/KNahtmlXWZ5JDtGiOhlJuDfLspp9rD4gSNeZj/Bj5rkyyze1
         ZYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718921968; x=1719526768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5407+z82JKtvMOrobuAn0ratWMuTj2tNIkXM8wd5dc=;
        b=FDoZPy8E/ddUXx2QUyJuSCT4EnoKPKDyJ9VEv87iSv9I6w5JmR23H45XBBqghTQPWu
         cNowRS+Q3g/Ncqqx8pZZlAQuWqPJWSqEPf8nt/OT2AoK899rz6XFiugyY6hDmPJkkNLh
         V4z4+qp91C18U6uJKFkM1jRNgkqrpFVrJpLca48FfxnJUib4mIrFgJoqfWuL4a6alDQ5
         lh9c2hn2jwHtCV4u4ALbhl2e4jkW+cYHfojVnzdTmkqcmMRTRi71UVYih2dD+eNctN5C
         dbs84Nraqpqcuk9T5pmk6l+Ldh5JM86tQpmuaiwY6ZUNW24NmYGvSJFFKUkUlaj8xUZm
         juuA==
X-Forwarded-Encrypted: i=1; AJvYcCXK7K5hDpk3wWWceW5NY70j3zTLXqWf3herOV6jXTGd6BaKGnVfKZE2SkDKRXhshEFY4J1oc9mpHYubzkAB8a1kn7sVizJDhtpH9BP5
X-Gm-Message-State: AOJu0YzXLslSWP01XxoGLI39Vm3RTua5jqvi5fBpKP1T3GlDUJCsKwxp
	3tUrcU08VZGPgaqP6sJcMaEfRCcWol8mHJ0UMKKdBWtK9ZKcZUSVOZkKTKbY+fE=
X-Google-Smtp-Source: AGHT+IHgBBxlD+qDZaVaOqDtQcbNvXT8j2u4+YOx1AyLUR2YCxxWQ0XJoivZxNhP3Jz56mudjlNUSQ==
X-Received: by 2002:ad4:57aa:0:b0:6b0:738f:faf1 with SMTP id 6a1803df08f44-6b501e3f1b4mr65791656d6.38.1718921968099;
        Thu, 20 Jun 2024 15:19:28 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:19cd::292:40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ecfe6d9sm907396d6.11.2024.06.20.15.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:19:27 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:19:25 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC net-next 6/9] veth: apply XDP offloading fixup when building skb
Message-ID: <b7c75daecca9c4e36ef79af683d288653a9b5b82.1718919473.git.yan@cloudflare.com>
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

Add a common point to transfer offloading info from XDP context to skb.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 drivers/net/veth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 426e68a95067..c799362a839c 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -703,6 +703,8 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
 			stats->rx_drops++;
 			continue;
 		}
+
+		xdp_frame_fixup_skb_offloading(frames[i], skb);
 		napi_gro_receive(&rq->xdp_napi, skb);
 	}
 }
@@ -855,6 +857,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen)
 		skb_metadata_set(skb, metalen);
+
+	xdp_buff_fixup_skb_offloading(xdp, skb);
 out:
 	return skb;
 drop:
-- 
2.30.2



