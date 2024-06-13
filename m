Return-Path: <linux-kernel+bounces-213387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D004907479
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A945CB23B37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0391F144D36;
	Thu, 13 Jun 2024 13:59:49 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D8161
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287188; cv=none; b=GxVGwRbx77uNglHZnW3QbRgyWwCk5f1IxXxZWpn1zD9Lz2+lOw/+kHZtXhMU6QFhrUfk6wE7F1f1iaXvEGdHdX9MQ6QkoTT9kzDdnzJjNLomfrXcJ2XklTm1hisVMQTsLVumpm/YvEvjC9mA0+FXPXxyGY5XfZDaWYfp2fYj7ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287188; c=relaxed/simple;
	bh=4h39z8mTbeZssOV6m35RKQXBQGHOkyD7oF2ewqQLjDQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=or3ZWvH9LrZ3kuvcTYpDJpu+EG7+eYAzmdX1pIrcnEBwfyNpcgL/4PaBJpyf/gf0xD2T6mcKh2er6plUBU8RYINpNAOPbvmHNsZI3vnQuAZoZiiz4qLsWwTvHh75CY288hZw46e5VZVwkMIM0yAPvdY+QN1l36rlEe39sBKjJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ead7796052so103032639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718287186; x=1718891986;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLfTtj4qCEbAExVAe1+fvi5MjMSzfJBKr3arYkLtASg=;
        b=DRfJvcDHC0GuyyHF6SPNJJu4KPdXL68T98vJcnWO4Y61s1b+OeywXgWOrR9V4Z5aaL
         R3pQsXPVFcyY3ZtQsi/Rm7vvdmyctIoIcWhBCTkPMvlGvRFEjLoKtvuYlLmvG1EYz8HR
         dzVGBtXaS9i0YdNkvLlQ0G+B0V3TRUpunRN5AhRal2Wue4Ae2NQLGQxMlS2DmkC8T81A
         C6GIUHw5s8CBZPqLsus/usT9rqPqPxDq0T+G1GvFItoAzQ+qv+Ay75NnCaZGlaF7PeyX
         KcX7CBp8bfYeZXyaMqPQIINaWNFl5HGQorDnSr5myOrPTWw1ASkbe+cmyevioJ1zqGqy
         BSCA==
X-Gm-Message-State: AOJu0YzvlY5Dp8H02ZRt9tGf86UMMOXmBGDVI3RZt0C+8QSUjl5k54kR
	Bb1DzT7gd7KesXI8RcIW7/y+QxvMJBex24xSsVNqiFq4JMGHfzGvqhDUfE4chpUHgo/Uk7M1CcU
	cJum/fB+8XUeVHjwkpz4Uak9XaIjvxDvnqFo0hphW3fDatSs45v9egwM=
X-Google-Smtp-Source: AGHT+IED3rq7SEeRfqkUQTNC9J8zDkRkwJN0HSWtMdAvU/O7FnbdeIf7zO6uuycGXIQz69taOFhMSAku4dRKFVhMxbuBcXzFo/Z4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216c:b0:374:8aa0:23e4 with SMTP id
 e9e14a558f8ab-375cd109e31mr3770775ab.2.1718287186307; Thu, 13 Jun 2024
 06:59:46 -0700 (PDT)
Date: Thu, 13 Jun 2024 06:59:46 -0700
In-Reply-To: <0000000000008312ad06163b7225@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005cba90061ac5e91a@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem
From: syzbot <syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_loo=
kup_percpu_elem
Author: wojciech.gladysz@infogain.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux e=
478cf26c556e4ab572ab0ab2306c986901dcd61

--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -139,7 +139,7 @@ const struct bpf_func_proto bpf_map_lookup_percpu_elem_=
proto =3D {
        .pkt_access     =3D true,
        .ret_type       =3D RET_PTR_TO_MAP_VALUE_OR_NULL,
        .arg1_type      =3D ARG_CONST_MAP_PTR,
-       .arg2_type      =3D ARG_PTR_TO_MAP_KEY,
+       .arg2_type      =3D ARG_PTR_TO_MAP_KEY | MEM_RDONLY,
        .arg3_type      =3D ARG_ANYTHING,
 };

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7146,8 +7146,8 @@ static int check_stack_range_initialized(
                 * reads. However, if raw_mode is not set, we'll do extra
                 * checks below.
                 */
-               bounds_check_type =3D BPF_WRITE;
-               clobber =3D true;
+               clobber =3D !meta || meta->raw_mode;
+               bounds_check_type =3D clobber ? BPF_WRITE : BPF_READ;
        } else {
                bounds_check_type =3D BPF_READ;
        }
@@ -7230,8 +7230,7 @@ static int check_stack_range_initialized(
                stype =3D &state->stack[spi].slot_type[slot % BPF_REG_SIZE]=
;
                if (*stype =3D=3D STACK_MISC)
                        goto mark;
-               if ((*stype =3D=3D STACK_ZERO) ||
-                   (*stype =3D=3D STACK_INVALID && env->allow_uninit_stack=
)) {
+               if (*stype =3D=3D STACK_ZERO) {
                        if (clobber) {
                                /* helper can write anything into the stack=
 */
                                *stype =3D STACK_MISC;
@@ -8748,6 +8747,7 @@ static int check_func_arg(struct bpf_verifier_env *en=
v, u32 arg,
                meta->map_uid =3D reg->map_uid;
                break;
        case ARG_PTR_TO_MAP_KEY:
+               meta->raw_mode =3D !(arg_type & MEM_RDONLY); // read only f=
o const* pointer
                /* bpf_map_xxx(..., map_ptr, ..., key) call:
                 * check that [key, key + map->key_size) are within
                 * stack limits and initialized
@@ -8763,7 +8763,7 @@ static int check_func_arg(struct bpf_verifier_env *en=
v, u32 arg,
                }
                err =3D check_helper_mem_access(env, regno,
                                              meta->map_ptr->key_size, fals=
e,
-                                             NULL);
+                                             meta);
                break;
        case ARG_PTR_TO_MAP_VALUE:
                if (type_may_be_null(arg_type) && register_is_null(reg))
--
2.35.3
The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee and access to it by anyone else i=
s unauthorized. If you are not the intended recipient, any disclosure, copy=
ing, distribution or any action taken or omitted to be taken based on it, i=
s strictly prohibited and may be unlawful.

