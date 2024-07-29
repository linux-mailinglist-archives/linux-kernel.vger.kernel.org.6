Return-Path: <linux-kernel+bounces-266068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 447EB93FA4F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EA71C21EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595E215A862;
	Mon, 29 Jul 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Wp3HYs8Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADD3548E0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269451; cv=none; b=lEF2cXz+eA4hHyrWghqkvnnq3Hb2gBODt+r2+vK/2yYz4tTZHa+h+tylDIXQZCbl2pyXPkcL26E1je0fvxinGnwalvFPR84UCQmQxhR20NAsrYZgz7otCfIEkoGYOmz+cjNmZ7KcBKVWjdhwC0BwlBRcRPP5+D9woxk2dy4SfVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269451; c=relaxed/simple;
	bh=ipiHST4SCIty4wj5yKMDhrD/wf5bD4cQT7ZVeP+MBUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tmRH5v7sfONQ0NJ6nLbSKQyfLoyORK+1yNKayStg/SMQZdUFrMfAZfxx/eBULPwKIElZC4nLAdHOWrlqK88RAEPK8x7T+KXN13lff51okYH9x3LEfoa7MlqTBaMPzGutrdhUQ4QOmlEj6jcQb70Lmyxjw6vrlqrLOWtApkmHwME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Wp3HYs8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A56AC32786;
	Mon, 29 Jul 2024 16:10:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Wp3HYs8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1722269448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YivZziX9LWa/2uzd4bPvyJF25hcnFS/xwNWlvB9xMGI=;
	b=Wp3HYs8YSq/TjRUqEpVDKPUrjySVQBWa3zh126ysqPd3VzjTsmc5FFvNZh8BRqNduWdhKb
	jIHvEAxJkEevM6F1YOBTEwugcXwxaWRd1rrAbQFiQ0logeUvLnPIDuao2cJScuqig+Dc9H
	OptHSmfoq5+rN+VlQDlaQXsO1eiruFQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5bf61c69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jul 2024 16:10:48 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] selftests/vDSO: simplify getrandom thread local storage and structs
Date: Mon, 29 Jul 2024 18:10:36 +0200
Message-ID: <20240729161039.316016-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than using pthread_get/set_specific, just use gcc's __thread
annotation, which is noticeably faster and makes the code more obvious.

Also, just have one simplified struct called vgrnd, instead of trying to
split things up semantically. Those divisions were useful when this code
was split across several commit *messages*, but doesn't make as much
sense within a single file. This should make the code more clear and
provide a better example for implementers.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 .../selftests/vDSO/vdso_test_getrandom.c      | 67 ++++++++-----------
 1 file changed, 27 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 05122425a873..89c961175956 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -38,50 +38,43 @@ static struct {
 	pthread_mutex_t lock;
 	void **states;
 	size_t len, cap;
-} grnd_allocator = {
-	.lock = PTHREAD_MUTEX_INITIALIZER
-};
-
-static struct {
 	ssize_t(*fn)(void *, size_t, unsigned long, void *, size_t);
-	pthread_key_t key;
-	pthread_once_t initialized;
 	struct vgetrandom_opaque_params params;
-} grnd_ctx = {
-	.initialized = PTHREAD_ONCE_INIT
+} vgrnd = {
+	.lock = PTHREAD_MUTEX_INITIALIZER
 };
 
 static void *vgetrandom_get_state(void)
 {
 	void *state = NULL;
 
-	pthread_mutex_lock(&grnd_allocator.lock);
-	if (!grnd_allocator.len) {
+	pthread_mutex_lock(&vgrnd.lock);
+	if (!vgrnd.len) {
 		size_t page_size = getpagesize();
 		size_t new_cap;
 		size_t alloc_size, num = sysconf(_SC_NPROCESSORS_ONLN); /* Just a decent heuristic. */
 		void *new_block, *new_states;
 
-		alloc_size = (num * grnd_ctx.params.size_of_opaque_state + page_size - 1) & (~(page_size - 1));
-		num = (page_size / grnd_ctx.params.size_of_opaque_state) * (alloc_size / page_size);
-		new_block = mmap(0, alloc_size, grnd_ctx.params.mmap_prot, grnd_ctx.params.mmap_flags, -1, 0);
+		alloc_size = (num * vgrnd.params.size_of_opaque_state + page_size - 1) & (~(page_size - 1));
+		num = (page_size / vgrnd.params.size_of_opaque_state) * (alloc_size / page_size);
+		new_block = mmap(0, alloc_size, vgrnd.params.mmap_prot, vgrnd.params.mmap_flags, -1, 0);
 		if (new_block == MAP_FAILED)
 			goto out;
 
-		new_cap = grnd_allocator.cap + num;
-		new_states = reallocarray(grnd_allocator.states, new_cap, sizeof(*grnd_allocator.states));
+		new_cap = vgrnd.cap + num;
+		new_states = reallocarray(vgrnd.states, new_cap, sizeof(*vgrnd.states));
 		if (!new_states)
 			goto unmap;
-		grnd_allocator.cap = new_cap;
-		grnd_allocator.states = new_states;
+		vgrnd.cap = new_cap;
+		vgrnd.states = new_states;
 
 		for (size_t i = 0; i < num; ++i) {
-			if (((uintptr_t)new_block & (page_size - 1)) + grnd_ctx.params.size_of_opaque_state > page_size)
+			if (((uintptr_t)new_block & (page_size - 1)) + vgrnd.params.size_of_opaque_state > page_size)
 				new_block = (void *)(((uintptr_t)new_block + page_size - 1) & (~(page_size - 1)));
-			grnd_allocator.states[i] = new_block;
-			new_block += grnd_ctx.params.size_of_opaque_state;
+			vgrnd.states[i] = new_block;
+			new_block += vgrnd.params.size_of_opaque_state;
 		}
-		grnd_allocator.len = num;
+		vgrnd.len = num;
 		goto success;
 
 	unmap:
@@ -89,10 +82,10 @@ static void *vgetrandom_get_state(void)
 		goto out;
 	}
 success:
-	state = grnd_allocator.states[--grnd_allocator.len];
+	state = vgrnd.states[--vgrnd.len];
 
 out:
-	pthread_mutex_unlock(&grnd_allocator.lock);
+	pthread_mutex_unlock(&vgrnd.lock);
 	return state;
 }
 
@@ -100,27 +93,25 @@ static void vgetrandom_put_state(void *state)
 {
 	if (!state)
 		return;
-	pthread_mutex_lock(&grnd_allocator.lock);
-	grnd_allocator.states[grnd_allocator.len++] = state;
-	pthread_mutex_unlock(&grnd_allocator.lock);
+	pthread_mutex_lock(&vgrnd.lock);
+	vgrnd.states[vgrnd.len++] = state;
+	pthread_mutex_unlock(&vgrnd.lock);
 }
 
 static void vgetrandom_init(void)
 {
-	if (pthread_key_create(&grnd_ctx.key, vgetrandom_put_state) != 0)
-		return;
 	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
 	if (!sysinfo_ehdr) {
 		printf("AT_SYSINFO_EHDR is not present!\n");
 		exit(KSFT_SKIP);
 	}
 	vdso_init_from_sysinfo_ehdr(sysinfo_ehdr);
-	grnd_ctx.fn = (__typeof__(grnd_ctx.fn))vdso_sym("LINUX_2.6", "__vdso_getrandom");
-	if (!grnd_ctx.fn) {
+	vgrnd.fn = (__typeof__(vgrnd.fn))vdso_sym("LINUX_2.6", "__vdso_getrandom");
+	if (!vgrnd.fn) {
 		printf("__vdso_getrandom is missing!\n");
 		exit(KSFT_FAIL);
 	}
-	if (grnd_ctx.fn(NULL, 0, 0, &grnd_ctx.params, ~0UL) != 0) {
+	if (vgrnd.fn(NULL, 0, 0, &vgrnd.params, ~0UL) != 0) {
 		printf("failed to fetch vgetrandom params!\n");
 		exit(KSFT_FAIL);
 	}
@@ -128,22 +119,16 @@ static void vgetrandom_init(void)
 
 static ssize_t vgetrandom(void *buf, size_t len, unsigned long flags)
 {
-	void *state;
+	static __thread void *state;
 
-	pthread_once(&grnd_ctx.initialized, vgetrandom_init);
-	state = pthread_getspecific(grnd_ctx.key);
 	if (!state) {
 		state = vgetrandom_get_state();
-		if (pthread_setspecific(grnd_ctx.key, state) != 0) {
-			vgetrandom_put_state(state);
-			state = NULL;
-		}
 		if (!state) {
 			printf("vgetrandom_get_state failed!\n");
 			exit(KSFT_FAIL);
 		}
 	}
-	return grnd_ctx.fn(buf, len, flags, state, grnd_ctx.params.size_of_opaque_state);
+	return vgrnd.fn(buf, len, flags, state, vgrnd.params.size_of_opaque_state);
 }
 
 enum { TRIALS = 25000000, THREADS = 256 };
@@ -265,6 +250,8 @@ static void usage(const char *argv0)
 
 int main(int argc, char *argv[])
 {
+	vgetrandom_init();
+
 	if (argc == 1) {
 		kselftest();
 		return 0;
-- 
2.45.2


