Return-Path: <linux-kernel+bounces-343020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEC49895FF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 16:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23451F220D2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E94017BED0;
	Sun, 29 Sep 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ut6M0K6c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9105680
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727620946; cv=none; b=m+mIG3FJrUmCuoeCXoGI+G5rfQCCCvoMn8q5069T20z6OQoekNuPEh8+jz17tzAgzFBsUPNb57oYmSf6RGRIJckBrmsauy/Zo0cpcxxK3AYu+SMSDTGp1GrCi1TEd554O48ZauZTcWMZPRUQ5RI5uH94C3WEvoIjfLAjxU6Dve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727620946; c=relaxed/simple;
	bh=YatX/cZk2OijMoQ5PN15nFDx9HccMY1rvaaBj2LpHoI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tVhfN+bKMCag8rRyI/PVJYzYH+KaoHtJgSi4uikqXxcAVSdfMuk8ZsvBzwKDsyZniCqQtn/BPNBFc3DYJNVLUmA1zTS+vEEYpoK8KXLr3qnk285sXrwLB9v4zubUjtsD5HKOzf5vlc7+sDSac+Ta+bp0ccyoWhXY7uHNlQO3kk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ut6M0K6c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727620944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=YatX/cZk2OijMoQ5PN15nFDx9HccMY1rvaaBj2LpHoI=;
	b=Ut6M0K6cyVuhEXXw7weBonzbOq9uXLeemjgc5JswdbTEH6PpgUWxRV7eejJHN6IEtykhSK
	GLtc1V9tIRihINiTZwJsR2vxwa/7WYhsIyqaWQu7zavjfR0p0ao3S7VOG8u82LTHaqw3QU
	ko94XEqoO78DiiNviIKxXWYwkDojqEA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-JUdHGhsPMoWHFXMnOnuLzQ-1; Sun,
 29 Sep 2024 10:42:20 -0400
X-MC-Unique: JUdHGhsPMoWHFXMnOnuLzQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E853190ECE8;
	Sun, 29 Sep 2024 14:42:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 113671944B22;
	Sun, 29 Sep 2024 14:42:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Sep 2024 16:42:05 +0200 (CEST)
Date: Sun, 29 Sep 2024 16:42:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Liao Chang <liaochang1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/7] uprobes: deuglify xol_get_insn_slot/xol_free_insn_slot
 paths
Message-ID: <20240929144201.GA9429@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello,

No functional changes, please review.

I'd like to push these cleanups first, then I'll send some optimizations
on top of this series.

Oleg.
---

 kernel/events/uprobes.c | 111 ++++++++++++++++--------------------------------
 1 file changed, 37 insertions(+), 74 deletions(-)


