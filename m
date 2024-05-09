Return-Path: <linux-kernel+bounces-174421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE228C0E79
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B64B1F22C87
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757E4148303;
	Thu,  9 May 2024 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGqMW6j+"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0183A1494C8
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251715; cv=none; b=NYYgQBLvI1lFgty1B87+aIygqaOuPph6TzYHfeMS59DNCnrt4+GP82NMtzhS1nwGqvZIvapxfH3jgNqf4xPa/pi5QnaLnXDHeaNWh5bI8YTHN3XY0XgtsPaeNkbU4dgl6y1rY0RQA1oiobYboNmaF0Yli0MgJFMezXlOF21Wrfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251715; c=relaxed/simple;
	bh=VctdIYRcYMl7yCi7G1Sb3DLUqDmPUVxcD0SKJgmAr9I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Pf/vpAy5APOan+uGX7OQ+QdxXN7XbbTvd3nkw3/O5yUFrXrMqfgCZT8LY5Du1wZKJiuXt7Y1Knxoy2ToD4ScZYQAQOY6QRIQSTH8Jrl7Z54Kd2n6DsNmsll717PbU3bPvZCUUmnic0Oxv4D1lULRZWOsD2kBvS+V8U9bExE7lFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bGqMW6j+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57342829409so467070a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 03:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715251712; x=1715856512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qD5o65PhiAwg7/piV822tTYM++wRvUpFA3lGrCXfalk=;
        b=bGqMW6j+jXVuenXgpVoj/r7W/X56zuyNfYC59cTEW0HJZj4lGTfPsXe/OAONJFGEAK
         iKq2VgfwIyHesubOBkMzd52cI4esnDHVKfGbI0ffenAY7civHWX24qWb3DsszQrzWbAH
         kaTJif5rSzm0IBtZXte39/nUjtS3tkzbK3VrUHrg/GHaYF//pvFiw4ynWOZ0dDgA06Zv
         a8JBOCuZAmXCOYZj2sI7xVcpRCdFo88LvNGU6wUz179MHNheYKJp1jybGo31mcY6XGBe
         +ZWgEkPK+KtfJHm1HEZXVlG/XPVyy0Ubn9Wc4EovauKzzFgKA9XVquo1z8L4epzdJvER
         /ALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715251712; x=1715856512;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qD5o65PhiAwg7/piV822tTYM++wRvUpFA3lGrCXfalk=;
        b=mhlTBpRqUBDtxR/WAP8+XIA05Ydj4LPGhtqREAKcqI3dB8MzbyAzO+3VP66Wg8MKR4
         Q5Qa4dzMbyf3ZFdc6izza3n5sxDYAbCZLxYNNpuiBKVwAIwkBEJwmwcvpZYqX6hNrG+P
         0EsrZNLYO+UPwsVljNdYvcKiIC5ypp8EOmInBuJYwYy4RbjKL0hpiFZMaDIXaoRS9AzL
         8c4byYwC9k9MMY1Wug0lzRLjQbRWBgLZuYLfskK1J/4hKhAvjIDSghAzAOORtOvg630B
         bfpUMGx56bcTEgCNSiO4vg5Bsd9hQxSY4hfnyKrjOoGUXGzoe14NY8Kzn3XsXzfCHrIx
         FrOg==
X-Forwarded-Encrypted: i=1; AJvYcCXTI1rzfMcw/3TrThDecVsXO2wVTERlIpcHPGmCc4/p2lUna2msSbvzE73gPwA2RiD8zvgVISVMKB793+SiooRAxH/2kPKB0IQf8pbB
X-Gm-Message-State: AOJu0YwjCacjGyCQFBPMI77h0JccgfzCfG+739L9pyXxw44a8Z61YahT
	UntqLHfN+IaexBG9z2lgNDIuCfzmeNETl00SQ91xGXdwY83uRO8/0gk30ECxYXbHOm/JHJUpfDl
	e
X-Google-Smtp-Source: AGHT+IGqDgXNiTu5L0LP3FiH0Qhn/LQ5EXyCt8R1SOSC3IM0XZ62ypkMejfMBZXujtcgLGfguVX/ig==
X-Received: by 2002:a50:d696:0:b0:572:a6fe:f7e7 with SMTP id 4fb4d7f45d1cf-5733294be26mr1553752a12.20.1715251712324;
        Thu, 09 May 2024 03:48:32 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2c7d79sm570649a12.59.2024.05.09.03.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:48:32 -0700 (PDT)
Date: Thu, 9 May 2024 13:48:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] NFSD: harden svcxdr_dupstr() and svcxdr_tmpalloc()
 against integer overflows
Message-ID: <babdb32b-3f3a-4e46-8cbb-26f0ca49cc61@moroto.mountain>
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

These lengths come from xdr_stream_decode_u32() and so we should be a
bit careful with them.  Use size_add() and struct_size() to avoid
integer overflows.  Saving size_add()/struct_size() results to a u32 is
unsafe because it truncates away the high bits.

Also generally storing sizes in longs is safer.  Most systems these days
use 64 bit CPUs.  It's harder for an addition to overflow 64 bits than
it is to overflow 32 bits.  Also functions like vmalloc() can
successfully allocate UINT_MAX bytes, but nothing can allocate ULONG_MAX
bytes.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I think my patch 1 fixes any real issues.  It's hard to assign a Fixes
tag to this.

 fs/nfsd/nfs4xdr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c7bfd2180e3f..42b41d55d4ed 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -118,11 +118,11 @@ static int zero_clientid(clientid_t *clid)
  * operation described in @argp finishes.
  */
 static void *
-svcxdr_tmpalloc(struct nfsd4_compoundargs *argp, u32 len)
+svcxdr_tmpalloc(struct nfsd4_compoundargs *argp, size_t len)
 {
 	struct svcxdr_tmpbuf *tb;
 
-	tb = kmalloc(sizeof(*tb) + len, GFP_KERNEL);
+	tb = kmalloc(struct_size(tb, buf, len), GFP_KERNEL);
 	if (!tb)
 		return NULL;
 	tb->next = argp->to_free;
@@ -138,9 +138,9 @@ svcxdr_tmpalloc(struct nfsd4_compoundargs *argp, u32 len)
  * buffer might end on a page boundary.
  */
 static char *
-svcxdr_dupstr(struct nfsd4_compoundargs *argp, void *buf, u32 len)
+svcxdr_dupstr(struct nfsd4_compoundargs *argp, void *buf, size_t len)
 {
-	char *p = svcxdr_tmpalloc(argp, len + 1);
+	char *p = svcxdr_tmpalloc(argp, size_add(len, 1));
 
 	if (!p)
 		return NULL;
@@ -150,7 +150,7 @@ svcxdr_dupstr(struct nfsd4_compoundargs *argp, void *buf, u32 len)
 }
 
 static void *
-svcxdr_savemem(struct nfsd4_compoundargs *argp, __be32 *p, u32 len)
+svcxdr_savemem(struct nfsd4_compoundargs *argp, __be32 *p, size_t len)
 {
 	__be32 *tmp;
 
@@ -2146,7 +2146,7 @@ nfsd4_decode_clone(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
  */
 static __be32
 nfsd4_vbuf_from_vector(struct nfsd4_compoundargs *argp, struct xdr_buf *xdr,
-		       char **bufp, u32 buflen)
+		       char **bufp, size_t buflen)
 {
 	struct page **pages = xdr->pages;
 	struct kvec *head = xdr->head;
-- 
2.43.0


