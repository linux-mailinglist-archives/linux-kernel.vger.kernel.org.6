Return-Path: <linux-kernel+bounces-181826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B34508C81DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D7CB21D71
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 07:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B905F21373;
	Fri, 17 May 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c87Vm4Sh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D917C69
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932626; cv=none; b=YerMBtrnovc3QJAdBKza0OQ3v14TeyfHSRKEhw+eKjFVIuRDW5qq6cE3euTf3G+2cMNLm1axEo+fFzo6j+kV6qeLFixIPiVBt01FzguTt80F6aWuMir4vR7CvUxn0EINgAU/RW79mdEy8JD2UjPMVhv8jqHbu3nodV1kDTItznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932626; c=relaxed/simple;
	bh=j4mDDIQXQY6Yt0ARbhylixXExzCaLztKBD5Eb//BJs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQQSvQNggGl73zbSftTiFPRFlfoWLmj/H6SRHlnrz0/MHfvGG+wY9W5ajivR4WhYTj6P1/0HVo4XDwKzjKl8b0Mv87O2un9uSWRoUVVc7hKaXyuhCqkH9EoqH8nqaEUWNq84hMcAeXljd4SiSVMTBDAFQjApQnBtrec31MeYaoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c87Vm4Sh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715932623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+jG2UN45Z0JvX/V83PsUb5yMQORYV9ShWj2nAq73LA=;
	b=c87Vm4ShnqlOAmVozSkjzhRgafpscyvHrKWYpdrDi9/Ns7lthkxXBTDTNRbsDyc9gprYRi
	xGpgr1g+ghs8Na+1iy69PGtYd+tgQnQn0c0AWzsA4Xs6WrsIsfazD0hQWdVAGK5WHwmlAN
	/xh0hD1asc8ixvCUvpj64labohTvUpU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-_AF1HgkKO6uhxaIdJBA8cg-1; Fri, 17 May 2024 03:56:59 -0400
X-MC-Unique: _AF1HgkKO6uhxaIdJBA8cg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19FD6800074;
	Fri, 17 May 2024 07:56:59 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8184828E2;
	Fri, 17 May 2024 07:56:57 +0000 (UTC)
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
Subject: [PATCH 1/5] powerpc64/bpf: jit support for 32bit offset jmp instruction
Date: Fri, 17 May 2024 09:56:46 +0200
Message-ID: <20240517075650.248801-2-asavkov@redhat.com>
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

Add jit support for JMP32_JA instruction. Tested using test_bpf module.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 8afc14a4a1258..3071205782b15 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1053,6 +1053,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		case BPF_JMP | BPF_JA:
 			PPC_JMP(addrs[i + 1 + off]);
 			break;
+		case BPF_JMP32 | BPF_JA:
+			PPC_JMP(addrs[i + 1 + imm]);
+			break;
 
 		case BPF_JMP | BPF_JGT | BPF_K:
 		case BPF_JMP | BPF_JGT | BPF_X:
-- 
2.45.0


