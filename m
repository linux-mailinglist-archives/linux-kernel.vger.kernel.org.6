Return-Path: <linux-kernel+bounces-179565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF988C617D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFD51C219CD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C160863511;
	Wed, 15 May 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XYhwxIUM"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94226214E
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757453; cv=none; b=u46LpLCiyDgn3MovnZDBSn0dAYqGBHPt4at8QozkHAilVELqwRR3CpHS6afI0R7fx2LZL5GAac1U6My9cU7vo3hQpFcRnQDUjNUVisDz3ZH0uihI9D6NkorpgaRCX453r/lIwVr9C8Yq9euV9wBvoFndBoPJp+95dcOLBzNL2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757453; c=relaxed/simple;
	bh=dGZx0+acqv0CZi2wH7InQ4R8O8AcdvZYdUe91hxxiWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSN0JJuL4+kqD8wkwQ/xsxDn3US7SofLsmP7QM+ZHA21D5QV0FQmIj0XWdmLrAQzNWcbgtH4C23NYrXOFYCTdUdJbLdiQj8U6F1Ei2QojuTR+fWJOTyCkDeMdcXnQJPSJILG84T1UejYi/fmWt4QW4yCuDMGkytWaW3xOcw241I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XYhwxIUM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d3907ff128so5438413a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757451; x=1716362251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/z5a3E5tjsWd2v3yZqDEd2ZFUX29EqdmRojLDBz4OHQ=;
        b=XYhwxIUM8or1FxDmvVN5glOWFu63z/QCHG1Ml26EstgH79SW1uXwEBvolud6QX6cdr
         2+dXRPM+1lza3dA2tPVvNhIQrMIsTCCoKiEZOzBED75+gaQ1/9SWjjsxVuJV0tQVwQOQ
         n0dmXtvze4CwhLT/6loisp/6N0yo4cD6NuT5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757451; x=1716362251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/z5a3E5tjsWd2v3yZqDEd2ZFUX29EqdmRojLDBz4OHQ=;
        b=SsyUmZAvdXD9Kq961OW7wD6wb3sK+TQ6UH0TJ0OHIv+922Yn5uflpoMtVpFb9r+3Jv
         jNhnU0cep4YpB5uM8SmYnb4cD0voOsixG8LQgmZpGxiez3Pyegs9HfnCHzK6n8fofY3C
         qny6fxh/R0WY2nCCvzoa9nEH0nKTOlK+ax+EUOWRjAjVktTzcmAxMJfHdfU0WJKMRIA5
         Bp+8vYVcq5uf4y3RIgIH4kUsAYMfFsQeBcU9L1yuTjvflYHPFDOqXKDeYZPGJRyW01fP
         YIFLE2842ySmW77PsQVx+sn2V4VmVz5mPa6jWhtvDjNXmEsOJVrlNVBCZFNZaeq3o3b8
         hzeA==
X-Gm-Message-State: AOJu0Ywdcce0l3qmD1PVA04BSeljbXadAdq/MvcId2NUxpBkdLtIC1NR
	wrGJp3f/WaPWgJEkRnBNDQJDJyPyveawcQwo8HbiKrPtgML58PIzZeih8sPFXAE5VQRNTHjz5YU
	=
X-Google-Smtp-Source: AGHT+IGv1Omsyk9TRAdIngjWvd5a6uW973xBM8/wHVw3kf6S3NTLue+rsCGPi9x1UgDL0rvIAAuHOQ==
X-Received: by 2002:a05:6a20:f38f:b0:1aa:a6cc:39c5 with SMTP id adf61e73a8af0-1afde0824f6mr18701539637.7.1715757451053;
        Wed, 15 May 2024 00:17:31 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:30 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Nick Terrell <terrelln@fb.com>
Subject: [PATCHv4 14/21] lib/zstd: export API needed for dictionary support
Date: Wed, 15 May 2024 16:12:51 +0900
Message-ID: <20240515071645.1788128-15-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240515071645.1788128-1-senozhatsky@chromium.org>
References: <20240515071645.1788128-1-senozhatsky@chromium.org>
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

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Nick Terrell <terrelln@fb.com>
---
 include/linux/zstd.h              | 165 ++++++++++++++++++++++++++++++
 lib/zstd/zstd_compress_module.c   |  52 ++++++++++
 lib/zstd/zstd_decompress_module.c |  38 +++++++
 3 files changed, 255 insertions(+)

diff --git a/include/linux/zstd.h b/include/linux/zstd.h
index f109d49f43f8..18260a354231 100644
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
@@ -180,6 +217,70 @@ zstd_cctx *zstd_init_cctx(void *workspace, size_t workspace_size);
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
+ * zstd_create_cdict_advanced() - Create compression dictionary
+ * @dict:              Pointer to dictionary buffer.
+ * @dict_size:         Size of the dictionary buffer.
+ * @dict_load_method:  Dictionary load method.
+ * @dict_content_type: Dictionary content type.
+ * @custom_mem:        Memory allocator.
+ *
+ * Return:             NULL on error, pointer to compression dictionary
+ *                     otherwise.
+ */
+zstd_cdict *zstd_create_cdict_advanced(const void *dict, size_t dict_size,
+				       zstd_dict_load_method dict_load_method,
+				       zstd_dict_content_type dict_content_type,
+				       zstd_compression_parameters cparams,
+				       zstd_custom_mem custom_mem);
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
@@ -220,6 +321,70 @@ zstd_dctx *zstd_init_dctx(void *workspace, size_t workspace_size);
 size_t zstd_decompress_dctx(zstd_dctx *dctx, void *dst, size_t dst_capacity,
 	const void *src, size_t src_size);
 
+/**
+ * struct zstd_ddict - Decompression dictionary.
+ * See zstd_lib.h.
+ */
+typedef ZSTD_DDict zstd_ddict;
+
+/**
+ * zstd_create_ddict_advanced() - Create decompression dictionary
+ * @dict:              Pointer to dictionary buffer.
+ * @dict_size:         Size of the dictionary buffer.
+ * @dict_load_method:  Dictionary load method.
+ * @dict_content_type: Dictionary content type.
+ * @custom_mem:        Memory allocator.
+ *
+ * Return:             NULL on error, pointer to decompression dictionary
+ *                     otherwise.
+ */
+zstd_ddict *zstd_create_ddict_advanced(const void *dict, size_t dict_size,
+				       zstd_dict_load_method dict_load_method,
+				       zstd_dict_content_type dict_content_type,
+				       zstd_custom_mem custom_mem);
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
index 8ecf43226af2..a5edf59334df 100644
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
@@ -93,6 +106,36 @@ zstd_cctx *zstd_init_cctx(void *workspace, size_t workspace_size)
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
+zstd_cdict *zstd_create_cdict_advanced(const void *dict, size_t dict_size,
+				       zstd_dict_load_method dict_load_method,
+				       zstd_dict_content_type dict_content_type,
+				       zstd_compression_parameters cparams,
+				       zstd_custom_mem custom_mem)
+{
+	return ZSTD_createCDict_advanced(dict, dict_size, dict_load_method,
+					 dict_content_type, cparams,
+					 custom_mem);
+}
+EXPORT_SYMBOL(zstd_create_cdict_advanced);
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
@@ -101,6 +144,15 @@ size_t zstd_compress_cctx(zstd_cctx *cctx, void *dst, size_t dst_capacity,
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
index 7d31518e9d5a..6a0f464609bc 100644
--- a/lib/zstd/zstd_decompress_module.c
+++ b/lib/zstd/zstd_decompress_module.c
@@ -44,6 +44,35 @@ size_t zstd_dctx_workspace_bound(void)
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
+zstd_ddict *zstd_create_ddict_advanced(const void *dict, size_t dict_size,
+                                      zstd_dict_load_method dict_load_method,
+                                      zstd_dict_content_type dict_content_type,
+                                      zstd_custom_mem custom_mem)
+{
+	return ZSTD_createDDict_advanced(dict, dict_size, dict_load_method,
+					 dict_content_type, custom_mem);
+
+}
+EXPORT_SYMBOL(zstd_create_ddict_advanced);
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
@@ -59,6 +88,15 @@ size_t zstd_decompress_dctx(zstd_dctx *dctx, void *dst, size_t dst_capacity,
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
2.45.0.rc1.225.g2a3ae87e7f-goog


