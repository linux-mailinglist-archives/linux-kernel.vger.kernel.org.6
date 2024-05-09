Return-Path: <linux-kernel+bounces-174417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC158C0E6D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C13B1F213AA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619D61304A3;
	Thu,  9 May 2024 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSLMi02n"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A791322E
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251692; cv=none; b=qqablFbmCNIJ8jvImr2HZ3j+PbxVgGbyQV8tIw4N5bXfiAr2xHkex8O6q4KBt78gcMX5nussCjlIanMhEXjd8wXlGXEm79pF0wossGOIBHBh2hyxTp/stDdEyiygGVan5rQMrsewnAusfqEB+hlGaxg75PC/0mQop1XtzXs0vqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251692; c=relaxed/simple;
	bh=EAmmvUuXUCvQhVJyhOjnloUwsHV7hU6+Z0N6I4QkxKY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tSH26XW/Ij2XkUlP5M6k1CMakLZTFTlHfrdNDAs7Gkpfc9tOKYlxT5VxAssCcE2AuLs2A07mWisPD/ugooA02BKr+u1KGd+33duqmxxutH0loInZewZlxH8QvvysbGdUTEe+87EsCqBJqQgfh06j8iMMsssntYVmLnRTDG0X1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kSLMi02n; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59b49162aeso164308666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 03:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715251689; x=1715856489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qlZtZk75coxcr32t+mJEdsIgCn5e7In21AxtT9MXDc=;
        b=kSLMi02n7NAwcdlaLMJ0lWD8/Lr9jOYvdvnDDWEf81jzisupG21zC9AkK5LJaqkxN2
         JW2TI3pXpHNn4cjfssxNLaMT4cG5MBBaoTt1moRnFdLvyvfv1DlpbMLvlRI2TlR8Qw5d
         nBYzg7wKRoPcj2WHksU0Jlu0uoyeyNKSIjZ9zJ2W+HUA2nmp7sanhS90PPQ2Ytyr+0ht
         ug00jlRzAvhVDCnbnaQYo8LtvY2Rx+ellXzC4bA4JbI8Pj3aAeKBamB8bQsT68cxOvJX
         eiq1bPp9QMECb+BGC9TTnBNZW3JpVqLMUhs05KT49HwsCyhYlyLunA5uKsuGO+UVjKEm
         HFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715251689; x=1715856489;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qlZtZk75coxcr32t+mJEdsIgCn5e7In21AxtT9MXDc=;
        b=am4djIugee821bn0CQmAVukfjrQJ3P5LBgBAVNGGVRnPdPSHxsC6pt+DPUxPs5z2WG
         krW+QN1llpfrG2rtbu4G+4XbjFGzlTSFb2kgwqQpFVpUm6ckYKVFdpG8jM2ubeKIch5M
         YV7+YA2Mq3njwkXu2bepLUHonxd+qyCeiJWzxZ767SR9pfRDVI7530zp4WXdIAGR5srR
         gc7FrYcW7UDjGCO5R7Aszzf8gG0mhQ8Jcsmv5n2f5AT32UNKO6qsCpDmu512XXGkEeEv
         nlP+qEXPaI5A0AeHY/pnDfYGEFF4mR10/EuI3Ifkq44j+iAy46jpsjnJPBsTfVEw5umc
         lQxA==
X-Forwarded-Encrypted: i=1; AJvYcCU4WFEME00RiI5IJEy7di9+UCJQYlnrTpf1MfA2l90A8AiHKJ7c/C3ZkPbGRt492EAcoK9u/DyYsd0ouu4abJZ9OHoX4WRVcsR7/N69
X-Gm-Message-State: AOJu0YwaykY/FuVoHkjCEc1oMfD24Vleba7sVXIOSHBfBadsgHGFpSdB
	e8dvHR2wz+Bt+xZDtg+jePpF+nLUrqxZWTBPGk0nD3kRpqvcO/iutVE8ROUpu5s=
X-Google-Smtp-Source: AGHT+IGOSEuA2npGO9GewqwIXTPylXogor9RcnRiDhrr39n3ApUuc/Uzk7+5WHH+SNpvw9TtEXjwgA==
X-Received: by 2002:a50:d595:0:b0:572:a7ec:1a5f with SMTP id 4fb4d7f45d1cf-5731d9f1eb8mr3880773a12.24.1715251689505;
        Thu, 09 May 2024 03:48:09 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bfe2dd1sm572297a12.58.2024.05.09.03.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:48:09 -0700 (PDT)
Date: Thu, 9 May 2024 13:48:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] SUNRPC: prevent integer overflow in XDR_QUADLEN()
Message-ID: <bbf929d6-18d2-4b7e-a660-a19460af0a3c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <332d1149-988e-4ece-8aef-1e3fb8bf8af4@moroto.mountain>
X-Mailer: git-send-email haha only kidding

The "l + 3" addition can have integer overflow on 32 bit systems
when it is used in __xdr_inline_decode().  The overflowed value
would be zero and the check "nwords > xdr->nwords" would not work
as intended.

Fixes: ba8e452a4fe6 ("SUNRPC: Add a helper function xdr_inline_peek")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 include/linux/sunrpc/xdr.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 2f8dc47f1eb0..585059f2afca 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -14,6 +14,7 @@
 #include <linux/uio.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
+#include <linux/overflow.h>
 #include <linux/scatterlist.h>
 
 struct bio_vec;
@@ -29,7 +30,7 @@ struct rpc_rqst;
 /*
  * Buffer adjustment
  */
-#define XDR_QUADLEN(l)		(((l) + 3) >> 2)
+#define XDR_QUADLEN(l)		(size_add(l, 3) >> 2)
 
 /*
  * Generic opaque `network object.'
-- 
2.43.0


