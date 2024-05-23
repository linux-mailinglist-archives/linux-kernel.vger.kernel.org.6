Return-Path: <linux-kernel+bounces-187800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8ED8CD8B2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1445F281ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DE51CFA9;
	Thu, 23 May 2024 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmF5XcwJ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5511711
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483153; cv=none; b=SsqOHUqw+16mg+Qs9DscrxI80Z0/OE/tNOclU2aLkGm63T8J1FvF+MLI8LIvQlEFRCPv4i4voqH36k9u0SWWKSXtkT+F3nK5kB2w6b18R/M9T/s10RFPoxMPhFtK4NqL+5dhct4IiEZHQUhGO2P603KKXElocI6EZ3ttoWYiaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483153; c=relaxed/simple;
	bh=ZBjQfebbku4/bUBs8h6x5TlCQhdiMEMTiX8BrAQapqE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=kDxqeZAfEzRcD9Tqgw0j8vQ/aOGcssiQ8EV4gtT7iTOV8lnIrDllImSCJ4lLMgtuZYuNsIbqEfes1HXf4gFfqTlg3OFuSo9N+ZdvIQwD765FWH8ir+RpPIDgP1Ji7OJg4DEHnbkbOe/ob806Eyd7rMVF1HTgTn3oa6I4YRIo9Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmF5XcwJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41fd5dc0480so53665505e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716483149; x=1717087949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:user-agent
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yr7A7+twaEG4YGP37jOqGZ1oZyO9dZYdh1Mba7skUqI=;
        b=QmF5XcwJCAdyngOgFXD8LPTZeNz1gbUYdOrkW+iUEM3wqAejc3OrHP3z+LWz4m98oU
         0ossx4a8M+UdpAx+oLgZPCbTtgNoCg/c4hGU7Y3VQbd8penQl+Y8tr61qZ00duY8SHEh
         rswMwA37eiWTXa4UKDX+/tLJtgwF2XKVshZ/i58JLHFYjRA5MlxCG4NIDimcqwoSnIlU
         RSRJOe3esffOUm9/s9nl5eOk58i2SiR7SB24CZyrMZyVU1GXRtwDYNOZli6PFiPKJhw6
         SlXBNbIwJbmMCg+yDzSBVM09YvfkQscZuGI1nBGnfXZv6L6usRGJ/eOD0UWT1iFE+Xtc
         I51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716483149; x=1717087949;
        h=content-transfer-encoding:mime-version:message-id:user-agent
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yr7A7+twaEG4YGP37jOqGZ1oZyO9dZYdh1Mba7skUqI=;
        b=ZRBCeaonjtH/x8sC1XM1g1vxCL8ZzVsvY+owSTFEhDeFJJUK7LP7Jywqy/W/6qId5k
         UkTb3Xfiawm8upKm4XyeWrttvojyAcYVC/q+83CwfXogat6OqUOP5H0XYtCb5evsrHlU
         m0RYI2qEXUtTeIIYNf+w+uAKvc6qTIvr3Ue0rDEPmrrA8oKgfd/BhTuC0V15bfGRkbUJ
         h0TGke1b2nOJ4Yb7x4K1y7m/KWpGxms1Sf9cC8O8li62qEdN44KLLIcW6uEYiwoZouXe
         TlSQ0IXNjL1xIPXMeMA2uavhq9YZPBcmFqz1O0Wp8fL9eIRssNcbNb4cqi8rro2xuevG
         RJnw==
X-Gm-Message-State: AOJu0YwVABOPSBU8JJ91SHtbtJbdBL1w4mpwIedH8C42ouVoCETq/PYD
	Z9C3rrHe/1+094+g2K4O/FHsaB4RsHXwsUcbW8NAjX55jl+9SvZrvDNlygkyyYo=
X-Google-Smtp-Source: AGHT+IE1OcM6D20yPxmwS7Sc6+erb6rrOllYaqJGoOAfCCd0TaQ30P3GNaj2UJexM78WpgQ9JWR7FQ==
X-Received: by 2002:a05:600c:5607:b0:41a:41c8:d8e7 with SMTP id 5b1f17b1804b1-420fd2d7033mr40411635e9.3.1716483149108;
        Thu, 23 May 2024 09:52:29 -0700 (PDT)
Received: from [127.0.0.1] ([86.120.163.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacecasm37052283f8f.82.2024.05.23.09.52.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 09:52:28 -0700 (PDT)
Date: Thu, 23 May 2024 19:52:22 +0300
From: Marcel <nitan.marcel@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?How_to_properly_fix_reading_user_po?=
 =?US-ASCII?Q?inters_in_bpf_in_android_kernel_4=2E9=3F?=
User-Agent: K-9 Mail for Android
Message-ID: <42DD54A2-D0C2-4A70-B461-7C16D3ECB8D2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

This seems that it was a long standing problem with the Linux kernel in gen=
eral=2E bpf_probe_read should have worked for both kernel and user pointers=
 but it fails with access error when reading an user one instead=2E=20

I know there's a patch upstream that fixes this by introducing new helpers=
 for reading kernel and userspace pointers and I tried to back port them ba=
ck to my kernel but with no success=2E Tools like bcc fail to use them and =
instead they report that the arguments sent to the helpers are invalid=2E I=
 assume this is due to the arguments ARG_CONST_STACK_SIZE and ARG_PTR_TO_RA=
W_STACK handle data different in the 4=2E9 android version and the upstream=
 version but I'm not sure that this is the cause=2E I left the patch I did =
below and with a link to the kernel I'm working on and maybe someone can ta=
ke a look and give me an hand (the patch isn't applied yet)

<https://github=2Ecom/nitanmarcel/android_kernel_oneplus_sdm845-bpf>

diff --git a/include/uapi/linux/bpf=2Eh b/include/uapi/linux/bpf=2Eh
index 744b4763b80e=2E=2Ede94c13b7193 100644
--- a/include/uapi/linux/bpf=2Eh
+++ b/include/uapi/linux/bpf=2Eh
@@ -559,6 +559,43 @@ enum bpf_func_id {
    */
    BPF_FUNC_probe_read_user,
=20
+   /**
+   * int bpf_probe_read_kernel(void *dst, int size, void *src)
+   *     Read a kernel pointer safely=2E
+   *     Return: 0 on success or negative error
+   */
+   BPF_FUNC_probe_read_kernel,
+
+	/**
+	 * int bpf_probe_read_str(void *dst, int size, const void *unsafe_ptr)
+	 *     Copy a NUL terminated string from user unsafe address=2E In case =
the string
+	 *     length is smaller than size, the target is not padded with furthe=
r NUL
+	 *     bytes=2E In case the string length is larger than size, just coun=
t-1
+	 *     bytes are copied and the last byte is set to NUL=2E
+	 *     @dst: destination address
+	 *     @size: maximum number of bytes to copy, including the trailing NU=
L
+	 *     @unsafe_ptr: unsafe address
+	 *     Return:
+	 *       > 0 length of the string including the trailing NUL on success
+	 *       < 0 error
+	 */
+	BPF_FUNC_probe_read_user_str,
+
+	/**
+	 * int bpf_probe_read_str(void *dst, int size, const void *unsafe_ptr)
+	 *     Copy a NUL terminated string from unsafe address=2E In case the s=
tring
+	 *     length is smaller than size, the target is not padded with furthe=
r NUL
+	 *     bytes=2E In case the string length is larger than size, just coun=
t-1
+	 *     bytes are copied and the last byte is set to NUL=2E
+	 *     @dst: destination address
+	 *     @size: maximum number of bytes to copy, including the trailing NU=
L
+	 *     @unsafe_ptr: unsafe address
+	 *     Return:
+	 *       > 0 length of the string including the trailing NUL on success
+	 *       < 0 error
+	 */
+	BPF_FUNC_probe_read_kernel_str,
+
 	__BPF_FUNC_MAX_ID,
 };
=20
diff --git a/kernel/trace/bpf_trace=2Ec b/kernel/trace/bpf_trace=2Ec
index a1e37a5d8c88=2E=2E3478ca744a45 100644
--- a/kernel/trace/bpf_trace=2Ec
+++ b/kernel/trace/bpf_trace=2Ec
@@ -94,7 +94,7 @@ static const struct bpf_func_proto bpf_probe_read_proto =
=3D {
 	=2Earg3_type	=3D ARG_ANYTHING,
 };
=20
-BPF_CALL_3(bpf_probe_read_user, void *, dst, u32, size, const void *, uns=
afe_ptr)
+BPF_CALL_3(bpf_probe_read_user, void *, dst, u32, size, const void  __use=
r *, unsafe_ptr)
 {
 	int ret;
=20
@@ -115,6 +115,27 @@ static const struct bpf_func_proto bpf_probe_read_use=
r_proto =3D {
 };
=20
=20
+BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size, const void *, u=
nsafe_ptr)
+{
+	int ret;
+
+	ret =3D probe_kernel_read(dst, unsafe_ptr, size);
+	if (unlikely(ret < 0))
+		memset(dst, 0, size);
+
+	return ret;
+}
+
+static const struct bpf_func_proto bpf_probe_read_kernel_proto =3D {
+	=2Efunc		=3D bpf_probe_read_kernel,
+	=2Egpl_only	=3D true,
+	=2Eret_type	=3D RET_INTEGER,
+	=2Earg1_type	=3D ARG_PTR_TO_RAW_STACK,
+	=2Earg2_type	=3D ARG_CONST_STACK_SIZE,
+	=2Earg3_type	=3D ARG_ANYTHING,
+};
+
+
 BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
 	   u32, size)
 {
@@ -487,6 +508,69 @@ static const struct bpf_func_proto bpf_probe_read_str=
_proto =3D {
 	=2Earg3_type	=3D ARG_ANYTHING,
 };
=20
+
+
+BPF_CALL_3(bpf_probe_read_user_str, void *, dst, u32, size,
+	   const void __user *, unsafe_ptr)
+{
+	int ret;
+
+	/*
+	 * The strncpy_from_unsafe() call will likely not fill the entire
+	 * buffer, but that's okay in this circumstance as we're probing
+	 * arbitrary memory anyway similar to bpf_probe_read() and might
+	 * as well probe the stack=2E Thus, memory is explicitly cleared
+	 * only in error case, so that improper users ignoring return
+	 * code altogether don't copy garbage; otherwise length of string
+	 * is returned that can be used for bpf_perf_event_output() et al=2E
+	 */
+	ret =3D strncpy_from_unsafe_user(dst, unsafe_ptr, size);
+	if (unlikely(ret < 0))
+		memset(dst, 0, size);
+
+	return ret;
+}
+
+static const struct bpf_func_proto bpf_probe_read_user_str_proto =3D {
+	=2Efunc		=3D bpf_probe_read_user_str,
+	=2Egpl_only	=3D true,
+	=2Eret_type	=3D RET_INTEGER,
+	=2Earg1_type	=3D ARG_PTR_TO_RAW_STACK,
+	=2Earg2_type	=3D ARG_CONST_STACK_SIZE,
+	=2Earg3_type	=3D ARG_ANYTHING,
+};
+
+
+BPF_CALL_3(bpf_probe_read_kernel_str, void *, dst, u32, size,
+	   const void *, unsafe_ptr)
+{
+	int ret;
+
+	/*
+	 * The strncpy_from_unsafe() call will likely not fill the entire
+	 * buffer, but that's okay in this circumstance as we're probing
+	 * arbitrary memory anyway similar to bpf_probe_read() and might
+	 * as well probe the stack=2E Thus, memory is explicitly cleared
+	 * only in error case, so that improper users ignoring return
+	 * code altogether don't copy garbage; otherwise length of string
+	 * is returned that can be used for bpf_perf_event_output() et al=2E
+	 */
+	ret =3D strncpy_from_unsafe(dst, unsafe_ptr, size);
+	if (unlikely(ret < 0))
+		memset(dst, 0, size);
+
+	return ret;
+}
+
+static const struct bpf_func_proto bpf_probe_read_kernel_str_proto =3D {
+	=2Efunc		=3D bpf_probe_read_kernel_str,
+	=2Egpl_only	=3D true,
+	=2Eret_type	=3D RET_INTEGER,
+	=2Earg1_type	=3D ARG_PTR_TO_RAW_STACK,
+	=2Earg2_type	=3D ARG_CONST_STACK_SIZE,
+	=2Earg3_type	=3D ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *tracing_func_proto(enum bpf_func_id f=
unc_id)
 {
 	switch (func_id) {
@@ -500,8 +584,14 @@ static const struct bpf_func_proto *tracing_func_prot=
o(enum bpf_func_id func_id)
 		return &bpf_probe_read_proto;
 	case BPF_FUNC_probe_read_user:
 		return &bpf_probe_read_user_proto;
+	case BPF_FUNC_probe_read_kernel:
+		return &bpf_probe_read_kernel_proto;
 	case BPF_FUNC_probe_read_str:
 		return &bpf_probe_read_str_proto;
+	case BPF_FUNC_probe_read_user_str:
+		return &bpf_probe_read_user_str_proto;
+	case BPF_FUNC_probe_read_kernel_str:
+		return &bpf_probe_read_kernel_proto;
 	case BPF_FUNC_ktime_get_ns:
 		return &bpf_ktime_get_ns_proto;
 	case BPF_FUNC_tail_call:
diff --git a/tools/include/uapi/linux/bpf=2Eh b/tools/include/uapi/linux/b=
pf=2Eh
index 155ce25c069d=2E=2E91d5691288a7 100644
--- a/tools/include/uapi/linux/bpf=2Eh
+++ b/tools/include/uapi/linux/bpf=2Eh
@@ -522,7 +522,44 @@ enum bpf_func_id {
    *     Return: 0 on success or negative error
    */
    BPF_FUNC_probe_read_user,
+
+   /**
+   * int bpf_probe_read_kernel(void *dst, int size, void *src)
+   *     Read a kernel pointer safely=2E
+   *     Return: 0 on success or negative error
+   */
+   BPF_FUNC_probe_read_kernel,
 =09
+	/**
+	 * int bpf_probe_read_str(void *dst, int size, const void *unsafe_ptr)
+	 *     Copy a NUL terminated string from user unsafe address=2E In case =
the string
+	 *     length is smaller than size, the target is not padded with furthe=
r NUL
+	 *     bytes=2E In case the string length is larger than size, just coun=
t-1
+	 *     bytes are copied and the last byte is set to NUL=2E
+	 *     @dst: destination address
+	 *     @size: maximum number of bytes to copy, including the trailing NU=
L
+	 *     @unsafe_ptr: unsafe address
+	 *     Return:
+	 *       > 0 length of the string including the trailing NUL on success
+	 *       < 0 error
+	 */
+	BPF_FUNC_probe_read_user_str,
+
+	/**
+	 * int bpf_probe_read_str(void *dst, int size, const void *unsafe_ptr)
+	 *     Copy a NUL terminated string from unsafe address=2E In case the s=
tring
+	 *     length is smaller than size, the target is not padded with furthe=
r NUL
+	 *     bytes=2E In case the string length is larger than size, just coun=
t-1
+	 *     bytes are copied and the last byte is set to NUL=2E
+	 *     @dst: destination address
+	 *     @size: maximum number of bytes to copy, including the trailing NU=
L
+	 *     @unsafe_ptr: unsafe address
+	 *     Return:
+	 *       > 0 length of the string including the trailing NUL on success
+	 *       < 0 error
+	 */
+	BPF_FUNC_probe_read_kernel_str,
+ =20
   __BPF_FUNC_MAX_ID,
 };

