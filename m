Return-Path: <linux-kernel+bounces-574214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D854FA6E210
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 999777A2F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1BA2641FF;
	Mon, 24 Mar 2025 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MkI2RcP+"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B8143736
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742839728; cv=none; b=vA4xglOmzNtbH0M2N2t0Hz28Ug3u4SnwVMN25yK+V8XCVIOvmZFfT1ie9NQfNg3xpq/5Tu4ZWqsftww5rRPt8DzmvQbcM6RvziUIfAJ0es243w90LtMDls4AzmsMnfDQGvUnIYJo08rHZ0ko2pqdTHNW8utP+Ske3VmebKPXf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742839728; c=relaxed/simple;
	bh=Yby3f56rViTJ9JbwSWxl146JQa14s+wRsQx1v0NM8ro=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tAanGgtL1muDwHI7/vbv3pUvno/DFYqZCYXT449owa0uflopTK3mPPPJofQawBXPoBGC56X+Yr3cVfRgJo08YKe+iqljGg5zca0+REJyl+gWrNGeDQ9AB3uyl9k4p3mBPCJDql/RXftvC60ZLHUebHFty+vXozz/DlEghpc+du8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MkI2RcP+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2262051205aso53112745ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742839726; x=1743444526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xWkoJSSdlLuXq+dtU3xvK8Ugt8eoJsGkxgUOu39JxAE=;
        b=MkI2RcP+5H8xaumoNqCd7SLbqVUWHIZuB5joRlRWAQWTcOGUT3y9kYb15v+zZGkU4q
         tIaTjrYPFpynEdbbrPa8nsLA6CEWgNamVSE2WS+PV7i55vHtFYT8lhUb+3mcTQMJTZz5
         8RN+jowN+60B9Pt7ijFDZ29j/rNR+kUJQCyR+jZgkDDRpj81EM1Cj5pU5PRz+B2X7Yi2
         iHq/tU8yYi/Trjabsb2ZQPY9OHUErCdwyRsYY+3jINwnaRSCjGG2xBjC3gfmpke1e5wR
         ulhPsn533T/+QP0w3uvPXKebCjsFOhqKZzS/2NGUz33POz3RVg3w7r3x6OzEnua9QF+q
         mdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742839726; x=1743444526;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWkoJSSdlLuXq+dtU3xvK8Ugt8eoJsGkxgUOu39JxAE=;
        b=BLINitRYdlN0uMzZNqXykjsoWThC9DDBKuE2YoLR9ze42Rv1ZrKSZJh6hSpyrq0bYe
         4wnoOfwR7+0RhyXWSqtbLGRJ3IxOeS1b8UjxKvadzlov43LgXc2nhSRBQsG2K+eZzfHj
         NE3RVaFzePKlSOwkev7b+okll3yxgqfxpPfchvR4/Bq7+xwr01ftE0tpSGYNOkZaxezI
         lrR+0/RPs8cJOVlS53doNeT4vmFaRmLtTkus5c7gF9QAN7bhTAk1sNr6hlWMbiRt5dB+
         Y0IeEJHLz5cebZM2wVX5g/j1+p1ewOg/QYMoA83tSyThxbYyWvNPl5wtnD8OpwCgtqFI
         P19Q==
X-Gm-Message-State: AOJu0Ywch1JFZNL1zpgHxkmaPoqNMJRmgOYIOcSADeL/NqO4PbclEBa5
	doUlsorJd75XVle0FF+hjl/0Oc7Ol0LF7QQLH9PRxQj7I6rh6jCgVFvYSmaJCFPBBgZOVc4UFP3
	KlVuKzA==
X-Google-Smtp-Source: AGHT+IE5+8uUwsmyOC8Ih3yQ2DKmuHu53FhbOE4b4SUAhDKzfeIdRZMOkJdyXeJqhCa9zxyT/L/GY6jixo7+
X-Received: from pldv5.prod.google.com ([2002:a17:902:ca85:b0:224:13ec:ae57])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc4:b0:220:c066:94eb
 with SMTP id d9443c01a7336-22780da24f6mr253209595ad.25.1742839726144; Mon, 24
 Mar 2025 11:08:46 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:07:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324180716.1012478-3-ynaffit@google.com>
Subject: [PATCH v2] binder: use buffer offsets in debug logs
From: "Tiffany Y. Yang" <ynaffit@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	"Tiffany Y. Yang" <ynaffit@google.com>
Content-Type: text/plain; charset="UTF-8"

Identify buffer addresses using vma offsets instead of full user
addresses in debug logs.

Signed-off-by: Tiffany Y. Yang <ynaffit@google.com>
---
 drivers/android/binder.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d1aa6d24450a..994ae205aa07 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3261,20 +3261,20 @@ static void binder_transaction(struct binder_proc *proc,
 
 	if (reply)
 		binder_debug(BINDER_DEBUG_TRANSACTION,
-			     "%d:%d BC_REPLY %d -> %d:%d, data %016llx-%016llx size %lld-%lld-%lld\n",
+			     "%d:%d BC_REPLY %d -> %d:%d, buffer offset %lx-%lx size %lld-%lld-%lld\n",
 			     proc->pid, thread->pid, t->debug_id,
 			     target_proc->pid, target_thread->pid,
-			     (u64)tr->data.ptr.buffer,
-			     (u64)tr->data.ptr.offsets,
+			     (unsigned long)tr->data.ptr.buffer - proc->alloc.buffer,
+			     (unsigned long)tr->data.ptr.offsets - proc->alloc.buffer,
 			     (u64)tr->data_size, (u64)tr->offsets_size,
 			     (u64)extra_buffers_size);
 	else
 		binder_debug(BINDER_DEBUG_TRANSACTION,
-			     "%d:%d BC_TRANSACTION %d -> %d - node %d, data %016llx-%016llx size %lld-%lld-%lld\n",
+			     "%d:%d BC_TRANSACTION %d -> %d - node %d, buffer offset %lx-%lx size %lld-%lld-%lld\n",
 			     proc->pid, thread->pid, t->debug_id,
 			     target_proc->pid, target_node->debug_id,
-			     (u64)tr->data.ptr.buffer,
-			     (u64)tr->data.ptr.offsets,
+			     (unsigned long)tr->data.ptr.buffer - proc->alloc.buffer,
+			     (unsigned long)tr->data.ptr.offsets - proc->alloc.buffer,
 			     (u64)tr->data_size, (u64)tr->offsets_size,
 			     (u64)extra_buffers_size);
 
@@ -4223,20 +4223,21 @@ static int binder_thread_write(struct binder_proc *proc,
 			if (IS_ERR_OR_NULL(buffer)) {
 				if (PTR_ERR(buffer) == -EPERM) {
 					binder_user_error(
-						"%d:%d BC_FREE_BUFFER u%016llx matched unreturned or currently freeing buffer\n",
+						"%d:%d BC_FREE_BUFFER matched unreturned or currently freeing buffer at offset %lx\n",
 						proc->pid, thread->pid,
-						(u64)data_ptr);
+						(unsigned long)data_ptr - proc->alloc.buffer);
 				} else {
 					binder_user_error(
-						"%d:%d BC_FREE_BUFFER u%016llx no match\n",
+						"%d:%d BC_FREE_BUFFER no match for buffer at offset %lx\n",
 						proc->pid, thread->pid,
-						(u64)data_ptr);
+						(unsigned long)data_ptr - proc->alloc.buffer);
 				}
 				break;
 			}
 			binder_debug(BINDER_DEBUG_FREE_BUFFER,
-				     "%d:%d BC_FREE_BUFFER u%016llx found buffer %d for %s transaction\n",
-				     proc->pid, thread->pid, (u64)data_ptr,
+				     "%d:%d BC_FREE_BUFFER at offset %lx found buffer %d for %s transaction\n",
+				     proc->pid, thread->pid,
+				     (unsigned long)data_ptr - proc->alloc.buffer,
 				     buffer->debug_id,
 				     buffer->transaction ? "active" : "finished");
 			binder_free_buf(proc, thread, buffer, false);
@@ -5053,7 +5054,7 @@ static int binder_thread_read(struct binder_proc *proc,
 		trace_binder_transaction_received(t);
 		binder_stat_br(proc, thread, cmd);
 		binder_debug(BINDER_DEBUG_TRANSACTION,
-			     "%d:%d %s %d %d:%d, cmd %u size %zd-%zd ptr %016llx-%016llx\n",
+			     "%d:%d %s %d %d:%d, cmd %u size %zd-%zd ptr offset %lx-%lx\n",
 			     proc->pid, thread->pid,
 			     (cmd == BR_TRANSACTION) ? "BR_TRANSACTION" :
 				(cmd == BR_TRANSACTION_SEC_CTX) ?
@@ -5061,8 +5062,8 @@ static int binder_thread_read(struct binder_proc *proc,
 			     t->debug_id, t_from ? t_from->proc->pid : 0,
 			     t_from ? t_from->pid : 0, cmd,
 			     t->buffer->data_size, t->buffer->offsets_size,
-			     (u64)trd->data.ptr.buffer,
-			     (u64)trd->data.ptr.offsets);
+			     (unsigned long)trd->data.ptr.buffer - proc->alloc.buffer,
+			     (unsigned long)trd->data.ptr.offsets - proc->alloc.buffer);
 
 		if (t_from)
 			binder_thread_dec_tmpref(t_from);
-- 
2.49.0.395.g12beb8f557-goog


