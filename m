Return-Path: <linux-kernel+bounces-311145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D216968578
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0572873E8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9DE184527;
	Mon,  2 Sep 2024 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mQQ2Oi4N"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D5217D377
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274627; cv=none; b=avibU6mzdyH7JNkg9b2RxKB0ZetC5mAFtnc+yF3zKC89n6J8yGIgBdAXv5J/Vo7saVdFREw/Ch620Fswi4zpcsBmaRoCB+AQv1NMNuRPGxglsnSY1dA0x5XZXkavNSwJL8KJZjjwmzN4y60HJzIC20s/1B8hriN6I08CnrZeeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274627; c=relaxed/simple;
	bh=UCuTJ3W17tR/k2lLF8j9d7zfbWvaVpdYHMwh5vQm3i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjFOmCfmmj62ZhO5xvK7mmnp95WERWFxtjt7RKX6tyKMYDGcXGWcb6h7UPHssZ1ag+n6hvDne9TF27Lg8rnn7M7IHqytIP3kJA32InpabUktomJD389hQC7b2mr4dP4oDkztW4TCx9NejYswa0lLngk+fpHc71DTcj4ICyQjcpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mQQ2Oi4N; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70df4b5cdd8so2773257a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274625; x=1725879425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ykiW8sIgPGAodK0jOXG/pemUjls0DsoyZf7zUnL9ME=;
        b=mQQ2Oi4NQheEZQm3UjQSt0Bw1kAwkIucLOP62LY74TnZUji7tsYVBiQobQEWAn3j/n
         HDbaIDHBK9ODekvPZJoSbKYp6T567ABEUvehF+iZoYXwsXGhcO1evcZxXKfEHxKOrb6R
         YQ0Xd/fkkNVmqw/JZyXDMB/Fy0tQfsUxEuAu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274625; x=1725879425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ykiW8sIgPGAodK0jOXG/pemUjls0DsoyZf7zUnL9ME=;
        b=pFmB77Xlkp+Su1uDIX4q9u5ONBRQDkAbEEq9ClQ7bpPK/bebBuyU5Na9YhrB0BAtje
         B79AvyBY8zVQxCtaaOtGH3uBAZEnyoqhfVxjK+RPVffYT3Uq6OrJEXcHrudADAvFRsDm
         clBfOv90a2fuT6isUrB6Cu0E/8rK/vRyvIqSZAH92PzOB99ozIPe7vo9CulezMrzeud/
         p7r2YBLvgMI9PRJcpE0/rfE/LY5km+okdWy5v8aaj7itG9JWDDBg1Puer7+Ya9a42TGl
         0+7qrSpRM2TgNJJoLL4iIkVZaahQr4Lac3ldvQ+xranHTVcz4fMIHQgqQDva0DLxME+W
         CtWw==
X-Forwarded-Encrypted: i=1; AJvYcCWdGitLiWAL54BA/pJZG7a8jmgW+sJA1P/+rRrT7CLQiy2xDs5ixxMMLxLRLVRuJg63wPzCDP0kc29z6K4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0FnGmYItx0Sv21D8zHv/eadT+gzGsQlh6OXvJMOhiSQN2Fk7p
	CQEiXdYzuZ4vNumLMN/3q+eCGdUaJpNosI0nMhLMRhnfUkPQYoGkfzgq5xixvQ==
X-Google-Smtp-Source: AGHT+IE/J4VzixubEq8s/Rq3uM/XwlQu9bFMvNf0OIsQiDyVGPGUz32ZC/Pp0WMhmYaM6AfVJRrAxQ==
X-Received: by 2002:a05:6358:5918:b0:1ac:f144:2b16 with SMTP id e5c5f4694b2df-1b7ef7089d9mr911882755d.26.1725274624772;
        Mon, 02 Sep 2024 03:57:04 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:04 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Nick Terrell <terrelln@fb.com>
Subject: [PATCHv7 01/24] lib: zstd: export API needed for dictionary support
Date: Mon,  2 Sep 2024 19:55:49 +0900
Message-ID: <20240902105656.1383858-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902105656.1383858-1-senozhatsky@chromium.org>
References: <20240902105656.1383858-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to export a number of API functions that enable
advanced zstd usage - C/D dictionaries, dictionaries
sharing between contexts, etc.

Cc: Nick Terrell <terrelln@fb.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/zstd.h              | 167 ++++++++++++++++++++++++++++++
 lib/zstd/zstd_compress_module.c   |  49 +++++++++
 lib/zstd/zstd_decompress_module.c |  36 +++++++
 3 files changed, 252 insertions(+)

diff --git a/include/linux/zstd.h b/include/linux/zstd.h
index f109d49f43f8..ac59ae9a18d7 100644
--- a/include/linux/zstd.h
+++ b/include/linux/zstd.h
@@ -77,6 +77,30 @@ int zstd_min_clevel(void);
  */
 int zstd_max_clevel(void);
 
+/**
+ * zstd_default_clevel() - default compression level
+ *
+ * Return: Default compression level.
+ */
+int zstd_default_clevel(void);
+
+/**
+ * struct zstd_custom_mem - custom memory allocation
+ */
+typedef ZSTD_customMem zstd_custom_mem;
+
+/**
+ * struct zstd_dict_load_method - Dictionary load method.
+ * See zstd_lib.h.
+ */
+typedef ZSTD_dictLoadMethod_e zstd_dict_load_method;
+
+/**
+ * struct zstd_dict_content_type - Dictionary context type.
+ * See zstd_lib.h.
+ */
+typedef ZSTD_dictContentType_e zstd_dict_content_type;
+
 /* ======   Parameter Selection   ====== */
 
 /**
@@ -136,6 +160,19 @@ typedef ZSTD_parameters zstd_parameters;
 zstd_parameters zstd_get_params(int level,
 	unsigned long long estimated_src_size);
 
+
+/**
+ * zstd_get_cparams() - returns zstd_compression_parameters for selected level
+ * @level:              The compression level
+ * @estimated_src_size: The estimated source size to compress or 0
+ *                      if unknown.
+ * @dict_size:          Dictionary size.
+ *
+ * Return:              The selected zstd_compression_parameters.
+ */
+zstd_compression_parameters zstd_get_cparams(int level,
+	unsigned long long estimated_src_size, size_t dict_size);
+
 /* ======   Single-pass Compression   ====== */
 
 typedef ZSTD_CCtx zstd_cctx;
@@ -180,6 +217,71 @@ zstd_cctx *zstd_init_cctx(void *workspace, size_t workspace_size);
 size_t zstd_compress_cctx(zstd_cctx *cctx, void *dst, size_t dst_capacity,
 	const void *src, size_t src_size, const zstd_parameters *parameters);
 
+/**
+ * zstd_create_cctx_advanced() - Create compression context
+ * @custom_mem:   Custom allocator.
+ *
+ * Return:        NULL on error, pointer to compression context otherwise.
+ */
+zstd_cctx *zstd_create_cctx_advanced(zstd_custom_mem custom_mem);
+
+/**
+ * zstd_free_cctx() - Free compression context
+ * @cdict:        Pointer to compression context.
+ *
+ * Return:        Always 0.
+ */
+size_t zstd_free_cctx(zstd_cctx* cctx);
+
+/**
+ * struct zstd_cdict - Compression dictionary.
+ * See zstd_lib.h.
+ */
+typedef ZSTD_CDict zstd_cdict;
+
+/**
+ * zstd_create_cdict_byreference() - Create compression dictionary
+ * @dict:              Pointer to dictionary buffer.
+ * @dict_size:         Size of the dictionary buffer.
+ * @dict_load_method:  Dictionary load method.
+ * @dict_content_type: Dictionary content type.
+ * @custom_mem:        Memory allocator.
+ *
+ * Note, this uses @dict by reference (ZSTD_dlm_byRef), so it should be
+ * free before zstd_cdict is destroyed.
+ *
+ * Return:             NULL on error, pointer to compression dictionary
+ *                     otherwise.
+ */
+zstd_cdict *zstd_create_cdict_byreference(const void *dict, size_t dict_size,
+					  zstd_compression_parameters cparams,
+					  zstd_custom_mem custom_mem);
+
+/**
+ * zstd_free_cdict() - Free compression dictionary
+ * @cdict:        Pointer to compression dictionary.
+ *
+ * Return:        Always 0.
+ */
+size_t zstd_free_cdict(zstd_cdict* cdict);
+
+/**
+ * zstd_compress_using_cdict() - compress src into dst using a dictionary
+ * @cctx:         The context. Must have been initialized with zstd_init_cctx().
+ * @dst:          The buffer to compress src into.
+ * @dst_capacity: The size of the destination buffer. May be any size, but
+ *                ZSTD_compressBound(srcSize) is guaranteed to be large enough.
+ * @src:          The data to compress.
+ * @src_size:     The size of the data to compress.
+ * @cdict:        The dictionary to be used.
+ *
+ * Return:        The compressed size or an error, which can be checked using
+ *                zstd_is_error().
+ */
+size_t zstd_compress_using_cdict(zstd_cctx *cctx, void *dst,
+	size_t dst_capacity, const void *src, size_t src_size,
+	const zstd_cdict *cdict);
+
 /* ======   Single-pass Decompression   ====== */
 
 typedef ZSTD_DCtx zstd_dctx;
@@ -220,6 +322,71 @@ zstd_dctx *zstd_init_dctx(void *workspace, size_t workspace_size);
 size_t zstd_decompress_dctx(zstd_dctx *dctx, void *dst, size_t dst_capacity,
 	const void *src, size_t src_size);
 
+/**
+ * struct zstd_ddict - Decompression dictionary.
+ * See zstd_lib.h.
+ */
+typedef ZSTD_DDict zstd_ddict;
+
+/**
+ * zstd_create_ddict_byreference() - Create decompression dictionary
+ * @dict:              Pointer to dictionary buffer.
+ * @dict_size:         Size of the dictionary buffer.
+ * @dict_load_method:  Dictionary load method.
+ * @dict_content_type: Dictionary content type.
+ * @custom_mem:        Memory allocator.
+ *
+ * Note, this uses @dict by reference (ZSTD_dlm_byRef), so it should be
+ * free before zstd_ddict is destroyed.
+ *
+ * Return:             NULL on error, pointer to decompression dictionary
+ *                     otherwise.
+ */
+zstd_ddict *zstd_create_ddict_byreference(const void *dict, size_t dict_size,
+					  zstd_custom_mem custom_mem);
+/**
+ * zstd_free_ddict() - Free decompression dictionary
+ * @dict:         Pointer to the dictionary.
+ *
+ * Return:        Always 0.
+ */
+size_t zstd_free_ddict(zstd_ddict *ddict);
+
+/**
+ * zstd_create_dctx_advanced() - Create decompression context
+ * @custom_mem:   Custom allocator.
+ *
+ * Return:        NULL on error, pointer to decompression context otherwise.
+ */
+zstd_dctx *zstd_create_dctx_advanced(zstd_custom_mem custom_mem);
+
+/**
+ * zstd_free_dctx() -- Free decompression context
+ * @dctx:         Pointer to decompression context.
+ * Return:        Always 0.
+ */
+size_t zstd_free_dctx(zstd_dctx *dctx);
+
+/**
+ * zstd_decompress_using_ddict() - decompress src into dst using a dictionary
+ * @dctx:         The decompression context.
+ * @dst:          The buffer to decompress src into.
+ * @dst_capacity: The size of the destination buffer. Must be at least as large
+ *                as the decompressed size. If the caller cannot upper bound the
+ *                decompressed size, then it's better to use the streaming API.
+ * @src:          The zstd compressed data to decompress. Multiple concatenated
+ *                frames and skippable frames are allowed.
+ * @src_size:     The exact size of the data to decompress.
+ * @ddict:        The dictionary to be used.
+ *
+ * Return:        The decompressed size or an error, which can be checked using
+ *                zstd_is_error().
+ */
+size_t zstd_decompress_using_ddict(zstd_dctx *dctx,
+	void *dst, size_t dst_capacity, const void *src, size_t src_size,
+	const zstd_ddict *ddict);
+
+
 /* ======   Streaming Buffers   ====== */
 
 /**
diff --git a/lib/zstd/zstd_compress_module.c b/lib/zstd/zstd_compress_module.c
index 8ecf43226af2..ceaf352d03e2 100644
--- a/lib/zstd/zstd_compress_module.c
+++ b/lib/zstd/zstd_compress_module.c
@@ -66,6 +66,12 @@ int zstd_max_clevel(void)
 }
 EXPORT_SYMBOL(zstd_max_clevel);
 
+int zstd_default_clevel(void)
+{
+	return ZSTD_defaultCLevel();
+}
+EXPORT_SYMBOL(zstd_default_clevel);
+
 size_t zstd_compress_bound(size_t src_size)
 {
 	return ZSTD_compressBound(src_size);
@@ -79,6 +85,13 @@ zstd_parameters zstd_get_params(int level,
 }
 EXPORT_SYMBOL(zstd_get_params);
 
+zstd_compression_parameters zstd_get_cparams(int level,
+	unsigned long long estimated_src_size, size_t dict_size)
+{
+	return ZSTD_getCParams(level, estimated_src_size, dict_size);
+}
+EXPORT_SYMBOL(zstd_get_cparams);
+
 size_t zstd_cctx_workspace_bound(const zstd_compression_parameters *cparams)
 {
 	return ZSTD_estimateCCtxSize_usingCParams(*cparams);
@@ -93,6 +106,33 @@ zstd_cctx *zstd_init_cctx(void *workspace, size_t workspace_size)
 }
 EXPORT_SYMBOL(zstd_init_cctx);
 
+zstd_cctx *zstd_create_cctx_advanced(zstd_custom_mem custom_mem)
+{
+	return ZSTD_createCCtx_advanced(custom_mem);
+}
+EXPORT_SYMBOL(zstd_create_cctx_advanced);
+
+size_t zstd_free_cctx(zstd_cctx *cctx)
+{
+	return ZSTD_freeCCtx(cctx);
+}
+EXPORT_SYMBOL(zstd_free_cctx);
+
+zstd_cdict *zstd_create_cdict_byreference(const void *dict, size_t dict_size,
+					  zstd_compression_parameters cparams,
+					  zstd_custom_mem custom_mem)
+{
+	return ZSTD_createCDict_advanced(dict, dict_size, ZSTD_dlm_byRef,
+					 ZSTD_dct_auto, cparams, custom_mem);
+}
+EXPORT_SYMBOL(zstd_create_cdict_byreference);
+
+size_t zstd_free_cdict(zstd_cdict *cdict)
+{
+	return ZSTD_freeCDict(cdict);
+}
+EXPORT_SYMBOL(zstd_free_cdict);
+
 size_t zstd_compress_cctx(zstd_cctx *cctx, void *dst, size_t dst_capacity,
 	const void *src, size_t src_size, const zstd_parameters *parameters)
 {
@@ -101,6 +141,15 @@ size_t zstd_compress_cctx(zstd_cctx *cctx, void *dst, size_t dst_capacity,
 }
 EXPORT_SYMBOL(zstd_compress_cctx);
 
+size_t zstd_compress_using_cdict(zstd_cctx *cctx, void *dst,
+	size_t dst_capacity, const void *src, size_t src_size,
+	const ZSTD_CDict *cdict)
+{
+	return ZSTD_compress_usingCDict(cctx, dst, dst_capacity,
+					src, src_size, cdict);
+}
+EXPORT_SYMBOL(zstd_compress_using_cdict);
+
 size_t zstd_cstream_workspace_bound(const zstd_compression_parameters *cparams)
 {
 	return ZSTD_estimateCStreamSize_usingCParams(*cparams);
diff --git a/lib/zstd/zstd_decompress_module.c b/lib/zstd/zstd_decompress_module.c
index 7d31518e9d5a..0ae819f0c927 100644
--- a/lib/zstd/zstd_decompress_module.c
+++ b/lib/zstd/zstd_decompress_module.c
@@ -44,6 +44,33 @@ size_t zstd_dctx_workspace_bound(void)
 }
 EXPORT_SYMBOL(zstd_dctx_workspace_bound);
 
+zstd_dctx *zstd_create_dctx_advanced(zstd_custom_mem custom_mem)
+{
+	return ZSTD_createDCtx_advanced(custom_mem);
+}
+EXPORT_SYMBOL(zstd_create_dctx_advanced);
+
+size_t zstd_free_dctx(zstd_dctx *dctx)
+{
+	return ZSTD_freeDCtx(dctx);
+}
+EXPORT_SYMBOL(zstd_free_dctx);
+
+zstd_ddict *zstd_create_ddict_byreference(const void *dict, size_t dict_size,
+					  zstd_custom_mem custom_mem)
+{
+	return ZSTD_createDDict_advanced(dict, dict_size, ZSTD_dlm_byRef,
+					 ZSTD_dct_auto, custom_mem);
+
+}
+EXPORT_SYMBOL(zstd_create_ddict_byreference);
+
+size_t zstd_free_ddict(zstd_ddict *ddict)
+{
+	return ZSTD_freeDDict(ddict);
+}
+EXPORT_SYMBOL(zstd_free_ddict);
+
 zstd_dctx *zstd_init_dctx(void *workspace, size_t workspace_size)
 {
 	if (workspace == NULL)
@@ -59,6 +86,15 @@ size_t zstd_decompress_dctx(zstd_dctx *dctx, void *dst, size_t dst_capacity,
 }
 EXPORT_SYMBOL(zstd_decompress_dctx);
 
+size_t zstd_decompress_using_ddict(zstd_dctx *dctx,
+	void *dst, size_t dst_capacity, const void* src, size_t src_size,
+	const zstd_ddict* ddict)
+{
+	return ZSTD_decompress_usingDDict(dctx, dst, dst_capacity, src,
+					  src_size, ddict);
+}
+EXPORT_SYMBOL(zstd_decompress_using_ddict);
+
 size_t zstd_dstream_workspace_bound(size_t max_window_size)
 {
 	return ZSTD_estimateDStreamSize(max_window_size);
-- 
2.46.0.469.g59c65b2a67-goog


