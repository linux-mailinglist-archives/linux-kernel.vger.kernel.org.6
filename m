Return-Path: <linux-kernel+bounces-181830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D98C81E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9461F21351
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 07:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0AA36AF3;
	Fri, 17 May 2024 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiDohHNl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C52BD06
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932630; cv=none; b=GaWLK9Bg7ynUppUWruwJexRCy0okpsWm/SXAUlDwW4OrpltZsGOvpN3YJKuJ2F+h7ILD3p9zSCr6lIc9lYXdeITweuV/RHXzanAGDltHfL9tR+wYt+cw9Ebw+QPXZrpNlPCBL8e4TusoNbVXOFQNeqxrB/cc/5iyyZRcJgnAO/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932630; c=relaxed/simple;
	bh=z3AwgBqlBUWCWye022RyFCz2f5ylMRfnUjZq4yLjspw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEE7yzI8F2BZisvayvhc4xWUjq8ZiahA3ptc9ulKhguS2KdzL1aALq232gxeLydvLg9l742e1pjlfSkXcoJ1KyJ2PhAEg9gYMVd8jK+E+oufeqz3ESwgZc9U23ODK/vINruQBRC6csAzPVdiowgcGmT63+I4bdd2JnI+WsKya58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QiDohHNl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715932627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EsCKnSd8SY21HTUjj+hbf4r5AF/uUdXnBR6lfnTM7uI=;
	b=QiDohHNl2UxsSvd1HKGiKdzbEqzbGN8sc7SAsMhEoAiyji3AqmR6lw4h8+eh68X/yuSocA
	ZTDj0BqHjmlkg10TtVXXcHAWS6qjlX+P5NOgFK/hNBFsEeJm3Y6VpoeU9RbcDzF5kxB0Mj
	NH/F7MXdc255m94UFkWVTHmSRJaCDNU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-vWFqYgpbOEGkJTvFzMf7zg-1; Fri,
 17 May 2024 03:57:05 -0400
X-MC-Unique: vWFqYgpbOEGkJTvFzMf7zg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 765E529AA3AC;
	Fri, 17 May 2024 07:57:04 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DD402740F;
	Fri, 17 May 2024 07:57:02 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>
Subject: [PATCH 4/5] powerpc64/bpf: jit support for sign extended mov
Date: Fri, 17 May 2024 09:56:49 +0200
Message-ID: <20240517075650.248801-5-asavkov@redhat.com>
In-Reply-To: <20240517075650.248801-1-asavkov@redhat.com>
References: <20240517075650.248801-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add jit support for sign extended mov. Tested using test_bpf module.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index b9f47398b311d..811775cfd3a1b 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -676,8 +676,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 				/* special mov32 for zext */
 				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 0, 31));
 				break;
-			}
-			EMIT(PPC_RAW_MR(dst_reg, src_reg));
+			} else if (off == 8) {
+				EMIT(PPC_RAW_EXTSB(dst_reg, src_reg));
+			} else if (off == 16) {
+				EMIT(PPC_RAW_EXTSH(dst_reg, src_reg));
+			} else if (off == 32) {
+				EMIT(PPC_RAW_EXTSW(dst_reg, src_reg));
+			} else if (dst_reg != src_reg)
+				EMIT(PPC_RAW_MR(dst_reg, src_reg));
 			goto bpf_alu32_trunc;
 		case BPF_ALU | BPF_MOV | BPF_K: /* (u32) dst = imm */
 		case BPF_ALU64 | BPF_MOV | BPF_K: /* dst = (s64) imm */
-- 
2.45.0


